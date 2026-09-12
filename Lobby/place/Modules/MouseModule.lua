local IsInClipping
repeat
    wait()
until game.Players.LocalPlayer
local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFeedback = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.ButtonFeedback)
local UISounds = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.UISounds)
local u30 = {}
local u31 = {Visible = false}
task.defer(function() -- Line: 11 -- upvalues: LocalPlayer (val), u31 (ref)
    local Panel = LocalPlayer.PlayerGui:WaitForChild("Panel", 30)
    if Panel then
        u31 = (Panel:WaitForChild("Elements")):WaitForChild("Commander")
    end
end)

local function isGuiRoot(p1) -- Line: 18
    local v1 = p1:IsA("ScreenGui")
    if not v1 then
        v1 = p1:IsA("SurfaceGui")
        if not v1 then
            v1 = p1:IsA("BillboardGui")
        end
    end
    return v1
end

local function findSurfaceGui(p1) -- Line: 22
    local v1, v2
    local Parent = p1
    while true do
        v2 = Parent
        v1 = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
        if v1 then
            return Parent
        end
        if not Parent.Parent then
            return Parent
        else
            Parent = Parent.Parent
        end
    end
end

local function refreshSurfaceGui(p1) -- Line: 37 -- upvalues: findSurfaceGui (val)
    if not p1.SurfaceGui then
        p1.SurfaceGui = findSurfaceGui(p1.UIObj)
    end
    return p1.SurfaceGui
end

local u39 = nil
local u40 = nil

local function getSurfaceGuiAdornee(p1) -- Line: 47
    if p1.Adornee and p1.Adornee:IsA("BasePart") then
        return p1.Adornee
    end
    if p1.Parent and p1.Parent:IsA("BasePart") then
        return p1.Parent
    end
    return nil
end

local function getSurfaceGuiCanvasSize(p1) -- Line: 57
    local success, result = pcall(function() -- Line: 58 -- upvalues: p1 (val)
        return p1.AbsoluteSize
    end)
    if success and 0 < result.X and 0 < result.Y then
        return result
    end
    local CanvasSize = p1.CanvasSize
    if 0 < CanvasSize.X and 0 < CanvasSize.Y then
        return CanvasSize
    end
    return nil
end

local function getScreenPointRay(p1, p2) -- Line: 73
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return nil
    end
    local success, result = pcall(function() -- Line: 79 -- upvalues: CurrentCamera (val), p1 (val), p2 (val)
        local v1 = CurrentCamera
        local v2 = p1
        local v3 = p2
        return v1:ScreenPointToRay(v2, v3)
    end)
    if success then
        return result
    end
    return CurrentCamera:ViewportPointToRay(p1, p2)
end

local function getSurfacePoint(p1, p2, p3) -- Line: 89 -- upvalues: getSurfaceGuiCanvasSize (val)
    local Adornee, v1
    if not p1.Adornee then
        if not p1.Parent or not p1.Parent:IsA("BasePart") then
            Adornee = nil
        else
            Adornee = p1.Parent
        end
    elseif p1.Adornee:IsA("BasePart") then
        Adornee = p1.Adornee
    elseif not p1.Parent or not p1.Parent:IsA("BasePart") then
        Adornee = nil
    else
        Adornee = p1.Parent
    end
    local v2 = getSurfaceGuiCanvasSize(p1)
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
        local success, result = pcall(function() -- Line: 79 -- upvalues: CurrentCamera (val), p2 (val), p3 (val)
            local v1 = CurrentCamera
            local v2 = p2
            local v3 = p3
            return v1:ScreenPointToRay(v2, v3)
        end)
        if not success then
            v1 = CurrentCamera:ViewportPointToRay(p2, p3)
        else
            v1 = result
        end
    else
        v1 = nil
    end
    if Adornee and v2 and v1 then
        local CFrame, X, X_2, X_3, X_4, Y, Y_2, Y_3, Y_4, Z, Z_2, Z_3, Z_4, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
        local Size = Adornee.Size
        local v13 = Size.X * 0.5
        local v14 = Size.Y * 0.5
        local v15 = Size.Z * 0.5
        local Face = p1.Face
        if Face == Enum.NormalId.Front then
            v3 = Vector3.new(0, 0, -1)
            v8 = -v15
            v4 = Vector3.new(0, 0, v8)
            v5 = Adornee.CFrame:VectorToWorldSpace(v3)
            v6 = Adornee.CFrame:PointToWorldSpace(v4)
            v7 = v1.Direction:Dot(v5)
            if (math.abs(v7)) < 1e-05 then
                return nil
            end
            v8 = (v6 - v1.Origin):Dot(v5) / v7
            if v8 < 0 then
                return nil
            end
            CFrame = Adornee.CFrame
            v11 = v1.Origin + v1.Direction * v8
            v9 = CFrame:PointToObjectSpace(v11)
            v10 = nil
            v11 = nil
            if Face == Enum.NormalId.Front then
                X = v9.X
                v12 = math.abs(X)
                if not (v13 + 0.001 < v12) then
                    Y = v9.Y
                    v12 = math.abs(Y)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v13 - v9.X) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Back then
                X_2 = v9.X
                v12 = math.abs(X_2)
                if not (v13 + 0.001 < v12) then
                    Y_2 = v9.Y
                    v12 = math.abs(Y_2)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.X + v13) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Right then
                Z = v9.Z
                v12 = math.abs(Z)
                if not (v15 + 0.001 < v12) then
                    Y_3 = v9.Y
                    v12 = math.abs(Y_3)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Left then
                Z_2 = v9.Z
                v12 = math.abs(Z_2)
                if not (v15 + 0.001 < v12) then
                    Y_4 = v9.Y
                    v12 = math.abs(Y_4)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.Z + v15) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Top then
                Z_3 = v9.Z
                v12 = math.abs(Z_3)
                if not (v15 + 0.001 < v12) then
                    X_3 = v9.X
                    v12 = math.abs(X_3)
                    if not (v13 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v9.X + v13) / Size.X
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face ~= Enum.NormalId.Bottom then
                if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                    return Vector2.new(v10 * v2.X, v11 * v2.Y)
                end
                return nil
            end
            Z_4 = v9.Z
            v12 = math.abs(Z_4)
            if not (v15 + 0.001 < v12) then
                X_4 = v9.X
                v12 = math.abs(X_4)
                if not (v13 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v13 - v9.X) / Size.X
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Back then
            v3 = Vector3.new(0, 0, 1)
            v4 = Vector3.new(0, 0, v15)
            v5 = Adornee.CFrame:VectorToWorldSpace(v3)
            v6 = Adornee.CFrame:PointToWorldSpace(v4)
            v7 = v1.Direction:Dot(v5)
            if (math.abs(v7)) < 1e-05 then
                return nil
            end
            v8 = (v6 - v1.Origin):Dot(v5) / v7
            if v8 < 0 then
                return nil
            end
            CFrame = Adornee.CFrame
            v11 = v1.Origin + v1.Direction * v8
            v9 = CFrame:PointToObjectSpace(v11)
            v10 = nil
            v11 = nil
            if Face == Enum.NormalId.Front then
                X = v9.X
                v12 = math.abs(X)
                if not (v13 + 0.001 < v12) then
                    Y = v9.Y
                    v12 = math.abs(Y)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v13 - v9.X) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Back then
                X_2 = v9.X
                v12 = math.abs(X_2)
                if not (v13 + 0.001 < v12) then
                    Y_2 = v9.Y
                    v12 = math.abs(Y_2)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.X + v13) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Right then
                Z = v9.Z
                v12 = math.abs(Z)
                if not (v15 + 0.001 < v12) then
                    Y_3 = v9.Y
                    v12 = math.abs(Y_3)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Left then
                Z_2 = v9.Z
                v12 = math.abs(Z_2)
                if not (v15 + 0.001 < v12) then
                    Y_4 = v9.Y
                    v12 = math.abs(Y_4)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.Z + v15) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Top then
                Z_3 = v9.Z
                v12 = math.abs(Z_3)
                if not (v15 + 0.001 < v12) then
                    X_3 = v9.X
                    v12 = math.abs(X_3)
                    if not (v13 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v9.X + v13) / Size.X
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face ~= Enum.NormalId.Bottom then
                if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                    return Vector2.new(v10 * v2.X, v11 * v2.Y)
                end
                return nil
            end
            Z_4 = v9.Z
            v12 = math.abs(Z_4)
            if not (v15 + 0.001 < v12) then
                X_4 = v9.X
                v12 = math.abs(X_4)
                if not (v13 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v13 - v9.X) / Size.X
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Right then
            v3 = Vector3.new(1, 0, 0)
            v4 = Vector3.new(v13, 0, 0)
            v5 = Adornee.CFrame:VectorToWorldSpace(v3)
            v6 = Adornee.CFrame:PointToWorldSpace(v4)
            v7 = v1.Direction:Dot(v5)
            if (math.abs(v7)) < 1e-05 then
                return nil
            end
            v8 = (v6 - v1.Origin):Dot(v5) / v7
            if v8 < 0 then
                return nil
            end
            CFrame = Adornee.CFrame
            v11 = v1.Origin + v1.Direction * v8
            v9 = CFrame:PointToObjectSpace(v11)
            v10 = nil
            v11 = nil
            if Face == Enum.NormalId.Front then
                X = v9.X
                v12 = math.abs(X)
                if not (v13 + 0.001 < v12) then
                    Y = v9.Y
                    v12 = math.abs(Y)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v13 - v9.X) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Back then
                X_2 = v9.X
                v12 = math.abs(X_2)
                if not (v13 + 0.001 < v12) then
                    Y_2 = v9.Y
                    v12 = math.abs(Y_2)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.X + v13) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Right then
                Z = v9.Z
                v12 = math.abs(Z)
                if not (v15 + 0.001 < v12) then
                    Y_3 = v9.Y
                    v12 = math.abs(Y_3)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Left then
                Z_2 = v9.Z
                v12 = math.abs(Z_2)
                if not (v15 + 0.001 < v12) then
                    Y_4 = v9.Y
                    v12 = math.abs(Y_4)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.Z + v15) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Top then
                Z_3 = v9.Z
                v12 = math.abs(Z_3)
                if not (v15 + 0.001 < v12) then
                    X_3 = v9.X
                    v12 = math.abs(X_3)
                    if not (v13 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v9.X + v13) / Size.X
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face ~= Enum.NormalId.Bottom then
                if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                    return Vector2.new(v10 * v2.X, v11 * v2.Y)
                end
                return nil
            end
            Z_4 = v9.Z
            v12 = math.abs(Z_4)
            if not (v15 + 0.001 < v12) then
                X_4 = v9.X
                v12 = math.abs(X_4)
                if not (v13 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v13 - v9.X) / Size.X
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Left then
            v3 = Vector3.new(-1, 0, 0)
            v6 = -v13
            v4 = Vector3.new(v6, 0, 0)
            v5 = Adornee.CFrame:VectorToWorldSpace(v3)
            v6 = Adornee.CFrame:PointToWorldSpace(v4)
            v7 = v1.Direction:Dot(v5)
            if (math.abs(v7)) < 1e-05 then
                return nil
            end
            v8 = (v6 - v1.Origin):Dot(v5) / v7
            if v8 < 0 then
                return nil
            end
            CFrame = Adornee.CFrame
            v11 = v1.Origin + v1.Direction * v8
            v9 = CFrame:PointToObjectSpace(v11)
            v10 = nil
            v11 = nil
            if Face == Enum.NormalId.Front then
                X = v9.X
                v12 = math.abs(X)
                if not (v13 + 0.001 < v12) then
                    Y = v9.Y
                    v12 = math.abs(Y)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v13 - v9.X) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Back then
                X_2 = v9.X
                v12 = math.abs(X_2)
                if not (v13 + 0.001 < v12) then
                    Y_2 = v9.Y
                    v12 = math.abs(Y_2)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.X + v13) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Right then
                Z = v9.Z
                v12 = math.abs(Z)
                if not (v15 + 0.001 < v12) then
                    Y_3 = v9.Y
                    v12 = math.abs(Y_3)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Left then
                Z_2 = v9.Z
                v12 = math.abs(Z_2)
                if not (v15 + 0.001 < v12) then
                    Y_4 = v9.Y
                    v12 = math.abs(Y_4)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.Z + v15) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Top then
                Z_3 = v9.Z
                v12 = math.abs(Z_3)
                if not (v15 + 0.001 < v12) then
                    X_3 = v9.X
                    v12 = math.abs(X_3)
                    if not (v13 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v9.X + v13) / Size.X
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face ~= Enum.NormalId.Bottom then
                if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                    return Vector2.new(v10 * v2.X, v11 * v2.Y)
                end
                return nil
            end
            Z_4 = v9.Z
            v12 = math.abs(Z_4)
            if not (v15 + 0.001 < v12) then
                X_4 = v9.X
                v12 = math.abs(X_4)
                if not (v13 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v13 - v9.X) / Size.X
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Top then
            v3 = Vector3.new(0, 1, 0)
            v4 = Vector3.new(0, v14, 0)
            v5 = Adornee.CFrame:VectorToWorldSpace(v3)
            v6 = Adornee.CFrame:PointToWorldSpace(v4)
            v7 = v1.Direction:Dot(v5)
            if (math.abs(v7)) < 1e-05 then
                return nil
            end
            v8 = (v6 - v1.Origin):Dot(v5) / v7
            if v8 < 0 then
                return nil
            end
            CFrame = Adornee.CFrame
            v11 = v1.Origin + v1.Direction * v8
            v9 = CFrame:PointToObjectSpace(v11)
            v10 = nil
            v11 = nil
            if Face == Enum.NormalId.Front then
                X = v9.X
                v12 = math.abs(X)
                if not (v13 + 0.001 < v12) then
                    Y = v9.Y
                    v12 = math.abs(Y)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v13 - v9.X) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Back then
                X_2 = v9.X
                v12 = math.abs(X_2)
                if not (v13 + 0.001 < v12) then
                    Y_2 = v9.Y
                    v12 = math.abs(Y_2)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.X + v13) / Size.X
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Right then
                Z = v9.Z
                v12 = math.abs(Z)
                if not (v15 + 0.001 < v12) then
                    Y_3 = v9.Y
                    v12 = math.abs(Y_3)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Left then
                Z_2 = v9.Z
                v12 = math.abs(Z_2)
                if not (v15 + 0.001 < v12) then
                    Y_4 = v9.Y
                    v12 = math.abs(Y_4)
                    if not (v14 + 0.001 < v12) then
                        v10 = (v9.Z + v15) / Size.Z
                        v11 = (v14 - v9.Y) / Size.Y
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face == Enum.NormalId.Top then
                Z_3 = v9.Z
                v12 = math.abs(Z_3)
                if not (v15 + 0.001 < v12) then
                    X_3 = v9.X
                    v12 = math.abs(X_3)
                    if not (v13 + 0.001 < v12) then
                        v10 = (v15 - v9.Z) / Size.Z
                        v11 = (v9.X + v13) / Size.X
                        if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                            return Vector2.new(v10 * v2.X, v11 * v2.Y)
                        end
                        return nil
                    end
                end
                return nil
            end
            if Face ~= Enum.NormalId.Bottom then
                if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                    return Vector2.new(v10 * v2.X, v11 * v2.Y)
                end
                return nil
            end
            Z_4 = v9.Z
            v12 = math.abs(Z_4)
            if not (v15 + 0.001 < v12) then
                X_4 = v9.X
                v12 = math.abs(X_4)
                if not (v13 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v13 - v9.X) / Size.X
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face ~= Enum.NormalId.Bottom then
            return nil
        end
        v3 = Vector3.new(0, -1, 0)
        v7 = -v14
        v4 = Vector3.new(0, v7, 0)
        v5 = Adornee.CFrame:VectorToWorldSpace(v3)
        v6 = Adornee.CFrame:PointToWorldSpace(v4)
        v7 = v1.Direction:Dot(v5)
        if (math.abs(v7)) < 1e-05 then
            return nil
        end
        v8 = (v6 - v1.Origin):Dot(v5) / v7
        if v8 < 0 then
            return nil
        end
        CFrame = Adornee.CFrame
        v11 = v1.Origin + v1.Direction * v8
        v9 = CFrame:PointToObjectSpace(v11)
        v10 = nil
        v11 = nil
        if Face == Enum.NormalId.Front then
            X = v9.X
            v12 = math.abs(X)
            if not (v13 + 0.001 < v12) then
                Y = v9.Y
                v12 = math.abs(Y)
                if not (v14 + 0.001 < v12) then
                    v10 = (v13 - v9.X) / Size.X
                    v11 = (v14 - v9.Y) / Size.Y
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Back then
            X_2 = v9.X
            v12 = math.abs(X_2)
            if not (v13 + 0.001 < v12) then
                Y_2 = v9.Y
                v12 = math.abs(Y_2)
                if not (v14 + 0.001 < v12) then
                    v10 = (v9.X + v13) / Size.X
                    v11 = (v14 - v9.Y) / Size.Y
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Right then
            Z = v9.Z
            v12 = math.abs(Z)
            if not (v15 + 0.001 < v12) then
                Y_3 = v9.Y
                v12 = math.abs(Y_3)
                if not (v14 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v14 - v9.Y) / Size.Y
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Left then
            Z_2 = v9.Z
            v12 = math.abs(Z_2)
            if not (v15 + 0.001 < v12) then
                Y_4 = v9.Y
                v12 = math.abs(Y_4)
                if not (v14 + 0.001 < v12) then
                    v10 = (v9.Z + v15) / Size.Z
                    v11 = (v14 - v9.Y) / Size.Y
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face == Enum.NormalId.Top then
            Z_3 = v9.Z
            v12 = math.abs(Z_3)
            if not (v15 + 0.001 < v12) then
                X_3 = v9.X
                v12 = math.abs(X_3)
                if not (v13 + 0.001 < v12) then
                    v10 = (v15 - v9.Z) / Size.Z
                    v11 = (v9.X + v13) / Size.X
                    if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                        return Vector2.new(v10 * v2.X, v11 * v2.Y)
                    end
                    return nil
                end
            end
            return nil
        end
        if Face ~= Enum.NormalId.Bottom then
            if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                return Vector2.new(v10 * v2.X, v11 * v2.Y)
            end
            return nil
        end
        Z_4 = v9.Z
        v12 = math.abs(Z_4)
        if not (v15 + 0.001 < v12) then
            X_4 = v9.X
            v12 = math.abs(X_4)
            if not (v13 + 0.001 < v12) then
                v10 = (v15 - v9.Z) / Size.Z
                v11 = (v13 - v9.X) / Size.X
                if v10 and v11 and not (v10 < 0) and not (1 < v10) and not (v11 < 0) and not (1 < v11) then
                    return Vector2.new(v10 * v2.X, v11 * v2.Y)
                end
                return nil
            end
        end
        return nil
    end
    return nil
end

local function getPointerPosition(p1, p2) -- Line: 189
    -- upvalues: findSurfaceGui (val), Mouse (val), u40 (ref), getSurfacePoint (val)
    local X, Y
    if not p1.SurfaceGui then
        p1.SurfaceGui = findSurfaceGui(p1.UIObj)
    end
    local SurfaceGui = p1.SurfaceGui
    if not p2 then
        X = Mouse.X
    else
        X = p2.X
        if not X then
            X = Mouse.X
        end
    end
    if not p2 then
        Y = Mouse.Y
    else
        Y = p2.Y
        if not Y then
            Y = Mouse.Y
        end
    end
    if SurfaceGui and SurfaceGui:IsA("SurfaceGui") then
        local v1 = u40
        if v1 then
            v1 = u40[SurfaceGui]
        end
        if v1 == nil then
            v1 = getSurfacePoint(SurfaceGui, X, Y)
            if u40 then
                u40[SurfaceGui] = v1 or false
            end
        end
        if v1 then
            return v1.X, v1.Y
        end
        return nil, nil
    end
    return X, Y
end

local function isPartOfNotify(p1) -- Line: 211
    local Parent
    local Parent_2 = p1
    local v1 = nil
    while true do
        if Parent_2.Parent then
            if Parent_2.Parent:IsA("ScreenGui") and Parent_2.Parent.Name == "Notify" then
                Parent = Parent_2.Parent
                return true
            end
            if not Parent_2.Parent then
                return v1
            else
                Parent_2 = Parent_2.Parent
            end
        elseif not Parent_2.Parent then
            return v1
        else
            Parent_2 = Parent_2.Parent
        end
    end
end

local function isSettingsOpen() -- Line: 228 -- upvalues: LocalPlayer (val)
    local SettingsGui = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
    local Enabled = SettingsGui
    if Enabled then
        Enabled = SettingsGui.Enabled
    end
    return Enabled
end

local v1 = {
    MouseEnterLeaveEvent = function(p1) -- Line: 234 -- upvalues: u30 (val), findSurfaceGui (val), isPartOfNotify (val)
        if u30[p1] then
            return u30[p1].EnteredEvent.Event, u30[p1].LeaveEvent.Event, u30[p1].ClickEvent.Event, u30[p1].DownEvent.Event, u30[p1].UpEvent.Event
        end
        p1.Active = false
        local u24 = {}
        u24.UIObj = p1
        local BindableEvent = Instance.new("BindableEvent")
        local BindableEvent_2 = Instance.new("BindableEvent")
        local BindableEvent_3 = Instance.new("BindableEvent")
        local BindableEvent_4 = Instance.new("BindableEvent")
        local BindableEvent_5 = Instance.new("BindableEvent")
        u24.EnteredEvent = BindableEvent
        u24.MouseIn = false
        u24.MouseDownOnObj = false
        u24.LeaveEvent = BindableEvent_2
        u24.ClickEvent = BindableEvent_3
        u24.DownEvent = BindableEvent_4
        u24.UpEvent = BindableEvent_5
        u24.SurfaceGui = findSurfaceGui(p1)
        u24.IsPartOfNotify = isPartOfNotify(p1)
        u30[p1] = u24
        p1.AncestryChanged:Connect(function() -- Line: 258 -- upvalues: u24 (val), isPartOfNotify (upval), p1 (val)
            u24.SurfaceGui = nil
            u24.IsPartOfNotify = isPartOfNotify(p1)
        end)
        p1.Destroying:Connect(function() -- Line: 262
            -- upvalues: BindableEvent (val), BindableEvent_2 (val), BindableEvent_3 (val), BindableEvent_4 (val)
            -- upvalues: BindableEvent_5 (val), u30 (upval), p1 (val)
            BindableEvent:Destroy()
            BindableEvent_2:Destroy()
            BindableEvent_3:Destroy()
            BindableEvent_4:Destroy()
            BindableEvent_5:Destroy()
            u30[p1] = nil
        end)
        return BindableEvent.Event, BindableEvent_2.Event, BindableEvent_3.Event, BindableEvent_4.Event, BindableEvent_5.Event, BindableEvent_3
    end,
}

local function IsInFrame(p1, p2, p3) -- Line: 294 -- upvalues: getPointerPosition (val), Mouse (val)
    local X, Y
    if p1.Visible ~= true then
        return
    end
    if not p2 then
        X = Mouse.X
        Y = Mouse.Y
    else
        local v1, v2 = getPointerPosition(p2, p3)
        X = v1
        Y = v2
    end
    if X
        and Y
        and p1.AbsolutePosition.X < X
        and p1.AbsolutePosition.Y < Y
        and X < p1.AbsolutePosition.X + p1.AbsoluteSize.X
        and Y < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y then
        return true
    end
    return false
end

local function ParentsVisible(p1) -- Line: 311 -- upvalues: findSurfaceGui (val), u39 (ref)
    local visible
    if not p1.SurfaceGui then
        p1.SurfaceGui = findSurfaceGui(p1.UIObj)
    end
    local SurfaceGui = p1.SurfaceGui

    function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
        local v1
        if u39 and u39[p1] ~= nil then
            return u39[p1]
        end
        if p1 ~= SurfaceGui then
            local Visible = false
            if p1.Parent ~= nil then
                if not p1:IsA("GuiObject") then
                    Visible = visible(p1.Parent)
                else
                    Visible = p1.Visible
                    if Visible then
                        Visible = visible(p1.Parent)
                    end
                end
            end
            v1 = Visible
        else
            local v2 = SurfaceGui
            local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
            if Enabled then
                Enabled = SurfaceGui.Enabled
            end
            v1 = Enabled
        end
        if u39 then
            u39[p1] = v1
        end
        return v1
    end

    return (visible(p1.UIObj))
end

local function checkIfNotifyAndIsApartOf(p1, p2) -- Line: 331 -- upvalues: LocalPlayer (val), u30 (val)
    if LocalPlayer.PlayerGui:FindFirstChild("Notify") then
        return u30[p2].IsPartOfNotify
    end
    return true
end

function IsInClipping(p1, p2, p3) -- Line: 352 -- upvalues: IsInFrame (val), IsInClipping (val)
    local v1
    if not p1.Parent:IsA("GuiObject") or not p1.Parent.ClipsDescendants then
        v1 = not p1.Parent:IsA("GuiObject")
        if not v1 then
            v1 = IsInClipping(p1.Parent, p2, p3)
        end
    else
        v1 = IsInFrame(p1.Parent, p2, p3)
        if v1 then
            v1 = not p1.Parent:IsA("GuiObject")
            if not v1 then
                v1 = IsInClipping(p1.Parent, p2, p3)
            end
        end
    end
    return v1
end

;(game:GetService("RunService")).Heartbeat:connect(function() -- Line: 356
    -- upvalues: Mouse (val), u39 (ref), u40 (ref), u30 (val), findSurfaceGui (val), IsInFrame (val), LocalPlayer (val)
    -- upvalues: IsInClipping (val), UISounds (val)
    local IsPartOfNotify
    local v1 = nil
    local v2 = Vector2.new(Mouse.X, Mouse.Y)
    u39 = {}
    u40 = {}
    for k, v in pairs(u30) do
        if k.Visible then
            if not v.SurfaceGui then
                v.SurfaceGui = findSurfaceGui(v.UIObj)
            end
            local SurfaceGui = v.SurfaceGui

            local function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
                local v1
                if u39 and u39[p1] ~= nil then
                    return u39[p1]
                end
                if p1 ~= SurfaceGui then
                    local Visible = false
                    if p1.Parent ~= nil then
                        if not p1:IsA("GuiObject") then
                            Visible = visible(p1.Parent)
                        else
                            Visible = p1.Visible
                            if Visible then
                                Visible = visible(p1.Parent)
                            end
                        end
                    end
                    v1 = Visible
                else
                    local v2 = SurfaceGui
                    local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                    if Enabled then
                        Enabled = SurfaceGui.Enabled
                    end
                    v1 = Enabled
                end
                if u39 then
                    u39[p1] = v1
                end
                return v1
            end

            if visible(v.UIObj) and IsInFrame(v.UIObj, v, v2) then
                if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u30[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v1 then
                        if IsInClipping(v.UIObj, v, v2) then
                            v1 = k
                        end
                    elseif v1.ZIndex < k.ZIndex and IsInClipping(v.UIObj, v, v2) then
                        v1 = k
                    end
                end
            end
        end
    end
    u39 = nil
    u40 = nil
    for k2, i in pairs(u30) do
        if k2 ~= v1 and i.MouseIn then
            i.MouseIn = false
            i.LeaveEvent:Fire()
        end
    end
    local v3 = v1
    if v3 then
        v3 = u30[v1]
    end
    if v3 and not v3.MouseIn then
        v3.MouseIn = true
        UISounds.Hover()
        v3.EnteredEvent:Fire()
    end
end)

local function pointInObject(p1, p2, p3) -- Line: 390
    local v1 = p2
    if v1 then
        v1 = p3
        if v1 then
            v1 = false
            if p1.AbsolutePosition.X < p2 then
                v1 = false
                if p1.AbsolutePosition.Y < p3 then
                    v1 = false
                    if p2 < p1.AbsolutePosition.X + p1.AbsoluteSize.X then
                        v1 = p3 < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y
                    end
                end
            end
        end
    end
    return v1
end

local function inputDown(p1, p2, p3) -- Line: 396
    -- upvalues: u30 (val), getPointerPosition (val), findSurfaceGui (val), u39 (ref), LocalPlayer (val)
    -- upvalues: IsInClipping (val), u31 (ref), ButtonFeedback (val)
    local IsPartOfNotify, IsPartOfNotify_2, v1, v2, v3
    local v4 = nil
    local v5, v6 = p3, p1
    for k, v in pairs(u30) do
        if v5 then
            v3, v1 = getPointerPosition(v, v5)
            v2 = v3
            if v2 then
                v2 = v1
                if v2 then
                    v2 = false
                    if k.AbsolutePosition.X < v3 then
                        v2 = false
                        if k.AbsolutePosition.Y < v1 then
                            v2 = false
                            if v3 < k.AbsolutePosition.X + k.AbsoluteSize.X then
                                v2 = v1 < k.AbsolutePosition.Y + k.AbsoluteSize.Y
                            end
                        end
                    end
                end
            end
            if not v2 or not v.UIObj.Visible then
                v.MouseDownOnObj = false
            else
                if not v.SurfaceGui then
                    v.SurfaceGui = findSurfaceGui(v.UIObj)
                end
                local SurfaceGui = v.SurfaceGui

                local function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
                    local v1
                    if u39 and u39[p1] ~= nil then
                        return u39[p1]
                    end
                    if p1 ~= SurfaceGui then
                        local Visible = false
                        if p1.Parent ~= nil then
                            if not p1:IsA("GuiObject") then
                                Visible = visible(p1.Parent)
                            else
                                Visible = p1.Visible
                                if Visible then
                                    Visible = visible(p1.Parent)
                                end
                            end
                        end
                        v1 = Visible
                    else
                        local v2 = SurfaceGui
                        local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                        if Enabled then
                            Enabled = SurfaceGui.Enabled
                        end
                        v1 = Enabled
                    end
                    if u39 then
                        u39[p1] = v1
                    end
                    return v1
                end

                if not visible(v.UIObj) then
                    v.MouseDownOnObj = false
                else
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u30[k].IsPartOfNotify
                    end
                    if not IsPartOfNotify then
                        v.MouseDownOnObj = false
                    elseif not v4 then
                        if not IsInClipping(v.UIObj, v, v5) then
                            v.MouseDownOnObj = false
                        else
                            if v4 then
                                v2 = u30[v4]
                                v2.MouseDownOnObj = false
                            end
                            v4 = k
                        end
                    elseif not (v4.ZIndex < k.ZIndex) or not IsInClipping(v.UIObj, v, v5) then
                        v.MouseDownOnObj = false
                    else
                        if v4 then
                            v2 = u30[v4]
                            v2.MouseDownOnObj = false
                        end
                        v4 = k
                    end
                end
            end
        elseif v6 then
            if v6.KeyCode == Enum.KeyCode.ButtonA then
                if not v.MouseIn or not v.UIObj.Visible then
                    v.MouseDownOnObj = false
                else
                    if not v.SurfaceGui then
                        v.SurfaceGui = findSurfaceGui(v.UIObj)
                    end
                    local SurfaceGui_2 = v.SurfaceGui

                    local function visible_2(p1) -- Line: 313
                        -- upvalues: u39 (upval), SurfaceGui_2 (val), visible_2 (val)
                        local v1
                        if u39 and u39[p1] ~= nil then
                            return u39[p1]
                        end
                        if p1 ~= SurfaceGui_2 then
                            local Visible = false
                            if p1.Parent ~= nil then
                                if not p1:IsA("GuiObject") then
                                    Visible = visible_2(p1.Parent)
                                else
                                    Visible = p1.Visible
                                    if Visible then
                                        Visible = visible_2(p1.Parent)
                                    end
                                end
                            end
                            v1 = Visible
                        else
                            local v2 = SurfaceGui_2
                            local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                            if Enabled then
                                Enabled = SurfaceGui_2.Enabled
                            end
                            v1 = Enabled
                        end
                        if u39 then
                            u39[p1] = v1
                        end
                        return v1
                    end

                    if not visible_2(v.UIObj) then
                        v.MouseDownOnObj = false
                    else
                        if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                            IsPartOfNotify_2 = true
                        else
                            IsPartOfNotify_2 = u30[k].IsPartOfNotify
                        end
                        if not IsPartOfNotify_2 then
                            v.MouseDownOnObj = false
                        elseif not v4 then
                            if not IsInClipping(v.UIObj, v) then
                                v.MouseDownOnObj = false
                            else
                                if v4 then
                                    v3 = u30[v4]
                                    v3.MouseDownOnObj = false
                                end
                                v4 = k
                            end
                        elseif not (v4.ZIndex < k.ZIndex) or not IsInClipping(v.UIObj, v) then
                            v.MouseDownOnObj = false
                        else
                            if v4 then
                                v3 = u30[v4]
                                v3.MouseDownOnObj = false
                            end
                            v4 = k
                        end
                    end
                end
            elseif v6.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v.MouseIn or not v.UIObj.Visible then
                    v.MouseDownOnObj = false
                else
                    if not v.SurfaceGui then
                        v.SurfaceGui = findSurfaceGui(v.UIObj)
                    end
                    local SurfaceGui_2 = v.SurfaceGui

                    local function visible_2(p1) -- Line: 313
                        -- upvalues: u39 (upval), SurfaceGui_2 (val), visible_2 (val)
                        local v1
                        if u39 and u39[p1] ~= nil then
                            return u39[p1]
                        end
                        if p1 ~= SurfaceGui_2 then
                            local Visible = false
                            if p1.Parent ~= nil then
                                if not p1:IsA("GuiObject") then
                                    Visible = visible_2(p1.Parent)
                                else
                                    Visible = p1.Visible
                                    if Visible then
                                        Visible = visible_2(p1.Parent)
                                    end
                                end
                            end
                            v1 = Visible
                        else
                            local v2 = SurfaceGui_2
                            local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                            if Enabled then
                                Enabled = SurfaceGui_2.Enabled
                            end
                            v1 = Enabled
                        end
                        if u39 then
                            u39[p1] = v1
                        end
                        return v1
                    end

                    if not visible_2(v.UIObj) then
                        v.MouseDownOnObj = false
                    else
                        if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                            IsPartOfNotify_2 = true
                        else
                            IsPartOfNotify_2 = u30[k].IsPartOfNotify
                        end
                        if not IsPartOfNotify_2 then
                            v.MouseDownOnObj = false
                        elseif not v4 then
                            if not IsInClipping(v.UIObj, v) then
                                v.MouseDownOnObj = false
                            else
                                if v4 then
                                    v3 = u30[v4]
                                    v3.MouseDownOnObj = false
                                end
                                v4 = k
                            end
                        elseif not (v4.ZIndex < k.ZIndex) or not IsInClipping(v.UIObj, v) then
                            v.MouseDownOnObj = false
                        else
                            if v4 then
                                v3 = u30[v4]
                                v3.MouseDownOnObj = false
                            end
                            v4 = k
                        end
                    end
                end
            end
        end
    end
    if v4 then
        local Enabled, SettingsGui, v7, v8, v9
        local Notify = LocalPlayer.PlayerGui:FindFirstChild("Notify")
        local v10 = u30[v4]
        if not Notify then
            if not Notify and not v10.IsPartOfNotify then
                v10.MouseDownOnObj = true
                if not v5 then
                    v9, v3 = getPointerPosition(v10)
                    v7 = v9
                    v8 = v3
                else
                    v9, v3 = getPointerPosition(v10, v5)
                    v7 = v9
                    v8 = v3
                    v10.EnteredEvent:Fire()
                end
                if v7 and v8 and not u31.Visible then
                    SettingsGui = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                    Enabled = SettingsGui
                    if Enabled then
                        Enabled = SettingsGui.Enabled
                    end
                    if not Enabled then
                        v9 = Vector2.new(v7, v8)
                        if v5 then
                            v9 = ButtonFeedback.PointFromMouseEvent(v5.X, v5.Y) or v9
                        end
                        ButtonFeedback.Ripple(v10.UIObj, v9)
                        v10.DownEvent:Fire(v7, v8)
                    end
                end
            end
        elseif v10.IsPartOfNotify or not Notify and not v10.IsPartOfNotify then
            v10.MouseDownOnObj = true
            if not v5 then
                v9, v3 = getPointerPosition(v10)
                v7 = v9
                v8 = v3
            else
                v9, v3 = getPointerPosition(v10, v5)
                v7 = v9
                v8 = v3
                v10.EnteredEvent:Fire()
            end
            if v7 and v8 and not u31.Visible then
                SettingsGui = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                Enabled = SettingsGui
                if Enabled then
                    Enabled = SettingsGui.Enabled
                end
                if not Enabled then
                    v9 = Vector2.new(v7, v8)
                    if v5 then
                        v9 = ButtonFeedback.PointFromMouseEvent(v5.X, v5.Y) or v9
                    end
                    ButtonFeedback.Ripple(v10.UIObj, v9)
                    v10.DownEvent:Fire(v7, v8)
                end
            end
        end
    end
end

local function inputEnded(p1, p2) -- Line: 445
    -- upvalues: u30 (val), getPointerPosition (val), LocalPlayer (val), findSurfaceGui (val), u39 (ref), u31 (ref)
    local IsPartOfNotify, IsPartOfNotify_2, v1, v2, v3, v4, v5, v6, v7
    local v8 = nil
    local v9, v10 = p2, p1
    for k, v in pairs(u30) do
        if v9 then
            v6, v7 = getPointerPosition(v, v9)
            v1 = v6
            if v1 then
                v1 = v7
                if v1 then
                    v1 = false
                    if k.AbsolutePosition.X < v6 then
                        v1 = false
                        if k.AbsolutePosition.Y < v7 then
                            v1 = false
                            if v6 < k.AbsolutePosition.X + k.AbsoluteSize.X then
                                v1 = v7 < k.AbsolutePosition.Y + k.AbsoluteSize.Y
                            end
                        end
                    end
                end
            end
            if v1 and v.UIObj.Visible and v.MouseDownOnObj == true then
                if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u30[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v8 or v8.ZIndex < k.ZIndex then
                        v8 = k
                    end
                end
            end
        elseif v10 then
            if v10.KeyCode == Enum.KeyCode.ButtonA then
                if k.Visible == true and k.Visible and v.MouseDownOnObj == true then
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify_2 = true
                    else
                        IsPartOfNotify_2 = u30[k].IsPartOfNotify
                    end
                    if IsPartOfNotify_2 then
                        if not v8 or v8.ZIndex < k.ZIndex then
                            v8 = k
                        end
                    end
                end
            elseif v10.UserInputType == Enum.UserInputType.MouseButton1
                and k.Visible == true
                and k.Visible
                and v.MouseDownOnObj == true then
                if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                    IsPartOfNotify_2 = true
                else
                    IsPartOfNotify_2 = u30[k].IsPartOfNotify
                end
                if IsPartOfNotify_2 then
                    if not v8 or v8.ZIndex < k.ZIndex then
                        v8 = k
                    end
                end
            end
        end
    end
    if not v8 then
        return
    end
    local v11 = u30[v8]
    if not v9 then
        v4, v5 = getPointerPosition(v11)
        v2 = v4
        v3 = v5
    else
        v4, v5 = getPointerPosition(v11, v9)
        v2 = v4
        v3 = v5
    end
    if v2 and v3 then
        if v9 then
            local visible
            if not v11.SurfaceGui then
                v11.SurfaceGui = findSurfaceGui(v11.UIObj)
            end
            local SurfaceGui = v11.SurfaceGui

            function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
                local v1
                if u39 and u39[p1] ~= nil then
                    return u39[p1]
                end
                if p1 ~= SurfaceGui then
                    local Visible = false
                    if p1.Parent ~= nil then
                        if not p1:IsA("GuiObject") then
                            Visible = visible(p1.Parent)
                        else
                            Visible = p1.Visible
                            if Visible then
                                Visible = visible(p1.Parent)
                            end
                        end
                    end
                    v1 = Visible
                else
                    local v2 = SurfaceGui
                    local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                    if Enabled then
                        Enabled = SurfaceGui.Enabled
                    end
                    v1 = Enabled
                end
                if u39 then
                    u39[p1] = v1
                end
                return v1
            end

            if visible(v11.UIObj) and not u31.Visible then
                local SettingsGui = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                local Enabled = SettingsGui
                if Enabled then
                    Enabled = SettingsGui.Enabled
                end
                if not Enabled then
                    local UIObj = v11.UIObj
                    v6 = v2
                    v7 = v3
                    v4 = v6
                    if v4 then
                        v4 = v7
                        if v4 then
                            v4 = false
                            if UIObj.AbsolutePosition.X < v6 then
                                v4 = false
                                if UIObj.AbsolutePosition.Y < v7 then
                                    v4 = false
                                    if v6 < UIObj.AbsolutePosition.X + UIObj.AbsoluteSize.X then
                                        v4 = v7 < UIObj.AbsolutePosition.Y + UIObj.AbsoluteSize.Y
                                    end
                                end
                            end
                        end
                    end
                    if v4 then
                        v11.ClickEvent:Fire(v2, v3)
                        return
                    end
                    v11.UpEvent:Fire(v2, v3)
                    return
                end
            end
        end
        if v11.MouseIn then
            local visible_2
            if not v11.SurfaceGui then
                v11.SurfaceGui = findSurfaceGui(v11.UIObj)
            end
            local SurfaceGui_2 = v11.SurfaceGui

            function visible_2(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui_2 (val), visible_2 (val)
                local v1
                if u39 and u39[p1] ~= nil then
                    return u39[p1]
                end
                if p1 ~= SurfaceGui_2 then
                    local Visible = false
                    if p1.Parent ~= nil then
                        if not p1:IsA("GuiObject") then
                            Visible = visible_2(p1.Parent)
                        else
                            Visible = p1.Visible
                            if Visible then
                                Visible = visible_2(p1.Parent)
                            end
                        end
                    end
                    v1 = Visible
                else
                    local v2 = SurfaceGui_2
                    local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                    if Enabled then
                        Enabled = SurfaceGui_2.Enabled
                    end
                    v1 = Enabled
                end
                if u39 then
                    u39[p1] = v1
                end
                return v1
            end

            if visible_2(v11.UIObj) and not u31.Visible then
                local SettingsGui_2 = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                local Enabled_2 = SettingsGui_2
                if Enabled_2 then
                    Enabled_2 = SettingsGui_2.Enabled
                end
                if not Enabled_2 then
                    v11.ClickEvent:Fire(v2, v3)
                    return
                end
            end
        end
        if not v11.MouseIn then
            v11.UpEvent:Fire(v2, v3)
        end
        return
    end
end

;(game:GetService("UserInputService")).InputBegan:connect(function(p1, p2) -- Line: 489 -- upvalues: inputDown (val)
    if p1.KeyCode == Enum.KeyCode.ButtonA or p1.UserInputType == Enum.UserInputType.MouseButton1 then
        inputDown(p1, p2)
    end
end)
if game:GetService("UserInputService").TouchEnabled then
    (game:GetService("UserInputService")).TouchStarted:Connect(function(p1, p2) -- Line: 496 -- upvalues: inputDown (val)
        inputDown(nil, p2, p1.Position)
    end)
    ;(game:GetService("UserInputService")).TouchEnded:Connect(function(p1, p2) -- Line: 499 -- upvalues: inputEnded (val)
        inputEnded(nil, p1.Position)
    end)
end
;(game:GetService("UserInputService")).InputEnded:connect(function(p1) -- Line: 504 -- upvalues: inputEnded (val)
    inputEnded(p1)
end)
;(game:GetService("UserInputService")).InputChanged:connect(function(p1, p2) -- Line: 508
    -- upvalues: u30 (val), IsInFrame (val), findSurfaceGui (val), u39 (ref), LocalPlayer (val), IsInClipping (val)
    if p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.Thumbstick1 then
        local IsPartOfNotify
        Vector2.new(p1.Position.X, p1.Position.Y)
        local v1 = nil
        for k, v in pairs(u30) do
            if not IsInFrame(v.UIObj, v) then
                if v.MouseIn then
                    v.MouseIn = false
                    v.LeaveEvent:Fire()
                end
            elseif k.Visible then
                if not v.SurfaceGui then
                    v.SurfaceGui = findSurfaceGui(v.UIObj)
                end
                local SurfaceGui = v.SurfaceGui

                local function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
                    local v1
                    if u39 and u39[p1] ~= nil then
                        return u39[p1]
                    end
                    if p1 ~= SurfaceGui then
                        local Visible = false
                        if p1.Parent ~= nil then
                            if not p1:IsA("GuiObject") then
                                Visible = visible(p1.Parent)
                            else
                                Visible = p1.Visible
                                if Visible then
                                    Visible = visible(p1.Parent)
                                end
                            end
                        end
                        v1 = Visible
                    else
                        local v2 = SurfaceGui
                        local Enabled = v2:IsA("ScreenGui") or v2:IsA("SurfaceGui") or v2:IsA("BillboardGui")
                        if Enabled then
                            Enabled = SurfaceGui.Enabled
                        end
                        v1 = Enabled
                    end
                    if u39 then
                        u39[p1] = v1
                    end
                    return v1
                end

                if visible(v.UIObj) then
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u30[k].IsPartOfNotify
                    end
                    if not IsPartOfNotify then
                        if v.MouseIn then
                            v.MouseIn = false
                            v.LeaveEvent:Fire()
                        end
                    elseif not v1 then
                        if IsInClipping(v.UIObj, v) then
                            v1 = k
                        elseif v.MouseIn then
                            v.MouseIn = false
                            v.LeaveEvent:Fire()
                        end
                    elseif not (v1.ZIndex < k.ZIndex) then
                        if v.MouseIn then
                            v.MouseIn = false
                            v.LeaveEvent:Fire()
                        end
                    elseif IsInClipping(v.UIObj, v) then
                        v1 = k
                    elseif v.MouseIn then
                        v.MouseIn = false
                        v.LeaveEvent:Fire()
                    end
                elseif v.MouseIn then
                    v.MouseIn = false
                    v.LeaveEvent:Fire()
                end
            elseif v.MouseIn then
                v.MouseIn = false
                v.LeaveEvent:Fire()
            end
        end
        if v1 and not u30[v1].MouseIn then
            local v2 = u30[v1]
            v2.MouseIn = true
            u30[v1].EnteredEvent:Fire()
        end
    end
end)
return v1