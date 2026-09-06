local deepCopy
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require("@game/ReplicatedStorage/common/zap")
local u15 = require("./PlayerDatabase")
local Scope = u15.Scope
local u18 = {}
function deepCopy(p1) -- Line: 14 -- upvalues: u18 (val), Scope (val), deepCopy (val)
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) ~= "table" then
            v1[k] = Scope:Value(v)
        elseif typeof(k) ~= "string" then
            v1[k] = deepCopy(v)
        elseif k:match("Table") then
            v1[k] = Scope:Value(deepCopy(v))
        elseif not (u18[k]) then
        end
    end
    return v1
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