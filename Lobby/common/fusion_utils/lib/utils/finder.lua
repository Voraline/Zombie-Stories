local compareTypes
local v1 = {libraries = {}}
local v2 = {tension = "number", friction = "number"}
local v3 = {name = "ripple"}
local v4 = {
    createMotion = "function",
    immediate = "function",
    linear = "function",
    spring = "function",
    tween = "function",
}
local v5 = {
    spring = {
        default = v2,
        gentle = v2,
        wobbly = v2,
        stiff = v2,
        slow = v2,
        molasses = v2,
    },
    linear = {
        default = {speed = "number"},
    },
    tween = {
        default = {
            time = "number",
            style = "EnumItem",
            direction = "EnumItem",
            repeatCount = "number",
            reverses = "boolean",
            delayTime = "number",
        },
    },
}
v4.config = v5
v3.exports = v4
v1.libraries.ripple = v3
function compareTypes(p1, p2) -- Line: 50 -- upvalues: compareTypes (val)
    local v1
    if typeof(p1) == "string" then
        v1 = p1 == typeof(p2)
        return v1
    end
    if typeof(p2) ~= "table" then
        return false
    end
    v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if not (compareTypes(j, p2[i])) then
            return false
        end
    end
    return true
end
function v1.find(p1, p2) -- Line: 68 -- upvalues: compareTypes (val)
    local v1, v2, v3, v4
    local Parent = script.Parent.Parent
    local v5 = p1.name:lower()
    v1, v2 = p1, p2
    while Parent do
        v3 = Parent:FindFirstChild(v1)
        if not v3 then
            v3 = Parent:FindFirstChild(v5)
        end
        if v3 and v3:IsA("ModuleScript") then
            v4 = require(v3)
            if compareTypes(v1, v4) then
                return v4
            end
        end
        Parent = Parent.Parent
    end
    error((("[pretty-fusion-utils] Cannot find library %* for %*"):format(v1.name, v2)))
end
return v1