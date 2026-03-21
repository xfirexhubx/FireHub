elseif tabName == "Fruit Rain" then
    yPos = CreateSection(ContentScrolling, yPos, "🌧️ FRUIT RAIN 2026 - COMPLETE EDITION")
    yPos = CreateSection(ContentScrolling, yPos, "✨ ALL 45 FRUITS INCLUDING DRAGON, KITSUNE, YETI!")
    
    -- Fruit Rain Toggle
    yPos, Features.FruitRainEnabled = CreateToggle(ContentScrolling, yPos, "🌧️ Fruit Rain (Auto Spawn)", Features.FruitRainEnabled, function(enabled)
        Features.FruitRainEnabled = enabled
        if enabled then
            StartFruitRain()
        end
    end)
    
    -- Auto Collect Toggle
    yPos, Features.AutoCollectFruits = CreateToggle(ContentScrolling, yPos, "🍎 Auto Collect Fruits", Features.AutoCollectFruits, function(enabled)
        Features.AutoCollectFruits = enabled
    end)
    
    -- Rare Fruit Only Toggle
    yPos, Features.RareFruitOnly = CreateToggle(ContentScrolling, yPos, "✨ Rare Fruits Only (Legendary/Mythical)", Features.RareFruitOnly, function(enabled)
        Features.RareFruitOnly = enabled
    end)
    
    -- Spawn Rate Slider
    yPos, Features.FruitSpawnRate = CreateSlider(ContentScrolling, yPos, "Spawn Rate (Seconds)", 1, 10, Features.FruitSpawnRate, "s", function(value)
        Features.FruitSpawnRate = value
    end)
    
    yPos = CreateSection(ContentScrolling, yPos, "📊 Fruit Rain Stats")
    
    -- Stats Display
    local FruitStatsFrame = Instance.new("Frame")
    FruitStatsFrame.Size = UDim2.new(1, -10, 0, 100)
    FruitStatsFrame.Position = UDim2.new(0, 5, 0, yPos)
    FruitStatsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    FruitStatsFrame.BackgroundTransparency = 0
    FruitStatsFrame.Parent = ContentScrolling
    
    local FruitStatsCorner = Instance.new("UICorner")
    FruitStatsCorner.CornerRadius = UDim.new(0, 5)
    FruitStatsCorner.Parent = FruitStatsFrame
    
    local TotalCollectedLabel = Instance.new("TextLabel")
    TotalCollectedLabel.Size = UDim2.new(1, -10, 0, 25)
    TotalCollectedLabel.Position = UDim2.new(0, 5, 0, 5)
    TotalCollectedLabel.BackgroundTransparency = 1
    TotalCollectedLabel.Text = "🍎 Total Fruits Collected: 0"
    TotalCollectedLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    TotalCollectedLabel.TextScaled = true
    TotalCollectedLabel.Font = Enum.Font.GothamBold
    TotalCollectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    TotalCollectedLabel.Parent = FruitStatsFrame
    
    local UniqueFruitsLabel = Instance.new("TextLabel")
    UniqueFruitsLabel.Size = UDim2.new(1, -10, 0, 25)
    UniqueFruitsLabel.Position = UDim2.new(0, 5, 0, 35)
    UniqueFruitsLabel.BackgroundTransparency = 1
    UniqueFruitsLabel.Text = "⭐ Unique Fruits Collected: 0/45"
    UniqueFruitsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    UniqueFruitsLabel.TextScaled = true
    UniqueFruitsLabel.Font = Enum.Font.Gotham
    UniqueFruitsLabel.TextXAlignment = Enum.TextXAlignment.Left
    UniqueFruitsLabel.Parent = FruitStatsFrame
    
    local TotalValueLabel = Instance.new("TextLabel")
    TotalValueLabel.Size = UDim2.new(1, -10, 0, 25)
    TotalValueLabel.Position = UDim2.new(0, 5, 0, 65)
    TotalValueLabel.BackgroundTransparency = 1
    TotalValueLabel.Text = "💰 Total Fruit Value: $0"
    TotalValueLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    TotalValueLabel.TextScaled = true
    TotalValueLabel.Font = Enum.Font.Gotham
    TotalValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    TotalValueLabel.Parent = FruitStatsFrame
    
    yPos = yPos + 105
    
    -- Update stats
    task.spawn(function()
        while true do
            task.wait(1)
            pcall(function()
                TotalCollectedLabel.Text = "🍎 Total Fruits Collected: " .. TotalCollected
                
                local uniqueCount = 0
                for _, count in pairs(FruitCounts) do
                    if count > 0 then uniqueCount = uniqueCount + 1
                end
                UniqueFruitsLabel.Text = "⭐ Unique Fruits Collected: " .. uniqueCount .. "/45"
                
                local totalValue = 0
                for fruitName, count in pairs(FruitCounts) do
                    for _, fruit in ipairs(FruitTypes) do
                        if fruit.Name == fruitName then
                            totalValue = totalValue + (fruit.Value * count)
                            break
                        end
                    end
                end
                TotalValueLabel.Text = "💰 Total Fruit Value: $" .. string.format("%.1f", totalValue/1000) .. "k"
            end)
        end
    end)
    
    -- Fruit Categories
    yPos = CreateSection(ContentScrolling, yPos, "🍇 COMMON FRUITS (7)")
    for _, fruit in ipairs(FruitTypes) do
        if fruit.Rarity == "Common" then
            local FruitLabel = Instance.new("TextLabel")
            FruitLabel.Size = UDim2.new(1, -10, 0, 25)
            FruitLabel.Position = UDim2.new(0, 5, 0, yPos)
            FruitLabel.BackgroundTransparency = 1
            FruitLabel.Text = "• " .. fruit.Name .. " (Value: $" .. string.format("%.1f", fruit.Value/1000) .. "k)"
            FruitLabel.TextColor3 = fruit.Color
            FruitLabel.TextScaled = true
            FruitLabel.Font = Enum.Font.Gotham
            FruitLabel.TextXAlignment = Enum.TextXAlignment.Left
            FruitLabel.Parent = ContentScrolling
            yPos = yPos + 28
        end
    end
    
    yPos = CreateSection(ContentScrolling, yPos, "⭐ RARE FRUITS (12)")
    for _, fruit in ipairs(FruitTypes) do
        if fruit.Rarity == "Rare" then
            local FruitLabel = Instance.new("TextLabel")
            FruitLabel.Size = UDim2.new(1, -10, 0, 25)
            FruitLabel.Position = UDim2.new(0, 5, 0, yPos)
            FruitLabel.BackgroundTransparency = 1
            FruitLabel.Text = "• " .. fruit.Name .. " (Value: $" .. string.format("%.1f", fruit.Value/1000) .. "k)"
            FruitLabel.TextColor3 = fruit.Color
            FruitLabel.TextScaled = true
            FruitLabel.Font = Enum.Font.Gotham
            FruitLabel.TextXAlignment = Enum.TextXAlignment.Left
            FruitLabel.Parent = ContentScrolling
            yPos = yPos + 28
        end
    end
    
    yPos = CreateSection(ContentScrolling, yPos, "✨ LEGENDARY FRUITS (18)")
    for _, fruit in ipairs(FruitTypes) do
        if fruit.Rarity == "Legendary" then
            local FruitLabel = Instance.new("TextLabel")
            FruitLabel.Size = UDim2.new(1, -10, 0, 25)
            FruitLabel.Position = UDim2.new(0, 5, 0, yPos)
            FruitLabel.BackgroundTransparency = 1
            FruitLabel.Text = "• " .. fruit.Name .. " (Value: $" .. string.format("%.1f", fruit.Value/1000) .. "k)"
            FruitLabel.TextColor3 = fruit.Color
            FruitLabel.TextScaled = true
            FruitLabel.Font = Enum.Font.Gotham
            FruitLabel.TextXAlignment = Enum.TextXAlignment.Left
            FruitLabel.Parent = ContentScrolling
            yPos = yPos + 28
        end
    end
    
    yPos = CreateSection(ContentScrolling, yPos, "🌟 MYTHICAL FRUITS (8)")
    for _, fruit in ipairs(FruitTypes) do
        if fruit.Rarity == "Mythical" then
            local FruitLabel = Instance.new("TextLabel")
            FruitLabel.Size = UDim2.new(1, -10, 0, 25)
            FruitLabel.Position = UDim2.new(0, 5, 0, yPos)
            FruitLabel.BackgroundTransparency = 1
            FruitLabel.Text = "• " .. fruit.Name .. " ⭐ (Value: $" .. string.format("%.1f", fruit.Value/1000) .. "k)"
            FruitLabel.TextColor3 = fruit.Color
            FruitLabel.TextScaled = true
            FruitLabel.Font = Enum.Font.GothamBold
            FruitLabel.TextXAlignment = Enum.TextXAlignment.Left
            FruitLabel.Parent = ContentScrolling
            yPos = yPos + 28
        end
    end
