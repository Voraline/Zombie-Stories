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
local v1 = {Instakill = "rbxassetid://79847861071198", WalkSpeed = "rbxassetid://14549056586"}
local v2 = {}
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
    local v1 = math.max(0, (math.ceil(p1 or 0)))
    return string.format("%ds", v1)
end
local function isTurkeyHuntActive() -- Line: 61 -- upvalues: Workspace (val), u30 (val)
    local Attribute = Workspace:GetAttribute("TurkeyHuntState")
    local v1 = Attribute
    if v1 then
        v1 = u30[Attribute] == true
    end
    return v1
end
local function updateBoostStates() -- Line: 66 -- upvalues: u35 (ref), Workspace (val), u30 (val), u36 (ref), u37 (ref), formatTime (val), LocalPlayer (val), u38 (ref), u39 (ref), peek (val)
    local v1
    if not u35 then
        return
    end
    local Attribute = Workspace:GetAttribute("TurkeyHuntState")
    local v2 = Attribute
    if v2 then
        v2 = u30[Attribute] == true
    end
    local v3 = v2
    if v3 then
        v3 = Workspace:GetAttribute("TurkeyHuntInstantKill") == true
    end
    u36:set(v3)
    if not v3 then
        u37:set("0s")
    else
        u37:set(formatTime(Workspace:GetAttribute("TurkeyHuntInstantKillTimeLeft")))
    end
    local Attribute_2 = LocalPlayer
    if Attribute_2 then
        Attribute_2 = LocalPlayer:GetAttribute("TurkeyHuntWalkSpeedBoostExpires")
    end
    local v4 = 0
    if typeof(Attribute_2) == "number" then
        if not Workspace.GetServerTimeNow then
            v1 = os.clock()
        else
            v1 = Workspace:GetServerTimeNow()
        end
        v4 = Attribute_2 - v1
    end
    v1 = v2
    if v1 then
        v1 = 0 < v4
    end
    u38:set(v1)
    if not v1 then
        u39:set("0s")
    else
        u39:set(formatTime(v4))
    end
    local v5 = v2
    if v5 then
        v5 = peek(u36)
        if not v5 then
            v5 = peek(u38)
        end
    end
    u35:set(v5)
end
local function createIconElement(p1) -- Line: 104 -- upvalues: u33 (ref), Fusion (val)
    local v1 = u33:New("Frame")
    local v2 = {Name = p1.Name, BackgroundTransparency = 1, Size = UDim2.fromOffset(48, 48), Visible = p1.VisibleState}
    local v3 = {}
    local v4 = u33:New("ImageLabel")
    v4 = v4({
        Name = "Icon",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Image = p1.Image,
        Size = UDim2.fromScale(1, 1),
    })
    local v5 = u33:New("TextLabel")
    local v6 = {
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
    v3[1] = v4
    v3[2] = v5(v6)
    v2[Fusion.Children] = v3
    return v1(v2)
end
local function initialize() -- Line: 138 -- upvalues: u40 (ref), u33 (ref), scoped (val), Fusion (val), u36 (ref), u37 (ref), u38 (ref), u39 (ref), u35 (ref), LocalPlayer (val), u34 (ref), createIconElement (val), u42 (val), Workspace (val), updateBoostStates (val), u41 (ref), RunService (val), u43 (ref)
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
    local v1 = u33:New("ScreenGui")
    u34 = v1({
        Name = "TurkeyHuntBoostIndicators",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 5,
        Parent = PlayerGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    v1 = u33:New("Frame")
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
    local v3 = {}
    local v4 = u33:New("UIListLayout")
    v4 = v4({
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v5 = createIconElement({Name = "InstaKillIcon", Image = "rbxassetid://79847861071198", VisibleState = u36, TextState = u37})
    v3[1] = v4
    v3[2] = v5
    v3[3] = createIconElement({Name = "WalkSpeedIcon", Image = "rbxassetid://14549056586", VisibleState = u38, TextState = u39})
    v2[Fusion.Children] = v3
    v1(v2)
    local AttributeChangedSignal = Workspace:GetAttributeChangedSignal("TurkeyHuntState")
    table.insert(u42, AttributeChangedSignal:Connect(function() -- Line: 194 -- upvalues: updateBoostStates (upval)
        updateBoostStates()
    end))
    local AttributeChangedSignal_2 = Workspace:GetAttributeChangedSignal("TurkeyHuntInstantKill")
    table.insert(u42, AttributeChangedSignal_2:Connect(function() -- Line: 197 -- upvalues: updateBoostStates (upval)
        updateBoostStates()
    end))
    local AttributeChangedSignal_3 = Workspace:GetAttributeChangedSignal("TurkeyHuntInstantKillTimeLeft")
    table.insert(u42, AttributeChangedSignal_3:Connect(function() -- Line: 200 -- upvalues: updateBoostStates (upval)
        updateBoostStates()
    end))
    if LocalPlayer then
        local AttributeChangedSignal_4 = LocalPlayer:GetAttributeChangedSignal("TurkeyHuntWalkSpeedBoostExpires")
        table.insert(u42, AttributeChangedSignal_4:Connect(function() -- Line: 204 -- upvalues: updateBoostStates (upval)
            updateBoostStates()
        end))
    end
    u41 = RunService.Heartbeat:Connect(function(p1) -- Line: 209 -- upvalues: u43 (upval), updateBoostStates (upval)
        u43 = u43 + p1
        if 0.15 <= u43 then
            u43 = 0
            updateBoostStates()
        end
    end)
    updateBoostStates()
    u40 = true
end
function v2.Show(p1) -- Line: 222 -- upvalues: u40 (ref), initialize (val), updateBoostStates (val)
    if not u40 then
        initialize()
        return
    end
    updateBoostStates()
end
function v2.Hide(p1) -- Line: 230 -- upvalues: u35 (ref)
    if u35 then
        u35:set(false)
    end
end
return v2