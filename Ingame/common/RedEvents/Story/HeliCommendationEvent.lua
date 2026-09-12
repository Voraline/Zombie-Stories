local Red = require(game.ReplicatedStorage.Packages.Red)

local function cleanString(p1, p2) -- Line: 3
    if typeof(p1) == "string" and not (p2 < #p1) then
        return p1
    end
    return nil
end

local function cleanEntry(p1) -- Line: 10
    local v1, v2, v3, v4
    if typeof(p1) ~= "table" then
        return nil
    end
    local userId = p1.userId
    local v5 = tonumber(userId)
    local seatIndex = p1.seatIndex
    local v6 = tonumber(seatIndex)
    local name = p1.name
    if typeof(name) ~= "string" then
        v1 = nil
    elseif not (80 < #name) then
        v1 = name
    else
        v1 = nil
    end
    local id = p1.id
    if typeof(id) ~= "string" then
        v2 = nil
    elseif not (40 < #id) then
        v2 = id
    else
        v2 = nil
    end
    local title = p1.title
    if typeof(title) ~= "string" then
        v3 = nil
    elseif not (80 < #title) then
        v3 = title
    else
        v3 = nil
    end
    local descriptor = p1.descriptor
    if typeof(descriptor) ~= "string" then
        v4 = nil
    elseif not (120 < #descriptor) then
        v4 = descriptor
    else
        v4 = nil
    end
    if v5
        and not (v5 < 0)
        and v5 == math.floor(v5)
        and v6
        and not (v6 < 1)
        and not (6 < v6)
        and v6 == math.floor(v6)
        and v1
        and v2
        and v3
        and v4 then
        local v7, v8, v9, v10
        local value = p1.value
        local v11 = p1.valueIsNumeric == true
        local countUpDuration = p1.countUpDuration
        local v12 = tonumber(countUpDuration)
        local presentationSeconds = p1.presentationSeconds
        local v13 = tonumber(presentationSeconds)
        if not v11 then
            v8 = value
            if typeof(v8) ~= "string" then
                v10 = nil
            elseif not (80 < #v8) then
                v10 = v8
            else
                v10 = nil
            end
            if not v10 then
                return nil
            end
            v12 = nil
            v7 = p1
            if v13 then
                if not (v13 < 1) and not (15 < v13) then
                    v8 = {
                        userId = v5,
                        name = v1,
                        seatIndex = v6,
                        id = v2,
                        title = v3,
                        descriptor = v4,
                        value = v10,
                        valueIsNumeric = v11,
                    }
                    v9 = v7.isSuperlative == true
                    v8.isSuperlative = v9
                    v8.countUpDuration = v12
                    v8.presentationSeconds = v13
                    return v8
                end
                return nil
            end
            v8 = {
                userId = v5,
                name = v1,
                seatIndex = v6,
                id = v2,
                title = v3,
                descriptor = v4,
                value = v10,
                valueIsNumeric = v11,
            }
            v9 = v7.isSuperlative == true
            v8.isSuperlative = v9
            v8.countUpDuration = v12
            v8.presentationSeconds = v13
            return v8
        end
        v10 = tonumber(value)
        if v10 and v10 == v10 and not (v10 < 0) and not ((1 / 0) <= v10) then
            if not v12 then
                v7 = p1
                if v13 then
                    if not (v13 < 1) and not (15 < v13) then
                        v8 = {
                            userId = v5,
                            name = v1,
                            seatIndex = v6,
                            id = v2,
                            title = v3,
                            descriptor = v4,
                            value = v10,
                            valueIsNumeric = v11,
                        }
                        v9 = v7.isSuperlative == true
                        v8.isSuperlative = v9
                        v8.countUpDuration = v12
                        v8.presentationSeconds = v13
                        return v8
                    end
                    return nil
                end
                v8 = {
                    userId = v5,
                    name = v1,
                    seatIndex = v6,
                    id = v2,
                    title = v3,
                    descriptor = v4,
                    value = v10,
                    valueIsNumeric = v11,
                }
                v9 = v7.isSuperlative == true
                v8.isSuperlative = v9
                v8.countUpDuration = v12
                v8.presentationSeconds = v13
                return v8
            end
            if not (v12 < 0.1) and not (10 < v12) then
                v7 = p1
                if not v13 then
                    v8 = {
                        userId = v5,
                        name = v1,
                        seatIndex = v6,
                        id = v2,
                        title = v3,
                        descriptor = v4,
                        value = v10,
                        valueIsNumeric = v11,
                    }
                    v9 = v7.isSuperlative == true
                    v8.isSuperlative = v9
                    v8.countUpDuration = v12
                    v8.presentationSeconds = v13
                    return v8
                end
                if not (v13 < 1) and not (15 < v13) then
                    v8 = {
                        userId = v5,
                        name = v1,
                        seatIndex = v6,
                        id = v2,
                        title = v3,
                        descriptor = v4,
                        value = v10,
                        valueIsNumeric = v11,
                    }
                    v9 = v7.isSuperlative == true
                    v8.isSuperlative = v9
                    v8.countUpDuration = v12
                    v8.presentationSeconds = v13
                    return v8
                end
                return nil
            end
            return nil
        end
        return nil
    end
    return nil
end

return Red.SharedEvent("HeliCommendation", function(p1) -- Line: 75 -- upvalues: cleanEntry (val)
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if action == "Stop" then
        return {action = action}
    end
    if action == "Start" then
        local entries = p1.entries
        if typeof(entries) == "table" then
            local v1
            local secondsPerPlayer = p1.secondsPerPlayer
            local v2 = tonumber(secondsPerPlayer)
            local outcome = p1.outcome
            if typeof(outcome) ~= "string" then
                v1 = nil
            elseif not (20 < #outcome) then
                v1 = outcome
            else
                v1 = nil
            end
            if v2 and not (v2 < 1) and not (15 < v2) and v1 then
                local v3
                local v4 = {}
                for i, v in ipairs(p1.entries) do
                    if 6 < i then
                        return nil
                    end
                    v3 = cleanEntry(v)
                    if not v3 then
                        return nil
                    end
                    table.insert(v4, v3)
                end
                if #v4 == 0 then
                    return nil
                end
                return {action = action, entries = v4, secondsPerPlayer = v2, outcome = v1}
            end
            return nil
        end
    end
    return nil
end)