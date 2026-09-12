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

function u19.ref(p1) -- Line: 25
    -- upvalues: RunService (val), u21 (val), u22 (val), u18 (val), u20 (ref), u12 (val), u23 (ref)
    if RunService:IsStudio() then
        u21[p1] = p1
        u22[p1] = p1
        return p1
    end
    if u21[p1] ~= nil then
        return u21[p1]
    end
    local fatalAssert = u18.fatalAssert
    local v1 = u20 <= u12.IDENTIFIER_CAP
    local v2 = u12
    local IDENTIFIER_CAP_STRING = v2.IDENTIFIER_CAP_STRING
    fatalAssert(v1, (("cannot create any more identifiers - over %* cap."):format(IDENTIFIER_CAP_STRING)))
    local v3 = u18
    local silent = v3.silent
    local v4 = u20
    v2 = v4 + 1
    silent((("creating identifier: %*, identifier count: %*"):format(p1, v2)))
    if not (u20 <= 255) then
        v3 = string.pack("H", u20)
    else
        v3 = string.pack("B", u20)
    end
    u20 = u20 + 1
    u23:SetAttribute(p1, v3)
    u21[p1] = v3
    u22[v3] = p1
    return v3
end

function u19.deser(p1) -- Line: 56 -- upvalues: u18 (val), u22 (val)
    local fatalAssert = u18.fatalAssert
    local v1 = typeof(p1) == "string"
    fatalAssert(v1, string.format("Deserialize takes string, got %*", (typeof(p1))))
    return u22[p1]
end

function u19.ser(p1) -- Line: 64 -- upvalues: u18 (val), u21 (val)
    local fatalAssert = u18.fatalAssert
    local v1 = typeof(p1) == "string"
    fatalAssert(v1, string.format("Serialize takes string, got %*", (typeof(p1))))
    return u21[p1]
end

return u19