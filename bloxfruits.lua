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

-- Aim Features Variables
local AimBotToggle = true
local AimSkillLevel = 1
local CamLockActive = false
local EspActivated = false
local AutoV4Enabled = false
local AutoV3Enabled = false

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
    
    return {
        gui = screenGui,
        background = background,
        titleLabel = titleLabel,
        closeButton = closeButton
    }
end

-- Aim Bot Implementation (Basic)
function AimBot()
    if AimBotToggle then
        local targetPosition = CurrentTarget.HumanoidRootPart.Position
        
        game:GetService("RunService").Heartbeat:Connect(function() 
            Player.Character.Head.CFrame = CFrame.new(Player.Character.Head.Position, Vector3.new(targetPosition.X, Player.Character.Head.Position.Y - 0.25, targetPosition.Z))
            
            if TargetingEnemy then
                AimAtTarget()
                
                -- Apply aim skill logic here
                
                wait(0.1)
            end
            
        end)
    end
end

-- Camera Lock Implementation (Basic)
function CamLock()
    if CamLockActive then
        game.Workspace.CurrentCamera.CameraSubject = CurrentTarget.HumanoidRootPart
        
        -- Add camera smoothing if needed
        
        return true
    else
        game.Workspace.CurrentCamera.CameraSubject = Character.Head
        
        return false
    end
end

-- ESP Implementation (Basic)
function ToggleESP()
    if EspActivated then
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do 
            local cFrame = Instance.new("BoxHandleAdornment",v)
            cFrame.Name="AimBotESP"
            cFrame.ZIndex=1000
            
            -- Calculate ESP size based on distance and aim skill level
        end
        
        return true
    else
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do 
            if v:FindFirstChild("AimBotESP") then
                v.AimBotESP:Destroy()
            end
        end
        
        return false
    end
end

-- Auto Kill Implementation (Basic)
function AutoKillV4()
    if AutoV4Enabled then
        -- Implement logic for killing v4 when spotted
        wait(0.1)
    end
    
    if AutoV3Enabled then
        -- Implement logic for killing v3 when spotted
        
        wait(0.2) -- Natural timing variation
    end
end

-- GUI State Management functions
function SetHUDVisible(visible)
    hud.background.Visible = visible
    
    return visible
end

-- Main execution loop
while true do
    if TargetingEnemy and CurrentTarget then 
        RapidAttackTimer = game:GetService("RunService").Heartbeat:wait(RapidFireRate)
        
        local tool = script.Parent
        
        AimBot()
        
        CamLock()
        
        ToggleESP()
        
        -- Execute damage calculation here
                
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
    
    AutoKillV4()
end

-- GUI Setup and initialization
local hud = CreateHUD()

wait(3) -- Delay start to avoid detection

SetHUDVisible(true)
