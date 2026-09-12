local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local whichLivesLonger = require(Parent.Memory.whichLivesLonger)
local nameOf = require(Parent.Utility.nameOf)
local v1 = {formatters = {}}

function v1.formatters.useFunction(p1, p2) -- Line: 22 -- upvalues: nameOf (val)
    local v1 = nameOf(p1, "object")
    local v2 = nameOf(p2, "object")
    return (("The use()-d %*"):format(v2)), (("the %*"):format(v1))
end

function v1.formatters.boundProperty(p1, p2, p3) -- Line: 31 -- upvalues: nameOf (val)
    local Name = p1.Name
    local v1 = nameOf(p2, "value")
    return (("The %* (bound to the %* property)"):format(v1, p3)), (("the %* instance"):format(Name))
end

function v1.formatters.boundAttribute(p1, p2, p3) -- Line: 41 -- upvalues: nameOf (val)
    local Name = p1.Name
    local v1 = nameOf(p2, "value")
    return (("The %* (bound to the %* attribute)"):format(v1, p3)), (("the %* instance"):format(Name))
end

function v1.formatters.propertyOutputsTo(p1, p2, p3) -- Line: 51 -- upvalues: nameOf (val)
    local Name = p1.Name
    local v1 = nameOf(p2, "object")
    return (("The %* (which the %* property outputs to)"):format(v1, p3)), (("the %* instance"):format(Name))
end

function v1.formatters.attributeOutputsTo(p1, p2, p3) -- Line: 61 -- upvalues: nameOf (val)
    local Name = p1.Name
    local v1 = nameOf(p2, "object")
    return (("The %* (which the %* attribute outputs to)"):format(v1, p3)), (("the %* instance"):format(Name))
end

function v1.formatters.refOutputsTo(p1, p2) -- Line: 71 -- upvalues: nameOf (val)
    local Name = p1.Name
    local v1 = nameOf(p2, "object")
    return (("The %* (which the Ref key outputs to)"):format(v1)), (("the %* instance"):format(Name))
end

function v1.formatters.animationGoal(p1, p2) -- Line: 80 -- upvalues: nameOf (val)
    local v1 = nameOf(p1, "object")
    local v2 = nameOf(p2, "object")
    return (("The goal %*"):format(v2)), (("the %* that is following it"):format(v1))
end

function v1.formatters.parameter(p1, p2, p3) -- Line: 89 -- upvalues: nameOf (val)
    local v1 = nameOf(p1, "object")
    local v2 = nameOf(p2, "object")
    if p3 == false then
        return (("The %* parameter"):format(v2)), (("the %* that it was used for"):format(v1))
    end
    return (("The %* representing the %* parameter"):format(v2, p3)), (("the %* that it was used for"):format(v1))
end

function v1.formatters.observer(p1, p2) -- Line: 103 -- upvalues: nameOf (val)
    local v1 = nameOf(p1, "object")
    local v2 = nameOf(p2, "object")
    return (("The watched %*"):format(v2)), (("the %* that's observing it for changes"):format(v1))
end

function v1.bOutlivesA(p1, p2, p3, p4, p5, ...) -- Line: 112 -- upvalues: External (val), whichLivesLonger (val)
    if p3 == nil then
        External.logError("useAfterDestroy", nil, p5(p2, p4, ...))
        return
    end
    if whichLivesLonger(p1, p2, p3, p4) == "definitely-a" then
        local v1
        local v2, v3 = p5(p2, p4, ...)
        local logWarn = External.logWarn
        if p1 ~= p3 then
            v1 = "the latter is in a different scope that gets destroyed too quickly"
        else
            v1 = "they're in the same scope, but the latter is destroyed too quickly"
        end
        logWarn("possiblyOutlives", v2, v3, v1)
    end
end

return v1