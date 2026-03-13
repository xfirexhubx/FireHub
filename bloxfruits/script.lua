-- FireHub UI for Roblox Game: 2753915549
local gameId = 2753915549
if game.GameId ~= gameId then return end

-- Loadstring ready FireHub UI
local FireHub = {}

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
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "FireHub"
    Title.TextColor3 = Color3.fromRGB(255, 100, 0)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- Home Button
    local HomeBtn = Instance.new("TextButton")
    HomeBtn.Name = "Home"
    HomeBtn.Size = UDim2.new(0, 60, 0, 30)
    HomeBtn.Position = UDim2.new(0, 120, 0, 5)
    HomeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    HomeBtn.Text = "HOME"
    HomeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HomeBtn.TextScaled = true
    HomeBtn.Font = Enum.Font.GothamBold
    HomeBtn.BorderSizePixel = 0
    HomeBtn.Parent = TopBar

    -- PVP Button
    local PvPBtn = Instance.new("TextButton")
    PvPBtn.Name = "PVP"
    PvPBtn.Size = UDim2.new(0, 60, 0, 30)
    PvPBtn.Position = UDim2.new(0, 190, 0, 5)
    PvPBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    PvPBtn.Text = "PVP"
    PvPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PvPBtn.TextScaled = true
    PvPBtn.Font = Enum.Font.GothamBold
    PvPBtn.BorderSizePixel = 0
    PvPBtn.Parent = TopBar

    -- PVE Button
    local PvEBtn = Instance.new("TextButton")
    PvEBtn.Name = "PVE"
    PvEBtn.Size = UDim2.new(0, 60, 0, 30)
    PvEBtn.Position = UDim2.new(0, 260, 0, 5)
    PvEBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    PvEBtn.Text = "PVE"
    PvEBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PvEBtn.TextScaled = true
    PvEBtn.Font = Enum.Font.GothamBold
    PvEBtn.BorderSizePixel = 0
    PvEBtn.Parent = TopBar

    -- Misc Button
    local MiscBtn = Instance.new("TextButton")
    MiscBtn.Name = "Misc"
    MiscBtn.Size = UDim2.new(0, 70, 0, 30)
    MiscBtn.Position = UDim2.new(0, 330, 0, 5)
    MiscBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    MiscBtn.Text = "Miscella."
    MiscBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiscBtn.TextScaled = true
    MiscBtn.Font = Enum.Font.GothamBold
    MiscBtn.BorderSizePixel = 0
    MiscBtn.Parent = TopBar

    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -20, 1, -60)
    ContentFrame.Position = UDim2.new(0, 10, 0, 50)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame

    -- Join Server Section
    local JoinLabel = Instance.new("TextLabel")
    JoinLabel.Name = "JoinLabel"
    JoinLabel.Size = UDim2.new(1, -20, 0, 40)
    JoinLabel.Position = UDim2.new(0, 10, 0, 20)
    JoinLabel.BackgroundTransparency = 1
    JoinLabel.Text = "JDIN OUR SERVER!"
    JoinLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinLabel.TextScaled = true
    JoinLabel.Font = Enum.Font.GothamBold
    JoinLabel.Parent = ContentFrame

    -- Discord Link Button
    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Name = "Discord"
    DiscordBtn.Size = UDim2.new(1, -20, 0, 50)
    DiscordBtn.Position = UDim2.new(0, 10, 0, 70)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    DiscordBtn.Text = "https://discord.gg/TGypsSGwpx"
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.TextScaled = true
    DiscordBtn.Font = Enum.Font.Gotham
    DiscordBtn.BorderSizePixel = 0
    DiscordBtn.Parent = ContentFrame

    -- Copy Link Section
    local CopyLabel = Instance.new("TextLabel")
    CopyLabel.Name = "CopyLabel"
    CopyLabel.Size = UDim2.new(1, -20, 0, 30)
    CopyLabel.Position = UDim2.new(0, 10, 0, 140)
    CopyLabel.BackgroundTransparency = 1
    CopyLabel.Text = "COPY.LINK"
    CopyLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
    CopyLabel.TextScaled = true
    CopyLabel.Font = Enum.Font.GothamBold
    CopyLabel.Parent = ContentFrame

    -- Copy Button
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Name = "CopyBtn"
    CopyBtn.Size = UDim2.new(1, -20, 0, 40)
    CopyBtn.Position = UDim2.new(0, 10, 0, 180)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    CopyBtn.Text = "COPY LINK"
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.TextScaled = true
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.BorderSizePixel = 0
    CopyBtn.Parent = ContentFrame

    -- ESP Section
    local ESPLabel = Instance.new("TextLabel")
    ESPLabel.Name = "ESPLabel"
    ESPLabel.Size = UDim2.new(1, -20, 0, 30)
    ESPLabel.Position = UDim2.new(0, 10, 0, 240)
    ESPLabel.BackgroundTransparency = 1
    ESPLabel.Text = "ESP"
    ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPLabel.TextScaled = true
    ESPLabel.Font = Enum.Font.GothamBold
    ESPLabel.Parent = ContentFrame

    -- ESP Toggle
    local ESPToggle = Instance.new("TextButton")
    ESPToggle.Name = "ESPToggle"
    ESPToggle.Size = UDim2.new(1, -20, 0, 40)
    ESPToggle.Position = UDim2.new(0, 10, 0, 270)
    ESPToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ESPToggle.Text = "ESP OFF"
    ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPToggle.TextScaled = true
    ESPToggle.Font = Enum.Font.GothamBold
    ESPToggle.BorderSizePixel = 0
    ESPToggle.Parent = ContentFrame

    return ScreenGui, DiscordBtn, CopyBtn, ESPToggle
end

-- Create the GUI
local ScreenGui, DiscordBtn, CopyBtn, ESPToggle = CreateFireHubGUI()

-- Discord button functionality
DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/TGypsSGwpx")
    DiscordBtn.Text = "Copied!"
    wait(1)
    DiscordBtn.Text = "https://discord.gg/TGypsSGwpx"
end)

-- Copy button functionality
CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("FireHub Loadstring")
    CopyBtn.Text = "Copied!"
    wait(1)
    CopyBtn.Text = "COPY LINK"
end)

-- ESP Toggle functionality
local espEnabled = false
ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ESPToggle.Text = "ESP ON"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        -- Add your ESP code here
        print("ESP Enabled")
    else
        ESPToggle.Text = "ESP OFF"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        -- Disable ESP here
        print("ESP Disabled")
    end
end)

-- Return the GUI for loadstring
return ScreenGui
