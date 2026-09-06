local u0 = {}
local function captureInstance(p1) -- Line: 20
    local v1 = {}
    if p1:IsA("GuiObject") then
        v1.BackgroundTransparency = p1.BackgroundTransparency
    end
    if p1:IsA("TextLabel") then
        v1.TextTransparency = p1.TextTransparency
        v1.TextStrokeTransparency = p1.TextStrokeTransparency
    elseif not (p1:IsA("TextButton")) and not (p1:IsA("TextBox")) then
    end
    if p1:IsA("ImageLabel") then
        v1.ImageTransparency = p1.ImageTransparency
    elseif not (p1:IsA("ImageButton")) and not (p1:IsA("ViewportFrame")) then
    end
    if p1:IsA("UIStroke") then
        v1.Transparency = p1.Transparency
    end
    if p1:IsA("ScrollingFrame") then
        v1.ScrollBarImageTransparency = p1.ScrollBarImageTransparency
    end
    return v1
end
function u0.capture(p1, p2) -- Line: 43 -- upvalues: captureInstance (val)
    local visit
    local u2 = {entries = {}}
    function visit(p1) -- Line: 46 -- upvalues: p2 (val), u2 (val), captureInstance (upval), visit (val)
        if not p2 then
            table.insert(u2.entries, {instance = p1, properties = captureInstance(p1)})
            for i, v in ipairs(p1:GetChildren()) do
                visit(v)
            end
            return
        elseif p2(p1) then
            return
        end
    end
    visit(p1)
    return u2
end
function u0.apply(p1, p2) -- Line: 64
    local properties, v1, v2
    local v3 = math.clamp(p2, 0, 1)
    for i, v in ipairs(p1.entries) do
        if v.instance.Parent then
            properties = v.properties
            v1 = nil
            v2 = nil
            for i2, j in properties, v1, v2 do
                v.instance[i2] = j + (1 - j) * v3
            end
        end
    end
end
function u0.restore(p1) -- Line: 76 -- upvalues: u0 (val)
    u0.apply(p1, 0)
end
return u0