-- FireHub Mobile | Blox Fruits Ultimate
-- Optimized for Mobile (GUI Scale 0.6)

local colors = {
    reset = "\27[0m",
    green1 = "\27[38;2;0;100;0m",
    green2 = "\27[38;2;0;150;0m",
    green3 = "\27[38;2;0;200;0m",
    green4 = "\27[38;2;50;255;50m",
    bg_black = "\27[48;2;0;0;0m",
    red = "\27[38;2;255;50;50m",
    gray = "\27[38;2;100;150;100m",
    white = "\27[38;2;200;255;200m",
    yellow = "\27[38;2;255;200;0m",
    orange = "\27[38;2;255;100;0m",
    cyan = "\27[38;2;0;255;200m"
}

print(colors.green4 .. "🔥 FireHub Mobile Loaded!" .. colors.reset)

local VALID_KEY_HASH = 0
local KEY_BYTES = {72, 101, 108, 108, 75, 101, 121}
for i = 1, 7 do
    VALID_KEY_HASH = VALID_KEY_HASH + KEY_BYTES[i]
end

local function hashKey(key)
    local hash = 0
    for i = 1, #key do
        hash = hash + string.byte(key, i)
    end
    return hash, #key
end

local attempts = 0
local isUnlocked = false
local userInput = ""

print(colors.bg_black)
print(colors.green3 .. string.rep("=", 45) .. colors.reset)
print(colors.green4 .. "     FireHub | Key System" .. colors.reset)
print(colors.green3 .. string.rep("=", 45) .. colors.reset)

while not isUnlocked do
    print(string.rep("\n", 15))
    print(colors.bg_black .. colors.green2 .. "╔" .. string.rep("═", 40) .. "╗" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "║" .. colors.reset .. colors.bg_black .. "  STATUS: " .. (isUnlocked and colors.green4 or colors.green2) .. (isUnlocked and "UNLOCKED" or "LOCKED") .. colors.reset .. string.rep(" ", 40 - 20) .. colors.green2 .. "║" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "║" .. colors.reset .. colors.bg_black .. "  ATTEMPTS: " .. colors.green3 .. attempts .. colors.reset .. string.rep(" ", 40 - 20) .. colors.green2 .. "║" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╠" .. string.rep("═", 40) .. "╣" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "║" .. colors.reset .. colors.bg_black .. " KEY: " .. colors.green3 .. userInput .. colors.reset .. string.rep(" ", 40 - #userInput - 6) .. colors.green2 .. "║" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╚" .. string.rep("═", 40) .. "╝" .. colors.reset)
    print()
    
    io.write(colors.green3 .. "⚡ > " .. colors.reset)
    userInput = io.read()

    if userInput then
        local inputHash, inputLen = hashKey(userInput)
        if inputHash == VALID_KEY_HASH and inputLen == 7 then
            isUnlocked = true
            print(string.rep("\n", 3))
            print(colors.green4 .. string.rep("█", 45) .. colors.reset)
            print(colors.green3 .. "     ✓ ACCESS GRANTED ✓" .. colors.reset)
            print(colors.green4 .. string.rep("█", 45) .. colors.reset)
            print()
            break
        else
            attempts = attempts + 1
            print(colors.red .. "\n✗ ACCESS DENIED" .. colors.reset)
            print(colors.gray .. "  Attempt #" .. attempts .. colors.reset)
            print(colors.gray .. "  Press ENTER..." .. colors.reset)
            io.read()
            userInput = ""
        end
    end
end

local tabs = {
    { name = "COMBAT", features = {
        {name="Inst Kill", state=false, desc="Instant kill"},
        {name="Kill Aura", state=false, desc="Auto damage"},
        {name="God Mode", state=false, desc="Invincible"},
        {name="No CD", state=false, desc="No cooldown"},
        {name="Fast Atk", state=false, desc="Fast attacks"},
        {name="Heart Atk", state=false, desc="Extreme speed"},
        {name="Aura Atk", state=false, desc="Balanced speed"},
        {name="No Stun", state=false, desc="No stun"},
    }},
    { name = "MOVE", features = {
        {name="Fly", state=false, desc="Fly/Noclip"},
        {name="Speed", state=false, desc="Speed hack"},
        {name="Super Jump", state=false, desc="High jump"},
        {name="No Grav", state=false, desc="No gravity"},
        {name="TP Behind", state=false, desc="TP behind"},
        {name="TP Chest", state=false, desc="TP to chest"},
        {name="TP Player", state=false, desc="TP to player"},
        {name="Glitch", state=false, desc="Phase walls"},
    }},
    { name = "FARM", features = {
        {name="Auto Farm", state=false, desc="Auto kill"},
        {name="Auto Quest", state=false, desc="Auto quest"},
        {name="Auto Boss", state=false, desc="Auto boss"},
        {name="Auto Raid", state=false, desc="Auto raid"},
        {name="Auto Factory", state=false, desc="Auto factory"},
        {name="Auto Ship", state=false, desc="Auto ship raid"},
        {name="Auto Sea", state=false, desc="Auto sea beast"},
        {name="Rebirth", state=false, desc="Auto rebirth"},
    }},
    { name = "SEA", features = {
        {name="Mirage", state=false, desc="Mirage Island"},
        {name="Kitsune", state=false, desc="Kitsune Island"},
        {name="Prehistoric", state=false, desc="Prehistoric"},
        {name="Frozen", state=false, desc="Frozen Dim"},
        {name="Sea Event", state=false, desc="Auto event"},
        {name="Notifier", state=false, desc="Event alert"},
        {name="Auto TP", state=false, desc="Auto teleport"},
        {name="Sea Track", state=false, desc="Track beasts"},
    }},
    { name = "FRUIT", features = {
        {name="Fruit Finder", state=false, desc="Find fruits"},
        {name="Get Fruit", state=false, desc="Auto collect"},
        {name="Notifier", state=false, desc="Fruit alert"},
        {name="Auto Buy", state=false, desc="Auto store"},
        {name="Auto Roll", state=false, desc="Auto roll"},
        {name="Collect", state=false, desc="Auto collect"},
        {name="Loot Chest", state=false, desc="Auto chest"},
        {name="Stealer", state=false, desc="Steal fruits"},
    }},
    { name = "RACE", features = {
        {name="V2 Awake", state=false, desc="V2 auto"},
        {name="V3 Awake", state=false, desc="V3 auto"},
        {name="V4 Awake", state=false, desc="V4 auto"},
        {name="Puzzle", state=false, desc="Auto puzzle"},
        {name="Trials", state=false, desc="Auto trials"},
        {name="Frag Farm", state=false, desc="Fragments"},
        {name="Race Check", state=false, desc="Check progress"},
        {name="Aura Farm", state=false, desc="Aura mats"},
    }},
    { name = "ESP", features = {
        {name="Player ESP", state=false, desc="See players"},
        {name="NPC ESP", state=false, desc="See NPCs"},
        {name="Fruit ESP", state=false, desc="See fruits"},
        {name="Chest ESP", state=false, desc="See chests"},
        {name="Boss ESP", state=false, desc="See bosses"},
        {name="Health Bar", state=false, desc="Health bars"},
        {name="Distance", state=false, desc="Show distance"},
        {name="Name Tag", state=false, desc="Show names"},
    }},
    { name = "PVP", features = {
        {name="Aimbot", state=false, desc="Auto aim"},
        {name="Cam Lock", state=false, desc="Lock camera"},
        {name="Auto Block", state=false, desc="Auto parry"},
        {name="Auto Dodge", state=false, desc="Auto dodge"},
        {name="Auto Heal", state=false, desc="Heal low HP"},
        {name="Inf Energy", state=false, desc="No stamina"},
        {name="Bounty x", state=false, desc="Multi bounty"},
        {name="Freeze", state=false, desc="Freeze others"},
    }},
    { name = "UTIL", features = {
        {name="Auto Store", state=false, desc="Store items"},
        {name="Auto Sell", state=false, desc="Sell items"},
        {name="Skip Dialog", state=false, desc="Skip chat"},
        {name="Anti AFK", state=false, desc="No kick"},
        {name="Spam Chat", state=false, desc="Auto chat"},
        {name="Invis", state=false, desc="Invisible"},
        {name="Anti Ban", state=false, desc="Hide script"},
        {name="Rejoin", state=false, desc="Auto rejoin"},
    }},
}

local currentTab = 1
local currentTarget = nil
local targetLocked = false
local spamChatText = "🧭 East Or West FireHub Is Best 🔥"
local spamChatEnabled = false

local pvpFeatures = {
    aimbot = false,
    cameraLock = false,
    tpBehind = false,
}

local function disablePvPFeatures()
    pvpFeatures.aimbot = false
    pvpFeatures.cameraLock = false
    pvpFeatures.tpBehind = false
    targetLocked = false
    currentTarget = nil
    
    for i, feat in ipairs(tabs[7].features) do
        if feat.name == "Aimbot" then
            feat.state = false
        elseif feat.name == "Cam Lock" then
            feat.state = false
        end
    end
    for i, feat in ipairs(tabs[2].features) do
        if feat.name == "TP Behind" then
            feat.state = false
        end
    end
    print(colors.red .. "  [PVP DISABLED]" .. colors.reset)
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

local function toggleFeature(tabIdx, featIdx)
    local feat = tabs[tabIdx].features[featIdx]
    if not feat then return end
    feat.state = not feat.state
    
    if feat.name == "Spam Chat" then
        spamChatEnabled = feat.state
        if spamChatEnabled then
            coroutine.wrap(spamChatLoop)()
        end
    elseif feat.name == "Aimbot" then
        pvpFeatures.aimbot = feat.state
        if feat.state then
            targetLocked = true
        else
            targetLocked = false
            currentTarget = nil
        end
    elseif feat.name == "Cam Lock" then
        pvpFeatures.cameraLock = feat.state
    elseif feat.name == "TP Behind" then
        pvpFeatures.tpBehind = feat.state
    end
    
    if feat.state then
        print(colors.green4 .. "  ✓ " .. feat.name .. " ON" .. colors.reset)
    else
        print(colors.red .. "  ✗ " .. feat.name .. " OFF" .. colors.reset)
    end
end

local function drawMainGUI()
    print(string.rep("\n", 3))
    print(colors.bg_black .. colors.green2 .. "╔" .. string.rep("═", 48) .. "╗" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "║" .. colors.reset .. colors.bg_black .. " FIREHUB MOBILE v3.0" .. string.rep(" ", 48 - 20) .. colors.green2 .. "║" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╠" .. string.rep("═", 48) .. "╣" .. colors.reset)
    
    local pvpBar = "║ PVP: " .. colors.red .. "[A]Aim " .. colors.orange .. "[C]Cam " .. colors.yellow .. "[T]TP" .. colors.reset
    pvpBar = pvpBar .. string.rep(" ", 48 - #pvpBar + 2) .. "║"
    print(colors.bg_black .. colors.green2 .. pvpBar .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╠" .. string.rep("═", 48) .. "╣" .. colors.reset)
    
    local tabLine = "║ "
    for i = 1, 4 do
        if i <= #tabs then
            local marker = (i == currentTab) and colors.green4 or colors.gray
            tabLine = tabLine .. marker .. i .. "." .. tabs[i].name .. colors.reset .. " "
        end
    end
    tabLine = tabLine .. string.rep(" ", 48 - #tabLine) .. "║"
    print(colors.bg_black .. colors.green2 .. tabLine .. colors.reset)
    
    local tabLine2 = "║ "
    for i = 5, 8 do
        if i <= #tabs then
            local marker = (i == currentTab) and colors.green4 or colors.gray
            tabLine2 = tabLine2 .. marker .. i .. "." .. tabs[i].name .. colors.reset .. " "
        end
    end
    tabLine2 = tabLine2 .. string.rep(" ", 48 - #tabLine2) .. "║"
    print(colors.bg_black .. colors.green2 .. tabLine2 .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╠" .. string.rep("═", 48) .. "╣" .. colors.reset)
    
    local header = "║ " .. colors.yellow .. tabs[currentTab].name .. " (" .. #tabs[currentTab].features .. ")" .. colors.reset
    header = header .. string.rep(" ", 48 - #header) .. "║"
    print(colors.bg_black .. colors.green2 .. header .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╠" .. string.rep("═", 48) .. "╣" .. colors.reset)
    
    for i, feat in ipairs(tabs[currentTab].features) do
        local stateStr = feat.state and colors.green4 .. "●" or colors.red .. "○"
        local line = string.format("║ %d.%s %-12s %s", i, stateStr, feat.name, string.rep(" ", 48 - 16))
        print(colors.bg_black .. colors.green2 .. line .. colors.reset)
    end
    
    print(colors.bg_black .. colors.green2 .. "╠" .. string.rep("═", 48) .. "╣" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "║" .. colors.reset .. colors.gray .. " [tab#] [1-8] [S]ave [L]oad [M]enu [Q]uit" .. string.rep(" ", 48 - 44) .. colors.green2 .. "║" .. colors.reset)
    print(colors.bg_black .. colors.green2 .. "╚" .. string.rep("═", 48) .. "╝" .. colors.reset)
    print()
    print(colors.gray .. "  Tap number to toggle | Type 'tab 2' to switch" .. colors.reset)
    io.write(colors.green3 .. "> " .. colors.reset)
end

local function saveConfig()
    local file = io.open("FireHub_Mobile.lua", "w")
    if file then
        file:write("return {\n")
        file:write(string.format("    currentTab = %d,\n", currentTab))
        file:write("    features = {\n")
        for i, tab in ipairs(tabs) do
            for j, feat in ipairs(tab.features) do
                file:write(string.format("        [%d][%d] = %s,\n", i, j, tostring(feat.state)))
            end
        end
        file:write("    },\n")
        file:write(string.format("    spamText = \"%s\",\n", spamChatText))
        file:write("}\n")
        file:close()
        print(colors.green4 .. "  ✓ Saved!" .. colors.reset)
    end
end

local function loadConfig()
    local f = loadfile("FireHub_Mobile.lua")
    if f then
        local cfg = f()
        if cfg then
            currentTab = cfg.currentTab or 1
            for i, tab in ipairs(tabs) do
                for j, feat in ipairs(tab.features) do
                    if cfg.features and cfg.features[i] and cfg.features[i][j] ~= nil then
                        feat.state = cfg.features[i][j]
                    end
                end
            end
            spamChatText = cfg.spamText or "🧭 East Or West FireHub Is Best 🔥"
            print(colors.green4 .. "  ✓ Loaded!" .. colors.reset)
        end
    end
end

local function changeSpamText()
    print(colors.gray .. "  Current: " .. colors.yellow .. spamChatText .. colors.reset)
    io.write(colors.green3 .. "  New text: " .. colors.reset)
    local newText = io.read()
    if newText and newText ~= "" then
        spamChatText = newText
        print(colors.green4 .. "  ✓ Updated!" .. colors.reset)
    end
end

loadConfig()

local function showMenu()
    print(string.rep("\n", 10))
    print(colors.green3 .. string.rep("=", 40) .. colors.reset)
    print(colors.green4 .. "     SETTINGS MENU" .. colors.reset)
    print(colors.green3 .. string.rep("=", 40) .. colors.reset)
    print(colors.green2 .. "  1. Change Spam Text" .. colors.reset)
    print(colors.green2 .. "  2. Back" .. colors.reset)
    print(colors.green3 .. string.rep("=", 40) .. colors.reset)
    io.write(colors.green3 .. "> " .. colors.reset)
end

print(string.rep("\n", 20))
while true do
    drawMainGUI()
    local input = io.read()
    if not input then break end
    input = input:lower()
    
    if input == "q" then
        saveConfig()
        break
    elseif input == "s" then
        saveConfig()
    elseif input == "l" then
        loadConfig()
    elseif input == "m" then
        while true do
            showMenu()
            local sub = io.read()
            if sub == "1" then
                changeSpamText()
            elseif sub == "2" then
                break
            end
        end
    elseif input == "a" then
        for i, feat in ipairs(tabs[7].features) do
            if feat.name == "Aimbot" then
                toggleFeature(7, i)
                break
            end
        end
    elseif input == "c" then
        for i, feat in ipairs(tabs[7].features) do
            if feat.name == "Cam Lock" then
                toggleFeature(7, i)
                break
            end
        end
    elseif input == "t" then
        for i, feat in ipairs(tabs[2].features) do
            if feat.name == "TP Behind" then
                toggleFeature(2, i)
                break
            end
        end
    elseif input:match("^tab%s+(%d+)$") then
        local num = tonumber(input:match("^tab%s+(%d+)$"))
        if num and num >= 1 and num <= #tabs then
            currentTab = num
        else
            print(colors.red .. "  Invalid tab" .. colors.reset)
            io.read()
        end
    elseif input:match("^%d+$") then
        local num = tonumber(input)
        if num and num >= 1 and num <= #tabs[currentTab].features then
            toggleFeature(currentTab, num)
        else
            print(colors.red .. "  Invalid number" .. colors.reset)
        end
        io.read()
    else
        print(colors.red .. "  Unknown" .. colors.reset)
        io.read()
    end
    print(string.rep("\n", 20))
end

print(colors.gray .. "Exiting FireHub. Goodbye!" .. colors.reset)
print(colors.reset)