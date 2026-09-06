local v1 = {}
local Parent = script.Parent.Parent.Parent.Parent.Parent
local Controllers = Parent:WaitForChild("Controllers")
local LocalPlayerController = Controllers:WaitForChild("LocalPlayerController")
local u17 = require(LocalPlayerController)
local Utils = Parent:WaitForChild("Utils")
local SpringUtil = require(Utils:WaitForChild("SpringUtil"))
local LocalPlayerUtils = LocalPlayerController:WaitForChild("LocalPlayerUtils")
local PlayerMovementUtil = require(LocalPlayerUtils:WaitForChild("PlayerMovementUtil"))
local PointRotationUtil = require(script.Parent.Parent:WaitForChild("PointRotationUtil"))
local Camera = workspace.Camera
local u51 = SpringUtil.new(0)
u51.Target = 0
u51.Speed = 6
u51.Damper = 0.4
local u57 = SpringUtil.new(0)
u57.Target = 0
u57.Speed = 6
u57.Damper = 0.4
local u65 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
local u66 = {u57.Position / 2, u51.Position / 2}
function v1.Update(p1) -- Line: 33 -- upvalues: u17 (val), Camera (val), PlayerMovementUtil (val), u51 (val), u57 (val), u66 (val), PointRotationUtil (val), u65 (val)
    local Character = u17.Character
    if not Character then
        return
    end
    local Humanoid = Character.Humanoid
    local v1 = Humanoid.MoveDirection:Dot(Camera.CFrame.RightVector)
    local v2 = Humanoid.MoveDirection:Dot(Camera.CFrame.LookVector)
    if 0.75 >= PlayerMovementUtil.MoveVector.Magnitude then
        u51.Target = 0
        u57.Target = 0
    else
        if 0.1 < v1 then
            u51.Target = -5 * v1
        elseif v1 >= 0.1 then
            u51.Target = 0
        end
        if 0.1 < v2 then
            u57.Target = -0.5 * v2
        elseif v2 >= 0.1 then
            u57.Target = 0
        end
    end
    u66[1] = u57.Position / 2
    u66[2] = u51.Position / 2
    local v3 = u66
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        if j <= 0.0001 and -0.0001 <= j then
            u66[i] = 0
        end
    end
    v4 = math.rad(u66[1])
    v3 = CFrame.Angles(v4, 0, (math.rad(u66[2])))
    PointRotationUtil.UpdateRotation("Directional", u65, v3)
end
return v1