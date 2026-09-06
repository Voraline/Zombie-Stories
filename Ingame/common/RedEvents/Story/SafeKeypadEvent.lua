local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage.common:WaitForChild("RedEvents")
local Red = require(ReplicatedStorage.Packages.Red)
local function log(...) -- Line: 6
    warn("[SafeKeypadEvent]", ...)
end
if not (game:GetService("RunService"):IsServer()) then
    v1 = "Client"
else
    v1 = "Server"
end
log("Module loaded", v1)
return Red.SharedEvent("SafeKeypad", function(p1) -- Line: 12 -- upvalues: log (val)
    local v1
    if typeof(p1) ~= "table" then
        log("Rejected non-table packet", p1)
        return nil
    end
    local action = p1.action
    if typeof(action) ~= "string" then
        log("Rejected missing action", p1)
        return nil
    end
    if action ~= "Enable" then
        if action == "Status" then
            local statusText_2 = p1.statusText
            if typeof(statusText_2) ~= "string" then
                log("Status missing text")
                return nil
            end
            local statusColor_2 = p1.statusColor
            if typeof(statusColor_2) ~= "Color3" then
                statusColor_2 = Color3.new(1, 1, 1)
            end
            local displayText_2 = p1.displayText
            if displayText_2 ~= nil and typeof(displayText_2) ~= "string" then
                displayText_2 = nil
            end
            v1 = p1.lockInput == true
            local resetAfter = p1.resetAfter
            if resetAfter ~= nil and typeof(resetAfter) ~= "number" then
                resetAfter = nil
            end
            return {
                action = action,
                statusText = statusText_2,
                statusColor = statusColor_2,
                displayText = displayText_2,
                lockInput = v1,
                resetAfter = resetAfter,
            }
        end
        if action == "Reset" then
            local displayText_3 = p1.displayText
            if displayText_3 ~= nil and typeof(displayText_3) ~= "string" then
                log("Reset invalid display text")
                displayText_3 = nil
            end
            local statusText_3 = p1.statusText
            if statusText_3 ~= nil and typeof(statusText_3) ~= "string" then
                statusText_3 = nil
            end
            local statusColor_3 = p1.statusColor
            if statusColor_3 ~= nil and typeof(statusColor_3) ~= "Color3" then
                statusColor_3 = nil
            end
            return {action = action, displayText = displayText_3, statusText = statusText_3, statusColor = statusColor_3}
        end
        if action == "Disable" then
            log("Disable action accepted")
            return {action = action}
        end
        if action == "RequestState" then
            return {action = action}
        end
        if action ~= "Submit" then
            log("Unknown action", action)
            return nil
        end
        local code = p1.code
        if typeof(code) ~= "string" then
            log("Submit invalid code", p1.code)
            return nil
        end
        log("Submit packet accepted")
        return {action = action, code = code}
    else
        local color, colorName, digit
        local hints = p1.hints
        if typeof(hints) ~= "table" then
            log("Enable missing hints")
            return nil
        end
        local v2 = {}
        for i, v in ipairs(hints) do
            if typeof(v) ~= "table" then
                log("Enable invalid hint entry", v)
                return nil
            end
            colorName = v.colorName
            digit = v.digit
            color = v.color
            if typeof(colorName) == "string" and typeof(digit) == "number" and typeof(color) == "Color3" then
                table.insert(v2, {colorName = colorName, digit = digit, color = color})
                continue
            end
            return nil
        end
        local keypadPath = p1.keypadPath
        v1 = nil
        if keypadPath == nil then
            local statusText = p1.statusText
            if typeof(statusText) ~= "string" then
                statusText = "Enter Code"
            end
            local statusColor = p1.statusColor
            if typeof(statusColor) ~= "Color3" then
                statusColor = Color3.new(1, 1, 1)
            end
            local displayText = p1.displayText
            if displayText ~= nil and typeof(displayText) ~= "string" then
                displayText = nil
            end
            local v3 = p1.locked == true
            local showHints = p1.showHints
            if showHints ~= nil then
                showHints = showHints == true
            end
            local logoAssetId = p1.logoAssetId
            if logoAssetId ~= nil and typeof(logoAssetId) ~= "string" then
                logoAssetId = nil
            end
            local codeLength = p1.codeLength
            if codeLength ~= nil then
                if typeof(codeLength) == "number" then
                    local v4 = math.floor(codeLength)
                    codeLength = math.clamp(v4, 1, 32)
                else
                    codeLength = nil
                end
            end
            return {
                action = action,
                hints = v2,
                statusText = statusText,
                statusColor = statusColor,
                displayText = displayText,
                locked = v3,
                keypadPath = v1,
                showHints = showHints,
                logoAssetId = logoAssetId,
                codeLength = codeLength,
            }
        else
            if typeof(keypadPath) ~= "table" then
                log("Enable invalid keypadPath")
                return nil
            end
            v1 = {}
            for i2, i3 in ipairs(keypadPath) do
                if typeof(i3) ~= "string" then
                    log("Enable keypadPath segment invalid", i3)
                    return nil
                end
                table.insert(v1, i3)
            end
        end
    end
end)