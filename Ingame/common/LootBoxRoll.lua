local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemData = require(ReplicatedStorage.common:WaitForChild("ItemData"))
local LevelInfo = require(ReplicatedStorage.common:WaitForChild("LevelInfo"))
local v1 = {}
function v1.ChooseRarity(p1, p2) -- Line: 11
    local v1 = p2:NextInteger(1, 100)
    local v2 = 0
    for k, v in pairs(p1) do
        v2 = v2 + v
        if v1 <= v2 then
            return k
        end
    end
    return nil
end
function v1.BuildPool(p1, p2, p3) -- Line: 23 -- upvalues: ItemData (val), LevelInfo (val)
    local Slot = p1.Slot
    local v1 = {}
    for k, v in pairs(ItemData:GetByCriteria("All", p2, Slot, true)) do
        if Slot ~= "Outfit" then
            if Slot ~= "Arcade" then
                if Slot ~= "Cyberpunk" then
                    if not v.ArcadeSkin and not v.WorldCupSkin and not v.CyberpunkSkin then
                        table.insert(v1, k)
                    end
                elseif v.CyberpunkSkin then
                    table.insert(v1, k)
                end
            elseif v.ArcadeSkin then
                table.insert(v1, k)
            end
        elseif not (LevelInfo.OwnsWeapon(p3, k)) then
            table.insert(v1, k)
        end
    end
    return v1
end
return v1