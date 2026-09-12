local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Red = require((ReplicatedStorage:WaitForChild("Packages")):WaitForChild("Red"))
local u15 = {Image = true, Paper = true}
local u16 = {Show = true, Hide = true}

local function coerceString(p1) -- Line: 15
    if typeof(p1) == "string" then
        return p1
    end
    if typeof(p1) == "number" then
        return (tostring(p1))
    end
    return nil
end

local function sanitizeImageId(p1) -- Line: 25
    if typeof(p1) ~= "string" then
        if typeof(p1) == "number" then
            return ("rbxassetid://%d"):format(p1)
        end
        return nil
    end
    if p1 == "" then
        return nil
    end
    local v1 = p1:match("%d+")
    if v1 then
        return "rbxassetid://" .. v1
    end
    return p1
end

local function sanitizeFont(p1) -- Line: 42
    if typeof(p1) == "EnumItem" and p1.EnumType == Enum.Font then
        return p1
    end
    if typeof(p1) == "string" then
        local success, result = pcall(function() -- Line: 47 -- upvalues: p1 (val)
            return Enum.Font[p1]
        end)
        if success then
            return result
        end
    end
    return nil
end

local function sanitizeFontFace(p1) -- Line: 57
    if typeof(p1) == "Font" then
        return p1
    end
    return nil
end

local function sanitizeVector2(p1) -- Line: 64
    if typeof(p1) == "Vector2" then
        return Vector2.new(p1.X, p1.Y)
    end
    if typeof(p1) == "table" then
        local X = p1.X
        if not X then
            X = p1.x
        end
        local Y = p1.Y
        if not Y then
            Y = p1.y
        end
        if typeof(X) == "number" and typeof(Y) == "number" then
            return Vector2.new(X, Y)
        end
    end
    return nil
end

local function sanitizeUDim2(p1) -- Line: 78
    if typeof(p1) == "UDim2" then
        return p1
    end
    return nil
end

local function sanitizeTextAlignmentX(p1) -- Line: 85
    if typeof(p1) == "EnumItem" and p1.EnumType == Enum.TextXAlignment then
        return p1
    end
    if typeof(p1) == "string" then
        local success, result = pcall(function() -- Line: 90 -- upvalues: p1 (val)
            return Enum.TextXAlignment[p1]
        end)
        if success then
            return result
        end
    end
    return nil
end

local function sanitizeTextAlignmentY(p1) -- Line: 100
    if typeof(p1) == "EnumItem" and p1.EnumType == Enum.TextYAlignment then
        return p1
    end
    if typeof(p1) == "string" then
        local success, result = pcall(function() -- Line: 105 -- upvalues: p1 (val)
            return Enum.TextYAlignment[p1]
        end)
        if success then
            return result
        end
    end
    return nil
end

local function sanitizeAction(p1) -- Line: 115 -- upvalues: u16 (val)
    if typeof(p1) ~= "string" then
        return nil
    end
    local v1 = (string.upper((string.sub(p1, 1, 1)))) .. string.lower((string.sub(p1, 2)))
    if u16[v1] then
        return v1
    end
    return nil
end

local function sanitizeHintType(p1) -- Line: 126
    if typeof(p1) ~= "string" then
        return nil
    end
    local v1 = string.lower(p1)
    if v1 == "image" then
        return "Image"
    end
    if v1 == "paper" then
        return "Paper"
    end
    return nil
end

return Red.SharedEvent("Hint", function(p1) -- Line: 139
    -- upvalues: u16 (val), u15 (val), sanitizeVector2 (val), sanitizeFont (val), sanitizeTextAlignmentX (val)
    -- upvalues: sanitizeTextAlignmentY (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if typeof(action) == "string" then
        v9 = (string.upper((string.sub(action, 1, 1)))) .. string.lower((string.sub(action, 2)))
        if not u16[v9] then
            v1 = nil
        else
            v1 = v9
        end
    else
        v1 = nil
    end
    if not v1 then
        return nil
    end
    if v1 == "Hide" then
        v5 = {action = v1}
        local hintId = p1.hintId
        if typeof(hintId) == "string" then
            v9 = hintId
        elseif typeof(hintId) ~= "number" then
            v9 = nil
        else
            v9 = tostring(hintId)
        end
        if v9 then
            v5.hintId = v9
        end
        return v5
    end
    local hintType = p1.hintType
    if typeof(hintType) == "string" then
        v10 = string.lower(hintType)
        if v10 == "image" then
            v5 = "Image"
        elseif v10 ~= "paper" then
            v5 = nil
        else
            v5 = "Paper"
        end
    else
        v5 = nil
    end
    if not v5 or not u15[v5] then
        return nil
    end
    v9 = {action = v1, hintType = v5}
    local hintId_2 = p1.hintId
    if typeof(hintId_2) == "string" then
        v10 = hintId_2
    elseif typeof(hintId_2) ~= "number" then
        v10 = nil
    else
        v10 = tostring(hintId_2)
    end
    if v10 then
        v9.hintId = v10
    end
    local title = p1.title
    if typeof(title) == "string" then
        v11 = title
    elseif typeof(title) ~= "number" then
        v11 = nil
    else
        v11 = tostring(title)
    end
    if v11 then
        v9.title = v11
    end
    local subtitle = p1.subtitle
    if typeof(subtitle) == "string" then
        v12 = subtitle
    elseif typeof(subtitle) ~= "number" then
        v12 = nil
    else
        v12 = tostring(subtitle)
    end
    if v12 then
        v9.subtitle = v12
    end
    local overlayTransparency = p1.overlayTransparency
    if typeof(overlayTransparency) == "number" then
        v9.overlayTransparency = math.clamp(overlayTransparency, 0, 1)
    end
    local promptText = p1.promptText
    if typeof(promptText) == "string" then
        v13 = promptText
    elseif typeof(promptText) ~= "number" then
        v13 = nil
    else
        v13 = tostring(promptText)
    end
    if v13 then
        v9.promptText = v13
    end
    if v5 == "Image" then
        local v14
        local imageId = p1.imageId
        if not imageId then
            imageId = p1.assetId
        end
        if typeof(imageId) ~= "string" then
            if typeof(imageId) ~= "number" then
                v14 = nil
            else
                v14 = ("rbxassetid://%d"):format(imageId)
            end
        elseif imageId ~= "" then
            v3 = imageId:match("%d+")
            if not v3 then
                v14 = imageId
            else
                v14 = "rbxassetid://" .. v3
            end
        else
            v14 = nil
        end
        if not v14 then
            return nil
        end
        v9.imageId = v14
        local aspectRatio = p1.aspectRatio
        if typeof(aspectRatio) == "number" then
            v9.aspectRatio = math.clamp(aspectRatio, 0.1, 10)
        end
        local imageColor3 = p1.imageColor3
        if not imageColor3 then
            imageColor3 = p1.imageColor
        end
        if typeof(imageColor3) == "Color3" then
            v9.imageColor3 = imageColor3
        end
        local backgroundColor3 = p1.backgroundColor3
        if not backgroundColor3 then
            backgroundColor3 = p1.backgroundColor
        end
        if typeof(backgroundColor3) == "Color3" then
            v9.backgroundColor3 = backgroundColor3
        end
        local backgroundTransparency = p1.backgroundTransparency
        if typeof(backgroundTransparency) == "number" then
            v9.backgroundTransparency = math.clamp(backgroundTransparency, 0, 1)
        end
        v4 = sanitizeVector2(p1.padding)
        if v4 then
            v9.padding = v4
        end
        return v9
    end
    local text = p1.text
    if typeof(text) ~= "string" then
        return nil
    end
    v9.text = text
    local fontFace = p1.fontFace
    if typeof(fontFace) ~= "Font" then
        v2 = nil
    else
        v2 = fontFace
    end
    if v2 then
        v9.fontFace = v2
    end
    v3 = sanitizeFont(p1.font)
    if v3 then
        v9.font = v3
    end
    if not v9.font and not v9.fontFace then
        v9.font = Enum.Font.Gotham
    end
    local textSize = p1.textSize
    if typeof(textSize) == "number" then
        local v15 = textSize + 0.5
        v4 = math.floor(v15)
        v9.textSize = math.clamp(v4, 6, 200)
    end
    local textWrapped = p1.textWrapped
    if typeof(textWrapped) == "boolean" then
        v9.textWrapped = textWrapped
    end
    local textScaled = p1.textScaled
    if typeof(textScaled) == "boolean" then
        v9.textScaled = textScaled
    end
    local richText = p1.richText
    if typeof(richText) == "boolean" then
        v9.richText = richText
    end
    local textColor3 = p1.textColor3
    if not textColor3 then
        textColor3 = p1.textColor
    end
    if typeof(textColor3) == "Color3" then
        v9.textColor3 = textColor3
    end
    local textTransparency = p1.textTransparency
    if typeof(textTransparency) == "number" then
        v9.textTransparency = math.clamp(textTransparency, 0, 1)
    end
    local textStrokeColor3 = p1.textStrokeColor3
    if not textStrokeColor3 then
        textStrokeColor3 = p1.textStrokeColor
    end
    if typeof(textStrokeColor3) == "Color3" then
        v9.textStrokeColor3 = textStrokeColor3
    end
    local textStrokeTransparency = p1.textStrokeTransparency
    if typeof(textStrokeTransparency) == "number" then
        v9.textStrokeTransparency = math.clamp(textStrokeTransparency, 0, 1)
    end
    local v16 = sanitizeTextAlignmentX(p1.textXAlignment)
    if v16 then
        v9.textXAlignment = v16
    end
    local v17 = sanitizeTextAlignmentY(p1.textYAlignment)
    if v17 then
        v9.textYAlignment = v17
    end
    local v18 = sanitizeVector2
    local frameSize = p1.frameSize
    if not frameSize then
        frameSize = p1.textSizePixels
    end
    v18 = v18(frameSize)
    if v18 then
        local X = v18.X
        v6 = math.max(X, 1)
        local Y = v18.Y
        v7 = math.max(Y, 1)
        v9.frameSize = Vector2.new(v6, v7)
    end
    v6 = sanitizeVector2(p1.canvasSize)
    if v6 then
        local X_2 = v6.X
        v7 = math.max(X_2, 1)
        local Y_2 = v6.Y
        local v19 = math.max(Y_2, 1)
        v9.canvasSize = Vector2.new(v7, v19)
    end
    local backgroundColor3_2 = p1.backgroundColor3
    if not backgroundColor3_2 then
        backgroundColor3_2 = p1.backgroundColor
    end
    if typeof(backgroundColor3_2) == "Color3" then
        v9.backgroundColor3 = backgroundColor3_2
    end
    local backgroundTransparency_2 = p1.backgroundTransparency
    if typeof(backgroundTransparency_2) == "number" then
        v9.backgroundTransparency = math.clamp(backgroundTransparency_2, 0, 1)
    end
    local v20 = sanitizeVector2(p1.padding)
    if v20 then
        v9.padding = v20
    end
    local sizeUDim = p1.sizeUDim
    if not sizeUDim then
        sizeUDim = p1.textSizeUDim
    end
    if typeof(sizeUDim) ~= "UDim2" then
        v8 = nil
    else
        v8 = sizeUDim
    end
    if v8 then
        v9.sizeUDim = v8
    end
    local lineHeight = p1.lineHeight
    if not lineHeight then
        lineHeight = p1.textLineHeight
    end
    if typeof(lineHeight) == "number" then
        v9.lineHeight = math.clamp(lineHeight, 0, 10)
    end
    return v9
end)