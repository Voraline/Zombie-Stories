local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local peek = Fusion.peek
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local MarauderLoading = require(ReplicatedStorage.common.ZS_Framework.UI.MarauderLoading)
local NotifyController = require(ReplicatedStorage.common.ZS_Framework.UI.Controllers.NotifyController)
local v1 = {}
local u60 = false
local u61 = nil
local u62 = nil
local BindableEvent = Instance.new("BindableEvent")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local u71 = 0
local function formatCountdown(p1) -- Line: 30
    local v1 = math.max(0, (math.floor(tonumber(p1) or 0)))
    local v2 = math.floor(v1 / 3600)
    local v3 = math.floor(v1 % 3600 / 60)
    return string.format("%02d:%02d:%02d", v2, v3, v1 % 60)
end
local function scheduleRolloverCheck(p1) -- Line: 35 -- upvalues: u71 (ref), ReplicatedStorage (val)
    u71 = u71 + 1
    local u3 = u71
    local v1 = math.max(0, (math.floor(tonumber(p1.SecondsUntilNext) or 0)))
    if p1.Claimable ~= true or v1 <= 0 then
        return
    end
    task.delay(v1, function() -- Line: 42 -- upvalues: u3 (val), u71 (upval), ReplicatedStorage (upval)
        if u3 ~= u71 then
            return
        end
        pcall(function() -- Line: 46 -- upvalues: ReplicatedStorage (upval)
            ReplicatedStorage.common.Remotes.DataRemote:InvokeServer("CheckDaily")
        end)
    end)
end
local function makeTile(p1, p2, p3, p4) -- Line: 52 -- upvalues: Theme (val), UIKit (val)
    local Accent, AccentCyan, Accent_2, Selected, Thick, v1, v2, v3, v4, v5
    local v6 = p1:innerScope()
    local v7 = p3 == p2.DayIndex
    if p3 <= p2.CompletedDays or 0 then
        v5 = true
    else
        v5 = false
    end
    local v8 = v7
    if v8 then
        v8 = p2.Claimable == true
    end
    if v7 then
        Accent = Theme.Menu.Accent
    elseif p2.DayIndex >= p3 then
        Accent = Theme.Menu.Border
    else
        Accent = Theme.Menu.BorderUnselected
    end
    local v9 = {StrokeTransparency = 0, scope = v6, Name = "Day" .. p3, Size = UDim2.fromOffset(108, 148)}
    if not v7 then
        Selected = Theme.Menu.Panel
    else
        Selected = Theme.Menu.Selected
    end
    v9.BackgroundColor3 = Selected
    v9.StrokeColor3 = Accent
    if not v7 then
        Thick = Theme.Stroke.Medium
    else
        Thick = Theme.Stroke.Thick
    end
    v9.StrokeThickness = Thick
    v9.ZIndex = Theme.ZIndex.Modal + 2
    local v10 = {}
    local v11 = v6:New("UIScale")
    local v12 = {}
    if not v7 then
        v1 = 1
    else
        v1 = 1.08
    end
    v12.Scale = v1
    v11 = v11(v12)
    v12 = v6:New("TextLabel")
    v1 = {
        Name = "DayLabel",
        BackgroundTransparency = 1,
        TextSize = 13,
        Position = UDim2.fromOffset(4, 6),
        Size = UDim2.new(1, -8, 0, 18),
    }
    if not v7 then
        v2 = "DAY " .. (p2.Week - 1) * 7 + p3
    else
        v2 = "TODAY"
    end
    v1.Text = v2
    v1.Font = Theme.Menu.Fonts.Header
    if not v7 then
        Accent_2 = Theme.Menu.TextMuted
    else
        Accent_2 = Theme.Menu.Accent
    end
    v1.TextColor3 = Accent_2
    v1.ZIndex = Theme.ZIndex.Modal + 3
    v12 = v12(v1)
    v1 = v6:New("ImageLabel")
    v1 = v1({
        Name = "RewardImage",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 28),
        Size = UDim2.fromOffset(72, 72),
        Image = p4.ImageId or "",
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = Theme.ZIndex.Modal + 3,
    })
    v2 = v6:New("TextLabel")
    local v13 = {
        Name = "RewardLabel",
        BackgroundTransparency = 1,
        TextWrapped = true,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -7),
        Size = UDim2.new(1, -8, 0, 28),
        Text = p4.Label or "",
        Font = Enum.Font.GothamBlack,
    }
    if p4.Kind ~= "Crate" then
        AccentCyan = Theme.Colors.ZBucksTitle
    else
        AccentCyan = Theme.Menu.AccentCyan
    end
    v13.TextColor3 = AccentCyan
    if p4.Kind ~= "Crate" then
        v3 = 16
    else
        v3 = 12
    end
    v13.TextSize = v3
    v13.ZIndex = Theme.ZIndex.Modal + 3
    v2 = v2(v13)
    v13 = v6:New("Frame")
    v3 = {
        Name = "Claimed",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.55,
        Visible = v5,
        ZIndex = Theme.ZIndex.Modal + 4,
    }
    local v14 = {}
    local v15 = v6:New("ImageLabel")
    local v16 = {
        Name = "CheckmarkDay" .. p3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(52, 52),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1154620824",
        ImageColor3 = Theme.Menu.Positive,
    }
    if not v8 then
        v4 = 0
    else
        v4 = 1
    end
    v16.ImageTransparency = v4
    v16.ZIndex = Theme.ZIndex.Modal + 5
    local Children = v6.Children
    local v17 = {}
    local v18 = v6:New("UIScale")
    v17[1] = v18({Name = "ClaimScale", Scale = 1})
    v16[Children] = v17
    v14[1] = v15(v16)
    v3[v6.Children] = v14
    v10[1] = v11
    v10[2] = v12
    v10[3] = v1
    v10[4] = v2
    v10[5] = v13(v3)
    v9.Children = v10
    return UIKit.Card(v9)
end
local function buildRewardLayout(p1, p2, p3, p4) -- Line: 137 -- upvalues: makeTile (val)
    local Horizontal, v1, v2
    local v3 = {}
    local Rewards = p2.Rewards
    if not Rewards then
        Rewards = {}
    end
    for i, v in ipairs(Rewards) do
        table.insert(v3, makeTile(p1, p2, i, v))
    end
    local v4 = p1:New("Frame")
    local v5 = {}
    if not p3 then
        v2 = "RewardStrip"
    else
        v2 = "RewardGrid"
    end
    v5.Name = v2
    v5.Size = p1:Computed(function(p1) -- Line: 144 -- upvalues: p4 (val), p3 (val)
        local v1
        if not (p1(p4)) then
            v1 = 0
        elseif not p3 then
            v1 = 168
        else
            v1 = 326
        end
        return UDim2.new(1, 0, 0, v1)
    end)
    v5.BackgroundTransparency = 1
    v5.Visible = p4
    local v6 = {}
    if not p3 then
        v1 = "UIListLayout"
    else
        v1 = "UIGridLayout"
    end
    local v7 = p1:New(v1)
    local v8 = {}
    if not p3 then
        v1 = nil
    else
        v1 = UDim2.fromOffset(108, 148)
    end
    v8.CellSize = v1
    if not p3 then
        v1 = nil
    else
        v1 = UDim2.fromOffset(10, 10)
    end
    v8.CellPadding = v1
    if not p3 then
        Horizontal = Enum.FillDirection.Horizontal
    else
        Horizontal = Enum.FillDirection.Horizontal
    end
    v8.FillDirection = Horizontal
    v8.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v8.VerticalAlignment = Enum.VerticalAlignment.Center
    v8.SortOrder = Enum.SortOrder.LayoutOrder
    if not p3 then
        v1 = UDim.new(0, 10)
    else
        v1 = nil
    end
    v8.Padding = v1
    v7 = v7(v8)
    v6[1] = v7
    v6[2] = table.unpack(v3)
    v5[p1.Children] = v6
    return v4(v5)
end
local function show(p1) -- Line: 164 -- upvalues: Fusion (val), fusion_utils (val), UserInputService (val), GuiService (val), PlayerGui (val), u62 (ref), peek (val), UIKit (val), Theme (val), buildRewardLayout (val), TweenService (val)
    local SelectedObject
    local v1 = Fusion.scoped(Fusion, fusion_utils)
    local u9 = v1:Value(true)
    local u10 = false
    local u22 = v1:Value((math.max(0, (math.floor(tonumber(p1.SecondsUntilNext) or 0)))))
    local u25 = fusion_utils.useViewport()
    local u29 = v1:Computed(function(p1) -- Line: 170 -- upvalues: u25 (val)
        local v1 = p1(u25).X < 620
        return v1
    end)
    local v2 = v1:Computed(function(p1) -- Line: 173 -- upvalues: u25 (val), u29 (val)
        local v1
        local v2 = p1(u25)
        if p1(u29) then
            v1 = v2.X / 480
            return (math.min(1, v1, v2.Y / 600))
        end
        v1 = v2.X / 1000
        return (math.min(1, v1, v2.Y / 600))
    end)
    local GamepadEnabled = UserInputService.GamepadEnabled
    local u38 = v1:Value(GamepadEnabled)
    if not UserInputService.GamepadEnabled then
        SelectedObject = nil
    else
        SelectedObject = GuiService.SelectedObject
    end
    local PropertyChangedSignal = UserInputService:GetPropertyChangedSignal("GamepadEnabled")
    table.insert(v1, PropertyChangedSignal:Connect(function() -- Line: 184 -- upvalues: u38 (val), UserInputService (upval)
        u38:set(UserInputService.GamepadEnabled)
    end))
    local v3 = v1:New("ScreenGui")
    local u65 = v3({
        Name = "Notify",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 10,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Parent = PlayerGui,
    })
    local u69 = p1.Claimable == true
    local u75 = v1:Computed(function(p1) -- Line: 198 -- upvalues: u38 (val)
        if p1(u38) then
            return "Ⓐ  "
        end
        return ""
    end)
    local v4 = v1:Computed(function(p1) -- Line: 201 -- upvalues: u69 (val), u75 (val)
        local v1, v2
        if not u69 then
            v1 = ""
        else
            v1 = p1(u75)
        end
        if not u69 then
            v2 = "BEAT A GAME TO CLAIM"
        else
            v2 = "CLAIM"
        end
        return v1 .. v2
    end)
    local v5 = v1:Computed(function(p1) -- Line: 204 -- upvalues: u75 (val)
        local v1 = p1(u75)
        return v1 .. "CLOSE"
    end)
    local function close() -- Line: 208 -- upvalues: u10 (ref), u9 (val)
        u10 = true
        u9:set(false)
    end
    u62 = close
    task.spawn(function() -- Line: 213 -- upvalues: peek (upval), u9 (val), u22 (val)
        local v1
        while peek(u9) do
            v1 = peek(u22)
            if 0 >= v1 then
                break
            end
            task.wait(1)
            u22:set((math.max(0, peek(u22) - 1)))
        end
    end)
    local v6 = {
        Name = "DailyRewardModal",
        DefaultOpen = true,
        HorizontalPadding = 8,
        TitleTextSize = 26,
        Text = "Log in every day for a bigger reward. Day 7 is a free Primary crate.",
        BodyTextSize = 16,
        ButtonHeight = 44,
        scope = v1,
        Parent = u65,
        Open = u9,
        PanelScale = v2,
        Size = v1:Computed(function(p1) -- Line: 226 -- upvalues: u29 (val)
            local v1
            if not (p1(u29)) then
                v1 = 860
            else
                v1 = 480
            end
            return UDim2.fromOffset(v1, 0)
        end),
    }
    local AbsoluteDay = p1.AbsoluteDay
    if not AbsoluteDay then
        AbsoluteDay = p1.DayIndex
    end
    v6.Title = "DAILY REWARD — DAY " .. tostring(AbsoluteDay)
    v6.TextColor = Theme.Menu.TextMuted
    v6.ButtonSound = UIKit.UISounds.ClickSound
    local v7 = {}
    local v8 = v1:New("Frame")
    local v9 = {Name = "DailyContent", Size = v1:Computed(function(p1) -- Line: 240 -- upvalues: u29 (val)
        local v1
        if not (p1(u29)) then
            v1 = 194
        else
            v1 = 352
        end
        return UDim2.new(1, 0, 0, v1)
    end), BackgroundTransparency = 1}
    local Children = v1.Children
    local v10 = {}
    local v11 = v1:New("UIListLayout")
    v11 = v11({FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)})
    local v12 = buildRewardLayout(v1, p1, false, v1:Computed(function(p1) -- Line: 255 -- upvalues: u29 (val)
        return not p1(u29)
    end))
    local v13 = buildRewardLayout(v1, p1, true, u29)
    local v14 = v1:New("TextLabel")
    local v15 = {
        Name = "NextReward",
        LayoutOrder = 4,
        BackgroundTransparency = 1,
        TextSize = 14,
        Size = UDim2.new(1, 0, 0, 18),
        Text = v1:Computed(function(p1) -- Line: 265 -- upvalues: u22 (val)
            local v1 = math.max(0, (math.floor(tonumber((p1(u22))) or 0)))
            local v2 = math.floor(v1 / 3600)
            local v3 = math.floor(v1 % 3600 / 60)
            return "NEXT REWARD IN " .. string.format("%02d:%02d:%02d", v2, v3, v1 % 60)
        end),
        Font = Theme.Menu.Fonts.Body,
        TextColor3 = Theme.Menu.TextMuted,
    }
    v10[1] = v11
    v10[2] = v12
    v10[3] = v13
    v10[4] = v14(v15)
    v9[Children] = v10
    v7[1] = v8(v9)
    v6.Children = v7
    v7 = {}
    v8 = {KeepOpen = true, Text = v4, Disabled = not u69}
    if not u69 then
        v9 = 270
    else
        v9 = 220
    end
    v8.Width = v9
    v8.Color = Theme.Menu.Positive
    v8.TextColor = Theme.Menu.Text
    v8.StrokeColor = Theme.Menu.NavigationColors.Play.Accent
    v8.BackgroundColor = Theme.Menu.NavigationColors.Play.Fill
    v8.GradientColor = Theme.Menu.NavigationColors.Play.Gradient
    function v8.OnClick() -- Line: 286 -- upvalues: u69 (val), UIKit (upval), peek (upval), u29 (val), u65 (val), p1 (val), TweenService (upval), close (val)
        local v1
        if not u69 then
            return
        end
        UIKit.UISounds.Reward()
        if not (peek(u29)) then
            v1 = "RewardStrip"
        else
            v1 = "RewardGrid"
        end
        local v2 = u65:FindFirstChild(v1, true)
        local v3 = v2
        if v3 then
            local v4 = "CheckmarkDay" .. tostring(p1.DayIndex)
            v3 = v2:FindFirstChild(v4, true)
        end
        if v3 then
            local v5
            v3.ImageTransparency = 1
            local ClaimScale = v3:FindFirstChild("ClaimScale")
            if ClaimScale then
                ClaimScale.Scale = 4
                v5 = TweenInfo.new(0.35, Enum.EasingStyle.Back)
                TweenService:Create(ClaimScale, v5, {Scale = 1}):Play()
            end
            v5 = TweenInfo.new(0.25)
            TweenService:Create(v3, v5, {ImageTransparency = 0}):Play()
        end
        task.delay(0.9, close)
    end
    if u69 then
        v9 = nil
    else
        v9 = {
            Width = 120,
            Text = v5,
            Color = Theme.Colors.CloseButton,
            TextColor = Theme.Menu.Text,
            StrokeColor = Theme.Menu.NavigationColors.Cancel.Accent,
            BackgroundColor = Theme.Menu.NavigationColors.Cancel.Fill,
            GradientColor = Theme.Menu.NavigationColors.Cancel.Gradient,
            OnClick = close,
        }
    end
    v7[1] = v8
    v7[2] = v9
    v6.Buttons = v7
    UIKit.Modal(v6)
    if not u69 then
        v7 = "Button2"
    else
        v7 = "Button1"
    end
    local v16 = u65:FindFirstChild(v7, true)
    if UserInputService.GamepadEnabled and v16 and v16:IsA("GuiButton") then
        GuiService.SelectedObject = v16
    end
    while not u10 do
        if not (peek(u9)) then
            break
        end
        task.wait()
    end
    task.wait(0.2)
    if UserInputService.GamepadEnabled and GuiService.SelectedObject == v16 then
        v6 = GuiService
        if not SelectedObject then
            v7 = nil
        elseif not SelectedObject.Parent then
            v7 = nil
        else
            v7 = SelectedObject
        end
        v6.SelectedObject = v7
    end
    u62 = nil
    v1:doCleanup()
end
local function worker() -- Line: 338 -- upvalues: BindableEvent (val), u61 (ref), MarauderLoading (val), NotifyController (val), show (val)
    local Lobby
    while true do
        BindableEvent.Event:Wait()
        while u61 do
            u61 = nil
            if workspace:GetAttribute("PlaceType") == "Lobby" then
                MarauderLoading.WaitUntilDismissed("Lobby")
                task.wait(0.35)
                NotifyController.WaitUntilIdle()
                if not u61 then
                    show(u61)
                end
            end
        end
    end
end
function v1.Start() -- Line: 357 -- upvalues: u60 (ref), ReplicatedStorage (val), scheduleRolloverCheck (val), u61 (ref), u62 (ref), BindableEvent (val), worker (val)
    if u60 then
        return
    end
    u60 = true
    ReplicatedStorage.common.Remotes:WaitForChild("DailyRewardRemote").OnClientEvent:Connect(function(p1) -- Line: 362 -- upvalues: scheduleRolloverCheck (upval), u61 (upval), u62 (upval), BindableEvent (upval)
        if type(p1) ~= "table" then
            return
        end
        scheduleRolloverCheck(p1)
        if p1.ShowPopup then
            u61 = p1
            if u62 then
                u62()
            end
            BindableEvent:Fire()
        end
    end)
    task.spawn(worker)
end
return v1