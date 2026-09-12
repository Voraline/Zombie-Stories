local deepCopy
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local peek = require(ReplicatedStorage.Packages.Fusion).peek
local v1 = require("@game/ReplicatedStorage/common/zap")
local u15 = require("./PlayerDatabase")
local Scope = u15.Scope
local u18 = {}

function deepCopy(p1) -- Line: 14 -- upvalues: u18 (val), Scope (val), deepCopy (val)
    local v1, v2
    local v3 = {}
    for k, v in pairs(p1) do
        if type(v) ~= "table" then
            v3[k] = (Scope:Value(v))
        elseif typeof(k) ~= "string" then
            v3[k] = (deepCopy(v))
        elseif k:match("Table") then
            v1 = Scope
            v2 = deepCopy
            v2 = v2(v)
            v3[k] = (v1:Value(v2))
        elseif not u18[k] then
            v3[k] = (deepCopy(v))
        else
            v1 = Scope
            v2 = deepCopy
            v2 = v2(v)
            v3[k] = (v1:Value(v2))
        end
    end
    return v3
end

v1.InitUser.On(function(p1) -- Line: 30 -- upvalues: u15 (val), deepCopy (val)
    print(p1.Data, p1.State)
    u15.Data = deepCopy(p1.Data)
    u15.State = deepCopy(p1.State)
    u15.Game = deepCopy(p1.Game)
    require("./Replicater")
    u15.Loaded:set(true)
end)
return {}