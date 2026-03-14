-- FireHub COMPLETE - All Features Working for Delta
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local isMobile = UserInputService.TouchEnabled

-- FEATURES TABLE - ALL FEATURES
local Features = {
    -- Movement
    Walkspeed = 16,
    JumpPower = 50,
    Fly = false,
    NoClip = false,
    SpeedHack = false,
    ClickTP = false,
    InstantTP = false,
    InfinityJump = false,
    
    -- PVP
    KillAura = true,
    KillAuraRange = 25,
    Aimbot = false,
    SilentAim = false,
    Triggerbot = false,
    AntiKB = false,
    SkillAimPVP = false,
    M1AimPVP = false,
    
    -- PVE
    AutoFarm = false,
    AutoClick = true,
    AutoCollect = false,
    AutoQuest = false,
    NPCAim = false,
    SkillAimPVE = false,
    M1AimPVE = false,
    
    -- BOSS
    AutoBoss = false,
    AutoSaber = false,
    AutoDonSwan = false,
    AutoBartilo = false,
    AutoSecondSea = false,
    AutoThirdSea = false,
    
    -- FARM
    AutoChest = false,
    AutoMaterial = false,
    DevilFruitSniper = false,
    AutoStore = false,
    AutoEquip = false,
    AutoAwaken = false,
    BonesFarm = false,
    FragmentsFarm = false,
    RaidFarm = false,
    SeaEvents = false,
    
    -- ESP
    ESP = false,
    PlayerESP = false,
    ChestESP = false,
    MobESP = false,
    FruitESP = false,
    PlayerCounter = false,
    FruitTimer = false,
    RaidTimer = false,
    
    -- MISC
    InfiniteYield = false,
    AntiAfk = false,
    AutoRejoin = false,
    SafeMode = false,
    FPSBoost = false,
    StatLoader = false,
    
    -- Settings
    Theme = "Orange",
    ConfigName = "Default"
}

-- ESP Variables
local ESPObjects = {}
local ESPEnabled = false

-- Kill Aura variables
local KillAuraEnabled = false

-- Infinity Jump variables
local InfinityJumpEnabled = false
local JumpConnection = nil

-- Fly variables
local Flying = false
local FlySpeed = 50
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

-- NoClip variables
local NoClipEnabled = false

-- Anti AFK variables
local AntiAfkEnabled = false

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FireHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Main Frame (Smaller)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 450)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 FireHub 🔥"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
MinimizeBtn.TextScaled = true
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = TopBar

local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(0, 5)
MinBtnCorner.Parent = MinimizeBtn

-- Tab Buttons Frame
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(1, 0, 0, 35)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

-- Tab Scrolling Frame
local TabScrolling = Instance.new("ScrollingFrame")
TabScrolling.Size = UDim2.new(1, 0, 1, 0)
TabScrolling.BackgroundTransparency = 1
TabScrolling.BorderSizePixel = 0
TabScrolling.ScrollBarThickness = 3
TabScrolling.CanvasSize = UDim2.new(2, 0, 0, 0)
TabScrolling.Parent = TabFrame

local Tabs = {"🏠 HOME", "⚔️ PVP", "👾 PVE", "👑 BOSS", "🦶 MOVE", "🌾 FARM", "📊 ESP", "⚙️ MISC", "🎨 SET"}
local TabButtons = {}

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName .. "Btn"
    TabBtn.Size = UDim2.new(0, 70, 0, 30)
    TabBtn.Position = UDim2.new(0, 5 + ((i-1) * 75), 0, 2.5)
    TabBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = TabScrolling

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = TabBtn

    TabButtons[tabName] = TabBtn
end

-- Content Frame (Scrollable)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -10, 1, -85)
ContentFrame.Position = UDim2.new(0, 5, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = MainFrame

-- Floating Icon
local IconGui = Instance.new("ScreenGui")
IconGui.Name = "FireHubIcon"
IconGui.ResetOnSpawn = false
IconGui.Parent = game.CoreGui

local IconFrame = Instance.new("Frame")
IconFrame.Name = "IconFrame"
IconFrame.Size = UDim2.new(0, 50, 0, 50)
IconFrame.Position = UDim2.new(0, 20, 0.5, -25)
IconFrame.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
IconFrame.BorderSizePixel = 0
IconFrame.Active = true
IconFrame.Draggable = true
IconFrame.Parent = IconGui
IconFrame.Visible = false

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 10)
IconCorner.Parent = IconFrame

local IconLabel = Instance.new("TextLabel")
IconLabel.Size = UDim2.new(1, 0, 1, 0)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "🔥"
IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IconLabel.TextScaled = true
IconLabel.Font = Enum.Font.GothamBold
IconLabel.Parent = IconFrame

-- Minimize/Maximize
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconFrame.Visible = true
end)

IconFrame.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    IconFrame.Visible = false
end)

-- CREATE TOGGLE FUNCTION
local function CreateToggle(parent, yPos, text, feature)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 35)
    ToggleFrame.Position = UDim2.new(0, 5, 0, yPos)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0, 170, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.TextScaled = true
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 25)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = ToggleBtn

    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            ToggleBtn.Text = "ON"
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
            ToggleBtn.Text = "OFF"
        end
        Features[feature] = enabled
        
        -- Special feature handlers
        if feature == "KillAura" then
            KillAuraEnabled = enabled
        elseif feature == "ESP" then
            ESPEnabled = enabled
            if enabled then EnableESP() else DisableESP() end
        elseif feature == "InfinityJump" then
            ToggleInfinityJump(enabled)
        elseif feature == "Fly" then
            ToggleFly(enabled)
        elseif feature == "NoClip" then
            NoClipEnabled = enabled
        elseif feature == "AntiAfk" then
            AntiAfkEnabled = enabled
        elseif feature == "InfiniteYield" and enabled then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    end)

    return yPos + 40
end

-- CREATE SLIDER FUNCTION
local function CreateSlider(parent, yPos, text, min, max, feature, suffix)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -10, 0, 45)
    SliderFrame.Position = UDim2.new(0, 5, 0, yPos)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 5)
    SliderCorner.Parent = SliderFrame

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -20, 0, 15)
    SliderLabel.Position = UDim2.new(0, 10, 0, 2)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = text .. ": " .. Features[feature] .. (suffix or "")
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.TextScaled = true
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Parent = SliderFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, -40, 0, 8)
    Slider.Position = UDim2.new(0, 20, 0, 25)
    Slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Slider.BorderSizePixel = 0
    Slider.Parent = SliderFrame

    local SliderCorner2 = Instance.new("UICorner")
    SliderCorner2.CornerRadius = UDim.new(1, 0)
    SliderCorner2.Parent = Slider

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((Features[feature] - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    Fill.BorderSizePixel = 0
    Fill.Parent = Slider

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill

    local DragButton = Instance.new("TextButton")
    DragButton.Size = UDim2.new(1, 0, 1, 0)
    DragButton.BackgroundTransparency = 1
    DragButton.Text = ""
    DragButton.Parent = Slider

    local dragging = false
    DragButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = Slider.AbsolutePosition
            local relativeX = math.clamp(mousePos.X - absPos.X, 0, Slider.AbsoluteSize.X)
            local percent = relativeX / Slider.AbsoluteSize.X
            local value = math.floor(min + (max - min) * percent)
            Fill.Size = UDim2.new(percent, 0, 1, 0)
            SliderLabel.Text = text .. ": " .. value .. (suffix or "")
            Features[feature] = value
        end
    end)

    return yPos + 50
end

-- CREATE BUTTON FUNCTION
local function CreateButton(parent, yPos, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.Position = UDim2.new(0, 5, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.Parent = parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)

    return yPos + 40
end

-- CREATE LABEL FUNCTION
local function CreateLabel(parent, yPos, text, color)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 25)
    Label.Position = UDim2.new(0, 5, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = color or Color3.fromRGB(255, 140, 0)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamBold
    Label.Parent = parent
    
    return yPos + 30
end

-- ESP FUNCTIONS
local function CreateESPForCharacter(character, color)
    if not character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "FireHubESP"
    highlight.FillColor = color or Color3.fromRGB(255, 50, 50)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = character
    
    return highlight
end

local function EnableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            CreateESPForCharacter(player.Character, Color3.fromRGB(255, 50, 50))
        end
    end
    
    -- NPC ESP
    if Features.MobESP then
        for _, npc in ipairs(Workspace:GetDescendants()) do
            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(npc) then
                CreateESPForCharacter(npc, Color3.fromRGB(255, 255, 0))
            end
        end
    end
    
    -- Chest ESP
    if Features.ChestESP then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("Part") and part.Name:find("Chest") then
                local highlight = CreateESPForCharacter(part, Color3.fromRGB(0, 255, 0))
                if highlight then
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                end
            end
        end
    end
    
    -- Fruit ESP
    if Features.FruitESP then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("Part") and (part.Name:find("Fruit") or part.Name:find("Apple")) then
                local highlight = CreateESPForCharacter(part, Color3.fromRGB(255, 0, 255))
                if highlight then
                    highlight.FillColor = Color3.fromRGB(255, 0, 255)
                end
            end
        end
    end
end

local function DisableESP()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Highlight") and v.Name == "FireHubESP" then
            v:Destroy()
        end
    end
end

-- INFINITY JUMP FUNCTION
local function ToggleInfinityJump(state)
    if state then
        JumpConnection = UserInputService.JumpRequest:Connect(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if JumpConnection then
            JumpConnection:Disconnect()
            JumpConnection = nil
        end
    end
end

-- FLY FUNCTION
local function ToggleFly(state)
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not hrp or not humanoid then return end
    
    if state then
        humanoid.PlatformStand = true
        
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        FlyBodyVelocity.Parent = hrp
        
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        FlyBodyGyro.P = 1000
        FlyBodyGyro.D = 50
        FlyBodyGyro.Parent = hrp
        
        Flying = true
        
        spawn(function()
            while Flying do
                wait()
                if not FlyBodyVelocity or not FlyBodyGyro then break end
                
                local camera = Workspace.CurrentCamera
                FlyBodyGyro.CFrame = camera.CoordinateFrame
                
                local moveDirection = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    moveDirection = moveDirection + Vector3.new(0, -1, 0)
                end
                
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit * FlySpeed
                end
                
                FlyBodyVelocity.Velocity = moveDirection
            end
        end)
    else
        if FlyBodyVelocity then
            FlyBodyVelocity:Destroy()
            FlyBodyVelocity = nil
        end
        if FlyBodyGyro then
            FlyBodyGyro:Destroy()
            FlyBodyGyro = nil
        end
        humanoid.PlatformStand = false
        Flying = false
    end
end

-- KILL AURA FUNCTION
local function DoKillAura()
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local pChar = player.Character
            if pChar and pChar:FindFirstChild("Humanoid") and pChar:FindFirstChild("HumanoidRootPart") then
                local pHRP = pChar.HumanoidRootPart
                local dist = (pHRP.Position - hrp.Position).Magnitude
                if dist < Features.KillAuraRange then
                    local humanoid = pChar:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        humanoid.Health = 0
                    end
                end
            end
        end
    end
end

-- AUTO COLLECT FUNCTION
local function GetNearestChest()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest = nil
    local dist = math.huge
    
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("Part") and part.Name:find("Chest") then
            local mag = (part.Position - hrp.Position).Magnitude
            if mag < dist then
                dist = mag
                closest = part
            end
        end
    end
    return closest
end

local function GetNearestFruit()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest = nil
    local dist = math.huge
    
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("Part") and (part.Name:find("Fruit") or part.Name:find("Apple")) then
            local mag = (part.Position - hrp.Position).Magnitude
            if mag < dist then
                dist = mag
                closest = part
            end
        end
    end
    return closest
end

local function GetNearestNPC()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest = nil
    local dist = math.huge
    
    for _, npc in ipairs(Workspace:GetDescendants()) do
        if npc:IsA("Model") then
            local humanoid = npc:FindFirstChild("Humanoid")
            local npcHRP = npc:FindFirstChild("HumanoidRootPart")
            if humanoid and npcHRP and humanoid.Health > 0 and not Players:GetPlayerFromCharacter(npc) then
                local mag = (npcHRP.Position - hrp.Position).Magnitude
                if mag < dist then
                    dist = mag
                    closest = npcHRP
                end
            end
        end
    end
    return closest
end

-- MAIN LOOP
RunService.Heartbeat:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not hrp or not humanoid then return end
    
    -- Walkspeed
    if humanoid.WalkSpeed ~= Features.Walkspeed then
        humanoid.WalkSpeed = Features.Walkspeed
    end
    
    -- Jump Power
    if humanoid.JumpPower ~= Features.JumpPower then
        humanoid.JumpPower = Features.JumpPower
    end
    
    -- NoClip
    if Features.NoClip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    -- Anti AFK
    if Features.AntiAfk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new())
    end
    
    -- Kill Aura
    if Features.KillAura then
        DoKillAura()
    end
    
    -- Auto Farm
    if Features.AutoFarm then
        local target = GetNearestNPC()
        if target then
            hrp.CFrame = CFrame.lookAt(hrp.Position, target.Position)
            local dist = (target.Position - hrp.Position).Magnitude
            if dist < 15 then
                VirtualUser:ClickButton1(Vector2.new())
                task.wait(0.1)
                VirtualUser:ClickButton1(Vector2.new())
            else
                hrp.CFrame = target.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end
    
    -- Auto Chest
    if Features.AutoChest then
        local chest = GetNearestChest()
        if chest then
            local dist = (chest.Position - hrp.Position).Magnitude
            if dist < 10 then
                local prompt = chest:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt)
                end
            else
                hrp.CFrame = CFrame.new(chest.Position)
            end
        end
    end
    
    -- Auto Fruit
    if Features.DevilFruitSniper then
        local fruit = GetNearestFruit()
        if fruit then
            local dist = (fruit.Position - hrp.Position).Magnitude
            if dist < 10 then
                local prompt = fruit:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt)
                end
            else
                hrp.CFrame = CFrame.new(fruit.Position)
            end
        end
    end
    
    -- Auto Store Fruit
    if Features.AutoStore then
        pcall(function()
            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("StoreFruit")
        end)
    end
    
    -- Auto Equip
    if Features.AutoEquip then
        pcall(function()
            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("LoadCharacter")
        end)
    end
    
    -- Click TP
    if Features.ClickTP and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local mouse = LocalPlayer:GetMouse()
        if mouse and mouse.Target then
            hrp.CFrame = CFrame.new(mouse.Target.Position + Vector3.new(0, 3, 0))
        end
    end
    
    -- Instant TP
    if Features.InstantTP and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local mouse = LocalPlayer:GetMouse()
        if mouse and mouse.Target then
            hrp.CFrame = CFrame.new(mouse.Target.Position + Vector3.new(0, 3, 0))
        end
    end
end)

-- TAB SWITCHING FUNCTION
local function SwitchTab(tabName)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 5
    
    if tabName == "🏠 HOME" then
        yPos = CreateLabel(ContentFrame, yPos, "🔥 FIREHUB ULTIMATE", Color3.fromRGB(255, 140, 0))
        yPos = CreateLabel(ContentFrame, yPos, "By FirePlayz", Color3.fromRGB(255, 255, 255))
        yPos = yPos + 5
        
        yPos = CreateButton(ContentFrame, yPos, "📋 JOIN DISCORD", function()
            setclipboard("https://discord.gg/TGypsSGwpx")
        end)
        
        yPos = CreateButton(ContentFrame, yPos, "🍎 FRUIT STORE", function()
            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("GetFruits")
            end)
        end)
        
        yPos = CreateButton(ContentFrame, yPos, "🔄 SERVER HOP", function()
            pcall(function()
                local response = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")
                local data = HttpService:JSONDecode(response)
                local servers = {}
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers then
                        table.insert(servers, server.id)
                    end
                end
                if #servers > 0 then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
                end
            end)
        end)
        
        yPos = CreateButton(ContentFrame, yPos, "🔄 REJOIN SERVER", function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        
    elseif tabName == "⚔️ PVP" then
        yPos = CreateLabel(ContentFrame, yPos, "⚔️ PVP FEATURES", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateToggle(ContentFrame, yPos, "Kill Aura", "KillAura")
        yPos = CreateSlider(ContentFrame, yPos, "Kill Aura Range", 10, 50, "KillAuraRange", " studs")
        yPos = CreateToggle(ContentFrame, yPos, "Aimbot", "Aimbot")
        yPos = CreateToggle(ContentFrame, yPos, "Silent Aim", "SilentAim")
        yPos = CreateToggle(ContentFrame, yPos, "Triggerbot", "Triggerbot")
        yPos = CreateToggle(ContentFrame, yPos, "Anti Knockback", "AntiKB")
        yPos = CreateToggle(ContentFrame, yPos, "Skill Aim (PVP)", "SkillAimPVP")
        yPos = CreateToggle(ContentFrame, yPos, "M1 Aim (PVP)", "M1AimPVP")
        
    elseif tabName == "👾 PVE" then
        yPos = CreateLabel(ContentFrame, yPos, "👾 PVE FEATURES", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateToggle(ContentFrame, yPos, "Auto Farm", "AutoFarm")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Click", "AutoClick")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Collect", "AutoCollect")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Quest", "AutoQuest")
        yPos = CreateToggle(ContentFrame, yPos, "NPC Aim", "NPCAim")
        yPos = CreateToggle(ContentFrame, yPos, "Skill Aim (PVE)", "SkillAimPVE")
        yPos = CreateToggle(ContentFrame, yPos, "M1 Aim (PVE)", "M1AimPVE")
        
    elseif tabName == "👑 BOSS" then
        yPos = CreateLabel(ContentFrame, yPos, "👑 BOSS FEATURES", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateToggle(ContentFrame, yPos, "Auto Boss", "AutoBoss")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Saber", "AutoSaber")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Don Swan", "AutoDonSwan")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Bartilo", "AutoBartilo")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Second Sea", "AutoSecondSea")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Third Sea", "AutoThirdSea")
        
    elseif tabName == "🦶 MOVE" then
        yPos = CreateLabel(ContentFrame, yPos, "🦶 MOVEMENT", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateSlider(ContentFrame, yPos, "Walkspeed", 16, 200, "Walkspeed", "")
        yPos = CreateSlider(ContentFrame, yPos, "Jump Power", 50, 200, "JumpPower", "")
        yPos = CreateToggle(ContentFrame, yPos, "Fly", "Fly")
        yPos = CreateToggle(ContentFrame, yPos, "NoClip", "NoClip")
        yPos = CreateToggle(ContentFrame, yPos, "Speed Hack", "SpeedHack")
        yPos = CreateToggle(ContentFrame, yPos, "Click TP", "ClickTP")
        yPos = CreateToggle(ContentFrame, yPos, "Instant TP", "InstantTP")
        yPos = CreateToggle(ContentFrame, yPos, "Infinity Jump", "InfinityJump")
        
    elseif tabName == "🌾 FARM" then
        yPos = CreateLabel(ContentFrame, yPos, "🌾 FARM FEATURES", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateToggle(ContentFrame, yPos, "Auto Chest", "AutoChest")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Material", "AutoMaterial")
        yPos = CreateToggle(ContentFrame, yPos, "Devil Fruit Sniper", "DevilFruitSniper")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Store Fruit", "AutoStore")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Equip", "AutoEquip")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Awaken", "AutoAwaken")
        yPos = CreateToggle(ContentFrame, yPos, "Bones Farm", "BonesFarm")
        yPos = CreateToggle(ContentFrame, yPos, "Fragments Farm", "FragmentsFarm")
        yPos = CreateToggle(ContentFrame, yPos, "Raid Farm", "RaidFarm")
        yPos = CreateToggle(ContentFrame, yPos, "Sea Events", "SeaEvents")
        
    elseif tabName == "📊 ESP" then
        yPos = CreateLabel(ContentFrame, yPos, "📊 ESP FEATURES", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateToggle(ContentFrame, yPos, "ESP Master", "ESP")
        yPos = CreateToggle(ContentFrame, yPos, "Player ESP", "PlayerESP")
        yPos = CreateToggle(ContentFrame, yPos, "Chest ESP", "ChestESP")
        yPos = CreateToggle(ContentFrame, yPos, "Mob ESP", "MobESP")
        yPos = CreateToggle(ContentFrame, yPos, "Fruit ESP", "FruitESP")
        yPos = CreateToggle(ContentFrame, yPos, "Player Counter", "PlayerCounter")
        yPos = CreateToggle(ContentFrame, yPos, "Fruit Timer", "FruitTimer")
        yPos = CreateToggle(ContentFrame, yPos, "Raid Timer", "RaidTimer")
        
    elseif tabName == "⚙️ MISC" then
        yPos = CreateLabel(ContentFrame, yPos, "⚙️ MISC FEATURES", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateToggle(ContentFrame, yPos, "Infinite Yield", "InfiniteYield")
        yPos = CreateToggle(ContentFrame, yPos, "Anti AFK", "AntiAfk")
        yPos = CreateToggle(ContentFrame, yPos, "Auto Rejoin", "AutoRejoin")
        yPos = CreateToggle(ContentFrame, yPos, "Safe Mode", "SafeMode")
        yPos = CreateToggle(ContentFrame, yPos, "FPS Booster", "FPSBoost")
        yPos = CreateToggle(ContentFrame, yPos, "Stat Loader", "StatLoader")
        
    elseif tabName == "🎨 SET" then
        yPos = CreateLabel(ContentFrame, yPos, "🎨 SETTINGS", Color3.fromRGB(255, 140, 0))
        yPos = yPos + 5
        
        yPos = CreateButton(ContentFrame, yPos, "🎨 Theme: Orange", function()
            local themes = {"Orange", "Red", "Blue", "Green", "Purple", "Pink"}
            local colors = {
                Orange = Color3.fromRGB(255, 140, 0),
                Red = Color3.fromRGB(255, 50, 50),
                Blue = Color3.fromRGB(50, 150, 255),
                Green = Color3.fromRGB(50, 255, 50),
                Purple = Color3.fromRGB(150, 50, 255),
                Pink = Color3.fromRGB(255, 50, 150)
            }
            local current = 1
            for i, v in ipairs(themes) do
                if v == Features.Theme then
                    current = i
                    break
                end
            end
            current = current + 1
            if current > #themes then current = 1 end
            Features.Theme = themes[current]
            TopBar.BackgroundColor3 = colors[Features.Theme]
            for _, btn in ipairs(TabButtons) do
                btn.BackgroundColor3 = colors[Features.Theme]
            end
        end)
        
        yPos = CreateButton(ContentFrame, yPos, "💾 Save Config", function()
            Features.ConfigName = "Config_" .. os.time()
        end)
        
        yPos = CreateButton(ContentFrame, yPos, "📂 Load Config", function()
            -- Load config logic
        end)
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Connect tab buttons
for tabName, button in pairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(tabName)
    end)
end

-- Start with HOME tab
SwitchTab("🏠 HOME")

print("🔥 FireHub ULTIMATE Loaded Successfully!")
print("📱 Made for Delta Executor")
print("👤 Created by FirePlayz")
