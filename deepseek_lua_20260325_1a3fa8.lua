--[[
    FIREHUB ULTIMATE V1 | BLOX FRUITS
    PRIMARY FOCUS: PVP / COMBAT
    Secondary: Fruit Rain, ESP, Movement
    Created by: FirePlayz
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

-- ================================
-- PVP / COMBAT SETTINGS (PRIORITY)
-- ================================
local Combat = {
    -- Kill Aura
    KillAura = false,
    KillRange = 35,
    KillMethod = 1, -- 1=Border, 2=Void, 3=Health, 4=Exploit
    
    -- Aim Assist / FOV
    AimAssist = false,
    FOVSize = 180,
    Triggerbot = false,
    AutoBlock = false,
    AutoDodge = false,
    
    -- Auto Skills
    AutoSkills = false,
    SkillDelay = 0.5,
    
    -- Player Targeting
    TargetMode = 1, -- 1=Nearest, 2=Lowest HP, 3=Closest Mouse
    
    -- Anti-Stun
    AntiStun = false,
    AutoRejoin = false,
    
    -- Combat Stats
    Kills = 0,
    Deaths = 0
}

-- Movement Settings
local Movement = {
    SpeedEnabled = false,
    SpeedValue = 16,
    JumpEnabled = false,
    JumpValue = 50,
    FlyEnabled = false,
    NoclipEnabled = false,
    InfinityJumpEnabled = false
}

-- ESP Settings
local ESP = {
    Enabled = false,
    Players = false,
    NameTags = false,
    HealthBar = false,
    Distance = false,
    BoxESP = false,
    Tracers = false,
    Chests = false,
    Fruits = false
}

-- Fruit Rain Settings (Secondary)
local FruitRain = {
    Enabled = false,
    AutoCollect = false,
    RareOnly = false,
    TotalCollected = 0
}

-- ================================
-- ALL 45 FRUITS DATA
-- ================================
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

-- Fruit Collection
local FruitCounts = {}
for _, fruit in ipairs(Fruits) do
    FruitCounts[fruit.Name] = 0
end

-- ================================
-- KILL METHODS (PVP CORE)
-- ================================
local KillMethods = {
    [1] = function(target) -- Border Kill (Recommended)
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = CFrame.new(99999, 99999, 99999)
        end
    end,
    [2] = function(target) -- Void Kill
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1000, 0)
        end
    end,
    [3] = function(target) -- Health Kill (Instant)
        if target.Character and target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Health = 0
        end
    end,
    [4] = function(target) -- Exploit Kill
        if target.Character then
            target.Character:BreakJoints()
        end
    end
}

-- ================================
-- UTILITY FUNCTIONS
-- ================================
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

-- ================================
-- PVP: GET TARGET (MULTIPLE MODES)
-- ================================
local function GetTarget()
    local hrp = GetHumanoidRootPart()
    if not hrp then return nil end
    
    local targets = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
            local targetHum = player.Character:FindFirstChild("Humanoid")
            if targetHrp and targetHum and targetHum.Health > 0 then
                local dist = (targetHrp.Position - hrp.Position).Magnitude
                table.insert(targets, {
                    Player = player,
                    Distance = dist,
                    Health = targetHum.Health,
                    MaxHealth = targetHum.MaxHealth
                })
            end
        end
    end
    
    if #targets == 0 then return nil end
    
    -- Target Mode Selection
    if Combat.TargetMode == 1 then -- Nearest
        table.sort(targets, function(a, b) return a.Distance < b.Distance end)
        return targets[1].Player
    elseif Combat.TargetMode == 2 then -- Lowest HP
        table.sort(targets, function(a, b) return a.Health < b.Health end)
        return targets[1].Player
    elseif Combat.TargetMode == 3 then -- Closest to Mouse
        local mouse = LocalPlayer:GetMouse()
        local camera = Workspace.CurrentCamera
        if not mouse or not camera then return targets[1].Player end
        
        local closestAngle = math.pi
        local closestTarget = nil
        
        for _, target in ipairs(targets) do
            local targetHrp = target.Player.Character.HumanoidRootPart
            local screenPos, onScreen = camera:WorldToScreenPoint(targetHrp.Position)
            if onScreen then
                local mousePos = Vector2.new(mouse.X, mouse.Y)
                local targetPos = Vector2.new(screenPos.X, screenPos.Y)
                local angle = (mousePos - targetPos).Magnitude
                if angle < closestAngle then
                    closestAngle = angle
                    closestTarget = target.Player
                end
            end
        end
        
        return closestTarget or targets[1].Player
    end
    
    return targets[1].Player
end

-- ================================
-- PVP: KILL AURA
-- ================================
local function KillAuraLoop()
    if not Combat.KillAura then return end
    
    local hrp = GetHumanoidRootPart()
    if not hrp then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
            if targetHrp then
                local dist = (targetHrp.Position - hrp.Position).Magnitude
                if dist < Combat.KillRange then
                    KillMethods[Combat.KillMethod](player)
                    Combat.Kills = Combat.Kills + 1
                end
            end
        end
    end
end

-- ================================
-- PVP: AIM ASSIST / FOV CIRCLE
-- ================================
local FOVCircle

local function CreateFOVCircle()
    if FOVCircle then FOVCircle:Destroy() end
    
    FOVCircle = Instance.new("Frame")
    FOVCircle.Size = UDim2.new(0, Combat.FOVSize * 2, 0, Combat.FOVSize * 2)
    FOVCircle.Position = UDim2.new(0.5, -Combat.FOVSize, 0.5, -Combat.FOVSize)
    FOVCircle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    FOVCircle.BackgroundTransparency = 0.85
    FOVCircle.BorderSizePixel = 2
    FOVCircle.BorderColor3 = Color3.fromRGB(255, 50, 50)
    FOVCircle.Visible = Combat.AimAssist
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
                    if distance < Combat.FOVSize then
                        return player
                    end
                end
            end
        end
    end
    
    return nil
end

-- ================================
-- PVP: AUTO SKILLS
-- ================================
local function AutoUseSkills(target)
    if not Combat.AutoSkills or not target then return end
    
    -- Find skill hotkeys (Z, X, C, V)
    local skills = {"Z", "X", "C", "V"}
    for _, skill in ipairs(skills) do
        VirtualInputManager:SendKeyEvent(true, skill, false, game)
        task.wait(Combat.SkillDelay)
        VirtualInputManager:SendKeyEvent(false, skill, false, game)
        task.wait(0.1)
    end
end

-- ================================
-- PVP: AUTO BLOCK
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
-- PVP: AUTO DODGE (Teleport Dodge)
-- ================================
local function AutoDodgeLoop()
    if not Combat.AutoDodge then return end
    
    local target = GetTarget()
    if target and target.Character then
        local hrp = GetHumanoidRootPart()
        local targetHrp = target.Character:FindFirstChild("HumanoidRootPart")
        if hrp and targetHrp then
            local direction = (hrp.Position - targetHrp.Position).Unit
            hrp.CFrame = hrp.CFrame + direction * 15
        end
    end
end

-- ================================
-- PVP: ANTI STUN
-- ================================
local function AntiStunLoop()
    if not Combat.AntiStun then return end
    
    local hum = GetHumanoid()
    if hum and hum:GetState() == Enum.HumanoidStateType.Stunned then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- ================================
-- PVP: TRIGGERBOT
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
-- MOVEMENT SYSTEMS
-- ================================
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
        FlyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        FlyBodyVelocity.Parent = hrp
        
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
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
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction + Vector3.new(0, -1, 0) end
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

-- ================================
-- ESP SYSTEM (PVP Focus)
-- ================================
local ESPObjects = {}

local function ClearESP()
    for _, obj in ipairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

local function CreateESP(target, color, name, health)
    if not target then return end
    
    if ESP.BoxESP then
        local box = Instance.new("BoxHandleAdornment")
        box.Size = Vector3.new(4, 6, 2)
        box.Color3 = color
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = target
        table.insert(ESPObjects, box)
    end
    
    if ESP.NameTags then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.AlwaysOnTop = true
        billboard.Parent = target
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = color
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
        
        if ESP.HealthBar then
            local healthBar = Instance.new("Frame")
            healthBar.Size = UDim2.new(health / 100, 0, 0, 5)
            healthBar.Position = UDim2.new(0, 0, 1, 2)
            healthBar.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            healthBar.Parent = billboard
        end
        
        table.insert(ESPObjects, billboard)
    end
    
    if ESP.Tracers then
        local tracer = Instance.new("SelectionBox")
        tracer.Adornee = target
        tracer.Color3 = color
        tracer.Parent = target
        table.insert(ESPObjects, tracer)
    end
end

local function UpdateESP()
    if not ESP.Enabled then
        ClearESP()
        return
    end
    
    ClearESP()
    
    if ESP.Players then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hum = player.Character:FindFirstChild("Humanoid")
                local health = hum and (hum.Health / hum.MaxHealth * 100) or 100
                local name = player.Name
                if ESP.Distance then
                    local hrp = GetHumanoidRootPart()
                    local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and targetHrp then
                        local dist = math.floor((hrp.Position - targetHrp.Position).Magnitude)
                        name = name .. " [" .. dist .. "m]"
                    end
                end
                CreateESP(player.Character, Color3.fromRGB(255, 50, 50), name, health)
            end
        end
    end
end

-- ================================
-- FRUIT RAIN SYSTEM (Secondary)
-- ================================
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
    
    if fruit.Rarity == "Mythical" then
        local particles = Instance.new("ParticleEmitter")
        particles.Rate = 15
        particles.Lifetime = NumberRange.new(0.8)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Color = ColorSequence.new(fruit.Color)
        particles.Parent = part
    end
    
    local startY = position.Y
    task.spawn(function()
        local t = 0
        while part and part.Parent do
            t = t + 0.05
            part.Position = Vector3.new(part.Position.X, startY + math.sin(t) * 0.5, part.Position.Z)
            task.wait()
        end
    end)
    
    if FruitRain.AutoCollect then
        task.spawn(function()
            while part and part.Parent do
                local hrp = GetHumanoidRootPart()
                if hrp and (hrp.Position - part.Position).Magnitude < 5 then
                    part:Destroy()
                    FruitRain.TotalCollected = FruitRain.TotalCollected + 1
                    FruitCounts[fruit.Name] = FruitCounts[fruit.Name] + 1
                    break
                end
                task.wait(0.1)
            end
        end)
    end
    
    task.wait(35)
    pcall(function() part:Destroy() end)
end

local function StartFruitRain()
    if FruitRainActive then return end
    FruitRainActive = true
    
    FruitRainConnection = RunService.Heartbeat:Connect(function()
        if not FruitRain.Enabled then
            FruitRainActive = false
            if FruitRainConnection then
                FruitRainConnection:Disconnect()
                FruitRainConnection = nil
            end
            return
        end
        
        if math.random(1, 28) == 1 then
            local availableFruits = Fruits
            if FruitRain.RareOnly then
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

-- ================================
-- MAIN PVP LOOP
-- ================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        -- PVP CORE
        KillAuraLoop()
        TriggerbotLoop()
        AutoBlockLoop()
        AutoDodgeLoop()
        AntiStunLoop()
        
        -- Auto Skills (uses target)
        if Combat.AutoSkills then
            local target = GetTarget()
            if target then
                AutoUseSkills(target)
            end
        end
        
        -- Aim Assist
        if Combat.AimAssist then
            local target = GetEnemyInFOV()
            if target and target.Character then
                local hrp = GetHumanoidRootPart()
                if hrp then
                    hrp.CFrame = CFrame.lookAt(hrp.Position, target.Character.HumanoidRootPart.Position)
                end
            end
        end
        
        -- Movement
        if Movement.SpeedEnabled then
            local hum = GetHumanoid()
            if hum then hum.WalkSpeed = Movement.SpeedValue end
        end
        
        if Movement.JumpEnabled then
            local hum = GetHumanoid()
            if hum then hum.JumpPower = Movement.JumpValue end
        end
        
        -- ESP
        if ESP.Enabled then
            UpdateESP()
        end
        
        -- Fruit Rain
        if FruitRain.Enabled and not FruitRainActive then
            StartFruitRain()
        end
    end)
end)

-- ================================
-- GUI CREATION (PVP Focus)
-- ================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FireHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Button
local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(0, 55, 0, 55)
MainButton.Position = UDim2.new(0, 12, 0.5, -27)
MainButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
MainButton.Text = "⚔️"
MainButton.TextSize = 30
MainButton.Font = Enum.Font.GothamBold
MainButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = MainButton

-- Main Menu
local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0, 380, 0, 550)
Menu.Position = UDim2.new(0.5, -190, 0.5, -275)
Menu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Menu.BackgroundTransparency = 0.05
Menu.Visible = false
Menu.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 12)
MenuCorner.Parent = Menu

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Title.Text = "⚔️ FIREHUB ULTIMATE - PVP EDITION ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = Menu

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Scrolling Frame
local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Size = UDim2.new(1, -10, 1, -55)
Scrolling.Position = UDim2.new(0, 5, 0, 50)
Scrolling.BackgroundTransparency = 1
Scrolling.ScrollBarThickness = 4
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
Scrolling.Parent = Menu

local yPos = 5

-- UI Helper Functions
local function AddSection(text)
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(1, -10, 0, 30)
    section.Position = UDim2.new(0, 5, 0, yPos)
    section.BackgroundTransparency = 1
    section.Text = text
    section.TextColor3 = Color3.fromRGB(255, 80, 80)
    section.TextSize = 16
    section.Font = Enum.Font.GothamBold
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.Parent = Scrolling
    yPos = yPos + 35
end

local function AddToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 42)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.Parent = Scrolling
    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    Instance.new("UICorner").Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 30)
    btn.Position = UDim2.new(1, -70, 0.5, -15)
    btn.BackgroundColor3 = default and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(255, 80, 80)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
    Instance.new("UICorner").Parent = btn
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(255, 80, 80)
        btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
    
    yPos = yPos + 47
    return function() return state end
end

local function AddSlider(text, min, max, default, suffix, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.Parent = Scrolling
    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    Instance.new("UICorner").Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 12, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default .. suffix
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -40, 0, 4)
    track.Position = UDim2.new(0, 20, 0, 40)
    track.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    track.Parent = frame
    Instance.new("UICorner").CornerRadius = UDim.new(1, 0)
    Instance.new("UICorner").Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    fill.Parent = track
    Instance.new("UICorner").CornerRadius = UDim.new(1, 0)
    Instance.new("UICorner").Parent = fill
    
    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(1, 0, 1, 0)
    drag.BackgroundTransparency = 1
    drag.Text = ""
    drag.Parent = track
    
    local dragging, value = false, default
    drag.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mouse = UserInputService:GetMouseLocation()
            local pos = track.AbsolutePosition
            local percent = math.clamp((mouse.X - pos.X) / track.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max - min) * percent)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            label.Text = text .. ": " .. value .. suffix
            callback(value)
        end
    end)
    
    yPos = yPos + 65
    return value
end

local function AddDropdown(text, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 48)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.Parent = Scrolling
    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    Instance.new("UICorner").Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 32)
    btn.Position = UDim2.new(1, -152, 0.5, -16)
    btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    btn.Text = options[default]
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
    Instance.new("UICorner").Parent = btn
    
    local idx = default
    btn.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        btn.Text = options[idx]
        callback(idx, options[idx])
    end)
    
    yPos = yPos + 53
end

-- ================================
-- BUILD PVP-FOCUSED UI
-- ================================

-- PVP Section
AddSection("⚔️ PVP / COMBAT (PRIORITY)")

AddToggle("Kill Aura", Combat.KillAura, function(v) Combat.KillAura = v end)
AddSlider("Kill Range", 20, 100, Combat.KillRange, " studs", function(v) Combat.KillRange = v end)
AddDropdown("Kill Method", {"Border Kill", "Void Kill", "Health Kill", "Exploit Kill"}, Combat.KillMethod, function(i, v) Combat.KillMethod = i end)

AddSection("🎯 AIM ASSIST")
AddToggle("Aim Assist (FOV)", Combat.AimAssist, function(v) 
    Combat.AimAssist = v 
    if FOVCircle then FOVCircle.Visible = v end
end)
AddSlider("FOV Size", 50, 300, Combat.FOVSize, " px", function(v) 
    Combat.FOVSize = v 
    if FOVCircle then 
        FOVCircle.Size = UDim2.new(0, v * 2, 0, v * 2)
        FOVCircle.Position = UDim2.new(0.5, -v, 0.5, -v)
    end
end)
AddToggle("Triggerbot", Combat.Triggerbot, function(v) Combat.Triggerbot = v end)

AddSection("🎮 COMBAT UTILITIES")
AddToggle("Auto Skills (Z,X,C,V)", Combat.AutoSkills, function(v) Combat.AutoSkills = v end)
AddSlider("Skill Delay", 0.1, 1.5, Combat.SkillDelay, "s", function(v) Combat.SkillDelay = v end)
AddToggle("Auto Block", Combat.AutoBlock, function(v) Combat.AutoBlock = v end)
AddToggle("Auto Dodge", Combat.AutoDodge, function(v) Combat.AutoDodge = v end)
AddToggle("Anti Stun", Combat.AntiStun, function(v) Combat.AntiStun = v end)

AddSection("🎯 TARGETING")
AddDropdown("Target Mode", {"Nearest Player", "Lowest HP", "Closest to Mouse"}, Combat.TargetMode, function(i, v) Combat.TargetMode = i end)

-- ESP Section
AddSection("👁️ ESP")
AddToggle("ESP Master", ESP.Enabled, function(v) ESP.Enabled = v end)
AddToggle("Player ESP", ESP.Players, function(v) ESP.Players = v end)
AddToggle("Name Tags", ESP.NameTags, function(v) ESP.NameTags = v end)
AddToggle("Health Bar", ESP.HealthBar, function(v) ESP.HealthBar = v end)
AddToggle("Show Distance", ESP.Distance, function(v) ESP.Distance = v end)

-- Movement Section
AddSection("🏃 MOVEMENT")
AddToggle("Speed Modifier", Movement.SpeedEnabled, function(v) Movement.SpeedEnabled = v end)
AddSlider("Walkspeed", 16, 200, Movement.SpeedValue, "", function(v) 
    Movement.SpeedValue = v 
    if Movement.SpeedEnabled then
        local hum = GetHumanoid()
        if hum then hum.WalkSpeed = v end
    end
end)
AddToggle("Fly Mode", Movement.FlyEnabled, function(v) Movement.FlyEnabled = v ToggleFly(v) end)
AddToggle("Noclip", Movement.NoclipEnabled, function(v) Movement.NoclipEnabled = v ToggleNoclip(v) end)

-- Fruit Rain Section (Secondary)
AddSection("🌧️ FRUIT RAIN 2026")
AddToggle("Fruit Rain", FruitRain.Enabled, function(v) FruitRain.Enabled = v end)
AddToggle("Auto Collect", FruitRain.AutoCollect, function(v) FruitRain.AutoCollect = v end)
AddToggle("Rare Only", FruitRain.RareOnly, function(v) FruitRain.RareOnly = v end)

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.9, 0, 0, 45)
CloseButton.Position = UDim2.new(0.05, 0, 0, yPos)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Text = "CLOSE MENU"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Scrolling
Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
Instance.new("UICorner").Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    Menu.Visible = false
end)

yPos = yPos + 50
Scrolling.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)

-- Toggle Menu
MainButton.MouseButton1Click:Connect(function()
    Menu.Visible = not Menu.Visible
end)

-- Create FOV Circle
CreateFOVCircle()

-- Success Message
print("⚔️ FIREHUB ULTIMATE - PVP EDITION LOADED ⚔️")
print("🎯 Kill Aura | Aim Assist | Auto Skills | ESP")
print("🌧️ Fruit Rain 2026 - All 45 Fruits")
print("🔥 Press the ⚔️ button to open menu")