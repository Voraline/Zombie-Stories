local u0 = {}
local Controllers = script.Parent.Parent.Parent:WaitForChild("Controllers")
local Classes = script.Parent.Parent.Parent:WaitForChild("Classes")
local Shared = script.Parent.Parent.Parent:WaitForChild("Shared")
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
local PointRotationUtil = require(((Classes:WaitForChild("Viewmodel")):WaitForChild("ViewmodelUtils")):WaitForChild("PointRotationUtil"))
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
local u98 = {}

function u98.BobCycle(p1, p2) -- Line: 34
    -- upvalues: u97 (ref), LocalPlayerController (val), u0 (val), u72 (ref), u77 (val), u64 (val), SharedSprings (val)
    local v1
    local v2 = p1 * 0.65
    local v3 = math.sin(v2)
    if not (u97 < v3) then
        if v3 < u97 and u97 < 0 then
            u97 = -u97
            if not LocalPlayerController.States.Proning and not LocalPlayerController.States.Sliding then
                v1 = LocalPlayerController.PlayerVelocity / 13 * 2
                if u0.Weapon and u0.Weapon.Aiming then
                    v1 = v1 * 0.2
                end
                v1 = math.min(v1, 2.5)
                u72 = (CFrame.Angles(-0.01 * v1, 0, -0.02 * v1 * u97)) * CFrame.new(-0 * v1 * u97, -0 * v1, 0)
                u77.Position = 0
                u64()
            end
        end
    elseif 0 < u97 or v3 < u97 and u97 < 0 then
        u97 = -u97
        if not LocalPlayerController.States.Proning and not LocalPlayerController.States.Sliding then
            v1 = LocalPlayerController.PlayerVelocity / 13 * 2
            if u0.Weapon and u0.Weapon.Aiming then
                v1 = v1 * 0.2
            end
            v1 = math.min(v1, 2.5)
            u72 = (CFrame.Angles(-0.01 * v1, 0, -0.02 * v1 * u97)) * CFrame.new(-0 * v1 * u97, -0 * v1, 0)
            u77.Position = 0
            u64()
        end
    end
    v1 = Lerp(2, 5, SharedSprings.SprintSpring.Position)
    local v4 = Lerp(2, 14, SharedSprings.SprintSpring.Position)
    local v5 = v2 * 2
    local v6 = -(math.sin(v5) * p2) * v1 * 0.2
    local v7 = -(math.sin(v2) * p2) * v4 * 0.3
    return (Vector3.new(v6, v7, 0))
end

function u98.BobCycle2(p1, p2) -- Line: 65 -- upvalues: u0 (val), u83 (val)
    local v1 = -p1 * 0.65
    if not u0.Weapon or not u0.Weapon.Aiming then
        u83.Target = 1
    else
        u83.Target = 0
    end
    local new = CFrame.new
    local v2 = -(math.sin(v1) * p2) * 0.005 * u83.Position
    local v3 = v1 * 2
    return new(v2, -(math.sin(v3) * p2) * 0.005 * u83.Position, 0)
end

local u101 = {}

function u101.BobCycle(p1, p2) -- Line: 77
    local v1 = p1 * 0.65
    local v2 = v1 * 2
    local v3 = -(math.sin(v2) * p2) * 2 * 0.05
    local v4 = -(math.sin(v1) * p2) * 2 * 0.06
    return (Vector3.new(v3, v4, 0))
end

function u101.BobCycle2(p1, p2) -- Line: 81
    local v1 = p1 * 1
    local new = CFrame.new
    local v2 = -(math.sin(v1) * p2) * 0.005
    local v3 = v1 * 2
    return new(v2, -(math.sin(v3) * p2) * 0.005, 0)
end

local function null(p1) -- Line: 86
    local v1 = false
    if p1 <= 0.0001 then
        v1 = -0.0001 <= p1
    end
    return v1
end

function u0.Update(p1) -- Line: 90
    -- upvalues: bobCalculate (val), u98 (val), u101 (val), u72 (ref), u77 (val), u74 (ref), PointRotationUtil (val)
    -- upvalues: u91 (val)
    local v1 = bobCalculate(u98)
    local v2 = bobCalculate(u101)
    local v3 = u72
    local v4 = CFrame.new()
    local v5 = u77
    local Position = v5.Position
    v3 = v3:lerp(v4, Position)
    local v6 = u74
    local v7 = p1 * 15
    local v8 = math.min(1, v7)
    u74 = v6:Lerp(v3, v8)
    local LookVector = (CFrame.new()).LookVector
    v8 = u74
    local LookVector_2 = v8.LookVector
    v4 = LookVector:Dot(LookVector_2)
    v6 = math.acos(v4)
    v4 = false
    if v6 <= 0.0001 then
        v4 = -0.0001 <= v6
    end
    if v4 then
        u74 = CFrame.new()
    end
    PointRotationUtil.UpdateGlobalRotation("BobbingBounce", u91, u74)
    return v1, v2
end

function Lerp(p1, p2, p3) -- Line: 108
    return p1 * (1 - p3) + p2 * p3
end

return u0