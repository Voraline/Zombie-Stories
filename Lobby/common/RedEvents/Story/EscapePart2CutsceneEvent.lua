return require(game.ReplicatedStorage.Packages.Red).SharedEvent("EscapePart2Cutscene", function(p1) -- Line: 3
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if action ~= "Play" then
        local v1
        if action ~= "StartEndCutscene" then
            if action == "Stop" or action == "CompleteEndCutscene" then
                return {action = action}
            end
            return nil
        end
        local v2 = if typeof(p1.triggeringPlayerName) == "string" then string.sub(p1.triggeringPlayerName, 1, 32) else nil
        local v3 = nil
        if typeof(p1.animations) ~= "table" then
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
        local rotorSoundId = nil
        if typeof(v1.rotorSoundId) == "string" then
            rotorSoundId = v1.rotorSoundId
        end
        return {action = action, triggeringPlayerName = v2, animations = v3, rotorSoundId = rotorSoundId}
    else
        local cameraCFrame = p1.cameraCFrame
        local travelTime = p1.travelTime
        local holdTime = p1.holdTime
        if cameraCFrame == nil then
            if travelTime == nil then
                if holdTime ~= nil then
                    if typeof(holdTime) ~= "number" then
                        return nil
                    end
                    return {action = action, cameraCFrame = cameraCFrame, travelTime = travelTime, holdTime = holdTime}
                end
                return {action = action, cameraCFrame = cameraCFrame, travelTime = travelTime, holdTime = holdTime}
            end
            if typeof(travelTime) ~= "number" then
                return nil
            end
            if holdTime == nil then
                return {action = action, cameraCFrame = cameraCFrame, travelTime = travelTime, holdTime = holdTime}
            end
            if typeof(holdTime) ~= "number" then
                return nil
            end
            return {action = action, cameraCFrame = cameraCFrame, travelTime = travelTime, holdTime = holdTime}
        elseif typeof(cameraCFrame) ~= "CFrame" then
            return nil
        end
    end
end)