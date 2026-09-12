local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local defaultProps = require(Parent.Instances.defaultProps)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
return function(p1, p2) -- Line: 19 -- upvalues: External (val), defaultProps (val), applyInstanceProps (val)
    if p2 == nil then
        External.logError("scopeMissing", nil, "instances using New", "myScope:New \"" .. p1 .. "\" { ... }")
    end
    return function(p1_2) -- Line: 31
        -- upvalues: p2 (val), External (upval), defaultProps (upval), p1 (val), applyInstanceProps (upval)
        local success, result = pcall(Instance.new, p2)
        if not success then
            External.logError("cannotCreateClass", nil, p2)
        end
        local v1 = defaultProps[p2]
        if v1 ~= nil then
            for k, v in pairs(v1) do
                result[k] = v
            end
        end
        local v2 = p1
        table.insert(v2, result)
        applyInstanceProps(p1, p1_2, result)
        return result
    end
end