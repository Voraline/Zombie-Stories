local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local defaultProps = require(Parent.Instances.defaultProps)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
return function(p1, p2) -- Line: 19 -- upvalues: External (val), defaultProps (val), applyInstanceProps (val)
    if p2 == nil then
        External.logError("scopeMissing", nil, "instances using New", "myScope:New \"" .. p1 .. "\" { ... }")
    end
    return function(a1) -- Line: 31 -- upvalues: p2 (val), External (upval), defaultProps (upval), p1 (val), applyInstanceProps (upval)
        local v1, v2
        v1, v2 = pcall(Instance.new, p2)
        if not v1 then
            External.logError("cannotCreateClass", nil, p2)
        end
        local v3 = defaultProps[p2]
        if v3 ~= nil then
            for k, v in pairs(v3) do
                v2[k] = v
            end
        end
        table.insert(p1, v2)
        applyInstanceProps(p1, a1, v2)
        return v2
    end
end