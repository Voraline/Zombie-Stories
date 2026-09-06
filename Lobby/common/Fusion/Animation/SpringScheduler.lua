local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent
require(Parent.Types)
local packType = require(Parent.Animation.packType)
local springCoefficients = require(Parent.Animation.springCoefficients)
local updateAll = require(Parent.Dependencies.updateAll)
local v1 = {}
local u24 = {}
local u26 = os.clock()
function v1.add(p1) -- Line: 24 -- upvalues: u26 (ref), u24 (val)
    p1._lastSchedule = u26
    p1._startDisplacements = {}
    p1._startVelocities = {}
    for i, v in ipairs(p1._springGoals) do
        p1._startDisplacements[i] = p1._springPositions[i] - v
        p1._startVelocities[i] = p1._springVelocities[i]
    end
    u24[p1] = true
end
function v1.remove(p1) -- Line: 39 -- upvalues: u24 (val)
    u24[p1] = nil
end
RunService:BindToRenderStep("__FusionSpringScheduler", Enum.RenderPriority.First.Value, function() -- Line: 44 -- upvalues: u26 (ref), u24 (val), springCoefficients (val), packType (val), updateAll (val)
    local _springPositions, _springVelocities, _startDisplacements, _startVelocities, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = {}
    u26 = os.clock()
    for k in pairs(u24) do
        v7, v8, v9, v10 = springCoefficients(u26 - k._lastSchedule, k._currentDamping, k._currentSpeed)
        _springPositions = k._springPositions
        _springVelocities = k._springVelocities
        _startDisplacements = k._startDisplacements
        _startVelocities = k._startVelocities
        v1 = false
        for i, v in ipairs(k._springGoals) do
            v2 = _startDisplacements[i]
            v3 = _startVelocities[i]
            v4 = v2 * v7 + v3 * v8
            v5 = v2 * v9 + v3 * v10
            v6 = math.abs(v4)
            if 0.0001 < v6 then
                v1 = true
            else
                v6 = math.abs(v5)
                if 0.0001 >= v6 then end
            end
            _springPositions[i] = v4 + v
            _springVelocities[i] = v5
        end
        if not v1 then
            v11[k] = true
        end
    end
    for k2 in pairs(u24) do
        k2._currentValue = packType(k2._springPositions, k2._currentType)
        updateAll(k2)
    end
    for k3 in pairs(v11) do
        u24[k3] = nil
    end
end)
return v1