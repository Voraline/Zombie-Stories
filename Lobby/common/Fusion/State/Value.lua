local Parent = script.Parent.Parent
require(Parent.Types)
local useDependency = require(Parent.Dependencies.useDependency)
local initDependency = require(Parent.Dependencies.initDependency)
local updateAll = require(Parent.Dependencies.updateAll)
local isSimilar = require(Parent.Utility.isSimilar)
local v1 = {}
local u23 = {}
u23.__index = v1
local u24 = {__mode = "k"}

function v1.get(p1, p2) -- Line: 25 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(p1)
    end
    return p1._value
end

function v1.set(p1, p2, p3) -- Line: 39 -- upvalues: isSimilar (val), updateAll (val)
    local _value = p1._value
    if p3 or not isSimilar(_value, p2) then
        p1._value = p2
        updateAll(p1)
    end
end

return function(p1) -- Line: 47 -- upvalues: u24 (val), u23 (val), initDependency (val)
    local v1 = {type = "State", kind = "Value"}
    local v2 = u24
    v1.dependentSet = setmetatable({}, v2)
    v1._value = p1
    local v3 = u23
    local v4 = setmetatable(v1, v3)
    initDependency(v4)
    return v4
end