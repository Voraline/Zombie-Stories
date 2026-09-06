local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent
require(Parent.Types)
local lerpType = require(Parent.Animation.lerpType)
local getTweenRatio = require(Parent.Animation.getTweenRatio)
local updateAll = require(Parent.Dependencies.updateAll)
local u23 = {}
local v1 = {__mode = "k"}
local u25 = {}
setmetatable(u25, v1)
function u23.add(p1) -- Line: 29 -- upvalues: u25 (val)
    u25[p1] = true
end
function u23.remove(p1) -- Line: 36 -- upvalues: u25 (val)
    u25[p1] = nil
end
RunService:BindToRenderStep("__FusionTweenScheduler", Enum.RenderPriority.First.Value, function() -- Line: 43 -- upvalues: u25 (val), updateAll (val), u23 (val), getTweenRatio (val), lerpType (val)
    local v1, v2
    local v3 = os.clock()
    for k in pairs(u25) do
        v1 = v3 - k._currentTweenStartTime
        if k._currentTweenDuration >= v1 then
            v2 = getTweenRatio(k._currentTweenInfo, v1)
            k._currentValue = lerpType(k._prevValue, k._nextValue, v2)
            k._currentlyAnimating = true
            updateAll(k)
        else
            if not k._currentTweenInfo.Reverses then
                k._currentValue = k._nextValue
            else
                k._currentValue = k._prevValue
            end
            k._currentlyAnimating = false
            updateAll(k)
            u23.remove(k)
        end
    end
end)
return u23