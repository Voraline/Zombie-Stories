local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
game:GetService("UserInputService")
local Players = game:GetService("Players")
local common = game.ReplicatedStorage.common
local Packages = game.ReplicatedStorage.Packages
local PromptUI = script.PromptUI
local Complete = PromptUI.Complete
local PromptGroup = PromptUI.PromptGroup
local NoProgressFrame = PromptGroup.NoProgressFrame
local ProgressSliceFrame = PromptGroup.ProgressSliceFrame
local ProgressFrame = ProgressSliceFrame.ProgressFrame
local Button = PromptUI.Button
local Highlight = Instance.new("Highlight")
local Signal = require(common.Signal)
local v1 = nil
local v2 = nil
local u83 = nil
local u87 = nil
if not (RunService:IsServer()) then
    v1 = require(common.BindUtil)
    v2 = require(common.InputLabel)
    u83 = require(Packages.Fusion)
    u87 = require("@game/ReplicatedStorage/common/skillTree/SkillTreeData")
    task.spawn(function() -- Line: 40 -- upvalues: Highlight (val)
        Highlight.FillTransparency = 1
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end)
end
local ReplicateProximityPrompt = require(game.ReplicatedStorage.common.RedEvents.General.ReplicateProximityPrompt)
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
local v3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u127 = TweenService:Create(Complete, v3, {BackgroundTransparency = 1})
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
local function isInteractionSuppressed() -- Line: 208 -- upvalues: u114 (val)
    local v1 = next(u114) ~= nil
    return v1
end
function u129.__index(p1, p2) -- Line: 214 -- upvalues: u128 (val), u129 (val)
    local v1 = rawget(p1, p2)
    if u128[p2] then
        return rawget(p1, "Properties")[p2]
    end
    if v1 ~= nil then
        return v1
    end
    return u129[p2]
end
function u129.__newindex(p1, p2, p3) -- Line: 226 -- upvalues: u128 (val), u129 (val)
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
function u129.new(p1, p2) -- Line: 244 -- upvalues: HttpService (val), u99 (val), Signal (val), u106 (val), CollectionService (val), ReplicateProximityPrompt (val), u107 (val), u129 (val)
    local Enabled, Obstructable, ResetOnRelease, v1
    if not p2 then
        v1 = HttpService:GenerateGUID(false)
    else
        v1 = p2
    end
    local v2 = p1 ~= nil
    assert(v2, "Must pass a property table")
    v2 = if p1.Position == nil then if p1.Part == nil then not u99 else true else true
    assert(v2, "Must pass either a Part or a Position")
    v2 = if p1.ActionText ~= nil then p1.ObjectText ~= nil else false
    assert(v2, "Must pass ActionText and ObjectText")
    if p1.Part then
        v2 = if typeof(p1.Part) == "Instance" then p1.Part:IsA("BasePart") else false
        assert(v2, "Part must be a BasePart")
    end
    if p1.Position then
        v2 = typeof(p1.Position) == "Vector3"
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
    local u105 = {_Identifier = v1, Properties = v3}
    local v4 = v1 == nil
    u105._IsLocal = v4
    u105.Triggered = Signal.new()
    u105.InteractBegan = Signal.new()
    u105.InteractEnded = Signal.new()
    u106[u105._Identifier] = u105
    if u99 then
        if v3.Part then
            CollectionService:AddTag(v3.Part, v1)
        end
        v4 = {Type = "Add", Identifier = u105._Identifier, PropertyTable = v3}
        if not v3.Players then
            ReplicateProximityPrompt:FireAllClients(v4)
        else
            ReplicateProximityPrompt:FireClients(v3.Players, v4)
        end
        u107[v1] = v4
    end
    if not u99 then
        u105.Triggered:Connect(function() -- Line: 317 -- upvalues: ReplicateProximityPrompt (upval), u105 (val)
            ReplicateProximityPrompt:FireServer({Type = "Triggered", Identifier = u105._Identifier})
        end)
        u105.InteractBegan:Connect(function() -- Line: 324 -- upvalues: ReplicateProximityPrompt (upval), u105 (val)
            ReplicateProximityPrompt:FireServer({Type = "InteractBegin", Identifier = u105._Identifier})
        end)
        u105.InteractEnded:Connect(function() -- Line: 331 -- upvalues: ReplicateProximityPrompt (upval), u105 (val)
            ReplicateProximityPrompt:FireServer({Type = "InteractEnd", Identifier = u105._Identifier})
        end)
    end
    return (setmetatable(u105, u129))
end
function u129:Destroy() -- Line: 343 -- upvalues: u99 (val), ReplicateProximityPrompt (val), u107 (val), u106 (val)
    self.Triggered:DisconnectAll()
    self.InteractBegan:DisconnectAll()
    self.InteractEnded:DisconnectAll()
    if u99 then
        ReplicateProximityPrompt:FireAllClients({Type = "Destroy", Identifier = self._Identifier})
        u107[self._Identifier] = nil
    end
    u106[self._Identifier] = nil
end
function u129.GetPromptByIdentifier(p1, p2) -- Line: 361 -- upvalues: u106 (val)
    return u106[p2]
end
function u129:_SetProperty(p2, p3) -- Line: 365 -- upvalues: u128 (val), u99 (val), ReplicateProximityPrompt (val), u129 (val)
    if not (u128[p2]) then
        return
    end
    self.Properties[p2] = p3
    if u99 then
        local v1 = {Type = "PropertyChanged", Identifier = self._Identifier, Index = p2, Value = p3}
        if self.Properties.Players == nil then
            ReplicateProximityPrompt:FireAllClients(v1)
            return
        end
        ReplicateProximityPrompt:FireClients(self.Properties.Players, v1)
        return
    end
    if p2 == "ActionText" then
        if u129.openedPrompt == self then
            setText(self.ActionText, self.ObjectText)
            return
        end
        return
    end
    if p2 == "ObjectText" then
        if u129.openedPrompt ~= self then
            return
        end
        setText(self.ActionText, self.ObjectText)
        return
    end
    if p2 == "Part" and not p3 then
        self.Properties[p2] = getUnreplicatedPart(self._Identifier)
    end
end
function easeOutQuad(p1) -- Line: 396
    return 1 - (1 - p1) * (1 - p1)
end
function doComplete() -- Line: 400 -- upvalues: Complete (val), NoProgressFrame (val), u127 (val)
    Complete.BackgroundTransparency = 0
    Complete.Size = UDim2.new(0, NoProgressFrame.AbsoluteSize.X, 0, NoProgressFrame.AbsoluteSize.Y)
    Complete.Visible = true
    local v1 = UDim2.new(0, NoProgressFrame.AbsoluteSize.X * 1.5, 0, NoProgressFrame.AbsoluteSize.Y * 1.5)
    Complete:TweenSize(v1, "Out", "Quad", 0.15, true)
    u127:Play()
end
u127.Completed:Connect(function(p1) -- Line: 421 -- upvalues: Complete (val)
    if p1 == Enum.PlaybackState.Completed then
        Complete.Visible = false
    end
end)
function setProgress(p1) -- Line: 427 -- upvalues: u103 (ref), u100 (ref), PromptUI (val), ProgressSliceFrame (val)
    u103 = p1
    ProgressSliceFrame.Size = UDim2.new(0, u100 * PromptUI.AbsoluteSize.Y * p1, 1, 0)
end
function updateWidth(p1) -- Line: 433 -- upvalues: PromptUI (val), u100 (ref), PromptGroup (val), u101 (ref), ProgressFrame (val), Button (val), u103 (ref)
    u100 = p1
    local v1 = UDim2.new(p1, 0, u101, 0)
    PromptGroup:TweenSize(v1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    ProgressFrame.Size = UDim2.new(0, p1 * PromptUI.AbsoluteSize.Y, 1, 0)
    Button.Size = UDim2.new(p1 * 1.5, 0, u101 * 2, 0)
    setProgress(u103)
end
function updateScaleWidth() -- Line: 450 -- upvalues: u102 (ref), u101 (ref), NoProgressFrame (val), ProgressFrame (val)
    local function updateText(p1) -- Line: 451 -- upvalues: u102 (upval), u101 (upval)
        local v1 = UDim2.new(u102 / u101, 0, 1, 0)
        p1:TweenSize(v1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    end
    local v1 = UDim2.new(u102 / u101, 0, 1, 0)
    NoProgressFrame.TextFrame:TweenSize(v1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    v1 = UDim2.new(u102 / u101, 0, 1, 0)
    ProgressFrame.TextFrame:TweenSize(v1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    updateWidth(u102 + u101)
end
function updateTextScaleWidth() -- Line: 467 -- upvalues: PromptGroup (val), u100 (ref), u101 (ref), PromptUI (val), NoProgressFrame (val), TextService (val), u109 (ref), u110 (ref), u102 (ref)
    PromptGroup.Size = UDim2.new(u100, 0, u101, 0)
    local Y = NoProgressFrame.TextFrame.HeaderLabel.TextBounds.Y
    local Y_2 = NoProgressFrame.TextFrame.TextLabel.TextBounds.Y
    local Font = NoProgressFrame.TextFrame.HeaderLabel.Font
    local v1 = math.max(TextService:GetTextSize(u109, Y, Font, Vector2.new((1 / 0), Y)).X, TextService:GetTextSize(u110, Y_2, Font, Vector2.new((1 / 0), Y_2)).X)
    u102 = v1 / PromptUI.AbsoluteSize.Y + 0.0075
end
function setText(p1, p2) -- Line: 480 -- upvalues: u109 (ref), u110 (ref), NoProgressFrame (val), ProgressFrame (val)
    u109 = p1
    u110 = p2
    updateTextScaleWidth()
    updateScaleWidth()
    local function updateText(a1) -- Line: 487 -- upvalues: p1 (val), p2 (val)
        a1.HeaderLabel.Text = p1
        a1.TextLabel.Text = p2
    end
    local TextFrame = NoProgressFrame.TextFrame
    TextFrame.HeaderLabel.Text = p1
    TextFrame.TextLabel.Text = p2
    local TextFrame_2 = ProgressFrame.TextFrame
    TextFrame_2.HeaderLabel.Text = p1
    TextFrame_2.TextLabel.Text = p2
end
local u160 = nil
function setPromptVisible(p1) -- Line: 497 -- upvalues: Button (val), u104 (ref), u160 (ref), PromptGroup (val), RunService (val)
    local u15
    local u2 = os.clock()
    Button.Active = p1
    if not p1 then
        if not p1 and u104 then
            u15 = os.clock() * 100
            u160 = u15
            task.defer(function() -- Line: 533 -- upvalues: PromptGroup (upval), RunService (upval), u2 (val), u160 (upval), u15 (val)
                local v1, v2, v3, v4, v5, v6, v7, v8
                local v9 = easeOutQuad(0 / 0.5)
                while true do
                    if 0.002 <= v9 then
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
                        v2 = NumberSequence.new(v3)
                        PromptGroup.UIGradient.Transparency = v2
                    end
                    RunService.RenderStepped:Wait()
                    v1 = os.clock() - u2
                    v9 = easeOutQuad(v1 / 0.5)
                    if 0.5 <= v1 then
                        break
                    end
                    v2 = v9 * 0.5 + 0.001
                    if 0.5 <= v2 or u160 ~= u15 then
                        break
                    end
                end
                if u160 == u15 then
                    PromptGroup.UIGradient.Transparency = NumberSequence.new(1)
                end
            end)
        end
    elseif not u104 then
        local u7 = os.clock() * 100
        u160 = u7
        task.defer(function() -- Line: 508 -- upvalues: PromptGroup (upval), RunService (upval), u2 (val), u160 (upval), u7 (val)
            local v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = easeOutQuad(0 / 0.5)
            while true do
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
                v2 = NumberSequence.new(v3)
                PromptGroup.UIGradient.Transparency = v2
                RunService.Heartbeat:Wait()
                v1 = os.clock() - u2
                v9 = easeOutQuad(v1 / 0.5)
                if 0.5 <= v1 then
                    break
                end
                v3 = v9 * 0.5 + 0.001
                if 0.5 <= v3 or u160 ~= u7 then
                    break
                end
            end
            if u160 == u7 then
                PromptGroup.UIGradient.Transparency = NumberSequence.new(0)
            end
        end)
    elseif not p1 and u104 then
        u15 = os.clock() * 100
        u160 = u15
        task.defer(function() -- Line: 533 -- upvalues: PromptGroup (upval), RunService (upval), u2 (val), u160 (upval), u15 (val)
            local v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = easeOutQuad(0 / 0.5)
            while true do
                if 0.002 <= v9 then
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
                    v2 = NumberSequence.new(v3)
                    PromptGroup.UIGradient.Transparency = v2
                end
                RunService.RenderStepped:Wait()
                v1 = os.clock() - u2
                v9 = easeOutQuad(v1 / 0.5)
                if 0.5 <= v1 then
                    break
                end
                v2 = v9 * 0.5 + 0.001
                if 0.5 <= v2 or u160 ~= u15 then
                    break
                end
            end
            if u160 == u15 then
                PromptGroup.UIGradient.Transparency = NumberSequence.new(1)
            end
        end)
    end
    u104 = p1
end
function setPrompt(p1) -- Line: 560 -- upvalues: u129 (val), Highlight (val)
    u129.openedPrompt = p1
    Highlight.Adornee = nil
    if p1.Part then
        local Parent = p1.Part.Parent
        if p1.Part:GetAttribute("Highlight") then
            Highlight.Adornee = p1.Part
        elseif not Parent then
            Highlight.Adornee = nil
        elseif not (Parent:GetAttribute("Highlight")) then
            Highlight.Adornee = nil
        else
            Highlight.Adornee = Parent
        end
    end
    setText(p1.ActionText, p1.ObjectText)
    setPromptVisible(true)
    setProgress(0)
end
function removePrompt() -- Line: 580 -- upvalues: u129 (val), Highlight (val)
    u129.openedPrompt = nil
    Highlight.Adornee = nil
    setPromptVisible(false)
    setProgress(0)
end
function u129.SetInteractionSuppressed(p1, p2) -- Line: 589 -- upvalues: u99 (val), u114 (val), u112 (ref), u111 (ref), u105 (ref), u113 (ref)
    local v1 = if type(p1) == "string" then p1 ~= "" else false
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
function u129.IsInteractionSuppressed() -- Line: 613 -- upvalues: u99 (val), u114 (val)
    local v1 = not u99
    if v1 then
        v1 = next(u114) ~= nil
    end
    return v1
end
function getUnreplicatedPart(p1) -- Line: 617 -- upvalues: CollectionService (val)
    local v1 = CollectionService:GetTagged(p1)[1]
    while v1 == nil do
        v1 = CollectionService:GetInstanceAddedSignal(p1):Wait()
    end
    return v1
end
local PropertyChangedSignal = PromptUI:GetPropertyChangedSignal("AbsoluteSize")
PropertyChangedSignal:Connect(function() -- Line: 625 -- upvalues: u100 (ref)
    updateWidth(u100)
end)
if not u99 then
    PromptUI.Parent = game.Players.LocalPlayer.PlayerGui
end
if not u99 then
    local v4 = v2.new("PromptInteract", 3, Color3.fromRGB(9, 39, 65))
    local UIObject = v4.UIObject
    UIObject.AnchorPoint = Vector2.new(0.5, 0.5)
    local UIObject_2 = v4.UIObject
    UIObject_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    local UIObject_3 = v4.UIObject
    UIObject_3.Size = UDim2.new(0.7, 0, 0.7, 0)
    v4.UIObject.Parent = ProgressFrame.InputFrame
    local v5 = v2.new("PromptInteract", 3, Color3.new(1, 1, 1))
    local UIObject_4 = v5.UIObject
    UIObject_4.AnchorPoint = Vector2.new(0.5, 0.5)
    local UIObject_5 = v5.UIObject
    UIObject_5.Position = UDim2.new(0.5, 0, 0.5, 0)
    local UIObject_6 = v5.UIObject
    UIObject_6.Size = UDim2.new(0.7, 0, 0.7, 0)
    v5.UIObject.Parent = NoProgressFrame.InputFrame
    if v1.getInputMethod() ~= "Touch" then end
    updateTextScaleWidth()
    updateScaleWidth()
    v1.InputMethodChanged:Connect(function(p1) -- Line: 634 -- upvalues: PromptGroup (val), u101 (ref)
        if p1 ~= "Touch" then
            u101 = 0.05
        else
            u101 = 0.1
        end
        updateTextScaleWidth()
        updateScaleWidth()
    end)
    local v6 = v1.getInputMethod() == "Touch"
    Button.Visible = v6
    v1.InputMethodChanged:Connect(function(p1) -- Line: 667 -- upvalues: Button (val)
        local v1 = p1 == "Touch"
        Button.Visible = v1
    end)
    v1.new("PromptInteract", function() -- Line: 674 -- upvalues: u114 (val), u105 (ref)
        local v1 = next(u114) ~= nil
        if v1 then
            return
        end
        u105 = true
    end, function() -- Line: 679 -- upvalues: u105 (ref), u113 (ref)
        u105 = false
        u113 = true
    end)
    Button.MouseButton1Down:Connect(function() -- Line: 684 -- upvalues: u114 (val), u105 (ref)
        local v1 = next(u114) ~= nil
        if v1 then
            return
        end
        u105 = true
    end)
    Button.MouseButton1Up:Connect(function() -- Line: 690 -- upvalues: u105 (ref), u113 (ref)
        u105 = false
        u113 = true
    end)
    Button.MouseLeave:Connect(function() -- Line: 694 -- upvalues: u105 (ref), u113 (ref)
        u105 = false
        u113 = true
    end)
end
RunService:BindToRenderStep("ProximityPromptProgress", Enum.RenderPriority.Camera.Value - 1, function(p1) -- Line: 700 -- upvalues: u114 (val), u129 (val), u104 (ref), u105 (ref), u87 (ref), u83 (ref), u113 (ref), u111 (ref), u112 (ref), u103 (ref)
    local v1
    local v2 = next(u114) ~= nil
    if v2 then
        if u129.openedPrompt then
            removePrompt()
        elseif u104 then
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
    v2 = if u87 and u87.InteractSpeedMult then u83.peek(u87.InteractSpeedMult) else 1
    if not u105 or not u113 then
        if u111 and u113 then
            u129.openedPrompt.InteractEnded:Fire()
            u111 = false
            if u129.openedPrompt.ResetOnRelease then
                u103 = 0
            end
        end
        v1 = u103 - p1 * 2 * v2 / u129.openedPrompt.HoldTime
        setProgress((math.max(v1, 0)))
        return
    end
    if not u111 then
        u129.openedPrompt.InteractBegan:Fire()
        u112 = u129.openedPrompt
        u111 = true
    elseif u129.openedPrompt == u112 then
    end
    if not u105 and u111 then
        if u112 then
            u112.InteractEnded:Fire()
        end
        u111 = false
    end
    v1 = u103 + p1 * v2 / u129.openedPrompt.HoldTime
    setProgress((math.min(v1, 1)))
    if u103 ~= 1 or not u129.openedPrompt.Enabled then
        return
    end
    u129.openedPrompt.Triggered:Fire(game.Players.LocalPlayer)
    u113 = false
    doComplete()
    setProgress(0)
end)
if not u99 then
    local LocalPlayer = game.Players.LocalPlayer
    local u395 = RaycastParams.new()
    u395.FilterDescendantsInstances = {workspace.Ignore, LocalPlayer.Character}
    u395.FilterType = Enum.RaycastFilterType.Exclude
    task.defer(function() -- Line: 903 -- upvalues: u114 (val), u129 (val), u104 (ref), LocalPlayer (val), u106 (val), u395 (val)
        local Distance, Instance, LookVector, Magnitude, Parent, Position, Position_2, Position_3, Prompt, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
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
                            Position_3 = j.Position
                            if not Position_3 and j.Part then
                                Position_3 = j.Part.Position
                            end
                            if Position_3 then
                                Magnitude = (Position - Position_3).Magnitude
                                if Magnitude <= j.Range then
                                    if not j.Obstructable then
                                        table.insert(v9, {Prompt = j, Position = Position_3, Distance = Magnitude})
                                    else
                                        u395.FilterDescendantsInstances = {workspace.Ignore, LocalPlayer.Character}
                                        if j.ObstructionIgnoreList then
                                            v3 = table.move(j.ObstructionIgnoreList, 1, #j.ObstructionIgnoreList, #u395.FilterDescendantsInstances + 1, u395.FilterDescendantsInstances)
                                            u395.FilterDescendantsInstances = v3
                                        end
                                        if workspace:Raycast(Position_3, Position - Position_3, u395) then end
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
                    v14 = workspace:Raycast(Position_2, LookVector * 35, v13)
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
                        v8 = math.acos((math.clamp(LookVector:Dot((v.Position - Position).Unit), -1, 1)))
                        if not Prompt then
                            Prompt = v.Prompt
                            v11 = v8
                            Distance = v.Distance
                        elseif v8 < v11 then
                            Prompt = v.Prompt
                            v11 = v8
                            Distance = v.Distance
                        elseif v8 == v11 and v.Distance >= Distance then
                        end
                    end
                    if Prompt == nil then
                        if u104 then
                            removePrompt()
                        end
                    elseif u129.openedPrompt ~= Prompt then
                        setPrompt(Prompt)
                    end
                end
            elseif u129.openedPrompt then
                removePrompt()
            elseif not u104 then
            end
        end
    end)
    ReplicateProximityPrompt:SetClientListener(function(p1) -- Line: 1046 -- upvalues: u129 (val), u106 (val)
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
                v1:_SetProperty(p1.Index, p1.Value)
            end
        end
    end)
    ReplicateProximityPrompt:FireServer()
else
    local function logTriggeredReject(p1, p2, p3) -- Line: 762 -- upvalues: u106 (val), u107 (val), u108 (val)
        local Identifier, v1, v2
        if typeof(p2) ~= "table" or p2.Type ~= "Triggered" then
            return
        end
        local v3 = false
        if type(p2.Identifier) == "string" then
            v1 = #p2.Identifier
            v3 = v1 <= 128
        end
        v1 = v3
        if v1 then
            v1 = if u106[p2.Identifier] == nil then u107[p2.Identifier] ~= nil else true
        end
        if v1 then
            Identifier = p2.Identifier
        elseif not v3 then
            Identifier = "<invalid>"
        else
            Identifier = "<unregistered>"
        end
        if not v3 then
            v2 = nil
        elseif not v1 then
            v2 = string.format("submittedIdentifier=%q", p2.Identifier)
        end
        local v4 = u108[p1]
        if not v4 then
            u108[p1] = {}
        end
        local v5 = v4[Identifier]
        if not v5 then
            v4[Identifier] = {}
        end
        local v6 = os.clock()
        local v7 = v5[p3]
        if not v7 then
            local v8
            v5[p3] = v6
            local v9 = warn
            local format = string.format
            local Name = p1.Name
            if not v2 then
                v8 = ""
            else
                v8 = string.format(" detail=%s", v2)
                if not v8 then
                    v8 = ""
                end
            end
            v9(format("[ProximityPromptZS] Trigger rejected: player=%s identifier=%s reason=%s%s", Name, Identifier, p3, v8))
        elseif 10 > v6 - v7 then
        end
    end
    Players.PlayerRemoving:Connect(function(p1) -- Line: 803 -- upvalues: u108 (val)
        u108[p1] = nil
    end)
    local function canPlayerUsePrompt(p1, p2) -- Line: 807 -- upvalues: u106 (val), Players (val)
        if typeof(p2) ~= "table" then
            return false, nil, "invalidPacket"
        elseif typeof(p2.Identifier) ~= "string" then
            return false, nil, "invalidPacket"
        else
            if typeof(p2.Type) ~= "string" then
                return false, nil, "invalidPacket"
            end
            if p2.Type == "Triggered" then
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
                if not v1.Players then
                    local Character = p1.Character
                    local HumanoidRootPart = Character
                    if HumanoidRootPart then
                        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    end
                    if not (p1:IsDescendantOf(Players)) or not HumanoidRootPart or not (HumanoidRootPart:IsA("BasePart")) then
                        return false, nil, "noCharacter"
                    end
                    local Position = v1.Position
                    if not Position and v1.Part and v1.Part:IsA("BasePart") then
                        Position = v1.Part.Position
                    end
                    local Range = v1.Range
                    if typeof(Position) ~= "Vector3" or type(Range) ~= "number" or Range < 0 then
                        return false, nil, "noPosition"
                    end
                    if Range < (HumanoidRootPart.Position - Position).Magnitude then
                        return false, nil, "tooFar"
                    end
                    if not v1.Obstructable then
                        return true, v1
                    end
                    local v2 = RaycastParams.new()
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
                    local v6 = HumanoidRootPart.Position - Position
                    if workspace:Raycast(Position, v6, v2) then
                        return false, nil, "obstructed"
                    end
                    return true, v1
                elseif not (table.find(v1.Players, p1)) then
                    return false, nil, "notAllowed"
                end
            elseif p2.Type ~= "InteractBegin" and p2.Type ~= "InteractEnd" then
                return false, nil, "invalidType"
            end
        end
    end
    ReplicateProximityPrompt:SetServerListener(function(p1, p2) -- Line: 873 -- upvalues: canPlayerUsePrompt (val), logTriggeredReject (val), u107 (val), ReplicateProximityPrompt (val)
        local v1, v2, v3
        if not p2 then
            v1 = u107
            v2 = nil
            v3 = nil
            local v4 = p1
            for i, j in v1, v2, v3 do
                if not j.PropertyTable.Players then
                    ReplicateProximityPrompt:FireClient(v4, j)
                elseif not (table.find(j.PropertyTable.Players, v4)) then
                end
            end
            return
        end
        v1, v2, v3 = canPlayerUsePrompt(p1, p2)
        if not v1 or not v2 then
            if v3 then
                logTriggeredReject(p1, p2, v3)
                return
            end
            return
        end
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
    end)
end
return u129