local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local u12 = require("../Constants")
require("../Types")
local u18 = require("../Utilities/Output")
local u19 = {}
local u20 = 0
local u21 = {}
local u22 = {}
local u23 = nil
function u19.start() -- Line: 16 -- upvalues: u23 (ref), ReplicatedStorage (val), u19 (val)
    u23 = Instance.new("Folder")
    u23.Name = "identifierStorage"
    u23.Parent = ReplicatedStorage
    u19.ref("NIL_VALUE")
    u19.ref("REQUEST")
end
function u19.ref(p1) -- Line: 25 -- upvalues: RunService (val), u21 (val), u22 (val), u18 (val), u20 (ref), u12 (val), u23 (ref)
    local v1
    if RunService:IsStudio() then
        u21[p1] = p1
        u22[p1] = p1
        return p1
    end
    if u21[p1] ~= nil then
        return u21[p1]
    end
    local v2 = u20 <= u12.IDENTIFIER_CAP
    u18.fatalAssert(v2, (("cannot create any more identifiers - over %* cap."):format(u12.IDENTIFIER_CAP_STRING)))
    u18.silent((("creating identifier: %*, identifier count: %*"):format(p1, u20 + 1)))
    if u20 > 255 then
        v1 = string.pack("H", u20)
    else
        v1 = string.pack("B", u20)
    end
    u20 = u20 + 1
    u23:SetAttribute(p1, v1)
    u21[p1] = v1
    u22[v1] = p1
    return v1
end
function u19.deser(p1) -- Line: 56 -- upvalues: u18 (val), u22 (val)
    local v1 = typeof(p1) == "string"
    u18.fatalAssert(v1, string.format("Deserialize takes string, got %*", (typeof(p1))))
    return u22[p1]
end
function u19.ser(p1) -- Line: 64 -- upvalues: u18 (val), u21 (val)
    local v1 = typeof(p1) == "string"
    u18.fatalAssert(v1, string.format("Serialize takes string, got %*", (typeof(p1))))
    return u21[p1]
end
return u19