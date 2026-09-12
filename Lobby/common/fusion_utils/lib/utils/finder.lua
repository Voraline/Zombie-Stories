local compareTypes
local v1 = {libraries = {}}
local v2 = {tension = "number", friction = "number"}
local libraries = v1.libraries
libraries.ripple = {
    name = "ripple",
    exports = {
        createMotion = "function",
        immediate = "function",
        linear = "function",
        spring = "function",
        tween = "function",
        config = {
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
        },
    },
}

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
        if not compareTypes(j, p2[i]) then
            return false
        end
    end
    return true
end

function v1.find(p1, p2) -- Line: 68 -- upvalues: compareTypes (val)
    local v1, v2
    local Parent = script.Parent.Parent
    local v3 = p1.name:lower()
    local v4, v5 = p1, p2
    while Parent do
        v1 = Parent:FindFirstChild(v4)
        if not v1 then
            v1 = Parent:FindFirstChild(v3)
        end
        if v1 and v1:IsA("ModuleScript") then
            v2 = require(v1)
            if compareTypes(v4, v2) then
                return v2
            end
        end
        Parent = Parent.Parent
    end
    v1 = error
    local name = v4.name
    v1((("[pretty-fusion-utils] Cannot find library %* for %*"):format(name, v5)))
end

return v1