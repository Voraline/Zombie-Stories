local SpringUtil = require(script.Parent.Parent.Parent.Parent.Parent.Utils.SpringUtil)
local u12 = require("../PointRotationUtil")
local u16 = SpringUtil.new((Vector3.new()))
u16.Target = Vector3.new()
u16.Speed = 13
u16.Damper = 0.45
local u21 = nil
local CFrame = workspace.CurrentCamera.CFrame
local u26 = CFrame.new()
local u28 = CFrame.new()
local u30 = CFrame.new()
local v1 = {}
function v1.Update(p1, p2) -- Line: 31 -- upvalues: u21 (ref), CFrame (ref), u16 (val), u26 (ref), u28 (ref), u30 (ref), u12 (val)
    local X, Y, v1, v2, v3, v4
    if not u21 then
        v1 = Vector2.new()
        if CFrame then
            local v5, v6
            v2, v5 = CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame):ToEulerAnglesXYZ()
            v6, v3 = workspace.CurrentCamera.CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame):ToEulerAnglesXYZ()
            local v7 = math.deg(v3 - v5)
            v4 = Vector2.new(v7, (math.deg(v6 - v2)))
            if not p2 then
                v7 = 0.002
            else
                v7 = 0.0005
            end
            v1 = v4 * v7
        end
        u16.Position = u16.Position + Vector3.new(-v1.X, v1.Y, 0)
        X = u16.Position.X
        if 0.05 <= X then
            u16.Position = Vector3.new(0.05, u16.Position.Y, 0)
        elseif X <= -0.05 then
            u16.Position = Vector3.new(-0.05, u16.Position.Y, 0)
        end
        Y = u16.Position.Y
        if 0.05 <= Y then
            u16.Position = Vector3.new(u16.Position.X, 0.05, 0)
        elseif Y <= -0.05 then
            u16.Position = Vector3.new(u16.Position.X, -0.05, 0)
        end
        u21 = os.clock()
        CFrame = workspace.CurrentCamera.CFrame
    else
        v1 = os.clock() - u21
        if 0.016666666666666666 > v1 then end
    end
    v1 = math.clamp(p1 * 10, 0, 1)
    v2 = if p2 then CFrame.Angles(-u16.Position.Y, u16.Position.X, u16.Position.X) else CFrame.Angles(-u16.Position.Y, u16.Position.X, 0)
    v4 = CFrame.Angles(-u16.Position.Y, u16.Position.X, u16.Position.X)
    local v8 = -u16.Position.X
    v3 = v4 * CFrame.new(v8, u16.Position.Y * 5, 0)
    u26 = u26:Lerp(v3, v1)
    u28 = u28:Lerp(v2, v1)
    if not p2 then
        u30 = u28
    else
        u30 = u30:Lerp(CFrame.new(), v1)
    end
    if not p2 then
        v8 = CFrame.Angles(-u16.Position.Y, 0, u16.Position.X)
        v4 = u12.GetRotation("Inertia"):Lerp(v8, v1)
        u12.UpdateRotation("Inertia", nil, v4, true)
    else
        u12.UpdateRotation("Inertia", "Barrel", u28, true)
    end
    return u30, u26
end
return v1