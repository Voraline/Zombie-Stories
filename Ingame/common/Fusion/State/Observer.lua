local Parent = script.Parent.Parent
require(Parent.PubTypes)
require(Parent.Types)
local initDependency = require(Parent.Dependencies.initDependency)
local v1 = {}
local u14 = {__index = v1}
local u15 = {}
function v1.update(p1) -- Line: 26
    for k, v in pairs(p1._changeListeners) do
        task.spawn(v)
    end
    return false
end
function v1.onChange(p1, p2) -- Line: 41 -- upvalues: u15 (val)
    local u2 = {}
    p1._numChangeListeners = p1._numChangeListeners + 1
    p1._changeListeners[u2] = p2
    u15[p1] = true
    local u8 = false
    return function() -- Line: 51 -- upvalues: u8 (ref), p1 (val), u2 (val), u15 (upval)
        if u8 then
            return
        end
        u8 = true
        p1._changeListeners[u2] = nil
        local v1 = p1
        v1._numChangeListeners = v1._numChangeListeners - 1
        if p1._numChangeListeners == 0 then
            u15[p1] = nil
        end
    end
end
return function(p1) -- Line: 66 -- upvalues: u14 (val), initDependency (val)
    local v1 = {type = "State", kind = "Observer", _numChangeListeners = 0}
    local v2 = {}
    v2[p1] = true
    v1.dependencySet = v2
    v1.dependentSet = {}
    v1._changeListeners = {}
    local v3 = setmetatable(v1, u14)
    initDependency(v3)
    p1.dependentSet[v3] = true
    return v3
end