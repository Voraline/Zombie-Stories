local u0 = {}
local Controllers = script.Parent.Parent.Parent:WaitForChild("Controllers")
local Classes = script.Parent.Parent.Parent:WaitForChild("Classes")
local Shared = script.Parent.Parent.Parent:WaitForChild("Shared")
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
local Viewmodel = Classes:WaitForChild("Viewmodel")
local ViewmodelUtils = Viewmodel:WaitForChild("ViewmodelUtils")
local PointRotationUtil = require(ViewmodelUtils:WaitForChild("PointRotationUtil"))
local bobCalculate = require(script.Parent:WaitForChild("bobCalculate"))
local SpringUtil = require(script.Parent.Parent:WaitForChild("SpringUtil"))
local u64 = require("../FootstepUtil")
local SharedSprings = require(Shared:WaitForChild("SharedSprings"))
local u72 = CFrame.new()
local u74 = CFrame.new()
local u77 = SpringUtil.new(0)
u77.Target = 1
u77.Speed = 15
u77.Damper = 0.4
local u83 = SpringUtil.new(0)
u83.Target = 1
u83.Speed = 15
u83.Damper = 0.4
local u91 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
PointRotationUtil.UpdateGlobalRotation("BobbingBounce", u91, u74)
local u97 = 0.9
local u98 = {
    BobCycle = function(p1, p2) -- Line: 34 -- upvalues: u97 (ref), LocalPlayerController (val), u0 (val), u72 (ref), u77 (val), u64 (val), SharedSprings (val)
        local v1
        local v2 = p1 * 0.65
        local v3 = math.sin(v2)
        if u97 >= v3 then
            if v3 < u97 and u97 < 0 then
                u97 = -u97
                if not LocalPlayerController.States.Proning and not LocalPlayerController.States.Sliding then
                    v1 = LocalPlayerController.PlayerVelocity / 13 * 2
                    if u0.Weapon and u0.Weapon.Aiming then
                        v1 = v1 * 0.2
                    end
                    v1 = math.min(v1, 2.5)
                    local v4 = CFrame.Angles(-0.01 * v1, 0, -0.02 * v1 * u97)
                    u72 = v4 * CFrame.new(-0 * v1 * u97, -0 * v1, 0)
                    u77.Position = 0
                    u64()
                end
            end
        elseif 0 < u97 then
        end
        v1 = Lerp(2, 5, SharedSprings.SprintSpring.Position)
        local v5 = Lerp(2, 14, SharedSprings.SprintSpring.Position)
        local v6 = -(math.sin(v2 * 2) * p2) * v1 * 0.2
        local v7 = -(math.sin(v2) * p2) * v5 * 0.3
        return (Vector3.new(v6, v7, 0))
    end,
    BobCycle2 = function(p1, p2) -- Line: 65 -- upvalues: u0 (val), u83 (val)
        local v1 = -p1 * 0.65
        if not u0.Weapon then
            u83.Target = 1
        elseif not u0.Weapon.Aiming then
            u83.Target = 1
        else
            u83.Target = 0
        end
        local v2 = -(math.sin(v1) * p2) * 0.005
        local v3 = v2 * u83.Position
        local v4 = -(math.sin(v1 * 2) * p2) * 0.005
        return CFrame.new(v3, v4 * u83.Position, 0)
    end,
}
local u101 = {
    BobCycle = function(p1, p2) -- Line: 77
        local v1 = p1 * 0.65
        local v2 = -(math.sin(v1 * 2) * p2) * 2 * 0.05
        local v3 = -(math.sin(v1) * p2) * 2 * 0.06
        return (Vector3.new(v2, v3, 0))
    end,
    BobCycle2 = function(p1, p2) -- Line: 81
        local v1 = p1 * 1
        local v2 = -(math.sin(v1) * p2) * 0.005
        local v3 = -(math.sin(v1 * 2) * p2) * 0.005
        return CFrame.new(v2, v3, 0)
    end,
}
local function null(p1) -- Line: 86
    local v1 = if p1 <= 0.0001 then -0.0001 <= p1 else false
    return v1
end
function u0.Update(p1) -- Line: 90 -- upvalues: bobCalculate (val), u98 (val), u101 (val), u72 (ref), u77 (val), u74 (ref), PointRotationUtil (val), u91 (val)
    local v1 = bobCalculate(u98)
    local v2 = bobCalculate(u101)
    local v3 = u72:lerp(CFrame.new(), u77.Position)
    u74 = u74:Lerp(v3, (math.min(1, p1 * 15)))
    local v4 = math.acos((CFrame.new().LookVector:Dot(u74.LookVector)))
    local v5 = if v4 <= 0.0001 then -0.0001 <= v4 else false
    if v5 then
        u74 = CFrame.new()
    end
    PointRotationUtil.UpdateGlobalRotation("BobbingBounce", u91, u74)
    return v1, v2
end
function Lerp(p1, p2, p3) -- Line: 108
    return p1 * (1 - p3) + p2 * p3
end
return u0