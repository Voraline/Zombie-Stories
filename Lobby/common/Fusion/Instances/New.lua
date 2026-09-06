local Parent = script.Parent.Parent
require(Parent.PubTypes)
local defaultProps = require(Parent.Instances.defaultProps)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
local logError = require(Parent.Logging.logError)
return function(p1) -- Line: 14 -- upvalues: logError (val), defaultProps (val), applyInstanceProps (val)
    return function(a1) -- Line: 15 -- upvalues: p1 (val), logError (upval), defaultProps (upval), applyInstanceProps (upval)
        local v1, v2
        v1, v2 = pcall(Instance.new, p1)
        if not v1 then
            logError("cannotCreateClass", nil, p1)
        end
        local v3 = defaultProps[p1]
        if v3 ~= nil then
            for k, v in pairs(v3) do
                v2[k] = v
            end
        end
        applyInstanceProps(a1, v2)
        return v2
    end
end