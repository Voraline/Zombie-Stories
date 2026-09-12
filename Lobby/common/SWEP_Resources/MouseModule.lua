local IsInClipping
repeat
    wait()
until game.Players.LocalPlayer
local LocalPlayer = game.Players.LocalPlayer
local u8 = {}
local SettingsGui = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("SettingsGui")
local u17 = {Visible = false}
task.defer(function() -- Line: 8 -- upvalues: LocalPlayer (val), u17 (ref)
    local Panel = LocalPlayer.PlayerGui:WaitForChild("Panel", 30)
    if Panel then
        u17 = (Panel:WaitForChild("Elements")):WaitForChild("Commander")
    end
end)

local function findSurfaceGui(p1) -- Line: 15
    local Parent = p1
    while true do
        if Parent.Parent then
            if Parent.Parent:IsA("ScreenGui") then
                return Parent.Parent
            end
            if not Parent.Parent then
                return Parent
            else
                Parent = Parent.Parent
            end
        elseif not Parent.Parent then
            return Parent
        else
            Parent = Parent.Parent
        end
    end
end

local function isPartOfNotify(p1) -- Line: 30
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
        p1.Destroying:Connect(function() -- Line: 73
            -- upvalues: p1 (val), BindableEvent (val), BindableEvent_2 (val), BindableEvent_3 (val)
            -- upvalues: BindableEvent_4 (val), BindableEvent_5 (val), u8 (upval), u25 (ref)
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
        v2.SelectRS = (game:GetService("RunService")).RenderStepped:connect(function() -- Line: 107 -- upvalues: u25 (ref)
            local v1, v2
            for k, v in pairs(u25) do
                v1 = v[1]
                v2 = v[2]
                v1 = v1 + 0.1
                k.BackgroundColor3 = k.BackgroundColor3:lerp(v2, v1)
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
    if p1.AbsolutePosition.X < X
        and p1.AbsolutePosition.Y < Y
        and X < p1.AbsolutePosition.X + p1.AbsoluteSize.X
        and Y < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y then
        return true
    end
    return false
end

local function ParentsVisible(p1) -- Line: 136
    local Check

    function Check(p1_2) -- Line: 159 -- upvalues: p1 (val), Check (val)
        local SurfaceGui = p1.SurfaceGui
        if not p1_2.Parent then
            return false
        end
        if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
            return SurfaceGui.Visible
        end
        if p1_2.Parent == SurfaceGui
            and p1_2:IsA("GuiObject")
            and p1_2.Visible == true
            and SurfaceGui.Enabled == true then
            return true
        end
        if p1_2.Parent == SurfaceGui and not p1_2:IsA("GuiObject") and SurfaceGui.Enabled == true then
            return true
        end
        if not p1_2:IsA("GuiObject") then
            return Check(p1_2.Parent)
        end
        if p1_2.Visible == false then
            return false
        end
        if p1_2.Visible == true then
            return Check(p1_2.Parent)
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
    if not p1.Parent:IsA("GuiObject") or not p1.Parent.ClipsDescendants then
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

;(game:GetService("RunService")).Heartbeat:connect(function() -- Line: 209 -- upvalues: u8 (val), IsInFrame (val), LocalPlayer (val), IsInClipping (val)
    local IsPartOfNotify
    local v1 = nil
    for k, v in pairs(u8) do
        if not IsInFrame(v.UIObj) then
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
                if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                    return SurfaceGui.Visible
                end
                if p1.Parent == SurfaceGui
                    and p1:IsA("GuiObject")
                    and p1.Visible == true
                    and SurfaceGui.Enabled == true then
                    return true
                end
                if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                    return true
                end
                if not p1:IsA("GuiObject") then
                    return Check(p1.Parent)
                end
                if p1.Visible == false then
                    return false
                end
                if p1.Visible == true then
                    return Check(p1.Parent)
                end
            end

            if Check(v.UIObj) then
                if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u8[k].IsPartOfNotify
                end
                if not IsPartOfNotify then
                    if v.MouseIn then
                        v.MouseIn = false
                        v.LeaveEvent:Fire()
                    end
                elseif not v1 then
                    if IsInClipping(v.UIObj) then
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
                elseif IsInClipping(v.UIObj) then
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
    if v1 and not u8[v1].MouseIn then
        local v2 = u8[v1]
        v2.MouseIn = true
        u8[v1].EnteredEvent:Fire()
    end
end)

local function pointInObject(p1, p2, p3) -- Line: 227
    local v1 = false
    if p1.AbsolutePosition.X < p2 then
        v1 = false
        if p1.AbsolutePosition.Y < p3 then
            v1 = false
            if p2 < p1.AbsolutePosition.X + p1.AbsoluteSize.X then
                v1 = p3 < p1.AbsolutePosition.Y + p1.AbsoluteSize.Y
            end
        end
    end
    return v1
end

local function inputDown(p1, p2, p3) -- Line: 232
    -- upvalues: u8 (val), LocalPlayer (val), IsInClipping (val), Mouse (val), SettingsGui (val), u17 (ref)
    local IsPartOfNotify, IsPartOfNotify_2, X_2, Y_2, v1, v2
    local v3 = nil
    local v4, v5 = p3, p1
    for k, v in pairs(u8) do
        if v4 then
            X_2 = v4.X
            Y_2 = v4.Y
            v1 = false
            if k.AbsolutePosition.X < X_2 then
                v1 = false
                if k.AbsolutePosition.Y < Y_2 then
                    v1 = false
                    if X_2 < k.AbsolutePosition.X + k.AbsoluteSize.X then
                        v1 = Y_2 < k.AbsolutePosition.Y + k.AbsoluteSize.Y
                    end
                end
            end
            if not v1 or not v.UIObj.Visible then
                v.MouseDownOnObj = false
            else
                local function Check(p1) -- Line: 159 -- upvalues: v (val), Check (val)
                    local SurfaceGui = v.SurfaceGui
                    if not p1.Parent then
                        return false
                    end
                    if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                    if p1.Parent == SurfaceGui
                        and p1:IsA("GuiObject")
                        and p1.Visible == true
                        and SurfaceGui.Enabled == true then
                        return true
                    end
                    if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                        return true
                    end
                    if not p1:IsA("GuiObject") then
                        return Check(p1.Parent)
                    end
                    if p1.Visible == false then
                        return false
                    end
                    if p1.Visible == true then
                        return Check(p1.Parent)
                    end
                end

                if not Check(v.UIObj) then
                    v.MouseDownOnObj = false
                else
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u8[k].IsPartOfNotify
                    end
                    if not IsPartOfNotify then
                        v.MouseDownOnObj = false
                    elseif not v3 then
                        if not IsInClipping(v.UIObj) then
                            v.MouseDownOnObj = false
                        else
                            if v3 then
                                v1 = u8[v3]
                                v1.MouseDownOnObj = false
                            end
                            v3 = k
                        end
                    elseif not (v3.ZIndex < k.ZIndex) or not IsInClipping(v.UIObj) then
                        v.MouseDownOnObj = false
                    else
                        if v3 then
                            v1 = u8[v3]
                            v1.MouseDownOnObj = false
                        end
                        v3 = k
                    end
                end
            end
        elseif v5.KeyCode == Enum.KeyCode.ButtonA then
            if not v.MouseIn or not v.UIObj.Visible then
                v.MouseDownOnObj = false
            else
                local function Check_2(p1) -- Line: 159 -- upvalues: v (val), Check_2 (val)
                    local SurfaceGui = v.SurfaceGui
                    if not p1.Parent then
                        return false
                    end
                    if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                    if p1.Parent == SurfaceGui
                        and p1:IsA("GuiObject")
                        and p1.Visible == true
                        and SurfaceGui.Enabled == true then
                        return true
                    end
                    if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                        return true
                    end
                    if not p1:IsA("GuiObject") then
                        return Check_2(p1.Parent)
                    end
                    if p1.Visible == false then
                        return false
                    end
                    if p1.Visible == true then
                        return Check_2(p1.Parent)
                    end
                end

                if not Check_2(v.UIObj) then
                    v.MouseDownOnObj = false
                else
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify_2 = true
                    else
                        IsPartOfNotify_2 = u8[k].IsPartOfNotify
                    end
                    if not IsPartOfNotify_2 then
                        v.MouseDownOnObj = false
                    elseif not v3 then
                        if not IsInClipping(v.UIObj) then
                            v.MouseDownOnObj = false
                        else
                            if v3 then
                                v2 = u8[v3]
                                v2.MouseDownOnObj = false
                            end
                            v3 = k
                        end
                    elseif not (v3.ZIndex < k.ZIndex) or not IsInClipping(v.UIObj) then
                        v.MouseDownOnObj = false
                    else
                        if v3 then
                            v2 = u8[v3]
                            v2.MouseDownOnObj = false
                        end
                        v3 = k
                    end
                end
            end
        elseif v5.UserInputType == Enum.UserInputType.MouseButton1 then
            if not v.MouseIn or not v.UIObj.Visible then
                v.MouseDownOnObj = false
            else
                local function Check_2(p1) -- Line: 159 -- upvalues: v (val), Check_2 (val)
                    local SurfaceGui = v.SurfaceGui
                    if not p1.Parent then
                        return false
                    end
                    if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                    if p1.Parent == SurfaceGui
                        and p1:IsA("GuiObject")
                        and p1.Visible == true
                        and SurfaceGui.Enabled == true then
                        return true
                    end
                    if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                        return true
                    end
                    if not p1:IsA("GuiObject") then
                        return Check_2(p1.Parent)
                    end
                    if p1.Visible == false then
                        return false
                    end
                    if p1.Visible == true then
                        return Check_2(p1.Parent)
                    end
                end

                if not Check_2(v.UIObj) then
                    v.MouseDownOnObj = false
                else
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify_2 = true
                    else
                        IsPartOfNotify_2 = u8[k].IsPartOfNotify
                    end
                    if not IsPartOfNotify_2 then
                        v.MouseDownOnObj = false
                    elseif not v3 then
                        if not IsInClipping(v.UIObj) then
                            v.MouseDownOnObj = false
                        else
                            if v3 then
                                v2 = u8[v3]
                                v2.MouseDownOnObj = false
                            end
                            v3 = k
                        end
                    elseif not (v3.ZIndex < k.ZIndex) or not IsInClipping(v.UIObj) then
                        v.MouseDownOnObj = false
                    else
                        if v3 then
                            v2 = u8[v3]
                            v2.MouseDownOnObj = false
                        end
                        v3 = k
                    end
                end
            end
        end
    end
    if v3 then
        local X, Y
        local Notify = LocalPlayer.PlayerGui:FindFirstChild("Notify")
        local v6 = u8[v3]
        if not Notify then
            if not Notify and not v6.IsPartOfNotify then
                v6.MouseDownOnObj = true
                if not v4 then
                    X = Mouse.X
                    Y = Mouse.Y
                else
                    X = v4.X
                    Y = v4.Y
                    v6.EnteredEvent:Fire()
                end
                if not SettingsGui.Enabled and not u17.Visible then
                    v6.DownEvent:Fire(X, Y)
                end
            end
        elseif v6.IsPartOfNotify or not Notify and not v6.IsPartOfNotify then
            v6.MouseDownOnObj = true
            if not v4 then
                X = Mouse.X
                Y = Mouse.Y
            else
                X = v4.X
                Y = v4.Y
                v6.EnteredEvent:Fire()
            end
            if not SettingsGui.Enabled and not u17.Visible then
                v6.DownEvent:Fire(X, Y)
            end
        end
    end
end

local function inputEnded(p1, p2) -- Line: 277
    -- upvalues: u8 (val), LocalPlayer (val), Mouse (val), SettingsGui (val), u17 (ref)
    local IsPartOfNotify, IsPartOfNotify_2, X_2, Y_2, v1
    local v2 = nil
    local v3, v4 = p2, p1
    for k, v in pairs(u8) do
        if v3 then
            X_2 = v3.X
            Y_2 = v3.Y
            v1 = false
            if k.AbsolutePosition.X < X_2 then
                v1 = false
                if k.AbsolutePosition.Y < Y_2 then
                    v1 = false
                    if X_2 < k.AbsolutePosition.X + k.AbsoluteSize.X then
                        v1 = Y_2 < k.AbsolutePosition.Y + k.AbsoluteSize.Y
                    end
                end
            end
            if v1 and v.UIObj.Visible and v.MouseDownOnObj == true then
                if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                    IsPartOfNotify = true
                else
                    IsPartOfNotify = u8[k].IsPartOfNotify
                end
                if IsPartOfNotify then
                    if not v2 or v2.ZIndex < k.ZIndex then
                        v2 = k
                    end
                end
            end
        elseif v4.KeyCode == Enum.KeyCode.ButtonA then
            if k.Visible == true and k.Visible and v.MouseDownOnObj == true then
                if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                    IsPartOfNotify_2 = true
                else
                    IsPartOfNotify_2 = u8[k].IsPartOfNotify
                end
                if IsPartOfNotify_2 then
                    if not v2 or v2.ZIndex < k.ZIndex then
                        v2 = k
                    end
                end
            end
        elseif v4.UserInputType == Enum.UserInputType.MouseButton1
            and k.Visible == true
            and k.Visible
            and v.MouseDownOnObj == true then
            if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                IsPartOfNotify_2 = true
            else
                IsPartOfNotify_2 = u8[k].IsPartOfNotify
            end
            if IsPartOfNotify_2 then
                if not v2 or v2.ZIndex < k.ZIndex then
                    v2 = k
                end
            end
        end
    end
    if v2 then
        local X, Y
        local u17_2 = u8[v2]
        if not v3 then
            X = Mouse.X
            Y = Mouse.Y
        else
            X = v3.X
            Y = v3.Y
        end
        if v3 then
            local Check

            function Check(p1) -- Line: 159 -- upvalues: u17_2 (val), Check (val)
                local SurfaceGui = u17_2.SurfaceGui
                if not p1.Parent then
                    return false
                end
                if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                    return SurfaceGui.Visible
                end
                if p1.Parent == SurfaceGui
                    and p1:IsA("GuiObject")
                    and p1.Visible == true
                    and SurfaceGui.Enabled == true then
                    return true
                end
                if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                    return true
                end
                if not p1:IsA("GuiObject") then
                    return Check(p1.Parent)
                end
                if p1.Visible == false then
                    return false
                end
                if p1.Visible == true then
                    return Check(p1.Parent)
                end
            end

            if Check(u17_2.UIObj) and not SettingsGui.Enabled and not u17.Visible then
                local UIObj = u17_2.UIObj
                local v5 = X
                local v6 = Y
                local v7 = false
                if UIObj.AbsolutePosition.X < v5 then
                    v7 = false
                    if UIObj.AbsolutePosition.Y < v6 then
                        v7 = false
                        if v5 < UIObj.AbsolutePosition.X + UIObj.AbsoluteSize.X then
                            v7 = v6 < UIObj.AbsolutePosition.Y + UIObj.AbsoluteSize.Y
                        end
                    end
                end
                if v7 then
                    u17_2.ClickEvent:Fire(X, Y)
                    return
                end
                u17_2.UpEvent:Fire(X, Y)
                return
            end
        end
        if u17_2.MouseIn then
            local Check_2

            function Check_2(p1) -- Line: 159 -- upvalues: u17_2 (val), Check_2 (val)
                local SurfaceGui = u17_2.SurfaceGui
                if not p1.Parent then
                    return false
                end
                if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                    return SurfaceGui.Visible
                end
                if p1.Parent == SurfaceGui
                    and p1:IsA("GuiObject")
                    and p1.Visible == true
                    and SurfaceGui.Enabled == true then
                    return true
                end
                if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                    return true
                end
                if not p1:IsA("GuiObject") then
                    return Check_2(p1.Parent)
                end
                if p1.Visible == false then
                    return false
                end
                if p1.Visible == true then
                    return Check_2(p1.Parent)
                end
            end

            if Check_2(u17_2.UIObj) and not SettingsGui.Enabled and not u17.Visible then
                u17_2.ClickEvent:Fire(X, Y)
                return
            end
        end
        if not u17_2.MouseIn then
            u17_2.UpEvent:Fire(X, Y)
        end
    end
end

;(game:GetService("UserInputService")).InputBegan:connect(function(p1, p2) -- Line: 321 -- upvalues: inputDown (val)
    if p1.KeyCode == Enum.KeyCode.ButtonA or p1.UserInputType == Enum.UserInputType.MouseButton1 then
        inputDown(p1, p2)
    end
end)
if game:GetService("UserInputService").TouchEnabled then
    (game:GetService("UserInputService")).TouchStarted:Connect(function(p1, p2) -- Line: 328 -- upvalues: inputDown (val)
        inputDown(nil, p2, p1.Position)
    end)
    ;(game:GetService("UserInputService")).TouchEnded:Connect(function(p1, p2) -- Line: 331 -- upvalues: inputEnded (val)
        inputEnded(nil, p1.Position)
    end)
end
;(game:GetService("UserInputService")).InputEnded:connect(function(p1) -- Line: 336 -- upvalues: inputEnded (val)
    inputEnded(p1)
end)
;(game:GetService("UserInputService")).InputChanged:connect(function(p1, p2) -- Line: 340 -- upvalues: u8 (val), IsInFrame (val), LocalPlayer (val), IsInClipping (val)
    if p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.Thumbstick1 then
        local IsPartOfNotify
        Vector2.new(p1.Position.X, p1.Position.Y)
        local v1 = nil
        for k, v in pairs(u8) do
            if not IsInFrame(v.UIObj) then
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
                    if not SurfaceGui:IsA("ScreenGui") and SurfaceGui:IsA("GuiObject") then
                        return SurfaceGui.Visible
                    end
                    if p1.Parent == SurfaceGui
                        and p1:IsA("GuiObject")
                        and p1.Visible == true
                        and SurfaceGui.Enabled == true then
                        return true
                    end
                    if p1.Parent == SurfaceGui and not p1:IsA("GuiObject") and SurfaceGui.Enabled == true then
                        return true
                    end
                    if not p1:IsA("GuiObject") then
                        return Check(p1.Parent)
                    end
                    if p1.Visible == false then
                        return false
                    end
                    if p1.Visible == true then
                        return Check(p1.Parent)
                    end
                end

                if Check(v.UIObj) then
                    if not LocalPlayer.PlayerGui:FindFirstChild("Notify") then
                        IsPartOfNotify = true
                    else
                        IsPartOfNotify = u8[k].IsPartOfNotify
                    end
                    if not IsPartOfNotify then
                        if v.MouseIn then
                            v.MouseIn = false
                            v.LeaveEvent:Fire()
                        end
                    elseif not v1 then
                        if IsInClipping(v.UIObj) then
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
                    elseif IsInClipping(v.UIObj) then
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
        if v1 and not u8[v1].MouseIn then
            local v2 = u8[v1]
            v2.MouseIn = true
            u8[v1].EnteredEvent:Fire()
        end
    end
end)
return v1