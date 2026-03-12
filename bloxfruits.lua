-- BloxFruits PvP Script Concept
local Player = game.Players.LocalPlayer
local Character = Player.Character

if not Character then return end -- Wait for character to load if needed

local ToolEquipped = false

function OnToolAcquire()
    local tool = script.Parent -- Assuming this is attached to your tool
    
    if tool:IsA("Tool") and not ToolEquipped then
        tool.Equipped:Connect(function() 
            -- Equip logic here
            print("Weapon equipped")
            
            -- Disable default physics for more responsive attack
            tool.Handle.Shape.Transparency = 1
            
            -- Make attacks faster than normal tools
            tool.Handle.CollisionGroupId = "Attack"
            ToolEquipped = true
        end)
        
        tool.Unequipped:Connect(function()
            -- Unequip logic here
            print("Weapon unequipped")
            
            -- Restore physics settings
            tool.Handle.Shape.Transparency = 0
            
            tool.Handle.CollisionGroupId = nil 
            ToolEquipped = false
        end)
    end
end

OnToolAcquire() -- Initialize on load or character change

-- Optional: Monitor for character changes to reset
Player.CharacterAdded:Connect(function(newChar) 
    Character = newChar
    OnToolAcquire()
end)
