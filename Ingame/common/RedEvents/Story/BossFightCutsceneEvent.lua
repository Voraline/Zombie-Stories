local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Packages.Red).SharedEvent("BossFightCutscene", function(p1) -- Line: 5
    local direction, duration, easing, style
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if typeof(action) ~= "string" then
        return nil
    end
    if action ~= "StartIntro" then
        if action == "BossReachedWaypoint" then
            local index = p1.index
            if typeof(index) ~= "number" then
                return nil
            end
            local v1 = math.floor(index)
            return {action = action, index = v1}
        end
        if action == "TriggerFlash" then
            local position = p1.position
            if typeof(position) ~= "Vector3" then
                return nil
            end
            local fadeIn = p1.fadeIn
            if typeof(fadeIn) ~= "number" then
                fadeIn = 0.35
            elseif fadeIn >= 0 then
            end
            local hold = p1.hold
            if typeof(hold) ~= "number" then
                hold = 0.4
            elseif hold >= 0 then
            end
            local fadeOut = p1.fadeOut
            if typeof(fadeOut) ~= "number" then
                fadeOut = 0.6
            elseif fadeOut < 0 then
                fadeOut = 0.6
            end
            return {
                action = action,
                position = position,
                fadeIn = fadeIn,
                hold = hold,
                fadeOut = fadeOut,
            }
        end
        if action == "EndFlash" or action == "BossSpawned" or action == "EndCutscene" then
            return {action = action}
        end
        return nil
    end
    local sequences = p1.sequences
    if typeof(sequences) ~= "table" then
        return nil
    end
    local v2 = {}
    for i, v in ipairs(sequences) do
        if typeof(v) ~= "table" then
            return nil
        end
        duration = v.duration
        if typeof(duration) == "number" and duration > 0 then
            easing = v.easing
            if easing == nil then
                v2[i] = {duration = duration}
                continue
            end
            if typeof(easing) ~= "table" then
                return nil
            end
            style = easing.style
            direction = easing.direction
            if style ~= nil and typeof(style) ~= "EnumItem" then
                return nil
            end
            if direction ~= nil and typeof(direction) ~= "EnumItem" then
                return nil
            end
            v2[i] = {
                duration = duration,
                easing = {style = style, direction = direction},
            }
            continue
        end
        return nil
    end
    local cutsceneMode = p1.cutsceneMode
    if cutsceneMode ~= nil and typeof(cutsceneMode) ~= "string" then
        cutsceneMode = nil
    end
    return {action = action, sequences = v2, cutsceneMode = cutsceneMode}
end)