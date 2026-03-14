-- FireHub v1 by FirePlayz
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
local MarketplaceService = game:GetService("MarketplaceService")

local isMobile = UserInputService.TouchEnabled

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FireHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 900, 0, 600)
MainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

-- Title with 12+ and FIREHUB
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(0, 200, 1, 0)
TitleFrame.Position = UDim2.new(0, 10, 0, 0)
TitleFrame.BackgroundTransparency = 1
TitleFrame.Parent = TopBar

local AgeLabel = Instance.new("TextLabel")
AgeLabel.Size = UDim2.new(0, 40, 1, 0)
AgeLabel.Position = UDim2.new(0, 0, 0, 0)
AgeLabel.BackgroundTransparency = 1
AgeLabel.Text = "12+"
AgeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AgeLabel.TextScaled = true
AgeLabel.Font = Enum.Font.GothamBold
AgeLabel.TextXAlignment = Enum.TextXAlignment.Left
AgeLabel.Parent = TitleFrame

local FireHubLabel = Instance.new("TextLabel")
FireHubLabel.Size = UDim2.new(0, 150, 1, 0)
FireHubLabel.Position = UDim2.new(0, 45, 0, 0)
FireHubLabel.BackgroundTransparency = 1
FireHubLabel.Text = "FIREHUB"
FireHubLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
FireHubLabel.TextScaled = true
FireHubLabel.Font = Enum.Font.GothamBold
FireHubLabel.TextXAlignment = Enum.TextXAlignment.Left
FireHubLabel.Parent = TitleFrame

-- Hub Name
local HubName = Instance.new("TextLabel")
HubName.Size = UDim2.new(0, 350, 1, 0)
HubName.Position = UDim2.new(0, 220, 0, 0)
HubName.BackgroundTransparency = 1
HubName.Text = "FireHub: Blox Fruit by FirePlayz"
HubName.TextColor3 = Color3.fromRGB(200, 200, 200)
HubName.TextScaled = true
HubName.Font = Enum.Font.Gotham
HubName.TextXAlignment = Enum.TextXAlignment.Left
HubName.Parent = TopBar

-- Version
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 60, 1, 0)
VersionLabel.Position = UDim2.new(1, -180, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v1.0.0"
VersionLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
VersionLabel.TextScaled = true
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.Parent = TopBar

-- Discord Button
local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0, 120, 0, 35)
DiscordBtn.Position = UDim2.new(1, -140, 0.5, -17.5)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "Join Discord"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.TextScaled = true
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Parent = TopBar

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 5)
DiscordCorner.Parent = DiscordBtn

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/YourDiscordLink")
    DiscordBtn.Text = "Copied!"
    task.wait(1)
    DiscordBtn.Text = "Join Discord"
end)

-- Left Sidebar (Tabs)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 200, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 55)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

-- Tabs List
local Tabs = {
    "Information",
    "Status And Server",
    "Shop",
    "Tab Farming",
    "Tab Farm Mastery",
    "Tab Farm Others",
    "Tab Sea Event",
    "Tab Race Upgrade",
    "Tab Dojo Quest",
    "Tab Stats & ESP",
    "Tab Local Player",
    "Tab Teleport",
    "Tab Get Items"
}

local TabButtons = {}
local TabContent = {}

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName .. "Btn"
    TabBtn.Size = UDim2.new(1, -10, 0, 30)
    TabBtn.Position = UDim2.new(0, 5, 0, 5 + ((i-1) * 35))
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabBtn.Text = "   " .. tabName
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = Sidebar
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = TabBtn
    
    TabButtons[tabName] = TabBtn
end

-- Main Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -210, 1, -60)
ContentArea.Position = UDim2.new(0, 205, 0, 55)
ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentArea

-- Scrolling Content
local ContentScrolling = Instance.new("ScrollingFrame")
ContentScrolling.Size = UDim2.new(1, -20, 1, -20)
ContentScrolling.Position = UDim2.new(0, 10, 0, 10)
ContentScrolling.BackgroundTransparency = 1
ContentScrolling.BorderSizePixel = 0
ContentScrolling.ScrollBarThickness = 5
ContentScrolling.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
ContentScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScrolling.Parent = ContentArea

-- Bottom Status Bar
local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, 0, 0, 40)
StatusBar.Position = UDim2.new(0, 0, 1, -40)
StatusBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 10)
StatusCorner.Parent = StatusBar

-- LV. Display
local LVLabel = Instance.new("TextLabel")
LVLabel.Size = UDim2.new(0, 150, 1, 0)
LVLabel.Position = UDim2.new(0, 10, 0, 0)
LVLabel.BackgroundTransparency = 1
LVLabel.Text = "Lv. 2800 (MAX)"
LVLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
LVLabel.TextScaled = true
LVLabel.Font = Enum.Font.GothamBold
LVLabel.TextXAlignment = Enum.TextXAlignment.Left
LVLabel.Parent = StatusBar

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(0, 300, 1, 0)
StatsLabel.Position = UDim2.new(0, 170, 0, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "106 / 257 / 460 / 526,493"
StatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatsLabel.TextScaled = true
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.Parent = StatusBar

local FragsLabel = Instance.new("TextLabel")
FragsLabel.Size = UDim2.new(0, 80, 1, 0)
FragsLabel.Position = UDim2.new(1, -180, 0, 0)
FragsLabel.BackgroundTransparency = 1
FragsLabel.Text = "f6,334"
FragsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FragsLabel.TextScaled = true
FragsLabel.Font = Enum.Font.GothamBold
FragsLabel.Parent = StatusBar

local MoneyLabel = Instance.new("TextLabel")
MoneyLabel.Size = UDim2.new(0, 100, 1, 0)
MoneyLabel.Position = UDim2.new(1, -90, 0, 0)
MoneyLabel.BackgroundTransparency = 1
MoneyLabel.Text = "$57,292"
MoneyLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
MoneyLabel.TextScaled = true
MoneyLabel.Font = Enum.Font.GothamBold
MoneyLabel.Parent = StatusBar

-- Helper Functions
local function CreateSection(parent, yPos, title)
    local Section = Instance.new("TextLabel")
    Section.Size = UDim2.new(1, -10, 0, 25)
    Section.Position = UDim2.new(0, 5, 0, yPos)
    Section.BackgroundTransparency = 1
    Section.Text = title
    Section.TextColor3 = Color3.fromRGB(255, 140, 0)
    Section.TextScaled = true
    Section.Font = Enum.Font.GothamBold
    Section.TextXAlignment = Enum.TextXAlignment.Left
    Section.Parent = parent
    return yPos + 30
end

local function CreateToggle(parent, yPos, text, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 5, 0, yPos)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.TextScaled = true
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -10)
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

    local enabled = default or false
    if enabled then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        ToggleBtn.Text = "ON"
    end

    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            ToggleBtn.Text = "ON"
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
            ToggleBtn.Text = "OFF"
        end
    end)

    return yPos + 35
end

local function CreateInput(parent, yPos, label, placeholder)
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, -10, 0, 60)
    InputFrame.Position = UDim2.new(0, 5, 0, yPos)
    InputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    InputFrame.BorderSizePixel = 0
    InputFrame.Parent = parent

    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 5)
    InputCorner.Parent = InputFrame

    local InputLabel = Instance.new("TextLabel")
    InputLabel.Size = UDim2.new(1, -20, 0, 20)
    InputLabel.Position = UDim2.new(0, 10, 0, 5)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = label
    InputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.TextScaled = true
    InputLabel.Font = Enum.Font.Gotham
    InputLabel.Parent = InputFrame

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, -20, 0, 25)
    InputBox.Position = UDim2.new(0, 10, 0, 30)
    InputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    InputBox.PlaceholderText = placeholder
    InputBox.Text = ""
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    InputBox.TextScaled = true
    InputBox.Font = Enum.Font.Gotham
    InputBox.ClearTextOnFocus = false
    InputBox.Parent = InputFrame

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 5)
    BoxCorner.Parent = InputBox

    return yPos + 65
end

local function CreateDropdown(parent, yPos, label, options)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, -10, 0, 50)
    DropdownFrame.Position = UDim2.new(0, 5, 0, yPos)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = parent

    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 5)
    DropdownCorner.Parent = DropdownFrame

    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Size = UDim2.new(0, 150, 1, 0)
    DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = label
    DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    DropdownLabel.TextScaled = true
    DropdownLabel.Font = Enum.Font.Gotham
    DropdownLabel.Parent = DropdownFrame

    local DropdownBtn = Instance.new("TextButton")
    DropdownBtn.Size = UDim2.new(0, 150, 0, 30)
    DropdownBtn.Position = UDim2.new(1, -160, 0.5, -15)
    DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    DropdownBtn.Text = options[1] or "Select"
    DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownBtn.TextScaled = true
    DropdownBtn.Font = Enum.Font.GothamBold
    DropdownBtn.BorderSizePixel = 0
    DropdownBtn.Parent = DropdownFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = DropdownBtn

    return yPos + 55
end

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

    Btn.MouseButton1Click:Connect(callback)
    return yPos + 40
end

-- Tab Switching Function
local function SwitchTab(tabName)
    for _, child in ipairs(ContentScrolling:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 5
    
    if tabName == "Information" then
        yPos = CreateSection(ContentScrolling, yPos, "Information")
        
        -- Time Zone
        local TimeFrame = Instance.new("Frame")
        TimeFrame.Size = UDim2.new(1, -10, 0, 60)
        TimeFrame.Position = UDim2.new(0, 5, 0, yPos)
        TimeFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TimeFrame.BorderSizePixel = 0
        TimeFrame.Parent = ContentScrolling
        
        local TimeCorner = Instance.new("UICorner")
        TimeCorner.CornerRadius = UDim.new(0, 5)
        TimeCorner.Parent = TimeFrame
        
        local TimeLabel = Instance.new("TextLabel")
        TimeLabel.Size = UDim2.new(1, -20, 0, 25)
        TimeLabel.Position = UDim2.new(0, 10, 0, 5)
        TimeLabel.BackgroundTransparency = 1
        TimeLabel.Text = "Time Zone"
        TimeLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
        TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
        TimeLabel.TextScaled = true
        TimeLabel.Font = Enum.Font.GothamBold
        TimeLabel.Parent = TimeFrame
        
        local TimeValue = Instance.new("TextLabel")
        TimeValue.Size = UDim2.new(1, -20, 0, 25)
        TimeValue.Position = UDim2.new(0, 10, 0, 30)
        TimeValue.BackgroundTransparency = 1
        TimeValue.Text = os.date("%d/%m/%Y - %I:%M:%S %p")
        TimeValue.TextColor3 = Color3.fromRGB(255, 255, 255)
        TimeValue.TextXAlignment = Enum.TextXAlignment.Left
        TimeValue.TextScaled = true
        TimeValue.Font = Enum.Font.Gotham
        TimeValue.Parent = TimeFrame
        
        yPos = yPos + 65
        
        -- Island Status
        yPos = CreateToggle(ContentScrolling, yPos, "Mirage Island", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Kitsune Island", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Prehistoric Island", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Frozen Dimension", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Dimension Killed")
        yPos = CreateToggle(ContentScrolling, yPos, "Kill: 500", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Boss Status")
        yPos = CreateToggle(ContentScrolling, yPos, "Tyrant of the Skies", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Rip_Indra", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Dough King", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Elite Hunter", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Pull Lever", false)
        
    elseif tabName == "Status And Server" then
        yPos = CreateSection(ContentScrolling, yPos, "Server")
        
        yPos = CreateInput(ContentScrolling, yPos, "Input Job Id", "Enter Job ID...")
        
        yPos = CreateButton(ContentScrolling, yPos, "Spam Join", function()
            print("Spam Join clicked")
        end)
        
        yPos = CreateButton(ContentScrolling, yPos, "Rejoin Server", function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        
        yPos = CreateButton(ContentScrolling, yPos, "Join Server", function()
            print("Join Server clicked")
        end)
        
    elseif tabName == "Shop" then
        yPos = CreateSection(ContentScrolling, yPos, "Sword Shop")
        
        local swords = {
            "Cutlass [1,000 Beli]",
            "Katana [1,000 Beli]",
            "Iron Mace [25,000 Beli]",
            "Dual Katana [12,000 Beli]",
            "Triple Katana [60,000 Beli]",
            "Pipe [100,000 Beli]",
            "Dual-Headed Blade [400,000 Beli]",
            "Bisento [1,200,000 Beli]",
            "Soul Cane [750,000 Beli]",
            "Pole v2 [5,000 Fragments]"
        }
        
        for _, sword in ipairs(swords) do
            yPos = CreateButton(ContentScrolling, yPos, sword, function()
                print("Buying: " .. sword)
            end)
        end
        
        yPos = CreateSection(ContentScrolling, yPos, "Gun Shop")
        
        local guns = {
            "Musket [8,000 Beli]",
            "Flintlock [10,500 Beli]",
            "Refined Slingshot [30,000 Beli]",
            "Refined Flintlock [65,000 Beli]",
            "Cannon [100,000 Beli]",
            "Kabucha [1,500 Fragments]",
            "Bizarre Rifle [250 Ectoplasm]"
        }
        
        for _, gun in ipairs(guns) do
            yPos = CreateButton(ContentScrolling, yPos, gun, function()
                print("Buying: " .. gun)
            end)
        end
        
        yPos = CreateSection(ContentScrolling, yPos, "Abilities Shop")
        
        local abilities = {
            "Skyjump [$10,000 Beli]",
            "Buso Haki [$25,000 Beli]",
            "Observation haki [$750,000 Beli]",
            "Soru [$100,000 Beli]"
        }
        
        for _, ability in ipairs(abilities) do
            yPos = CreateButton(ContentScrolling, yPos, ability, function()
                print("Buying: " .. ability)
            end)
        end
        
        yPos = CreateSection(ContentScrolling, yPos, "Misc Shop")
        
        yPos = CreateButton(ContentScrolling, yPos, "Buy Refund Stat (2500F)", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Buy Reroll Race (3000F)", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Buy Draco", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Buy Ghoul Race", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Buy Cyborg Race (2500F)", function() end)
        
        yPos = CreateSection(ContentScrolling, yPos, "Fighting Shop")
        
        local fighting = {
            "Black Leg",
            "Fishman Karate",
            "Electro",
            "Dragon Breath",
            "SuperHuman",
            "Death Step",
            "Sharkman Karate",
            "Electric Claw",
            "Dragon Talon",
            "God Human",
            "Sanguine Art"
        }
        
        for _, style in ipairs(fighting) do
            yPos = CreateButton(ContentScrolling, yPos, style, function()
                print("Buying: " .. style)
            end)
        end
        
    elseif tabName == "Tab Farming" then
        yPos = CreateSection(ContentScrolling, yPos, "Auto Farm main")
        
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Weapon", {"Melee", "Sword", "Gun", "Fruit"})
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Farm Mode", {"Normal", "Quest", "Boss"})
        
        yPos = CreateButton(ContentScrolling, yPos, "Start Farm", function() end)
        yPos = CreateToggle(ContentScrolling, yPos, "Accept Quests", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Other")
        yPos = CreateToggle(ContentScrolling, yPos, "Kill Mobs Nearest", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Collect")
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Collect Chest", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Collect Berry", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Material")
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Material", {"All", "Scrap", "Metal", "Wood", "Bone", "Fragment"})
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Farm", false)
        
    elseif tabName == "Tab Farm Mastery" then
        yPos = CreateSection(ContentScrolling, yPos, "Mastery")
        
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Method", {"Cake", "Bone", "Normal"})
        
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Farm Mastery Fruit", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Farm Mastery Gun", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Fruit Skills")
        yPos = CreateToggle(ContentScrolling, yPos, "Fruit Skill Z", true)
        yPos = CreateToggle(ContentScrolling, yPos, "Fruit Skill X", true)
        yPos = CreateToggle(ContentScrolling, yPos, "Fruit Skill C", true)
        yPos = CreateToggle(ContentScrolling, yPos, "Fruit Skill V", true)
        yPos = CreateToggle(ContentScrolling, yPos, "Fruit Skill F", true)
        
    elseif tabName == "Tab Farm Others" then
        yPos = CreateSection(ContentScrolling, yPos, "Fishing")
        
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Fishing Rod", {"Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"})
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Bait", {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"})
        
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Buy Bait", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Fishing", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Quest Fishing", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Complete Quest", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Sell Fish", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto use skill of the rod", false)
        
    elseif tabName == "Tab Sea Event" then
        yPos = CreateSection(ContentScrolling, yPos, "Sea Event / Setting Sail")
        
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Boats", {"Basic Boat", "Stealth Boat", "Party Boat", "Duck Boat"})
        
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Start farm", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Buy Boat & Move to Zone", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Activate Boat Speed", false)
        
        yPos = CreateInput(ContentScrolling, yPos, "Boat Speed Value", "Recommended: 300")
        
        yPos = CreateSection(ContentScrolling, yPos, "Select what you will farm.")
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Attack Sea Beast", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Attack Pirate GrandBrigade", false)
        
        yPos = CreateButton(ContentScrolling, yPos, "Go to Sea 3 or Sea 2 for Farm maritime events", function() end)
        
    elseif tabName == "Tab Race Upgrade" then
        yPos = CreateSection(ContentScrolling, yPos, "Race Upgrade")
        
        local races = {"Human", "Fishman", "Skypiea", "Mink", "Ghoul", "Cyborg", "Draco"}
        
        for _, race in ipairs(races) do
            yPos = CreateButton(ContentScrolling, yPos, "Upgrade " .. race, function() end)
        end
        
    elseif tabName == "Tab Dojo Quest" then
        yPos = CreateSection(ContentScrolling, yPos, "Boss Farm")
        
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Boss", {
            "The Gorilla King", "Bobby", "The Saw", "Yeti", "Mob Leader",
            "Vice Admiral", "Saber Expert", "Warden", "Chief Warden", "Swan"
        })
        
        yPos = CreateButton(ContentScrolling, yPos, "Refresh Boss List", function() end)
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Farm Boss Select", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Accept Quest Boss", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Farm All Bosses", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Quests")
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Farm Observation", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Accept Quest Bypass [Risk]", false)
        
    elseif tabName == "Tab Stats & ESP" then
        yPos = CreateSection(ContentScrolling, yPos, "Stats")
        
        yPos = CreateToggle(ContentScrolling, yPos, "Add Points Melee", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Add Points Sword", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Add Points Gun", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Add Points Fruit", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Add Points Defense", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "ESP")
        yPos = CreateToggle(ContentScrolling, yPos, "Player ESP", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Chest ESP", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Mob ESP", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Fruit ESP", false)
        
    elseif tabName == "Tab Local Player" then
        yPos = CreateSection(ContentScrolling, yPos, "LocalPlayer Settings")
        
        yPos = CreateToggle(ContentScrolling, yPos, "Enable custom WalkSpeed", false)
        yPos = CreateInput(ContentScrolling, yPos, "WalkSpeed Value", "Enter speed...")
        
        yPos = CreateToggle(ContentScrolling, yPos, "Enable custom JumpPower", false)
        yPos = CreateInput(ContentScrolling, yPos, "JumpPower Value", "Enter jump power...")
        
        yPos = CreateSection(ContentScrolling, yPos, "Infinite Energy")
        yPos = CreateToggle(ContentScrolling, yPos, "Infinite Energy", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Infinite Soru", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Infinite Observation", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Combat Settings")
        yPos = CreateToggle(ContentScrolling, yPos, "Ignore Same Teams", true)
        yPos = CreateToggle(ContentScrolling, yPos, "Accept Allies", false)
        
    elseif tabName == "Tab Teleport" then
        yPos = CreateSection(ContentScrolling, yPos, "Travel - Worlds")
        
        yPos = CreateButton(ContentScrolling, yPos, "Teleport Sea 1", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Teleport Sea 2", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Teleport Sea 3", function() end)
        
        yPos = CreateSection(ContentScrolling, yPos, "Travel - Island")
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Island", {"Island 1", "Island 2", "Island 3"})
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Travel", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Travel - NPCs")
        yPos = CreateDropdown(ContentScrolling, yPos, "Select NPC", {"NPC 1", "NPC 2"})
        yPos = CreateToggle(ContentScrolling, yPos, "Auto Tween to NPC", false)
        
        yPos = CreateSection(ContentScrolling, yPos, "Player Teleport")
        
        yPos = CreateDropdown(ContentScrolling, yPos, "Select Player", {"Player 1", "Player 2"})
        yPos = CreateButton(ContentScrolling, yPos, "Refresh Player List", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Teleport to Player", function() end)
        yPos = CreateButton(ContentScrolling, yPos, "Spectate Player", function() end)
        
        yPos = CreateSection(ContentScrolling, yPos, "Aimbot")
        yPos = CreateToggle(ContentScrolling, yPos, "Aimbot Cam Lock", false)
        yPos = CreateToggle(ContentScrolling, yPos, "Aimbot Skills", false)
        
    elseif tabName == "Tab Get Items" then
        yPos = CreateSection(ContentScrolling, yPos, "World 1 Items")
        
        local items = {
            "Auto Saw Sword",
            "Auto Saber Sword",
            "Auto Usoap's Hat",
            "Auto Bisento V2",
            "Auto Warden Sword",
            "Auto Marine Coat",
            "Auto Drop Fruit"
        }
        
        for _, item in ipairs(items) do
            yPos = CreateToggle(ContentScrolling, yPos, item, false)
        end
        
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, -10, 0, 20)
        desc.Position = UDim2.new(0, 5, 0, yPos)
        desc.BackgroundTransparency = 1
        desc.Text = "Automatic drop devil fruit"
        desc.TextColor3 = Color3.fromRGB(150, 150, 150)
        desc.TextScaled = true
        desc.Font = Enum.Font.Gotham
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.Parent = ContentScrolling
        yPos = yPos + 25
    end
    
    ContentScrolling.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
end

-- Connect tab buttons
for tabName, button in pairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        -- Reset all button colors
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        -- Highlight selected
        button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        SwitchTab(tabName)
    end)
end

-- Start with Information tab
SwitchTab("Information")
TabButtons["Information"].BackgroundColor3 = Color3.fromRGB(255, 140, 0)

print("🔥 FireHub v1 by FirePlayz Loaded!")
print("📱 Version 1.0.0")