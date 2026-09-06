local IsInClipping, LocalPlayer, v1
while true do
    wait()
    if game.Players.LocalPlayer then
        break
    end
end
LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFeedback = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.ButtonFeedback)
local UISounds = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.UISounds)
local u30 = {}
local u31 = {Visible = false}
task.defer(function() -- Line: 11 -- upvalues: LocalPlayer (val), u31 (ref)
    local Panel = LocalPlayer.PlayerGui:WaitForChild("Panel", 30)
    if Panel then
        local Elements = Panel:WaitForChild("Elements")
        u31 = Elements:WaitForChild("Commander")
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
        v1 = v2:IsA("ScreenGui")
        if not v1 then
            v1 = v2:IsA("SurfaceGui")
            if not v1 then
                v1 = v2:IsA("BillboardGui")
            end
        end
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
    if not p1.Adornee then
        if p1.Parent then
            if p1.Parent:IsA("BasePart") then
                return p1.Parent
            end
            return nil
        end
        return nil
    end
    if p1.Adornee:IsA("BasePart") then
        return p1.Adornee
    end
    if not p1.Parent then
        return nil
    end
    if p1.Parent:IsA("BasePart") then
        return p1.Parent
    end
    return nil
end
local function getSurfaceGuiCanvasSize(p1) -- Line: 57
    local CanvasSize, v1, v2
    v1, v2 = pcall(function() -- Line: 58 -- upvalues: p1 (val)
        return p1.AbsoluteSize
    end)
    if not v1 or 0 >= v2.X then
        CanvasSize = p1.CanvasSize
        if 0 < CanvasSize.X then
            if 0 < CanvasSize.Y then
                return CanvasSize
            end
            return nil
        end
        return nil
    end
    if 0 < v2.Y then
        return v2
    end
    CanvasSize = p1.CanvasSize
    if 0 >= CanvasSize.X then
        return nil
    end
    if 0 < CanvasSize.Y then
        return CanvasSize
    end
    return nil
end
local function getScreenPointRay(p1, p2) -- Line: 73
    local v1, v2
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return nil
    end
    v1, v2 = pcall(function() -- Line: 79 -- upvalues: CurrentCamera (val), p1 (val), p2 (val)
        return CurrentCamera:ScreenPointToRay(p1, p2)
    end)
    if v1 then
        return v2
    end
    return CurrentCamera:ViewportPointToRay(p1, p2)
end
local function getSurfacePoint(p1, p2, p3) -- Line: 89 -- upvalues: getSurfaceGuiCanvasSize (val)
    local Adornee, v1, v2, v3
    if not p1.Adornee then
        if not p1.Parent then
            Adornee = nil
        elseif p1.Parent:IsA("BasePart") then
            Adornee = p1.Parent
        end
    elseif p1.Adornee:IsA("BasePart") then
        Adornee = p1.Adornee
    end
    local v4 = getSurfaceGuiCanvasSize(p1)
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
        v2, v3 = pcall(function() -- Line: 79 -- upvalues: CurrentCamera (val), p2 (val), p3 (val)
            return CurrentCamera:ScreenPointToRay(p2, p3)
        end)
        if not v2 then
            v1 = CurrentCamera:ViewportPointToRay(p2, p3)
        else
            v1 = v3
        end
    else
        v1 = nil
    end
    if not Adornee then
        return nil
    elseif not v4 then
        return nil
    else
        local v5, v6
        if not v1 then
            return nil
        end
        local Size = Adornee.Size
        v2 = Size.X * 0.5
        v3 = Size.Y * 0.5
        local v7 = Size.Z * 0.5
        local Face = p1.Face
        if Face == Enum.NormalId.Front then
            v5 = Vector3.new(0, 0, -1)
            v6 = Vector3.new(0, 0, -v7)
        elseif Face == Enum.NormalId.Back then
            v5 = Vector3.new(0, 0, 1)
            v6 = Vector3.new(0, 0, v7)
        elseif Face == Enum.NormalId.Right then
            v5 = Vector3.new(1, 0, 0)
            v6 = Vector3.new(v2, 0, 0)
        elseif Face == Enum.NormalId.Left then
            v5 = Vector3.new(-1, 0, 0)
            v6 = Vector3.new(-v2, 0, 0)
        elseif Face == Enum.NormalId.Top then
            v5 = Vector3.new(0, 1, 0)
            v6 = Vector3.new(0, v3, 0)
        elseif Face ~= Enum.NormalId.Bottom then
            return nil
        else
            local v8
            v5 = Vector3.new(0, -1, 0)
            v6 = Vector3.new(0, -v3, 0)
            local v9 = Adornee.CFrame:VectorToWorldSpace(v5)
            local v10 = Adornee.CFrame:PointToWorldSpace(v6)
            local v11 = v1.Direction:Dot(v9)
            local v12 = math.abs(v11)
            if v12 < 1e-05 then
                return nil
            end
            v12 = (v10 - v1.Origin):Dot(v9) / v11
            if v12 < 0 then
                return nil
            end
            local v13 = Adornee.CFrame:PointToObjectSpace(v1.Origin + v1.Direction * v12)
            local v14 = nil
            local v15 = nil
            if Face == Enum.NormalId.Front then
                v8 = math.abs(v13.X)
                if v2 + 0.001 < v8 then
                    return nil
                else
                    v8 = math.abs(v13.Y)
                    if v3 + 0.001 < v8 then
                        return nil
                    end
                    v14 = (v2 - v13.X) / Size.X
                    v15 = (v3 - v13.Y) / Size.Y
                end
            elseif Face == Enum.NormalId.Back then
                v8 = math.abs(v13.X)
                if v2 + 0.001 < v8 then
                    return nil
                else
                    v8 = math.abs(v13.Y)
                    if v3 + 0.001 < v8 then
                        return nil
                    end
                    v14 = (v13.X + v2) / Size.X
                    v15 = (v3 - v13.Y) / Size.Y
                end
            elseif Face == Enum.NormalId.Right then
                v8 = math.abs(v13.Z)
                if v7 + 0.001 < v8 then
                    return nil
                else
                    v8 = math.abs(v13.Y)
                    if v3 + 0.001 < v8 then
                        return nil
                    end
                    v14 = (v7 - v13.Z) / Size.Z
                    v15 = (v3 - v13.Y) / Size.Y
                end
            elseif Face == Enum.NormalId.Left then
                v8 = math.abs(v13.Z)
                if v7 + 0.001 < v8 then
                    return nil
                else
                    v8 = math.abs(v13.Y)
                    if v3 + 0.001 < v8 then
                        return nil
                    end
                    v14 = (v13.Z + v7) / Size.Z
                    v15 = (v3 - v13.Y) / Size.Y
                end
            elseif Face == Enum.NormalId.Top then
                v8 = math.abs(v13.Z)
                if v7 + 0.001 < v8 then
                    return nil
                else
                    v8 = math.abs(v13.X)
                    if v2 + 0.001 < v8 then
                        return nil
                    end
                    v14 = (v7 - v13.Z) / Size.Z
                    v15 = (v13.X + v2) / Size.X
                end
            elseif Face ~= Enum.NormalId.Bottom then
                if not v14 or not v15 or v14 < 0 or 1 < v14 or v15 < 0 or 1 < v15 then
                    return nil
                end
                return Vector2.new(v14 * v4.X, v15 * v4.Y)
            else
                v8 = math.abs(v13.Z)
                if v7 + 0.001 < v8 then
                    return nil
                else
                    v8 = math.abs(v13.X)
                    if v2 + 0.001 < v8 then
                        return nil
                    end
                    v14 = (v7 - v13.Z) / Size.Z
                    v15 = (v2 - v13.X) / Size.X
                end
            end
        end
    end
end
local function getPointerPosition(p1, p2) -- Line: 189 -- upvalues: findSurfaceGui (val), Mouse (val), u40 (ref), getSurfacePoint (val)
    local SurfaceGui, X, Y
    if not p1.SurfaceGui then
        p1.SurfaceGui = findSurfaceGui(p1.UIObj)
    end
    SurfaceGui = p1.SurfaceGui
    if not p2 then
        X = Mouse.X
    else
        X = p2.X
    end
    if not p2 then
        Y = Mouse.Y
    else
        Y = p2.Y
    end
    if not SurfaceGui or not (SurfaceGui:IsA("SurfaceGui")) then
        return X, Y
    end
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
local function isPartOfNotify(p1) -- Line: 211
    local Parent = p1
    local v1 = nil
    while true do
        if not Parent.Parent then
            if not Parent.Parent then
                return v1
            else
                Parent = Parent.Parent
            end
        elseif Parent.Parent:IsA("ScreenGui") and Parent.Parent.Name == "Notify" then
            return true
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
v1 = {
    MouseEnterLeaveEvent = function(p1) -- Line: 234 -- upvalues: u30 (val), findSurfaceGui (val), isPartOfNotify (val)
        if u30[p1] then
            return u30[p1].EnteredEvent.Event, u30[p1].LeaveEvent.Event, u30[p1].ClickEvent.Event, u30[p1].DownEvent.Event, u30[p1].UpEvent.Event
        end
        p1.Active = false
        local u24 = {UIObj = p1}
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
        p1.Destroying:Connect(function() -- Line: 262 -- upvalues: BindableEvent (val), BindableEvent_2 (val), BindableEvent_3 (val), BindableEvent_4 (val), BindableEvent_5 (val), u30 (upval), p1 (val)
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
        local v1, v2
        v1, v2 = getPointerPosition(p2, p3)
        X = v1
        Y = v2
    end
    if not X or not Y or p1.AbsolutePosition.X >= X or p1.AbsolutePosition.Y >= Y or X >= p1.AbsolutePosition.X + p1.AbsoluteSize.X then
        return false
    end
    if Y < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y then
        return true
    end
    return false
end
local function ParentsVisible(p1) -- Line: 311 -- upvalues: findSurfaceGui (val), u39 (ref)
    local SurfaceGui, visible
    if not p1.SurfaceGui then
        p1.SurfaceGui = findSurfaceGui(p1.UIObj)
    end
    SurfaceGui = p1.SurfaceGui
    function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
        if not u39 then
            local v1
            if p1 ~= SurfaceGui then
                local Visible = false
                if p1.Parent ~= nil then
                    if not (p1:IsA("GuiObject")) then
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
                local Enabled = v2:IsA("ScreenGui")
                if not Enabled then
                    Enabled = v2:IsA("SurfaceGui")
                    if not Enabled then
                        Enabled = v2:IsA("BillboardGui")
                    end
                end
                if Enabled then
                    Enabled = SurfaceGui.Enabled
                end
                v1 = Enabled
            end
            if u39 then
                u39[p1] = v1
            end
            return v1
        elseif u39[p1] ~= nil then
            return u39[p1]
        end
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
    if not (p1.Parent:IsA("GuiObject")) then
        v1 = not p1.Parent:IsA("GuiObject")
        if not v1 then
            v1 = IsInClipping(p1.Parent, p2, p3)
        end
    elseif not p1.Parent.ClipsDescendants then
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
game:GetService("RunService").Heartbeat:connect(function() -- Line: 356 -- upvalues: Mouse (val), u39 (ref), u40 (ref), u30 (val), findSurfaceGui (val), IsInFrame (val), LocalPlayer (val), IsInClipping (val), UISounds (val)
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
                if not u39 then
                    local v1
                    if p1 ~= SurfaceGui then
                        local Visible = false
                        if p1.Parent ~= nil then
                            if not (p1:IsA("GuiObject")) then
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
                        local Enabled = v2:IsA("ScreenGui")
                        if not Enabled then
                            Enabled = v2:IsA("SurfaceGui")
                            if not Enabled then
                                Enabled = v2:IsA("BillboardGui")
                            end
                        end
                        if Enabled then
                            Enabled = SurfaceGui.Enabled
                        end
                        v1 = Enabled
                    end
                    if u39 then
                        u39[p1] = v1
                    end
                    return v1
                elseif u39[p1] ~= nil then
                    return u39[p1]
                end
            end
            if visible(v.UIObj) and IsInFrame(v.UIObj, v, v2) then
                if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u30[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v1 then
                        if IsInClipping(v.UIObj, v, v2) then
                            v1 = k
                        end
                    elseif v1.ZIndex >= k.ZIndex then
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
            v1 = if p1.AbsolutePosition.X < p2 then if p1.AbsolutePosition.Y < p3 then if p2 < p1.AbsolutePosition.X + p1.AbsoluteSize.X then p3 < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y else false else false else false
        end
    end
    return v1
end
local function inputDown(p1, p2, p3) -- Line: 396 -- upvalues: u30 (val), getPointerPosition (val), findSurfaceGui (val), u39 (ref), LocalPlayer (val), IsInClipping (val), u31 (ref), ButtonFeedback (val)
    local Enabled, IsPartOfNotify, IsPartOfNotify_2, Notify, v1, v2, v3, v4, v5
    local v6 = nil
    v4, v1 = p3, p1
    for k, v in pairs(u30) do
        if v4 then
            v5, v2 = getPointerPosition(v, v4)
            v3 = v5
            if v3 then
                v3 = v2
                if v3 then
                    v3 = if k.AbsolutePosition.X < v5 then if k.AbsolutePosition.Y < v2 then if v5 < k.AbsolutePosition.X + k.AbsoluteSize.X then v2 < k.AbsolutePosition.Y + k.AbsoluteSize.Y else false else false else false
                end
            end
            if not v3 then
                v.MouseDownOnObj = false
            elseif v.UIObj.Visible then
                if not v.SurfaceGui then
                    v.SurfaceGui = findSurfaceGui(v.UIObj)
                end
                local SurfaceGui = v.SurfaceGui
                local function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
                    if not u39 then
                        local v1
                        if p1 ~= SurfaceGui then
                            local Visible = false
                            if p1.Parent ~= nil then
                                if not (p1:IsA("GuiObject")) then
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
                            local Enabled = v2:IsA("ScreenGui")
                            if not Enabled then
                                Enabled = v2:IsA("SurfaceGui")
                                if not Enabled then
                                    Enabled = v2:IsA("BillboardGui")
                                end
                            end
                            if Enabled then
                                Enabled = SurfaceGui.Enabled
                            end
                            v1 = Enabled
                        end
                        if u39 then
                            u39[p1] = v1
                        end
                        return v1
                    elseif u39[p1] ~= nil then
                        return u39[p1]
                    end
                end
                if visible(v.UIObj) then
                    if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u30[k].IsPartOfNotify
                    end
                    if IsPartOfNotify then
                        if not v6 then
                            if IsInClipping(v.UIObj, v, v4) then
                                if v6 then
                                    v3 = u30[v6]
                                    v3.MouseDownOnObj = false
                                end
                                v6 = k
                            end
                        elseif v6.ZIndex >= k.ZIndex then
                        end
                    end
                end
            end
        elseif v1 then
            if v1.KeyCode == Enum.KeyCode.ButtonA then
                if not v.MouseIn then
                    v.MouseDownOnObj = false
                elseif v.UIObj.Visible then
                    if not v.SurfaceGui then
                        v.SurfaceGui = findSurfaceGui(v.UIObj)
                    end
                    local SurfaceGui_2 = v.SurfaceGui
                    local function visible_2(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui_2 (val), visible_2 (val)
                        if not u39 then
                            local v1
                            if p1 ~= SurfaceGui_2 then
                                local Visible = false
                                if p1.Parent ~= nil then
                                    if not (p1:IsA("GuiObject")) then
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
                                local Enabled = v2:IsA("ScreenGui")
                                if not Enabled then
                                    Enabled = v2:IsA("SurfaceGui")
                                    if not Enabled then
                                        Enabled = v2:IsA("BillboardGui")
                                    end
                                end
                                if Enabled then
                                    Enabled = SurfaceGui_2.Enabled
                                end
                                v1 = Enabled
                            end
                            if u39 then
                                u39[p1] = v1
                            end
                            return v1
                        elseif u39[p1] ~= nil then
                            return u39[p1]
                        end
                    end
                    if visible_2(v.UIObj) then
                        if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                            IsPartOfNotify_2 = true
                        else
                            IsPartOfNotify_2 = u30[k].IsPartOfNotify
                        end
                        if IsPartOfNotify_2 then
                            if not v6 then
                                if IsInClipping(v.UIObj, v) then
                                    if v6 then
                                        v5 = u30[v6]
                                        v5.MouseDownOnObj = false
                                    end
                                    v6 = k
                                end
                            elseif v6.ZIndex >= k.ZIndex then
                            end
                        end
                    end
                end
            elseif v1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            end
        end
    end
    if v6 then
        Notify = LocalPlayer.PlayerGui:FindFirstChild("Notify")
        local v7 = u30[v6]
        if not Notify then
            if not Notify and not v7.IsPartOfNotify then
                local v8, v9, v10
                v7.MouseDownOnObj = true
                if not v4 then
                    v10, v5 = getPointerPosition(v7)
                    v8 = v10
                    v9 = v5
                else
                    v10, v5 = getPointerPosition(v7, v4)
                    v8 = v10
                    v9 = v5
                    v7.EnteredEvent:Fire()
                end
                if v8 and v9 and not u31.Visible then
                    local SettingsGui = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                    Enabled = SettingsGui
                    if Enabled then
                        Enabled = SettingsGui.Enabled
                    end
                    if not Enabled then
                        v10 = Vector2.new(v8, v9)
                        if v4 then
                            v10 = ButtonFeedback.PointFromMouseEvent(v4.X, v4.Y) or v10
                        end
                        ButtonFeedback.Ripple(v7.UIObj, v10)
                        v7.DownEvent:Fire(v8, v9)
                    end
                end
            end
        elseif v7.IsPartOfNotify then
        end
    end
end
local function inputEnded(p1, p2) -- Line: 445 -- upvalues: u30 (val), getPointerPosition (val), LocalPlayer (val), findSurfaceGui (val), u39 (ref), u31 (ref)
    local IsPartOfNotify, IsPartOfNotify_2, UIObj, v1, v2, v3, v4, v5
    local v6 = nil
    v2, v1 = p2, p1
    for k, v in pairs(u30) do
        if v2 then
            v4, v5 = getPointerPosition(v, v2)
            v3 = v4
            if v3 then
                v3 = v5
                if v3 then
                    v3 = if k.AbsolutePosition.X < v4 then if k.AbsolutePosition.Y < v5 then if v4 < k.AbsolutePosition.X + k.AbsoluteSize.X then v5 < k.AbsolutePosition.Y + k.AbsoluteSize.Y else false else false else false
                end
            end
            if v3 and v.UIObj.Visible and v.MouseDownOnObj == true then
                if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u30[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v6 then
                        v6 = k
                    elseif v6.ZIndex >= k.ZIndex then
                    end
                end
            end
        elseif v1 then
            if v1.KeyCode == Enum.KeyCode.ButtonA then
                if k.Visible == true and k.Visible and v.MouseDownOnObj == true then
                    if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                        IsPartOfNotify_2 = true
                    else
                        IsPartOfNotify_2 = u30[k].IsPartOfNotify
                    end
                    if IsPartOfNotify_2 then
                        if not v6 then
                            v6 = k
                        elseif v6.ZIndex >= k.ZIndex then
                        end
                    end
                end
            elseif v1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            end
        end
    end
    if not v6 then
        return
    else
        local v7, v8, v9, v10
        local v11 = u30[v6]
        if not v2 then
            v9, v10 = getPointerPosition(v11)
            v7 = v9
            v8 = v10
        else
            v9, v10 = getPointerPosition(v11, v2)
            v7 = v9
            v8 = v10
        end
        if not v7 then
            return
        else
            local Enabled, SurfaceGui
            if not v8 then
                return
            end
            if not v2 then
                local visible_2
                if not v11.MouseIn then
                    if not v11.MouseIn then
                        v11.UpEvent:Fire(v7, v8)
                    end
                    return
                end
                if not v11.SurfaceGui then
                    v11.SurfaceGui = findSurfaceGui(v11.UIObj)
                end
                local SurfaceGui_2 = v11.SurfaceGui
                function visible_2(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui_2 (val), visible_2 (val)
                    if not u39 then
                        local v1
                        if p1 ~= SurfaceGui_2 then
                            local Visible = false
                            if p1.Parent ~= nil then
                                if not (p1:IsA("GuiObject")) then
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
                            local Enabled = v2:IsA("ScreenGui")
                            if not Enabled then
                                Enabled = v2:IsA("SurfaceGui")
                                if not Enabled then
                                    Enabled = v2:IsA("BillboardGui")
                                end
                            end
                            if Enabled then
                                Enabled = SurfaceGui_2.Enabled
                            end
                            v1 = Enabled
                        end
                        if u39 then
                            u39[p1] = v1
                        end
                        return v1
                    elseif u39[p1] ~= nil then
                        return u39[p1]
                    end
                end
                if not (visible_2(v11.UIObj)) or u31.Visible then
                    if not v11.MouseIn then
                        v11.UpEvent:Fire(v7, v8)
                    end
                    return
                end
                local SettingsGui_2 = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                local Enabled_2 = SettingsGui_2
                if Enabled_2 then
                    Enabled_2 = SettingsGui_2.Enabled
                end
                if not Enabled_2 then
                    v11.ClickEvent:Fire(v7, v8)
                    return
                end
                if not v11.MouseIn then
                    v11.UpEvent:Fire(v7, v8)
                end
                return
            else
                local visible
                if not v11.SurfaceGui then
                    v11.SurfaceGui = findSurfaceGui(v11.UIObj)
                end
                SurfaceGui = v11.SurfaceGui
                function visible(p1) -- Line: 313 -- upvalues: u39 (upval), SurfaceGui (val), visible (val)
                    if not u39 then
                        local v1
                        if p1 ~= SurfaceGui then
                            local Visible = false
                            if p1.Parent ~= nil then
                                if not (p1:IsA("GuiObject")) then
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
                            local Enabled = v2:IsA("ScreenGui")
                            if not Enabled then
                                Enabled = v2:IsA("SurfaceGui")
                                if not Enabled then
                                    Enabled = v2:IsA("BillboardGui")
                                end
                            end
                            if Enabled then
                                Enabled = SurfaceGui.Enabled
                            end
                            v1 = Enabled
                        end
                        if u39 then
                            u39[p1] = v1
                        end
                        return v1
                    elseif u39[p1] ~= nil then
                        return u39[p1]
                    end
                end
                if visible(v11.UIObj) and not u31.Visible then
                    local SettingsGui = LocalPlayer.PlayerGui:FindFirstChild("SettingsGui")
                    Enabled = SettingsGui
                    if Enabled then
                        Enabled = SettingsGui.Enabled
                    end
                    if not Enabled then
                        UIObj = v11.UIObj
                        v4 = v7
                        v5 = v8
                        v9 = v4
                        if v9 then
                            v9 = v5
                            if v9 then
                                v9 = if UIObj.AbsolutePosition.X < v4 then if UIObj.AbsolutePosition.Y < v5 then if v4 < UIObj.AbsolutePosition.X + UIObj.AbsoluteSize.X then v5 < UIObj.AbsolutePosition.Y + UIObj.AbsoluteSize.Y else false else false else false
                            end
                        end
                        if v9 then
                            v11.ClickEvent:Fire(v7, v8)
                            return
                        end
                        v11.UpEvent:Fire(v7, v8)
                        return
                    end
                end
            end
        end
    end
end
game:GetService("UserInputService").InputBegan:connect(function(p1, p2) -- Line: 489 -- upvalues: inputDown (val)
    if p1.KeyCode == Enum.KeyCode.ButtonA then
        inputDown(p1, p2)
    elseif p1.UserInputType == Enum.UserInputType.MouseButton1 then
        inputDown(p1, p2)
    end
end)
if game:GetService("UserInputService").TouchEnabled then
    game:GetService("UserInputService").TouchStarted:Connect(function(p1, p2) -- Line: 496 -- upvalues: inputDown (val)
        inputDown(nil, p2, p1.Position)
    end)
    game:GetService("UserInputService").TouchEnded:Connect(function(p1, p2) -- Line: 499 -- upvalues: inputEnded (val)
        inputEnded(nil, p1.Position)
    end)
end
game:GetService("UserInputService").InputEnded:connect(function(p1) -- Line: 504 -- upvalues: inputEnded (val)
    inputEnded(p1)
end)
game:GetService("UserInputService").InputChanged:connect(function(p1, p2) -- Line: 508 -- upvalues: u30 (val), IsInFrame (val), findSurfaceGui (val), u39 (ref), LocalPlayer (val), IsInClipping (val)
    if p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.Thumbstick1 then
        local IsPartOfNotify
        Vector2.new(p1.Position.X, p1.Position.Y)
        local v1 = nil
        for k, v in pairs(u30) do
            if not (IsInFrame(v.UIObj, v)) then
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
                    if not u39 then
                        local v1
                        if p1 ~= SurfaceGui then
                            local Visible = false
                            if p1.Parent ~= nil then
                                if not (p1:IsA("GuiObject")) then
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
                            local Enabled = v2:IsA("ScreenGui")
                            if not Enabled then
                                Enabled = v2:IsA("SurfaceGui")
                                if not Enabled then
                                    Enabled = v2:IsA("BillboardGui")
                                end
                            end
                            if Enabled then
                                Enabled = SurfaceGui.Enabled
                            end
                            v1 = Enabled
                        end
                        if u39 then
                            u39[p1] = v1
                        end
                        return v1
                    elseif u39[p1] ~= nil then
                        return u39[p1]
                    end
                end
                if visible(v.UIObj) then
                    if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u30[k].IsPartOfNotify
                    end
                    if IsPartOfNotify then
                        if not v1 then
                            if IsInClipping(v.UIObj, v) then
                                v1 = k
                            end
                        elseif v1.ZIndex >= k.ZIndex then
                        end
                    end
                end
            end
        end
        if v1 and not (u30[v1].MouseIn) then
            local v2 = u30[v1]
            v2.MouseIn = true
            u30[v1].EnteredEvent:Fire()
        end
    end
end)
return v1