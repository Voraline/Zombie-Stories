local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local v1 = require("../../Data/PlayerDatabase")
local u15 = require("../Components/AnnouncementToast")
local v2 = require("@game/ReplicatedStorage/common/zap")
local u19 = {}
local u22 = Fusion.scoped(Fusion)
local v3 = u22:New("Frame")
local v4 = {
    Name = "ToastContainer",
    Size = UDim2.new(0.42, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    Position = UDim2.new(0.5, 0, 0, 56),
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}
local v5 = {}
local v6 = u22:New("UISizeConstraint")
v6 = v6({MinSize = Vector2.new(300, 0), MaxSize = Vector2.new(520, 10000)})
local v7 = u22:New("UIListLayout")
local v8 = {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)}
v5[1] = v6
v5[2] = v7(v8)
v4[Children] = v5
local u76 = v3(v4)
v4 = u22:New("ScreenGui")
v5 = {
    Name = "AdminAnnouncements",
    Parent = v1.PlayerGui,
    DisplayOrder = 50,
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
}
v5[Children] = {u76}
v4(v5)
local u90 = {}
local u91 = 0
local function removeActive(p1) -- Line: 69 -- upvalues: u90 (val)
    local v1 = u90
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j == p1 then
            table.remove(u90, i)
            return
        end
    end
end
local function dismiss(p1) -- Line: 78 -- upvalues: removeActive (val)
    if p1.closing then
        return
    end
    p1.closing = true
    removeActive(p1)
    p1.transparency:set(1)
    task.delay(0.35, function() -- Line: 87 -- upvalues: p1 (val)
        p1.scope:doCleanup()
    end)
end
function u19.Push(p1) -- Line: 92 -- upvalues: u90 (val), dismiss (val), u91 (ref), u22 (val), u15 (val), u76 (val)
    local v1
    if type(p1) ~= "table" or type(p1.userId) ~= "number" or type(p1.username) ~= "string" or type(p1.message) ~= "string" then
        return
    end
    while true do
        v1 = #u90
        if 3 > v1 then
            break
        end
        dismiss(u90[1])
    end
    u91 = u91 + 1
    v1 = u22:innerScope()
    local u26 = {closing = false, scope = v1, transparency = v1:Value(1)}
    table.insert(u90, u26)
    local v2 = {
        scope = v1,
        UserId = p1.userId,
        Username = p1.username,
        Message = p1.message,
        Transparency = u26.transparency,
        LayoutOrder = u91,
    }
    local v3 = u15(v2)
    v3.Parent = u76
    task.defer(function() -- Line: 123 -- upvalues: u26 (val)
        if not u26.closing then
            u26.transparency:set(0)
        end
    end)
    if type(p1.duration) ~= "number" then
        v2 = 8
    else
        v2 = math.clamp(p1.duration, 3, 30)
    end
    task.delay(v2, function() -- Line: 132 -- upvalues: dismiss (upval), u26 (val)
        dismiss(u26)
    end)
end
v2.AdminAnnouncement.On(function(p1) -- Line: 137 -- upvalues: u19 (val)
    u19.Push(p1)
end)
return u19