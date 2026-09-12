return require(game.ReplicatedStorage.Packages.Red).SharedEvent("ParachuteAlarm", function(p1) -- Line: 3
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    local session = p1.session
    if action ~= "Start" and action ~= "Stop" then
        return nil
    end
    if typeof(session) == "string" and session ~= "" then
        if action == "Start" then
            local config = p1.config
            if config ~= nil and typeof(config) ~= "table" then
                return nil
            end
            return {action = action, session = session, config = config}
        end
        if p1.makeRed ~= nil then
            local makeRed = p1.makeRed
            if typeof(makeRed) ~= "boolean" then
                return nil
            end
        end
        return {action = action, session = session, makeRed = p1.makeRed}
    end
    return nil
end)