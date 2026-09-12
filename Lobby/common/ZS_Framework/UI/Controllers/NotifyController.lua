local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local u36 = {}
local u37 = false
local u38 = {}
local BindableEvent = Instance.new("BindableEvent")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local u47 = nil
local u48 = {}
local u78 = nil

local function refreshForeignNotify() -- Line: 34 -- upvalues: u78 (ref), u48 (val)
    if u78 and u48[u78] then
        return
    end
    u78 = next(u48)
end

PlayerGui.ChildAdded:Connect(function(p1) -- Line: 41 -- upvalues: u47 (ref), u48 (val), u78 (ref), BindableEvent (val)
    if p1 ~= u47 and p1.Name == "Notify" and p1:IsA("ScreenGui") then
        if u48[p1] then
            return
        end
        u48[p1] = true
        if not u78 or not u48[u78] then
            u78 = next(u48)
        end
        p1.IgnoreGuiInset = true
        p1.DisplayOrder = 500
        p1.Enabled = true
        BindableEvent:Fire()
        return
    end
end)
PlayerGui.ChildRemoved:Connect(function(p1) -- Line: 57 -- upvalues: u48 (val), u78 (ref), BindableEvent (val)
    if not u48[p1] then
        return
    end
    u48[p1] = nil
    if not u78 or not u48[u78] then
        u78 = next(u48)
    end
    BindableEvent:Fire()
end)
local Notify = PlayerGui:FindFirstChild("Notify")
if Notify and Notify ~= u47 and Notify.Name == "Notify" and Notify:IsA("ScreenGui") and not u48[Notify] then
    u48[Notify] = true
    if not u78 or not u48[u78] then
        u78 = next(u48)
    end
    Notify.IgnoreGuiInset = true
    Notify.DisplayOrder = 500
    Notify.Enabled = true
    BindableEvent:Fire()
end

local function waitForLobbyPresentation() -- Line: 71 -- upvalues: ReplicatedStorage (val)
    if workspace:GetAttribute("PlaceType") ~= "Lobby" then
        return
    end
    local MarauderLoading = require(ReplicatedStorage.common.ZS_Framework.UI.MarauderLoading)
    if MarauderLoading.WaitUntilPresented("Lobby", 5) then
        MarauderLoading.WaitUntilDismissed("Lobby")
    end
end

local function show(p1) -- Line: 82
    -- upvalues: Fusion (val), UserInputService (val), GuiService (val), PlayerGui (val), u47 (ref), u48 (val)
    -- upvalues: u78 (ref), UIKit (val), Theme (val), BindableEvent (val)
    local SelectedObject
    local v1 = Fusion.scoped(Fusion)
    local v2 = v1:Value(true)
    local v3 = v1:Value("CONTINUE")
    local v4 = 0 < (p1.Waittime or 0)
    local v5 = v1:Value(v4)
    local u23 = false
    local GamepadEnabled = UserInputService.GamepadEnabled
    if not GamepadEnabled then
        SelectedObject = nil
    else
        SelectedObject = GuiService.SelectedObject
    end
    local v6 = v1:New("ScreenGui")({
        Name = "Notify",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 500,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Parent = PlayerGui,
    })
    u47 = v6
    u48[v6] = nil
    if u78 == v6 then
        u78 = nil
    end
    local v7 = UIKit
    local Modal = v7.Modal
    local v8 = {
        Name = "NotifyModal",
        DefaultOpen = true,
        Dismissable = false,
        scope = v1,
        Parent = v6,
        Open = v2,
        Title = p1.Header,
        Text = p1.Body,
        ButtonSound = UIKit.UISounds.ClickSound,
    }
    local v9 = {
        {
            Text = v3,
            Disabled = v5,
            Color = Theme.Menu.Positive,
            TextColor = Theme.Menu.Text,
            StrokeColor = Theme.Menu.NavigationColors.Play.Accent,
            BackgroundColor = Theme.Menu.NavigationColors.Play.Fill,
            GradientColor = Theme.Menu.NavigationColors.Play.Gradient,
            OnClick = function() -- Line: 124 -- upvalues: u23 (ref)
                u23 = true
            end,
        },
    }
    v8.Buttons = v9
    Modal(v8)
    local Button1 = v6:FindFirstChild("Button1", true)
    if GamepadEnabled and Button1 and Button1:IsA("GuiButton") then
        GuiService.SelectedObject = Button1
    end
    local Waittime = p1.Waittime
    local v10 = tonumber(Waittime)
    local v11 = math.floor(v10 or 0)
    v8 = math.max(0, v11)
    if 0 < v8 then
        local v12
        for i = v8, 1, -1 do
            v12 = tostring(i)
            v3:set(v12)
            task.wait(1)
        end
        v5:set(false)
        v3:set("CONTINUE")
    end
    while not u23 do
        task.wait()
    end
    v2:set(false)
    task.wait(0.2)
    if GamepadEnabled and GuiService.SelectedObject == Button1 then
        v9 = GuiService
        if not SelectedObject or not SelectedObject.Parent then
            v11 = nil
        else
            v11 = SelectedObject
        end
        v9.SelectedObject = v11
    end
    v1:doCleanup()
    u47 = nil
    BindableEvent:Fire()
end

local function worker() -- Line: 159
    -- upvalues: waitForLobbyPresentation (val), u78 (ref), BindableEvent (val), u38 (val), show (val)
    waitForLobbyPresentation()
    while true do
        if u78 or not (0 < #u38) then
            BindableEvent.Event:Wait()
        else
            show(table.remove(u38, 1))
        end
    end
end

function u36.Push(p1) -- Line: 172 -- upvalues: u38 (val), BindableEvent (val)
    if type(p1) ~= "table" then
        return
    end
    local v1 = u38
    local v2 = {Header = p1.Header or "", Body = p1.Body or "", Waittime = p1.Waittime}
    table.insert(v1, v2)
    BindableEvent:Fire()
end

function u36.WaitUntilIdle() -- Line: 184 -- upvalues: u47 (ref), u48 (val), u38 (val), BindableEvent (val)
    while true do
        if u47 or next(u48) then
            BindableEvent.Event:Wait()
            continue
        end
        if not (0 < #u38) then
            break
        end
        BindableEvent.Event:Wait()
    end
end

function u36.Start() -- Line: 190 -- upvalues: u37 (ref), ReplicatedStorage (val), u36 (val), worker (val)
    if u37 then
        return
    end
    u37 = true
    ;(ReplicatedStorage.common.Remotes:WaitForChild("NotifyRemote")).OnClientEvent:Connect(function(p1, p2, p3) -- Line: 195 -- upvalues: u36 (upval)
        local v1 = u36
        v1.Push({Body = p1, Header = p2, Waittime = p3})
    end)
    task.spawn(worker)
end

return u36