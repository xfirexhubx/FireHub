-- BloxFruits PvP Script with Enhanced GUI Control

local Player = game.Players.LocalPlayer
local Character = Player.Character

if not Character then return end -- Wait for character if needed

local ToolEquipped = false
local TargetingEnemy = false
local CurrentTarget = nil

-- HUD Variables
local hudState = "normal" -- normal/minimized/closed
local RapidFireRate = 0.25
local RapidAttackTimer = nil

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

-- Main execution loop
while true do
    if TargetingEnemy and CurrentTarget then 
        RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(RapidFireRate)
        
        local tool = script.Parent
        
        if not tool.Animation1 or tool.Animation1.AnimationId == "" then 
            tool:Activate()
        end
        
        wait(0.2 + math.random() * 0.5) -- Natural timing variation
    else
        TargetingEnemy, _ = FindClosestEnemy()
        
        if TargetingEnemy and CurrentTarget then 
            AimAtTarget() 
            
            local tool = script.Parent
            
            -- Execute damage calculation here
                
            wait(0.2 + math.random() * 0.5) -- Natural timing variation
        end
    end
    
    Attack() -- Rapid fire handling
end

-- GUI Setup and initialization
local hud = CreateHUD()

wait(3) -- Delay start to avoid detection

SetHUDVisible(true)
