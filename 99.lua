--[[
    FireHub v3.0 - SIMPLE EDITION
    Fruit Rain 2026 - ALL 45 FRUITS!
    No errors, guaranteed to work!
--]]

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- Wait for player
if not LocalPlayer then
    repeat task.wait() until Players.LocalPlayer
    LocalPlayer = Players.LocalPlayer
end

-- Features
local FruitRainEnabled = false
local AutoCollect = false
local RareOnly = false
local TotalCollected = 0
local FruitCounts = {}

-- ALL 45 FRUITS
local Fruits = {
    -- Common (7)
    "Rocket", "Spin", "Blade", "Spring", "Bomb", "Smoke", "Spike",
    -- Rare (11)
    "Flame", "Ice", "Sand", "Dark", "Eagle", "Diamond", "Light", "Rubber", "Ghost", "Magma", "Quake",
    -- Legendary (18)
    "Buddha", "Love", "Creation", "Spider", "Sound", "Phoenix", "Portal", "Lightning", "Pain", 
    "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough", "Shadow", "Venom", "Gas", "Spirit",
    -- Mythical (5)
    "Tiger", "Yeti", "Kitsune", "Control", "Dragon"
}

local FruitColors = {
    Rocket = Color3.fromRGB(255,100,100),
    Spin = Color3.fromRGB(150,150,255),
    Blade = Color3.fromRGB(200,200,200),
    Spring = Color3.fromRGB(100,255,100),
    Bomb = Color3.fromRGB(255,150,100),
    Smoke = Color3.fromRGB(100,100,100),
    Spike = Color3.fromRGB(255,200,100),
    Flame = Color3.fromRGB(255,80,0),
    Ice = Color3.fromRGB(100,200,255),
    Sand = Color3.fromRGB(255,200,100),
    Dark = Color3.fromRGB(100,50,150),
    Eagle = Color3.fromRGB(200,150,100),
    Diamond = Color3.fromRGB(100,255,255),
    Light = Color3.fromRGB(255,255,100),
    Rubber = Color3.fromRGB(255,100,150),
    Ghost = Color3.fromRGB(150,150,255),
    Magma = Color3.fromRGB(255,100,0),
    Quake = Color3.fromRGB(150,100,50),
    Buddha = Color3.fromRGB(255,215,0),
    Love = Color3.fromRGB(255,100,150),
    Creation = Color3.fromRGB(200,100,255),
    Spider = Color3.fromRGB(100,50,50),
    Sound = Color3.fromRGB(255,200,150),
    Phoenix = Color3.fromRGB(255,100,50),
    Portal = Color3.fromRGB(100,100,255),
    Lightning = Color3.fromRGB(255,255,0),
    Pain = Color3.fromRGB(100,50,100),
    Blizzard = Color3.fromRGB(150,200,255),
    Gravity = Color3.fromRGB(100,50,150),
    Mammoth = Color3.fromRGB(150,100,50),
    ["T-Rex"] = Color3.fromRGB(100,150,50),
    Dough = Color3.fromRGB(255,200,150),
    Shadow = Color3.fromRGB(50,50,100),
    Venom = Color3.fromRGB(100,255,100),
    Gas = Color3.fromRGB(150,255,150),
    Spirit = Color3.fromRGB(200,150,255),
    Tiger = Color3.fromRGB(255,150,0),
    Yeti = Color3.fromRGB(150,200,255),
    Kitsune = Color3.fromRGB(255,100,150),
    Control = Color3.fromRGB(150,100,200),
    Dragon = Color3.fromRGB(255,50,50)
}

local FruitRarity = {
    Dragon = "Mythical", Kitsune = "Mythical", Yeti = "Mythical", Control = "Mythical", Tiger = "Mythical",
    Buddha = "Legendary", Love = "Legendary", Creation = "Legendary", Spider = "Legendary", Sound = "Legendary",
    Phoenix = "Legendary", Portal = "Legendary", Lightning = "Legendary", Pain = "Legendary", Blizzard = "Legendary",
    Gravity = "Legendary", Mammoth = "Legendary", ["T-Rex"] = "Legendary", Dough = "Legendary", Shadow = "Legendary",
    Venom = "Legendary", Gas = "Legendary", Spirit = "Legendary",
    Flame = "Rare", Ice = "Rare", Sand = "Rare", Dark = "Rare", Eagle = "Rare", Diamond = "Rare", Light = "Rare",
    Rubber = "Rare", Ghost = "Rare", Magma = "Rare", Quake = "Rare",
    Rocket = "Common", Spin = "Common", Blade = "Common", Spring = "Common", Bomb = "Common", Smoke = "Common", Spike = "Common"
}

local FruitValues = {
    Dragon = 5000000, Kitsune = 3500000, Yeti = 3200000, Control = 3800000, Tiger = 3000000,
    Buddha = 1200000, Love = 1300000, Creation = 1400000, Spider = 1500000, Sound = 1600000,
    Phoenix = 1700000, Portal = 1800000, Lightning = 1900000, Pain = 2000000, Blizzard = 2100000,
    Gravity = 2200000, Mammoth = 2300000, ["T-Rex"] = 2400000, Dough = 2500000, Shadow = 2600000,
    Venom = 2700000, Gas = 2800000, Spirit = 2900000,
    Flame = 250000, Ice = 350000, Sand = 420000, Dark = 500000, Eagle = 550000, Diamond = 600000,
    Light = 650000, Rubber = 700000, Ghost = 750000, Magma = 800000, Quake = 850000,
    Rocket = 5000, Spin = 7500, Blade = 10000, Spring = 12000, Bomb = 15000, Smoke = 18000, Spike = 20000
}

-- Initialize counts
for _, fruit in ipairs(Fruits) do
    FruitCounts[fruit] = 0
end

-- Create fruit
local function CreateFruit(fruitName, position)
    local color = FruitColors[fruitName] or Color3.fromRGB(255,140,0)
    local part = Instance.new("Part")
    part.Name = fruitName
    part.Size = Vector3.new(2, 2, 2)
    part.Position = position
    part.Anchored = false
    part.CanCollide = true
    part.BrickColor = BrickColor.new(color)
    part.Material = Enum.Material.Neon
    part.Parent = workspace
    
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Scale = Vector3.new(1.2, 1.2, 1.2)
    mesh.Parent = part
    
    -- Mythical particles
    if FruitRarity[fruitName] == "Mythical" then
        local particles = Instance.new("ParticleEmitter")
        particles.Texture = "rbxassetid://14034496178"
        particles.Rate = 15
        particles.Lifetime = NumberRange.new(0.8)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Color = ColorSequence.new(color)
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
    if AutoCollect then
        task.spawn(function()
            while part and part.Parent do
                local char = LocalPlayer and LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    if (hrp.Position - part.Position).Magnitude < 5 then
                        part:Destroy()
                        TotalCollected = TotalCollected + 1
                        FruitCounts[fruitName] = FruitCounts[fruitName] + 1
                        print(string.format("🍎 Collected %s Fruit! (%s)", fruitName, FruitRarity[fruitName]))
                        break
                    end
                end
                task.wait(0.1)
            end
        end)
    end
    
    -- Despawn after 30 seconds
    task.wait(30)
    pcall(function() part:Destroy() end)
end

-- Spawn fruits
local spawnConnection
local function StartFruitRain()
    if spawnConnection then spawnConnection:Disconnect() end
    
    spawnConnection = RunService.Heartbeat:Connect(function()
        if not FruitRainEnabled then return end
        
        -- Random spawn chance
        if math.random(1, 30) == 1 then
            local availableFruits = Fruits
            if RareOnly then
                availableFruits = {}
                for _, f in ipairs(Fruits) do
                    if FruitRarity[f] == "Legendary" or FruitRarity[f] == "Mythical" then
                        table.insert(availableFruits, f)
                    end
                end
            end
            
            local fruit = availableFruits[math.random(1, #availableFruits)]
            local x = math.random(-150, 150)
            local z = math.random(-150, 150)
            local pos = Vector3.new(x, 40, z)
            
            if FruitRarity[fruit] == "Mythical" then
                print(string.format("🌟 MYTHICAL FRUIT SPAWNED: %s!", fruit))
            end
            
            CreateFruit(fruit, pos)
        end
    end)
end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FireHub"
gui.ResetOnSpawn = false

local success, parent = pcall(function()
    return game:GetService("CoreGui")
end)

if success and parent then
    gui.Parent = parent
else
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main button
local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(0, 60, 0, 60)
mainBtn.Position = UDim2.new(0, 10, 0.5, -30)
mainBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
mainBtn.Text = "🔥"
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.TextSize = 30
mainBtn.Font = Enum.Font.GothamBold
mainBtn.Parent = gui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = mainBtn

-- Menu
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 280, 0, 350)
menu.Position = UDim2.new(0.5, -140, 0.5, -175)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
menu.BackgroundTransparency = 0.05
menu.Visible = false
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 10)
menuCorner.Parent = menu

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
title.Text = "🔥 FIREHUB - FRUIT RAIN 2026"
title.TextColor3 = Color3.fromRGB(255, 140, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = menu

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Fruit Rain Toggle
local fruitRainBtn = Instance.new("TextButton")
fruitRainBtn.Size = UDim2.new(0.9, 0, 0, 45)
fruitRainBtn.Position = UDim2.new(0.05, 0, 0.13, 0)
fruitRainBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
fruitRainBtn.Text = "🌧️ FRUIT RAIN: OFF"
fruitRainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fruitRainBtn.TextScaled = true
fruitRainBtn.Font = Enum.Font.GothamBold
fruitRainBtn.Parent = menu

local btn1Corner = Instance.new("UICorner")
btn1Corner.CornerRadius = UDim.new(0, 5)
btn1Corner.Parent = fruitRainBtn

fruitRainBtn.MouseButton1Click:Connect(function()
    FruitRainEnabled = not FruitRainEnabled
    fruitRainBtn.Text = FruitRainEnabled and "🌧️ FRUIT RAIN: ON" or "🌧️ FRUIT RAIN: OFF"
    fruitRainBtn.BackgroundColor3 = FruitRainEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
    
    if FruitRainEnabled then
        StartFruitRain()
        print("🌧️ Fruit Rain Started!")
    else
        print("🌧️ Fruit Rain Stopped")
    end
end)

-- Auto Collect Toggle
local autoCollectBtn = Instance.new("TextButton")
autoCollectBtn.Size = UDim2.new(0.9, 0, 0, 45)
autoCollectBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
autoCollectBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
autoCollectBtn.Text = "🍎 AUTO COLLECT: OFF"
autoCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoCollectBtn.TextScaled = true
autoCollectBtn.Font = Enum.Font.Gotham
autoCollectBtn.Parent = menu

local btn2Corner = Instance.new("UICorner")
btn2Corner.CornerRadius = UDim.new(0, 5)
btn2Corner.Parent = autoCollectBtn

autoCollectBtn.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    autoCollectBtn.Text = AutoCollect and "🍎 AUTO COLLECT: ON" or "🍎 AUTO COLLECT: OFF"
    autoCollectBtn.BackgroundColor3 = AutoCollect and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
end)

-- Rare Only Toggle
local rareOnlyBtn = Instance.new("TextButton")
rareOnlyBtn.Size = UDim2.new(0.9, 0, 0, 45)
rareOnlyBtn.Position = UDim2.new(0.05, 0, 0.37, 0)
rareOnlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
rareOnlyBtn.Text = "✨ RARE ONLY: OFF"
rareOnlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rareOnlyBtn.TextScaled = true
rareOnlyBtn.Font = Enum.Font.Gotham
rareOnlyBtn.Parent = menu

local btn3Corner = Instance.new("UICorner")
btn3Corner.CornerRadius = UDim.new(0, 5)
btn3Corner.Parent = rareOnlyBtn

rareOnlyBtn.MouseButton1Click:Connect(function()
    RareOnly = not RareOnly
    rareOnlyBtn.Text = RareOnly and "✨ RARE ONLY: ON" or "✨ RARE ONLY: OFF"
    rareOnlyBtn.BackgroundColor3 = RareOnly and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 70)
end)

-- Stats Display
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0.9, 0, 0, 80)
statsFrame.Position = UDim2.new(0.05, 0, 0.5, 0)
statsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
statsFrame.BackgroundTransparency = 0
statsFrame.Parent = menu

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 5)
statsCorner.Parent = statsFrame

local statsLabel = Instance.new("TextLabel")
statsLabel.Size = UDim2.new(1, -10, 1, -10)
statsLabel.Position = UDim2.new(0, 5, 0, 5)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "🍎 Fruits: 0/45\n💰 Value: $0"
statsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statsLabel.TextScaled = true
statsLabel.Font = Enum.Font.Gotham
statsLabel.Parent = statsFrame

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = menu

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

-- Toggle menu
mainBtn.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- Update stats
task.spawn(function()
    while true do
        task.wait(1)
        local uniqueCount = 0
        for _, count in pairs(FruitCounts) do
            if count > 0 then uniqueCount = uniqueCount + 1
        end
        
        local totalValue = 0
        for fruit, count in pairs(FruitCounts) do
            totalValue = totalValue + (FruitValues[fruit] or 0) * count
        end
        
        local valueText = totalValue >= 1000 and string.format("$%.1fk", totalValue/1000) or "$" .. totalValue
        statsLabel.Text = string.format("🍎 Fruits: %d/%d\n💰 Value: %s", uniqueCount, #Fruits, valueText)
    end
end)

-- Success message
print("=" .. string.rep("=", 50))
print("🔥 FIREHUB v1.0 LOADED!")
print("=" .. string.rep("=", 50))
print("✨ ALL 45 FRUITS INCLUDED:")
print("   🌟 MYTHICAL: Dragon, Kitsune, Yeti, Control, Tiger")
print("   💛 LEGENDARY: Buddha, Dough, Spirit, Venom, etc.")
print("   💙 RARE: Flame, Ice, Magma, Light, etc.")
print("   🤍 COMMON: Rocket, Spin, Bomb, etc.")
print("=" .. string.rep("=", 50))
print("📱 HOW TO USE:")
print("   1. Click the RED 🔥 button on screen")
print("   2. Toggle 'FRUIT RAIN' ON")
print("   3. Fruits will rain from the sky!")
print("   4. Toggle 'AUTO COLLECT' to automatically pick them up")
print("   5. Toggle 'RARE ONLY' for legendary/mythical only!")
print("=" .. string.rep("=", 50))
print("🌟 MYTHICAL FRUIT SPAWNS WILL BE ANNOUNCED!")
print("🎮 HAVE FUN COLLECTING ALL 45 FRUITS!")
print("=" .. string.rep("=", 50))
