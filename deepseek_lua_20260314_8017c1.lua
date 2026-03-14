local gameId = 2753915549
if game.GameId ~= gameId then return end

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

local isMobile = UserInputService.TouchEnabled
local fontSize = isMobile and 18 or 14

local Features = {
    Aimbot = false,
    SilentAim = false,
    Triggerbot = false,
    AntiBan = false,
    AimFOV = 100,
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
    JumpPower = 50
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 60
FOVCircle.Radius = 100
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(255, 140, 0)
FOVCircle.Transparency = 1

local function CreateFireHubGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FireHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:FindFirstChild("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") or Instance.new("ScreenGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = isMobile and UDim2.new(0, 340, 0, 550) or UDim2.new(0, 600, 0, 450)
    MainFrame.Position = UDim2.new(0.5, isMobile and -170 or -300, 0.5, isMobile and -275 or -225)
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
    TopBar.Size = UDim2.new(1, 0, 0, isMobile and 45 or 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 140, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 FireHub"
    Title.TextColor3 = Color3.fromRGB(255, 140, 0)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Size = UDim2.new(0, isMobile and 40 or 30, 0, isMobile and 40 or 30)
    MinimizeBtn.Position = UDim2.new(1, isMobile and -45 or -35, 0, 5)
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
    TabFrame.Size = UDim2.new(1, 0, 0, isMobile and 55 or 45)
    TabFrame.Position = UDim2.new(0, 0, 0, isMobile and 45 or 40)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabFrame.BorderSizePixel = 0
    TabFrame.Parent = MainFrame

    local TabScrolling = Instance.new("ScrollingFrame")
    TabScrolling.Size = UDim2.new(1, 0, 1, 0)
    TabScrolling.BackgroundTransparency = 1
    TabScrolling.BorderSizePixel = 0
    TabScrolling.ScrollBarThickness = isMobile and 3 or 5
    TabScrolling.CanvasSize = UDim2.new(2, 0, 0, 0)
    TabScrolling.Parent = TabFrame

    local Tabs = {"HOME", "PVP", "PVE", "MISC", "ESP", "SET"}
    local TabButtons = {}

    for i, tabName in ipairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = tabName .. "Btn"
        TabBtn.Size = UDim2.new(0, isMobile and 75 or 85, 0, isMobile and 40 or 35)
        TabBtn.Position = UDim2.new(0, 5 + ((i-1) * (isMobile and 80 or 90)), 0, isMobile and 7 or 5)
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
    ContentFrame.Size = UDim2.new(1, -20, 1, isMobile and -140 or -120)
    ContentFrame.Position = UDim2.new(0, 10, 0, isMobile and 105 or 90)
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
    IconFrame.Size = UDim2.new(0, isMobile and 60 or 50, 0, isMobile and 60 or 50)
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

    IconFrame.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        IconFrame.Visible = false
    end)

    return IconGui, IconFrame
end

local function CreateToggle(parent, position, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, isMobile and 55 or 45)
    ToggleFrame.Position = position
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0, isMobile and 170 or 200, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = fontSize
    ToggleLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, isMobile and 70 or 55, 0, isMobile and 40 or 35)
    ToggleBtn.Position = UDim2.new(1, isMobile and -80 or -65, 0, isMobile and 7 or 5)
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
    SliderFrame.Size = UDim2.new(1, -20, 0, isMobile and 75 or 65)
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
    Slider.Size = UDim2.new(1, -40, 0, isMobile and 15 or 12)
    Slider.Position = UDim2.new(0, 20, 0, isMobile and 40 or 35)
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
    Btn.Size = UDim2.new(1, -20, 0, isMobile and 50 or 45)
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

local ScreenGui, TabButtons, ContentFrame, MainFrame, MinimizeBtn = CreateFireHubGUI()
local IconGui, IconFrame = CreateFloatingIcon(MainFrame)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconFrame.Visible = true
end)

RunService.RenderStepped:Connect(function()
    if Features.Aimbot and Features.AimFOV > 0 then
        FOVCircle.Visible = true
        FOVCircle.Radius = Features.AimFOV
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        FOVCircle.Visible = false
    end
end)

RunService.Heartbeat:Connect(function()
    if Features.SkillAimPVP then
        local target = GetClosestTarget("player")
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.lookAt(character.HumanoidRootPart.Position, target.Position)
            end
        end
    end
    
    if Features.SkillAimPVE or Features.NPCAim then
        local target = GetClosestTarget("npc")
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.lookAt(character.HumanoidRootPart.Position, target.Position)
            end
        end
    end
    
    if Features.M1AimPVP or Features.M1AimPVE then
        local targetType = Features.M1AimPVP and "player" or "npc"
        local target = GetClosestTarget(targetType)
    end
    
    if Features.Triggerbot then
        local target = GetClosestTarget("both")
        if target then
            VirtualUser:ClickButton1(Vector2.new())
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
        yPos = yPos + (isMobile and 60 or 55)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "COPY LINK", function()
            setclipboard("FireHub Loadstring")
        end)
        yPos = yPos + (isMobile and 60 or 55)

        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, -20, 0, 40)
        StatusLabel.Position = UDim2.new(0, 10, 0, yPos)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "🔥 FireHub Ready!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.TextSize = fontSize
        StatusLabel.Parent = ScrollingFrame

    elseif tabName == "PVP" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Aimbot", function(state)
            Features.Aimbot = state
        end)
        yPos = yPos + (isMobile and 65 or 55)
        
        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "FOV Size", 50, 300, Features.AimFOV, function(value)
            Features.AimFOV = value
        end)
        yPos = yPos + (isMobile and 85 or 75)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Skill Aim (Players)", function(state)
            Features.SkillAimPVP = state
            if state then Features.SkillAimPVE = false end
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "M1 Aim (Players)", function(state)
            Features.M1AimPVP = state
            if state then Features.M1AimPVE = false end
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Silent Aim", function(state)
            Features.SilentAim = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Triggerbot", function(state)
            Features.Triggerbot = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Anti-Ban", function(state)
            Features.AntiBan = state
        end)

    elseif tabName == "PVE" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Farm", function(state)
            Features.AutoFarm = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Click", function(state)
            Features.AutoClick = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Collect", function(state)
            Features.AutoCollect = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Quest", function(state)
            Features.AutoQuest = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "NPC Aim", function(state)
            Features.NPCAim = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Skill Aim (NPCs)", function(state)
            Features.SkillAimPVE = state
            if state then Features.SkillAimPVP = false end
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "M1 Aim (NPCs)", function(state)
            Features.M1AimPVE = state
            if state then Features.M1AimPVP = false end
        end)

    elseif tabName == "MISC" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Infinite Yield", function(state)
            Features.InfiniteYield = state
            if state then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fly", function(state)
            Features.Fly = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "NoClip", function(state)
            Features.NoClip = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Server Hop", function()
            local HttpService = game:GetService("HttpService")
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
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
                    end
                end
            end
        end)

    elseif tabName == "ESP" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Player ESP", function(state)
            Features.ESP = state
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Chest ESP", function(state)
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Mob ESP", function(state)
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Item ESP", function(state)
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fruit ESP", function(state)
        end)

    elseif tabName == "SET" then
        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Walkspeed", 16, 120, Features.Walkspeed, function(value)
            Features.Walkspeed = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end)
        yPos = yPos + (isMobile and 85 or 75)

        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Jump Power", 50, 200, Features.JumpPower, function(value)
            Features.JumpPower = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = value
            end
        end)
        yPos = yPos + (isMobile and 85 or 75)

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Infinity Jump", function(state)
        end)
        yPos = yPos + (isMobile and 65 or 55)

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Rejoin Server", function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
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