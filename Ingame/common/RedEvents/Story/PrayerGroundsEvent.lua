local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Red = require(ReplicatedStorage.Packages.Red)

local function sanitizeSequence(p1) -- Line: 5
    if typeof(p1) ~= "table" then
        return nil
    end
    local v1 = {}
    for i, v in ipairs(p1) do
        if typeof(v) ~= "string" then
            return nil
        end
        table.insert(v1, v)
    end
    if #v1 == 0 then
        return nil
    end
    return v1
end

return Red.SharedEvent("PrayerGrounds", function(p1) -- Line: 25 -- upvalues: sanitizeSequence (val)
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if typeof(action) ~= "string" then
        return nil
    end
    if action == "Configure" then
        local v1 = sanitizeSequence(p1.sequence)
        if not v1 then
            return nil
        end
        local resetDelay = p1.resetDelay
        if typeof(resetDelay) ~= "number" then
            resetDelay = nil
        end
        return {action = action, sequence = v1, resetDelay = resetDelay}
    end
    if action ~= "Disable" and action ~= "PuzzleComplete" then
        if action ~= "CorrectTile" and action ~= "WrongTile" then
            if action == "RequestState" then
                return {action = action}
            end
            return nil
        end
        local tileId = p1.tileId
        if typeof(tileId) ~= "string" then
            return nil
        end
        return {action = action, tileId = tileId}
    end
    return {action = action}
end)