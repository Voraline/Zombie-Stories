local IsInClipping, LocalPlayer
while true do
    wait()
    if game.Players.LocalPlayer then
        break
    end
end
LocalPlayer = game.Players.LocalPlayer
local u8 = {}
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local SettingsGui = PlayerGui:WaitForChild("SettingsGui")
local u17 = {Visible = false}
task.defer(function() -- Line: 8 -- upvalues: LocalPlayer (val), u17 (ref)
    local Panel = LocalPlayer.PlayerGui:WaitForChild("Panel", 30)
    if Panel then
        local Elements = Panel:WaitForChild("Elements")
        u17 = Elements:WaitForChild("Commander")
    end
end)
local function findSurfaceGui(p1) -- Line: 15
    local Parent = p1
    while true do
        if not Parent.Parent then
            if not Parent.Parent then
                return Parent
            else
                Parent = Parent.Parent
            end
        elseif Parent.Parent:IsA("ScreenGui") then
            return Parent.Parent
        end
    end
end
local function isPartOfNotify(p1) -- Line: 30
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
local v1 = {
    MouseEnterLeaveEvent = function(p1) -- Line: 48 -- upvalues: u8 (val), findSurfaceGui (val), isPartOfNotify (val)
        if u8[p1] then
            return u8[p1].EnteredEvent.Event, u8[p1].LeaveEvent.Event, u8[p1].ClickEvent.Event, u8[p1].DownEvent.Event, u8[p1].UpEvent.Event
        end
        p1.Active = false
        local v1 = {}
        local u25 = {}
        v1.UIObj = p1
        local BindableEvent = Instance.new("BindableEvent")
        local BindableEvent_2 = Instance.new("BindableEvent")
        local BindableEvent_3 = Instance.new("BindableEvent")
        local BindableEvent_4 = Instance.new("BindableEvent")
        local BindableEvent_5 = Instance.new("BindableEvent")
        v1.EnteredEvent = BindableEvent
        v1.MouseIn = false
        v1.MouseDownOnObj = false
        v1.LeaveEvent = BindableEvent_2
        v1.ClickEvent = BindableEvent_3
        v1.DownEvent = BindableEvent_4
        v1.UpEvent = BindableEvent_5
        v1.SurfaceGui = findSurfaceGui(p1)
        v1.IsPartOfNotify = isPartOfNotify(p1)
        u8[p1] = v1
        p1.Destroying:Connect(function() -- Line: 73 -- upvalues: p1 (val), BindableEvent (val), BindableEvent_2 (val), BindableEvent_3 (val), BindableEvent_4 (val), BindableEvent_5 (val), u8 (upval), u25 (ref)
            print("removing", p1)
            BindableEvent:Destroy()
            BindableEvent_2:Destroy()
            BindableEvent_3:Destroy()
            BindableEvent_4:Destroy()
            BindableEvent_5:Destroy()
            if p1 and u8[p1] and u8[p1].SelectRS then
                u8[p1].SelectRS:Disconnect()
            end
            u8[p1] = nil
            u25 = nil
        end)
        local v2 = u8[p1]
        v2.SelectRS = game:GetService("RunService").RenderStepped:connect(function() -- Line: 107 -- upvalues: u25 (ref)
            local v1
            for k, v in pairs(u25) do
                v1 = v[1] + 0.1
                k.BackgroundColor3 = k.BackgroundColor3:lerp(v[2], v1)
                if 1 <= v1 then
                    u25[k] = nil
                end
            end
        end)
        return BindableEvent.Event, BindableEvent_2.Event, BindableEvent_3.Event, BindableEvent_4.Event, BindableEvent_5.Event, BindableEvent_3
    end,
}
local Mouse = LocalPlayer:GetMouse()
local function IsInFrame(p1) -- Line: 124 -- upvalues: Mouse (val)
    if p1.Visible ~= true then
        return
    end
    local X = Mouse.X
    local Y = Mouse.Y
    if p1.AbsolutePosition.X >= X or p1.AbsolutePosition.Y >= Y or X >= p1.AbsolutePosition.X + p1.AbsoluteSize.X then
        return false
    end
    if Y < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y then
        return true
    end
    return false
end
local function ParentsVisible(p1) -- Line: 136
    local Check
    function Check(a1) -- Line: 159 -- upvalues: p1 (val), Check (val)
        local SurfaceGui = p1.SurfaceGui
        if not a1.Parent then
            return false
        end
        if SurfaceGui:IsA("ScreenGui") then
            if a1.Parent ~= SurfaceGui then
                if a1.Parent ~= SurfaceGui or a1:IsA("GuiObject") then
                    if a1:IsA("GuiObject") then
                        if a1.Visible == false then
                            return false
                        end
                        if a1.Visible == true then
                            return Check(a1.Parent)
                        end
                        return
                    end
                    return Check(a1.Parent)
                end
                if SurfaceGui.Enabled == true then
                    return true
                end
                if not (a1:IsA("GuiObject")) then
                    return Check(a1.Parent)
                end
                if a1.Visible == false then
                    return false
                end
                if a1.Visible == true then
                    return Check(a1.Parent)
                end
                return
            elseif a1:IsA("GuiObject") and a1.Visible == true and SurfaceGui.Enabled == true then
                return true
            end
        elseif SurfaceGui:IsA("GuiObject") then
            return SurfaceGui.Visible
        end
    end
    return (Check(p1.UIObj))
end
local function checkIfNotifyAndIsApartOf(p1, p2) -- Line: 184 -- upvalues: LocalPlayer (val), u8 (val)
    if LocalPlayer.PlayerGui:FindFirstChild("Notify") then
        return u8[p2].IsPartOfNotify
    end
    return true
end
function IsInClipping(p1) -- Line: 205 -- upvalues: IsInFrame (val), IsInClipping (val)
    local v1
    if not (p1.Parent:IsA("GuiObject")) then
        v1 = not p1.Parent:IsA("GuiObject")
        if not v1 then
            v1 = IsInClipping(p1.Parent)
        end
    elseif not p1.Parent.ClipsDescendants then
        v1 = not p1.Parent:IsA("GuiObject")
        if not v1 then
            v1 = IsInClipping(p1.Parent)
        end
    else
        v1 = IsInFrame(p1.Parent)
        if v1 then
            v1 = not p1.Parent:IsA("GuiObject")
            if not v1 then
                v1 = IsInClipping(p1.Parent)
            end
        end
    end
    return v1
end
game:GetService("RunService").Heartbeat:connect(function() -- Line: 209 -- upvalues: u8 (val), IsInFrame (val), LocalPlayer (val), IsInClipping (val)
    local IsPartOfNotify
    local v1 = nil
    for k, v in pairs(u8) do
        if not (IsInFrame(v.UIObj)) then
            if v.MouseIn then
                v.MouseIn = false
                v.LeaveEvent:Fire()
            end
        elseif k.Visible then
            local function Check(p1) -- Line: 159 -- upvalues: v (val), Check (val)
                local SurfaceGui = v.SurfaceGui
                if not p1.Parent then
                    return false
                end
                if SurfaceGui:IsA("ScreenGui") then
                    if p1.Parent ~= SurfaceGui then
                        if p1.Parent ~= SurfaceGui or p1:IsA("GuiObject") then
                            if p1:IsA("GuiObject") then
                                if p1.Visible == false then
                                    return false
                                end
                                if p1.Visible == true then
                                    return Check(p1.Parent)
                                end
                                return
                            end
                            return Check(p1.Parent)
                        end
                        if SurfaceGui.Enabled == true then
                            return true
                        end
                        if not (p1:IsA("GuiObject")) then
                            return Check(p1.Parent)
                        end
                        if p1.Visible == false then
                            return false
                        end
                        if p1.Visible == true then
                            return Check(p1.Parent)
                        end
                        return
                    elseif p1:IsA("GuiObject") and p1.Visible == true and SurfaceGui.Enabled == true then
                        return true
                    end
                elseif SurfaceGui:IsA("GuiObject") then
                    return SurfaceGui.Visible
                end
            end
            if Check(v.UIObj) then
                if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u8[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v1 then
                        if IsInClipping(v.UIObj) then
                            v1 = k
                        end
                    elseif v1.ZIndex >= k.ZIndex then
                    end
                end
            end
        end
    end
    if v1 and not (u8[v1].MouseIn) then
        local v2 = u8[v1]
        v2.MouseIn = true
        u8[v1].EnteredEvent:Fire()
    end
end)
local function pointInObject(p1, p2, p3) -- Line: 227
    local v1 = if p1.AbsolutePosition.X < p2 then if p1.AbsolutePosition.Y < p3 then if p2 < p1.AbsolutePosition.X + p1.AbsoluteSize.X then p3 < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y else false else false else false
    return v1
end
local function inputDown(p1, p2, p3) -- Line: 232 -- upvalues: u8 (val), LocalPlayer (val), IsInClipping (val), Mouse (val), SettingsGui (val), u17 (ref)
    local IsPartOfNotify, IsPartOfNotify_2, Notify, X, X_2, Y, Y_2, v1, v2, v3, v4
    local v5 = nil
    v3, v1 = p3, p1
    for k, v in pairs(u8) do
        if v3 then
            X_2 = v3.X
            Y_2 = v3.Y
            v2 = if k.AbsolutePosition.X < X_2 then if k.AbsolutePosition.Y < Y_2 then if X_2 < k.AbsolutePosition.X + k.AbsoluteSize.X then Y_2 < k.AbsolutePosition.Y + k.AbsoluteSize.Y else false else false else false
            if not v2 then
                v.MouseDownOnObj = false
            elseif v.UIObj.Visible then
                local function Check(p1) -- Line: 159 -- upvalues: v (val), Check (val)
                    local SurfaceGui = v.SurfaceGui
                    if not p1.Parent then
                        return false
                    end
                    if SurfaceGui:IsA("ScreenGui") then
                        if p1.Parent ~= SurfaceGui then
                            if p1.Parent ~= SurfaceGui or p1:IsA("GuiObject") then
                                if p1:IsA("GuiObject") then
                                    if p1.Visible == false then
                                        return false
                                    end
                                    if p1.Visible == true then
                                        return Check(p1.Parent)
                                    end
                                    return
                                end
                                return Check(p1.Parent)
                            end
                            if SurfaceGui.Enabled == true then
                                return true
                            end
                            if not (p1:IsA("GuiObject")) then
                                return Check(p1.Parent)
                            end
                            if p1.Visible == false then
                                return false
                            end
                            if p1.Visible == true then
                                return Check(p1.Parent)
                            end
                            return
                        elseif p1:IsA("GuiObject") and p1.Visible == true and SurfaceGui.Enabled == true then
                            return true
                        end
                    elseif SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                end
                if Check(v.UIObj) then
                    if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u8[k].IsPartOfNotify
                    end
                    if IsPartOfNotify then
                        if not v5 then
                            if IsInClipping(v.UIObj) then
                                if v5 then
                                    v2 = u8[v5]
                                    v2.MouseDownOnObj = false
                                end
                                v5 = k
                            end
                        elseif v5.ZIndex >= k.ZIndex then
                        end
                    end
                end
            end
        elseif v1.KeyCode == Enum.KeyCode.ButtonA then
            if not v.MouseIn then
                v.MouseDownOnObj = false
            elseif v.UIObj.Visible then
                local function Check_2(p1) -- Line: 159 -- upvalues: v (val), Check_2 (val)
                    local SurfaceGui = v.SurfaceGui
                    if not p1.Parent then
                        return false
                    end
                    if SurfaceGui:IsA("ScreenGui") then
                        if p1.Parent ~= SurfaceGui then
                            if p1.Parent ~= SurfaceGui or p1:IsA("GuiObject") then
                                if p1:IsA("GuiObject") then
                                    if p1.Visible == false then
                                        return false
                                    end
                                    if p1.Visible == true then
                                        return Check_2(p1.Parent)
                                    end
                                    return
                                end
                                return Check_2(p1.Parent)
                            end
                            if SurfaceGui.Enabled == true then
                                return true
                            end
                            if not (p1:IsA("GuiObject")) then
                                return Check_2(p1.Parent)
                            end
                            if p1.Visible == false then
                                return false
                            end
                            if p1.Visible == true then
                                return Check_2(p1.Parent)
                            end
                            return
                        elseif p1:IsA("GuiObject") and p1.Visible == true and SurfaceGui.Enabled == true then
                            return true
                        end
                    elseif SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                end
                if Check_2(v.UIObj) then
                    if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                        IsPartOfNotify_2 = true
                    else
                        IsPartOfNotify_2 = u8[k].IsPartOfNotify
                    end
                    if IsPartOfNotify_2 then
                        if not v5 then
                            if IsInClipping(v.UIObj) then
                                if v5 then
                                    v4 = u8[v5]
                                    v4.MouseDownOnObj = false
                                end
                                v5 = k
                            end
                        elseif v5.ZIndex >= k.ZIndex then
                        end
                    end
                end
            end
        elseif v1.UserInputType ~= Enum.UserInputType.MouseButton1 then
        end
    end
    if v5 then
        Notify = LocalPlayer.PlayerGui:FindFirstChild("Notify")
        local v6 = u8[v5]
        if not Notify then
            if not Notify and not v6.IsPartOfNotify then
                v6.MouseDownOnObj = true
                if not v3 then
                    X = Mouse.X
                    Y = Mouse.Y
                else
                    X = v3.X
                    Y = v3.Y
                    v6.EnteredEvent:Fire()
                end
                if not SettingsGui.Enabled and not u17.Visible then
                    v6.DownEvent:Fire(X, Y)
                end
            end
        elseif v6.IsPartOfNotify then
        end
    end
end
local function inputEnded(p1, p2) -- Line: 277 -- upvalues: u8 (val), LocalPlayer (val), Mouse (val), SettingsGui (val), u17 (ref)
    local IsPartOfNotify, IsPartOfNotify_2, UIObj, X, X_2, Y, Y_2, v1, v2, v3
    local v4 = nil
    v2, v1 = p2, p1
    for k, v in pairs(u8) do
        if v2 then
            X_2 = v2.X
            Y_2 = v2.Y
            v3 = if k.AbsolutePosition.X < X_2 then if k.AbsolutePosition.Y < Y_2 then if X_2 < k.AbsolutePosition.X + k.AbsoluteSize.X then Y_2 < k.AbsolutePosition.Y + k.AbsoluteSize.Y else false else false else false
            if v3 and v.UIObj.Visible and v.MouseDownOnObj == true then
                if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u8[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v4 then
                        v4 = k
                    elseif v4.ZIndex >= k.ZIndex then
                    end
                end
            end
        elseif v1.KeyCode == Enum.KeyCode.ButtonA then
            if k.Visible == true and k.Visible and v.MouseDownOnObj == true then
                if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                    IsPartOfNotify_2 = true
                else
                    IsPartOfNotify_2 = u8[k].IsPartOfNotify
                end
                if IsPartOfNotify_2 then
                    if not v4 then
                        v4 = k
                    elseif v4.ZIndex >= k.ZIndex then
                    end
                end
            end
        elseif v1.UserInputType ~= Enum.UserInputType.MouseButton1 then
        end
    end
    if not v4 then
        return
    else
        local u17 = u8[v4]
        if not v2 then
            X = Mouse.X
            Y = Mouse.Y
        else
            X = v2.X
            Y = v2.Y
        end
        if not v2 then
            local Check_2
            if not u17.MouseIn then
                if not u17.MouseIn then
                    u17.UpEvent:Fire(X, Y)
                end
                return
            end
            function Check_2(p1) -- Line: 159 -- upvalues: u17 (val), Check_2 (val)
                local SurfaceGui = u17.SurfaceGui
                if not p1.Parent then
                    return false
                end
                if SurfaceGui:IsA("ScreenGui") then
                    if p1.Parent ~= SurfaceGui then
                        if p1.Parent ~= SurfaceGui or p1:IsA("GuiObject") then
                            if p1:IsA("GuiObject") then
                                if p1.Visible == false then
                                    return false
                                end
                                if p1.Visible == true then
                                    return Check_2(p1.Parent)
                                end
                                return
                            end
                            return Check_2(p1.Parent)
                        end
                        if SurfaceGui.Enabled == true then
                            return true
                        end
                        if not (p1:IsA("GuiObject")) then
                            return Check_2(p1.Parent)
                        end
                        if p1.Visible == false then
                            return false
                        end
                        if p1.Visible == true then
                            return Check_2(p1.Parent)
                        end
                        return
                    elseif p1:IsA("GuiObject") and p1.Visible == true and SurfaceGui.Enabled == true then
                        return true
                    end
                elseif SurfaceGui:IsA("GuiObject") then
                    return SurfaceGui.Visible
                end
            end
            if not (Check_2(u17.UIObj)) or SettingsGui.Enabled then
                if not u17.MouseIn then
                    u17.UpEvent:Fire(X, Y)
                end
                return
            end
            if not u17.Visible then
                u17.ClickEvent:Fire(X, Y)
                return
            end
            if not u17.MouseIn then
                u17.UpEvent:Fire(X, Y)
            end
            return
        else
            local Check
            function Check(p1) -- Line: 159 -- upvalues: u17 (val), Check (val)
                local SurfaceGui = u17.SurfaceGui
                if not p1.Parent then
                    return false
                end
                if SurfaceGui:IsA("ScreenGui") then
                    if p1.Parent ~= SurfaceGui then
                        if p1.Parent ~= SurfaceGui or p1:IsA("GuiObject") then
                            if p1:IsA("GuiObject") then
                                if p1.Visible == false then
                                    return false
                                end
                                if p1.Visible == true then
                                    return Check(p1.Parent)
                                end
                                return
                            end
                            return Check(p1.Parent)
                        end
                        if SurfaceGui.Enabled == true then
                            return true
                        end
                        if not (p1:IsA("GuiObject")) then
                            return Check(p1.Parent)
                        end
                        if p1.Visible == false then
                            return false
                        end
                        if p1.Visible == true then
                            return Check(p1.Parent)
                        end
                        return
                    elseif p1:IsA("GuiObject") and p1.Visible == true and SurfaceGui.Enabled == true then
                        return true
                    end
                elseif SurfaceGui:IsA("GuiObject") then
                    return SurfaceGui.Visible
                end
            end
            if Check(u17.UIObj) and not SettingsGui.Enabled and not u17.Visible then
                UIObj = u17.UIObj
                local v5 = X
                local v6 = Y
                local v7 = if UIObj.AbsolutePosition.X < v5 then if UIObj.AbsolutePosition.Y < v6 then if v5 < UIObj.AbsolutePosition.X + UIObj.AbsoluteSize.X then v6 < UIObj.AbsolutePosition.Y + UIObj.AbsoluteSize.Y else false else false else false
                if v7 then
                    u17.ClickEvent:Fire(X, Y)
                    return
                end
                u17.UpEvent:Fire(X, Y)
                return
            end
        end
    end
end
game:GetService("UserInputService").InputBegan:connect(function(p1, p2) -- Line: 321 -- upvalues: inputDown (val)
    if p1.KeyCode == Enum.KeyCode.ButtonA then
        inputDown(p1, p2)
    elseif p1.UserInputType == Enum.UserInputType.MouseButton1 then
        inputDown(p1, p2)
    end
end)
if game:GetService("UserInputService").TouchEnabled then
    game:GetService("UserInputService").TouchStarted:Connect(function(p1, p2) -- Line: 328 -- upvalues: inputDown (val)
        inputDown(nil, p2, p1.Position)
    end)
    game:GetService("UserInputService").TouchEnded:Connect(function(p1, p2) -- Line: 331 -- upvalues: inputEnded (val)
        inputEnded(nil, p1.Position)
    end)
end
game:GetService("UserInputService").InputEnded:connect(function(p1) -- Line: 336 -- upvalues: inputEnded (val)
    inputEnded(p1)
end)
game:GetService("UserInputService").InputChanged:connect(function(p1, p2) -- Line: 340 -- upvalues: u8 (val), IsInFrame (val), LocalPlayer (val), IsInClipping (val)
    if p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.Thumbstick1 then
        local IsPartOfNotify
        Vector2.new(p1.Position.X, p1.Position.Y)
        local v1 = nil
        for k, v in pairs(u8) do
            if not (IsInFrame(v.UIObj)) then
                if v.MouseIn then
                    v.MouseIn = false
                    v.LeaveEvent:Fire()
                end
            elseif k.Visible then
                local function Check(p1) -- Line: 159 -- upvalues: v (val), Check (val)
                    local SurfaceGui = v.SurfaceGui
                    if not p1.Parent then
                        return false
                    end
                    if SurfaceGui:IsA("ScreenGui") then
                        if p1.Parent ~= SurfaceGui then
                            if p1.Parent ~= SurfaceGui or p1:IsA("GuiObject") then
                                if p1:IsA("GuiObject") then
                                    if p1.Visible == false then
                                        return false
                                    end
                                    if p1.Visible == true then
                                        return Check(p1.Parent)
                                    end
                                    return
                                end
                                return Check(p1.Parent)
                            end
                            if SurfaceGui.Enabled == true then
                                return true
                            end
                            if not (p1:IsA("GuiObject")) then
                                return Check(p1.Parent)
                            end
                            if p1.Visible == false then
                                return false
                            end
                            if p1.Visible == true then
                                return Check(p1.Parent)
                            end
                            return
                        elseif p1:IsA("GuiObject") and p1.Visible == true and SurfaceGui.Enabled == true then
                            return true
                        end
                    elseif SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                end
                if Check(v.UIObj) then
                    if not (LocalPlayer.PlayerGui:FindFirstChild("Notify")) then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u8[k].IsPartOfNotify
                    end
                    if IsPartOfNotify then
                        if not v1 then
                            if IsInClipping(v.UIObj) then
                                v1 = k
                            end
                        elseif v1.ZIndex >= k.ZIndex then
                        end
                    end
                end
            end
        end
        if v1 and not (u8[v1].MouseIn) then
            local v2 = u8[v1]
            v2.MouseIn = true
            u8[v1].EnteredEvent:Fire()
        end
    end
end)
return v1