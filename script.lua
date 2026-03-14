local gameId = 2753915549
if game.GameId ~= gameId then return end

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local isMobile = UserInputService.TouchEnabled
local fontSize = isMobile and 18 or 14

local Features = {
    Aimbot = false,
    SilentAim = false,
    Triggerbot = false,
    AntiBan = false,
    AimFOV = 100,
    AimFOVEnabled = false,
    SkillAimPVP = false,
    M1AimPVP = false,
    AutoFarm = false,
    AutoClick = false,
    AutoCollect = false,
    AutoQuest = false,
    SkillAimPVE = false,
    M1AimPVE = false,
    NPCAim = false,
    InfiniteYield = false,
    Fly = false,
    NoClip = false,
    ESP = false,
    Walkspeed = 16,
    JumpPower = 50,
    PredictionAim = false,
    AutoCombo = false,
    TargetPlayer = nil,
    AntiKB = false,
    KillAura = false,
    AutoBoss = false,
    AutoChest = false,
    AutoMaterial = false,
    AutoSecondSea = false,
    AutoThirdSea = false,
    AutoBartilo = false,
    AutoDonSwan = false,
    AutoSaber = false,
    ClickTP = false,
    SpeedHack = false,
    AutoDodge = false,
    InstantTP = false,
    AutoStore = false,
    AutoEquip = false,
    AutoAwaken = false,
    BonesFarm = false,
    FragmentsFarm = false,
    PlayerCounter = false,
    FruitTimer = false,
    RaidTimer = false,
    AntiAfk = false,
    AutoRejoin = false,
    SafeMode = false,
    FPSBoost = false,
    DevilFruitSniper = false,
    RaidFarm = false,
    SeaEvents = false,
    StatLoader = false,
    Theme = "Orange",
    Keybinds = {},
    ConfigName = "Default"
}

local function SafeGetCharacter(player)
    local success, character = pcall(function()
        return player and player.Character
    end)
    return success and character or nil
end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 60
FOVCircle.Radius = 100
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(255, 140, 0)
FOVCircle.Transparency = 1

local ThemeColors = {
    Orange = Color3.fromRGB(255, 140, 0),
    Red = Color3.fromRGB(255, 50, 50),
    Blue = Color3.fromRGB(50, 150, 255),
    Green = Color3.fromRGB(50, 255, 50),
    Purple = Color3.fromRGB(150, 50, 255),
    Pink = Color3.fromRGB(255, 50, 150)
}

local function CreateFireHubGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FireHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:FindFirstChild("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") or Instance.new("ScreenGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = isMobile and UDim2.new(0, 360, 0, 600) or UDim2.new(0, 650, 0, 500)
    MainFrame.Position = UDim2.new(0.5, isMobile and -180 or -325, 0.5, isMobile and -300 or -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, isMobile and 50 or 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, isMobile and 250 or 300, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 FireHub By FirePlayz 🔥"
    Title.TextColor3 = Color3.fromRGB(255, 140, 0)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Size = UDim2.new(0, isMobile and 45 or 35, 0, isMobile and 45 or 35)
    MinimizeBtn.Position = UDim2.new(1, isMobile and -50 or -40, 0, 7)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextScaled = true
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Parent = TopBar

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = MinimizeBtn

    local TabFrame = Instance.new("Frame")
    TabFrame.Name = "TabFrame"
    TabFrame.Size = UDim2.new(1, 0, 0, isMobile and 60 or 50)
    TabFrame.Position = UDim2.new(0, 0, 0, isMobile and 50 or 45)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabFrame.BorderSizePixel = 0
    TabFrame.Parent = MainFrame

    local TabScrolling = Instance.new("ScrollingFrame")
    TabScrolling.Size = UDim2.new(1, 0, 1, 0)
    TabScrolling.BackgroundTransparency = 1
    TabScrolling.BorderSizePixel = 0
    TabScrolling.ScrollBarThickness = isMobile and 3 or 5
    TabScrolling.CanvasSize = UDim2.new(3, 0, 0, 0)
    TabScrolling.Parent = TabFrame

    local Tabs = {"HOME", "PVP", "PVE", "BOSS", "MOVEMENT", "FARM", "MISC", "ESP", "SETTINGS"}
    local TabButtons = {}

    for i, tabName in ipairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = tabName .. "Btn"
        TabBtn.Size = UDim2.new(0, isMobile and 85 or 75, 0, isMobile and 45 or 40)
        TabBtn.Position = UDim2.new(0, 5 + ((i-1) * (isMobile and 90 or 80)), 0, isMobile and 7 or 5)
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

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -20, 1, isMobile and -160 or -140)
    ContentFrame.Position = UDim2.new(0, 10, 0, isMobile and 115 or 100)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame

    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentFrame

    return ScreenGui, TabButtons, ContentFrame, MainFrame, MinimizeBtn
end

local function CreateFloatingIcon(mainFrame)
    local IconGui = Instance.new("ScreenGui")
    IconGui.Name = "FireHubIcon"
    IconGui.ResetOnSpawn = false
    IconGui.Parent = game:FindFirstChild("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

    local IconFrame = Instance.new("Frame")
    IconFrame.Name = "IconFrame"
    IconFrame.Size = UDim2.new(0, isMobile and 70 or 60, 0, isMobile and 70 or 60)
    IconFrame.Position = UDim2.new(0, 10, 0.5, -35)
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

    IconFrame.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        IconFrame.Visible = false
    end)

    return IconGui, IconFrame
end

local function CreateToggle(parent, position, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, isMobile and 60 or 50)
    ToggleFrame.Position = position
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0, isMobile and 180 or 210, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = fontSize
    ToggleLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, isMobile and 75 or 60, 0, isMobile and 45 or 40)
    ToggleBtn.Position = UDim2.new(1, isMobile and -85 or -70, 0, isMobile and 7 or 5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = fontSize
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = ToggleBtn

    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 255, 100)}):Play()
            ToggleBtn.Text = "ON"
        else
            TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
            ToggleBtn.Text = "OFF"
        end
        pcall(function() callback(enabled) end)
    end)

    return ToggleBtn
end

local function CreateSlider(parent, position, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -20, 0, isMobile and 85 or 70)
    SliderFrame.Position = position
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 5)
    SliderCorner.Parent = SliderFrame

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -20, 0, 25)
    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextSize = fontSize
    SliderLabel.Parent = SliderFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, -40, 0, isMobile and 18 or 15)
    Slider.Position = UDim2.new(0, 20, 0, isMobile and 45 or 40)
    Slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Slider.BorderSizePixel = 0
    Slider.Parent = SliderFrame

    local SliderCorner2 = Instance.new("UICorner")
    SliderCorner2.CornerRadius = UDim.new(1, 0)
    SliderCorner2.Parent = Slider

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
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
            local success, mousePos = pcall(function()
                return UserInputService:GetMouseLocation()
            end)
            if success then
                local absPos = Slider.AbsolutePosition
                local relativeX = math.clamp(mousePos.X - absPos.X, 0, Slider.AbsoluteSize.X)
                local percent = relativeX / Slider.AbsoluteSize.X
                local value = min + (max - min) * percent
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                SliderLabel.Text = text .. ": " .. math.floor(value)
                pcall(function() callback(value) end)
            end
        end
    end)
end

local function CreateButton(parent, position, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -20, 0, isMobile and 55 or 50)
    Btn.Position = position
    Btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = fontSize
    Btn.BorderSizePixel = 0
    Btn.Parent = parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

local function GetClosestTarget(type)
    local closest = nil
    local shortestDistance = Features.AimFOV
    
    if type == "player" or type == "both" then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local success, char = pcall(function()
                    return player.Character
                end)
                if success and char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local humanoid = char:FindFirstChild("Humanoid")
                    if hrp and humanoid and humanoid.Health > 0 then
                        local success2, pos = pcall(function()
                            return Camera:WorldToScreenPoint(hrp.Position)
                        end)
                        if success2 and pos then
                            local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                            if pos.Z > 0 and distance < shortestDistance then
                                closest = hrp
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    
    if type == "npc" or type == "both" then
        local success, npcs = pcall(function()
            return Workspace:GetDescendants()
        end)
        if success then
            for _, npc in ipairs(npcs) do
                if npc:IsA("Model") then
                    local hrp = npc:FindFirstChild("HumanoidRootPart")
                    local humanoid = npc:FindFirstChild("Humanoid")
                    if hrp and humanoid and humanoid.Health > 0 and not Players:GetPlayerFromCharacter(npc) then
                        local success2, pos = pcall(function()
                            return Camera:WorldToScreenPoint(hrp.Position)
                        end)
                        if success2 and pos then
                            local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                            if pos.Z > 0 and distance < shortestDistance then
                                closest = hrp
                                shortestDistance = distance
                            end
                        end
                    end
                end
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
    
    local success, npcs = pcall(function()
        return Workspace:GetDescendants()
    end)
    
    if success then
        for _, npc in ipairs(npcs) do
            if npc:IsA("Model") then
                local npcHrp = npc:FindFirstChild("HumanoidRootPart")
                local humanoid = npc:FindFirstChild("Humanoid")
                if npcHrp and humanoid and humanoid.Health > 0 and not Players:GetPlayerFromCharacter(npc) then
                    local mag = (npcHrp.Position - hrp.Position).Magnitude
                    if mag < dist then
                        dist = mag
                        closest = npcHrp
                    end
                end
            end
        end
    end
    
    return closest
end

local function GetNearestPlayer()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest = nil
    local dist = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local success, char = pcall(function()
                return player.Character
            end)
            if success and char then
                local pHrp = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                if pHrp and humanoid and humanoid.Health > 0 then
                    local mag = (pHrp.Position - hrp.Position).Magnitude
                    if mag < dist then
                        dist = mag
                        closest = pHrp
                    end
                end
            end
        end
    end
    
    return closest
end

local function GetNearestBoss()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local bosses = {
        "Saber Expert", "Boss", "Don Swan", "Greybeard", "Diamond", "Jeremy",
        "Fajita", "Order", "Lady", "Beautiful Pirate", "Bob", "Tony Tony Chopper"
    }
    
    local closest = nil
    local dist = math.huge
    
    local success, npcs = pcall(function()
        return Workspace:GetDescendants()
    end)
    
    if success then
        for _, npc in ipairs(npcs) do
            if npc:IsA("Model") then
                local npcHrp = npc:FindFirstChild("HumanoidRootPart")
                local humanoid = npc:FindFirstChild("Humanoid")
                if npcHrp and humanoid and humanoid.Health > 0 and not Players:GetPlayerFromCharacter(npc) then
                    for _, bossName in ipairs(bosses) do
                        if npc.Name:find(bossName) then
                            local mag = (npcHrp.Position - hrp.Position).Magnitude
                            if mag < dist then
                                dist = mag
                                closest = npcHrp
                            end
                            break
                        end
                    end
                end
            end
        end
    end
    
    return closest
end

local function GetNearestChest()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest = nil
    local dist = math.huge
    
    local success, parts = pcall(function()
        return Workspace:GetDescendants()
    end)
    
    if success then
        for _, part in ipairs(parts) do
            if part:IsA("Part") and part.Name:find("Chest") then
                local mag = (part.Position - hrp.Position).Magnitude
                if mag < dist then
                    dist = mag
                    closest = part
                end
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
    
    local success, parts = pcall(function()
        return Workspace:GetDescendants()
    end)
    
    if success then
        for _, part in ipairs(parts) do
            if part:IsA("Part") and (part.Name:find("Fruit") or part.Name:find("Apple")) then
                local mag = (part.Position - hrp.Position).Magnitude
                if mag < dist then
                    dist = mag
                    closest = part
                end
            end
        end
    end
    
    return closest
end

local function GetNearestMaterial()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local materials = {"Scrap", "Metal", "Wood", "Bone", "Fragment", "Magma Ore", "Fish Tail"}
    local closest = nil
    local dist = math.huge
    
    local success, parts = pcall(function()
        return Workspace:GetDescendants()
    end)
    
    if success then
        for _, part in ipairs(parts) do
            if part:IsA("Part") then
                for _, matName in ipairs(materials) do
                    if part.Name:find(matName) then
                        local mag = (part.Position - hrp.Position).Magnitude
                        if mag < dist then
                            dist = mag
                            closest = part
                        end
                        break
                    end
                end
            end
        end
    end
    
    return closest
end

local ScreenGui, TabButtons, ContentFrame, MainFrame, MinimizeBtn = CreateFireHubGUI()
local IconGui, IconFrame = CreateFloatingIcon(MainFrame)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconFrame.Visible = true
end)

RunService.RenderStepped:Connect(function()
    if Features.AimFOVEnabled and Features.AimFOV > 0 then
        FOVCircle.Visible = true
        FOVCircle.Radius = Features.AimFOV
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        FOVCircle.Visible = false
    end
    
    if Features.PlayerCounter then
        -- Will be displayed in UI
    end
end)

RunService.Heartbeat:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not hrp or not humanoid then return end
    
    if Features.AntiAfk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new())
    end
    
    if Features.SpeedHack and Features.Walkspeed > 16 then
        humanoid.WalkSpeed = Features.Walkspeed
    end
    
    if Features.Fly then
        -- Fly logic
    end
    
    if Features.NoClip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("Part") then
                part.CanCollide = false
            end
        end
    end
    
    if Features.AutoFarm or Features.AutoBoss then
        local target = nil
        if Features.AutoBoss then
            target = GetNearestBoss()
        elseif Features.AutoFarm then
            target = GetNearestNPC()
        end
        
        if target then
            hrp.CFrame = CFrame.lookAt(hrp.Position, target.Position)
            local dist = (target.Position - hrp.Position).Magnitude
            if dist < 20 then
                VirtualUser:ClickButton1(Vector2.new())
                if Features.AutoClick then
                    wait(0.1)
                    VirtualUser:ClickButton1(Vector2.new())
                end
            else
                local tween = TweenService:Create(hrp, TweenInfo.new(dist/50), {CFrame = target.CFrame * CFrame.new(0, 0, -5)})
                tween:Play()
            end
        end
    end
    
    if Features.AutoChest then
        local chest = GetNearestChest()
        if chest then
            local dist = (chest.Position - hrp.Position).Magnitude
            if dist < 15 then
                fireproximityprompt(chest:FindFirstChildOfClass("ProximityPrompt"))
            else
                hrp.CFrame = CFrame.new(chest.Position)
            end
        end
    end
    
    if Features.AutoMaterial then
        local mat = GetNearestMaterial()
        if mat then
            local dist = (mat.Position - hrp.Position).Magnitude
            if dist < 10 then
                fireproximityprompt(mat:FindFirstChildOfClass("ProximityPrompt"))
            else
                hrp.CFrame = CFrame.new(mat.Position)
            end
        end
    end
    
    if Features.DevilFruitSniper then
        local fruit = GetNearestFruit()
        if fruit then
            local dist = (fruit.Position - hrp.Position).Magnitude
            if dist < 10 then
                fireproximityprompt(fruit:FindFirstChildOfClass("ProximityPrompt"))
            else
                hrp.CFrame = CFrame.new(fruit.Position)
            end
        end
    end
    
    if Features.KillAura then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local pChar = player.Character
                if pChar and pChar:FindFirstChild("HumanoidRootPart") and pChar:FindFirstChild("Humanoid") then
                    local dist = (pChar.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if dist < 20 then
                        pChar.Humanoid.Health = 0
                    end
                end
            end
        end
    end
    
    if Features.SkillAimPVP then
        local target = GetClosestTarget("player")
        if target then
            hrp.CFrame = CFrame.lookAt(hrp.Position, target.Position)
        end
    end
    
    if Features.SkillAimPVE or Features.NPCAim then
        local target = GetClosestTarget("npc")
        if target then
            hrp.CFrame = CFrame.lookAt(hrp.Position, target.Position)
        end
    end
    
    if Features.Triggerbot then
        local target = GetClosestTarget("both")
        if target then
            VirtualUser:ClickButton1(Vector2.new())
        end
    end
    
    if Features.ClickTP and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local mouse = LocalPlayer:GetMouse()
        if mouse and mouse.Target then
            hrp.CFrame = CFrame.new(mouse.Target.Position + Vector3.new(0, 3, 0))
        end
    end
    
    if Features.InstantTP and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local mouse = LocalPlayer:GetMouse()
        if mouse and mouse.Target then
            hrp.CFrame = CFrame.new(mouse.Target.Position + Vector3.new(0, 3, 0))
        end
    end
    
    if Features.AutoStore then
        local args = {[1] = "StoreFruit"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
    
    if Features.AutoEquip then
        local args = {[1] = "LoadCharacter"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
end)

local function CheckSafeMode()
    for _, player in ipairs(Players:GetPlayers()) do
        if player:GetRankInGroup(1) > 0 then
            return true
        end
    end
    return false
end

RunService.Heartbeat:Connect(function()
    if Features.SafeMode and CheckSafeMode() then
        for k, v in pairs(Features) do
            if type(v) == "boolean" then
                Features[k] = false
            end
        end
    end
end)

local function SwitchTab(tabName)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        child:Destroy()
    end

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -20, 1, -20)
    ScrollingFrame.Position = UDim2.new(0, 10, 0, 10)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = isMobile and 3 or 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Parent = ContentFrame

    local yPos = 0

    if tabName == "HOME" then
        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "JOIN DISCORD", function()
            setclipboard("https://discord.gg/TGypsSGwpx")
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "COPY LINK", function()
            setclipboard("FireHub Ultimate")
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "FRUIT STORE", function()
            local args = {[1] = "GetFruits"}
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Anti Afk", function(state)
            Features.AntiAfk = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Rejoin", function(state)
            Features.AutoRejoin = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Safe Mode", function(state)
            Features.SafeMode = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "FPS Booster", function(state)
            Features.FPSBoost = state
            if state then
                local decals = Workspace:GetDescendants()
                for _, v in ipairs(decals) do
                    if v:IsA("BasePart") then
                        v.Material = Enum.Material.SmoothPlastic
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        v.Transparency = 1
                    end
                end
            end
        end)

    elseif tabName == "PVP" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Aimbot", function(state)
            Features.Aimbot = state
        end)
        yPos = yPos + (isMobile and 70 or 60)
        
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Aim FOV Circle", function(state)
            Features.AimFOVEnabled = state
        end)
        yPos = yPos + (isMobile and 70 or 60)
        
        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "FOV Size", 50, 300, Features.AimFOV, function(value)
            Features.AimFOV = value
        end)
        yPos = yPos + (isMobile and 95 or 80)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Prediction Aim", function(state)
            Features.PredictionAim = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Combo", function(state)
            Features.AutoCombo = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Kill Aura", function(state)
            Features.KillAura = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Anti Knockback", function(state)
            Features.AntiKB = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Skill Aim (Players)", function(state)
            Features.SkillAimPVP = state
            if state then Features.SkillAimPVE = false end
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "M1 Aim (Players)", function(state)
            Features.M1AimPVP = state
            if state then Features.M1AimPVE = false end
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Silent Aim", function(state)
            Features.SilentAim = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Triggerbot", function(state)
            Features.Triggerbot = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Anti-Ban", function(state)
            Features.AntiBan = state
        end)

    elseif tabName == "PVE" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Farm", function(state)
            Features.AutoFarm = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Click", function(state)
            Features.AutoClick = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Collect", function(state)
            Features.AutoCollect = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Quest", function(state)
            Features.AutoQuest = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "NPC Aim", function(state)
            Features.NPCAim = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Skill Aim (NPCs)", function(state)
            Features.SkillAimPVE = state
            if state then Features.SkillAimPVP = false end
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "M1 Aim (NPCs)", function(state)
            Features.M1AimPVE = state
            if state then Features.M1AimPVP = false end
        end)

    elseif tabName == "BOSS" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Boss", function(state)
            Features.AutoBoss = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Saber", function(state)
            Features.AutoSaber = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Don Swan", function(state)
            Features.AutoDonSwan = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Bartilo", function(state)
            Features.AutoBartilo = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Second Sea", function(state)
            Features.AutoSecondSea = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Third Sea", function(state)
            Features.AutoThirdSea = state
        end)

    elseif tabName == "MOVEMENT" then
        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Walkspeed", 16, 200, Features.Walkspeed, function(value)
            Features.Walkspeed = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end)
        yPos = yPos + (isMobile and 95 or 80)

        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Jump Power", 50, 250, Features.JumpPower, function(value)
            Features.JumpPower = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = value
            end
        end)
        yPos = yPos + (isMobile and 95 or 80)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fly", function(state)
            Features.Fly = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "NoClip", function(state)
            Features.NoClip = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Speed Hack", function(state)
            Features.SpeedHack = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Dodge", function(state)
            Features.AutoDodge = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Click TP", function(state)
            Features.ClickTP = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Instant TP", function(state)
            Features.InstantTP = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Infinity Jump", function(state)
            local infiniteJumpEnabled = state
            local UIS = UserInputService
            local jumpCount = 0
            
            if infiniteJumpEnabled then
                UIS.JumpRequest:Connect(function()
                    if infiniteJumpEnabled then
                        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            jumpCount = jumpCount + 1
                            if jumpCount >= 2 then
                                wait(0.1)
                                jumpCount = 0
                            end
                        end
                    end
                end)
            end
        end)

    elseif tabName == "FARM" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Chest", function(state)
            Features.AutoChest = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Material", function(state)
            Features.AutoMaterial = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Devil Fruit Sniper", function(state)
            Features.DevilFruitSniper = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Store Fruit", function(state)
            Features.AutoStore = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Equip", function(state)
            Features.AutoEquip = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Awaken", function(state)
            Features.AutoAwaken = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Bones Farm", function(state)
            Features.BonesFarm = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fragments Farm", function(state)
            Features.FragmentsFarm = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Raid Farm", function(state)
            Features.RaidFarm = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Sea Events", function(state)
            Features.SeaEvents = state
        end)

    elseif tabName == "MISC" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Infinite Yield", function(state)
            Features.InfiniteYield = state
            if state then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Server Hop", function()
            local req = syn and syn.request or http_request or request
            if req then
                local response = req({
                    Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100",
                    Method = "GET"
                })
                if response and response.Body then
                    local data = HttpService:JSONDecode(response.Body)
                    local servers = {}
                    for _, server in ipairs(data.data) do
                        if server.playing < server.maxPlayers then
                            table.insert(servers, server.id)
                        end
                    end
                    if #servers > 0 then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
                    end
                end
            end
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Rejoin Server", function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Stat Loader", function(state)
            Features.StatLoader = state
        end)

    elseif tabName == "ESP" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Player ESP", function(state)
            Features.ESP = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Chest ESP", function(state)
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Mob ESP", function(state)
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Item ESP", function(state)
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fruit ESP", function(state)
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Player Counter", function(state)
            Features.PlayerCounter = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fruit Timer", function(state)
            Features.FruitTimer = state
        end)
        yPos = yPos + (isMobile and 70 or 60)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Raid Timer", function(state)
            Features.RaidTimer = state
        end)

    elseif tabName == "SETTINGS" then
        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Theme: Orange", function()
            local themes = {"Orange", "Red", "Blue", "Green", "Purple", "Pink"}
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
            for _, btn in ipairs(TabButtons) do
                btn.BackgroundColor3 = ThemeColors[Features.Theme]
            end
            MinimizeBtn.BackgroundColor3 = ThemeColors[Features.Theme]
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Save Config", function()
            Features.ConfigName = "Config_" .. os.time()
        end)
        yPos = yPos + (isMobile and 65 or 60)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Load Config", function()
        end)
    end

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
end

for tabName, button in pairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(tabName)
    end)
end

SwitchTab("HOME")
