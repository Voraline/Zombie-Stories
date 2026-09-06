local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require("../Types")
local u15 = require("../Utilities/Output")
local u16 = nil
local u17 = {}
local u18 = {}
local u19 = {}
local u20 = {}
function u20.start() -- Line: 15 -- upvalues: u16 (ref), ReplicatedStorage (val), u17 (val), u18 (val), u19 (val), u20 (val)
    u16 = ReplicatedStorage:WaitForChild("identifierStorage")
    for i, j in u16:GetAttributes() do
        u17[i] = j
        u18[j] = i
    end
    u16.AttributeChanged:Connect(function(p1) -- Line: 26 -- upvalues: u16 (upval), u19 (upval), u17 (upval), u18 (upval)
        local v1
        local Attribute = u16:GetAttribute(p1)
        if not Attribute then
            v1 = u17[p1]
            u17[p1] = nil
            u18[v1] = nil
            return
        end
        v1 = u19[p1]
        if v1 then
            local v2 = v1
            local v3 = nil
            local v4 = nil
            for i in v2, v3, v4 do
                task.spawn(i, Attribute)
            end
            u19[p1] = nil
        end
        u17[p1] = Attribute
        u18[Attribute] = p1
    end)
    u20.ref("NIL_VALUE")
end
function u20.ref(p1, p2) -- Line: 55 -- upvalues: u15 (val), RunService (val), u17 (val), u18 (val), u19 (val)
    local v1
    u15.typecheck("string", "ReferenceIdentifier", "identifierName", p1)
    if RunService:IsStudio() then
        u17[p1] = p1
        u18[p1] = p1
        return p1
    end
    if p2 ~= nil then
        u15.typecheck("number", "ReferenceIdentifier", "maxWaitTime", p2)
    end
    local v2 = u17[p1]
    if v2 then
        return v2
    end
    local u28 = coroutine.running()
    local u34 = u19[p1]
    if not u34 then
        v1 = {}
        v1[u28] = true
        u19[p1] = v1
    else
        u34[u28] = true
    end
    v1 = task.delay(p2 or 1, function() -- Line: 85 -- upvalues: u34 (ref), u28 (val)
        u34[u28] = nil
        task.spawn(u28, nil)
    end)
    local v3 = coroutine.yield()
    if v3 ~= nil then
        task.cancel(v1)
    else
        u15.fatal((("reached max wait time for identifier %*, broke yield. Did you forget to implement it on the server?"):format(p1)))
    end
    return v3
end
function u20.deser(p1) -- Line: 105 -- upvalues: u15 (val), u18 (val)
    local v1 = typeof(p1) == "string"
    u15.fatalAssert(v1, string.format("Deserialize takes string, got %*", (typeof(p1))))
    return u18[p1]
end
function u20.ser(p1) -- Line: 113 -- upvalues: u15 (val), u17 (val)
    local v1 = typeof(p1) == "string"
    u15.fatalAssert(v1, string.format("Serialize takes string, got %*", (typeof(p1))))
    return u17[p1]
end
return u20