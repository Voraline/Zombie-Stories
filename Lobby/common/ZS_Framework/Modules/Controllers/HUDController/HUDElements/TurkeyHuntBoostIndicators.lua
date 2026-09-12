local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Fusion = require(ReplicatedStorage.Packages.Fusion)
require("@game/ReplicatedStorage/common/HUDService")
local scoped = Fusion.scoped
local peek = Fusion.peek
local u30 = {Live = true}
local v1 = {}
local u33 = nil
local u34 = nil
local u35 = nil
local u36 = nil
local u37 = nil
local u38 = nil
local u39 = nil
local u40 = false
local u41 = nil
local u42 = {}
local u43 = 0

local function formatTime(p1) -- Line: 56
    local v1 = math.ceil(p1 or 0)
    local v2 = math.max(0, v1)
    return string.format("%ds", v2)
end

local function isTurkeyHuntActive() -- Line: 61 -- upvalues: Workspace (val), u30 (val)
    local Attribute = Workspace:GetAttribute("TurkeyHuntState")
    local v1 = Attribute
    if v1 then
        v1 = u30[Attribute] == true
    end
    return v1
end

local function updateBoostStates() -- Line: 66
    -- upvalues: u35 (ref), Workspace (val), u30 (val), u36 (ref), u37 (ref), formatTime (val), LocalPlayer (val)
    -- upvalues: u38 (ref), u39 (ref), peek (val)
    local v1, v2
    if not u35 then
        return
    end
    local Attribute = Workspace:GetAttribute("TurkeyHuntState")
    local v3 = Attribute
    if v3 then
        v3 = u30[Attribute] == true
    end
    local v4 = v3
    if v4 then
        v4 = Workspace:GetAttribute("TurkeyHuntInstantKill") == true
    end
    u36:set(v4)
    if not v4 then
        u37:set("0s")
    else
        local v5 = u37
        v1 = formatTime
        local Attribute_2 = Workspace:GetAttribute("TurkeyHuntInstantKillTimeLeft")
        v1 = v1(Attribute_2)
        v5:set(v1)
    end
    local Attribute_3 = LocalPlayer
    if Attribute_3 then
        Attribute_3 = LocalPlayer:GetAttribute("TurkeyHuntWalkSpeedBoostExpires")
    end
    local v6 = 0
    if typeof(Attribute_3) == "number" then
        if not Workspace.GetServerTimeNow then
            v1 = os.clock()
        else
            v1 = Workspace:GetServerTimeNow()
        end
        v6 = Attribute_3 - v1
    end
    v1 = v3
    if v1 then
        v1 = 0 < v6
    end
    u38:set(v1)
    if not v1 then
        u39:set("0s")
    else
        v2 = u39
        local v7 = formatTime
        v7 = v7(v6)
        v2:set(v7)
    end
    v2 = v3
    if v2 then
        v2 = peek(u36)
        if not v2 then
            v2 = peek(u38)
        end
    end
    u35:set(v2)
end

local function createIconElement(p1) -- Line: 104 -- upvalues: u33 (ref), Fusion (val)
    local v1 = u33:New("Frame")
    local v2 = {
        Name = p1.Name,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(48, 48),
        Visible = p1.VisibleState,
    }
    local v3 = Fusion
    local Children = v3.Children
    local v4 = {}
    local v5 = u33:New("ImageLabel")({
        Name = "Icon",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Image = p1.Image,
        Size = UDim2.fromScale(1, 1),
    })
    local v6 = u33:New("TextLabel")
    local v7 = {
        Name = "Timer",
        BackgroundTransparency = 0.35,
        TextScaled = true,
        ZIndex = 3,
        TextStrokeTransparency = 0.5,
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamBold,
        Size = UDim2.new(0.85, 0, 0.35, 0),
        Position = UDim2.new(0.5, 0, 1, 0),
        Visible = p1.VisibleState,
        Text = p1.TextState,
    }
    v4[1] = v5
    v4[2] = v6(v7)
    v2[Children] = v4
    return v1(v2)
end

local function initialize() -- Line: 138
    -- upvalues: u40 (ref), u33 (ref), scoped (val), Fusion (val), u36 (ref), u37 (ref), u38 (ref), u39 (ref), u35 (ref)
    -- upvalues: LocalPlayer (val), u34 (ref), createIconElement (val), u42 (val), Workspace (val)
    -- upvalues: updateBoostStates (val), u41 (ref), RunService (val), u43 (ref)
    if u40 then
        return
    end
    u33 = scoped(Fusion)
    u36 = u33:Value(false)
    u37 = u33:Value("0s")
    u38 = u33:Value(false)
    u39 = u33:Value("0s")
    u35 = u33:Value(false)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    u34 = u33:New("ScreenGui")({
        Name = "TurkeyHuntBoostIndicators",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 5,
        Parent = PlayerGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    local v1 = u33:New("Frame")
    local v2 = {
        Name = "BoostContainer",
        Parent = u34,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 150),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.fromOffset(48, 48),
        Visible = u35,
        ZIndex = 10,
    }
    local v3 = Fusion
    local Children = v3.Children
    local v4 = {}
    local v5 = u33:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v6 = createIconElement
    v6 = v6({Name = "InstaKillIcon", Image = "rbxassetid://79847861071198", VisibleState = u36, TextState = u37})
    local v7 = createIconElement
    v4[1] = v5
    v4[2] = v6
    v4[3] = v7({Name = "WalkSpeedIcon", Image = "rbxassetid://14549056586", VisibleState = u38, TextState = u39})
    v2[Children] = v4
    v1(v2)
    v2 = u42
    v3 = (Workspace:GetAttributeChangedSignal("TurkeyHuntState")):Connect(function() -- Line: 194 -- upvalues: updateBoostStates (upval)
        updateBoostStates()
    end)
    table.insert(v2, v3)
    v2 = u42
    v3 = (Workspace:GetAttributeChangedSignal("TurkeyHuntInstantKill")):Connect(function() -- Line: 197 -- upvalues: updateBoostStates (upval)
        updateBoostStates()
    end)
    table.insert(v2, v3)
    v2 = u42
    v3 = (Workspace:GetAttributeChangedSignal("TurkeyHuntInstantKillTimeLeft")):Connect(function() -- Line: 200 -- upvalues: updateBoostStates (upval)
        updateBoostStates()
    end)
    table.insert(v2, v3)
    if LocalPlayer then
        v2 = u42
        v3 = (LocalPlayer:GetAttributeChangedSignal("TurkeyHuntWalkSpeedBoostExpires")):Connect(function() -- Line: 204 -- upvalues: updateBoostStates (upval)
            updateBoostStates()
        end)
        table.insert(v2, v3)
    end
    v1 = RunService
    u41 = v1.Heartbeat:Connect(function(p1) -- Line: 209 -- upvalues: u43 (upval), updateBoostStates (upval)
        u43 = u43 + p1
        if 0.15 <= u43 then
            u43 = 0
            updateBoostStates()
        end
    end)
    updateBoostStates()
    u40 = true
end

function v1.Show(p1) -- Line: 222 -- upvalues: u40 (ref), initialize (val), updateBoostStates (val)
    if not u40 then
        initialize()
        return
    end
    updateBoostStates()
end

function v1.Hide(p1) -- Line: 230 -- upvalues: u35 (ref)
    if u35 then
        u35:set(false)
    end
end

return v1