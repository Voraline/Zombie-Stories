local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Red = require(ReplicatedStorage.Packages.Red)
local function sanitizeString(p1, p2) -- Line: 10
    local v1
    if typeof(p1) ~= "string" then
        return p2
    end
    if 120 >= #p1 then
        v1 = p1
    else
        v1 = string.sub(p1, 1, 120)
    end
    return v1
end
local function sanitizePath(p1) -- Line: 22
    local v1, v2
    if p1 == nil or typeof(p1) ~= "table" then
        return nil
    end
    local v3 = {}
    for i, v in ipairs(p1) do
        v2 = v
        if typeof(v2) == "string" then
            if 120 < #v2 then
                v2 = string.sub(v2, 1, 120)
            end
            v1 = v2
        else
            v1 = nil
        end
        if v1 and v1 ~= "" then
            table.insert(v3, v1)
            continue
        end
        return nil
    end
    if #v3 == 0 then
        return nil
    end
    return v3
end
local function sanitizeBodyParts(p1) -- Line: 47 -- upvalues: sanitizePath (val)
    local id, name, v1, v2, v3, v4
    if typeof(p1) ~= "table" then
        return {}
    end
    local v5 = {}
    for i, v in ipairs(p1) do
        if 12 < i then
            break
        end
        if typeof(v) == "table" then
            id = v.id
            if not id then
                id = v.bodyPartId
            end
            if typeof(id) == "string" then
                if 120 < #id then
                    id = string.sub(id, 1, 120)
                end
                v2 = id
            else
                v2 = nil
            end
            name = v.name
            if not name then
                name = v.displayName
            end
            if typeof(name) == "string" then
                if 120 < #name then
                    name = string.sub(name, 1, 120)
                end
                v3 = name
            else
                v3 = nil
            end
            v4 = {}
            if typeof(v.partPaths) == "table" then
                for i2, i3 in ipairs(v.partPaths) do
                    if 12 < i2 then
                        break
                    end
                    v1 = sanitizePath(i3)
                    if v1 then
                        table.insert(v4, v1)
                    end
                end
            end
            if v2 and v3 and 0 < #v4 then
                table.insert(v5, {id = v2, name = v3, partPaths = v4})
            end
        end
    end
    return v5
end
local function sanitizeCapsules(p1) -- Line: 89 -- upvalues: sanitizePath (val), sanitizeBodyParts (val)
    local bodyParts, id, label, modelPath, shortLabel, v1, v2, v3, v4, zombieModelRef
    if typeof(p1) ~= "table" then
        return {}
    end
    local v5 = {}
    for i, v in ipairs(p1) do
        if 50 < i then
            break
        end
        if typeof(v) == "table" then
            id = v.id
            if typeof(id) == "number" then
                id = math.floor(id)
            elseif typeof(id) == "string" then
                id = tonumber(id)
                if id then
                    id = math.floor(id)
                end
            end
            if typeof(id) == "number" and 1 <= id then
                label = v.label
                v1 = string.format("Capsule #%02d", id)
                if typeof(label) == "string" then
                    if 120 < #label then
                        label = string.sub(label, 1, 120)
                    end
                    v3 = label
                else
                    v3 = v1
                end
                shortLabel = v.shortLabel
                if typeof(shortLabel) == "string" then
                    if 120 < #shortLabel then
                        shortLabel = string.sub(shortLabel, 1, 120)
                    end
                    v4 = shortLabel
                else
                    v4 = nil
                end
                modelPath = v.modelPath
                if not modelPath then
                    modelPath = v.path
                end
                v1 = sanitizePath(modelPath)
                bodyParts = v.bodyParts
                if not bodyParts then
                    bodyParts = v.zones
                end
                v2 = sanitizeBodyParts(bodyParts)
                zombieModelRef = nil
                if typeof(v.zombieModelRef) == "Instance" then
                    zombieModelRef = v.zombieModelRef
                end
                table.insert(v5, {
                    id = id,
                    label = v3,
                    shortLabel = v4,
                    modelPath = v1,
                    bodyParts = v2,
                    zombieModelRef = zombieModelRef,
                })
            end
        end
    end
    return v5
end
local function sanitizeScanState(p1) -- Line: 136
    local v1, v2
    if typeof(p1) ~= "table" then
        return nil
    end
    local mode = p1.mode
    if typeof(mode) == "string" then
        if 120 < #mode then
            mode = string.sub(mode, 1, 120)
        end
        v1 = mode
    else
        v1 = "idle"
    end
    local v3 = if typeof(p1.capsuleId) == "number" then math.floor(p1.capsuleId) else nil
    local v4 = if typeof(p1.duration) == "number" then math.max(0, p1.duration) else nil
    local v5 = if typeof(p1.remaining) == "number" then math.max(0, p1.remaining) else nil
    local startedBy = p1.startedBy
    if typeof(startedBy) == "string" then
        if 120 < #startedBy then
            startedBy = string.sub(startedBy, 1, 120)
        end
        v2 = startedBy
    else
        v2 = nil
    end
    local v6 = if typeof(p1.cooldown) == "number" then math.max(0, p1.cooldown) else nil
    return {
        mode = v1,
        capsuleId = v3,
        duration = v4,
        remaining = v5,
        startedBy = v2,
        cooldown = v6,
    }
end
return Red.SharedEvent("ResearchRoom", function(p1) -- Line: 173 -- upvalues: sanitizeCapsules (val), sanitizeScanState (val)
    local capsuleId, v1, v2, v3, v4
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if typeof(action) == "string" then
        if 120 < #action then
            action = string.sub(action, 1, 120)
        end
        v1 = action
    else
        v1 = nil
    end
    if not v1 then
        return nil
    end
    if v1 == "OpenXRay" then
        local sessionId = p1.sessionId
        if typeof(sessionId) == "string" then
            if 120 < #sessionId then
                sessionId = string.sub(sessionId, 1, 120)
            end
            v2 = sessionId
        else
            v2 = nil
        end
        local capsules = p1.capsules
        if not capsules then
            capsules = {}
        end
        v3 = sanitizeCapsules(capsules)
        v4 = if typeof(p1.focusId) == "number" then math.floor(p1.focusId) else nil
        return {action = v1, sessionId = v2, capsules = v3, focusId = v4}
    end
    if v1 == "CloseXRay" then
        return {action = v1}
    end
    if v1 == "OpenScan" then
        local sessionId_2 = p1.sessionId
        if typeof(sessionId_2) == "string" then
            if 120 < #sessionId_2 then
                sessionId_2 = string.sub(sessionId_2, 1, 120)
            end
            v2 = sessionId_2
        else
            v2 = nil
        end
        local capsules_2 = p1.capsules
        if not capsules_2 then
            capsules_2 = {}
        end
        v3 = sanitizeCapsules(capsules_2)
        v4 = sanitizeScanState(p1.scanState)
        return {action = v1, sessionId = v2, capsules = v3, scanState = v4}
    end
    if v1 == "ScanState" then
        v2 = sanitizeScanState(p1.scanState)
        if not v2 then
            return nil
        end
        return {action = v1, scanState = v2}
    end
    if v1 ~= "ScanResult" then
        if v1 == "ConsoleInUse" then
            local by = p1.by
            if typeof(by) == "string" then
                if 120 < #by then
                    by = string.sub(by, 1, 120)
                end
                v2 = by
            else
                v2 = nil
            end
            return {action = v1, by = v2}
        end
        if v1 == "RequestScanStatus" then
            return {action = v1}
        end
        if v1 ~= "StartScan" then
            if v1 ~= "CloseScan" then
                if v1 == "CloseXRayClient" or v1 == "RequestXRayData" then
                    return {action = v1}
                end
                return nil
            end
            return {action = v1}
        end
        capsuleId = p1.capsuleId
        if typeof(capsuleId) == "number" then
            capsuleId = math.floor(capsuleId)
        elseif typeof(capsuleId) == "string" then
            capsuleId = tonumber(capsuleId)
            if capsuleId then
                capsuleId = math.floor(capsuleId)
            end
        end
        if typeof(capsuleId) ~= "number" or capsuleId < 1 then
            return nil
        end
        return {action = v1, capsuleId = capsuleId}
    else
        local result = p1.result
        if typeof(result) == "string" then
            if 120 < #result then
                result = string.sub(result, 1, 120)
            end
            v2 = result
        else
            v2 = nil
        end
        if v2 == "success" then
            v3 = if typeof(p1.capsuleId) == "number" then math.floor(p1.capsuleId) else nil
            local message = p1.message
            if typeof(message) == "string" then
                if 120 < #message then
                    message = string.sub(message, 1, 120)
                end
                v4 = message
            else
                v4 = nil
            end
            local v5 = if typeof(p1.cooldown) == "number" then math.max(0, p1.cooldown) else nil
            return {
                action = v1,
                result = v2,
                capsuleId = v3,
                message = v4,
                cooldown = v5,
            }
        elseif v2 ~= "failure" then
            return nil
        end
    end
end)