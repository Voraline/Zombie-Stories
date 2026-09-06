return require(game.ReplicatedStorage.Packages.Red).SharedEvent("ParachuteAlarm", function(p1) -- Line: 3
    local config
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    local session = p1.session
    if action == "Start" then
        if typeof(session) == "string" then
            if session == "" then
                return nil
            end
            if action ~= "Start" then
                if p1.makeRed ~= nil then
                    if typeof(p1.makeRed) ~= "boolean" then
                        return nil
                    end
                    return {action = action, session = session, makeRed = p1.makeRed}
                end
                return {action = action, session = session, makeRed = p1.makeRed}
            end
            config = p1.config
            if config == nil then
                return {action = action, session = session, config = config}
            end
            if typeof(config) ~= "table" then
                return nil
            end
            return {action = action, session = session, config = config}
        end
        return nil
    end
    if action ~= "Stop" or typeof(session) ~= "string" or session == "" then
        return nil
    end
    if action ~= "Start" then
        if p1.makeRed ~= nil then
            if typeof(p1.makeRed) ~= "boolean" then
                return nil
            end
            return {action = action, session = session, makeRed = p1.makeRed}
        end
        return {action = action, session = session, makeRed = p1.makeRed}
    end
    config = p1.config
    if config == nil then
        return {action = action, session = session, config = config}
    end
    if typeof(config) ~= "table" then
        return nil
    end
    return {action = action, session = session, config = config}
end)