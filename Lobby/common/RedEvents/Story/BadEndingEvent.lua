local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Red = require(ReplicatedStorage.Packages.Red)
local u9 = {StartHallucination = true, ShowSequence = true, Clear = true}
local function sanitizeBoolean(p1) -- Line: 14
    if typeof(p1) == "boolean" then
        return p1
    end
    return nil
end
local function sanitizeString(p1) -- Line: 21
    local v1
    if typeof(p1) ~= "string" then
        return nil
    end
    if 120 >= #p1 then
        v1 = p1
    else
        v1 = string.sub(p1, 1, 120)
    end
    return v1
end
local function sanitizeMessages(p1) -- Line: 31
    local text, v1, v2, v3
    if typeof(p1) ~= "table" then
        return {}
    end
    local v4 = {}
    for i, v in ipairs(p1) do
        if 6 < i then
            break
        end
        v1 = nil
        v2 = nil
        if typeof(v) == "table" then
            text = v.text
            if typeof(text) == "string" then
                if 120 < #text then
                    text = string.sub(text, 1, 120)
                end
                v1 = text
            else
                v1 = nil
            end
            if typeof(v.duration) == "number" then
                v2 = math.max(0.5, (math.min(v.duration, 10)))
            end
        elseif typeof(v) == "string" then
            v3 = v
            if typeof(v3) == "string" then
                if 120 < #v3 then
                    v3 = string.sub(v3, 1, 120)
                end
                v1 = v3
            else
                v1 = nil
            end
        end
        if v1 then
            table.insert(v4, {text = v1, duration = v2 or 3})
        end
    end
    return v4
end
local function sanitizeProfile(p1) -- Line: 65
    if typeof(p1) ~= "string" then
        return nil
    end
    local v1 = string.sub(p1, 1, 32)
    if v1 == "" then
        return nil
    end
    local v2 = string.lower(v1)
    if string.match(v2, "^[%w_%-%?%.]+$") then
        return v2
    end
    return nil
end
return Red.SharedEvent("BadEndingEvent", function(p1) -- Line: 83 -- upvalues: u9 (val), sanitizeMessages (val)
    local v1, v2, v3, v4
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if not (u9[action]) then
        return nil
    end
    if action ~= "StartHallucination" then
        if action == "ShowSequence" then
            v1 = if typeof(p1.fadeTime) == "number" then math.clamp(p1.fadeTime, 0, 5) else 1.5
            return {action = action, fadeTime = v1, messages = sanitizeMessages(p1.messages)}
        end
        return {action = action}
    end
    v1 = if typeof(p1.intensity) == "number" then math.clamp(p1.intensity, 0, 5) else 1
    local profile = p1.profile
    if typeof(profile) == "string" then
        v4 = string.sub(profile, 1, 32)
        if v4 ~= "" then
            local v5 = string.lower(v4)
            if not (string.match(v5, "^[%w_%-%?%.]+$")) then
                v2 = nil
            else
                v2 = v5
            end
        else
            v2 = nil
        end
    else
        v2 = nil
    end
    local resume = p1.resume
    if typeof(resume) ~= "boolean" then
        v3 = nil
    else
        v3 = resume
    end
    v4 = {action = action, intensity = v1}
    if v2 then
        v4.profile = v2
    end
    if v3 ~= nil then
        v4.resume = v3
    end
    return v4
end)