local SpringUtil = require(script.Parent.Parent.Parent.Parent.Parent.Utils.SpringUtil)
local u12 = require("../PointRotationUtil")
local u16 = SpringUtil.new((Vector3.new()))
u16.Target = Vector3.new()
u16.Speed = 13
u16.Damper = 0.45
local u21 = nil
local CFrame_2 = workspace.CurrentCamera.CFrame
local u26 = CFrame.new()
local u28 = CFrame.new()
local u30 = CFrame.new()
return {
    Update = function(p1, p2) -- Line: 31
        -- upvalues: u21 (ref), CFrame_2 (ref), u16 (val), u26 (ref), u28 (ref), u30 (ref), u12 (val)
        local CFrame_3, CFrame_4, CFrame_5, Position, X, X_2, X_3, Y, Y_2, Y_3, Y_4, new, v1, v2, v3, v4, v5, v6, v7, v8, v9
        if not u21 then
            v2 = Vector2.new()
            if CFrame_2 then
                v3 = CFrame_2
                CFrame_3 = workspace.CurrentCamera.CFrame
                v3, v4 = v3:ToObjectSpace(CFrame_3):ToEulerAnglesXYZ()
                CFrame_4 = workspace.CurrentCamera.CFrame
                CFrame_5 = workspace.CurrentCamera.CFrame
                v5, v6 = CFrame_4:ToObjectSpace(CFrame_5):ToEulerAnglesXYZ()
                new = Vector2.new
                v9 = v6 - v4
                v8 = math.deg(v9)
                v1 = v5 - v3
                v7 = new(v8, (math.deg(v1)))
                if not p2 then
                    v8 = 0.002
                else
                    v8 = 0.0005
                end
                v2 = v7 * v8
            end
            v3 = u16
            v5 = u16
            Position = v5.Position
            v7 = -v2.X
            Y = v2.Y
            v3.Position = Position + Vector3.new(v7, Y, 0)
            X = u16.Position.X
            if 0.05 <= X then
                v4 = u16
                v7 = u16
                Y_2 = v7.Position.Y
                v4.Position = Vector3.new(0.05, Y_2, 0)
            elseif X <= -0.05 then
                v4 = u16
                v7 = u16
                Y_3 = v7.Position.Y
                v4.Position = Vector3.new(-0.05, Y_3, 0)
            end
            Y_4 = u16.Position.Y
            if 0.05 <= Y_4 then
                v5 = u16
                v7 = u16
                X_2 = v7.Position.X
                v5.Position = Vector3.new(X_2, 0.05, 0)
            elseif Y_4 <= -0.05 then
                v5 = u16
                v7 = u16
                X_3 = v7.Position.X
                v5.Position = Vector3.new(X_3, -0.05, 0)
            end
            u21 = os.clock()
            CFrame_2 = workspace.CurrentCamera.CFrame
        else
            v2 = os.clock() - u21
            if 0.016666666666666666 <= v2 then
                v2 = Vector2.new()
                if CFrame_2 then
                    v3 = CFrame_2
                    CFrame_3 = workspace.CurrentCamera.CFrame
                    v3, v4 = v3:ToObjectSpace(CFrame_3):ToEulerAnglesXYZ()
                    CFrame_4 = workspace.CurrentCamera.CFrame
                    CFrame_5 = workspace.CurrentCamera.CFrame
                    v5, v6 = CFrame_4:ToObjectSpace(CFrame_5):ToEulerAnglesXYZ()
                    new = Vector2.new
                    v9 = v6 - v4
                    v8 = math.deg(v9)
                    v1 = v5 - v3
                    v7 = new(v8, (math.deg(v1)))
                    if not p2 then
                        v8 = 0.002
                    else
                        v8 = 0.0005
                    end
                    v2 = v7 * v8
                end
                v3 = u16
                v5 = u16
                Position = v5.Position
                v7 = -v2.X
                Y = v2.Y
                v3.Position = Position + Vector3.new(v7, Y, 0)
                X = u16.Position.X
                if 0.05 <= X then
                    v4 = u16
                    v7 = u16
                    Y_2 = v7.Position.Y
                    v4.Position = Vector3.new(0.05, Y_2, 0)
                elseif X <= -0.05 then
                    v4 = u16
                    v7 = u16
                    Y_3 = v7.Position.Y
                    v4.Position = Vector3.new(-0.05, Y_3, 0)
                end
                Y_4 = u16.Position.Y
                if 0.05 <= Y_4 then
                    v5 = u16
                    v7 = u16
                    X_2 = v7.Position.X
                    v5.Position = Vector3.new(X_2, 0.05, 0)
                elseif Y_4 <= -0.05 then
                    v5 = u16
                    v7 = u16
                    X_3 = v7.Position.X
                    v5.Position = Vector3.new(X_3, -0.05, 0)
                end
                u21 = os.clock()
                CFrame_2 = workspace.CurrentCamera.CFrame
            end
        end
        v3 = p1 * 10
        v2 = math.clamp(v3, 0, 1)
        v3 = CFrame.Angles(-u16.Position.Y, u16.Position.X, 0)
        if p2 then
            v3 = CFrame.Angles(-u16.Position.Y, u16.Position.X, u16.Position.X)
        end
        v4 = u26
        v7 = CFrame.Angles(-u16.Position.Y, u16.Position.X, u16.Position.X)
        local new_2 = CFrame.new
        v9 = -u16.Position.X
        v6 = v7 * new_2(v9, u16.Position.Y * 5, 0)
        u26 = v4:Lerp(v6, v2)
        u28 = u28:Lerp(v3, v2)
        if not p2 then
            u30 = u28
        else
            v4 = u30
            v6 = CFrame.new()
            u30 = v4:Lerp(v6, v2)
        end
        if not p2 then
            v4 = u12
            local UpdateRotation = v4.UpdateRotation
            v7 = u12
            local Inertia = v7.GetRotation("Inertia")
            v9 = CFrame.Angles(-u16.Position.Y, 0, u16.Position.X)
            UpdateRotation("Inertia", nil, Inertia:Lerp(v9, v2), true)
        else
            u12.UpdateRotation("Inertia", "Barrel", u28, true)
        end
        return u30, u26
    end,
}