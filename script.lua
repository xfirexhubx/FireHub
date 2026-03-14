-- FireHub Enhanced UI for Roblox Game: 2753915549
local gameId = 2753915549
if game.GameId ~= gameId then return end

-- Loadstring ready FireHub UI
local FireHub = {}
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Feature tables
local Features = {
    AutoFarm = false,
    AutoClick = false,
    ESP = false,
    InfiniteYield = false,
    Walkspeed = 16,
    JumpPower = 50,
    NoClip = false,
    Fly = false
}

-- Main GUI Creation
local function CreateFireHubGUI()
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FireHub"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 600, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Add Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    -- Top Bar Corner
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar

    -- Title with Icon
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 120, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 FireHub"
    Title.TextColor3 = Color3.fromRGB(255, 140, 0)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0, 7.5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = TopBar

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tab Buttons Frame
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = "TabFrame"
    TabFrame.Size = UDim2.new(1, 0, 0, 40)
    TabFrame.Position = UDim2.new(0, 0, 0, 45)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabFrame.BorderSizePixel = 0
    TabFrame.Parent = MainFrame

    -- Create Tabs
    local Tabs = {"HOME", "PVP", "PVE", "MISCELLA.", "ESP", "SETTINGS"}
    local TabButtons = {}
    local TabContents = {}

    for i, tabName in ipairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = tabName .. "Btn"
        TabBtn.Size = UDim2.new(0, 95, 0, 30)
        TabBtn.Position = UDim2.new(0, 5 + ((i-1) * 100), 0, 5)
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.TextScaled = true
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.BorderSizePixel = 0
        TabBtn.Parent = TabFrame

        -- Button Corner
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 5)
        BtnCorner.Parent = TabBtn

        TabButtons[tabName] = TabBtn
    end

    -- Content Frame (for tabs)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -20, 1, -130)
    ContentFrame.Position = UDim2.new(0, 10, 0, 90)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame

    -- Content Corner
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentFrame

    -- Create Tab Contents
    return ScreenGui, TabButtons, ContentFrame
end

-- Function to create a toggle button
local function CreateToggle(parent, position, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0, 260, 0, 40)
    ToggleFrame.Position = position
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0, 150, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = 16
    ToggleLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -70, 0, 5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 14
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
        callback(enabled)
    end)

    return ToggleBtn
end

-- Function to create a slider
local function CreateSlider(parent, position, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0, 260, 0, 60)
    SliderFrame.Position = position
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 5)
    SliderCorner.Parent = SliderFrame

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -20, 0, 20)
    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextSize = 14
    SliderLabel.Parent = SliderFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, -40, 0, 10)
    Slider.Position = UDim2.new(0, 20, 0, 35)
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
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = Slider.AbsolutePosition
            local relativeX = math.clamp(mousePos.X - absPos.X, 0, Slider.AbsoluteSize.X)
            local percent = relativeX / Slider.AbsoluteSize.X
            local value = min + (max - min) * percent
            Fill.Size = UDim2.new(percent, 0, 1, 0)
            SliderLabel.Text = text .. ": " .. math.floor(value)
            callback(value)
        end
    end)
end

-- Function to create a button
local function CreateButton(parent, position, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 260, 0, 40)
    Btn.Position = position
    Btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Btn.BorderSizePixel = 0
    Btn.Parent = parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(callback)
end

-- Create GUI
local ScreenGui, TabButtons, ContentFrame = CreateFireHubGUI()

-- Function to switch tabs
local function SwitchTab(tabName)
    -- Clear content
    for _, child in ipairs(ContentFrame:GetChildren()) do
        child:Destroy()
    end

    -- Create ScrollingFrame
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -20, 1, -20)
    ScrollingFrame.Position = UDim2.new(0, 10, 0, 10)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Parent = ContentFrame

    local yPos = 0

    if tabName == "HOME" then
        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "JOIN DISCORD", function()
            setclipboard("https://discord.gg/TGypsSGwpx")
        end)
        yPos = yPos + 50

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "COPY LINK", function()
            setclipboard("FireHub Loadstring")
        end)
        yPos = yPos + 50

        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, -20, 0, 30)
        StatusLabel.Position = UDim2.new(0, 10, 0, yPos)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "🔥 FireHub v1.0 Loaded!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.TextSize = 18
        StatusLabel.Parent = ScrollingFrame

    elseif tabName == "PVP" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Aimbot", function(state)
            print("Aimbot:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Silent Aim", function(state)
            print("Silent Aim:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Wallhack", function(state)
            print("Wallhack:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Triggerbot", function(state)
            print("Triggerbot:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Anti-Ban", function(state)
            print("Anti-Ban:", state)
        end)

    elseif tabName == "PVE" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Farm", function(state)
            Features.AutoFarm = state
            if state then
                -- Auto farm loop
                spawn(function()
                    while Features.AutoFarm do
                        wait(0.1)
                        -- Add auto farm code here
                    end
                end)
            end
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Click", function(state)
            Features.AutoClick = state
            if state then
                spawn(function()
                    while Features.AutoClick do
                        VirtualUser:ClickButton1(Vector2.new())
                        wait(0.01)
                    end
                end)
            end
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Collect", function(state)
            print("Auto Collect:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Auto Quest", function(state)
            print("Auto Quest:", state)
        end)

    elseif tabName == "MISCELLA." then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Infinite Yield", function(state)
            Features.InfiniteYield = state
            if state then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Fly", function(state)
            Features.Fly = state
            -- Add fly code here
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "NoClip", function(state)
            Features.NoClip = state
            -- Add noclip code here
        end)
        yPos = yPos + 50

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Teleport Tool", function()
            print("Teleport tool activated")
        end)
        yPos = yPos + 50

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Server Hop", function()
            print("Server hopping...")
        end)

    elseif tabName == "ESP" then
        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Player ESP", function(state)
            Features.ESP = state
            if state then
                -- Add ESP code here
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        -- Create ESP for player
                    end
                end
            end
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Chest ESP", function(state)
            print("Chest ESP:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Mob ESP", function(state)
            print("Mob ESP:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Item ESP", function(state)
            print("Item ESP:", state)
        end)
        yPos = yPos + 50

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Tracer ESP", function(state)
            print("Tracer ESP:", state)
        end)

    elseif tabName == "SETTINGS" then
        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Walkspeed", 16, 100, 16, function(value)
            Features.Walkspeed = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end)
        yPos = yPos + 70

        CreateSlider(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Jump Power", 50, 200, 50, function(value)
            Features.JumpPower = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = value
            end
        end)
        yPos = yPos + 70

        CreateToggle(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Infinity Jump", function(state)
            -- Add infinity jump code here
        end)
        yPos = yPos + 50

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Rejoin Server", function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end)
        yPos = yPos + 50

        CreateButton(ScrollingFrame, UDim2.new(0, 10, 0, yPos), "Server Hop", function()
            local HttpService = game:GetService("HttpService")
            local servers = {}
            local req = syn and syn.request or http_request or request
            if req then
                local response = req({
                    Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100",
                    Method = "GET"
                })
                if response and response.Body then
                    local data = HttpService:JSONDecode(response.Body)
                    for _, server in ipairs(data.data) do
                        if server.playing < server.maxPlayers then
                            table.insert(servers, server.id)
                        end
                    end
                end
                if #servers > 0 then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
                end
            end
        end)
    end

    -- Update canvas size
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
end

-- Connect tab buttons
for tabName, button in pairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(tabName)
    end)
end

-- Start with HOME tab
SwitchTab("HOME")

-- Return for loadstring
return ScreenGui
