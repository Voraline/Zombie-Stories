local Parent = script.Parent.Parent
require(Parent.PubTypes)
local defaultProps = require(Parent.Instances.defaultProps)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
local logError = require(Parent.Logging.logError)
return function(p1) -- Line: 14 -- upvalues: logError (val), defaultProps (val), applyInstanceProps (val)
    return function(p1_2) -- Line: 15 -- upvalues: p1 (val), logError (upval), defaultProps (upval), applyInstanceProps (upval)
        local success, result = pcall(Instance.new, p1)
        if not success then
            logError("cannotCreateClass", nil, p1)
        end
        local v1 = defaultProps[p1]
        if v1 ~= nil then
            for k, v in pairs(v1) do
                result[k] = v
            end
        end
        applyInstanceProps(p1_2, result)
        return result
    end
end