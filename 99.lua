--[[
    FIREHUB ULTIMATE V1 | BLOX FRUITS
    Created by: FirePlayz
    Discord: https://discord.gg/firehub
    Features: Fruit Rain (45 Fruits), Kill Aura, ESP, Auto Farm, Movement
--]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer and LocalPlayer.Character

local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Settings Table
local Settings = {
    -- Combat
    KillAura = false,
    KillRange = 30,
    KillMethod = 1,
    AimAssist = false,
    FOVSize = 150,
    Triggerbot = false,
    
    -- Movement
    SpeedEnabled = false,
    SpeedValue = 16,
    JumpEnabled = false,
    JumpValue = 50,
    FlyEnabled = false,
    NoclipEnabled = false,
    InfinityJumpEnabled = false,
    
    -- ESP
    ESPEnabled = false,
    ESPPlayers = false,
    ESPChests = false,
    ESPMobs = false,
    ESPFruits = false,
    
    -- Auto Farm
    AutoFarmEnabled = false,
    FarmDistance = 100,
    AutoAttackEnabled = false,
    
    -- Fruit Rain (45 Fruits)
    FruitRainEnabled = false,
    AutoCollectEnabled = false,
    RareOnlyEnabled = false,
    FruitsCollected = 0,
    
    -- UI
    UIVisible = true,
    UITransparency = 0.85,
    ThemeColor = 1
}

-- All 45 Fruits Data
local Fruits = {
    -- Common (7)
    {Name = "Rocket", Color = Color3.fromRGB(255,100,100), Rarity = "Common", Value = 5000},
    {Name = "Spin", Color = Color3.fromRGB(150,150,255), Rarity = "Common", Value = 7500},
    {Name = "Blade", Color = Color3.fromRGB(200,200,200), Rarity = "Common", Value = 10000},
    {Name = "Spring", Color = Color3.fromRGB(100,255,100), Rarity = "Common", Value = 12000},
    {Name = "Bomb", Color = Color3.fromRGB(255,150,100), Rarity = "Common", Value = 15000},
    {Name = "Smoke", Color = Color3.fromRGB(100,100,100), Rarity = "Common", Value = 18000},
    {Name = "Spike", Color = Color3.fromRGB(255,200,100), Rarity = "Common", Value = 20000},
    
    -- Rare (11)
    {Name = "Flame", Color = Color3.fromRGB(255,80,0), Rarity = "Rare", Value = 250000},
    {Name = "Ice", Color = Color3.fromRGB(100,200,255), Rarity = "Rare", Value = 350000},
    {Name = "Sand", Color = Color3.fromRGB(255,200,100), Rarity = "Rare", Value = 420000},
    {Name = "Dark", Color = Color3.fromRGB(100,50,150), Rarity = "Rare", Value = 500000},
    {Name = "Eagle", Color = Color3.fromRGB(200,150,100), Rarity = "Rare", Value = 550000},
    {Name = "Diamond", Color = Color3.fromRGB(100,255,255), Rarity = "Rare", Value = 600000},
    {Name = "Light", Color = Color3.fromRGB(255,255,100), Rarity = "Rare", Value = 650000},
    {Name = "Rubber", Color = Color3.fromRGB(255,100,150), Rarity = "Rare", Value = 700000},
    {Name = "Ghost", Color = Color3.fromRGB(150,150,255), Rarity = "Rare", Value = 750000},
    {Name = "Magma", Color = Color3.fromRGB(255,100,0), Rarity = "Rare", Value = 800000},
    {Name = "Quake", Color = Color3.fromRGB(150,100,50), Rarity = "Rare", Value = 850000},
    
    -- Legendary (18)
    {Name = "Buddha", Color = Color3.fromRGB(255,215,0), Rarity = "Legendary", Value = 1200000},
    {Name = "Love", Color = Color3.fromRGB(255,100,150), Rarity = "Legendary", Value = 1300000},
    {Name = "Creation", Color = Color3.fromRGB(200,100,255), Rarity = "Legendary", Value = 1400000},
    {Name = "Spider", Color = Color3.fromRGB(100,50,50), Rarity = "Legendary", Value = 1500000},
    {Name = "Sound", Color = Color3.fromRGB(255,200,150), Rarity = "Legendary", Value = 1600000},
    {Name = "Phoenix", Color = Color3.fromRGB(255,100,50), Rarity = "Legendary", Value = 1700000},
    {Name = "Portal", Color = Color3.fromRGB(100,100,255), Rarity = "Legendary", Value = 1800000},
    {Name = "Lightning", Color = Color3.fromRGB(255,255,0), Rarity = "Legendary", Value = 1900000},
    {Name = "Pain", Color = Color3.fromRGB(100,50,100), Rarity = "Legendary", Value = 2000000},
    {Name = "Blizzard", Color = Color3.fromRGB(150,200,255), Rarity = "Legendary", Value = 2100000},
    {Name = "Gravity", Color = Color3.fromRGB(100,50,150), Rarity = "Legendary", Value = 2200000},
    {Name = "Mammoth", Color = Color3.fromRGB(150,100,50), Rarity = "Legendary", Value = 2300000},
    {Name = "T-Rex", Color = Color3.fromRGB(100,150,50), Rarity = "Legendary", Value = 2400000},
    {Name = "Dough", Color = Color3.fromRGB(255,200,150), Rarity = "Legendary", Value = 2500000},
    {Name = "Shadow", Color = Color3.fromRGB(50,50,100), Rarity = "Legendary", Value = 2600000},
    {Name = "Venom", Color = Color3.fromRGB(100,255,100), Rarity = "Legendary", Value = 2700000},
    {Name = "Gas", Color = Color3.fromRGB(150,255,150), Rarity = "Legendary", Value = 2800000},
    {Name = "Spirit", Color = Color3.fromRGB(200,150,255), Rarity = "Legendary", Value = 2900000},
    
    -- Mythical (5)
    {Name = "Tiger", Color = Color3.fromRGB(255,150,0), Rarity = "Mythical", Value = 3000000},
    {Name = "Yeti", Color = Color3.fromRGB(150,200,255), Rarity = "Mythical", Value = 3200000},
    {Name = "Kitsune", Color = Color3.fromRGB(255,100,150), Rarity = "Mythical", Value = 3500000},
    {Name = "Control", Color = Color3.fromRGB(150,100,200), Rarity = "Mythical", Value = 3800000},
    {Name = "Dragon", Color = Color3.fromRGB(255,50,50), Rarity = "Mythical", Value = 5000000}
}

-- Fruit Collection Counter
local FruitCounts = {}
for _, fruit in ipairs(Fruits) do
    FruitCounts[fruit.Name] = 0
end

-- Kill Methods
local KillMethods = {
    [1] = function(target)
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = CFrame.new(99999, 99999, 99999)
        end
    end,
    [2] = function(target)
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1000, 0)
        end
    end,
    [3] = function(target)
        if target.Character and target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Health = 0
        end
    end,
    [4] = function(target)
        if target.Character then
            target.Character:BreakJoints()
        end
    end
}

-- Utility Functions
local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function GetHumanoidRootPart()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ESP System
local ESPObjects = {}

local function ClearESP()
    for _, obj in ipairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

local function CreateESP(target, color)
    if not target then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "FireHubESP"
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(255,255,255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = target
    table.insert(ESPObjects, highlight)
end

local function UpdateESP()
    if not Settings.ESPEnabled then
        ClearESP()
        return
    end
    
    ClearESP()
    
    if Settings.ESPPlayers then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                CreateESP(player.Character, Color3.fromRGB(255,50,50))
            end
        end
    end
    
    if Settings.ESPChests then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and (part.Name:lower():find("chest") or part.Name:lower():find("barrel")) then
                CreateESP(part, Color3.fromRGB(50,255,50))
            end
        end
    end
    
    if Settings.ESPMobs then
        for _, model in ipairs(Workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(model) then
                CreateESP(model, Color3.fromRGB(255,255,0))
            end
        end
    end
    
    if Settings.ESPFruits then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:find("Fruit") then
                CreateESP(part, Color3.fromRGB(150,50,255))
            end
        end
    end
end

-- Movement Systems
local FlyActive = false
local FlyBodyVelocity, FlyBodyGyro

local function ToggleFly(state)
    local hrp = GetHumanoidRootPart()
    local hum = GetHumanoid()
    if not hrp or not hum then return end
    
    if state then
        hum.PlatformStand = true
        FlyActive = true
        
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
        FlyBodyVelocity.Parent = hrp
        
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.MaxTorque = Vector3.new(4000,4000,4000)
        FlyBodyGyro.P = 1000
        FlyBodyGyro.Parent = hrp
        
        task.spawn(function()
            while FlyActive and FlyBodyVelocity and FlyBodyGyro do
                local camera = Workspace.CurrentCamera
                if camera then
                    FlyBodyGyro.CFrame = camera.CoordinateFrame
                    local direction = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0,1,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction + Vector3.new(0,-1,0) end
                    FlyBodyVelocity.Velocity = direction.Magnitude > 0 and direction.Unit * 50 or Vector3.new()
                end
                task.wait()
            end
        end)
    else
        FlyActive = false
        if FlyBodyVelocity then FlyBodyVelocity:Destroy() end
        if FlyBodyGyro then FlyBodyGyro:Destroy() end
        hum.PlatformStand = false
    end
end

local function ToggleNoclip(state)
    local char = GetCharacter()
    if not char then return end
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = not state
        end
    end
end

local JumpConnection
local function ToggleInfinityJump(state)
    if state then
        if JumpConnection then return end
        JumpConnection = UserInputService.JumpRequest:Connect(function()
            local hum = GetHumanoid()
            if hum and hum:GetState() ~= Enum.HumanoidStateType.Dead then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if JumpConnection then
            JumpConnection:Disconnect()
            JumpConnection = nil
        end
    end
end

-- Auto Farm
local IsAttacking = false

local function GetNearestNPC()
    local hrp = GetHumanoidRootPart()
    if not hrp then return nil end
    
    local nearest, nearestDist = nil, Settings.FarmDistance
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
            local root = obj:FindFirstChild("HumanoidRootPart")
            if root then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = obj
                end
            end
        end
    end
    
    return nearest
end

local function AutoFarmLoop()
    if not Settings.AutoFarmEnabled then return end
    
    local npc = GetNearestNPC()
    if npc and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
        local hrp = GetHumanoidRootPart()
        local npcRoot = npc:FindFirstChild("HumanoidRootPart")
        if hrp and npcRoot then
            hrp.CFrame = CFrame.lookAt(hrp.Position, npcRoot.Position)
            
            if Settings.AutoAttackEnabled and not IsAttacking then
                IsAttacking = true
                task.spawn(function()
                    while Settings.AutoAttackEnabled and Settings.AutoFarmEnabled and npc and npc.Humanoid and npc.Humanoid.Health > 0 do
                        VirtualInputManager:SendKeyEvent(true, "Button1", false, game)
                        task.wait(0.1)
                        VirtualInputManager:SendKeyEvent(false, "Button1", false, game)
                        task.wait(0.2)
                    end
                    IsAttacking = false
                end)
            end
        end
    else
        IsAttacking = false
    end
end

-- Kill Aura
local function KillAuraLoop()
    if not Settings.KillAura then return end
    
    local hrp = GetHumanoidRootPart()
    if not hrp then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < Settings.KillRange then
                KillMethods[Settings.KillMethod](player)
            end
        end
    end
end

-- Aim Assist / FOV
local FOVCircle

local function CreateFOVCircle()
    if FOVCircle then FOVCircle:Destroy() end
    
    FOVCircle = Instance.new("Frame")
    FOVCircle.Size = UDim2.new(0, Settings.FOVSize * 2, 0, Settings.FOVSize * 2)
    FOVCircle.Position = UDim2.new(0.5, -Settings.FOVSize, 0.5, -Settings.FOVSize)
    FOVCircle.BackgroundColor3 = Color3.fromRGB(255,140,0)
    FOVCircle.BackgroundTransparency = 0.85
    FOVCircle.BorderSizePixel = 2
    FOVCircle.BorderColor3 = Color3.fromRGB(255,140,0)
    FOVCircle.Visible = Settings.AimAssist
    FOVCircle.Parent = CoreGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = FOVCircle
end

local function GetEnemyInFOV()
    local camera = Workspace.CurrentCamera
    if not camera then return nil end
    
    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos, onScreen = camera:WorldToScreenPoint(hrp.Position)
                if onScreen then
                    local distance = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if distance < Settings.FOVSize then
                        return player
                    end
                end
            end
        end
    end
    
    return nil
end

-- Fruit Rain System
local FruitRainActive = false
local FruitRainConnection

local function CreateFruitRainFruit(fruit, position)
    local part = Instance.new("Part")
    part.Name = fruit.Name .. "Fruit"
    part.Size = Vector3.new(2.2, 2.2, 2.2)
    part.Position = position
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
        particles.Rate = 15
        particles.Lifetime = NumberRange.new(0.8)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Color = ColorSequence.new(fruit.Color)
        particles.Parent = part
    end
    
    -- Floating animation
    local startY = position.Y
    task.spawn(function()
        local t = 0
        while part and part.Parent do
            t = t + 0.05
            part.Position = Vector3.new(part.Position.X, startY + math.sin(t) * 0.5, part.Position.Z)
            task.wait()
        end
    end)
    
    -- Auto collect
    if Settings.AutoCollectEnabled then
        task.spawn(function()
            while part and part.Parent do
                local hrp = GetHumanoidRootPart()
                if hrp and (hrp.Position - part.Position).Magnitude < 5 then
                    part:Destroy()
                    Settings.FruitsCollected = Settings.FruitsCollected + 1
                    FruitCounts[fruit.Name] = FruitCounts[fruit.Name] + 1
                    break
                end
                task.wait(0.1)
            end
        end)
    end
    
    -- Despawn after 35 seconds
    task.wait(35)
    pcall(function() part:Destroy() end)
end

local function StartFruitRain()
    if FruitRainActive then return end
    FruitRainActive = true
    
    FruitRainConnection = RunService.Heartbeat:Connect(function()
        if not Settings.FruitRainEnabled then
            FruitRainActive = false
            if FruitRainConnection then
                FruitRainConnection:Disconnect()
                FruitRainConnection = nil
            end
            return
        end
        
        if math.random(1, 28) == 1 then
            local availableFruits = Fruits
            if Settings.RareOnlyEnabled then
                availableFruits = {}
                for _, fruit in ipairs(Fruits) do
                    if fruit.Rarity == "Legendary" or fruit.Rarity == "Mythical" then
                        table.insert(availableFruits, fruit)
                    end
                end
            end
            
            local fruit = availableFruits[math.random(1, #availableFruits)]
            local x = math.random(-150, 150)
            local z = math.random(-150, 150)
            CreateFruitRainFruit(fruit, Vector3.new(x, 45, z))
        end
    end)
end

-- Main Loop
RunService.Heartbeat:Connect(function()
    pcall(function()
        -- Movement
        if Settings.SpeedEnabled then
            local hum = GetHumanoid()
            if hum then hum.WalkSpeed = Settings.SpeedValue end
        end
        
        if Settings.JumpEnabled then
            local hum = GetHumanoid()
            if hum then hum.JumpPower = Settings.JumpValue end
        end
        
        -- Combat
        KillAuraLoop()
        
        -- Auto Farm
        if Settings.AutoFarmEnabled then
            AutoFarmLoop()
        end
        
        -- Fruit Rain
        if Settings.FruitRainEnabled and not FruitRainActive then
            StartFruitRain()
        end
        
        -- Aim Assist
        if Settings.AimAssist then
            local target = GetEnemyInFOV()
            if target and target.Character then
                local hrp = GetHumanoidRootPart()
                if hrp then
                    hrp.CFrame = CFrame.lookAt(hrp.Position, target.Character.HumanoidRootPart.Position)
                end
                
                if Settings.Triggerbot then
                    VirtualInputManager:SendKeyEvent(true, "Button1", false, game)
                    task.wait(0.05)
                    VirtualInputManager:SendKeyEvent(false, "Button1", false, game)
                end
            end
        end
        
        -- ESP
        if Settings.ESPEnabled then
            UpdateESP()
        end
    end)
end)

-- Create GUI (simplified)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FireHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(0, 50, 0, 50)
MainButton.Position = UDim2.new(0, 10, 0.5, -25)
MainButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
MainButton.Text = "🔥"
MainButton.TextSize = 30
MainButton.Font = Enum.Font.GothamBold
MainButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = MainButton

local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0, 300, 0, 400)
Menu.Position = UDim2.new(0.5, -150, 0.5, -200)
Menu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Menu.BackgroundTransparency = 0.1
Menu.Visible = false
Menu.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = Menu

-- Quick toggles in menu
local FruitRainBtn = Instance.new("TextButton")
FruitRainBtn.Size = UDim2.new(0.9, 0, 0, 40)
FruitRainBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
FruitRainBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
FruitRainBtn.Text = "🌧️ FRUIT RAIN"
FruitRainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FruitRainBtn.TextSize = 14
FruitRainBtn.Font = Enum.Font.GothamBold
FruitRainBtn.Parent = Menu

FruitRainBtn.MouseButton1Click:Connect(function()
    Settings.FruitRainEnabled = not Settings.FruitRainEnabled
    FruitRainBtn.BackgroundColor3 = Settings.FruitRainEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
    if Settings.FruitRainEnabled then StartFruitRain() end
end)

local KillAuraBtn = Instance.new("TextButton")
KillAuraBtn.Size = UDim2.new(0.9, 0, 0, 40)
KillAuraBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
KillAuraBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
KillAuraBtn.Text = "⚔️ KILL AURA"
KillAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAuraBtn.TextSize = 14
KillAuraBtn.Font = Enum.Font.GothamBold
KillAuraBtn.Parent = Menu

KillAuraBtn.MouseButton1Click:Connect(function()
    Settings.KillAura = not Settings.KillAura
    KillAuraBtn.BackgroundColor3 = Settings.KillAura and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
end)

local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(0.9, 0, 0, 40)
ESPBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
ESPBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
ESPBtn.Text = "👁️ ESP"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.TextSize = 14
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.Parent = Menu

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESPEnabled = not Settings.ESPEnabled
    ESPBtn.BackgroundColor3 = Settings.ESPEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
end)

local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(0.9, 0, 0, 40)
FlyBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
FlyBtn.Text = "🦅 FLY MODE"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.TextSize = 14
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Parent = Menu

FlyBtn.MouseButton1Click:Connect(function()
    Settings.FlyEnabled = not Settings.FlyEnabled
    FlyBtn.BackgroundColor3 = Settings.FlyEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
    ToggleFly(Settings.FlyEnabled)
end)

local CloseMenu = Instance.new("TextButton")
CloseMenu.Size = UDim2.new(0.9, 0, 0, 40)
CloseMenu.Position = UDim2.new(0.05, 0, 0.85, 0)
CloseMenu.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseMenu.Text = "CLOSE"
CloseMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseMenu.TextSize = 14
CloseMenu.Font = Enum.Font.GothamBold
CloseMenu.Parent = Menu

CloseMenu.MouseButton1Click:Connect(function()
    Menu.Visible = false
end)

MainButton.MouseButton1Click:Connect(function()
    Menu.Visible = not Menu.Visible
end)

-- Create FOV Circle
CreateFOVCircle()

-- Success Message
print("🔥 FIREHUB V1 LOADED")
