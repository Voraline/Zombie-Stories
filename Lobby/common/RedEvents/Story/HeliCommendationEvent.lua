local Red = require(game.ReplicatedStorage.Packages.Red)
local function cleanString(p1, p2) -- Line: 3
    if typeof(p1) ~= "string" or p2 < #p1 then
        return nil
    end
    return p1
end
local function cleanEntry(p1) -- Line: 10
    local v1, v2, v3, v4
    if typeof(p1) ~= "table" then
        return nil
    end
    local v5 = tonumber(p1.userId)
    local v6 = tonumber(p1.seatIndex)
    local name = p1.name
    if typeof(name) ~= "string" then
        v1 = nil
    elseif 80 >= #name then
        v1 = name
    end
    local id = p1.id
    if typeof(id) ~= "string" then
        v2 = nil
    elseif 40 >= #id then
        v2 = id
    end
    local title = p1.title
    if typeof(title) ~= "string" then
        v3 = nil
    elseif 80 >= #title then
        v3 = title
    end
    local descriptor = p1.descriptor
    if typeof(descriptor) ~= "string" then
        v4 = nil
    elseif 120 >= #descriptor then
        v4 = descriptor
    end
    if not v5 then
        return nil
    elseif v5 < 0 then
        return nil
    elseif v5 ~= math.floor(v5) then
        return nil
    elseif not v6 then
        return nil
    elseif v6 < 1 then
        return nil
    elseif 6 < v6 then
        return nil
    elseif v6 ~= math.floor(v6) then
        return nil
    elseif not v1 then
        return nil
    elseif not v2 then
        return nil
    elseif not v3 then
        return nil
    else
        local v7, v8
        if not v4 then
            return nil
        end
        local value = p1.value
        local v9 = p1.valueIsNumeric == true
        local v10 = tonumber(p1.countUpDuration)
        local v11 = tonumber(p1.presentationSeconds)
        if not v9 then
            local v12
            local v13 = value
            if typeof(v13) ~= "string" then
                v8 = nil
            elseif 80 >= #v13 then
                v8 = v13
            end
            if not v8 then
                return nil
            end
            v10 = nil
            v7 = p1
            if not v11 then
                v13 = {
                    userId = v5,
                    name = v1,
                    seatIndex = v6,
                    id = v2,
                    title = v3,
                    descriptor = v4,
                    value = v8,
                    valueIsNumeric = v9,
                }
                v12 = v7.isSuperlative == true
                v13.isSuperlative = v12
                v13.countUpDuration = v10
                v13.presentationSeconds = v11
                return v13
            end
            if v11 < 1 or 15 < v11 then
                return nil
            end
            v13 = {
                userId = v5,
                name = v1,
                seatIndex = v6,
                id = v2,
                title = v3,
                descriptor = v4,
                value = v8,
                valueIsNumeric = v9,
            }
            v12 = v7.isSuperlative == true
            v13.isSuperlative = v12
            v13.countUpDuration = v10
            v13.presentationSeconds = v11
            return v13
        else
            v8 = tonumber(value)
            if not v8 then
                return nil
            elseif v8 ~= v8 then
                return nil
            elseif v8 < 0 then
                return nil
            else
                if (1 / 0) <= v8 then
                    return nil
                end
                if not v10 then
                    v7 = p1
                elseif v10 < 0.1 then
                    return nil
                else
                    if 10 < v10 then
                        return nil
                    end
                    v7 = p1
                end
            end
        end
    end
end
return Red.SharedEvent("HeliCommendation", function(p1) -- Line: 75 -- upvalues: cleanEntry (val)
    local v1, v2
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if action == "Stop" then
        return {action = action}
    end
    if action ~= "Start" or typeof(p1.entries) ~= "table" then
        return nil
    end
    local v3 = tonumber(p1.secondsPerPlayer)
    local outcome = p1.outcome
    if typeof(outcome) ~= "string" then
        v2 = nil
    elseif 20 >= #outcome then
        v2 = outcome
    end
    if not v3 or v3 < 1 or 15 < v3 or not v2 then
        return nil
    end
    local v4 = {}
    for i, v in ipairs(p1.entries) do
        if 6 < i then
            return nil
        end
        v1 = cleanEntry(v)
        if not v1 then
            return nil
        end
        table.insert(v4, v1)
    end
    if #v4 == 0 then
        return nil
    end
    return {action = action, entries = v4, secondsPerPlayer = v3, outcome = v2}
end)