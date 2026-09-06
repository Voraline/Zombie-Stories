local Notify
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
    if not u78 then
        u78 = next(u48)
        return
    end
    if u48[u78] then
        return
    end
    u78 = next(u48)
end
PlayerGui.ChildAdded:Connect(function(p1) -- Line: 41 -- upvalues: u47 (ref), u48 (val), u78 (ref), BindableEvent (val)
    if p1 == u47 or p1.Name ~= "Notify" or not (p1:IsA("ScreenGui")) or u48[p1] then
        return
    end
    u48[p1] = true
    if not u78 then
        u78 = next(u48)
    elseif not (u48[u78]) then
        u78 = next(u48)
    end
    p1.IgnoreGuiInset = true
    p1.DisplayOrder = 500
    p1.Enabled = true
    BindableEvent:Fire()
end)
PlayerGui.ChildRemoved:Connect(function(p1) -- Line: 57 -- upvalues: u48 (val), u78 (ref), BindableEvent (val)
    if not (u48[p1]) then
        return
    end
    u48[p1] = nil
    if not u78 then
        u78 = next(u48)
    elseif not (u48[u78]) then
        u78 = next(u48)
    end
    BindableEvent:Fire()
end)
Notify = PlayerGui:FindFirstChild("Notify")
if Notify and Notify ~= u47 and Notify.Name == "Notify" and Notify:IsA("ScreenGui") and not (u48[Notify]) then
    u48[Notify] = true
    if not u78 then
        u78 = next(u48)
    elseif not (u48[u78]) then
        u78 = next(u48)
    end
    Notify.IgnoreGuiInset = true
    Notify.DisplayOrder = 500
    Notify.Enabled = true
    BindableEvent:Fire()
end
local function waitForLobbyPresentation() -- Line: 71 -- upvalues: ReplicatedStorage (val)
    local Lobby
    if workspace:GetAttribute("PlaceType") ~= "Lobby" then
        return
    end
    local MarauderLoading = require(ReplicatedStorage.common.ZS_Framework.UI.MarauderLoading)
    if MarauderLoading.WaitUntilPresented("Lobby", 5) then
        MarauderLoading.WaitUntilDismissed("Lobby")
    end
end
local function show(p1) -- Line: 82 -- upvalues: Fusion (val), UserInputService (val), GuiService (val), PlayerGui (val), u47 (ref), u48 (val), u78 (ref), UIKit (val), Theme (val), BindableEvent (val)
    local SelectedObject
    local v1 = Fusion.scoped(Fusion)
    local v2 = v1:Value(true)
    local v3 = v1:Value("CONTINUE")
    local v4 = p1.Waittime or 0
    local v5 = 0 < v4
    local v6 = v1:Value(v5)
    local u23 = false
    local GamepadEnabled = UserInputService.GamepadEnabled
    if not GamepadEnabled then
        SelectedObject = nil
    else
        SelectedObject = GuiService.SelectedObject
    end
    local v7 = v1:New("ScreenGui")
    v7 = v7({
        Name = "Notify",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 500,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Parent = PlayerGui,
    })
    u47 = v7
    u48[v7] = nil
    if u78 == v7 then
        u78 = nil
    end
    local v8 = {
        Name = "NotifyModal",
        DefaultOpen = true,
        Dismissable = false,
        scope = v1,
        Parent = v7,
        Open = v2,
        Title = p1.Header,
        Text = p1.Body,
        ButtonSound = UIKit.UISounds.ClickSound,
    }
    local v9 = {}
    local v10 = {
        Text = v3,
        Disabled = v6,
        Color = Theme.Menu.Positive,
        TextColor = Theme.Menu.Text,
        StrokeColor = Theme.Menu.NavigationColors.Play.Accent,
        BackgroundColor = Theme.Menu.NavigationColors.Play.Fill,
        GradientColor = Theme.Menu.NavigationColors.Play.Gradient,
        OnClick = function() -- Line: 124 -- upvalues: u23 (ref)
            u23 = true
        end,
    }
    v9[1] = v10
    v8.Buttons = v9
    UIKit.Modal(v8)
    local Button1 = v7:FindFirstChild("Button1", true)
    if GamepadEnabled and Button1 and Button1:IsA("GuiButton") then
        GuiService.SelectedObject = Button1
    end
    v8 = math.max(0, (math.floor(tonumber(p1.Waittime) or 0)))
    if 0 < v8 then
        v9 = 1
        v10 = -1
        for i = v8, v9, v10 do
            v3:set((tostring(i)))
            task.wait(1)
        end
        v6:set(false)
        v3:set("CONTINUE")
    end
    while not u23 do
        task.wait()
    end
    v2:set(false)
    task.wait(0.2)
    if GamepadEnabled and GuiService.SelectedObject == Button1 then
        v9 = GuiService
        if not SelectedObject then
            v10 = nil
        elseif not SelectedObject.Parent then
            v10 = nil
        else
            v10 = SelectedObject
        end
        v9.SelectedObject = v10
    end
    v1:doCleanup()
    u47 = nil
    BindableEvent:Fire()
end
local function worker() -- Line: 159 -- upvalues: waitForLobbyPresentation (val), u78 (ref), BindableEvent (val), u38 (val), show (val)
    local v1
    waitForLobbyPresentation()
    while true do
        if not u78 then
            v1 = #u38
            if 0 >= v1 then
                BindableEvent.Event:Wait()
            else
                show(table.remove(u38, 1))
            end
        else
            BindableEvent.Event:Wait()
        end
    end
end
function u36.Push(p1) -- Line: 172 -- upvalues: u38 (val), BindableEvent (val)
    if type(p1) ~= "table" then
        return
    end
    table.insert(u38, {Header = p1.Header or "", Body = p1.Body or "", Waittime = p1.Waittime})
    BindableEvent:Fire()
end
function u36.WaitUntilIdle() -- Line: 184 -- upvalues: u47 (ref), u48 (val), u38 (val), BindableEvent (val)
    local v1
    while true do
        if u47 then
            BindableEvent.Event:Wait()
            continue
        end
        if next(u48) then end
        v1 = #u38
        if 0 >= v1 then
            break
        end
    end
end
function u36.Start() -- Line: 190 -- upvalues: u37 (ref), ReplicatedStorage (val), u36 (val), worker (val)
    if u37 then
        return
    end
    u37 = true
    ReplicatedStorage.common.Remotes:WaitForChild("NotifyRemote").OnClientEvent:Connect(function(p1, p2, p3) -- Line: 195 -- upvalues: u36 (upval)
        u36.Push({Body = p1, Header = p2, Waittime = p3})
    end)
    task.spawn(worker)
end
return u36