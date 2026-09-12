return require(game.ReplicatedStorage.Packages.Red).SharedEvent("EscapePart2Cutscene", function(p1) -- Line: 3
    local v1
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if action == "Play" then
        local cameraCFrame = p1.cameraCFrame
        local travelTime = p1.travelTime
        local holdTime = p1.holdTime
        if cameraCFrame ~= nil and typeof(cameraCFrame) ~= "CFrame" then
            return nil
        end
        if travelTime ~= nil and typeof(travelTime) ~= "number" then
            return nil
        end
        if holdTime ~= nil and typeof(holdTime) ~= "number" then
            return nil
        end
        return {action = action, cameraCFrame = cameraCFrame, travelTime = travelTime, holdTime = holdTime}
    end
    if action ~= "StartEndCutscene" then
        if action == "Stop" or action == "CompleteEndCutscene" then
            return {action = action}
        end
        return nil
    end
    local v2 = nil
    local triggeringPlayerName = p1.triggeringPlayerName
    if typeof(triggeringPlayerName) == "string" then
        local triggeringPlayerName_2 = p1.triggeringPlayerName
        v2 = string.sub(triggeringPlayerName_2, 1, 32)
    end
    local v3 = nil
    local animations = p1.animations
    if typeof(animations) ~= "table" then
        v1 = p1
    else
        local id, v4, v5
        v3 = {}
        v1 = p1
        for k, v in pairs(p1.animations) do
            if typeof(k) == "string" and typeof(v) == "table" then
                id = v.id
                if typeof(id) == "string" then
                    v4 = {id = id}
                    v5 = v.looped == true
                    v4.looped = v5
                    v3[k] = v4
                end
            end
        end
    end
    local rotorSoundId_2 = nil
    local rotorSoundId = v1.rotorSoundId
    if typeof(rotorSoundId) == "string" then
        rotorSoundId_2 = v1.rotorSoundId
    end
    return {action = action, triggeringPlayerName = v2, animations = v3, rotorSoundId = rotorSoundId_2}
end)