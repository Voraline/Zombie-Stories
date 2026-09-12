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
    local v1 = tonumber(p1)
    local v2 = math.floor(v1 or 0)
    local v3 = math.max(0, v2)
    local format = string.format
    v1 = v3 / 3600
    local v4 = math.floor(v1)
    local v5 = v3 % 3600 / 60
    return format("%02d:%02d:%02d", v4, math.floor(v5), v3 % 60)
end

local function scheduleRolloverCheck(p1) -- Line: 35 -- upvalues: u71 (ref), ReplicatedStorage (val)
    u71 = u71 + 1
    local u3 = u71
    local SecondsUntilNext = p1.SecondsUntilNext
    local v1 = tonumber(SecondsUntilNext)
    local v2 = math.floor(v1 or 0)
    local v3 = math.max(0, v2)
    if p1.Claimable == true and not (v3 <= 0) then
        task.delay(v3, function() -- Line: 42 -- upvalues: u3 (val), u71 (upval), ReplicatedStorage (upval)
            if u3 ~= u71 then
                return
            end
            pcall(function() -- Line: 46 -- upvalues: ReplicatedStorage (upval)
                ReplicatedStorage.common.Remotes.DataRemote:InvokeServer("CheckDaily")
            end)
        end)
        return
    end
end

local function makeTile(p1, p2, p3, p4) -- Line: 52 -- upvalues: Theme (val), UIKit (val)
    local Accent, AccentCyan, Accent_2, Selected, Thick, v1, v2, v3, v4
    local v5 = p1:innerScope()
    local v6 = p3 == p2.DayIndex
    local v7 = p3 <= (p2.CompletedDays or 0)
    local v8 = v6
    if v8 then
        v8 = p2.Claimable == true
    end
    local v9 = (p2.Week - 1) * 7 + p3
    if v6 then
        Accent = Theme.Menu.Accent
    elseif not (p2.DayIndex < p3) then
        Accent = Theme.Menu.Border
    else
        Accent = Theme.Menu.BorderUnselected
    end
    local Card = UIKit.Card
    local v10 = {StrokeTransparency = 0, scope = v5, Name = "Day" .. p3, Size = UDim2.fromOffset(108, 148)}
    if not v6 then
        Selected = Theme.Menu.Panel
    else
        Selected = Theme.Menu.Selected
    end
    v10.BackgroundColor3 = Selected
    v10.StrokeColor3 = Accent
    if not v6 then
        Thick = Theme.Stroke.Medium
    else
        Thick = Theme.Stroke.Thick
    end
    v10.StrokeThickness = Thick
    v10.ZIndex = Theme.ZIndex.Modal + 2
    local v11 = {}
    local v12 = v5:New("UIScale")
    local v13 = {}
    if not v6 then
        v1 = 1
    else
        v1 = 1.08
    end
    v13.Scale = v1
    v12 = v12(v13)
    v13 = v5:New("TextLabel")
    v1 = {
        Name = "DayLabel",
        BackgroundTransparency = 1,
        TextSize = 13,
        Position = UDim2.fromOffset(4, 6),
        Size = UDim2.new(1, -8, 0, 18),
    }
    if not v6 then
        v2 = "DAY " .. v9
    else
        v2 = "TODAY"
    end
    v1.Text = v2
    v1.Font = Theme.Menu.Fonts.Header
    if not v6 then
        Accent_2 = Theme.Menu.TextMuted
    else
        Accent_2 = Theme.Menu.Accent
    end
    v1.TextColor3 = Accent_2
    v1.ZIndex = Theme.ZIndex.Modal + 3
    v13 = v13(v1)
    v1 = v5:New("ImageLabel")({
        Name = "RewardImage",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 28),
        Size = UDim2.fromOffset(72, 72),
        Image = p4.ImageId or "",
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = Theme.ZIndex.Modal + 3,
    })
    v2 = v5:New("TextLabel")
    local v14 = {
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
    v14.TextColor3 = AccentCyan
    if p4.Kind ~= "Crate" then
        v3 = 16
    else
        v3 = 12
    end
    v14.TextSize = v3
    v14.ZIndex = Theme.ZIndex.Modal + 3
    v2 = v2(v14)
    v14 = v5:New("Frame")
    v3 = {
        Name = "Claimed",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.55,
        Visible = v7,
        ZIndex = Theme.ZIndex.Modal + 4,
    }
    local Children = v5.Children
    local v15 = {}
    local v16 = v5:New("ImageLabel")
    local v17 = {
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
    v17.ImageTransparency = v4
    v17.ZIndex = Theme.ZIndex.Modal + 5
    local Children_2 = v5.Children
    v17[Children_2] = {v5:New("UIScale")({Name = "ClaimScale", Scale = 1})}
    v15[1] = v16(v17)
    v3[Children] = v15
    v11[1] = v12
    v11[2] = v13
    v11[3] = v1
    v11[4] = v2
    v11[5] = v14(v3)
    v10.Children = v11
    return Card(v10)
end

local function buildRewardLayout(p1, p2, p3, p4) -- Line: 137 -- upvalues: makeTile (val)
    local Horizontal, v1, v2, v3
    local v4 = {}
    local v5 = ipairs
    local Rewards = p2.Rewards
    if not Rewards then
        Rewards = {}
    end
    for i, v in v5(Rewards) do
        v2 = makeTile
        v2 = v2(p1, p2, i, v)
        table.insert(v4, v2)
    end
    v5 = p1:New("Frame")
    local v6 = {}
    if not p3 then
        v3 = "RewardStrip"
    else
        v3 = "RewardGrid"
    end
    v6.Name = v3
    v6.Size = p1:Computed(function(p1) -- Line: 144 -- upvalues: p4 (val), p3 (val)
        local v1
        local new = UDim2.new
        if not p1(p4) then
            v1 = 0
        elseif not p3 then
            v1 = 168
        else
            v1 = 326
        end
        return new(1, 0, 0, v1)
    end)
    v6.BackgroundTransparency = 1
    v6.Visible = p4
    local Children = p1.Children
    local v7 = {}
    if not p3 then
        v1 = "UIListLayout"
    else
        v1 = "UIGridLayout"
    end
    local v8 = p1:New(v1)
    local v9 = {}
    if not p3 then
        v1 = nil
    else
        v1 = UDim2.fromOffset(108, 148)
    end
    v9.CellSize = v1
    if not p3 then
        v1 = nil
    else
        v1 = UDim2.fromOffset(10, 10)
    end
    v9.CellPadding = v1
    if not p3 then
        Horizontal = Enum.FillDirection.Horizontal
    else
        Horizontal = Enum.FillDirection.Horizontal
    end
    v9.FillDirection = Horizontal
    v9.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v9.VerticalAlignment = Enum.VerticalAlignment.Center
    v9.SortOrder = Enum.SortOrder.LayoutOrder
    if not p3 then
        v1 = UDim.new(0, 10)
    else
        v1 = nil
    end
    v9.Padding = v1
    v8 = v8(v9)
    v7[1] = v8
    v7[2] = table.unpack(v4)
    v6[Children] = v7
    return v5(v6)
end

local function show(p1) -- Line: 164
    -- upvalues: Fusion (val), fusion_utils (val), UserInputService (val), GuiService (val), PlayerGui (val), u62 (ref)
    -- upvalues: peek (val), UIKit (val), Theme (val), buildRewardLayout (val), TweenService (val)
    local SelectedObject
    local v1 = Fusion.scoped(Fusion, fusion_utils)
    local u9 = v1:Value(true)
    local u10 = false
    local SecondsUntilNext = p1.SecondsUntilNext
    local v2 = tonumber(SecondsUntilNext)
    local v3 = math.floor(v2 or 0)
    local v4 = math.max(0, v3)
    local u22 = v1:Value(v4)
    local u25 = fusion_utils.useViewport()
    local u29 = v1:Computed(function(p1) -- Line: 170 -- upvalues: u25 (val)
        local v1 = p1(u25).X < 620
        return v1
    end)
    local v5 = v1:Computed(function(p1) -- Line: 173 -- upvalues: u25 (val), u29 (val)
        local v1, v2
        local v3 = p1(u25)
        if p1(u29) then
            v1 = v3.X / 480
            v2 = v3.Y / 600
            return (math.min(1, v1, v2))
        end
        v1 = v3.X / 1000
        v2 = v3.Y / 600
        return (math.min(1, v1, v2))
    end)
    local GamepadEnabled = UserInputService.GamepadEnabled
    local u38 = v1:Value(GamepadEnabled)
    if not UserInputService.GamepadEnabled then
        SelectedObject = nil
    else
        SelectedObject = GuiService.SelectedObject
    end
    local v6 = (UserInputService:GetPropertyChangedSignal("GamepadEnabled")):Connect(function() -- Line: 184 -- upvalues: u38 (val), UserInputService (upval)
        local v1 = u38
        local v2 = UserInputService
        local GamepadEnabled = v2.GamepadEnabled
        v1:set(GamepadEnabled)
    end)
    table.insert(v1, v6)
    local u65 = v1:New("ScreenGui")({
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
    local v7 = v1:Computed(function(p1) -- Line: 201 -- upvalues: u69 (val), u75 (val)
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
    local v8 = v1:Computed(function(p1) -- Line: 204 -- upvalues: u75 (val)
        return (p1(u75)) .. "CLOSE"
    end)

    local function close() -- Line: 208 -- upvalues: u10 (ref), u9 (val)
        u10 = true
        u9:set(false)
    end

    u62 = close
    task.spawn(function() -- Line: 213 -- upvalues: peek (upval), u9 (val), u22 (val)
        local v1, v2, v3, v4, v5
        while peek(u9) do
            if not (0 < (peek(u22))) then
                break
            end
            task.wait(1)
            v1 = u22
            v4 = peek
            v5 = u22
            v4 = v4(v5)
            v3 = v4 - 1
            v2 = math.max(0, v3)
            v1:set(v2)
        end
    end)
    local Modal = UIKit.Modal
    local v9 = {
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
        PanelScale = v5,
        Size = v1:Computed(function(p1) -- Line: 226 -- upvalues: u29 (val)
            local v1
            local fromOffset = UDim2.fromOffset
            if not p1(u29) then
                v1 = 860
            else
                v1 = 480
            end
            return fromOffset(v1, 0)
        end),
    }
    local AbsoluteDay = p1.AbsoluteDay
    if not AbsoluteDay then
        AbsoluteDay = p1.DayIndex
    end
    v9.Title = "DAILY REWARD — DAY " .. tostring(AbsoluteDay)
    v9.TextColor = Theme.Menu.TextMuted
    v9.ButtonSound = UIKit.UISounds.ClickSound
    local v10 = {}
    local v11 = v1:New("Frame")
    local v12 = {
        Name = "DailyContent",
        Size = v1:Computed(function(p1) -- Line: 240 -- upvalues: u29 (val)
            local v1
            local new = UDim2.new
            if not p1(u29) then
                v1 = 194
            else
                v1 = 352
            end
            return new(1, 0, 0, v1)
        end),
        BackgroundTransparency = 1,
    }
    local Children = v1.Children
    local v13 = {}
    local v14 = v1:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
    })
    local v15 = buildRewardLayout
    v15 = v15(v1, p1, false, v1:Computed(function(p1) -- Line: 255 -- upvalues: u29 (val)
        return not p1(u29)
    end))
    local v16 = buildRewardLayout(v1, p1, true, u29)
    local v17 = v1:New("TextLabel")
    local v18 = {
        Name = "NextReward",
        LayoutOrder = 4,
        BackgroundTransparency = 1,
        TextSize = 14,
        Size = UDim2.new(1, 0, 0, 18),
        Text = v1:Computed(function(p1) -- Line: 265 -- upvalues: u22 (val)
            local v1 = u22
            local v2 = p1(v1)
            local v3 = tonumber(v2)
            local v4 = math.floor(v3 or 0)
            v1 = math.max(0, v4)
            local format = string.format
            v3 = v1 / 3600
            local v5 = math.floor(v3)
            local v6 = v1 % 3600 / 60
            return "NEXT REWARD IN " .. format("%02d:%02d:%02d", v5, math.floor(v6), v1 % 60)
        end),
        Font = Theme.Menu.Fonts.Body,
        TextColor3 = Theme.Menu.TextMuted,
    }
    v13[1] = v14
    v13[2] = v15
    v13[3] = v16
    v13[4] = v17(v18)
    v12[Children] = v13
    v10[1] = v11(v12)
    v9.Children = v10
    v10 = {}
    v11 = {KeepOpen = true, Text = v7, Disabled = not u69}
    if not u69 then
        v12 = 270
    else
        v12 = 220
    end
    v11.Width = v12
    v11.Color = Theme.Menu.Positive
    v11.TextColor = Theme.Menu.Text
    v11.StrokeColor = Theme.Menu.NavigationColors.Play.Accent
    v11.BackgroundColor = Theme.Menu.NavigationColors.Play.Fill
    v11.GradientColor = Theme.Menu.NavigationColors.Play.Gradient

    function v11.OnClick() -- Line: 286
        -- upvalues: u69 (val), UIKit (upval), peek (upval), u29 (val), u65 (val), p1 (val), TweenService (upval)
        -- upvalues: close (val)
        local v1, v2, v3
        if not u69 then
            return
        end
        UIKit.UISounds.Reward()
        if not peek(u29) then
            v1 = "RewardStrip"
        else
            v1 = "RewardGrid"
        end
        local v4 = u65:FindFirstChild(v1, true)
        local v5 = v4
        if v5 then
            v3 = p1
            local DayIndex = v3.DayIndex
            v2 = "CheckmarkDay" .. tostring(DayIndex)
            v5 = v4:FindFirstChild(v2, true)
        end
        if v5 then
            v5.ImageTransparency = 1
            local ClaimScale = v5:FindFirstChild("ClaimScale")
            if ClaimScale then
                ClaimScale.Scale = 4
                v2 = TweenService
                v3 = TweenInfo.new(0.35, Enum.EasingStyle.Back)
                v2:Create(ClaimScale, v3, {Scale = 1}):Play()
            end
            v2 = TweenService
            v3 = TweenInfo.new(0.25)
            v2:Create(v5, v3, {ImageTransparency = 0}):Play()
        end
        task.delay(0.9, close)
    end

    if u69 then
        v12 = nil
    else
        v12 = {Width = 120}
        v12.Text = v8
        v12.Color = Theme.Colors.CloseButton
        v12.TextColor = Theme.Menu.Text
        v12.StrokeColor = Theme.Menu.NavigationColors.Cancel.Accent
        v12.BackgroundColor = Theme.Menu.NavigationColors.Cancel.Fill
        v12.GradientColor = Theme.Menu.NavigationColors.Cancel.Gradient
        v12.OnClick = close
    end
    v10[1] = v11
    v10[2] = v12
    v9.Buttons = v10
    Modal(v9)
    if not u69 then
        v10 = "Button2"
    else
        v10 = "Button1"
    end
    local v19 = u65:FindFirstChild(v10, true)
    if UserInputService.GamepadEnabled and v19 and v19:IsA("GuiButton") then
        GuiService.SelectedObject = v19
    end
    while not u10 do
        if not peek(u9) then
            break
        end
        task.wait()
    end
    task.wait(0.2)
    if UserInputService.GamepadEnabled and GuiService.SelectedObject == v19 then
        v9 = GuiService
        if not SelectedObject or not SelectedObject.Parent then
            v10 = nil
        else
            v10 = SelectedObject
        end
        v9.SelectedObject = v10
    end
    u62 = nil
    v1:doCleanup()
end

local function worker() -- Line: 338
    -- upvalues: BindableEvent (val), u61 (ref), MarauderLoading (val), NotifyController (val), show (val)
    local v1
    while true do
        BindableEvent.Event:Wait()
        while u61 do
            v1 = u61
            u61 = nil
            if workspace:GetAttribute("PlaceType") == "Lobby" then
                MarauderLoading.WaitUntilDismissed("Lobby")
                task.wait(0.35)
                NotifyController.WaitUntilIdle()
                if not u61 then
                    show(v1)
                end
            end
        end
    end
end

function v1.Start() -- Line: 357
    -- upvalues: u60 (ref), ReplicatedStorage (val), scheduleRolloverCheck (val), u61 (ref), u62 (ref)
    -- upvalues: BindableEvent (val), worker (val)
    if u60 then
        return
    end
    u60 = true
    ;(ReplicatedStorage.common.Remotes:WaitForChild("DailyRewardRemote")).OnClientEvent:Connect(function(p1) -- Line: 362 -- upvalues: scheduleRolloverCheck (upval), u61 (upval), u62 (upval), BindableEvent (upval)
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