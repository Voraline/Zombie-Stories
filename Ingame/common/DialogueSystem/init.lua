local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.common.Signal)
local DialogueDefaults = require(script.DialogueDefaults)
local DialogueUI = require(script.DialogueUI)
local u37 = {}
local u38 = {}
u38.__index = u38
local u39 = nil
local u40 = {}
local u42 = Random.new()
local u43 = 0
local u44 = {[","] = true, ["."] = true, ["!"] = true, ["?"] = true}
local u49 = {}
u49[Enum.KeyCode.One] = 1
u49[Enum.KeyCode.Two] = 2
u49[Enum.KeyCode.Three] = 3
u49[Enum.KeyCode.Four] = 4
u49[Enum.KeyCode.KeypadOne] = 1
u49[Enum.KeyCode.KeypadTwo] = 2
u49[Enum.KeyCode.KeypadThree] = 3
u49[Enum.KeyCode.KeypadFour] = 4

local function disconnect(p1) -- Line: 41
    if p1 then
        p1:Disconnect()
    end
end

local function getPosition(p1) -- Line: 47
    if p1 and p1.Parent then
        local Position
        if p1:IsA("BasePart") then
            return p1.Position
        end
        if not p1:IsA("Model") then
            return nil
        end
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then
            HumanoidRootPart = p1.PrimaryPart
        end
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            return HumanoidRootPart.Position
        end
        local BasePart = p1:FindFirstChildWhichIsA("BasePart", true)
        if not BasePart then
            Position = nil
        else
            Position = BasePart.Position
            if not Position then
                Position = nil
            end
        end
        return Position
    end
    return nil
end

local function splitGraphemes(p1) -- Line: 63
    local u1 = {}
    if not pcall(function() -- Line: 65 -- upvalues: p1 (val), u1 (val)
        local sub, v3, v4, v5, v6, v7, v8
        for i, j in utf8.graphemes(p1) do
            v6 = u1
            v8 = p1
            sub = string.sub
            v7 = sub(v8, i, j)
            table.insert(v6, v7)
        end
        return
    end) then
        local v1
        local v2 = #p1
        for i = 1, v2 do
            v1 = string.sub(p1, i, i)
            table.insert(u1, v1)
        end
    end
    return u1
end

function u38:_stopNodeAnimation() -- Line: 78
    if self._animationCleanup then
        local _animationCleanup = self._animationCleanup
        self._animationCleanup = nil
        pcall(_animationCleanup)
    end
end

function u38:_resolveLine(p2) -- Line: 86
    if type(p2) == "string" then
        return p2
    end
    if type(p2) ~= "function" then
        warn(string.format("[DialogueSystem] Invalid line in tree %s", self.Tree.id))
        return ""
    end
    local success, result = pcall(p2, self.Context)
    if not success then
        warn(string.format("[DialogueSystem] Line resolver failed in tree %s: %s", self.Tree.id, (tostring(result))))
        return ""
    end
    if type(result) == "string" then
        return result
    end
    warn(string.format("[DialogueSystem] Line resolver returned %s in tree %s", type(result), self.Tree.id))
    return ""
end

function u38:_chooseGreeting() -- Line: 105 -- upvalues: u40 (val), u42 (val)
    local greetings = self.Tree.greetings
    if greetings and #greetings ~= 0 then
        local v1
        local v2 = u40[self.Tree.id]
        if #greetings == 1 then
            v1 = 1
        else
            local v3, v4
            if not v2 then
                v3 = u42
                v4 = #greetings
                v1 = v3:NextInteger(1, v4)
            else
                v3 = u42
                v4 = #greetings - 1
                v1 = v3:NextInteger(1, v4)
                if v2 <= v1 then
                    v1 = v1 + 1
                end
            end
        end
        u40[self.Tree.id] = v1
        return greetings[v1]
    end
    return nil
end

function u38:_getNodeLines(p2, p3) -- Line: 127
    local v1, v2
    local clone = table.clone
    local lines = p3.lines
    if not lines then
        lines = {}
    end
    local v3 = clone(lines)
    if p2 == self.Tree.root and self.Tree.greetings then
        v2 = #self.Tree.greetings
        if 0 < v2 then
            v2 = self:_chooseGreeting()
            if #v3 ~= 0 then
                v3[1] = v2
            else
                table.insert(v3, v2)
            end
        end
    end
    if #v3 == 0 then
        table.insert(v3, "")
    end
    v2 = table.create(#v3)
    for i, v in ipairs(v3) do
        v1 = self:_resolveLine(v)
        table.insert(v2, v1)
    end
    return v2
end

function u38:_playCurrentLine() -- Line: 148 -- upvalues: splitGraphemes (val), DialogueDefaults (val), u44 (val)
    local v1
    self._typingGeneration = self._typingGeneration + 1
    local _typingGeneration = self._typingGeneration
    local v2 = self._lines[self._lineIndex] or ""
    local u10 = splitGraphemes(v2)
    local v3 = 0 < #u10
    self._typing = v3
    local UI = self.UI
    if not self._typing then
        v1 = -1
    else
        v1 = 0
    end
    UI:SetLine(v2, v1)
    if not self._typing then
        return
    end
    task.spawn(function() -- Line: 159
        -- upvalues: u10 (val), self (val), _typingGeneration (val), DialogueDefaults (upval), u44 (upval)
        local CharacterDelay
        for i, v in ipairs(u10) do
            if not self._stopped and _typingGeneration == self._typingGeneration then
                self.UI:SetVisibleGraphemes(i)
                self.UI:PlayTypeSound()
                CharacterDelay = DialogueDefaults.CharacterDelay
                if u44[v] then
                    CharacterDelay = CharacterDelay + DialogueDefaults.PunctuationDelay
                end
                task.wait(CharacterDelay)
                continue
            end
            return
        end
        if not self._stopped and _typingGeneration == self._typingGeneration then
            self._typing = false
        end
    end)
end

function u38:_enterNode(p2) -- Line: 178
    local v1 = self.Tree.nodes[p2]
    if not v1 then
        warn(string.format("[DialogueSystem] Tree %s is missing node %s", self.Tree.id, (tostring(p2))))
        self:Stop("invalid-node")
        return
    end
    self:_stopNodeAnimation()
    self.UI:ClearOptions()
    self._optionsVisible = false
    self._nodeId = p2
    self._node = v1
    self.Context.visited[p2] = (self.Context.visited[p2] or 0) + 1
    self._lines = self:_getNodeLines(p2, v1)
    self._lineIndex = 1
    local UI = self.UI
    local speaker = v1.speaker
    if not speaker then
        speaker = self.Tree.speaker
    end
    UI:SetSpeaker(speaker)
    local UI_2 = self.UI
    local portrait = v1.portrait
    if not portrait then
        portrait = self.Tree.portrait
        if not portrait then
            portrait = ""
        end
    end
    UI_2:SetPortrait(portrait)
    if v1.animation and self.Options.animationPlayer then
        local success, result = pcall(self.Options.animationPlayer, self.Context.npc, v1.animation, Enum.AnimationPriority.Action)
        if not success then
            if not success then
                warn(string.format("[DialogueSystem] Animation player failed: %s", (tostring(result))))
            end
        elseif type(result) == "function" then
            self._animationCleanup = result
        elseif not success then
            warn(string.format("[DialogueSystem] Animation player failed: %s", (tostring(result))))
        end
    end
    self:_playCurrentLine()
end

function u38:_visibleOptions() -- Line: 210 -- upvalues: DialogueDefaults (val)
    local result, success, v1, v2
    local v3 = {}
    local v4 = ipairs
    local options = self._node.options
    if not options then
        options = {}
    end
    local v5 = self
    for i, v in v4(options) do
        v2 = true
        if v.condition then
            success, result = pcall(v.condition, v5.Context)
            if success then
                v2 = result == true
            else
                warn(string.format("[DialogueSystem] Option condition failed in %s/%s: %s", v5.Tree.id, v5._nodeId, result))
                v2 = false
            end
        end
        if v2 then
            v1 = {text = v.text, action = v.action, style = v.style or "default"}
            table.insert(v3, v1)
        end
    end
    if not v5._node.noCancel then
        local v6 = {text = DialogueDefaults.CancelText}
        local cancelAction = v5.Tree.cancelAction
        if not cancelAction then
            cancelAction = {kind = "end"}
        end
        v6.action = cancelAction
        v6.style = DialogueDefaults.CancelStyle
        table.insert(v3, v6)
    end
    for i2, i3 in ipairs(v3) do
        i3.index = i2
    end
    return v3
end

function u38:_presentOptions() -- Line: 252 -- upvalues: UserInputService (val)
    local v1 = self:_visibleOptions()
    if #v1 == 0 then
        self:Stop("completed")
        return
    end
    self._options = v1
    self._optionsVisible = true
    self._confirmArmed = false
    self._stickArmed = true
    self._gamepadIndex = 1
    self.UI:SetOptions(v1, function(p1) -- Line: 263 -- upvalues: self (val)
        self:_chooseOption(p1)
    end)
    if not UserInputService:GetLastInputType().Name:find("Gamepad", 1, true) then
        self.UI:SetSelectedIndex(0)
        return
    end
    local UI_2 = self.UI
    local _gamepadIndex = self._gamepadIndex
    UI_2:SetSelectedIndex(_gamepadIndex)
end

function u38:_invokeHandler(p2) -- Line: 273
    local handlers = self.Options.handlers
    if handlers then
        handlers = self.Options.handlers[p2.handler]
    end
    if handlers then
        local Context = self.Context
        self:Stop("invoked")
        task.defer(function() -- Line: 282 -- upvalues: handlers (val), p2 (val), Context (val)
            local success, result = pcall(handlers, p2.args, Context)
            if not success then
                local v1 = warn
                local format = string.format
                local v2 = p2
                local handler = v2.handler
                v1(format("[DialogueSystem] Handler %s failed: %s", tostring(handler), (tostring(result))))
            end
        end)
        return
    end
    local v1 = warn
    local format = string.format
    local handler = p2.handler
    v1(format("[DialogueSystem] Unknown handler %s in tree %s", tostring(handler), self.Tree.id))
    self:Stop("unknown-handler")
end

function u38:_performAction(p2) -- Line: 290
    if type(p2) ~= "table" then
        warn(string.format("[DialogueSystem] Invalid action in %s/%s", self.Tree.id, self._nodeId))
        return
    end
    if p2.kind == "goto" then
        local node = p2.node
        self:_enterNode(node)
        return
    end
    if p2.kind == "end" then
        self:Stop("selected-end")
        return
    end
    if p2.kind == "invoke" then
        self:_invokeHandler(p2)
        return
    end
    local v1 = warn
    local format = string.format
    local kind = p2.kind
    v1(format("[DialogueSystem] Unknown action kind %s", (tostring(kind))))
end

function u38:_chooseOption(p2) -- Line: 305
    if not self._stopped and self._optionsVisible then
        local v1 = self._options[p2]
        if not v1 then
            return
        end
        local action = v1.action
        self:_performAction(action)
        return
    end
end

function u38:_moveGamepadSelection(p2) -- Line: 316
    if not self._stopped and self._optionsVisible then
        local v1
        local SelectedIndex = self.UI:GetSelectedIndex()
        if not (0 < SelectedIndex) then
            v1 = self._gamepadIndex or 1
        else
            v1 = SelectedIndex
        end
        local v2 = v1 + p2
        local v3 = #self._options
        self._gamepadIndex = math.clamp(v2, 1, v3)
        local UI = self.UI
        local _gamepadIndex = self._gamepadIndex
        UI:SetSelectedIndex(_gamepadIndex)
        return true
    end
    return false
end

function u38:_advance() -- Line: 327
    if not self._stopped and self._ready and not self._optionsVisible then
        if self._typing then
            self._typingGeneration = self._typingGeneration + 1
            self._typing = false
            self.UI:SetVisibleGraphemes(-1)
            return
        end
        if self._lineIndex < #self._lines then
            self._lineIndex = self._lineIndex + 1
            self:_playCurrentLine()
            return
        end
        if self._node.options then
            self:_presentOptions()
            return
        end
        if not self._node.completionAction then
            self:Stop("completed")
            return
        end
        local completionAction = self._node.completionAction
        self:_performAction(completionAction)
        return
    end
end

function u38:_checkDistance() -- Line: 349 -- upvalues: getPosition (val)
    local Character = self.Context.player.Character
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    local v1 = getPosition(self.Context.npc)
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") and v1 then
        local v2 = HumanoidRootPart.Position - v1
        local v3 = v2:Dot(v2)
        if self._leaveRange * self._leaveRange < v3 then
            self:Stop("walked-away")
        end
        return
    end
    self:Stop("missing-subject")
end

function u38:_bindLifetime() -- Line: 363
    -- upvalues: RunService (val), DialogueDefaults (val), ContextActionService (val), UserInputService (val), u49 (val)
    -- upvalues: u43 (ref)
    local v1
    local Character = self.Context.player.Character
    if not Character then
        self:Stop("missing-character")
        return
    end
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        local _connections = self._connections
        v1 = Humanoid.Died:Connect(function() -- Line: 373 -- upvalues: self (val)
            self:Stop("player-died")
        end)
        table.insert(_connections, v1)
    end
    local _connections_2 = self._connections
    v1 = self.Context.player.CharacterRemoving:Connect(function(p1) -- Line: 380 -- upvalues: Character (val), self (val)
        if p1 == Character then
            self:Stop("character-removed")
        end
    end)
    table.insert(_connections_2, v1)
    local _connections_3 = self._connections
    v1 = self.Context.npc.AncestryChanged:Connect(function(p1, p2) -- Line: 388 -- upvalues: self (val)
        if not p2 then
            self:Stop("npc-removed")
        end
    end)
    table.insert(_connections_3, v1)
    local _connections_4 = self._connections
    v1 = self.Context.npc.Destroying:Connect(function() -- Line: 396 -- upvalues: self (val)
        self:Stop("npc-destroyed")
    end)
    table.insert(_connections_4, v1)
    local u52 = 0
    local _connections_5 = self._connections
    local v2 = RunService
    v2 = v2.Heartbeat:Connect(function(p1) -- Line: 404 -- upvalues: u52 (ref), DialogueDefaults (upval), self (val)
        u52 = u52 + p1
        if u52 < DialogueDefaults.DistanceCheckInterval then
            return
        end
        u52 = 0
        self:_checkDistance()
    end)
    table.insert(_connections_5, v2)
    self._gamepadBound = true
    local v3 = ContextActionService
    local Value = Enum.ContextActionPriority.High.Value
    local ButtonA = Enum.KeyCode.ButtonA
    local ButtonB = Enum.KeyCode.ButtonB
    local DPadUp = Enum.KeyCode.DPadUp
    local DPadDown = Enum.KeyCode.DPadDown
    local Thumbstick1 = Enum.KeyCode.Thumbstick1
    v3:BindActionAtPriority("ZS_DialogueGamepad", function(p1, p2, p3) -- Line: 417 -- upvalues: self (val)
        if self._stopped then
            return Enum.ContextActionResult.Pass
        end
        local KeyCode = p3.KeyCode
        if KeyCode == Enum.KeyCode.ButtonA then
            if p2 ~= Enum.UserInputState.Begin then
                if p2 == Enum.UserInputState.End then
                    self._confirmArmed = true
                    return Enum.ContextActionResult.Sink
                end
                return Enum.ContextActionResult.Pass
            end
            if not self._optionsVisible then
                self:_advance()
            elseif self._confirmArmed then
                local SelectedIndex = self.UI:GetSelectedIndex()
                if 0 < SelectedIndex then
                    self._gamepadIndex = SelectedIndex
                    self:_chooseOption(SelectedIndex)
                end
            end
            return Enum.ContextActionResult.Sink
        end
        if KeyCode == Enum.KeyCode.ButtonB and p2 == Enum.UserInputState.Begin then
            self:Interrupt()
            return Enum.ContextActionResult.Sink
        end
        if p2 == Enum.UserInputState.Begin and KeyCode == Enum.KeyCode.DPadUp then
            if self:_moveGamepadSelection(-1) then
                return Enum.ContextActionResult.Sink
            end
            return Enum.ContextActionResult.Pass
        end
        if p2 == Enum.UserInputState.Begin and KeyCode == Enum.KeyCode.DPadDown then
            if self:_moveGamepadSelection(1) then
                return Enum.ContextActionResult.Sink
            end
            return Enum.ContextActionResult.Pass
        end
        if KeyCode == Enum.KeyCode.Thumbstick1 and p2 == Enum.UserInputState.Change then
            local Y = p3.Position.Y
            local v1 = math.abs(Y)
            if v1 < 0.35 then
                self._stickArmed = true
            elseif self._stickArmed then
                v1 = math.abs(Y)
                if 0.6 < v1 and self._optionsVisible then
                    local v2
                    self._stickArmed = false
                    v1 = self
                    if not (0 < Y) then
                        v2 = 1
                    else
                        v2 = -1
                    end
                    v1:_moveGamepadSelection(v2)
                end
            end
        end
        return Enum.ContextActionResult.Pass
    end, false, Value, ButtonA, ButtonB, DPadUp, DPadDown, Thumbstick1)
    local _connections_6 = self._connections
    v2 = UserInputService
    v2 = v2.InputBegan:Connect(function(p1, p2) -- Line: 475 -- upvalues: self (val), u49 (upval), u43 (upval)
        if self._stopped then
            return
        end
        local KeyCode = p1.KeyCode
        if KeyCode == Enum.KeyCode.Escape then
            self:Interrupt()
            return
        end
        if p2 then
            return
        end
        if u49[KeyCode] then
            u43 = os.clock() + 0.1
        end
        local v1 = u49[KeyCode]
        if v1 and self._optionsVisible then
            self:_chooseOption(v1)
            return
        end
        if KeyCode == Enum.KeyCode.E or KeyCode == Enum.KeyCode.Space then
            self:_advance()
        end
    end)
    table.insert(_connections_6, v2)
end

function u38:Stop(p2) -- Line: 505 -- upvalues: ContextActionService (val), u39 (ref), u37 (val)
    if self._stopped then
        return
    end
    self._stopped = true
    self._typingGeneration = self._typingGeneration + 1
    local _ready = self._ready
    self._ready = false
    if self._gamepadBound then
        self._gamepadBound = false
        ContextActionService:UnbindAction("ZS_DialogueGamepad")
    end
    if u39 == self then
        u39 = nil
    end
    self:_stopNodeAnimation()
    for i, v in ipairs(self._connections) do
        if v then
            v:Disconnect()
        end
    end
    table.clear(self._connections)
    if self.UI then
        self.UI:Destroy()
    end
    if _ready then
        u37.ActiveChanged:Fire(false)
    end
    self.Finished:Fire(p2 or "stopped")
    task.defer(function() -- Line: 532 -- upvalues: self (val)
        self.Finished:DisconnectAll()
    end)
end

function u38:Interrupt() -- Line: 537
    self:Stop("interrupted")
end

u37.ActiveChanged = Signal.new()

function u37.Start(p1) -- Line: 543
    -- upvalues: u39 (ref), Players (val), Signal (val), DialogueDefaults (val), u38 (val), DialogueUI (val), u37 (val)
    local v1 = type(p1) == "table"
    assert(v1, "DialogueSystem.Start expects an options table")
    local tree = p1.tree
    v1 = type(tree) == "table"
    assert(v1, "DialogueSystem.Start requires a tree")
    local npc = p1.npc
    v1 = typeof(npc) == "Instance"
    assert(v1, "DialogueSystem.Start requires an NPC Instance")
    if u39 then
        u39:Stop("replaced")
    end
    local tree_2 = p1.tree
    local v2 = false
    local id = tree_2.id
    if type(id) == "string" then
        v2 = tree_2.id ~= ""
    end
    assert(v2, "Dialogue tree requires an id")
    v2 = false
    local root = tree_2.root
    if type(root) == "string" then
        v2 = false
        local nodes = tree_2.nodes
        if type(nodes) == "table" then
            v2 = tree_2.nodes[tree_2.root]
        end
    end
    assert(v2, "Dialogue tree root is missing")
    local startNode = p1.startNode
    local v3 = startNode
    if type(v3) ~= "string" or not tree_2.nodes[startNode] then
        startNode = tree_2.root
    end
    v3 = {
        _typing = false,
        _typingGeneration = 0,
        _optionsVisible = false,
        _confirmArmed = false,
        _gamepadIndex = 1,
        _stickArmed = true,
        _stopped = false,
        _ready = false,
        _gamepadBound = false,
    }
    v3.Tree = tree_2
    v3.Options = p1
    local v4 = {}
    local player = p1.player
    if not player then
        player = Players.LocalPlayer
    end
    v4.player = player
    v4.data = p1.data
    v4.npc = p1.npc
    v4.visited = {}
    local flags = p1.flags
    if not flags then
        flags = {}
    end
    v4.flags = flags
    local values = p1.values
    if not values then
        values = {}
    end
    v4.values = values
    v3.Context = v4
    v3.Finished = Signal.new()
    v3._connections = {}
    v3._options = {}
    local leaveRange = tree_2.leaveRange
    if not leaveRange then
        local interactRange = tree_2.interactRange
        if not interactRange then
            interactRange = DialogueDefaults.InteractRange
        end
        leaveRange = interactRange + DialogueDefaults.LeaveRangePadding
    end
    v3._leaveRange = leaveRange
    v4 = u38
    local u124 = setmetatable(v3, v4)
    local success, result = pcall(function() -- Line: 588
        -- upvalues: u124 (val), DialogueUI (upval), DialogueDefaults (upval), p1 (val), u39 (upval), startNode (ref)
        local v1 = u124
        local v2 = DialogueUI
        local new = v2.new
        local v3 = {
            ClickSound = DialogueDefaults.ClickSound,
            Npc = p1.npc,
            OnAdvance = function() -- Line: 592 -- upvalues: u124 (upval)
                u124:_advance()
            end,
        }
        v1.UI = new(v3)
        u39 = u124
        u124:_bindLifetime()
        if not u124._stopped then
            v1 = u124
            v3 = startNode
            v1:_enterNode(v3)
        end
    end)
    if not success then
        local success_2, result_2 = pcall(u124.Stop, u124, "startup-failed")
        if not success_2 then
            warn("[DialogueSystem] Failed to clean up startup:", result_2)
        end
        error(result, 0)
    end
    if not u124._stopped then
        u124._ready = true
        u37.ActiveChanged:Fire(true)
    end
    return u124
end

function u37.Stop(p1) -- Line: 616 -- upvalues: u39 (ref)
    if u39 then
        u39:Stop(p1 or "host-stopped")
    end
end

function u37.IsActive() -- Line: 622 -- upvalues: u39 (ref)
    local v1 = false
    if u39 ~= nil then
        v1 = not u39._stopped
    end
    return v1
end

function u37.BlocksGameplayInput() -- Line: 626 -- upvalues: u37 (val), u43 (ref)
    local v1 = u37.IsActive()
    if not v1 then
        v1 = os.clock() <= u43
    end
    return v1
end

return u37