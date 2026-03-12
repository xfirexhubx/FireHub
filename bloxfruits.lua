-- BloxFruits PvP Script with Enhanced GUI Control

local Player = game.Players.LocalPlayer
local Character = Player.Character

if not Character then return end -- Wait for character if needed

local ToolEquipped = false
local TargetingEnemy = false
local CurrentTarget = nil

-- Create enhanced HUD controls
function CreateHUD()
    local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    -- Background box (lime)
    local background = Instance.new("Frame", screenGui)
    background.Name = "MainPanel"
    background.BackgroundTransparency = 0.75
    background.BackgroundColor3 = Color3.fromRGB(124, 252, 0) -- Lime green
    
    -- Title label with toggle button
    local titleLabel = Instance.new("TextButton", background)
    titleLabel.Position = UDim2.new(0, -8, 0.975, -60)
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(255, 15, 15) -- Red
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.FontSize = Enum.FontSize.Size36
    
    -- Close button (red X)
    local closeButton = Instance.new("TextButton", background)
    closeButton.Position = UDim2.new(1, -30, 0.975, -60) 
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Text = "X"
    closeButton.FontSize = Enum.FontSize.Size24
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 15, 15) -- Red
    
    -- Minimize button (-)
    local minimizeButton = Instance.new("TextButton", background)
    minimizeButton.Position = UDim2.new(0.95, -35, 0.975, -60)
    minimizeButton.Size = UDim2.new(0, 20, 0, 20)
    minimizeButton.Text = "-"
    minimizeButton.FontSize = Enum.FontSize.Size24
    minimizeButton.BackgroundColor3 = Color3.fromRGB(187, 187, 187) -- Gray
    
    return {
        gui = screenGui,
        background = background,
        titleLabel = titleLabel,
        closeButton = closeButton,
        minimizeButton = minimizeButton
    }
end

-- GUI State Management functions
local hudState = "normal" -- normal/minimized/closed
function SetHUDVisible(visible)
    if visible then 
        hud.background.Visible = true
        
        if hudState == "minimized" then
            wait(0.1) -- Animation delay for UI smoothness
            hud.background.Size = UDim2.new(1, -20, 0, 60)
            
            hud.titleLabel.Text = "FireHub"
            hud.titleLabel.BackgroundColor3 = Color3.fromRGB(255, 15, 15) -- Red
            
            hudState = "normal"
        end
    else 
        hud.background.Visible = false
        
        if hudState == "normal" then
            wait(0.1) -- Animation delay for UI smoothness
            hud.background.Size = UDim2.new(1, -20, 0, 30)
            
            hud.titleLabel.Text = ""
            hud.titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0) -- Clear
            
            hudState = "minimized"
        end
    end
    
    return visible
end

-- Add event listeners to GUI controls
hud.closeButton.MouseButton1Click:Connect(function()
    SetHUDVisible(false)
    
    local tool = script.Parent
    if tool and ToolEquipped then
        
        wait(0.2) -- Allow attack timing adjustments
    
        if TargetingEnemy and CurrentTarget then 
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait()
            
            local tool = script.Parent
            
            if not tool.Animation1 or tool.Animation1.AnimationId == "" then 
                tool:Activate()
            end
            
            wait(RapidFireRate) -- Natural timing variation
        else
            TargetingEnemy, _ = FindClosestEnemy()
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(rapidFireRate)
            
            if TargetingEnemy and CurrentTarget then 
                AimAtTarget() 
            
                local tool = script.Parent
                
                -- Execute damage calculation here
                
                wait(0.2 + math.random() * rapidFireRate) -- Natural timing variation
            end
        end
    end
    
    print("[+] UI Closed")
end)

hud.minimizeButton.MouseButton1Click:Connect(function()
    SetHUDVisible(not hud.background.Visible)
    
    local tool = script.Parent
    if ToolEquipped then 
        AimAtTarget() -- Update positioning on toggle
        
        wait(0.2) -- Allow attack timing adjustments
    
        if TargetingEnemy and CurrentTarget then 
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait()
            
            local tool = script.Parent
            
            if not tool.Animation1 or tool.Animation1.AnimationId == "" then 
                tool:Activate()
            end
            
            wait(RapidFireRate) -- Natural timing variation
        else
            TargetingEnemy, _ = FindClosestEnemy()
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(rapidFireRate)
            
            if TargetingEnemy and CurrentTarget then 
                AimAtTarget() 
            
                local tool = script.Parent
                
                -- Execute damage calculation here
                
                wait(0.2 + math.random() * rapidFireRate) -- Natural timing variation
            end
        end
    end
    
    print(hud.background.Visible and "[+] UI Minimized" or "[-] UI Expanded")
end)

hud.titleLabel.MouseButton1Click:Connect(function()
    SetHUDVisible(not hud.background.Visible)
    
    local tool = script.Parent
    
    if TargetingEnemy then
        
        wait(0.2) -- Allow attack timing adjustments
    
        if CurrentTarget then 
            AimAtTarget() 
            
            local tool = script.Parent
            
            if not tool.Animation1 or tool.Animation1.AnimationId == "" then 
                tool:Activate()
            end
            
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(RapidFireRate)
            
            wait(0.2 + math.random() * rapidFireRate) -- Natural timing variation
        end
        
    elseif ToolEquipped then
        AimAtTarget() -- Update positioning on toggle
        
        TargetingEnemy, _ = FindClosestEnemy()
        
        if TargetingEnemy and CurrentTarget then 
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(RapidFireRate)
            
            local tool = script.Parent
            
            -- Execute damage calculation here
                
            wait(0.2 + math.random() * rapidFireRate) -- Natural timing variation
        end
        
    else
        AimAtTarget()
        
        TargetingEnemy, _ = FindClosestEnemy()
        if TargetingEnemy then 
            RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(RapidFireRate)
            
            local tool = script.Parent
            
            -- Execute damage calculation here
                
            wait(0.2 + math.random() * rapidFireRate) -- Natural timing variation
        end
        
    end
    
    print(hud.background.Visible and "[+] UI Minimized" or "[-] UI Expanded")
end)

-- Add interactive elements to HUD
local function CreateToggleSlider()
    
    if hud.toggleButton then return end
    
    local toggleFrame = Instance.new("Frame", hud.background)
    toggleFrame.Position = UDim2.new(0, 5, -4, 16)
    toggleFrame.Size = UDim2.new(0, 28, 0, 28)
    
    local toggleButton = Instance.new("TextButton", toggleFrame)
    toggleButton.BackgroundColor3 = Color3.fromRGB(76, 169, 54) -- Green
    toggleButton.Position = UDim2.new(0.125, -5, 0.125, -5)
    toggleButton.Size = UDim2.new(0, 20, 0, 20)
    toggleButton.Text = ""
    
    hud.toggleButton = {
        button = toggleButton,
        frame = toggleFrame
    }
end

-- Setup draggable GUI elements with bounds checking
local function MakeMovable(guiElement)
    local dragging = false
    
    guiElement.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            
            -- Capture cursor position offset to GUI element
            local startPosX = guiElement.AbsolutePosition.X - input.Position.X
            local startPosY = guiElement.AbsolutePosition.Y - input.Position.Y
            
            -- Set constraint bounds based on screen size
            local maxX = math.min(
                game.Workspace.CurrentCamera.ViewportSize.X,
                600 + 25 -- right edge of screen minus offset from center
            )
            
            local maxY = math.min(
                game.Workspace.CurrentCamera.ViewportSize.Y, 
                700 - 40 -- bottom edge of screen plus offset
            )
            
            while dragging do
                
                wait(0.02)
                
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    
                    local
