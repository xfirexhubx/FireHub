-- FireHub Mobile | Blox Fruits Ultimate
-- Custom Tabs with Icons

local player = game:GetService("Players").LocalPlayer
local guiService = game:GetService("GuiService")
local userInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FireHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local function createButton(parent, text, position, size, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.TextColor3 = Color3.new(0, 1, 0)
    button.TextScaled = true
    button.BackgroundColor3 = Color3.new(0, 0.2, 0)
    button.BorderColor3 = Color3.new(0, 1, 0)
    button.Position = position
    button.Size = size
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)
    return button
end

local function createLabel(parent, text, position, size, color)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.TextColor3 = color or Color3.new(0, 1, 0)
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Position = position
    label.Size = size
    label.Parent = parent
    return label
end

local function createFrame(parent, position, size, color)
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = color or Color3.new(0, 0.1, 0)
    frame.BorderColor3 = Color3.new(0, 1, 0)
    frame.Position = position
    frame.Size = size
    frame.Parent = parent
    return frame
end

local mainFrame = createFrame(screenGui, UDim2.new(0.05, 0, 0.05, 0), UDim2.new(0.9, 0, 0.9, 0), Color3.new(0, 0.05, 0))
mainFrame.BackgroundTransparency = 0.1

local titleBar = createFrame(mainFrame, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0.06, 0), Color3.new(0, 0.2, 0))
local title = createLabel(titleBar, "🔥 FIREHUB MOBILE | BLOX FRUITS", UDim2.new(0.02, 0, 0, 0), UDim2.new(0.6, 0, 1, 0), Color3.new(0, 1, 0))

local closeBtn = createButton(titleBar, "✕", UDim2.new(0.95, 0, 0, 0), UDim2.new(0.05, 0, 1, 0), function()
    screenGui.Enabled = false
end)

local keyFrame = createFrame(mainFrame, UDim2.new(0.3, 0, 0.3, 0), UDim2.new(0.4, 0, 0.4, 0), Color3.new(0, 0.1, 0))
keyFrame.Visible = true

local keyTitle = createLabel(keyFrame, "𓆩♛𓆪 FIREHUB KEY SYSTEM 𓆩♛𓆪", UDim2.new(0, 0, 0.05, 0), UDim2.new(1, 0, 0.15, 0), Color3.new(0, 1, 0))

local keyStatus = createLabel(keyFrame, "STATUS: LOCKED", UDim2.new(0, 0, 0.25, 0), UDim2.new(1, 0, 0.1, 0), Color3.new(1, 0.5, 0))

local attemptsLabel = createLabel(keyFrame, "ATTEMPTS: 0", UDim2.new(0, 0, 0.4, 0), UDim2.new(1, 0, 0.1, 0), Color3.new(0, 1, 0))

local keyInput = Instance.new("TextBox")
keyInput.Text = ""
keyInput.TextColor3 = Color3.new(0, 1, 0)
keyInput.BackgroundColor3 = Color3.new(0, 0.2, 0)
keyInput.BorderColor3 = Color3.new(0, 1, 0)
keyInput.Position = UDim2.new(0.1, 0, 0.55, 0)
keyInput.Size = UDim2.new(0.8, 0, 0.15, 0)
keyInput.Parent = keyFrame
keyInput.PlaceholderText = "Enter Security Key"
keyInput.PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5)

local submitBtn = createButton(keyFrame, "UNLOCK", UDim2.new(0.3, 0, 0.75, 0), UDim2.new(0.4, 0, 0.15, 0), nil)

local errorLabel = createLabel(keyFrame, "", UDim2.new(0, 0, 0.92, 0), UDim2.new(1, 0, 0.08, 0), Color3.new(1, 0, 0))

local mainGUI = createFrame(mainFrame, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), Color3.new(0, 0.05, 0))
mainGUI.Visible = false
mainGUI.BackgroundTransparency = 0.1

local pvpBar = createFrame(mainGUI, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0.06, 0), Color3.new(0, 0.15, 0))
local pvpText = createLabel(pvpBar, "⚔️ PVP QUICK: [A] AIMBOT | [C] CAM LOCK | [T] TP BEHIND", UDim2.new(0.02, 0, 0, 0), UDim2.new(0.85, 0, 1, 0), Color3.new(1, 0.8, 0))

local tabBar = createFrame(mainGUI, UDim2.new(0, 0, 0.07, 0), UDim2.new(1, 0, 0.14, 0), Color3.new(0, 0.1, 0))

local tabs = {
    {name="𓆩♛𓆪 Information", icon="𓆩♛𓆪", frame=nil, features={}},
    {name="모 Status", icon="모", frame=nil, features={}},
    {name="⛃ Shop", icon="⛃", frame=nil, features={}},
    {name="⛏ Farming", icon="⛏", frame=nil, features={}},
    {name="⛏ Farm Mastery", icon="⛏", frame=nil, features={}},
    {name="⛏ Farm Other", icon="⛏", frame=nil, features={}},
    {name="♆ Sea Events", icon="♆", frame=nil, features={}},
    {name="☠︎︎ Race", icon="☠︎", frame=nil, features={}},
    {name="☣︎ Dojo", icon="☣︎", frame=nil, features={}},
    {name="✦︎ Stats/Esp", icon="✦︎", frame=nil, features={}},
    {name="⚔︎ PvP", icon="⚔︎", frame=nil, features={}},
    {name="✡ Teleport", icon="✡", frame=nil, features={}},
    {name="☄ Miscellaneous", icon="☄", frame=nil, features={}},
}

local tabButtons = {}
local currentTab = 1
local featureStates = {}

for i, tab in ipairs(tabs) do
    featureStates[tab.name] = {}
    for j = 1, 8 do
        featureStates[tab.name][j] = false
    end
end

local function getFeatureName(tabName, idx)
    local names = {
        ["𓆩♛𓆪 Information"] = {"Player Info","Server Info","Bounty Info","Level Info","Race Info","Fruit Info","Stats Display","Kill Counter"},
        ["모 Status"] = {"Auto Status","Show Health","Show Energy","Show Bounty","Show Level","Show Race","Show Fruit","Show Cooldowns"},
        ["⛃ Shop"] = {"Auto Buy Fruits","Auto Buy Sword","Auto Buy Gun","Auto Buy Accessory","Auto Buy Items","Shop Notifier","Best Price","Auto Sell"},
        ["⛏ Farming"] = {"Auto Farm","Auto Attack","Auto Collect","Auto Equip","Auto Skills","Auto Rejoin","Auto Haki","Auto Reset"},
        ["⛏ Farm Mastery"] = {"Melee Mastery","Sword Mastery","Gun Mastery","Fruit Mastery","Auto Switch","Train Dummies","Mastery Boost","Farm All"},
        ["⛏ Farm Other"] = {"Fragment Farm","Bone Farm","Ectoplasm Farm","Money Farm","Level Farm","Title Farm","Accessory Farm","Chip Farm"},
        ["♆ Sea Events"] = {"Auto Sea Beast","Auto Ship Raid","Mirage Island","Kitsune Island","Prehistoric","Frozen Dim","Event Notifier","Auto Teleport"},
        ["☠︎︎ Race"] = {"V2 Awake","V3 Awake","V4 Awake","Puzzle Solve","Trials","Fragment Grind","Race Check","Aura Farm"},
        ["☣︎ Dojo"] = {"Auto Accept","Auto Complete","Auto Turn In","Quest Loop","Specific Quest","Use Items","Skip Cutscenes","Quest Tracker"},
        ["✦︎ Stats/Esp"] = {"Player ESP","NPC ESP","Fruit ESP","Chest ESP","Boss ESP","Health Bars","Distance","Name Tags"},
        ["⚔︎ PvP"] = {"Aimbot","Camera Lock","Auto Block","Auto Dodge","Auto Heal","Inf Energy","Bounty x","Freeze"},
        ["✡ Teleport"] = {"TP to NPC","TP to Boss","TP to Fruit","TP to Chest","TP to Island","TP to Raid","TP to Sea Beast","TP to Player"},
        ["☄ Miscellaneous"] = {"Auto Store","Auto Sell","Skip Dialog","Anti AFK","Spam Chat","Invisible","Anti Ban","Auto Rejoin"},
    }
    return names[tabName][idx] or "Feature"
end

for i, tab in ipairs(tabs) do
    local btn = createButton(tabBar, tab.name, UDim2.new((i-1) * 0.077, 0, 0, 0), UDim2.new(0.076, 0, 1, 0), function()
        for _, b in ipairs(tabButtons) do
            b.BackgroundColor3 = Color3.new(0, 0.2, 0)
        end
        btn.BackgroundColor3 = Color3.new(0, 0.5, 0)
        for _, t in ipairs(tabs) do
            if t.frame then
                t.frame.Visible = false
            end
        end
        tab.frame.Visible = true
        currentTab = i
    end)
    btn.TextScaled = true
    btn.Text = tab.name
    tabButtons[i] = btn
    
    local featureFrame = createFrame(mainGUI, UDim2.new(0, 0, 0.22, 0), UDim2.new(1, 0, 0.68, 0), Color3.new(0, 0.05, 0))
    featureFrame.Visible = (i == 1)
    tab.frame = featureFrame
    
    for j = 1, 8 do
        local row = math.floor((j-1) / 2)
        local col = (j-1) % 2
        local btnFeat = createButton(featureFrame, "", UDim2.new(0.02 + col * 0.49, 0, 0.02 + row * 0.12, 0), UDim2.new(0.47, 0, 0.11, 0), function()
            featureStates[tab.name][j] = not featureStates[tab.name][j]
            local newText = (j) .. ". " .. (featureStates[tab.name][j] and "✓ " or "○ ") .. getFeatureName(tab.name, j)
            btnFeat.Text = newText
            btnFeat.TextColor3 = featureStates[tab.name][j] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
            
            if getFeatureName(tab.name, j) == "Spam Chat" and featureStates[tab.name][j] then
                toggleSpamChat(true)
            elseif getFeatureName(tab.name, j) == "Spam Chat" and not featureStates[tab.name][j] then
                toggleSpamChat(false)
            end
        end)
        btnFeat.TextScaled = true
        tab.features[j] = btnFeat
    end
end

for i, tab in ipairs(tabs) do
    for j = 1, 8 do
        local btn = tab.features[j]
        btn.Text = j .. ". ○ " .. getFeatureName(tab.name, j)
        btn.TextColor3 = Color3.new(1, 0.5, 0)
    end
end

local bottomBar = createFrame(mainGUI, UDim2.new(0, 0, 0.91, 0), UDim2.new(1, 0, 0.07, 0), Color3.new(0, 0.1, 0))
local bottomText = createLabel(bottomBar, "[S] SAVE | [L] LOAD | [M] SETTINGS | [Q] HIDE GUI", UDim2.new(0.02, 0, 0, 0), UDim2.new(0.85, 0, 1, 0), Color3.new(0.5, 0.5, 0.5))

local settingsFrame = createFrame(mainFrame, UDim2.new(0.25, 0, 0.25, 0), UDim2.new(0.5, 0, 0.5, 0), Color3.new(0, 0.1, 0))
settingsFrame.Visible = false

local settingsTitle = createLabel(settingsFrame, "⚙️ SETTINGS", UDim2.new(0, 0, 0.05, 0), UDim2.new(1, 0, 0.1, 0), Color3.new(0, 1, 0))

local spamTextInput = Instance.new("TextBox")
spamTextInput.Text = "🧭 East Or West FireHub Is Best 🔥"
spamTextInput.TextColor3 = Color3.new(0, 1, 0)
spamTextInput.BackgroundColor3 = Color3.new(0, 0.2, 0)
spamTextInput.BorderColor3 = Color3.new(0, 1, 0)
spamTextInput.Position = UDim2.new(0.05, 0, 0.2, 0)
spamTextInput.Size = UDim2.new(0.9, 0, 0.15, 0)
spamTextInput.Parent = settingsFrame
spamTextInput.PlaceholderText = "Spam Message"

local saveSpamBtn = createButton(settingsFrame, "SAVE SPAM TEXT", UDim2.new(0.25, 0, 0.4, 0), UDim2.new(0.5, 0, 0.12, 0), function()
    spamChatText = spamTextInput.Text
    print("[FireHub] Spam text saved!")
end)

local closeSettingsBtn = createButton(settingsFrame, "CLOSE", UDim2.new(0.35, 0, 0.6, 0), UDim2.new(0.3, 0, 0.12, 0), function()
    settingsFrame.Visible = false
end)

local VALID_KEY_HASH = 686
local attempts = 0
local isUnlocked = false
local spamChatText = "🧭 East Or West FireHub Is Best 🔥"
local spamChatEnabled = false
local spamChatCoroutine = nil

local function hashKey(key)
    local hash = 0
    for i = 1, #key do
        hash = hash + string.byte(key, i)
    end
    return hash
end

local function spamChatLoop()
    while spamChatEnabled do
        pcall(function()
            local rs = game:GetService("ReplicatedStorage")
            local chatEvent = rs:FindFirstChild("DefaultChatSystemChatEvents")
            if chatEvent then
                local sayRequest = chatEvent:FindFirstChild("SayMessageRequest")
                if sayRequest then
                    sayRequest:FireServer(spamChatText, "All")
                end
            end
        end)
        task.wait(5)
    end
end

local function toggleSpamChat(enabled)
    spamChatEnabled = enabled
    if enabled then
        if spamChatCoroutine then
            coroutine.close(spamChatCoroutine)
        end
        spamChatCoroutine = coroutine.create(spamChatLoop)
        coroutine.resume(spamChatCoroutine)
    end
end

submitBtn.MouseButton1Click:Connect(function()
    local input = keyInput.Text
    if input and input ~= "" then
        local inputHash = hashKey(input)
        if inputHash == VALID_KEY_HASH and #input == 7 then
            isUnlocked = true
            keyFrame.Visible = false
            mainGUI.Visible = true
        else
            attempts = attempts + 1
            keyStatus.Text = "STATUS: ACCESS DENIED"
            keyStatus.TextColor3 = Color3.new(1, 0, 0)
            attemptsLabel.Text = "ATTEMPTS: " .. attempts
            errorLabel.Text = "Invalid key! Attempt #" .. attempts
            errorLabel.TextColor3 = Color3.new(1, 0, 0)
            keyInput.Text = ""
            task.wait(1)
            keyStatus.Text = "STATUS: LOCKED"
            keyStatus.TextColor3 = Color3.new(1, 0.5, 0)
            errorLabel.Text = ""
        end
    end
end)

local function saveConfig()
    local data = {
        currentTab = currentTab,
        features = {},
        spamText = spamChatText,
    }
    for i, tab in ipairs(tabs) do
        data.features[tab.name] = {}
        for j = 1, 8 do
            data.features[tab.name][j] = featureStates[tab.name][j]
        end
    end
    pcall(function()
        writefile("FireHub_Mobile.json", game:GetService("HttpService"):JSONEncode(data))
    end)
    print("[FireHub] Config saved!")
end

local function loadConfig()
    pcall(function()
        local data = game:GetService("HttpService"):JSONDecode(readfile("FireHub_Mobile.json"))
        if data then
            currentTab = data.currentTab or 1
            spamChatText = data.spamText or "🧭 East Or West FireHub Is Best 🔥"
            spamTextInput.Text = spamChatText
            for i, tab in ipairs(tabs) do
                if data.features and data.features[tab.name] then
                    for j = 1, 8 do
                        featureStates[tab.name][j] = data.features[tab.name][j] or false
                        local btn = tab.features[j]
                        if btn then
                            btn.Text = j .. ". " .. (featureStates[tab.name][j] and "✓ " or "○ ") .. getFeatureName(tab.name, j)
                            btn.TextColor3 = featureStates[tab.name][j] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
                        end
                    end
                end
            end
            print("[FireHub] Config loaded!")
        end
    end)
end

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not isUnlocked then return end
    
    local key = input.KeyCode
    if key == Enum.KeyCode.S then
        saveConfig()
    elseif key == Enum.KeyCode.L then
        loadConfig()
    elseif key == Enum.KeyCode.M then
        settingsFrame.Visible = not settingsFrame.Visible
    elseif key == Enum.KeyCode.Q then
        screenGui.Enabled = false
    elseif key == Enum.KeyCode.A then
        for i, tab in ipairs(tabs) do
            if tab.name == "⚔︎ PvP" then
                featureStates[tab.name][1] = not featureStates[tab.name][1]
                local btn = tab.features[1]
                btn.Text = "1. " .. (featureStates[tab.name][1] and "✓ " or "○ ") .. getFeatureName(tab.name, 1)
                btn.TextColor3 = featureStates[tab.name][1] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
                break
            end
        end
    elseif key == Enum.KeyCode.C then
        for i, tab in ipairs(tabs) do
            if tab.name == "⚔︎ PvP" then
                featureStates[tab.name][2] = not featureStates[tab.name][2]
                local btn = tab.features[2]
                btn.Text = "2. " .. (featureStates[tab.name][2] and "✓ " or "○ ") .. getFeatureName(tab.name, 2)
                btn.TextColor3 = featureStates[tab.name][2] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
                break
            end
        end
    elseif key == Enum.KeyCode.T then
        for i, tab in ipairs(tabs) do
            if tab.name == "✡ Teleport" then
                featureStates[tab.name][1] = not featureStates[tab.name][1]
                local btn = tab.features[1]
                btn.Text = "1. " .. (featureStates[tab.name][1] and "✓ " or "○ ") .. getFeatureName(tab.name, 1)
                btn.TextColor3 = featureStates[tab.name][1] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
                break
            end
        end
    elseif key == Enum.KeyCode.One then
        featureStates[tabs[currentTab].name][1] = not featureStates[tabs[currentTab].name][1]
        local btn = tabs[currentTab].features[1]
        btn.Text = "1. " .. (featureStates[tabs[currentTab].name][1] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 1)
        btn.TextColor3 = featureStates[tabs[currentTab].name][1] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Two then
        featureStates[tabs[currentTab].name][2] = not featureStates[tabs[currentTab].name][2]
        local btn = tabs[currentTab].features[2]
        btn.Text = "2. " .. (featureStates[tabs[currentTab].name][2] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 2)
        btn.TextColor3 = featureStates[tabs[currentTab].name][2] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Three then
        featureStates[tabs[currentTab].name][3] = not featureStates[tabs[currentTab].name][3]
        local btn = tabs[currentTab].features[3]
        btn.Text = "3. " .. (featureStates[tabs[currentTab].name][3] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 3)
        btn.TextColor3 = featureStates[tabs[currentTab].name][3] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Four then
        featureStates[tabs[currentTab].name][4] = not featureStates[tabs[currentTab].name][4]
        local btn = tabs[currentTab].features[4]
        btn.Text = "4. " .. (featureStates[tabs[currentTab].name][4] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 4)
        btn.TextColor3 = featureStates[tabs[currentTab].name][4] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Five then
        featureStates[tabs[currentTab].name][5] = not featureStates[tabs[currentTab].name][5]
        local btn = tabs[currentTab].features[5]
        btn.Text = "5. " .. (featureStates[tabs[currentTab].name][5] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 5)
        btn.TextColor3 = featureStates[tabs[currentTab].name][5] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Six then
        featureStates[tabs[currentTab].name][6] = not featureStates[tabs[currentTab].name][6]
        local btn = tabs[currentTab].features[6]
        btn.Text = "6. " .. (featureStates[tabs[currentTab].name][6] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 6)
        btn.TextColor3 = featureStates[tabs[currentTab].name][6] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Seven then
        featureStates[tabs[currentTab].name][7] = not featureStates[tabs[currentTab].name][7]
        local btn = tabs[currentTab].features[7]
        btn.Text = "7. " .. (featureStates[tabs[currentTab].name][7] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 7)
        btn.TextColor3 = featureStates[tabs[currentTab].name][7] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    elseif key == Enum.KeyCode.Eight then
        featureStates[tabs[currentTab].name][8] = not featureStates[tabs[currentTab].name][8]
        local btn = tabs[currentTab].features[8]
        btn.Text = "8. " .. (featureStates[tabs[currentTab].name][8] and "✓ " or "○ ") .. getFeatureName(tabs[currentTab].name, 8)
        btn.TextColor3 = featureStates[tabs[currentTab].name][8] and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    end
end)

print("[FireHub] GUI Loaded Successfully!")
print("[FireHub] Enter Key: HellKey")