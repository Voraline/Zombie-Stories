local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Red = require(ReplicatedStorage.Packages.Red)

local function sanitizeString(p1, p2) -- Line: 10
    local v1
    if typeof(p1) ~= "string" then
        return p2
    end
    if not (120 < #p1) then
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
    local id, name, partPaths, v1, v2, v3, v4, v5
    if typeof(p1) ~= "table" then
        return {}
    end
    local v6 = {}
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
                v3 = id
            else
                v3 = nil
            end
            name = v.name
            if not name then
                name = v.displayName
            end
            if typeof(name) == "string" then
                if 120 < #name then
                    name = string.sub(name, 1, 120)
                end
                v4 = name
            else
                v4 = nil
            end
            v5 = {}
            partPaths = v.partPaths
            if typeof(partPaths) == "table" then
                for i2, i3 in ipairs(v.partPaths) do
                    if 12 < i2 then
                        break
                    end
                    v2 = sanitizePath(i3)
                    if v2 then
                        table.insert(v5, v2)
                    end
                end
            end
            if v3 and v4 and 0 < #v5 then
                v1 = {id = v3, name = v4, partPaths = v5}
                table.insert(v6, v1)
            end
        end
    end
    return v6
end

local function sanitizeCapsules(p1) -- Line: 89 -- upvalues: sanitizePath (val), sanitizeBodyParts (val)
    local bodyParts, id, label, modelPath, shortLabel, v1, v2, v3, v4, v5, zombieModelRef, zombieModelRef_2
    if typeof(p1) ~= "table" then
        return {}
    end
    local v6 = {}
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
                    v4 = label
                else
                    v4 = v1
                end
                shortLabel = v.shortLabel
                if typeof(shortLabel) == "string" then
                    if 120 < #shortLabel then
                        shortLabel = string.sub(shortLabel, 1, 120)
                    end
                    v5 = shortLabel
                else
                    v5 = nil
                end
                v1 = sanitizePath
                modelPath = v.modelPath
                if not modelPath then
                    modelPath = v.path
                end
                v1 = v1(modelPath)
                v2 = sanitizeBodyParts
                bodyParts = v.bodyParts
                if not bodyParts then
                    bodyParts = v.zones
                end
                v2 = v2(bodyParts)
                zombieModelRef_2 = nil
                zombieModelRef = v.zombieModelRef
                if typeof(zombieModelRef) == "Instance" then
                    zombieModelRef_2 = v.zombieModelRef
                end
                v3 = {
                    id = id,
                    label = v4,
                    shortLabel = v5,
                    modelPath = v1,
                    bodyParts = v2,
                    zombieModelRef = zombieModelRef_2,
                }
                table.insert(v6, v3)
            end
        end
    end
    return v6
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
    local v3 = nil
    local capsuleId = p1.capsuleId
    if typeof(capsuleId) == "number" then
        local capsuleId_2 = p1.capsuleId
        v3 = math.floor(capsuleId_2)
    end
    local v4 = nil
    local duration = p1.duration
    if typeof(duration) == "number" then
        local duration_2 = p1.duration
        v4 = math.max(0, duration_2)
    end
    local v5 = nil
    local remaining = p1.remaining
    if typeof(remaining) == "number" then
        local remaining_2 = p1.remaining
        v5 = math.max(0, remaining_2)
    end
    local startedBy = p1.startedBy
    if typeof(startedBy) == "string" then
        if 120 < #startedBy then
            startedBy = string.sub(startedBy, 1, 120)
        end
        v2 = startedBy
    else
        v2 = nil
    end
    local v6 = nil
    local cooldown = p1.cooldown
    if typeof(cooldown) == "number" then
        local cooldown_2 = p1.cooldown
        v6 = math.max(0, cooldown_2)
    end
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
    local v1, v2, v3, v4
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
        v3 = sanitizeCapsules
        local capsules = p1.capsules
        if not capsules then
            capsules = {}
        end
        v3 = v3(capsules)
        v4 = nil
        local focusId = p1.focusId
        if typeof(focusId) == "number" then
            local focusId_2 = p1.focusId
            v4 = math.floor(focusId_2)
        end
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
        v3 = sanitizeCapsules
        local capsules_2 = p1.capsules
        if not capsules_2 then
            capsules_2 = {}
        end
        v3 = v3(capsules_2)
        return {action = v1, sessionId = v2, capsules = v3, scanState = sanitizeScanState(p1.scanState)}
    end
    if v1 == "ScanState" then
        v2 = sanitizeScanState(p1.scanState)
        if not v2 then
            return nil
        end
        return {action = v1, scanState = v2}
    end
    if v1 == "ScanResult" then
        local result = p1.result
        if typeof(result) == "string" then
            if 120 < #result then
                result = string.sub(result, 1, 120)
            end
            v2 = result
        else
            v2 = nil
        end
        if v2 ~= "success" and v2 ~= "failure" then
            return nil
        end
        v3 = nil
        local capsuleId = p1.capsuleId
        if typeof(capsuleId) == "number" then
            local capsuleId_2 = p1.capsuleId
            v3 = math.floor(capsuleId_2)
        end
        local message = p1.message
        if typeof(message) == "string" then
            if 120 < #message then
                message = string.sub(message, 1, 120)
            end
            v4 = message
        else
            v4 = nil
        end
        local v5 = nil
        local cooldown = p1.cooldown
        if typeof(cooldown) == "number" then
            local cooldown_2 = p1.cooldown
            v5 = math.max(0, cooldown_2)
        end
        return {
            action = v1,
            result = v2,
            capsuleId = v3,
            message = v4,
            cooldown = v5,
        }
    end
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
        if v1 ~= "CloseScan" and v1 ~= "CloseXRayClient" then
            if v1 == "RequestXRayData" then
                return {action = v1}
            end
            return nil
        end
        return {action = v1}
    end
    local capsuleId_3 = p1.capsuleId
    if typeof(capsuleId_3) == "number" then
        capsuleId_3 = math.floor(capsuleId_3)
    elseif typeof(capsuleId_3) == "string" then
        capsuleId_3 = tonumber(capsuleId_3)
        if capsuleId_3 then
            capsuleId_3 = math.floor(capsuleId_3)
        end
    end
    if typeof(capsuleId_3) == "number" and not (capsuleId_3 < 1) then
        return {action = v1, capsuleId = capsuleId_3}
    end
    return nil
end)