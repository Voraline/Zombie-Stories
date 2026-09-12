local v1
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
game:GetService("UserInputService")
local Players = game:GetService("Players")
local common = game.ReplicatedStorage.common
local Packages = game.ReplicatedStorage.Packages
local RedEvents = game.ReplicatedStorage.common.RedEvents
local PromptUI = script.PromptUI
local Complete = PromptUI.Complete
local PromptGroup = PromptUI.PromptGroup
local NoProgressFrame = PromptGroup.NoProgressFrame
local ProgressSliceFrame = PromptGroup.ProgressSliceFrame
local ProgressFrame = ProgressSliceFrame.ProgressFrame
local Button = PromptUI.Button
local InputFrame = ProgressFrame.InputFrame
local InputFrame_2 = NoProgressFrame.InputFrame
local Highlight = Instance.new("Highlight")
local Signal = require(common.Signal)
local Streamable = require(Packages.Streamable).Streamable
local v2 = nil
local v3 = nil
local u83 = nil
local u87 = nil
if not RunService:IsServer() then
    v2 = require(common.BindUtil)
    v3 = require(common.InputLabel)
    u83 = require(Packages.Fusion)
    u87 = require("@game/ReplicatedStorage/common/skillTree/SkillTreeData")
    task.spawn(function() -- Line: 40 -- upvalues: Highlight (val)
        Highlight.FillTransparency = 1
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end)
end
local ReplicateProximityPrompt = require(RedEvents.General.ReplicateProximityPrompt)
local u99 = RunService:IsServer()
local u100 = 0.15
local u101 = 0.05
local u102 = 0
local u103 = 0
local u104 = false
local u105 = false
local u106 = {}
local u107 = {}
local u108 = {}
local u109 = ""
local u110 = ""
local u111 = false
local u112 = nil
local u113 = true
local u114 = {}
local v4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u127 = TweenService:Create(Complete, v4, {BackgroundTransparency = 1})
local u128 = {
    Position = true,
    Part = true,
    Range = true,
    Obstructable = true,
    ObstructionIgnoreList = true,
    HoldTime = true,
    ResetOnRelease = true,
    ActionText = true,
    ObjectText = true,
    Enabled = true,
    Players = true,
}
local u129 = {openedPrompt = nil}

local function isInteractionSuppressed() -- Line: 210 -- upvalues: u114 (val)
    local v1 = next(u114) ~= nil
    return v1
end

function u129.__index(p1, p2) -- Line: 216 -- upvalues: u128 (val), u129 (val)
    local v1 = rawget(p1, p2)
    if u128[p2] then
        return rawget(p1, "Properties")[p2]
    end
    if v1 ~= nil then
        return v1
    end
    return u129[p2]
end

function u129.__newindex(p1, p2, p3) -- Line: 228 -- upvalues: u128 (val), u129 (val)
    local v1 = rawget(p1, p2)
    if u128[p2] then
        p1:_SetProperty(p2, p3)
        return p1
    end
    if v1 ~= nil then
        p1[p2] = p3
        return p1
    end
    u129[p2] = p3
    return p1
end

function u129.new(p1, p2) -- Line: 246
    -- upvalues: HttpService (val), u99 (val), Signal (val), u106 (val), CollectionService (val)
    -- upvalues: ReplicateProximityPrompt (val), u107 (val), u129 (val)
    local Enabled, Obstructable, ResetOnRelease, v1
    if not p2 then
        v1 = HttpService:GenerateGUID(false)
    else
        v1 = p2
    end
    local v2 = p1 ~= nil
    assert(v2, "Must pass a property table")
    v2 = true
    if p1.Position == nil then
        v2 = true
        if p1.Part == nil then
            v2 = not u99
        end
    end
    assert(v2, "Must pass either a Part or a Position")
    v2 = false
    if p1.ActionText ~= nil then
        v2 = p1.ObjectText ~= nil
    end
    assert(v2, "Must pass ActionText and ObjectText")
    if p1.Part then
        v2 = false
        local Part = p1.Part
        if typeof(Part) == "Instance" then
            v2 = p1.Part:IsA("BasePart")
        end
        assert(v2, "Part must be a BasePart")
    end
    if p1.Position then
        local Position = p1.Position
        v2 = typeof(Position) == "Vector3"
        assert(v2, "Position must be of type Vector3")
    elseif not u99 and not p1.Part then
        p1.Part = getUnreplicatedPart(v1)
    end
    local v3 = {Position = p1.Position, Part = p1.Part, Range = p1.Range or 4}
    if p1.Obstructable == nil then
        Obstructable = true
    else
        Obstructable = p1.Obstructable
    end
    v3.Obstructable = Obstructable
    v3.ObstructionIgnoreList = p1.ObstructionIgnoreList
    v3.HoldTime = p1.HoldTime or 0.75
    if p1.ResetOnRelease == nil then
        ResetOnRelease = false
    else
        ResetOnRelease = p1.ResetOnRelease
    end
    v3.ResetOnRelease = ResetOnRelease
    v3.ActionText = p1.ActionText
    v3.ObjectText = p1.ObjectText
    if p1.Enabled == nil then
        Enabled = true
    else
        Enabled = p1.Enabled
    end
    v3.Enabled = Enabled
    v3.Players = p1.Players
    local u105 = {}
    u105._Identifier = v1
    u105.Properties = v3
    local v4 = not u99
    if v4 then
        v4 = p1.LocalOnly == true
    end
    u105._IsLocal = v4
    u105.Triggered = Signal.new()
    u105.InteractBegan = Signal.new()
    u105.InteractEnded = Signal.new()
    u106[u105._Identifier] = u105
    if u99 then
        if v3.Part then
            v4 = CollectionService
            local Part_2 = v3.Part
            v4:AddTag(Part_2, v1)
        end
        v4 = {Type = "Add", Identifier = u105._Identifier, PropertyTable = v3}
        if not v3.Players then
            ReplicateProximityPrompt:FireAllClients(v4)
        else
            local v5 = ReplicateProximityPrompt
            local Players = v3.Players
            v5:FireClients(Players, v4)
        end
        u107[v1] = v4
    end
    if not u99 and not u105._IsLocal then
        u105.Triggered:Connect(function() -- Line: 319 -- upvalues: ReplicateProximityPrompt (upval), u105 (val)
            local v1 = ReplicateProximityPrompt
            local v2 = {Type = "Triggered", Identifier = u105._Identifier}
            v1:FireServer(v2)
        end)
        u105.InteractBegan:Connect(function() -- Line: 326 -- upvalues: ReplicateProximityPrompt (upval), u105 (val)
            local v1 = ReplicateProximityPrompt
            local v2 = {Type = "InteractBegin", Identifier = u105._Identifier}
            v1:FireServer(v2)
        end)
        u105.InteractEnded:Connect(function() -- Line: 333 -- upvalues: ReplicateProximityPrompt (upval), u105 (val)
            local v1 = ReplicateProximityPrompt
            local v2 = {Type = "InteractEnd", Identifier = u105._Identifier}
            v1:FireServer(v2)
        end)
    end
    local v6 = u129
    return (setmetatable(u105, v6))
end

function u129:Destroy() -- Line: 345 -- upvalues: u99 (val), ReplicateProximityPrompt (val), u107 (val), u106 (val)
    self.Triggered:DisconnectAll()
    self.InteractBegan:DisconnectAll()
    self.InteractEnded:DisconnectAll()
    if u99 then
        local v1 = ReplicateProximityPrompt
        local v2 = {Type = "Destroy", Identifier = self._Identifier}
        v1:FireAllClients(v2)
        u107[self._Identifier] = nil
    end
    u106[self._Identifier] = nil
end

function u129.GetPromptByIdentifier(p1, p2) -- Line: 363 -- upvalues: u106 (val)
    return u106[p2]
end

function u129:_SetProperty(p2, p3) -- Line: 367
    -- upvalues: u128 (val), u99 (val), ReplicateProximityPrompt (val), u129 (val)
    if u128[p2] then
        self.Properties[p2] = p3
        if u99 then
            local v1 = {Type = "PropertyChanged", Identifier = self._Identifier, Index = p2, Value = p3}
            if self.Properties.Players == nil then
                ReplicateProximityPrompt:FireAllClients(v1)
                return
            end
            local v2 = ReplicateProximityPrompt
            local Players = self.Properties.Players
            v2:FireClients(Players, v1)
            return
        end
        if p2 ~= "ActionText" and p2 ~= "ObjectText" then
            if p2 == "Part" and not p3 then
                self.Properties[p2] = (getUnreplicatedPart(self._Identifier))
            end
            return
        end
        if u129.openedPrompt == self then
            setText(self.ActionText, self.ObjectText)
            return
        end
    end
end

function easeOutQuad(p1) -- Line: 398
    return 1 - (1 - p1) * (1 - p1)
end

function doComplete() -- Line: 402 -- upvalues: Complete (val), NoProgressFrame (val), u127 (val)
    Complete.BackgroundTransparency = 0
    Complete.Size = UDim2.new(0, NoProgressFrame.AbsoluteSize.X, 0, NoProgressFrame.AbsoluteSize.Y)
    Complete.Visible = true
    local v1 = Complete
    local v2 = UDim2.new(0, NoProgressFrame.AbsoluteSize.X * 1.5, 0, NoProgressFrame.AbsoluteSize.Y * 1.5)
    v1:TweenSize(v2, "Out", "Quad", 0.15, true)
    u127:Play()
end

u127.Completed:Connect(function(p1) -- Line: 423 -- upvalues: Complete (val)
    if p1 == Enum.PlaybackState.Completed then
        Complete.Visible = false
    end
end)

function setProgress(p1) -- Line: 429 -- upvalues: u103 (ref), u100 (ref), PromptUI (val), ProgressSliceFrame (val)
    u103 = p1
    local v1 = u100 * PromptUI.AbsoluteSize.Y * p1
    ProgressSliceFrame.Size = UDim2.new(0, v1, 1, 0)
end

function updateWidth(p1) -- Line: 435
    -- upvalues: PromptUI (val), u100 (ref), PromptGroup (val), u101 (ref), ProgressFrame (val), Button (val)
    -- upvalues: u103 (ref)
    local AbsoluteSize = PromptUI.AbsoluteSize
    u100 = p1
    local v1 = PromptGroup
    local v2 = UDim2.new(p1, 0, u101, 0)
    local Out = Enum.EasingDirection.Out
    local Quad = Enum.EasingStyle.Quad
    v1:TweenSize(v2, Out, Quad, 0.5, true)
    v1 = ProgressFrame
    v1.Size = UDim2.new(0, p1 * PromptUI.AbsoluteSize.Y, 1, 0)
    v1 = Button
    v1.Size = UDim2.new(p1 * 1.5, 0, u101 * 2, 0)
    setProgress(u103)
end

function updateScaleWidth() -- Line: 452 -- upvalues: u102 (ref), u101 (ref), NoProgressFrame (val), ProgressFrame (val)
    local function updateText(p1) -- Line: 453 -- upvalues: u102 (upval), u101 (upval)
        local v1 = UDim2.new(u102 / u101, 0, 1, 0)
        local Out = Enum.EasingDirection.Out
        local Quad = Enum.EasingStyle.Quad
        p1:TweenSize(v1, Out, Quad, 0.5, true)
    end

    local v1 = NoProgressFrame
    local TextFrame = v1.TextFrame
    local v2 = UDim2.new(u102 / u101, 0, 1, 0)
    local Out = Enum.EasingDirection.Out
    local Quad = Enum.EasingStyle.Quad
    TextFrame:TweenSize(v2, Out, Quad, 0.5, true)
    v1 = ProgressFrame
    local TextFrame_2 = v1.TextFrame
    v2 = UDim2.new(u102 / u101, 0, 1, 0)
    local Out_2 = Enum.EasingDirection.Out
    local Quad_2 = Enum.EasingStyle.Quad
    TextFrame_2:TweenSize(v2, Out_2, Quad_2, 0.5, true)
    updateWidth(u102 + u101)
end

function updateTextScaleWidth() -- Line: 469
    -- upvalues: PromptGroup (val), u100 (ref), u101 (ref), PromptUI (val), NoProgressFrame (val), TextService (val)
    -- upvalues: u109 (ref), u110 (ref), u102 (ref)
    PromptGroup.Size = UDim2.new(u100, 0, u101, 0)
    local v1 = PromptUI
    local AbsoluteSize = v1.AbsoluteSize
    local Y = NoProgressFrame.TextFrame.HeaderLabel.TextBounds.Y
    local Y_2 = NoProgressFrame.TextFrame.TextLabel.TextBounds.Y
    local Font = NoProgressFrame.TextFrame.HeaderLabel.Font
    local v2 = TextService
    local v3 = u109
    local v4 = Vector2.new((1 / 0), Y)
    local X = (v2:GetTextSize(v3, Y, Font, v4)).X
    local v5 = TextService
    local v6 = u110
    local v7 = Vector2.new((1 / 0), Y_2)
    local X_2 = (v5:GetTextSize(v6, Y_2, Font, v7)).X
    u102 = (math.max(X, X_2)) / AbsoluteSize.Y + 0.0075
end

function setText(p1, p2) -- Line: 482 -- upvalues: u109 (ref), u110 (ref), NoProgressFrame (val), ProgressFrame (val)
    u109 = p1
    u110 = p2
    updateTextScaleWidth()
    updateScaleWidth()

    local function updateText(p1_2) -- Line: 489 -- upvalues: p1 (val), p2 (val)
        p1_2.HeaderLabel.Text = p1
        p1_2.TextLabel.Text = p2
    end

    local TextFrame = NoProgressFrame.TextFrame
    TextFrame.HeaderLabel.Text = p1
    TextFrame.TextLabel.Text = p2
    local TextFrame_2 = ProgressFrame.TextFrame
    TextFrame_2.HeaderLabel.Text = p1
    TextFrame_2.TextLabel.Text = p2
end

local u160 = nil

function setPromptVisible(p1) -- Line: 499
    -- upvalues: Button (val), u104 (ref), u160 (ref), PromptGroup (val), RunService (val)
    local u15
    local u2 = os.clock()
    Button.Active = p1
    if not p1 then
        if not p1 and u104 then
            u15 = os.clock() * 100
            u160 = u15
            task.defer(function() -- Line: 535 -- upvalues: PromptGroup (upval), RunService (upval), u2 (val), u160 (upval), u15 (val)
                local new, v1, v2, v3, v4, v5, v6, v7, v8
                local v9 = easeOutQuad(0 / 0.5)
                repeat
                    if 0.002 <= v9 then
                        new = NumberSequence.new
                        v3 = {}
                        v4 = NumberSequenceKeypoint.new(0, 1)
                        v5 = NumberSequenceKeypoint.new(v9 * 0.5 - 0.001, 1)
                        v6 = NumberSequenceKeypoint.new(v9 * 0.5, 0)
                        v7 = NumberSequenceKeypoint.new(1 - v9 * 0.5, 0)
                        v8 = NumberSequenceKeypoint.new(1 - v9 * 0.5 + 0.001, 1)
                        v3[1] = v4
                        v3[2] = v5
                        v3[3] = v6
                        v3[4] = v7
                        v3[5] = v8
                        v3[6] = NumberSequenceKeypoint.new(1, 1)
                        v2 = new(v3)
                        PromptGroup.UIGradient.Transparency = v2
                    end
                    RunService.RenderStepped:Wait()
                    v1 = os.clock() - u2
                    v9 = easeOutQuad(v1 / 0.5)
                until 0.5 <= v1 or 0.5 <= v9 * 0.5 + 0.001 or u160 ~= u15
                if u160 == u15 then
                    PromptGroup.UIGradient.Transparency = NumberSequence.new(1)
                end
            end)
        end
    elseif not u104 then
        local u7 = os.clock() * 100
        u160 = u7
        task.defer(function() -- Line: 510 -- upvalues: PromptGroup (upval), RunService (upval), u2 (val), u160 (upval), u7 (val)
            local new, v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = easeOutQuad(0 / 0.5)
            repeat
                new = NumberSequence.new
                v3 = {}
                v4 = NumberSequenceKeypoint.new(0, 1)
                v5 = NumberSequenceKeypoint.new(0.5 - v9 * 0.5 - 0.001, 1)
                v6 = NumberSequenceKeypoint.new(0.5 - v9 * 0.5, 0)
                v7 = NumberSequenceKeypoint.new(0.5 + v9 * 0.5, 0)
                v8 = NumberSequenceKeypoint.new(0.5 + v9 * 0.5 + 0.001, 1)
                v3[1] = v4
                v3[2] = v5
                v3[3] = v6
                v3[4] = v7
                v3[5] = v8
                v3[6] = NumberSequenceKeypoint.new(1, 1)
                v2 = new(v3)
                PromptGroup.UIGradient.Transparency = v2
                RunService.Heartbeat:Wait()
                v1 = os.clock() - u2
                v9 = easeOutQuad(v1 / 0.5)
            until 0.5 <= v1 or 0.5 <= v9 * 0.5 + 0.001 or u160 ~= u7
            if u160 == u7 then
                PromptGroup.UIGradient.Transparency = NumberSequence.new(0)
            end
        end)
    elseif not p1 and u104 then
        u15 = os.clock() * 100
        u160 = u15
        task.defer(function() -- Line: 535 -- upvalues: PromptGroup (upval), RunService (upval), u2 (val), u160 (upval), u15 (val)
            local new, v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = easeOutQuad(0 / 0.5)
            repeat
                if 0.002 <= v9 then
                    new = NumberSequence.new
                    v3 = {}
                    v4 = NumberSequenceKeypoint.new(0, 1)
                    v5 = NumberSequenceKeypoint.new(v9 * 0.5 - 0.001, 1)
                    v6 = NumberSequenceKeypoint.new(v9 * 0.5, 0)
                    v7 = NumberSequenceKeypoint.new(1 - v9 * 0.5, 0)
                    v8 = NumberSequenceKeypoint.new(1 - v9 * 0.5 + 0.001, 1)
                    v3[1] = v4
                    v3[2] = v5
                    v3[3] = v6
                    v3[4] = v7
                    v3[5] = v8
                    v3[6] = NumberSequenceKeypoint.new(1, 1)
                    v2 = new(v3)
                    PromptGroup.UIGradient.Transparency = v2
                end
                RunService.RenderStepped:Wait()
                v1 = os.clock() - u2
                v9 = easeOutQuad(v1 / 0.5)
            until 0.5 <= v1 or 0.5 <= v9 * 0.5 + 0.001 or u160 ~= u15
            if u160 == u15 then
                PromptGroup.UIGradient.Transparency = NumberSequence.new(1)
            end
        end)
    end
    u104 = p1
end

function setPrompt(p1) -- Line: 562 -- upvalues: u129 (val), Highlight (val)
    u129.openedPrompt = p1
    Highlight.Adornee = nil
    if p1.Part then
        local Parent = p1.Part.Parent
        if p1.Part:GetAttribute("Highlight") then
            Highlight.Adornee = p1.Part
        elseif not Parent or not Parent:GetAttribute("Highlight") then
            Highlight.Adornee = nil
        else
            Highlight.Adornee = Parent
        end
    end
    setText(p1.ActionText, p1.ObjectText)
    setPromptVisible(true)
    setProgress(0)
end

function removePrompt() -- Line: 582 -- upvalues: u129 (val), Highlight (val)
    u129.openedPrompt = nil
    Highlight.Adornee = nil
    setPromptVisible(false)
    setProgress(0)
end

function u129.SetInteractionSuppressed(p1, p2) -- Line: 591
    -- upvalues: u99 (val), u114 (val), u112 (ref), u111 (ref), u105 (ref), u113 (ref)
    local v1 = false
    if type(p1) == "string" then
        v1 = p1 ~= ""
    end
    assert(v1, "A non-empty suppression reason is required")
    if u99 then
        return
    end
    if not p2 then
        u114[p1] = nil
    else
        u114[p1] = true
    end
    local v2 = next(u114) ~= nil
    if v2 then
        if u112 and u111 then
            u112.InteractEnded:Fire()
        end
        u105 = false
        u113 = true
        u111 = false
        u112 = nil
        removePrompt()
    end
end

function u129.IsInteractionSuppressed() -- Line: 615 -- upvalues: u99 (val), u114 (val)
    local v1 = not u99
    if v1 then
        v1 = next(u114) ~= nil
    end
    return v1
end

function getUnreplicatedPart(p1) -- Line: 619 -- upvalues: CollectionService (val)
    local v1 = CollectionService:GetTagged(p1)[1]
    while v1 == nil do
        v1 = CollectionService:GetInstanceAddedSignal(p1):Wait()
    end
    return v1
end

;(PromptUI:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 627 -- upvalues: u100 (ref)
    updateWidth(u100)
end)
if not u99 then
    PromptUI.Parent = game.Players.LocalPlayer.PlayerGui
end
if not u99 then
    local v5 = v3.new("PromptInteract", 3, Color3.fromRGB(9, 39, 65))
    local UIObject = v5.UIObject
    UIObject.AnchorPoint = Vector2.new(0.5, 0.5)
    local UIObject_2 = v5.UIObject
    UIObject_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    local UIObject_3 = v5.UIObject
    UIObject_3.Size = UDim2.new(0.7, 0, 0.7, 0)
    v5.UIObject.Parent = InputFrame
    local v6 = v3.new("PromptInteract", 3, Color3.new(1, 1, 1))
    local UIObject_4 = v6.UIObject
    UIObject_4.AnchorPoint = Vector2.new(0.5, 0.5)
    local UIObject_5 = v6.UIObject
    UIObject_5.Position = UDim2.new(0.5, 0, 0.5, 0)
    local UIObject_6 = v6.UIObject
    UIObject_6.Size = UDim2.new(0.7, 0, 0.7, 0)
    v6.UIObject.Parent = InputFrame_2
    v1 = v2.getInputMethod()
    local Size = PromptGroup.Size
    if v1 ~= "Touch" then end
    updateTextScaleWidth()
    updateScaleWidth()
    v2.InputMethodChanged:Connect(function(p1) -- Line: 636 -- upvalues: PromptGroup (val), u101 (ref)
        local Size = PromptGroup.Size
        if p1 ~= "Touch" then
            u101 = 0.05
        else
            u101 = 0.1
        end
        updateTextScaleWidth()
        updateScaleWidth()
    end)
    local v7 = v2.getInputMethod() == "Touch"
    Button.Visible = v7
    v2.InputMethodChanged:Connect(function(p1) -- Line: 669 -- upvalues: Button (val)
        local v1 = Button
        local v2 = p1 == "Touch"
        v1.Visible = v2
    end)
    v2.new("PromptInteract", function() -- Line: 676 -- upvalues: u114 (val), u105 (ref)
        local v1 = next(u114) ~= nil
        if v1 then
            return
        end
        u105 = true
    end, function() -- Line: 681 -- upvalues: u105 (ref), u113 (ref)
        u105 = false
        u113 = true
    end)
    Button.MouseButton1Down:Connect(function() -- Line: 686 -- upvalues: u114 (val), u105 (ref)
        local v1 = next(u114) ~= nil
        if v1 then
            return
        end
        u105 = true
    end)
    Button.MouseButton1Up:Connect(function() -- Line: 692 -- upvalues: u105 (ref), u113 (ref)
        u105 = false
        u113 = true
    end)
    Button.MouseLeave:Connect(function() -- Line: 696 -- upvalues: u105 (ref), u113 (ref)
        u105 = false
        u113 = true
    end)
end
local v8 = Enum.RenderPriority.Camera.Value - 1
RunService:BindToRenderStep("ProximityPromptProgress", v8, function(p1) -- Line: 702
    -- upvalues: u114 (val), u129 (val), u104 (ref), u105 (ref), u87 (ref), u83 (ref), u113 (ref), u111 (ref)
    -- upvalues: u112 (ref), u103 (ref)
    local v1, v2
    local v3 = next(u114) ~= nil
    if v3 then
        if u129.openedPrompt or u104 then
            removePrompt()
        end
        u105 = false
        return
    end
    if not u129.openedPrompt then
        if u112 and u113 then
            u112.InteractEnded:Fire()
            u112 = nil
        end
        return
    end
    v3 = 1
    if u87 and u87.InteractSpeedMult then
        v3 = u83.peek(u87.InteractSpeedMult)
    end
    if u105 and u113 then
        if not u111 or u129.openedPrompt ~= u112 then
            u129.openedPrompt.InteractBegan:Fire()
            u112 = u129.openedPrompt
            u111 = true
        end
        if not u105 and u111 then
            if u112 then
                u112.InteractEnded:Fire()
            end
            u111 = false
        end
        v1 = setProgress
        v2 = u103 + p1 * v3 / u129.openedPrompt.HoldTime
        v1((math.min(v2, 1)))
        if u103 == 1 and u129.openedPrompt.Enabled then
            v1 = u129
            local Triggered = v1.openedPrompt.Triggered
            local LocalPlayer = game.Players.LocalPlayer
            Triggered:Fire(LocalPlayer)
            u113 = false
            doComplete()
            setProgress(0)
            return
        end
        return
    end
    if u111 and u113 then
        u129.openedPrompt.InteractEnded:Fire()
        u111 = false
        if u129.openedPrompt.ResetOnRelease then
            u103 = 0
        end
    end
    v1 = setProgress
    local v4 = u103
    v2 = v4 - p1 * 2 * v3 / u129.openedPrompt.HoldTime
    v1((math.max(v2, 0)))
end)
if not u99 then
    local LocalPlayer = game.Players.LocalPlayer
    local u395 = RaycastParams.new()
    v1 = {workspace.Ignore, LocalPlayer.Character}
    u395.FilterDescendantsInstances = v1
    u395.FilterType = Enum.RaycastFilterType.Exclude
    task.defer(function() -- Line: 905 -- upvalues: u114 (val), u129 (val), u104 (ref), LocalPlayer (val), u106 (val), u395 (val)
        local Distance, Instance, LookVector, Magnitude, Parent, Position, Position_2, Position_4, Prompt, Unit, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
        while task.wait(0.1) do
            v1 = next(u114) ~= nil
            if not v1 then
                if not LocalPlayer.Character then
                    if u104 then
                        removePrompt()
                    end
                elseif LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    Position = LocalPlayer.Character.HumanoidRootPart.Position
                    LookVector = workspace.CurrentCamera.CFrame.LookVector
                    Position_2 = workspace.CurrentCamera.CFrame.Position
                    v9 = {}
                    v10 = u106
                    v11 = nil
                    v12 = nil
                    for i, j in v10, v11, v12 do
                        if j.Enabled then
                            Position_4 = j.Position
                            if not Position_4 and j.Part then
                                Position_4 = j.Part.Position
                            end
                            if Position_4 then
                                Magnitude = (Position - Position_4).Magnitude
                                if Magnitude <= j.Range then
                                    if not j.Obstructable then
                                        v5 = {Prompt = j, Position = Position_4, Distance = Magnitude}
                                        table.insert(v9, v5)
                                    else
                                        v3 = u395
                                        v3.FilterDescendantsInstances = {workspace.Ignore, LocalPlayer.Character}
                                        if j.ObstructionIgnoreList then
                                            v3 = table.move(
                                                j.ObstructionIgnoreList,
                                                1,
                                                #j.ObstructionIgnoreList,
                                                #u395.FilterDescendantsInstances + 1,
                                                u395.FilterDescendantsInstances
                                            )
                                            u395.FilterDescendantsInstances = v3
                                        end
                                        v3 = workspace
                                        v6 = Position - Position_4
                                        v7 = u395
                                        if not v3:Raycast(Position_4, v6, v7) then
                                            v5 = {Prompt = j, Position = Position_4, Distance = Magnitude}
                                            table.insert(v9, v5)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    Prompt = nil
                    v11 = nil
                    Distance = nil
                    v13 = RaycastParams.new()
                    v13.FilterDescendantsInstances = {workspace.Ignore, LocalPlayer.Character}
                    v13.FilterType = Enum.RaycastFilterType.Exclude
                    v14 = workspace
                    v3 = LookVector * 35
                    v14 = v14:Raycast(Position_2, v3, v13)
                    if v14 then
                        Instance = v14.Instance
                        v2 = {}
                        v3 = {}
                        v4 = {}
                        v5 = v9
                        v6 = nil
                        v7 = nil
                        for k, n in v5, v6, v7 do
                            if n ~= nil and n.Prompt ~= nil and n.Prompt.Part ~= nil then
                                Parent = n.Prompt.Part.Parent
                                if n.Prompt.Part == Instance then
                                    table.insert(v4, n)
                                elseif Instance.Parent == Parent then
                                    table.insert(v3, n)
                                elseif Instance:IsDescendantOf(Parent) then
                                    table.insert(v2, n)
                                end
                            end
                        end
                        if #v4 ~= 0 then
                            v9 = v4
                        elseif #v3 ~= 0 then
                            v9 = v3
                        elseif #v2 ~= 0 then
                            v9 = v2
                        end
                    end
                    for i2, v in ipairs(v9) do
                        Unit = (v.Position - Position).Unit
                        v7 = LookVector:Dot(Unit)
                        v8 = math.clamp(v7, -1, 1)
                        v8 = math.acos(v8)
                        if not Prompt or v8 < v11 or v8 == v11 and v.Distance < Distance then
                            Prompt = v.Prompt
                            v11 = v8
                            Distance = v.Distance
                        end
                    end
                    if Prompt == nil then
                        if u104 then
                            removePrompt()
                        end
                    elseif u129.openedPrompt ~= Prompt then
                        setPrompt(Prompt)
                    end
                elseif u104 then
                    removePrompt()
                end
            elseif u129.openedPrompt or u104 then
                removePrompt()
            end
        end
    end)
    ReplicateProximityPrompt:SetClientListener(function(p1) -- Line: 1048 -- upvalues: u129 (val), u106 (val)
        local v1
        if p1.Type == "Add" then
            u129.new(p1.PropertyTable, p1.Identifier)
            return
        end
        if p1.Type == "Destroy" then
            v1 = u106[p1.Identifier]
            if not v1 then
                return
            end
            v1:Destroy()
            return
        end
        if p1.Type == "PropertyChanged" then
            v1 = u106[p1.Identifier]
            if v1 then
                local Index = p1.Index
                local Value = p1.Value
                v1:_SetProperty(Index, Value)
            end
        end
    end)
    ReplicateProximityPrompt:FireServer()
else
    local function logTriggeredReject(p1, p2, p3) -- Line: 764 -- upvalues: u106 (val), u107 (val), u108 (val)
        if typeof(p2) == "table" and p2.Type == "Triggered" then
            local Identifier_2, v1
            local v2 = false
            local Identifier = p2.Identifier
            if type(Identifier) == "string" then
                v2 = #p2.Identifier <= 128
            end
            local v3 = v2
            if v3 then
                v3 = true
                if u106[p2.Identifier] == nil then
                    v3 = u107[p2.Identifier] ~= nil
                end
            end
            if v3 then
                Identifier_2 = p2.Identifier
            elseif not v2 then
                Identifier_2 = "<invalid>"
            else
                Identifier_2 = "<unregistered>"
            end
            if not v2 or v3 then
                v1 = nil
            else
                v1 = string.format("submittedIdentifier=%q", p2.Identifier)
            end
            local v4 = u108[p1]
            if not v4 then
                v4 = {}
                u108[p1] = v4
            end
            local v5 = v4[Identifier_2]
            if not v5 then
                v5 = {}
                v4[Identifier_2] = v5
            end
            local v6 = os.clock()
            local v7 = v5[p3]
            if not v7 or 10 <= v6 - v7 then
                local v8
                v5[p3] = v6
                local v9 = warn
                local format = string.format
                local v10 = "[ProximityPromptZS] Trigger rejected: player=%s identifier=%s reason=%s%s"
                local Name = p1.Name
                local v11 = Identifier_2
                local v12 = p3
                if not v1 then
                    v8 = ""
                else
                    v8 = string.format(" detail=%s", v1)
                    if not v8 then
                        v8 = ""
                    end
                end
                v9(format(v10, Name, v11, v12, v8))
            end
            return
        end
    end

    Players.PlayerRemoving:Connect(function(p1) -- Line: 805 -- upvalues: u108 (val)
        u108[p1] = nil
    end)

    local function canPlayerUsePrompt(p1, p2) -- Line: 809 -- upvalues: u106 (val), Players (val)
        if typeof(p2) == "table" then
            local Identifier = p2.Identifier
            if typeof(Identifier) == "string" then
                local Type = p2.Type
                if typeof(Type) == "string" then
                    if p2.Type ~= "Triggered" and p2.Type ~= "InteractBegin" and p2.Type ~= "InteractEnd" then
                        return false, nil, "invalidType"
                    end
                    local v1 = u106[p2.Identifier]
                    if not v1 then
                        return false, nil, "noPrompt"
                    end
                    if p2.Type == "InteractEnd" then
                        return true, v1
                    end
                    if not v1.Enabled then
                        return false, nil, "disabled"
                    end
                    if v1.Players and not table.find(v1.Players, p1) then
                        return false, nil, "notAllowed"
                    end
                    local Character = p1.Character
                    local HumanoidRootPart = Character
                    if HumanoidRootPart then
                        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    end
                    local v2 = Players
                    if p1:IsDescendantOf(v2) and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                        local Position = v1.Position
                        if not Position and v1.Part and v1.Part:IsA("BasePart") then
                            Position = v1.Part.Position
                        end
                        local Range = v1.Range
                        if typeof(Position) == "Vector3" and type(Range) == "number" and not (Range < 0) then
                            if Range < (HumanoidRootPart.Position - Position).Magnitude then
                                return false, nil, "tooFar"
                            end
                            if v1.Obstructable then
                                v2 = RaycastParams.new()
                                local v3 = {Character}
                                local Ignore = workspace:FindFirstChild("Ignore")
                                if Ignore then
                                    table.insert(v3, Ignore)
                                end
                                local ObstructionIgnoreList = v1.ObstructionIgnoreList
                                if not ObstructionIgnoreList then
                                    ObstructionIgnoreList = {}
                                end
                                local v4 = nil
                                local v5 = nil
                                for i, j in ObstructionIgnoreList, v4, v5 do
                                    if typeof(j) == "Instance" then
                                        table.insert(v3, j)
                                    end
                                end
                                v2.FilterDescendantsInstances = v3
                                v2.FilterType = Enum.RaycastFilterType.Exclude
                                local v6 = workspace
                                local v7 = HumanoidRootPart.Position - Position
                                if v6:Raycast(Position, v7, v2) then
                                    return false, nil, "obstructed"
                                end
                            end
                            return true, v1
                        end
                        return false, nil, "noPosition"
                    end
                    return false, nil, "noCharacter"
                end
            end
        end
        return false, nil, "invalidPacket"
    end

    ReplicateProximityPrompt:SetServerListener(function(p1, p2) -- Line: 875
        -- upvalues: canPlayerUsePrompt (val), logTriggeredReject (val), u107 (val), ReplicateProximityPrompt (val)
        local v1, v2, v3
        if not p2 then
            v1 = u107
            v2 = nil
            v3 = nil
            local v4 = p1
            for i, j in v1, v2, v3 do
                if not j.PropertyTable.Players or table.find(j.PropertyTable.Players, v4) then
                    ReplicateProximityPrompt:FireClient(v4, j)
                end
            end
            return
        end
        v1, v2, v3 = canPlayerUsePrompt(p1, p2)
        if v1 and v2 then
            if p2.Type == "Triggered" then
                v2.Triggered:Fire(p1)
                return
            end
            if p2.Type == "InteractBegin" then
                v2.InteractBegan:Fire(p1)
                return
            end
            if p2.Type ~= "InteractEnd" then
                return
            end
            v2.InteractEnded:Fire(p1)
            return
        end
        if not v3 then
            return
        end
        logTriggeredReject(p1, p2, v3)
    end)
end
return u129