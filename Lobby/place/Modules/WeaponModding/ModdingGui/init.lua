local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedResources = ReplicatedStorage.common:WaitForChild("SharedResources")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local Sounds = script:WaitForChild("Sounds")
local Attachments = script:WaitForChild("Attachments")
local WeaponStats = Attachments:WaitForChild("WeaponStats")
local ProsCons = Attachments.ProsCons
local TextTemplate = ProsCons.Pros.List.TextTemplate
TextTemplate.Parent = nil
local PurchaseMod = Attachments.PurchaseMod
local Nodes = Attachments:WaitForChild("Nodes")
local Template = Nodes:WaitForChild("Template")
Template.Parent = nil
Template.Visible = true
local Attachments_2 = Attachments.Attachments
local ScrollingFrame = Attachments_2.ScrollingFrame
local Scrollbar = Attachments_2.Scrollbar
local Template_2 = ScrollingFrame.Template
Template_2.Parent = nil
local Progression = Attachments.Progression
local LevelLabel = Progression.LevelLabel
local FillSliceFrame = Progression.XPBarFrame.FillSliceFrame
local LowerXPLabel = Progression.XPBarFrame.LowerXPLabel
local UpperXPLabel = FillSliceFrame.UpperXPLabel
local CurrentCamera = workspace.CurrentCamera
local common = game.ReplicatedStorage.common
game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
local DataRemote = Remotes:WaitForChild("DataRemote")
local place = game.ReplicatedStorage:FindFirstChild("place")
local RedEvents = place
if RedEvents then
    RedEvents = place:FindFirstChild("RedEvents")
end
local MiscFunctions = require(script.Parent:WaitForChild("MiscFunctions"))
local GuiTransparency = require(script:WaitForChild("GuiTransparency"))
local AttachmentSystem = require(SharedResources.Attachments:WaitForChild("AttachmentSystem"))
local AttachmentsRoot = require(SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local AttachmentEntitlements = require(SharedResources.Attachments:WaitForChild("AttachmentEntitlements"))
local WeaponStatsUI = require(script:WaitForChild("WeaponStatsUI"))
local u149 = WeaponStatsUI(WeaponStats)
local WepConfig = require(ReplicatedStorage.common:WaitForChild("WepConfig"))
local ScrollBar = require(common.ScrollBar)
local ItemData = require(common.ItemData)
local LevelInfo = require(common:WaitForChild("LevelInfo"))
local Signal = require(common.Signal)
local NPCs_Shared = common:WaitForChild("NPCs_Shared")
local Utils = NPCs_Shared:WaitForChild("Utils")
local DamageFalloffUtil = require(Utils:WaitForChild("DamageFalloffUtil"))
local drawLine = MiscFunctions.drawLine
local clickEvent = MiscFunctions.clickEvent
local function awaitDress(p1, p2) -- Line: 67
    local v1, v2
    v1, v2 = p1:timeout(10):await()
    if not v1 then
        warn("[WeaponModding] DressWeapon timed out or failed (" .. p2 .. "):\n" .. tostring(v2))
    end
    return v1
end
local ModificationEvent = RedEvents
if ModificationEvent then
    ModificationEvent = RedEvents:FindFirstChild("ModificationEvent")
    if ModificationEvent then
        ModificationEvent = require(RedEvents.ModificationEvent)
    end
end
local u200 = nil
local u201 = false
local u202 = {}
local u203 = false
local u204 = nil
local u207 = nil
local u212 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local u213 = {}
local u214 = {}
local u215 = {}
local u216 = {}
local u217 = {}
local u218 = {}
local u219 = nil
local u220 = {}
local u221 = {}
local u222 = {}
local u223 = {}
local u224 = {}
local u225 = nil
local u226 = nil
local u227 = nil
local u228 = nil
local u229 = nil
local u230 = false
local u231 = nil
local v1 = {}
local v2 = ColorSequenceKeypoint.new(0, Color3.fromHex("8f8f8f"))
local v3 = ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1))
v1[1] = v2
v1[2] = v3
v1[3] = ColorSequenceKeypoint.new(1, Color3.fromHex("98ffa1"))
local u254 = ColorSequence.new(v1)
v2 = {}
v3 = ColorSequenceKeypoint.new(0, Color3.fromHex("8f8f8f"))
local v4 = ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1))
v2[1] = v3
v2[2] = v4
v2[3] = ColorSequenceKeypoint.new(1, Color3.fromHex("8fe7ff"))
local u277 = ColorSequence.new(v2)
v3 = {}
v4 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
local v5 = ColorSequenceKeypoint.new(0.53, Color3.new(1, 1, 1))
v3[1] = v4
v3[2] = v5
v3[3] = ColorSequenceKeypoint.new(1, Color3.new())
local u301 = ColorSequence.new(v3)
local u302 = {}
v4 = clickEvent(Attachments.Exit)
local u311 = Signal.new()
v4:Connect(function() -- Line: 134 -- upvalues: u311 (val)
    removePreviewAttachments()
    closePurchaseModPrompt()
    u311:Fire()
end)
u302.ExitPressed = u311
u302.OptionGroupChanged = Signal.new()
function u302.init() end
function u302.exitMod() -- Line: 147 -- upvalues: Attachments (val)
    Attachments.Parent = script
end
function u302.loadGui(p1, p2, p3, p4, p5, p6) -- Line: 151 -- upvalues: u202 (ref), u201 (ref), u203 (ref), u200 (ref), DataRemote (val), u226 (ref), ItemData (val), u221 (ref), u222 (ref), u229 (ref), WepConfig (val), u149 (val), LevelInfo (val), LevelLabel (val), FillSliceFrame (val), LowerXPLabel (val), UpperXPLabel (val), u213 (ref), AttachmentsRoot (val), u214 (val), u215 (val), u216 (val), u217 (val), u218 (val), u227 (ref), u225 (ref), u220 (ref), AttachmentSystem (val), u219 (ref), u204 (ref), u207 (ref), Attachments (val), PlayerGui (val)
    local v1, v2, v3, v4, v5
    local v6 = p4
    if not v6 then
        v6 = {}
    end
    u202 = v6
    u201 = p5 or false
    u203 = false
    if u201 then
        u200 = {
            Progression = {ZBucks = 999999, Weapons = {}},
        }
        v1 = p1
    else
        v6 = false
        v5 = 0
        while not v6 do
            if v5 >= 3 then
                break
            end
            v5 = v5 + 1
            v6 = pcall(function() -- Line: 163 -- upvalues: u200 (upval), DataRemote (upval)
                u200 = DataRemote:InvokeServer("GetData")
            end)
            if not v6 then
                task.wait(0.2)
            end
        end
        if not v6 then
            u200 = {
                Progression = {ZBucks = 999999, Weapons = {}},
            }
            u201 = true
        end
    end
    u226 = v1
    local ItemIdFromName = ItemData:GetItemIdFromName(u226)
    u221 = {}
    u222 = {}
    u229 = deepCopy(WepConfig:GetWeaponConfig(v1))
    u149:SetBaseStats(u229)
    u149:UpdateDisplay()
    v5 = u200.Progression.Weapons[ItemIdFromName]
    local v7 = 0
    local v8 = 0
    if v5 then
        v7 = v5[1]
        v8 = v5[2]
    end
    local v9 = LevelInfo:RequiredXp(v7)
    local v10 = ("%d/%d XP"):format(v8, v9)
    LevelLabel.Text = "LEVEL " .. v7
    FillSliceFrame.Size = UDim2.new(v8 / v9, 0, 1, 0)
    LowerXPLabel.Text = v10
    UpperXPLabel.Text = v10
    if not v11 then
        u213 = AttachmentsRoot.new(u229)
    else
        u213 = v11
    end
    local v12 = u214
    local v13 = nil
    local v14 = nil
    for i, j in v12, v13, v14 do
        j:Destroy()
    end
    v12 = u215
    v13 = nil
    v14 = nil
    for k, n in v12, v13, v14 do
        n:Destroy()
    end
    v12 = u216
    v13 = nil
    v14 = nil
    for m, i5 in v12, v13, v14 do
        i5:Destroy()
    end
    table.clear(u214)
    table.clear(u215)
    table.clear(u216)
    table.clear(u217)
    table.clear(u218)
    u227 = nil
    u225 = nil
    u220 = {}
    local GlobalParts = v15:FindFirstChild("GlobalParts")
    if GlobalParts then
        local BasePoints = GlobalParts:FindFirstChild("BasePoints")
        if BasePoints then
            local NodeIDFromName
            local Children = BasePoints:GetChildren()
            v2 = Children
            v3 = nil
            local v16 = nil
            for i6, i7 in v2, v3, v16 do
                NodeIDFromName = u213:GetNodeIDFromName(i7.Name)
                MakeGui(i7, v15, NodeIDFromName, u213, false)
            end
            if 0 < #Children and v15.Parent then
                v2 = u218[1]
                u229 = deepCopy(WepConfig:GetWeaponConfig(v15.Name))
                v3 = AttachmentSystem.DressWeapon(v15.Name, u213, u229.AttachmentNodeData, v15, v2)
                v16, v4 = v3:timeout(10):await()
                if not v16 then
                    warn("[WeaponModding] DressWeapon timed out or failed (" .. "loadGui populate" .. "):\n" .. tostring(v4))
                end
                u149:UpdateStats(u229)
                u149:UpdateDisplay()
            end
        end
    end
    v13 = u202
    v14 = nil
    v2 = nil
    for i8 in v13, v14, v2 do
        v4 = u217[i8]
        if v4 then
            v4.Visible = false
        end
    end
    u219 = v17
    if v17 then
        u204(v15)
        v13 = v17
        v14 = nil
        v2 = nil
        for i9, i10 in v13, v14, v2 do
            u207(i9, i10.members, v15)
        end
    end
    local DisplayName = u213:GetDisplayName(v1)
    v3 = string.upper(DisplayName)
    Attachments.Header.TextLabel.Text = v3 .. " ATTACHMENTS"
    setMode("Nodes")
    Attachments.Parent = PlayerGui
end
function u302.getAttached() -- Line: 316 -- upvalues: u213 (ref), ItemData (val), u226 (ref)
    local v1 = u213:Serialize()
    return v1, (ItemData:GetItemIdFromName(u226))
end
function setMode(p1) -- Line: 323 -- upvalues: u149 (val), Attachments_2 (val), ProsCons (val), u203 (ref), Nodes (val), u227 (ref), Attachments (val), u226 (ref)
    local v1
    u149:UpdatePlacement(p1)
    local v2 = p1 ~= "Nodes"
    Attachments_2.Visible = v2
    v2 = if p1 ~= "Nodes" then not u203 else false
    ProsCons.Visible = v2
    v2 = p1 == "Nodes"
    Nodes.Visible = v2
    if p1 ~= "Attachments" then
        v1 = string.upper(u226)
        Attachments.Header.TextLabel.Text = v1 .. " ATTACHMENTS"
        return
    end
    if u227 then
        Attachments.Header.TextLabel.Text = string.upper(u227.Name)
        return
    end
    v1 = string.upper(u226)
    Attachments.Header.TextLabel.Text = v1 .. " ATTACHMENTS"
end
function setAttachmentButtonSelected(p1, p2) -- Line: 335 -- upvalues: u277 (val), u254 (val), u301 (val)
    if not p2 then
        if p1.Parent.Name ~= "NONE" and p1.LockedFrame.Visible then
            p1.LockedFrame.LinePattern.TileSize = UDim2.new(0.1, 0, 0.1, 0)
        end
        p1.UIGradient.Color = u301
        if p1.Parent.Name == "NONE" then
            p1.ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        else
            p1.TextLine1.Position = UDim2.new(0.5, 0, 0.8, 0)
            p1.TextLine2.Position = UDim2.new(0.5, 0, 0.93, 0)
            p1.TextLine1.Size = UDim2.new(0.86, 0, 0.15, 0)
            p1.TextLine2.Size = UDim2.new(0.86, 0, 0.15, 0)
            p1.ImageLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
            p1.LockedFrame.LockLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
            p1.LockedFrame.LockLabel.Size = UDim2.new(0.17, 0, 0.17, 0)
            p1.LockedFrame.LevelLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            p1.LockedFrame.PriceLabel.Position = UDim2.new(0.5, 0, 0.8, 0)
        end
        p1.Size = UDim2.new(0.947, 0, 0.852, 0)
    else
        if p1.Parent.Name == "NONE" then
            p1.UIGradient.Color = u254
        elseif p1.LockedFrame.Visible then
            p1.UIGradient.Color = u277
            p1.LockedFrame.LinePattern.TileSize = UDim2.new(0.1, 0, 0.0852, 0)
        end
        if p1.Parent.Name == "NONE" then
            p1.ImageLabel.Position = UDim2.new(0.5, 0, 0.426, 0)
        else
            p1.TextLine1.Position = UDim2.new(0.5, 0, 0.682, 0)
            p1.TextLine2.Position = UDim2.new(0.5, 0, 0.792, 0)
            p1.TextLine1.Size = UDim2.new(0.86, 0, 0.1278, 0)
            p1.TextLine2.Size = UDim2.new(0.86, 0, 0.1278, 0)
            p1.ImageLabel.Position = UDim2.new(0.5, 0, 0.0852, 0)
            p1.LockedFrame.LockLabel.Position = UDim2.new(0.5, 0, 0.0852, 0)
            p1.LockedFrame.LockLabel.Size = UDim2.new(0.17, 0, 0.145, 0)
            p1.LockedFrame.LevelLabel.Position = UDim2.new(0.5, 0, 0.426, 0)
            p1.LockedFrame.PriceLabel.Position = UDim2.new(0.5, 0, 0.6816, 0)
        end
        p1.Size = UDim2.new(0.947, 0, 1, 0)
    end
    p1.SelectionFrame.Visible = p2
end
function setSelectionFrameAppearance(p1, p2) -- Line: 386
    local SelectionFrame = p1:WaitForChild("SelectionFrame")
    local v1 = nil
    local v2 = nil
    if p2 == "equip" then
        v1 = Color3.fromRGB(152, 255, 161)
        v2 = "EQUIP"
    elseif p2 == "unlock" then
        v1 = Color3.fromRGB(143, 231, 255)
        v2 = "UNLOCK"
    end
    local SliceTop = SelectionFrame:WaitForChild("SliceTop")
    SliceTop:WaitForChild("Frame").BackgroundColor3 = v1
    local SliceBottom = SelectionFrame:WaitForChild("SliceBottom")
    SliceBottom:WaitForChild("Frame").BackgroundColor3 = v1
    local SliceBottom_2 = SelectionFrame:WaitForChild("SliceBottom")
    SliceBottom_2:WaitForChild("TextLabel").Text = v2
end
function setProsCons(p1) -- Line: 403 -- upvalues: ProsCons (val), TextTemplate (val)
    local List, v1, v2, v3, v4
    local v5 = {"Pros", "Cons"}
    for k, v in pairs(v5) do
        List = ProsCons[v].List
        for k2, i in pairs(List:GetChildren()) do
            if i.Name ~= "UIListLayout" then
                i:Destroy()
            end
        end
        v4 = v1[v]
        if not v4 then
            v4 = {}
        end
        for k3, j in pairs(v4) do
            v2 = TextTemplate:Clone()
            if v ~= "Pros" then
                v3 = "<font color=\"#ff6363\">-</font>  "
            else
                v3 = "<font color=\"#75ff75\">+</font> "
            end
            v2.Text = v3 .. j
            v2.Name = "TEMP"
            v2.Visible = true
            v2.Parent = List
        end
    end
end
function MakeGui(p1, p2, p3, p4, p5) -- Line: 424 -- upvalues: u213 (ref), ItemData (val), u226 (ref), Template (val), u214 (val), ScrollingFrame (val), u215 (val), Attachments_2 (val), Scrollbar (val), ScrollBar (val), u216 (val), u217 (val), u220 (ref), u224 (ref), u229 (ref), DamageFalloffUtil (val), u218 (val), Sounds (val), u221 (ref), WepConfig (val), AttachmentSystem (val), u149 (val), u200 (ref), Attachments (val), AttachmentEntitlements (val), u201 (ref), Template_2 (val), TextService (val), LevelInfo (val), u223 (val), clickEvent (val), u228 (ref), u227 (ref), u225 (ref), u302 (val), u231 (ref), u222 (ref), GuiTransparency (val), u212 (val), RunService (val), CurrentCamera (val), drawLine (val), Nodes (val)
    local Alias, Alias_2, DropShadow, Font, Font_2, Image, ImageLabel, LevelLabel, LockedFrame, TextLine2, destroyNodePartTree, getTextWidth, selectAttachment, u1003, u1007, u1010, u982, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18
    local AttachmentNodeData = u213:GetAttachmentNodeData()
    local ItemIdFromName = ItemData:GetItemIdFromName(u226)
    local u1053 = Template:Clone()
    table.insert(u214, u1053)
    u1053.Name = p1.Name
    local v19 = u1053:WaitForChild("Frame")
    local v20 = v19:WaitForChild("TopLabel")
    local u47 = v19:WaitForChild("BottomLabel")
    local u52 = v19:WaitForChild("ImageLabel")
    local u1075 = v19:WaitForChild("Point")
    local u1080 = ScrollingFrame:Clone()
    table.insert(u215, u1080)
    u1080.Parent = Attachments_2
    local v21 = Scrollbar:Clone()
    local u1101 = ScrollBar.new(v21, u1080, "X")
    table.insert(u216, u1101)
    v21.Parent = Attachments_2
    v20.Text = p1.Name
    u47.Text = "NONE"
    local v22 = p4:GetNodes()[p3]
    local ConnectedAttachment = v22
    if ConnectedAttachment then
        ConnectedAttachment = v22.ConnectedAttachment
    end
    if ConnectedAttachment then
        local AttachmentIndex = ConnectedAttachment:GetAttachmentIndex()
        v1 = AttachmentNodeData[p3]
        if v1 then
            v1 = AttachmentNodeData[p3].PotentialAttachments[AttachmentIndex]
        end
        if v1 then
            Alias = v1.Alias
            if not Alias then
                Alias = v1.Name
            end
            u47.Text = string.upper(Alias)
            if not v1.Image then
                Image = "rbxassetid://4923293939"
            else
                Image = v1.Image
            end
            u52.Image = Image
        end
    end
    u217[p1.Name] = u1053
    local u134 = {}
    local PotentialAttachments = AttachmentNodeData[u213:GetNodeIDFromName(p1.Name)].PotentialAttachments
    if not PotentialAttachments then
        PotentialAttachments = {}
    end
    v1 = nil
    local v23 = nil
    for i, j in PotentialAttachments, v1, v23 do
        table.insert(u134, j)
    end
    u134[0] = {Name = "NONE"}
    function destroyNodePartTree(p1) -- Line: 491 -- upvalues: u220 (upval), destroyNodePartTree (val)
        local NodeParts = p1.NodeParts
        local v1 = nil
        local v2 = nil
        for i, j in NodeParts, v1, v2 do
            j:Destroy()
        end
        local v3 = u220[p1.Object.Parent]
        local NodeID = p1.Object:GetNodeID()
        v3[NodeID] = nil
        v3 = u220[p1.Object]
        if v3 then
            v1 = v3
            v2 = nil
            local v4 = nil
            for k, n in v1, v2, v4 do
                destroyNodePartTree(n)
            end
        end
    end
    local function AttachAttachment(a1, a2, a3, a4) -- Line: 507 -- upvalues: p3 (val), p4 (val), AttachmentNodeData (val), u47 (ref), u52 (ref), u224 (upval), u220 (upval), destroyNodePartTree (val), p1 (val), p2 (val), u229 (upval), DamageFalloffUtil (upval)
        local v1, v2, v3, v4
        a1:GetAttachmentNodeData()
        local NodeID = a1:GetNodeID()
        if NodeID == p3 and a1.Parent == p4 then
            local Image
            v3 = AttachmentNodeData[NodeID].PotentialAttachments[a1:GetAttachmentIndex()]
            local Alias = v3.Alias
            if not Alias then
                Alias = v3.Name
            end
            v4 = string.upper(Alias)
            if not v3.Image then
                Image = "rbxassetid://4923293939"
            else
                Image = v3.Image
            end
            u47.Text = v4
            u52.Image = Image
        end
        u224 = a4
        local v5 = u220[a1.Parent]
        if not v5 then
            u220[a1.Parent] = {}
        else
            v3 = v5[a1:GetNodeID()]
            if v3 and v3.Object ~= a1 then
                destroyNodePartTree(v3)
            end
        end
        if not a2 then
            v2, v1 = a3, a2
        else
            local NodeParts = a2:FindFirstChild("NodeParts")
            if not NodeParts then
                v2, v1 = a3, a2
            else
                local Attribute, NodeIDFromName, Weld, v6, v7
                v4 = v5[a1:GetNodeID()]
                if not v4 then
                    v5[a1:GetNodeID()] = {Object = a1, NodeParts = {}}
                end
                v6, v2, v1 = a1, a3, a2
                for i, j in NodeParts:GetChildren() do
                    if not (v4.NodeParts[j.Name]) then
                        v7 = p1
                        Weld = Instance.new("Weld")
                        Weld.Name = "ExpansionWeld"
                        Weld.Part0 = v7
                        Weld.Part1 = j
                        Weld.C0 = CFrame.new()
                        Weld.C1 = j.CFrame:toObjectSpace(v7.CFrame)
                        Weld.Parent = j
                        j.Parent = p2.KeyParts
                        Attribute = j:GetAttribute("NodeName")
                        if not Attribute then
                            Attribute = j.Name
                        end
                        j.Name = Attribute
                        v4.NodeParts[j.Name] = j
                        NodeIDFromName = v6:GetNodeIDFromName(j.Name)
                        MakeGui(j, p2, NodeIDFromName, v6, false)
                    end
                end
            end
        end
        v3 = nil
        if v2 then
            local SettingChanges
            v3 = require(v2).new(v1, u229, {Model = p2})
            if v3.SettingChanges then
                SettingChanges = v3.SettingChanges
                local v8 = nil
                local v9 = nil
                for k, n in SettingChanges, v8, v9 do
                    if k == "Damage" and u229.DamageDropoff and not v3.SettingChanges.DamageDropoff then
                        u229.DamageDropoff = DamageFalloffUtil.RescaleDropoff(u229.DamageDropoff, u229.Damage, n)
                    end
                    u229[k] = n
                end
            end
        end
        return v3
    end
    table.insert(u218, AttachAttachment)
    function selectAttachment(p1, a2, a3) -- Line: 604 -- upvalues: Sounds (upval), u221 (upval), p4 (val), p3 (val), u134 (val), selectAttachment (val), u220 (upval), destroyNodePartTree (val), u229 (upval), WepConfig (upval), p2 (val), AttachmentSystem (upval), u213 (upval), AttachAttachment (val), u149 (upval), u47 (ref), u52 (ref)
        local v1, v2, v3
        local Alias = a2.Alias
        if not Alias then
            Alias = a2.Name
        end
        local v4 = string.upper(Alias)
        local Children = Sounds.Att:GetChildren()
        Children[math.random(1, 3)]:Play()
        if not a3 then
            v1 = u221[p4]
            if v1 then
                v1[p3] = nil
            end
        else
            v1 = u221[p4]
            if not v1 then
                u221[p4] = {}
            end
            if not (v1[p3]) then
                local Nodes = p4:GetNodes()
                v2 = Nodes[p3]
                v3 = if v2 and v2.ConnectedAttachment then v2.ConnectedAttachment:GetAttachmentIndex() else 0
                v1[p3] = {OriginalAttachmentIndex = v3, OriginalProperties = u134[v3], SelectFunction = selectAttachment}
            end
        end
        p4:SetNodeAttachment(p3, p1)
        local Nodes_2 = p4:GetNodes()
        if not (Nodes_2[p3].ConnectedAttachment) then
            v1 = u220[p4]
            if v1 and v1[p3] then
                destroyNodePartTree(v1[p3])
            end
        end
        u229 = deepCopy(WepConfig:GetWeaponConfig(p2.Name))
        if p2.Parent then
            local Image
            p2.Attachments:ClearAllChildren()
            v1 = AttachmentSystem.DressWeapon(p2.Name, u213, u229.AttachmentNodeData, p2, AttachAttachment)
            v2, v3 = v1:timeout(10):await()
            if not v2 then
                warn("[WeaponModding] DressWeapon timed out or failed (" .. "selectAttachment" .. "):\n" .. tostring(v3))
            end
            u149:UpdateStats(u229)
            u149:UpdateDisplay()
            if not a2.Image then
                Image = "rbxassetid://4923293939"
            else
                Image = a2.Image
            end
            u47.Text = v4
            u52.Image = Image
        end
    end
    local function removePreview() -- Line: 665 -- upvalues: u221 (upval), p4 (val), p3 (val), selectAttachment (val)
        local v1 = u221[p4]
        if v1 then
            local v2 = v1[p3]
            if v2 then
                selectAttachment(v2.OriginalAttachmentIndex, v2.OriginalProperties)
            end
        end
    end
    local u1132 = {}
    local v24 = u200.Progression.Weapons[ItemIdFromName]
    if not v24 then
        v2 = {}
    else
        v2 = deserializeUnlockedAttachments(v24[3])
    end
    local AbsoluteSize = Attachments.AbsoluteSize
    local v25 = u134
    local v26 = nil
    local v27 = nil
    v9, u1003, u982, u1010, u1007 = p5, p2, p1, p4, p3
    for k, n in v25, v26, v27 do
        v3 = n.UnlockLevel or 999
        Alias_2 = n.Alias
        if not Alias_2 then
            Alias_2 = n.Name
        end
        local u406 = string.upper(Alias_2)
        local CleanUp = false
        local new = nil
        v6 = AttachmentEntitlements.HasEntitlement(u200, n)
        if not (AttachmentEntitlements.IsEntitlementGated(n)) then
            if u406 == "NONE" then
                CleanUp = true
                v5 = u1080:WaitForChild("NONE")
            elseif not u201 then
                if v6 then
                    CleanUp = true
                elseif not (table.find(v2, n.ID)) then
                end
                v5 = Template_2:Clone()
                v5.LayoutOrder = v3
            else
                CleanUp = true
                v5 = Template_2:Clone()
                v5.LayoutOrder = v3
            end
            local ImageButton = v5:WaitForChild("ImageButton")
            if u406 ~= "NONE" then
                ImageLabel = ImageButton:WaitForChild("ImageLabel")
                if n.Image then
                    ImageLabel.Image = n.Image
                    DropShadow = ImageLabel:WaitForChild("DropShadow")
                    DropShadow.Image = n.Image
                end
                local TextLine1 = ImageButton:WaitForChild("TextLine1")
                TextLine2 = ImageButton:WaitForChild("TextLine2")
                v11 = AbsoluteSize.Y * Attachments_2.Size.Y.Scale
                v12 = v11 * Template_2.Size.Y.Scale * ImageButton.Size.Y.Scale
                v13 = math.floor(v11 * Template_2.Size.X.Scale * ImageButton.Size.X.Scale * TextLine1.Size.X.Scale)
                local u529 = math.floor(v12 * TextLine1.Size.Y.Scale)
                function getTextWidth(p1) -- Line: 731 -- upvalues: TextService (upval), u529 (val), TextLine1 (val)
                    return TextService:GetTextSize(p1, u529, TextLine1.Font, Vector2.new((1 / 0), u529)).X
                end
                v15 = trim(u406)
                v14 = string.split(v15, " ")
                if 1 >= #v14 then
                    TextLine1.Text = ""
                    TextLine2.Text = u406
                else
                    Font_2 = TextLine1.Font
                    if v13 < TextService:GetTextSize(u406, u529, Font_2, Vector2.new((1 / 0), u529)).X then
                        v15 = table.clone(v14)
                        v16 = #v14
                        while true do
                            v18 = wordsToSentence(v15)
                            Font = TextLine1.Font
                            if v13 >= TextService:GetTextSize(v18, u529, Font, Vector2.new((1 / 0), u529)).X or v16 == 1 then
                                break
                            end
                            table.remove(v15, v16)
                            v16 = v16 - 1
                        end
                        v17 = v16
                        v18 = 1
                        for m = 1, v17, v18 do
                            table.remove(v14, 1)
                        end
                        TextLine1.Text = wordsToSentence(v15)
                        TextLine2.Text = wordsToSentence(v14)
                    end
                end
                if not CleanUp then
                    LockedFrame = ImageButton:WaitForChild("LockedFrame")
                    LockedFrame.Visible = true
                    v15 = if v24 then v24[1] else 0
                    if not n.FixedPrice then
                        new = LevelInfo:AttachmentUnlockCost(v15, v3)
                    else
                        new = n.FixedPrice
                    end
                    LevelLabel = ImageButton.LockedFrame:WaitForChild("LevelLabel")
                    local PriceLabel = ImageButton.LockedFrame:WaitForChild("PriceLabel")
                    if not n.PurchaseOnly then
                        LevelLabel.Text = "LEVEL " .. v3
                    else
                        LevelLabel.Text = "LEVEL N/A"
                    end
                    if v15 >= v3 then
                        LevelLabel.TextColor3 = Color3.new(1, 1, 1)
                    else
                        LevelLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                    end
                    if new ~= 0 then
                        PriceLabel.Text = new .. " Z$"
                    else
                        PriceLabel.Text = "FREE"
                    end
                    local function updatePriceColor() -- Line: 790 -- upvalues: new (ref), u200 (upval), PriceLabel (val), ImageButton (val)
                        if u200.Progression.ZBucks < new then
                            PriceLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                            return
                        end
                        ImageButton.LockedFrame.PriceLabel.TextColor3 = Color3.new(1, 1, 1)
                    end
                    u223[updatePriceColor] = true
                    ImageButton.Destroying:Connect(function() -- Line: 799 -- upvalues: u223 (upval), updatePriceColor (val)
                        u223[updatePriceColor] = nil
                    end)
                    setSelectionFrameAppearance(ImageButton, "unlock")
                else
                    setSelectionFrameAppearance(ImageButton, "equip")
                end
            end
            v5.Visible = true
            v5.Name = n.Name
            v5.Parent = u1080
            v7, v8, v10 = clickEvent(ImageButton)
            u1132[#u1132 + 1] = v7:Connect(function() -- Line: 812 -- upvalues: u228 (upval), ImageButton (val), CleanUp (ref), Sounds (upval), u227 (upval), u225 (upval), u302 (upval), new (ref), u200 (upval), u231 (upval), n (val), ItemIdFromName (val), u406 (val), selectAttachment (val), k (val)
                if u228 ~= ImageButton then
                    if u228 then
                        setAttachmentButtonSelected(u228, false)
                    end
                    u228 = ImageButton
                    setAttachmentButtonSelected(ImageButton, true)
                    setProsCons(n)
                    selectAttachment(k, n, not CleanUp)
                    return
                end
                if CleanUp then
                    setMode("Nodes")
                    Sounds.close:Play()
                    u227 = nil
                    u225 = nil
                    u302.HoveringOver = nil
                    closePurchaseModPrompt()
                    return
                end
                if not new or new > u200.Progression.ZBucks then
                    return
                end
                if not u231 then
                    openPurchaseModPrompt(ItemIdFromName, n.ID, u406, new)
                    return
                end
                if u231.ModID == n.ID then
                    closePurchaseModPrompt()
                    return
                end
                openPurchaseModPrompt(ItemIdFromName, n.ID, u406, new)
            end)
            u1132[#u1132 + 1] = v8:Connect(function() -- Line: 846 -- upvalues: u225 (upval), n (val)
                u225 = n
            end)
            u1132[#u1132 + 1] = v10:Connect(function() -- Line: 849 -- upvalues: u225 (upval), n (val), u1010 (val), u1007 (val)
                if u225 == n then
                    local Nodes = u1010:GetNodes()
                    local v1 = Nodes[u1007]
                    if v1 and v1.ConnectedAttachment and v1.ConnectedAttachment:GetAttachmentIndex() ~= 0 then
                        u225 = v1.ConnectedAttachment:GetAttachmentData()
                    end
                end
            end)
            if u406 ~= "NONE" then
                if not (u222[n.ID]) then
                    u222[n.ID] = {}
                end
                u222[n.ID][ImageButton] = function() -- Line: 861 -- upvalues: CleanUp (ref), ImageButton (val), u228 (upval), selectAttachment (val), k (val), n (val)
                    if not CleanUp then
                        CleanUp = true
                        local LockedFrame = ImageButton:WaitForChild("LockedFrame")
                        LockedFrame.Visible = false
                        setSelectionFrameAppearance(ImageButton, "equip")
                        if u228 == ImageButton then
                            setAttachmentButtonSelected(ImageButton, true)
                            selectAttachment(k, n, false)
                        end
                    end
                end
                ImageButton.Destroying:Connect(function() -- Line: 877 -- upvalues: u222 (upval), n (val), ImageButton (val)
                    local v1 = u222[n.ID]
                    v1[ImageButton] = nil
                end)
            end
        elseif not v6 then
        end
    end
    local UIListLayout = u1080:WaitForChild("UIListLayout")
    local PropertyChangedSignal = UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize")
    PropertyChangedSignal:Connect(function() -- Line: 885 -- upvalues: u1080 (ref), Attachments (upval)
        u1080.CanvasSize = UDim2.new(0, u1080.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01, 0, 0)
    end)
    v25 = u1080.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01
    u1080.CanvasSize = UDim2.new(0, v25, 0, 0)
    if v9 then
        local v28
        u229 = deepCopy(WepConfig:GetWeaponConfig(u1003.Name))
        v2 = AttachmentSystem.DressWeapon(u1003.Name, u213, u229.AttachmentNodeData, u1003, AttachAttachment)
        v28, v25 = v2:timeout(10):await()
        if not v28 then
            warn("[WeaponModding] DressWeapon timed out or failed (" .. "MakeGui runDress" .. "):\n" .. tostring(v25))
        end
        u149:UpdateStats(u229)
        u149:UpdateDisplay()
    end
    local u271 = nil
    local u274 = nil
    local u275 = nil
    local u276 = nil
    local u281 = script.Square:Clone()
    u281.Parent = Attachments
    GuiTransparency:SetTransparency(u281, 1, u212)
    v3 = #u1132 + 1
    function CleanUp() -- Line: 917 -- upvalues: u982 (val), CurrentCamera (upval), u271 (ref), drawLine (upval), u1075 (ref), Attachments (upval), u281 (val), u276 (ref), GuiTransparency (upval), u302 (upval), u1053 (ref), u274 (ref), u275 (ref), u212 (upval), u227 (upval), u1010 (val), u1007 (val), u224 (upval)
        local ConnectedAttachment
        local v1 = CurrentCamera:WorldToScreenPoint(u982.Position)
        local v2 = Vector2.new(v1.X, v1.Y)
        u271 = drawLine(u1075.AbsolutePosition, v2, Attachments, u271)
        u281.Position = UDim2.new(0, v1.X, 0, v1.Y)
        if not u276 then
            u276 = true
            GuiTransparency:SetTransparency(u271, 1, TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
            u271.BackgroundTransparency = 1
        end
        if u302.HoveringOver == u1053 then
            if u274 and not u275 and u302.HoveringOver == u1053 then
                u274 = false
                u275 = true
                GuiTransparency:Revert(u281, u212)
                GuiTransparency:Revert(u271, u212)
            end
        elseif not u274 then
            u274 = true
            u275 = false
            GuiTransparency:SetTransparency(u271, 1, u212)
            GuiTransparency:SetTransparency(u281, 1, u212)
        end
        if u227 ~= nil and u227 == u1053 then
            u271.BackgroundTransparency = 1
        end
        local Nodes = u1010:GetNodes()
        local v3 = Nodes[u1007]
        ConnectedAttachment = if v3 then v3.ConnectedAttachment else nil
        if u302.HoveringOver ~= u1053 then
            if u224[ConnectedAttachment] then
                v2 = u224[ConnectedAttachment]
                v2.Enabled = false
            end
            return
        end
        if not (u224[ConnectedAttachment]) then
            return
        end
        v2 = u224[ConnectedAttachment]
        v2.Enabled = true
    end
    u1132[v3] = RunService.RenderStepped:Connect(CleanUp)
    v3, v4, v5 = clickEvent(u1053)
    CleanUp = #u1132 + 1
    new = v3:Connect(function() -- Line: 966 -- upvalues: Sounds (upval), u215 (upval), u216 (upval), u1010 (val), u982 (val), u1080 (ref), u227 (upval), u1053 (ref), u1101 (ref), u228 (upval), u302 (upval), u225 (upval)
        local v1
        Sounds.click:Play()
        local v2 = u215
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            j.Visible = false
        end
        v2 = u216
        v3 = nil
        v4 = nil
        for k, n in v2, v3, v4 do
            n:SetVisible(false)
        end
        local AttachmentFromNodeName = u1010:GetAttachmentFromNodeName(u982.Name)
        if not AttachmentFromNodeName then
            v3 = {Name = "NONE"}
        elseif AttachmentFromNodeName:GetAttachmentIndex() ~= 0 then
            v3 = AttachmentFromNodeName:GetAttachmentData()
        end
        local v5 = u227 ~= u1053
        u1080.Visible = v5
        u1101:SetVisible(u1080.Visible)
        v4 = u1080:FindFirstChild(v3.Name)
        if v4 then
            u228 = v4.ImageButton
            setAttachmentButtonSelected(u228, true)
        end
        if not u1080.Visible then
            Sounds.close:Play()
            u227 = nil
            u225 = nil
        else
            u302.HoveringOver = u1053
            Sounds.open:Play()
            u227 = u1053
            u225 = v3
        end
        if not u1080.Visible then
            v1 = "Nodes"
        else
            v1 = "Attachments"
        end
        setMode(v1)
    end)
    u1132[CleanUp] = new
    CleanUp = #u1132 + 1
    new = v4:Connect(function() -- Line: 1008 -- upvalues: u227 (upval), u302 (upval), u1053 (ref)
        if u227 then
            return
        end
        u302.HoveringOver = u1053
    end)
    u1132[CleanUp] = new
    CleanUp = #u1132 + 1
    new = v5:Connect(function() -- Line: 1012 -- upvalues: u227 (upval), u302 (upval), u1053 (ref)
        if u227 then
            return
        end
        if u302.HoveringOver == u1053 then
            u302.HoveringOver = nil
        end
    end)
    u1132[CleanUp] = new
    u1053.Parent = Nodes
    CleanUp = Nodes
    new = UDim2.new(0, 0, 0, Nodes.UIListLayout.AbsoluteContentSize.Y)
    CleanUp.CanvasSize = new
    function CleanUp() -- Line: 1022 -- upvalues: u1053 (ref), u1080 (ref), u271 (ref), u281 (val), u1132 (val)
        if u1053 then
            u1053:Destroy()
        end
        if u1080 then
            u1080:Destroy()
        end
        if u271 then
            u271:Destroy()
        end
        if u281 then
            u281:Destroy()
        end
        for k, v in pairs(u1132) do
            v:Disconnect()
        end
        table.clear(u1132)
    end
    u1132[#u1132 + 1] = u1003.Destroying:Connect(function() -- Line: 1042 -- upvalues: CleanUp (val)
        CleanUp()
    end)
    u1132[#u1132 + 1] = u982.Destroying:Connect(function() -- Line: 1046 -- upvalues: CleanUp (val)
        CleanUp()
    end)
    new = u982:FindFirstChild("ExpansionWeld")
    if new then
        u1132[#u1132 + 1] = new.Part0.Destroying:Connect(function() -- Line: 1053 -- upvalues: CleanUp (val), u982 (val)
            CleanUp()
            u982:Destroy()
        end)
        u1132[#u1132 + 1] = new.Part1.Destroying:Connect(function() -- Line: 1057 -- upvalues: CleanUp (val)
            CleanUp()
        end)
        u1132[#u1132 + 1] = new.Destroying:Connect(function() -- Line: 1060 -- upvalues: CleanUp (val), u982 (val)
            CleanUp()
            u982:Destroy()
        end)
    end
end
local u376 = {}
function u204(p1) -- Line: 1071 -- upvalues: u376 (ref)
    local BasePart, v1, v2, v3, v4, v5, v6, v7, v8
    u376 = {}
    local GlobalParts = p1:FindFirstChild("GlobalParts")
    local BasePoints = GlobalParts
    if BasePoints then
        BasePoints = GlobalParts:FindFirstChild("BasePoints")
    end
    local Weapon = p1:FindFirstChild("Weapon")
    local Handle = p1:FindFirstChild("Handle")
    if not Handle then
        Handle = p1.PrimaryPart
    end
    if not BasePoints or not Weapon or not Handle then
        return
    end
    local v9 = {}
    for i, j in Weapon:GetChildren() do
        if j:IsA("Model") then
            BasePart = j:FindFirstChildWhichIsA("BasePart", true)
            if not BasePart then
                for k, n in j:GetAttributes() do
                    if string.sub(k, 1, 13) == "NodeOverride_" then
                        v4 = string.sub(k, 14)
                        v6 = tostring(n)
                        v5 = string.split(v6, ",")
                        if #v5 == 3 then
                            v7 = tonumber(v5[1]) or 0
                            v8 = tonumber(v5[2]) or 0
                            v9[v4] = Vector3.new(v7, v8, tonumber(v5[3]) or 0)
                        end
                    end
                end
            elseif BasePart:GetAttribute("OptionGroupHidden") then
            end
        end
    end
    for m, i5 in BasePoints:GetChildren() do
        if i5:IsA("BasePart") then
            v1 = Handle.CFrame:ToObjectSpace(i5.CFrame)
            v2 = v9[i5.Name]
            if not v2 then
                u376[i5.Name] = v1
            else
                v3 = CFrame.new(v1.Position - v2)
                u376[i5.Name] = v3 * v1.Rotation
            end
        end
    end
end
local function u378(p1) -- Line: 1115 -- upvalues: u376 (ref)
    local BasePart, Part1, Weld, v1, v2, v3, v4, v5, v6, v7, v8, v9
    if not (next(u376)) then
        return
    end
    local GlobalParts = p1:FindFirstChild("GlobalParts")
    local BasePoints = GlobalParts
    if BasePoints then
        BasePoints = GlobalParts:FindFirstChild("BasePoints")
    end
    local Weapon = p1:FindFirstChild("Weapon")
    local Handle = p1:FindFirstChild("Handle")
    if not Handle then
        Handle = p1.PrimaryPart
    end
    if not BasePoints or not Weapon or not Handle then
        return
    end
    local KeyParts = p1:FindFirstChild("KeyParts")
    local function moveBasePoint(p1, p2) -- Line: 1127 -- upvalues: KeyParts (val)
        local Part1, v1, v2
        local v3 = nil
        v1, v2 = p1, p2
        for i, j in p1:GetJoints() do
            if j:IsA("JointInstance") and KeyParts then
                if j.Part0 == v1 then
                    Part1 = j.Part1
                elseif j.Part1 ~= v1 then
                    Part1 = nil
                else
                    Part1 = j.Part0
                end
                if Part1 and Part1:IsDescendantOf(KeyParts) then
                    v3 = Part1
                    j:Destroy()
                    break
                end
            end
        end
        v1.CFrame = v2
        if v3 then
            local Weld = Instance.new("Weld")
            Weld.Part0 = v3
            Weld.Part1 = v1
            Weld.C0 = CFrame.new()
            Weld.C1 = v1.CFrame:toObjectSpace(v3.CFrame)
            Weld.Parent = v3
        end
    end
    local v10 = {}
    for i, j in Weapon:GetChildren() do
        if j:IsA("Model") then
            BasePart = j:FindFirstChildWhichIsA("BasePart", true)
            if not BasePart then
                for k, n in j:GetAttributes() do
                    if string.sub(k, 1, 13) == "NodeOverride_" then
                        v5 = string.sub(k, 14)
                        v7 = tostring(n)
                        v6 = string.split(v7, ",")
                        if #v6 == 3 then
                            v8 = tonumber(v6[1]) or 0
                            v9 = tonumber(v6[2]) or 0
                            v10[v5] = Vector3.new(v8, v9, tonumber(v6[3]) or 0)
                        end
                    end
                end
            elseif BasePart:GetAttribute("OptionGroupHidden") then
            end
        end
    end
    local v11 = u376
    local v12 = nil
    local v13 = nil
    for m, i5 in v11, v12, v13 do
        v1 = BasePoints:FindFirstChild(m)
        if v1 and v1:IsA("BasePart") then
            v2 = v10[m]
            v3 = i5
            if v2 then
                v4 = CFrame.new(i5.Position + v2)
                v3 = v4 * i5.Rotation
                print("[NodeOverride] Override for node:", m, "offset:", v2)
            end
            moveBasePoint(v1, Handle.CFrame * v3)
            if v2 then
                for i6, i7 in v1:GetJoints() do
                    if i7:IsA("JointInstance") then
                        if i7.Part0 == v1 then
                            Part1 = i7.Part1
                        elseif i7.Part1 ~= v1 then
                            Part1 = nil
                        else
                            Part1 = i7.Part0
                        end
                        if Part1 then
                            if not KeyParts then
                                v9 = Part1:FindFirstAncestorOfClass("Model")
                                if v9 and v9.PrimaryPart then
                                    print("[NodeOverride] Re-welding attachment:", v9.Name, "to node:", m)
                                    i7:Destroy()
                                    v9:PivotTo(v1.CFrame)
                                    Weld = Instance.new("Weld")
                                    Weld.Part0 = v9.PrimaryPart
                                    Weld.Part1 = v1
                                    Weld.Parent = v9
                                end
                            elseif Part1:IsDescendantOf(KeyParts) then
                            end
                        end
                    end
                end
            end
        end
    end
end
local function u379(p1, p2) -- Line: 1210 -- upvalues: u202 (ref), u217 (val), u227 (ref), u213 (ref), u229 (ref), WepConfig (val), AttachmentSystem (val), u218 (val), u149 (val)
    local Frame, Frame_2, NodeIDFromName, v1, v2, v3
    local v4 = u202
    u202 = p1
    local v5 = v4
    local v6 = nil
    local v7 = nil
    for i in v5, v6, v7 do
        if not (p1[i]) then
            v2 = u217[i]
            if v2 then
                v2.Visible = true
            end
        end
    end
    v5 = false
    v6 = p1
    v7 = nil
    local v8 = nil
    local v9 = p2
    for j in v6, v7, v8 do
        if not (v4[j]) then
            v3 = u217[j]
            if v3 then
                v3.Visible = false
                if u227 == v3 then
                    u227 = nil
                    setMode("Nodes")
                end
            end
            NodeIDFromName = u213:GetNodeIDFromName(j)
            if NodeIDFromName then
                v1 = u213:GetNodes()[NodeIDFromName]
                if v1 and v1.ConnectedAttachment then
                    u213:SetNodeAttachment(NodeIDFromName, 0)
                    v5 = true
                    if v3 then
                        Frame = v3:FindFirstChild("Frame")
                        if Frame then
                            Frame = v3.Frame:FindFirstChild("BottomLabel")
                        end
                        if Frame then
                            Frame.Text = "NONE"
                        end
                        Frame_2 = v3:FindFirstChild("Frame")
                        if Frame_2 then
                            Frame_2 = v3.Frame:FindFirstChild("ImageLabel")
                        end
                        if Frame_2 then
                            Frame_2.Image = ""
                        end
                    end
                end
            end
        end
    end
    if v5 and v9 and v9.Parent then
        u229 = deepCopy(WepConfig:GetWeaponConfig(v9.Name))
        v9.Attachments:ClearAllChildren()
        v6 = AttachmentSystem.DressWeapon(v9.Name, u213, u229.AttachmentNodeData, v9, function(...) -- Line: 1259 -- upvalues: u218 (upval)
            local v1 = u218
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                j(...)
            end
        end)
        v7, v8 = v6:timeout(10):await()
        if not v7 then
            warn("[WeaponModding] DressWeapon timed out or failed (" .. "needsRedress" .. "):\n" .. tostring(v8))
        end
        u149:UpdateStats(u229)
        u149:UpdateDisplay()
    end
end
function u207(p1, p2, p3) -- Line: 1271 -- upvalues: Template (val), u214 (val), SharedResources (val), Attachments (val), GuiTransparency (val), u212 (val), ScrollingFrame (val), u215 (val), Attachments_2 (val), Scrollbar (val), ScrollBar (val), u216 (val), Template_2 (val), clickEvent (val), u228 (ref), Sounds (val), u227 (ref), u203 (ref), u378 (ref), u302 (val), u219 (ref), u379 (ref), RunService (val), CurrentCamera (val), drawLine (val), Nodes (val)
    local ImageLabel_2, LockedFrame, TextLine1, TextLine2, u86, v1, v2, v3
    local u6 = Template:Clone()
    table.insert(u214, u6)
    u6.Name = p1
    u6.LayoutOrder = 1000
    local Frame = u6:WaitForChild("Frame")
    local TopLabel = Frame:WaitForChild("TopLabel")
    local BottomLabel = Frame:WaitForChild("BottomLabel")
    local ImageLabel = Frame:WaitForChild("ImageLabel")
    local Point = Frame:WaitForChild("Point")
    local name = nil
    local v4 = p2
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        if j.isActive then
            name = j.name
            break
        end
    end
    if not name and 0 < #p2 then
        name = p2[1].name
        p2[1].isActive = true
    end
    TopLabel.Text = p1
    if not name then
        v4 = ""
    else
        v4 = string.upper(name)
    end
    BottomLabel.Text = v4
    ImageLabel.Image = ""
    local function findMemberModel(a1) -- Line: 1302 -- upvalues: p3 (val), p1 (val)
        local Attribute
        local Weapon = p3:FindFirstChild("Weapon")
        if not Weapon then
            return nil
        end
        for i, j in Weapon:GetChildren() do
            if j:IsA("Model") then
                Attribute = j:GetAttribute("OptionGroup")
                if Attribute == p1 and j.Name == a1 then
                    return j
                end
            end
        end
        return nil
    end
    if not name then
        u86 = nil
    else
        u86 = findMemberModel(name)
    end
    local u93 = SharedResources.Attachments.AttachmentSystem.Highlight:Clone()
    u93.Enabled = false
    if u86 then
        u93.Adornee = u86
    end
    u93.Parent = p3
    local u99 = nil
    local u100 = nil
    local u101 = nil
    local u102 = nil
    local u107 = script.Square:Clone()
    u107.Parent = Attachments
    GuiTransparency:SetTransparency(u107, 1, u212)
    local u119 = ScrollingFrame:Clone()
    table.insert(u215, u119)
    local NONE = u119:FindFirstChild("NONE")
    if NONE then
        NONE:Destroy()
    end
    u119.Parent = Attachments_2
    local v7 = Scrollbar:Clone()
    local u142 = ScrollBar.new(v7, u119, "X")
    table.insert(u216, u142)
    v7.Parent = Attachments_2
    local u148 = {}
    local v8 = p2
    local v9 = nil
    local v10 = nil
    for k, n in v8, v9, v10 do
        v2 = Template_2:Clone()
        v2.LayoutOrder = k
        v2.Visible = true
        v2.Name = n.name
        local ImageButton = v2:WaitForChild("ImageButton")
        TextLine1 = ImageButton:WaitForChild("TextLine1")
        TextLine2 = ImageButton:WaitForChild("TextLine2")
        ImageLabel_2 = ImageButton:WaitForChild("ImageLabel")
        TextLine1.Text = ""
        TextLine2.Text = string.upper(n.name)
        ImageLabel_2.Visible = false
        LockedFrame = ImageButton:WaitForChild("LockedFrame")
        LockedFrame.Visible = false
        setSelectionFrameAppearance(ImageButton, "equip")
        v2.Parent = u119
        v3 = clickEvent(ImageButton)
        u148[#u148 + 1] = v3:Connect(function() -- Line: 1369 -- upvalues: u228 (upval), ImageButton (val), Sounds (upval), u227 (upval), u203 (upval), p3 (val), p1 (val), n (val), u378 (upval), BottomLabel (val), u86 (ref), findMemberModel (val), u93 (val), p2 (val), u302 (upval), u219 (upval), u379 (upval)
            local v1, v2
            if u228 == ImageButton then
                setMode("Nodes")
                Sounds.close:Play()
                u227 = nil
                u203 = false
                return
            end
            if u228 then
                setAttachmentButtonSelected(u228, false)
            end
            u228 = ImageButton
            setAttachmentButtonSelected(ImageButton, true)
            local Children = Sounds.Att:GetChildren()
            Children[math.random(1, 3)]:Play()
            local Weapon = p3:FindFirstChild("Weapon")
            if Weapon then
                local Attribute, Attribute_2, Attribute_3
                for i, j in Weapon:GetChildren() do
                    if j:IsA("Model") then
                        Attribute = j:GetAttribute("OptionGroup")
                        if Attribute == p1 then
                            v2 = j.Name == n.name
                            for k, n2 in j:GetDescendants() do
                                if n2:IsA("BasePart") then
                                    if v2 then
                                        n2:SetAttribute("OptionGroupHidden", nil)
                                        Attribute_3 = n2:GetAttribute("OrigTransparency")
                                        if Attribute_3 == nil then
                                            v1 = 0
                                        else
                                            v1 = Attribute_3
                                        end
                                        n2.Transparency = v1
                                    elseif not (n2:GetAttribute("OptionGroupHidden")) then
                                        n2:SetAttribute("OptionGroupHidden", true)
                                        if n2:GetAttribute("OrigTransparency") == nil then
                                            n2:SetAttribute("OrigTransparency", n2.Transparency)
                                        end
                                        n2.Transparency = 1
                                    end
                                elseif not (n2:IsA("Decal")) and not (n2:IsA("Texture")) then
                                    if n2:IsA("Beam") then
                                        if v2 then
                                            n2:SetAttribute("OptionGroupHidden", nil)
                                            Attribute_2 = n2:GetAttribute("OrigEnabled")
                                            if Attribute_2 == nil then
                                                v1 = true
                                            else
                                                v1 = Attribute_2
                                            end
                                            n2.Enabled = v1
                                        elseif not (n2:GetAttribute("OptionGroupHidden")) then
                                            n2:SetAttribute("OptionGroupHidden", true)
                                            n2:SetAttribute("OrigEnabled", n2.Enabled)
                                            n2.Enabled = false
                                        end
                                    elseif not (n2:IsA("ParticleEmitter")) then
                                    end
                                end
                            end
                        end
                    end
                end
            end
            u378(p3)
            BottomLabel.Text = string.upper(n.name)
            u86 = findMemberModel(n.name)
            u93.Adornee = u86
            local v3 = p2
            local v4 = nil
            local v5 = nil
            for m, i5 in v3, v4, v5 do
                v2 = i5.id == n.id
                i5.isActive = v2
            end
            u302.OptionGroupChanged:Fire(p1, n.id, n.name)
            if u219 then
                local lockedNodes, members, v6, v7, v8
                v3 = {}
                v4 = u219
                v5 = nil
                local v9 = nil
                for i6, i7 in v4, v5, v9 do
                    members = i7.members
                    v7 = nil
                    v8 = nil
                    for i8, i9 in members, v7, v8 do
                        if i9.isActive and i9.lockedNodes then
                            lockedNodes = i9.lockedNodes
                            v1 = nil
                            v6 = nil
                            for i10, i11 in lockedNodes, v1, v6 do
                                v3[i11] = true
                            end
                        end
                    end
                end
                u379(v3, p3)
            end
        end)
    end
    local UIListLayout = u119:WaitForChild("UIListLayout")
    local PropertyChangedSignal = UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize")
    PropertyChangedSignal:Connect(function() -- Line: 1461 -- upvalues: u119 (val), Attachments (upval)
        u119.CanvasSize = UDim2.new(0, u119.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01, 0, 0)
    end)
    u119.CanvasSize = UDim2.new(0, u119.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01, 0, 0)
    u148[#u148 + 1] = RunService.RenderStepped:Connect(function() -- Line: 1468 -- upvalues: u86 (ref), CurrentCamera (upval), u99 (ref), drawLine (upval), Point (val), Attachments (upval), u107 (val), u102 (ref), GuiTransparency (upval), u302 (upval), u6 (val), u100 (ref), u101 (ref), u212 (upval), u227 (upval), u93 (val)
        if not u86 then
            return
        end
        local BoundingBox = u86:GetBoundingBox()
        local v1 = CurrentCamera:WorldToScreenPoint(BoundingBox.Position)
        local v2 = Vector2.new(v1.X, v1.Y)
        u99 = drawLine(Point.AbsolutePosition, v2, Attachments, u99)
        u107.Position = UDim2.new(0, v1.X, 0, v1.Y)
        if not u102 then
            u102 = true
            GuiTransparency:SetTransparency(u99, 1, TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
            u99.BackgroundTransparency = 1
        end
        if u302.HoveringOver == u6 then
            if u100 and not u101 and u302.HoveringOver == u6 then
                u100 = false
                u101 = true
                GuiTransparency:Revert(u107, u212)
                GuiTransparency:Revert(u99, u212)
            end
        elseif not u100 then
            u100 = true
            u101 = false
            GuiTransparency:SetTransparency(u99, 1, u212)
            GuiTransparency:SetTransparency(u107, 1, u212)
        end
        if u227 ~= nil and u227 == u6 then
            u99.BackgroundTransparency = 1
        end
        if u302.HoveringOver == u6 then
            u93.Enabled = true
            return
        end
        u93.Enabled = false
    end)
    v9, v10, v1 = clickEvent(u6)
    u148[#u148 + 1] = v9:Connect(function() -- Line: 1510 -- upvalues: Sounds (upval), u215 (upval), u216 (upval), u119 (val), u227 (upval), u6 (val), u142 (val), p2 (val), u228 (upval), u302 (upval), u203 (upval)
        Sounds.click:Play()
        local v1 = u215
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j.Visible = false
        end
        v1 = u216
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            n:SetVisible(false)
        end
        v2 = u227 ~= u6
        u119.Visible = v2
        u142:SetVisible(u119.Visible)
        if u119.Visible then
            local v4
            v1 = p2
            v2 = nil
            v3 = nil
            for m, i5 in v1, v2, v3 do
                if i5.isActive then
                    v4 = u119:FindFirstChild(i5.name)
                    if not v4 then
                        break
                    end
                    u228 = v4:FindFirstChild("ImageButton")
                    if not u228 then
                        break
                    end
                    setAttachmentButtonSelected(u228, true)
                    break
                end
            end
        end
        if not u119.Visible then
            Sounds.close:Play()
            u227 = nil
            u203 = false
        else
            u302.HoveringOver = u6
            Sounds.open:Play()
            u227 = u6
            u203 = true
        end
        if not u119.Visible then
            v2 = "Nodes"
        else
            v2 = "Attachments"
        end
        setMode(v2)
    end)
    u148[#u148 + 1] = v10:Connect(function() -- Line: 1551 -- upvalues: u227 (upval), u302 (upval), u6 (val)
        if u227 then
            return
        end
        u302.HoveringOver = u6
    end)
    u148[#u148 + 1] = v1:Connect(function() -- Line: 1555 -- upvalues: u227 (upval), u302 (upval), u6 (val)
        if u227 then
            return
        end
        if u302.HoveringOver == u6 then
            u302.HoveringOver = nil
        end
    end)
    u6.Parent = Nodes
    Nodes.CanvasSize = UDim2.new(0, 0, 0, Nodes.UIListLayout.AbsoluteContentSize.Y)
    u148[#u148 + 1] = p3.Destroying:Connect(function() -- Line: 1566 -- upvalues: u6 (val), u119 (val), u99 (ref), u107 (val), u93 (val), u148 (val)
        if u6 then
            u6:Destroy()
        end
        if u119 then
            u119:Destroy()
        end
        if u99 then
            u99:Destroy()
        end
        if u107 then
            u107:Destroy()
        end
        if u93 then
            u93:Destroy()
        end
        local v1 = u148
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j:Disconnect()
        end
        table.clear(u148)
    end)
end
function removePreviewAttachments() -- Line: 1581 -- upvalues: u221 (ref)
    local v1, v2, v3
    local v4 = u221
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = j
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            n.SelectFunction(n.OriginalAttachmentIndex, n.OriginalProperties)
        end
    end
end
function deepCopy(p1) -- Line: 1589
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        v1[k] = v
    end
    return v1
end
function wordsToSentence(p1) -- Line: 1600
    local v1 = ""
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1 = v1 .. j
        if i < #p1 then
            v1 = v1 .. " "
        end
    end
    return v1
end
function trim(p1) -- Line: 1611
    local v1 = p1:gsub("^%s+", "", 1)
    return (v1:gsub("%s+$", "", 1))
end
function updatePlayerData(p1) -- Line: 1616 -- upvalues: u200 (ref), u223 (val)
    u200 = p1
    local v1 = u223
    local v2 = nil
    local v3 = nil
    for i in v1, v2, v3 do
        i()
    end
end
function openPurchaseModPrompt(p1, p2, p3, p4) -- Line: 1623 -- upvalues: u230 (ref), PurchaseMod (val), u200 (ref), u231 (ref)
    if u230 then
        closePurchaseModPrompt()
    end
    u230 = true
    PurchaseMod.NameLabel.Text = p3
    PurchaseMod.BalanceLabel.Text = ("YOUR BALANCE: %d Z$"):format(u200.Progression.ZBucks)
    PurchaseMod.InfoLabel.Text = ("UNLOCK FOR %d Z$"):format(p4)
    u231 = {WeaponID = p1, ModID = p2}
    PurchaseMod.Visible = true
end
clickEvent(PurchaseMod.UnlockButton):Connect(function() -- Line: 1642 -- upvalues: u231 (ref), ModificationEvent (val)
    if u231 and ModificationEvent then
        ModificationEvent:FireServer({Type = "PurchaseMod", WeaponID = u231.WeaponID, ModID = u231.ModID})
        closePurchaseModPrompt()
    end
end)
function closePurchaseModPrompt() -- Line: 1653 -- upvalues: u231 (ref), PurchaseMod (val), u230 (ref)
    u231 = nil
    PurchaseMod.Visible = false
    u230 = false
end
function deserializeUnlockedAttachments(p1) -- Line: 1659
    if p1 then
        return string.split(p1, ",")
    end
    return {}
end
clickEvent(PurchaseMod.CancelButton):Connect(closePurchaseModPrompt)
if ModificationEvent then
    ModificationEvent:SetClientListener(function(p1) -- Line: 1670 -- upvalues: u200 (ref), ItemData (val), u226 (ref), u222 (ref)
        if p1.Type and p1.Type == "ModUnlocked" then
            u200.Progression = p1.NewProgression
            updatePlayerData(u200)
            local ItemIdFromName = ItemData:GetItemIdFromName(u226)
            if p1.WeaponID == ItemIdFromName and u222[p1.ModID] then
                local v1 = u222[p1.ModID]
                local v2 = nil
                local v3 = nil
                for i, j in v1, v2, v3 do
                    j()
                end
            end
        end
    end)
end
local Remotes_2 = ReplicatedStorage.common:WaitForChild("Remotes")
Remotes_2:WaitForChild("Net").OnClientEvent:Connect(function(p1, p2) -- Line: 1686 -- upvalues: u200 (ref)
    if p1 == "UpdateZBucks" and u200 and u200.Progression then
        u200.Progression.ZBucks = tonumber(p2) or 0
        updatePlayerData(u200)
    end
end)
return u302