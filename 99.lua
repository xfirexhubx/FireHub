--[[
    FIREHUB ULTIMATE V2 | BLOX FRUITS
    MODERN GUI | MOVABLE | FRUIT RAIN BUTTON | FRUIT ESP
--]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

repeat task.wait() until LocalPlayer and LocalPlayer.Character

local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ================================
-- SETTINGS
-- ================================
local Combat = {
    KillAura = false,
    KillRange = 35,
    KillMethod = 1,
    AimAssist = false,
    FOVSize = 150,
    Triggerbot = false,
    AutoSkills = false,
    AutoBlock = false,
}

local Movement = {
    SpeedEnabled = false,
    SpeedValue = 16,
    FlyEnabled = false,
    NoclipEnabled = false,
}

local ESP = {
    Enabled = false,
    Players = false,
    Fruits = false,  -- NEW: Fruit ESP
}

-- ================================
-- ALL 45 FRUITS DATA
-- ================================
local Fruits = {
    {Name = "Rocket", Color = Color3.fromRGB(255,100,100), Rarity = "Common"},
    {Name = "Spin", Color = Color3.fromRGB(150,150,255), Rarity = "Common"},
    {Name = "Blade", Color = Color3.fromRGB(200,200,200), Rarity = "Common"},
    {Name = "Spring", Color = Color3.fromRGB(100,255,100), Rarity = "Common"},
    {Name = "Bomb", Color = Color3.fromRGB(255,150,100), Rarity = "Common"},
    {Name = "Smoke", Color = Color3.fromRGB(100,100,100), Rarity = "Common"},
    {Name = "Spike", Color = Color3.fromRGB(255,200,100), Rarity = "Common"},
    {Name = "Flame", Color = Color3.fromRGB(255,80,0), Rarity = "Rare"},
    {Name = "Ice", Color = Color3.fromRGB(100,200,255), Rarity = "Rare"},
    {Name = "Sand", Color = Color3.fromRGB(255,200,100), Rarity = "Rare"},
    {Name = "Dark", Color = Color3.fromRGB(100,50,150), Rarity = "Rare"},
    {Name = "Eagle", Color = Color3.fromRGB(200,150,100), Rarity = "Rare"},
    {Name = "Diamond", Color = Color3.fromRGB(100,255,255), Rarity = "Rare"},
    {Name = "Light", Color = Color3.fromRGB(255,255,100), Rarity = "Rare"},
    {Name = "Rubber", Color = Color3.fromRGB(255,100,150), Rarity = "Rare"},
    {Name = "Ghost", Color = Color3.fromRGB(150,150,255), Rarity = "Rare"},
    {Name = "Magma", Color = Color3.fromRGB(255,100,0), Rarity = "Rare"},
    {Name = "Quake", Color = Color3.fromRGB(150,100,50), Rarity = "Rare"},
    {Name = "Buddha", Color = Color3.fromRGB(255,215,0), Rarity = "Legendary"},
    {Name = "Love", Color = Color3.fromRGB(255,100,150), Rarity = "Legendary"},
    {Name = "Creation", Color = Color3.fromRGB(200,100,255), Rarity = "Legendary"},
    {Name = "Spider", Color = Color3.fromRGB(100,50,50), Rarity = "Legendary"},
    {Name = "Sound", Color = Color3.fromRGB(255,200,150), Rarity = "Legendary"},
    {Name = "Phoenix", Color = Color3.fromRGB(255,100,50), Rarity = "Legendary"},
    {Name = "Portal", Color = Color3.fromRGB(100,100,255), Rarity = "Legendary"},
    {Name = "Lightning", Color = Color3.fromRGB(255,255,0), Rarity = "Legendary"},
    {Name = "Pain", Color = Color3.fromRGB(100,50,100), Rarity = "Legendary"},
    {Name = "Blizzard", Color = Color3.fromRGB(150,200,255), Rarity = "Legendary"},
    {Name = "Gravity", Color = Color3.fromRGB(100,50,150), Rarity = "Legendary"},
    {Name = "Mammoth", Color = Color3.fromRGB(150,100,50), Rarity = "Legendary"},
    {Name = "T-Rex", Color = Color3.fromRGB(100,150,50), Rarity = "Legendary"},
    {Name = "Dough", Color = Color3.fromRGB(255,200,150), Rarity = "Legendary"},
    {Name = "Shadow", Color = Color3.fromRGB(50,50,100), Rarity = "Legendary"},
    {Name = "Venom", Color = Color3.fromRGB(100,255,100), Rarity = "Legendary"},
    {Name = "Gas", Color = Color3.fromRGB(150,255,150), Rarity = "Legendary"},
    {Name = "Spirit", Color = Color3.fromRGB(200,150,255), Rarity = "Legendary"},
    {Name = "Tiger", Color = Color3.fromRGB(255,150,0), Rarity = "Mythical"},
    {Name = "Yeti", Color = Color3.fromRGB(150,200,255), Rarity = "Mythical"},
    {Name = "Kitsune", Color = Color3.fromRGB(255,100,150), Rarity = "Mythical"},
    {Name = "Control", Color = Color3.fromRGB(150,100,200), Rarity = "Mythical"},
    {Name = "Dragon", Color = Color3.fromRGB(255,50,50), Rarity = "Mythical"},
}

-- Fruit collection stats
local TotalCollected = 0
local FruitCounts = {}
for _, f in ipairs(Fruits) do FruitCounts[f.Name] = 0 end

-- ================================
-- KILL METHODS
-- ================================
local KillMethods = {
    [1] = function(p) if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.CFrame = CFrame.new(99999, 99999, 99999) end end,
    [2] = function(p) if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1000, 0) end end,
    [3] = function(p) if p.Character and p.Character:FindFirstChild("Humanoid") then p.Character.Humanoid.Health = 0 end end,
    [4] = function(p) if p.Character then p.Character:BreakJoints() end end,
}

-- ================================
-- UTILITY FUNCTIONS
-- ================================
local function GetHRP() return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end
local function GetHum() return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") end

-- ================================
-- KILL AURA
-- ================================
local function KillAuraLoop()
    if not Combat.KillAura then return end
    local hrp = GetHRP()
    if not hrp then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < Combat.KillRange then KillMethods[Combat.KillMethod](p) end
        end
    end
end

-- ================================
-- GET TARGET
-- ================================
local function GetTarget()
    local hrp = GetHRP()
    if not hrp then return nil end
    local nearest, nearestDist = nil, 100
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = p
            end
        end
    end
    return nearest
end

-- ================================
-- AUTO SKILLS
-- ================================
local function AutoSkillsLoop()
    if not Combat.AutoSkills then return end
    local target = GetTarget()
    if target and target.Character then
        for _, key in ipairs({"Z", "X", "C", "V"}) do
            VirtualInputManager:SendKeyEvent(true, key, false, game)
            task.wait(0.3)
            VirtualInputManager:SendKeyEvent(false, key, false, game)
            task.wait(0.1)
        end
    end
end

-- ================================
-- AUTO BLOCK
-- ================================
local function AutoBlockLoop()
    if not Combat.AutoBlock then return end
    local target = GetTarget()
    if target and target.Character then
        VirtualInputManager:SendKeyEvent(true, "F", false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, "F", false, game)
    end
end

-- ================================
-- FLY SYSTEM
-- ================================
local FlyActive = false
local FlyBV, FlyBG
local function ToggleFly(state)
    local hrp = GetHRP()
    local hum = GetHum()
    if not hrp or not hum then return end
    if state then
        hum.PlatformStand = true
        FlyActive = true
        FlyBV = Instance.new("BodyVelocity")
        FlyBV.MaxForce = Vector3.new(4000, 4000, 4000)
        FlyBV.Parent = hrp
        FlyBG = Instance.new("BodyGyro")
        FlyBG.MaxTorque = Vector3.new(4000, 4000, 4000)
        FlyBG.P = 1000
        FlyBG.Parent = hrp
        task.spawn(function()
            while FlyActive and FlyBV and FlyBG do
                local cam = Workspace.CurrentCamera
                if cam then
                    FlyBG.CFrame = cam.CoordinateFrame
                    local dir = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir + Vector3.new(0, -1, 0) end
                    FlyBV.Velocity = dir.Magnitude > 0 and dir.Unit * 50 or Vector3.new()
                end
                task.wait()
            end
        end)
    else
        FlyActive = false
        if FlyBV then FlyBV:Destroy() end
        if FlyBG then FlyBG:Destroy() end
        hum.PlatformStand = false
    end
end

-- ================================
-- NOCLIP
-- ================================
local function ToggleNoclip(state)
    local char = LocalPlayer.Character
    if not char then return end
    for _, p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") then p.CanCollide = not state end
    end
end

-- ================================
-- ESP SYSTEM (WITH FRUIT ESP)
-- ================================
local ESPObjects = {}

local function ClearESP()
    for _, obj in ipairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

local function CreateESP(target, color, text)
    if not target then return end
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = target
    table.insert(ESPObjects, highlight)
    
    if text then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 25)
        billboard.AlwaysOnTop = true
        billboard.Parent = target
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = color
        label.TextSize = 12
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
        
        table.insert(ESPObjects, billboard)
    end
end

-- Fruit ESP - Detects original Blox Fruits
local function FindOriginalFruits()
    local fruits = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            -- Detect original Blox Fruits by name patterns
            if name:find("fruit") or name:find("apple") or name:find("bomb") or 
               name:find("spike") or name:find("door") or name:find("flame") or
               name:find("ice") or name:find("magma") or name:find("light") or
               name:find("dark") or name:find("diamond") or name:find("buddha") then
                table.insert(fruits, obj)
            end
            -- Also detect fruit models
            if obj:IsA("Model") and obj:FindFirstChild("Handle") then
                if obj.Name:lower():find("fruit") then
                    table.insert(fruits, obj)
                end
            end
        end
    end
    return fruits
end

local function UpdateESP()
    if not ESP.Enabled then
        ClearESP()
        return
    end
    
    ClearESP()
    
    -- Player ESP
    if ESP.Players then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                CreateESP(p.Character, Color3.fromRGB(255, 50, 50), p.Name)
            end
        end
    end
    
    -- Fruit ESP - Detect original fruits
    if ESP.Fruits then
        for _, fruit in ipairs(FindOriginalFruits()) do
            local fruitColor = Color3.fromRGB(255, 100, 255)
            local fruitName = fruit.Name:gsub("Fruit", ""):gsub("fruit", "")
            CreateESP(fruit, fruitColor, "🍎 " .. fruitName)
        end
    end
end

-- ================================
-- FOV CIRCLE
-- ================================
local FOVCircle = nil
local function CreateFOVCircle()
    if FOVCircle then FOVCircle:Destroy() end
    FOVCircle = Instance.new("Frame")
    FOVCircle.Size = UDim2.new(0, Combat.FOVSize * 2, 0, Combat.FOVSize * 2)
    FOVCircle.Position = UDim2.new(0.5, -Combat.FOVSize, 0.5, -Combat.FOVSize)
    FOVCircle.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    FOVCircle.BackgroundTransparency = 0.85
    FOVCircle.BorderSizePixel = 2
    FOVCircle.BorderColor3 = Color3.fromRGB(255, 80, 80)
    FOVCircle.Visible = Combat.AimAssist
    FOVCircle.Parent = CoreGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = FOVCircle
end

local function GetEnemyInFOV()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos, onScreen = cam:WorldToScreenPoint(hrp.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < Combat.FOVSize then return p end
                end
            end
        end
    end
    return nil
end

-- ================================
-- TRIGGERBOT
-- ================================
local function TriggerbotLoop()
    if not Combat.Triggerbot then return end
    local target = GetEnemyInFOV()
    if target then
        VirtualInputManager:SendKeyEvent(true, "Button1", false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, "Button1", false, game)
    end
end

-- ================================
-- AIM ASSIST
-- ================================
local function AimAssistLoop()
    if not Combat.AimAssist then return end
    local target = GetEnemyInFOV()
    if target and target.Character then
        local hrp = GetHRP()
        if hrp then
            hrp.CFrame = CFrame.lookAt(hrp.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end

-- ================================
-- FRUIT RAIN BUTTON (Spawns on player)
-- ================================
local function SpawnFruitOnPlayer()
    local hrp = GetHRP()
    if not hrp then return end
    
    -- Random fruit from all 45
    local fruit = Fruits[math.random(1, #Fruits)]
    local pos = hrp.Position + Vector3.new(0, 3, 0) -- Spawn at player's feet
    
    -- Create fruit part
    local part = Instance.new("Part")
    part.Name = fruit.Name .. "Fruit"
    part.Size = Vector3.new(2, 2, 2)
    part.Position = pos
    part.Anchored = false
    part.CanCollide = true
    part.BrickColor = BrickColor.new(fruit.Color)
    part.Material = Enum.Material.Neon
    part.Parent = Workspace
    
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Scale = Vector3.new(1.2, 1.2, 1.2)
    mesh.Parent = part
    
    -- Add particles for mythical fruits
    if fruit.Rarity == "Mythical" then
        local particles = Instance.new("ParticleEmitter")
        particles.Rate = 20
        particles.Lifetime = NumberRange.new(1)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Color = ColorSequence.new(fruit.Color)
        particles.Parent = part
    end
    
    -- Floating animation
    local startY = pos.Y
    task.spawn(function()
        local t = 0
        while part and part.Parent do
            t = t + 0.05
            part.Position = Vector3.new(part.Position.X, startY + math.sin(t) * 0.5, part.Position.Z)
            task.wait()
        end
    end)
    
    -- Auto collect (instant collection on spawn)
    task.spawn(function()
        task.wait(0.5)
        if part and part.Parent then
            part:Destroy()
            TotalCollected = TotalCollected + 1
            FruitCounts[fruit.Name] = FruitCounts[fruit.Name] + 1
            -- Show collection message
            local msg = Instance.new("TextLabel")
            msg.Text = "🍎 Collected " .. fruit.Name .. " Fruit! (" .. fruit.Rarity .. ")"
            msg.TextColor3 = fruit.Color
            msg.TextSize = 18
            msg.Font = Enum.Font.GothamBold
            msg.Position = UDim2.new(0.5, -150, 0.5, -20)
            msg.Size = UDim2.new(0, 300, 0, 40)
            msg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            msg.BackgroundTransparency = 0.3
            msg.Parent = CoreGui
            task.wait(2)
            msg:Destroy()
        end
    end)
    
    -- Despawn after 5 seconds if not collected
    task.wait(5)
    pcall(function() part:Destroy() end)
end

-- ================================
-- MAIN LOOP
-- ================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        KillAuraLoop()
        TriggerbotLoop()
        AimAssistLoop()
        AutoSkillsLoop()
        AutoBlockLoop()
        
        if Movement.SpeedEnabled then
            local hum = GetHum()
            if hum then hum.WalkSpeed = Movement.SpeedValue end
        end
        
        if ESP.Enabled then UpdateESP() end
    end)
end)

-- ================================
-- MODERN GUI
-- ================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FireHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- MOVABLE ICON
local Icon = Instance.new("ImageButton")
Icon.Size = UDim2.new(0, 55, 0, 55)
Icon.Position = UDim2.new(0, 15, 0.5, -27)
Icon.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
Icon.BackgroundTransparency = 0
Icon.Image = "rbxassetid://75831350708221"
Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
Icon.ScaleType = Enum.ScaleType.Fit
Icon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = Icon

-- Make Icon Movable
local draggingIcon = false
local dragIconStart, dragIconPos

Icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingIcon = true
        dragIconStart = input.Position
        dragIconPos = Icon.Position
    end
end)

Icon.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingIcon = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingIcon and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragIconStart
        Icon.Position = UDim2.new(
            dragIconPos.X.Scale, dragIconPos.X.Offset + delta.X,
            dragIconPos.Y.Scale, dragIconPos.Y.Offset + delta.Y
        )
    end
end)

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 550)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Make MainFrame Movable
local draggingFrame = false
local dragFrameStart, dragFramePos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFrame = true
        dragFrameStart = input.Position
        dragFramePos = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFrame = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingFrame and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragFrameStart
        MainFrame.Position = UDim2.new(
            dragFramePos.X.Scale, dragFramePos.X.Offset + delta.X,
            dragFramePos.Y.Scale, dragFramePos.Y.Offset + delta.Y
        )
    end
end)

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚔️ FIREHUB ULTIMATE"
TitleLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.Position = UDim2.new(1, -42, 0.5, -16)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Minimize Button
local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 32, 0, 32)
MinButton.Position = UDim2.new(1, -84, 0.5, -16)
MinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
MinButton.Text = "−"
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.TextSize = 18
MinButton.Font = Enum.Font.GothamBold
MinButton.BorderSizePixel = 0
MinButton.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinButton

MinButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Icon.Visible = true
end)

Icon.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    Icon.Visible = false
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -275)
end)

-- TAB BAR
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 45)
TabBar.Position = UDim2.new(0, 0, 0, 55)
TabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

-- Tab Buttons
local Tabs = {"PVP", "MOVEMENT", "ESP", "FRUIT"}
local TabButtons = {}
local CurrentTab = "PVP"

local function CreateTabButton(name, xPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 105, 1, 0)
    btn.Position = UDim2.new(0, xPos, 0, 0)
    btn.BackgroundColor3 = name == "PVP" and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(30, 30, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    return btn
end

-- CONTENT FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -115)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = MainFrame

-- CONTENT BUILDERS
local contentY = 5
local function ResetContent()
    for _, child in ipairs(ContentFrame:GetChildren()) do
        child:Destroy()
    end
    contentY = 5
end

local function AddSection(text)
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(1, 0, 0, 30)
    section.Position = UDim2.new(0, 0, 0, contentY)
    section.BackgroundTransparency = 1
    section.Text = text
    section.TextColor3 = Color3.fromRGB(255, 80, 80)
    section.TextSize = 16
    section.Font = Enum.Font.GothamBold
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.Parent = ContentFrame
    contentY = contentY + 38
end

local function AddToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.Position = UDim2.new(0, 0, 0, contentY)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 65, 0, 32)
    btn.Position = UDim2.new(1, -77, 0.5, -16)
    btn.BackgroundColor3 = default and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(255, 80, 80)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(255, 80, 80)
        btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
    
    contentY = contentY + 53
end

local function AddSlider(text, min, max, default, suffix, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 65)
    frame.Position = UDim2.new(0, 0, 0, contentY)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 12, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default .. suffix
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -40, 0, 5)
    track.Position = UDim2.new(0, 20, 0, 45)
    track.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    track.BorderSizePixel = 0
    track.Parent = frame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    fill.BorderSizePixel = 0
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local value = default
    local dragging = false
    
    local function updateSlider(input)
        local posX = input.Position.X
        local trackPos = track.AbsolutePosition.X
        local trackWidth = track.AbsoluteSize.X
        local percent = math.clamp((posX - trackPos) / trackWidth, 0, 1)
        value = math.floor(min + (max - min) * percent)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. value .. suffix
        callback(value)
    end
    
    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(1, 0, 1, 0)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.Parent = track
    
    dragBtn.MouseButton1Down:Connect(function(input)
        dragging = true
        updateSlider(input)
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    contentY = contentY + 73
end

local function AddDropdown(text, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.Position = UDim2.new(0, 0, 0, contentY)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 34)
    btn.Position = UDim2.new(1, -152, 0.5, -17)
    btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    btn.Text = options[default]
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local idx = default
    btn.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        btn.Text = options[idx]
        callback(idx, options[idx])
    end)
    
    contentY = contentY + 58
end

local function AddButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.Position = UDim2.new(0, 10, 0, contentY)
    btn.BackgroundColor3 = color or Color3.fromRGB(255, 80, 80)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = ContentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    contentY = contentY + 58
end

-- BUILD UI
local function BuildPVPTab()
    AddSection("⚔️ PVP / COMBAT")
    AddToggle("Kill Aura", Combat.KillAura, function(v) Combat.KillAura = v end)
    AddSlider("Kill Range", 20, 100, Combat.KillRange, " studs", function(v) Combat.KillRange = v end)
    AddDropdown("Kill Method", {"Border Kill", "Void Kill", "Health Kill", "Exploit Kill"}, Combat.KillMethod, function(i, v) Combat.KillMethod = i end)
    AddToggle("Aim Assist (FOV)", Combat.AimAssist, function(v) Combat.AimAssist = v if FOVCircle then FOVCircle.Visible = v end end)
    AddSlider("FOV Size", 50, 300, Combat.FOVSize, " px", function(v) Combat.FOVSize = v if FOVCircle then FOVCircle.Size = UDim2.new(0, v*2, 0, v*2) FOVCircle.Position = UDim2.new(0.5, -v, 0.5, -v) end end)
    AddToggle("Triggerbot", Combat.Triggerbot, function(v) Combat.Triggerbot = v end)
    AddToggle("Auto Skills (Z,X,C,V)", Combat.AutoSkills, function(v) Combat.AutoSkills = v end)
    AddToggle("Auto Block (F)", Combat.AutoBlock, function(v) Combat.AutoBlock = v end)
end

local function BuildMovementTab()
    AddSection("🏃 MOVEMENT")
    AddToggle("Speed Modifier", Movement.SpeedEnabled, function(v) Movement.SpeedEnabled = v end)
    AddSlider("Walkspeed", 16, 200, Movement.SpeedValue, "", function(v) Movement.SpeedValue = v if Movement.SpeedEnabled then local h = GetHum() if h then h.WalkSpeed = v end end end)
    AddToggle("Fly Mode", Movement.FlyEnabled, function(v) Movement.FlyEnabled = v ToggleFly(v) end)
    AddToggle("Noclip", Movement.NoclipEnabled, function(v) Movement.NoclipEnabled = v ToggleNoclip(v) end)
end

local function BuildESPTab()
    AddSection("👁️ ESP")
    AddToggle("ESP Master", ESP.Enabled, function(v) ESP.Enabled = v end)
    AddToggle("Player ESP", ESP.Players, function(v) ESP.Players = v end)
    AddToggle("🍎 Fruit ESP", ESP.Fruits, function(v) ESP.Fruits = v end)
end

local function BuildFruitTab()
    AddSection("🍎 FRUIT RAIN 2026")
    AddSection("🌧️ SPAWN FRUIT ON YOUR POSITION")
    
    -- BUTTON (not toggle) - spawns fruit on player
    AddButton("🍎 SPAWN RANDOM FRUIT 🍎", Color3.fromRGB(255, 100, 100), function()
        SpawnFruitOnPlayer()
    end)
    
    AddSection("📊 COLLECTION STATS")
    
    local statsFrame = Instance.new("Frame")
    statsFrame.Size = UDim2.new(1, 0, 0, 80)
    statsFrame.Position = UDim2.new(0, 0, 0, contentY)
    statsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    statsFrame.Parent = ContentFrame
    
    local statsCorner = Instance.new("UICorner")
    statsCorner.CornerRadius = UDim.new(0, 8)
    statsCorner.Parent = statsFrame
    
    local totalLabel = Instance.new("TextLabel")
    totalLabel.Size = UDim2.new(1, -20, 0, 35)
    totalLabel.Position = UDim2.new(0, 10, 0, 10)
    totalLabel.BackgroundTransparency = 1
    totalLabel.Text = "🍎 Total Fruits Collected: 0"
    totalLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    totalLabel.TextSize = 14
    totalLabel.Font = Enum.Font.GothamBold
    totalLabel.TextXAlignment = Enum.TextXAlignment.Left
    totalLabel.Parent = statsFrame
    
    local uniqueLabel = Instance.new("TextLabel")
    uniqueLabel.Size = UDim2.new(1, -20, 0, 35)
    uniqueLabel.Position = UDim2.new(0, 10, 0, 45)
    uniqueLabel.BackgroundTransparency = 1
    uniqueLabel.Text = "⭐ Unique Fruits: 0/45"
    uniqueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    uniqueLabel.TextSize = 13
    uniqueLabel.Font = Enum.Font.Gotham
    uniqueLabel.TextXAlignment = Enum.TextXAlignment.Left
    uniqueLabel.Parent = statsFrame
    
    contentY = contentY + 88
    
    -- Update stats loop
    task.spawn(function()
        while true do
            task.wait(1)
            local unique = 0
            for _, count in pairs(FruitCounts) do
                if count > 0 then unique = unique + 1 end
            end
            totalLabel.Text = "🍎 Total Fruits Collected: " .. TotalCollected
            uniqueLabel.Text = "⭐ Unique Fruits: " .. unique .. "/45"
        end
    end)
    
    AddSection("🍇 ALL 45 FRUITS")
    
    -- Show fruits by rarity
    local rarities = {"Common", "Rare", "Legendary", "Mythical"}
    for _, rarity in ipairs(rarities) do
        local rarityLabel = Instance.new("TextLabel")
        rarityLabel.Size = UDim2.new(1, 0, 0, 28)
        rarityLabel.Position = UDim2.new(0, 0, 0, contentY)
        rarityLabel.BackgroundTransparency = 1
        rarityLabel.Text = "✦ " .. rarity .. " Fruits"
        rarityLabel.TextColor3 = rarity == "Mythical" and Color3.fromRGB(255, 100, 150) or 
                                  rarity == "Legendary" and Color3.fromRGB(255, 200, 50) or
                                  rarity == "Rare" and Color3.fromRGB(100, 150, 255) or
                                  Color3.fromRGB(150, 150, 150)
        rarityLabel.TextSize = 14
        rarityLabel.Font = Enum.Font.GothamBold
        rarityLabel.TextXAlignment = Enum.TextXAlignment.Left
        rarityLabel.Parent = ContentFrame
        contentY = contentY + 32
        
        for _, fruit in ipairs(Fruits) do
            if fruit.Rarity == rarity then
                local fruitLabel = Instance.new("TextLabel")
                fruitLabel.Size = UDim2.new(1, 0, 0, 24)
                fruitLabel.Position = UDim2.new(0, 15, 0, contentY)
                fruitLabel.BackgroundTransparency = 1
                local collected = FruitCounts[fruit.Name] > 0 and "✓" or "○"
                fruitLabel.Text = collected .. " " .. fruit.Name
                fruitLabel.TextColor3 = fruit.Color
                fruitLabel.TextSize = 12
                fruitLabel.Font = Enum.Font.Gotham
                fruitLabel.TextXAlignment = Enum.TextXAlignment.Left
                fruitLabel.Parent = ContentFrame
                contentY = contentY + 26
            end
        end
        contentY = contentY + 5
    end
end

-- Tab switching
local pvpBtn = CreateTabButton("PVP", 0)
local movementBtn = CreateTabButton("MOVEMENT", 105)
local espBtn = CreateTabButton("ESP", 210)
local fruitBtn = CreateTabButton("FRUIT", 315)

pvpBtn.MouseButton1Click:Connect(function()
    CurrentTab = "PVP"
    pvpBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    movementBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    fruitBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ResetContent()
    BuildPVPTab()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentY + 20)
end)

movementBtn.MouseButton1Click:Connect(function()
    CurrentTab = "MOVEMENT"
    pvpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    movementBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    fruitBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ResetContent()
    BuildMovementTab()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentY + 20)
end)

espBtn.MouseButton1Click:Connect(function()
    CurrentTab = "ESP"
    pvpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    movementBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    espBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    fruitBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ResetContent()
    BuildESPTab()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentY + 20)
end)

fruitBtn.MouseButton1Click:Connect(function()
    CurrentTab = "FRUIT"
    pvpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    movementBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    fruitBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    ResetContent()
    BuildFruitTab()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentY + 20)
end)

-- Build initial tab
BuildPVPTab()
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentY + 20)

-- Create FOV Circle
CreateFOVCircle()

-- Success Message
print("⚔️ FIREHUB ULTIMATE V2 LOADED ⚔️")
print("🎯 Kill Aura | Aim Assist | Auto Skills")
print("🍎 Fruit Rain BUTTON - Spawns fruit on your position")
print("👁️ Fruit ESP - Detects original Blox Fruits")
print("🔥 Click the 🔥 icon to open menu")
