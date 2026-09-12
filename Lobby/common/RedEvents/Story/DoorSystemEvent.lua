return require(game.ReplicatedStorage.Packages.Red).SharedEvent("DoorSystem", function(p1) -- Line: 3
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    local doorId = p1.doorId
    local state = p1.state
    if typeof(action) == "string" and typeof(doorId) == "string" then
        if action == "Proximity" then
            if typeof(state) ~= "boolean" then
                return nil
            end
            return {action = action, doorId = doorId, state = state}
        end
        if action ~= "StopCycle" then
            return nil
        end
        if state ~= nil and typeof(state) ~= "boolean" then
            return nil
        end
        return {action = action, doorId = doorId, state = state}
    end
    return nil
end)