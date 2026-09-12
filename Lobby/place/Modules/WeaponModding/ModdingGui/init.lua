local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedResources = ReplicatedStorage.common:WaitForChild("SharedResources")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local Sounds = script:WaitForChild("Sounds")
local Attachments = script:WaitForChild("Attachments")
local WeaponStats = Attachments:WaitForChild("WeaponStats")
local Exit = Attachments.Exit
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
local WeaponModding = script.Parent.WeaponModding
local CurrentCamera = workspace.CurrentCamera
local common = game.ReplicatedStorage.common
game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local DataRemote = (game.ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("DataRemote")
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
local u149 = require(script:WaitForChild("WeaponStatsUI"))(WeaponStats)
local WepConfig = require(ReplicatedStorage.common:WaitForChild("WepConfig"))
local ScrollBar = require(common.ScrollBar)
local ItemData = require(common.ItemData)
local LevelInfo = require(common:WaitForChild("LevelInfo"))
local Signal = require(common.Signal)
local DamageFalloffUtil = require(((common:WaitForChild("NPCs_Shared")):WaitForChild("Utils")):WaitForChild("DamageFalloffUtil"))
local drawLine = MiscFunctions.drawLine
local clickEvent = MiscFunctions.clickEvent

local function awaitDress(p1, p2) -- Line: 67
    local v1, v2 = p1:timeout(10):await()
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
local new = ColorSequence.new
local v1 = {}
local v2 = ColorSequenceKeypoint.new(0, Color3.fromHex("8f8f8f"))
local v3 = ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1))
v1[1] = v2
v1[2] = v3
v1[3] = ColorSequenceKeypoint.new(1, Color3.fromHex("98ffa1"))
local u254 = new(v1)
local new_2 = ColorSequence.new
v2 = {}
v3 = ColorSequenceKeypoint.new(0, Color3.fromHex("8f8f8f"))
local v4 = ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1))
v2[1] = v3
v2[2] = v4
v2[3] = ColorSequenceKeypoint.new(1, Color3.fromHex("8fe7ff"))
local u277 = new_2(v2)
local new_3 = ColorSequence.new
v3 = {}
v4 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
local v5 = ColorSequenceKeypoint.new(0.53, Color3.new(1, 1, 1))
v3[1] = v4
v3[2] = v5
v3[3] = ColorSequenceKeypoint.new(1, Color3.new())
local u301 = new_3(v3)
local u302 = {}
v4 = clickEvent(Exit)
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

function u302.loadGui(p1, p2, p3, p4, p5, p6) -- Line: 151
    -- upvalues: u202 (ref), u201 (ref), u203 (ref), u200 (ref), DataRemote (val), u226 (ref), ItemData (val)
    -- upvalues: u221 (ref), u222 (ref), u229 (ref), WepConfig (val), u149 (val), LevelInfo (val), LevelLabel (val)
    -- upvalues: FillSliceFrame (val), LowerXPLabel (val), UpperXPLabel (val), u213 (ref), AttachmentsRoot (val)
    -- upvalues: u214 (val), u215 (val), u216 (val), u217 (val), u218 (val), u227 (ref), u225 (ref), u220 (ref)
    -- upvalues: AttachmentSystem (val), u219 (ref), u204 (ref), u207 (ref), Attachments (val), PlayerGui (val)
    local v1, v2, v3, v4
    local v5 = p4 or {}
    u202 = v5
    u201 = p5 or false
    u203 = false
    if u201 then
        u200 = {
            Progression = {ZBucks = 999999, Weapons = {}},
        }
        v1 = p1
    else
        v5 = false
        v4 = 0
        while not v5 do
            if not (v4 < 3) then
                break
            end
            v4 = v4 + 1
            v5 = pcall(function() -- Line: 163 -- upvalues: u200 (upval), DataRemote (upval)
                u200 = DataRemote:InvokeServer("GetData")
            end)
            if not v5 then
                task.wait(0.2)
            end
        end
        if not v5 or not u200 then
            u200 = {
                Progression = {ZBucks = 999999, Weapons = {}},
            }
            u201 = true
        end
    end
    u226 = v1
    v5 = ItemData
    local v6 = u226
    local ItemIdFromName = v5:GetItemIdFromName(v6)
    u221 = {}
    u222 = {}
    u229 = deepCopy(WepConfig:GetWeaponConfig(v1))
    v4 = u149
    local v7 = u229
    v4:SetBaseStats(v7)
    u149:UpdateDisplay()
    v4 = u200.Progression.Weapons[ItemIdFromName]
    v6 = 0
    v7 = 0
    if v4 then
        v6 = v4[1]
        v7 = v4[2]
    end
    local v8 = LevelInfo:RequiredXp(v6)
    local v9 = ("%d/%d XP"):format(v7, v8)
    LevelLabel.Text = "LEVEL " .. v6
    FillSliceFrame.Size = UDim2.new(v7 / v8, 0, 1, 0)
    LowerXPLabel.Text = v9
    UpperXPLabel.Text = v9
    if not v10 then
        u213 = AttachmentsRoot.new(u229)
    else
        u213 = v10
    end
    local v11 = u214
    local v12 = nil
    local v13 = nil
    for i, j in v11, v12, v13 do
        j:Destroy()
    end
    v11 = u215
    v12 = nil
    v13 = nil
    for k, n in v11, v12, v13 do
        n:Destroy()
    end
    v11 = u216
    v12 = nil
    v13 = nil
    for m, i5 in v11, v12, v13 do
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
    local GlobalParts = v14:FindFirstChild("GlobalParts")
    if GlobalParts then
        local BasePoints = GlobalParts:FindFirstChild("BasePoints")
        if BasePoints then
            local Name_2, NodeIDFromName, v15
            local Children = BasePoints:GetChildren()
            v2 = Children
            local v16 = nil
            local v17 = nil
            for i6, i7 in v2, v16, v17 do
                v15 = u213
                Name_2 = i7.Name
                NodeIDFromName = v15:GetNodeIDFromName(Name_2)
                MakeGui(i7, v14, NodeIDFromName, u213, false)
            end
            if 0 < #Children and v14.Parent then
                v2 = u218[1]
                v16 = deepCopy
                v17 = WepConfig
                local Name = v14.Name
                u229 = v16(v17:GetWeaponConfig(Name))
                v17, v3 = (AttachmentSystem.DressWeapon(v14.Name, u213, u229.AttachmentNodeData, v14, v2)):timeout(10):await()
                if not v17 then
                    warn("[WeaponModding] DressWeapon timed out or failed (" .. "loadGui populate" .. "):\n" .. tostring(v3))
                end
                v16 = u149
                v3 = u229
                v16:UpdateStats(v3)
                u149:UpdateDisplay()
            end
        end
    end
    v12 = u202
    v13 = nil
    v2 = nil
    for i8 in v12, v13, v2 do
        v3 = u217[i8]
        if v3 then
            v3.Visible = false
        end
    end
    u219 = v18
    if v18 then
        u204(v14)
        v12 = v18
        v13 = nil
        v2 = nil
        for i9, i10 in v12, v13, v2 do
            u207(i9, i10.members, v14)
        end
    end
    local DisplayName = u213:GetDisplayName(v1)
    v13 = Attachments
    local TextLabel = v13.Header.TextLabel
    TextLabel.Text = (string.upper(DisplayName)) .. " ATTACHMENTS"
    setMode("Nodes")
    Attachments.Parent = PlayerGui
end

function u302.getAttached() -- Line: 316 -- upvalues: u213 (ref), ItemData (val), u226 (ref)
    local v1 = u213:Serialize()
    local v2 = ItemData
    local v3 = u226
    return v1, (v2:GetItemIdFromName(v3))
end

function setMode(p1) -- Line: 323
    -- upvalues: u149 (val), Attachments_2 (val), ProsCons (val), u203 (ref), Nodes (val), u227 (ref), Attachments (val)
    -- upvalues: u226 (ref)
    u149:UpdatePlacement(p1)
    local v1 = Attachments_2
    local v2 = p1 ~= "Nodes"
    v1.Visible = v2
    v1 = ProsCons
    v2 = false
    if p1 ~= "Nodes" then
        v2 = not u203
    end
    v1.Visible = v2
    v1 = Nodes
    v2 = p1 == "Nodes"
    v1.Visible = v2
    if p1 == "Attachments" and u227 then
        Attachments.Header.TextLabel.Text = string.upper(u227.Name)
        return
    end
    v1 = Attachments
    local TextLabel = v1.Header.TextLabel
    TextLabel.Text = (string.upper(u226)) .. " ATTACHMENTS"
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
        if p1.Parent.Name == "NONE" or not p1.LockedFrame.Visible then
            p1.UIGradient.Color = u254
        else
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
    local List, v1, v2, v3, v4, v5
    local v6 = {"Pros", "Cons"}
    for k, v in pairs(v6) do
        List = ProsCons[v].List
        for k2, i in pairs(List:GetChildren()) do
            if i.Name ~= "UIListLayout" then
                i:Destroy()
            end
        end
        v4 = pairs
        v5 = v1[v]
        if not v5 then
            v5 = {}
        end
        for k3, j in v4(v5) do
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

function MakeGui(p1, p2, p3, p4, p5) -- Line: 424
    -- upvalues: u213 (ref), ItemData (val), u226 (ref), Template (val), u214 (val), ScrollingFrame (val), u215 (val)
    -- upvalues: Attachments_2 (val), Scrollbar (val), ScrollBar (val), u216 (val), u217 (val), u220 (ref), u224 (ref)
    -- upvalues: u229 (ref), DamageFalloffUtil (val), u218 (val), Sounds (val), u221 (ref), WepConfig (val)
    -- upvalues: AttachmentSystem (val), u149 (val), u200 (ref), Attachments (val), AttachmentEntitlements (val)
    -- upvalues: u201 (ref), Template_2 (val), TextService (val), LevelInfo (val), u223 (val), clickEvent (val)
    -- upvalues: u228 (ref), u227 (ref), u225 (ref), u302 (val), u231 (ref), u222 (ref), GuiTransparency (val)
    -- upvalues: u212 (val), RunService (val), CurrentCamera (val), drawLine (val), Nodes (val)
    local AttachmentNodeData = u213:GetAttachmentNodeData()
    local v1 = ItemData
    local v2 = u226
    local ItemIdFromName = v1:GetItemIdFromName(v2)
    if p3 and AttachmentNodeData and AttachmentNodeData[p3] then
        local Alias_2, DropShadow, Font, Font_2, ImageLabel, LevelLabel, LockedFrame, TextLine2, destroyNodePartTree, getTextWidth, selectAttachment, split, upper_2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24
        local u1052 = Template:Clone()
        v2 = u214
        local v25 = u1052
        table.insert(v2, v25)
        u1052.Name = p1.Name
        local v26 = u1052:WaitForChild("Frame")
        local v27 = v26:WaitForChild("TopLabel")
        local u48 = v26:WaitForChild("BottomLabel")
        local u53 = v26:WaitForChild("ImageLabel")
        local u1074 = v26:WaitForChild("Point")
        local u1079 = ScrollingFrame:Clone()
        v2 = u215
        v25 = u1079
        table.insert(v2, v25)
        u1079.Parent = Attachments_2
        local v28 = Scrollbar:Clone()
        local u1100 = ScrollBar.new(v28, u1079, "X")
        v2 = u216
        v25 = u1100
        table.insert(v2, v25)
        v28.Parent = Attachments_2
        v27.Text = p1.Name
        u48.Text = "NONE"
        local v29 = p4:GetNodes()[p3]
        local ConnectedAttachment = v29
        if ConnectedAttachment then
            ConnectedAttachment = v29.ConnectedAttachment
        end
        if ConnectedAttachment then
            local AttachmentIndex = ConnectedAttachment:GetAttachmentIndex()
            v3 = AttachmentNodeData[p3]
            if v3 then
                v3 = AttachmentNodeData[p3].PotentialAttachments[AttachmentIndex]
            end
            if v3 then
                local Image
                local upper = string.upper
                local Alias = v3.Alias
                if not Alias then
                    Alias = v3.Name
                end
                u48.Text = upper(Alias)
                if not v3.Image then
                    Image = "rbxassetid://4923293939"
                else
                    Image = v3.Image
                end
                u53.Image = Image
            end
        end
        u217[p1.Name] = u1052
        local u135 = {}
        local PotentialAttachments = AttachmentNodeData[p3].PotentialAttachments
        if not PotentialAttachments then
            PotentialAttachments = {}
        end
        v25 = nil
        v3 = nil
        for i, j in PotentialAttachments, v25, v3 do
            table.insert(u135, j)
        end
        u135[0] = {Name = "NONE"}

        function destroyNodePartTree(p1) -- Line: 497 -- upvalues: u220 (upval), destroyNodePartTree (val)
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

        local function AttachAttachment(p1_2, p2_2, p3_2, p4_2) -- Line: 513
            -- upvalues: p3 (val), p4 (val), AttachmentNodeData (val), u48 (ref), u53 (ref), u224 (upval), u220 (upval)
            -- upvalues: destroyNodePartTree (val), p1 (val), p2 (val), u229 (upval), DamageFalloffUtil (upval)
            local v1, v2, v3, v4
            p1_2:GetAttachmentNodeData()
            local NodeID = p1_2:GetNodeID()
            if NodeID == p3 and p1_2.Parent == p4 then
                local Image
                local AttachmentIndex = p1_2:GetAttachmentIndex()
                v3 = AttachmentNodeData[NodeID].PotentialAttachments[AttachmentIndex]
                local upper = string.upper
                local Alias = v3.Alias
                if not Alias then
                    Alias = v3.Name
                end
                v4 = upper(Alias)
                if not v3.Image then
                    Image = "rbxassetid://4923293939"
                else
                    Image = v3.Image
                end
                u48.Text = v4
                u53.Image = Image
            end
            u224 = p4_2
            local v5 = u220[p1_2.Parent]
            if not v5 then
                v5 = {}
                u220[p1_2.Parent] = v5
            else
                v3 = v5[p1_2:GetNodeID()]
                if v3 and v3.Object ~= p1_2 then
                    destroyNodePartTree(v3)
                end
            end
            if not p2_2 then
                v2, v1 = p3_2, p2_2
            else
                local NodeParts = p2_2:FindFirstChild("NodeParts")
                if not NodeParts then
                    v2, v1 = p3_2, p2_2
                else
                    local Attribute, CFrame_2, CFrame_3, Name, NodeIDFromName, Weld, v6, v7
                    v4 = v5[p1_2:GetNodeID()]
                    if not v4 then
                        v4 = {Object = p1_2, NodeParts = {}}
                        v5[p1_2:GetNodeID()] = v4
                    end
                    v6, v2, v1 = p1_2, p3_2, p2_2
                    for i, j in NodeParts:GetChildren() do
                        if not v4.NodeParts[j.Name] then
                            v7 = p1
                            Weld = Instance.new("Weld")
                            Weld.Name = "ExpansionWeld"
                            Weld.Part0 = v7
                            Weld.Part1 = j
                            Weld.C0 = CFrame.new()
                            CFrame_2 = j.CFrame
                            CFrame_3 = v7.CFrame
                            Weld.C1 = CFrame_2:toObjectSpace(CFrame_3)
                            Weld.Parent = j
                            j.Parent = p2.KeyParts
                            Attribute = j:GetAttribute("NodeName")
                            if not Attribute then
                                Attribute = j.Name
                            end
                            j.Name = Attribute
                            v4.NodeParts[j.Name] = j
                            Name = j.Name
                            NodeIDFromName = v6:GetNodeIDFromName(Name)
                            MakeGui(j, p2, NodeIDFromName, v6, false)
                        end
                    end
                end
            end
            v3 = nil
            if v2 then
                local new = (require(v2)).new
                local v8 = u229
                v3 = new(v1, v8, {Model = p2})
                if v3.SettingChanges then
                    local SettingChanges = v3.SettingChanges
                    local v9 = nil
                    v8 = nil
                    for k, n in SettingChanges, v9, v8 do
                        if k == "Damage" and u229.DamageDropoff and not v3.SettingChanges.DamageDropoff then
                            u229.DamageDropoff = DamageFalloffUtil.RescaleDropoff(u229.DamageDropoff, u229.Damage, n)
                        end
                        u229[k] = n
                    end
                end
            end
            return v3
        end

        local v30 = u218
        table.insert(v30, AttachAttachment)

        function selectAttachment(p1, p2_2, p3_2) -- Line: 610
            -- upvalues: Sounds (upval), u221 (upval), p4 (val), p3 (val), u135 (val), selectAttachment (val)
            -- upvalues: u220 (upval), destroyNodePartTree (val), u229 (upval), WepConfig (upval), p2 (val)
            -- upvalues: AttachmentSystem (upval), u213 (upval), AttachAttachment (val), u149 (upval), u48 (ref)
            -- upvalues: u53 (ref)
            local v1, v2, v3, v4
            local upper = string.upper
            local Alias = p2_2.Alias
            if not Alias then
                Alias = p2_2.Name
            end
            local v5 = upper(Alias)
            ;(Sounds.Att:GetChildren())[math.random(1, 3)]:Play()
            if not p3_2 then
                v1 = u221[p4]
                if v1 then
                    v1[p3] = nil
                end
            else
                v1 = u221[p4]
                if not v1 then
                    v1 = {}
                    u221[p4] = v1
                end
                if not v1[p3] then
                    v2 = (p4:GetNodes())[p3]
                    v3 = 0
                    if v2 and v2.ConnectedAttachment then
                        v3 = v2.ConnectedAttachment:GetAttachmentIndex()
                    end
                    v4 = {
                        OriginalAttachmentIndex = v3,
                        OriginalProperties = u135[v3],
                        SelectFunction = selectAttachment,
                    }
                    v1[p3] = v4
                end
            end
            v1 = p4
            v3 = p3
            v1:SetNodeAttachment(v3, p1)
            if not (p4:GetNodes())[p3].ConnectedAttachment then
                v1 = u220[p4]
                if v1 and v1[p3] then
                    destroyNodePartTree(v1[p3])
                end
            end
            v1 = deepCopy
            v2 = WepConfig
            v4 = p2
            local Name = v4.Name
            u229 = v1(v2:GetWeaponConfig(Name))
            if p2.Parent then
                local Image
                p2.Attachments:ClearAllChildren()
                v2, v3 = (AttachmentSystem.DressWeapon(p2.Name, u213, u229.AttachmentNodeData, p2, AttachAttachment)):timeout(10):await()
                if not v2 then
                    warn("[WeaponModding] DressWeapon timed out or failed (" .. "selectAttachment" .. "):\n" .. tostring(v3))
                end
                v1 = u149
                v3 = u229
                v1:UpdateStats(v3)
                u149:UpdateDisplay()
                if not p2_2.Image then
                    Image = "rbxassetid://4923293939"
                else
                    Image = p2_2.Image
                end
                u48.Text = v5
                u53.Image = Image
            end
        end

        local function removePreview() -- Line: 671
            -- upvalues: u221 (upval), p4 (val), p3 (val), selectAttachment (val)
            local v1 = u221[p4]
            if v1 then
                local v2 = v1[p3]
                if v2 then
                    selectAttachment(v2.OriginalAttachmentIndex, v2.OriginalProperties)
                end
            end
        end

        local u1131 = {}
        local v31 = u200.Progression.Weapons[ItemIdFromName]
        if not v31 then
            v4 = {}
        else
            v4 = deserializeUnlockedAttachments(v31[3])
        end
        local AbsoluteSize = Attachments.AbsoluteSize
        local v32 = u135
        local v33 = nil
        local v34 = nil
        for k, n in v32, v33, v34 do
            v5 = n.UnlockLevel or 999
            upper_2 = string.upper
            Alias_2 = n.Alias
            if not Alias_2 then
                Alias_2 = n.Name
            end
            local u405 = upper_2(Alias_2)
            local u447 = false
            local FixedPrice = nil
            v7 = AttachmentEntitlements.HasEntitlement(u200, n)
            if not AttachmentEntitlements.IsEntitlementGated(n) then
                if u405 == "NONE" then
                    u447 = true
                    v6 = u1079:WaitForChild("NONE")
                elseif not u201 then
                    if v7 or table.find(v4, n.ID) then
                        u447 = true
                    end
                    v6 = Template_2:Clone()
                    v6.LayoutOrder = v5
                else
                    u447 = true
                    v6 = Template_2:Clone()
                    v6.LayoutOrder = v5
                end
                local ImageButton = v6:WaitForChild("ImageButton")
                if u405 ~= "NONE" then
                    ImageLabel = ImageButton:WaitForChild("ImageLabel")
                    if n.Image then
                        ImageLabel.Image = n.Image
                        DropShadow = ImageLabel:WaitForChild("DropShadow")
                        DropShadow.Image = n.Image
                    end
                    local TextLine1 = ImageButton:WaitForChild("TextLine1")
                    TextLine2 = ImageButton:WaitForChild("TextLine2")
                    v11 = AbsoluteSize.Y * Attachments_2.Size.Y.Scale
                    v12 = v11 * Template_2.Size.X.Scale * ImageButton.Size.X.Scale
                    v13 = v11 * Template_2.Size.Y.Scale * ImageButton.Size.Y.Scale
                    v15 = v12 * TextLine1.Size.X.Scale
                    v14 = math.floor(v15)
                    v16 = v13 * TextLine1.Size.Y.Scale
                    local u528 = math.floor(v16)

                    function getTextWidth(p1) -- Line: 737 -- upvalues: TextService (upval), u528 (val), TextLine1 (val)
                        local v1 = TextService
                        local v2 = u528
                        local v3 = TextLine1
                        local Font = v3.Font
                        local new = Vector2.new
                        local v4 = u528
                        local v5 = new((1 / 0), v4)
                        return v1:GetTextSize(p1, v2, Font, v5).X
                    end

                    split = string.split
                    v18 = trim(u405)
                    v17 = split(v18, " ")
                    if not (1 < #v17) then
                        TextLine1.Text = ""
                        TextLine2.Text = u405
                    else
                        v18 = TextService
                        Font_2 = TextLine1.Font
                        v23 = Vector2.new((1 / 0), u528)
                        if not (v14 < v18:GetTextSize(u405, u528, Font_2, v23).X) then
                            TextLine1.Text = ""
                            TextLine2.Text = u405
                        else
                            v18 = table.clone(v17)
                            v19 = #v17
                            while true do
                                v21 = wordsToSentence(v18)
                                v22 = TextService
                                Font = TextLine1.Font
                                v24 = Vector2.new((1 / 0), u528)
                                if not (v14 < v22:GetTextSize(v21, u528, Font, v24).X) or v19 == 1 then
                                    break
                                end
                                table.remove(v18, v19)
                                v19 = v19 - 1
                            end
                            v20 = v19
                            for m = 1, v20 do
                                table.remove(v17, 1)
                            end
                            TextLine1.Text = wordsToSentence(v18)
                            TextLine2.Text = wordsToSentence(v17)
                        end
                    end
                    if not u447 then
                        LockedFrame = ImageButton:WaitForChild("LockedFrame")
                        LockedFrame.Visible = true
                        v18 = 0
                        if v31 then
                            v18 = v31[1]
                        end
                        if not n.FixedPrice then
                            FixedPrice = LevelInfo:AttachmentUnlockCost(v18, v5)
                        else
                            FixedPrice = n.FixedPrice
                        end
                        LevelLabel = ImageButton.LockedFrame:WaitForChild("LevelLabel")
                        local PriceLabel = ImageButton.LockedFrame:WaitForChild("PriceLabel")
                        if not n.PurchaseOnly then
                            LevelLabel.Text = "LEVEL " .. v5
                        else
                            LevelLabel.Text = "LEVEL N/A"
                        end
                        if not (v18 < v5) then
                            LevelLabel.TextColor3 = Color3.new(1, 1, 1)
                        else
                            LevelLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                        end
                        if FixedPrice ~= 0 then
                            PriceLabel.Text = FixedPrice .. " Z$"
                        else
                            PriceLabel.Text = "FREE"
                        end

                        local function updatePriceColor() -- Line: 796
                            -- upvalues: FixedPrice (ref), u200 (upval), PriceLabel (val), ImageButton (val)
                            local v1 = FixedPrice
                            if u200.Progression.ZBucks < v1 then
                                PriceLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                                return
                            end
                            ImageButton.LockedFrame.PriceLabel.TextColor3 = Color3.new(1, 1, 1)
                        end

                        u223[updatePriceColor] = true
                        ImageButton.Destroying:Connect(function() -- Line: 805 -- upvalues: u223 (upval), updatePriceColor (val)
                            u223[updatePriceColor] = nil
                        end)
                        setSelectionFrameAppearance(ImageButton, "unlock")
                    else
                        setSelectionFrameAppearance(ImageButton, "equip")
                    end
                end
                v6.Visible = true
                v6.Name = n.Name
                v6.Parent = u1079
                v8, v9, v10 = clickEvent(ImageButton)
                v11 = #u1131 + 1
                u1131[v11] = (v8:Connect(function() -- Line: 818
                    -- upvalues: u228 (upval), ImageButton (val), u447 (ref), Sounds (upval), u227 (upval), u225 (upval)
                    -- upvalues: u302 (upval), FixedPrice (ref), u200 (upval), u231 (upval), n (val)
                    -- upvalues: ItemIdFromName (val), u405 (val), selectAttachment (val), k (val)
                    if u228 ~= ImageButton then
                        if u228 then
                            setAttachmentButtonSelected(u228, false)
                        end
                        u228 = ImageButton
                        setAttachmentButtonSelected(ImageButton, true)
                        setProsCons(n)
                        selectAttachment(k, n, not u447)
                        return
                    end
                    if u447 then
                        setMode("Nodes")
                        Sounds.close:Play()
                        u227 = nil
                        u225 = nil
                        u302.HoveringOver = nil
                        closePurchaseModPrompt()
                        return
                    end
                    if FixedPrice then
                        local v1 = u200
                        local ZBucks = v1.Progression.ZBucks
                        if FixedPrice <= ZBucks then
                            if u231 and u231.ModID == n.ID then
                                closePurchaseModPrompt()
                                return
                            end
                            openPurchaseModPrompt(ItemIdFromName, n.ID, u405, FixedPrice)
                            return
                        end
                    end
                end))
                v11 = #u1131 + 1
                u1131[v11] = (v9:Connect(function() -- Line: 852 -- upvalues: u225 (upval), n (val)
                    u225 = n
                end))
                v11 = #u1131 + 1
                u1131[v11] = (v10:Connect(function() -- Line: 855 -- upvalues: u225 (upval), n (val), p4 (val), p3 (val)
                    if u225 == n then
                        local v1 = (p4:GetNodes())[p3]
                        if v1 and v1.ConnectedAttachment and v1.ConnectedAttachment:GetAttachmentIndex() ~= 0 then
                            u225 = v1.ConnectedAttachment:GetAttachmentData()
                        end
                    end
                end))
                if u405 ~= "NONE" then
                    if not u222[n.ID] then
                        u222[n.ID] = {}
                    end

                    u222[n.ID][ImageButton] = function() -- Line: 867
                        -- upvalues: u447 (ref), ImageButton (val), u228 (upval), selectAttachment (val), k (val)
                        -- upvalues: n (val)
                        if not u447 then
                            u447 = true
                            local LockedFrame = ImageButton:WaitForChild("LockedFrame")
                            LockedFrame.Visible = false
                            setSelectionFrameAppearance(ImageButton, "equip")
                            if u228 == ImageButton then
                                setAttachmentButtonSelected(ImageButton, true)
                                selectAttachment(k, n, false)
                            end
                        end
                    end

                    ImageButton.Destroying:Connect(function() -- Line: 883 -- upvalues: u222 (upval), n (val), ImageButton (val)
                        local v1 = u222[n.ID]
                        v1[ImageButton] = nil
                    end)
                end
            elseif v7 then
                if u405 == "NONE" then
                    u447 = true
                    v6 = u1079:WaitForChild("NONE")
                elseif not u201 then
                    if v7 or table.find(v4, n.ID) then
                        u447 = true
                    end
                    v6 = Template_2:Clone()
                    v6.LayoutOrder = v5
                else
                    u447 = true
                    v6 = Template_2:Clone()
                    v6.LayoutOrder = v5
                end
                local ImageButton = v6:WaitForChild("ImageButton")
                if u405 ~= "NONE" then
                    ImageLabel = ImageButton:WaitForChild("ImageLabel")
                    if n.Image then
                        ImageLabel.Image = n.Image
                        DropShadow = ImageLabel:WaitForChild("DropShadow")
                        DropShadow.Image = n.Image
                    end
                    local TextLine1 = ImageButton:WaitForChild("TextLine1")
                    TextLine2 = ImageButton:WaitForChild("TextLine2")
                    v11 = AbsoluteSize.Y * Attachments_2.Size.Y.Scale
                    v12 = v11 * Template_2.Size.X.Scale * ImageButton.Size.X.Scale
                    v13 = v11 * Template_2.Size.Y.Scale * ImageButton.Size.Y.Scale
                    v15 = v12 * TextLine1.Size.X.Scale
                    v14 = math.floor(v15)
                    v16 = v13 * TextLine1.Size.Y.Scale
                    local u528 = math.floor(v16)

                    function getTextWidth(p1) -- Line: 737 -- upvalues: TextService (upval), u528 (val), TextLine1 (val)
                        local v1 = TextService
                        local v2 = u528
                        local v3 = TextLine1
                        local Font = v3.Font
                        local new = Vector2.new
                        local v4 = u528
                        local v5 = new((1 / 0), v4)
                        return v1:GetTextSize(p1, v2, Font, v5).X
                    end

                    split = string.split
                    v18 = trim(u405)
                    v17 = split(v18, " ")
                    if not (1 < #v17) then
                        TextLine1.Text = ""
                        TextLine2.Text = u405
                    else
                        v18 = TextService
                        Font_2 = TextLine1.Font
                        v23 = Vector2.new((1 / 0), u528)
                        if not (v14 < v18:GetTextSize(u405, u528, Font_2, v23).X) then
                            TextLine1.Text = ""
                            TextLine2.Text = u405
                        else
                            v18 = table.clone(v17)
                            v19 = #v17
                            while true do
                                v21 = wordsToSentence(v18)
                                v22 = TextService
                                Font = TextLine1.Font
                                v24 = Vector2.new((1 / 0), u528)
                                if not (v14 < v22:GetTextSize(v21, u528, Font, v24).X) or v19 == 1 then
                                    break
                                end
                                table.remove(v18, v19)
                                v19 = v19 - 1
                            end
                            v20 = v19
                            for i5 = 1, v20 do
                                table.remove(v17, 1)
                            end
                            TextLine1.Text = wordsToSentence(v18)
                            TextLine2.Text = wordsToSentence(v17)
                        end
                    end
                    if not u447 then
                        LockedFrame = ImageButton:WaitForChild("LockedFrame")
                        LockedFrame.Visible = true
                        v18 = 0
                        if v31 then
                            v18 = v31[1]
                        end
                        if not n.FixedPrice then
                            FixedPrice = LevelInfo:AttachmentUnlockCost(v18, v5)
                        else
                            FixedPrice = n.FixedPrice
                        end
                        LevelLabel = ImageButton.LockedFrame:WaitForChild("LevelLabel")
                        local PriceLabel = ImageButton.LockedFrame:WaitForChild("PriceLabel")
                        if not n.PurchaseOnly then
                            LevelLabel.Text = "LEVEL " .. v5
                        else
                            LevelLabel.Text = "LEVEL N/A"
                        end
                        if not (v18 < v5) then
                            LevelLabel.TextColor3 = Color3.new(1, 1, 1)
                        else
                            LevelLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                        end
                        if FixedPrice ~= 0 then
                            PriceLabel.Text = FixedPrice .. " Z$"
                        else
                            PriceLabel.Text = "FREE"
                        end

                        local function updatePriceColor() -- Line: 796
                            -- upvalues: FixedPrice (ref), u200 (upval), PriceLabel (val), ImageButton (val)
                            local v1 = FixedPrice
                            if u200.Progression.ZBucks < v1 then
                                PriceLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                                return
                            end
                            ImageButton.LockedFrame.PriceLabel.TextColor3 = Color3.new(1, 1, 1)
                        end

                        u223[updatePriceColor] = true
                        ImageButton.Destroying:Connect(function() -- Line: 805 -- upvalues: u223 (upval), updatePriceColor (val)
                            u223[updatePriceColor] = nil
                        end)
                        setSelectionFrameAppearance(ImageButton, "unlock")
                    else
                        setSelectionFrameAppearance(ImageButton, "equip")
                    end
                end
                v6.Visible = true
                v6.Name = n.Name
                v6.Parent = u1079
                v8, v9, v10 = clickEvent(ImageButton)
                v11 = #u1131 + 1
                u1131[v11] = (v8:Connect(function() -- Line: 818
                    -- upvalues: u228 (upval), ImageButton (val), u447 (ref), Sounds (upval), u227 (upval), u225 (upval)
                    -- upvalues: u302 (upval), FixedPrice (ref), u200 (upval), u231 (upval), n (val)
                    -- upvalues: ItemIdFromName (val), u405 (val), selectAttachment (val), k (val)
                    if u228 ~= ImageButton then
                        if u228 then
                            setAttachmentButtonSelected(u228, false)
                        end
                        u228 = ImageButton
                        setAttachmentButtonSelected(ImageButton, true)
                        setProsCons(n)
                        selectAttachment(k, n, not u447)
                        return
                    end
                    if u447 then
                        setMode("Nodes")
                        Sounds.close:Play()
                        u227 = nil
                        u225 = nil
                        u302.HoveringOver = nil
                        closePurchaseModPrompt()
                        return
                    end
                    if FixedPrice then
                        local v1 = u200
                        local ZBucks = v1.Progression.ZBucks
                        if FixedPrice <= ZBucks then
                            if u231 and u231.ModID == n.ID then
                                closePurchaseModPrompt()
                                return
                            end
                            openPurchaseModPrompt(ItemIdFromName, n.ID, u405, FixedPrice)
                            return
                        end
                    end
                end))
                v11 = #u1131 + 1
                u1131[v11] = (v9:Connect(function() -- Line: 852 -- upvalues: u225 (upval), n (val)
                    u225 = n
                end))
                v11 = #u1131 + 1
                u1131[v11] = (v10:Connect(function() -- Line: 855 -- upvalues: u225 (upval), n (val), p4 (val), p3 (val)
                    if u225 == n then
                        local v1 = (p4:GetNodes())[p3]
                        if v1 and v1.ConnectedAttachment and v1.ConnectedAttachment:GetAttachmentIndex() ~= 0 then
                            u225 = v1.ConnectedAttachment:GetAttachmentData()
                        end
                    end
                end))
                if u405 ~= "NONE" then
                    if not u222[n.ID] then
                        u222[n.ID] = {}
                    end

                    u222[n.ID][ImageButton] = function() -- Line: 867
                        -- upvalues: u447 (ref), ImageButton (val), u228 (upval), selectAttachment (val), k (val)
                        -- upvalues: n (val)
                        if not u447 then
                            u447 = true
                            local LockedFrame = ImageButton:WaitForChild("LockedFrame")
                            LockedFrame.Visible = false
                            setSelectionFrameAppearance(ImageButton, "equip")
                            if u228 == ImageButton then
                                setAttachmentButtonSelected(ImageButton, true)
                                selectAttachment(k, n, false)
                            end
                        end
                    end

                    ImageButton.Destroying:Connect(function() -- Line: 883 -- upvalues: u222 (upval), n (val), ImageButton (val)
                        local v1 = u222[n.ID]
                        v1[ImageButton] = nil
                    end)
                end
            elseif u201 then
                if u405 == "NONE" then
                    u447 = true
                    v6 = u1079:WaitForChild("NONE")
                elseif not u201 then
                    if v7 or table.find(v4, n.ID) then
                        u447 = true
                    end
                    v6 = Template_2:Clone()
                    v6.LayoutOrder = v5
                else
                    u447 = true
                    v6 = Template_2:Clone()
                    v6.LayoutOrder = v5
                end
                local ImageButton = v6:WaitForChild("ImageButton")
                if u405 ~= "NONE" then
                    ImageLabel = ImageButton:WaitForChild("ImageLabel")
                    if n.Image then
                        ImageLabel.Image = n.Image
                        DropShadow = ImageLabel:WaitForChild("DropShadow")
                        DropShadow.Image = n.Image
                    end
                    local TextLine1 = ImageButton:WaitForChild("TextLine1")
                    TextLine2 = ImageButton:WaitForChild("TextLine2")
                    v11 = AbsoluteSize.Y * Attachments_2.Size.Y.Scale
                    v12 = v11 * Template_2.Size.X.Scale * ImageButton.Size.X.Scale
                    v13 = v11 * Template_2.Size.Y.Scale * ImageButton.Size.Y.Scale
                    v15 = v12 * TextLine1.Size.X.Scale
                    v14 = math.floor(v15)
                    v16 = v13 * TextLine1.Size.Y.Scale
                    local u528 = math.floor(v16)

                    function getTextWidth(p1) -- Line: 737 -- upvalues: TextService (upval), u528 (val), TextLine1 (val)
                        local v1 = TextService
                        local v2 = u528
                        local v3 = TextLine1
                        local Font = v3.Font
                        local new = Vector2.new
                        local v4 = u528
                        local v5 = new((1 / 0), v4)
                        return v1:GetTextSize(p1, v2, Font, v5).X
                    end

                    split = string.split
                    v18 = trim(u405)
                    v17 = split(v18, " ")
                    if not (1 < #v17) then
                        TextLine1.Text = ""
                        TextLine2.Text = u405
                    else
                        v18 = TextService
                        Font_2 = TextLine1.Font
                        v23 = Vector2.new((1 / 0), u528)
                        if not (v14 < v18:GetTextSize(u405, u528, Font_2, v23).X) then
                            TextLine1.Text = ""
                            TextLine2.Text = u405
                        else
                            v18 = table.clone(v17)
                            v19 = #v17
                            while true do
                                v21 = wordsToSentence(v18)
                                v22 = TextService
                                Font = TextLine1.Font
                                v24 = Vector2.new((1 / 0), u528)
                                if not (v14 < v22:GetTextSize(v21, u528, Font, v24).X) or v19 == 1 then
                                    break
                                end
                                table.remove(v18, v19)
                                v19 = v19 - 1
                            end
                            v20 = v19
                            for i6 = 1, v20 do
                                table.remove(v17, 1)
                            end
                            TextLine1.Text = wordsToSentence(v18)
                            TextLine2.Text = wordsToSentence(v17)
                        end
                    end
                    if not u447 then
                        LockedFrame = ImageButton:WaitForChild("LockedFrame")
                        LockedFrame.Visible = true
                        v18 = 0
                        if v31 then
                            v18 = v31[1]
                        end
                        if not n.FixedPrice then
                            FixedPrice = LevelInfo:AttachmentUnlockCost(v18, v5)
                        else
                            FixedPrice = n.FixedPrice
                        end
                        LevelLabel = ImageButton.LockedFrame:WaitForChild("LevelLabel")
                        local PriceLabel = ImageButton.LockedFrame:WaitForChild("PriceLabel")
                        if not n.PurchaseOnly then
                            LevelLabel.Text = "LEVEL " .. v5
                        else
                            LevelLabel.Text = "LEVEL N/A"
                        end
                        if not (v18 < v5) then
                            LevelLabel.TextColor3 = Color3.new(1, 1, 1)
                        else
                            LevelLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                        end
                        if FixedPrice ~= 0 then
                            PriceLabel.Text = FixedPrice .. " Z$"
                        else
                            PriceLabel.Text = "FREE"
                        end

                        local function updatePriceColor() -- Line: 796
                            -- upvalues: FixedPrice (ref), u200 (upval), PriceLabel (val), ImageButton (val)
                            local v1 = FixedPrice
                            if u200.Progression.ZBucks < v1 then
                                PriceLabel.TextColor3 = Color3.fromRGB(255, 92, 92)
                                return
                            end
                            ImageButton.LockedFrame.PriceLabel.TextColor3 = Color3.new(1, 1, 1)
                        end

                        u223[updatePriceColor] = true
                        ImageButton.Destroying:Connect(function() -- Line: 805 -- upvalues: u223 (upval), updatePriceColor (val)
                            u223[updatePriceColor] = nil
                        end)
                        setSelectionFrameAppearance(ImageButton, "unlock")
                    else
                        setSelectionFrameAppearance(ImageButton, "equip")
                    end
                end
                v6.Visible = true
                v6.Name = n.Name
                v6.Parent = u1079
                v8, v9, v10 = clickEvent(ImageButton)
                v11 = #u1131 + 1
                u1131[v11] = (v8:Connect(function() -- Line: 818
                    -- upvalues: u228 (upval), ImageButton (val), u447 (ref), Sounds (upval), u227 (upval), u225 (upval)
                    -- upvalues: u302 (upval), FixedPrice (ref), u200 (upval), u231 (upval), n (val)
                    -- upvalues: ItemIdFromName (val), u405 (val), selectAttachment (val), k (val)
                    if u228 ~= ImageButton then
                        if u228 then
                            setAttachmentButtonSelected(u228, false)
                        end
                        u228 = ImageButton
                        setAttachmentButtonSelected(ImageButton, true)
                        setProsCons(n)
                        selectAttachment(k, n, not u447)
                        return
                    end
                    if u447 then
                        setMode("Nodes")
                        Sounds.close:Play()
                        u227 = nil
                        u225 = nil
                        u302.HoveringOver = nil
                        closePurchaseModPrompt()
                        return
                    end
                    if FixedPrice then
                        local v1 = u200
                        local ZBucks = v1.Progression.ZBucks
                        if FixedPrice <= ZBucks then
                            if u231 and u231.ModID == n.ID then
                                closePurchaseModPrompt()
                                return
                            end
                            openPurchaseModPrompt(ItemIdFromName, n.ID, u405, FixedPrice)
                            return
                        end
                    end
                end))
                v11 = #u1131 + 1
                u1131[v11] = (v9:Connect(function() -- Line: 852 -- upvalues: u225 (upval), n (val)
                    u225 = n
                end))
                v11 = #u1131 + 1
                u1131[v11] = (v10:Connect(function() -- Line: 855 -- upvalues: u225 (upval), n (val), p4 (val), p3 (val)
                    if u225 == n then
                        local v1 = (p4:GetNodes())[p3]
                        if v1 and v1.ConnectedAttachment and v1.ConnectedAttachment:GetAttachmentIndex() ~= 0 then
                            u225 = v1.ConnectedAttachment:GetAttachmentData()
                        end
                    end
                end))
                if u405 ~= "NONE" then
                    if not u222[n.ID] then
                        u222[n.ID] = {}
                    end

                    u222[n.ID][ImageButton] = function() -- Line: 867
                        -- upvalues: u447 (ref), ImageButton (val), u228 (upval), selectAttachment (val), k (val)
                        -- upvalues: n (val)
                        if not u447 then
                            u447 = true
                            local LockedFrame = ImageButton:WaitForChild("LockedFrame")
                            LockedFrame.Visible = false
                            setSelectionFrameAppearance(ImageButton, "equip")
                            if u228 == ImageButton then
                                setAttachmentButtonSelected(ImageButton, true)
                                selectAttachment(k, n, false)
                            end
                        end
                    end

                    ImageButton.Destroying:Connect(function() -- Line: 883 -- upvalues: u222 (upval), n (val), ImageButton (val)
                        local v1 = u222[n.ID]
                        v1[ImageButton] = nil
                    end)
                end
            end
        end
        ;((u1079:WaitForChild("UIListLayout")):GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function() -- Line: 891 -- upvalues: u1079 (ref), Attachments (upval)
            local v1 = u1079
            v1.CanvasSize = UDim2.new(0, u1079.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01, 0, 0)
        end)
        local new = UDim2.new
        v32 = u1079.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01
        u1079.CanvasSize = new(0, v32, 0, 0)
        if p5 then
            v4 = deepCopy
            local v35 = WepConfig
            local Name = p2.Name
            u229 = v4(v35:GetWeaponConfig(Name))
            v35, v32 = (AttachmentSystem.DressWeapon(p2.Name, u213, u229.AttachmentNodeData, p2, AttachAttachment)):timeout(10):await()
            if not v35 then
                warn("[WeaponModding] DressWeapon timed out or failed (" .. "MakeGui runDress" .. "):\n" .. tostring(v32))
            end
            v4 = u149
            v32 = u229
            v4:UpdateStats(v32)
            u149:UpdateDisplay()
        end
        local u270 = nil
        local u273 = nil
        local u274 = nil
        local u275 = nil
        local u280 = script.Square:Clone()
        u280.Parent = Attachments
        v5 = GuiTransparency
        local v36 = u212
        v5:SetTransparency(u280, 1, v36)
        v5 = #u1131 + 1
        local v37 = RunService
        local RenderStepped = v37.RenderStepped
        u1131[v5] = (RenderStepped:Connect(function() -- Line: 923
            -- upvalues: p1 (val), CurrentCamera (upval), u270 (ref), drawLine (upval), u1074 (ref), Attachments (upval)
            -- upvalues: u280 (val), u275 (ref), GuiTransparency (upval), u302 (upval), u1052 (ref), u273 (ref)
            -- upvalues: u274 (ref), u212 (upval), u227 (upval), p4 (val), p3 (val), u224 (upval)
            local v1, v2
            local v3 = p1
            local Position = v3.Position
            local v4 = CurrentCamera:WorldToScreenPoint(Position)
            local v5 = drawLine
            local v6 = u1074
            local AbsolutePosition = v6.AbsolutePosition
            local v7 = Vector2.new(v4.X, v4.Y)
            u270 = v5(AbsolutePosition, v7, Attachments, u270)
            u280.Position = UDim2.new(0, v4.X, 0, v4.Y)
            if not u275 then
                u275 = true
                v5 = GuiTransparency
                v7 = u270
                v2 = TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                v5:SetTransparency(v7, 1, v2)
                u270.BackgroundTransparency = 1
            end
            if u302.HoveringOver == u1052 then
                if u273 and not u274 and u302.HoveringOver == u1052 then
                    u273 = false
                    u274 = true
                    v5 = GuiTransparency
                    v7 = u280
                    v1 = u212
                    v5:Revert(v7, v1)
                    v5 = GuiTransparency
                    v7 = u270
                    v1 = u212
                    v5:Revert(v7, v1)
                end
            elseif not u273 then
                u273 = true
                u274 = false
                v5 = GuiTransparency
                v7 = u270
                v2 = u212
                v5:SetTransparency(v7, 1, v2)
                v5 = GuiTransparency
                v7 = u280
                v2 = u212
                v5:SetTransparency(v7, 1, v2)
            elseif u273 and not u274 and u302.HoveringOver == u1052 then
                u273 = false
                u274 = true
                v5 = GuiTransparency
                v7 = u280
                v1 = u212
                v5:Revert(v7, v1)
                v5 = GuiTransparency
                v7 = u270
                v1 = u212
                v5:Revert(v7, v1)
            end
            if u227 ~= nil and u227 == u1052 then
                u270.BackgroundTransparency = 1
            end
            v5 = (p4:GetNodes())[p3]
            local ConnectedAttachment = nil
            if v5 then
                ConnectedAttachment = v5.ConnectedAttachment
            end
            if u302.HoveringOver ~= u1052 then
                if u224[ConnectedAttachment] then
                    v7 = u224[ConnectedAttachment]
                    v7.Enabled = false
                end
                return
            end
            if not u224[ConnectedAttachment] then
                return
            end
            v7 = u224[ConnectedAttachment]
            v7.Enabled = true
        end))
        v5, v37, v6 = clickEvent(u1052)
        local v38 = #u1131 + 1
        u1131[v38] = (v5:Connect(function() -- Line: 972
            -- upvalues: Sounds (upval), u215 (upval), u216 (upval), p4 (val), p1 (val), u1079 (ref), u227 (upval)
            -- upvalues: u1052 (ref), u1100 (ref), u228 (upval), u302 (upval), u225 (upval)
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
            v1 = p4
            v3 = p1
            local Name = v3.Name
            local AttachmentFromNodeName = v1:GetAttachmentFromNodeName(Name)
            if not AttachmentFromNodeName or AttachmentFromNodeName:GetAttachmentIndex() == 0 then
                v2 = {Name = "NONE"}
            else
                local AttachmentData = AttachmentFromNodeName:GetAttachmentData()
                if not AttachmentData then
                    AttachmentData = {Name = "NONE"}
                end
                v2 = AttachmentData
            end
            v3 = u1079
            local v4 = u227 ~= u1052
            v3.Visible = v4
            v3 = u1100
            local v5 = u1079
            local Visible = v5.Visible
            v3:SetVisible(Visible)
            v3 = u1079
            local Name_2 = v2.Name
            v3 = v3:FindFirstChild(Name_2)
            if v3 then
                u228 = v3.ImageButton
                setAttachmentButtonSelected(u228, true)
            end
            if not u1079.Visible then
                Sounds.close:Play()
                u227 = nil
                u225 = nil
            else
                u302.HoveringOver = u1052
                Sounds.open:Play()
                u227 = u1052
                u225 = v2
            end
            v4 = setMode
            if not u1079.Visible then
                v5 = "Nodes"
            else
                v5 = "Attachments"
            end
            v4(v5)
        end))
        v38 = #u1131 + 1
        u1131[v38] = (v37:Connect(function() -- Line: 1015 -- upvalues: u227 (upval), u302 (upval), u1052 (ref)
            if u227 then
                return
            end
            u302.HoveringOver = u1052
        end))
        v38 = #u1131 + 1
        u1131[v38] = (v6:Connect(function() -- Line: 1019 -- upvalues: u227 (upval), u302 (upval), u1052 (ref)
            if u227 then
                return
            end
            if u302.HoveringOver == u1052 then
                u302.HoveringOver = nil
            end
        end))
        u1052.Parent = Nodes
        Nodes.CanvasSize = UDim2.new(0, 0, 0, Nodes.UIListLayout.AbsoluteContentSize.Y)

        local function CleanUp() -- Line: 1029
            -- upvalues: u1052 (ref), u1079 (ref), u270 (ref), u280 (val), u1131 (val)
            if u1052 then
                u1052:Destroy()
            end
            if u1079 then
                u1079:Destroy()
            end
            if u270 then
                u270:Destroy()
            end
            if u280 then
                u280:Destroy()
            end
            for k, v in pairs(u1131) do
                v:Disconnect()
            end
            table.clear(u1131)
        end

        v36 = #u1131 + 1
        local Destroying = p2.Destroying
        u1131[v36] = (Destroying:Connect(function() -- Line: 1049 -- upvalues: CleanUp (val)
            CleanUp()
        end))
        v36 = #u1131 + 1
        local Destroying_2 = p1.Destroying
        u1131[v36] = (Destroying_2:Connect(function() -- Line: 1053 -- upvalues: CleanUp (val)
            CleanUp()
        end))
        local ExpansionWeld = p1:FindFirstChild("ExpansionWeld")
        if ExpansionWeld then
            v7 = #u1131 + 1
            local Destroying_3 = ExpansionWeld.Part0.Destroying
            u1131[v7] = (Destroying_3:Connect(function() -- Line: 1060 -- upvalues: CleanUp (val), p1 (val)
                CleanUp()
                p1:Destroy()
            end))
            v7 = #u1131 + 1
            local Destroying_4 = ExpansionWeld.Part1.Destroying
            u1131[v7] = (Destroying_4:Connect(function() -- Line: 1064 -- upvalues: CleanUp (val)
                CleanUp()
            end))
            v7 = #u1131 + 1
            local Destroying_5 = ExpansionWeld.Destroying
            u1131[v7] = (Destroying_5:Connect(function() -- Line: 1067 -- upvalues: CleanUp (val), p1 (val)
                CleanUp()
                p1:Destroy()
            end))
        end
        return
    end
end

local u376 = {}

function u204(p1) -- Line: 1078 -- upvalues: u376 (ref)
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
    if BasePoints and Weapon and Handle then
        local BasePart, CFrame_2, CFrame_3, Name, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
        local v11 = {}
        for i, j in Weapon:GetChildren() do
            if j:IsA("Model") then
                BasePart = j:FindFirstChildWhichIsA("BasePart", true)
                if not BasePart then
                    for k, n in j:GetAttributes() do
                        if string.sub(k, 1, 13) == "NodeOverride_" then
                            v4 = string.sub(k, 14)
                            v5 = string.split(tostring(n), ",")
                            if #v5 == 3 then
                                v8 = v5[1]
                                v6 = tonumber(v8) or 0
                                v9 = v5[2]
                                v7 = tonumber(v9) or 0
                                v10 = v5[3]
                                v9 = tonumber(v10)
                                v11[v4] = (Vector3.new(v6, v7, v9 or 0))
                            end
                        end
                    end
                elseif not BasePart:GetAttribute("OptionGroupHidden") then
                    for m, i5 in j:GetAttributes() do
                        if string.sub(m, 1, 13) == "NodeOverride_" then
                            v4 = string.sub(m, 14)
                            v5 = string.split(tostring(i5), ",")
                            if #v5 == 3 then
                                v8 = v5[1]
                                v6 = tonumber(v8) or 0
                                v9 = v5[2]
                                v7 = tonumber(v9) or 0
                                v10 = v5[3]
                                v9 = tonumber(v10)
                                v11[v4] = (Vector3.new(v6, v7, v9 or 0))
                            end
                        end
                    end
                end
            end
        end
        for i6, i7 in BasePoints:GetChildren() do
            if i7:IsA("BasePart") then
                CFrame_2 = Handle.CFrame
                CFrame_3 = i7.CFrame
                v1 = CFrame_2:ToObjectSpace(CFrame_3)
                v2 = v11[i7.Name]
                if not v2 then
                    u376[i7.Name] = v1
                else
                    v3 = u376
                    Name = i7.Name
                    v3[Name] = (CFrame.new(v1.Position - v2)) * v1.Rotation
                end
            end
        end
        return
    end
end

local function u378(p1) -- Line: 1122 -- upvalues: u376 (ref)
    if not next(u376) then
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
    if BasePoints and Weapon and Handle then
        local BasePart, CFrame_2, Part1, Weld, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
        local KeyParts = p1:FindFirstChild("KeyParts")

        local function moveBasePoint(p1, p2) -- Line: 1134 -- upvalues: KeyParts (val)
            local Part1, v1
            local v2 = nil
            local v3, v4 = p1, p2
            for i, j in p1:GetJoints() do
                if j:IsA("JointInstance") and KeyParts then
                    if j.Part0 == v3 then
                        Part1 = j.Part1
                    elseif j.Part1 ~= v3 then
                        Part1 = nil
                    else
                        Part1 = j.Part0
                    end
                    if Part1 then
                        v1 = KeyParts
                        if Part1:IsDescendantOf(v1) then
                            v2 = Part1
                            j:Destroy()
                            break
                        end
                    end
                end
            end
            v3.CFrame = v4
            if v2 then
                local Weld = Instance.new("Weld")
                Weld.Part0 = v2
                Weld.Part1 = v3
                Weld.C0 = CFrame.new()
                local CFrame_2 = v3.CFrame
                local CFrame_3 = v2.CFrame
                Weld.C1 = CFrame_2:toObjectSpace(CFrame_3)
                Weld.Parent = v2
            end
        end

        local v11 = {}
        for i, j in Weapon:GetChildren() do
            if j:IsA("Model") then
                BasePart = j:FindFirstChildWhichIsA("BasePart", true)
                if not BasePart then
                    for k, n in j:GetAttributes() do
                        if string.sub(k, 1, 13) == "NodeOverride_" then
                            v4 = string.sub(k, 14)
                            v5 = string.split(tostring(n), ",")
                            if #v5 == 3 then
                                v8 = v5[1]
                                v6 = tonumber(v8) or 0
                                v9 = v5[2]
                                v7 = tonumber(v9) or 0
                                v10 = v5[3]
                                v9 = tonumber(v10)
                                v11[v4] = (Vector3.new(v6, v7, v9 or 0))
                            end
                        end
                    end
                elseif not BasePart:GetAttribute("OptionGroupHidden") then
                    for m, i5 in j:GetAttributes() do
                        if string.sub(m, 1, 13) == "NodeOverride_" then
                            v4 = string.sub(m, 14)
                            v5 = string.split(tostring(i5), ",")
                            if #v5 == 3 then
                                v8 = v5[1]
                                v6 = tonumber(v8) or 0
                                v9 = v5[2]
                                v7 = tonumber(v9) or 0
                                v10 = v5[3]
                                v9 = tonumber(v10)
                                v11[v4] = (Vector3.new(v6, v7, v9 or 0))
                            end
                        end
                    end
                end
            end
        end
        local v12 = u376
        local v13 = nil
        local v14 = nil
        for i6, i7 in v12, v13, v14 do
            v1 = BasePoints:FindFirstChild(i6)
            if v1 and v1:IsA("BasePart") then
                v2 = v11[i6]
                v3 = i7
                if v2 then
                    v3 = (CFrame.new(i7.Position + v2)) * i7.Rotation
                    print("[NodeOverride] Override for node:", i6, "offset:", v2)
                end
                moveBasePoint(v1, Handle.CFrame * v3)
                if v2 then
                    for i8, i9 in v1:GetJoints() do
                        if i9:IsA("JointInstance") then
                            if i9.Part0 == v1 then
                                Part1 = i9.Part1
                            elseif i9.Part1 ~= v1 then
                                Part1 = nil
                            else
                                Part1 = i9.Part0
                            end
                            if Part1 then
                                if not KeyParts or not Part1:IsDescendantOf(KeyParts) then
                                    v7 = Part1:FindFirstAncestorOfClass("Model")
                                    if v7 and v7.PrimaryPart then
                                        print("[NodeOverride] Re-welding attachment:", v7.Name, "to node:", i6)
                                        i9:Destroy()
                                        CFrame_2 = v1.CFrame
                                        v7:PivotTo(CFrame_2)
                                        Weld = Instance.new("Weld")
                                        Weld.Part0 = v7.PrimaryPart
                                        Weld.Part1 = v1
                                        Weld.Parent = v7
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return
    end
end

local function u379(p1, p2) -- Line: 1217
    -- upvalues: u202 (ref), u217 (val), u227 (ref), u213 (ref), u229 (ref), WepConfig (val), AttachmentSystem (val)
    -- upvalues: u218 (val), u149 (val)
    local Frame, Frame_2, NodeIDFromName, v1, v2, v3
    local v4 = u202
    u202 = p1
    local v5 = v4
    local v6 = nil
    local v7 = nil
    for i in v5, v6, v7 do
        if not p1[i] then
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
        if not v4[j] then
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
        v6 = deepCopy
        v7 = WepConfig
        local Name = v9.Name
        u229 = v6(v7:GetWeaponConfig(Name))
        v9.Attachments:ClearAllChildren()
        v6 = AttachmentSystem
        local DressWeapon = v6.DressWeapon
        local Name_2 = v9.Name
        v8 = u213
        local v10 = u229
        v7, v8 = (DressWeapon(Name_2, v8, v10.AttachmentNodeData, v9, function(...) -- Line: 1266 -- upvalues: u218 (upval)
            local v1 = u218
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                j(...)
            end
        end)):timeout(10):await()
        if not v7 then
            warn("[WeaponModding] DressWeapon timed out or failed (" .. "needsRedress" .. "):\n" .. tostring(v8))
        end
        v6 = u149
        v8 = u229
        v6:UpdateStats(v8)
        u149:UpdateDisplay()
    end
end

function u207(p1, p2, p3) -- Line: 1278
    -- upvalues: Template (val), u214 (val), SharedResources (val), Attachments (val), GuiTransparency (val), u212 (val)
    -- upvalues: ScrollingFrame (val), u215 (val), Attachments_2 (val), Scrollbar (val), ScrollBar (val), u216 (val)
    -- upvalues: Template_2 (val), clickEvent (val), u228 (ref), Sounds (val), u227 (ref), u203 (ref), u378 (ref)
    -- upvalues: u302 (val), u219 (ref), u379 (ref), RunService (val), CurrentCamera (val), drawLine (val), Nodes (val)
    local ImageLabel_2, LockedFrame, TextLine1, TextLine2, u86, v1, v2, v3
    local u6 = Template:Clone()
    local v4 = u214
    table.insert(v4, u6)
    u6.Name = p1
    u6.LayoutOrder = 1000
    local Frame = u6:WaitForChild("Frame")
    local TopLabel = Frame:WaitForChild("TopLabel")
    local BottomLabel = Frame:WaitForChild("BottomLabel")
    local ImageLabel = Frame:WaitForChild("ImageLabel")
    local Point = Frame:WaitForChild("Point")
    local name = nil
    local v5 = p2
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
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
        v5 = ""
    else
        v5 = string.upper(name)
    end
    BottomLabel.Text = v5
    ImageLabel.Image = ""

    local function findMemberModel(p1_2) -- Line: 1309 -- upvalues: p3 (val), p1 (val)
        local Weapon = p3:FindFirstChild("Weapon")
        if not Weapon then
            return nil
        end
        for i, j in Weapon:GetChildren() do
            if j:IsA("Model") and (j:GetAttribute("OptionGroup")) == p1 and j.Name == p1_2 then
                return j
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
    local v8 = GuiTransparency
    local v9 = u212
    v8:SetTransparency(u107, 1, v9)
    local u119 = ScrollingFrame:Clone()
    local v10 = u215
    table.insert(v10, u119)
    local NONE = u119:FindFirstChild("NONE")
    if NONE then
        NONE:Destroy()
    end
    u119.Parent = Attachments_2
    v10 = Scrollbar:Clone()
    local u142 = ScrollBar.new(v10, u119, "X")
    local v11 = u216
    table.insert(v11, u142)
    v10.Parent = Attachments_2
    local u148 = {}
    v11 = p2
    local v12 = nil
    local v13 = nil
    for k, n in v11, v12, v13 do
        v1 = Template_2:Clone()
        v1.LayoutOrder = k
        v1.Visible = true
        v1.Name = n.name
        local ImageButton = v1:WaitForChild("ImageButton")
        TextLine1 = ImageButton:WaitForChild("TextLine1")
        TextLine2 = ImageButton:WaitForChild("TextLine2")
        ImageLabel_2 = ImageButton:WaitForChild("ImageLabel")
        TextLine1.Text = ""
        TextLine2.Text = string.upper(n.name)
        ImageLabel_2.Visible = false
        LockedFrame = ImageButton:WaitForChild("LockedFrame")
        LockedFrame.Visible = false
        setSelectionFrameAppearance(ImageButton, "equip")
        v1.Parent = u119
        v2 = clickEvent(ImageButton)
        v3 = #u148 + 1
        u148[v3] = (v2:Connect(function() -- Line: 1376
            -- upvalues: u228 (upval), ImageButton (val), Sounds (upval), u227 (upval), u203 (upval), p3 (val), p1 (val)
            -- upvalues: n (val), u378 (upval), BottomLabel (val), u86 (ref), findMemberModel (val), u93 (val), p2 (val)
            -- upvalues: u302 (upval), u219 (upval), u379 (upval)
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
            ;(Sounds.Att:GetChildren())[math.random(1, 3)]:Play()
            local Weapon = p3:FindFirstChild("Weapon")
            if Weapon then
                local Attribute_2, Attribute_3, Enabled, Transparency
                for i, j in Weapon:GetChildren() do
                    if j:IsA("Model") and (j:GetAttribute("OptionGroup")) == p1 then
                        v2 = j.Name == n.name
                        for k, n2 in j:GetDescendants() do
                            if n2:IsA("BasePart") or n2:IsA("Decal") then
                                if v2 then
                                    n2:SetAttribute("OptionGroupHidden", nil)
                                    Attribute_3 = n2:GetAttribute("OrigTransparency")
                                    if Attribute_3 == nil then
                                        v1 = 0
                                    else
                                        v1 = Attribute_3
                                    end
                                    n2.Transparency = v1
                                elseif not n2:GetAttribute("OptionGroupHidden") then
                                    n2:SetAttribute("OptionGroupHidden", true)
                                    if n2:GetAttribute("OrigTransparency") == nil then
                                        Transparency = n2.Transparency
                                        n2:SetAttribute("OrigTransparency", Transparency)
                                    end
                                    n2.Transparency = 1
                                end
                            elseif not n2:IsA("Texture") then
                                if n2:IsA("Beam") or n2:IsA("ParticleEmitter") then
                                    if v2 then
                                        n2:SetAttribute("OptionGroupHidden", nil)
                                        Attribute_2 = n2:GetAttribute("OrigEnabled")
                                        if Attribute_2 == nil then
                                            v1 = true
                                        else
                                            v1 = Attribute_2
                                        end
                                        n2.Enabled = v1
                                    elseif not n2:GetAttribute("OptionGroupHidden") then
                                        n2:SetAttribute("OptionGroupHidden", true)
                                        Enabled = n2.Enabled
                                        n2:SetAttribute("OrigEnabled", Enabled)
                                        n2.Enabled = false
                                    end
                                end
                            elseif v2 then
                                n2:SetAttribute("OptionGroupHidden", nil)
                                Attribute_3 = n2:GetAttribute("OrigTransparency")
                                if Attribute_3 == nil then
                                    v1 = 0
                                else
                                    v1 = Attribute_3
                                end
                                n2.Transparency = v1
                            elseif not n2:GetAttribute("OptionGroupHidden") then
                                n2:SetAttribute("OptionGroupHidden", true)
                                if n2:GetAttribute("OrigTransparency") == nil then
                                    Transparency = n2.Transparency
                                    n2:SetAttribute("OrigTransparency", Transparency)
                                end
                                n2.Transparency = 1
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
            v3 = u302
            local OptionGroupChanged = v3.OptionGroupChanged
            v5 = p1
            local v6 = n
            local id = v6.id
            local v7 = n
            local name = v7.name
            OptionGroupChanged:Fire(v5, id, name)
            if u219 then
                local lockedNodes, members, v8, v9, v10
                v3 = {}
                v4 = u219
                v5 = nil
                v6 = nil
                for i6, i7 in v4, v5, v6 do
                    members = i7.members
                    v9 = nil
                    v10 = nil
                    for i8, i9 in members, v9, v10 do
                        if i9.isActive and i9.lockedNodes then
                            lockedNodes = i9.lockedNodes
                            v1 = nil
                            v8 = nil
                            for i10, i11 in lockedNodes, v1, v8 do
                                v3[i11] = true
                            end
                        end
                    end
                end
                u379(v3, p3)
            end
        end))
    end
    ;((u119:WaitForChild("UIListLayout")):GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function() -- Line: 1468 -- upvalues: u119 (val), Attachments (upval)
        local v1 = u119
        v1.CanvasSize = UDim2.new(0, u119.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01, 0, 0)
    end)
    local new = UDim2.new
    local v14 = u119.UIListLayout.AbsoluteContentSize.X - Attachments.AbsoluteSize.Y * 0.01
    u119.CanvasSize = new(0, v14, 0, 0)
    v12 = #u148 + 1
    v13 = RunService
    local RenderStepped = v13.RenderStepped
    u148[v12] = (RenderStepped:Connect(function() -- Line: 1475
        -- upvalues: u86 (ref), CurrentCamera (upval), u99 (ref), drawLine (upval), Point (val), Attachments (upval)
        -- upvalues: u107 (val), u102 (ref), GuiTransparency (upval), u302 (upval), u6 (val), u100 (ref), u101 (ref)
        -- upvalues: u212 (upval), u227 (upval), u93 (val)
        local v1, v2
        if not u86 then
            return
        end
        local BoundingBox = u86:GetBoundingBox()
        local Position = BoundingBox.Position
        local v3 = CurrentCamera:WorldToScreenPoint(Position)
        local v4 = drawLine
        local v5 = Point
        local AbsolutePosition = v5.AbsolutePosition
        local v6 = Vector2.new(v3.X, v3.Y)
        u99 = v4(AbsolutePosition, v6, Attachments, u99)
        u107.Position = UDim2.new(0, v3.X, 0, v3.Y)
        if not u102 then
            u102 = true
            v4 = GuiTransparency
            v6 = u99
            v2 = TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            v4:SetTransparency(v6, 1, v2)
            u99.BackgroundTransparency = 1
        end
        if u302.HoveringOver == u6 then
            if u100 and not u101 and u302.HoveringOver == u6 then
                u100 = false
                u101 = true
                v4 = GuiTransparency
                v6 = u107
                v1 = u212
                v4:Revert(v6, v1)
                v4 = GuiTransparency
                v6 = u99
                v1 = u212
                v4:Revert(v6, v1)
            end
        elseif not u100 then
            u100 = true
            u101 = false
            v4 = GuiTransparency
            v6 = u99
            v2 = u212
            v4:SetTransparency(v6, 1, v2)
            v4 = GuiTransparency
            v6 = u107
            v2 = u212
            v4:SetTransparency(v6, 1, v2)
        elseif u100 and not u101 and u302.HoveringOver == u6 then
            u100 = false
            u101 = true
            v4 = GuiTransparency
            v6 = u107
            v1 = u212
            v4:Revert(v6, v1)
            v4 = GuiTransparency
            v6 = u99
            v1 = u212
            v4:Revert(v6, v1)
        end
        if u227 ~= nil and u227 == u6 then
            u99.BackgroundTransparency = 1
        end
        if u302.HoveringOver == u6 then
            u93.Enabled = true
            return
        end
        u93.Enabled = false
    end))
    v12, v13, v14 = clickEvent(u6)
    local v15 = #u148 + 1
    u148[v15] = (v12:Connect(function() -- Line: 1517
        -- upvalues: Sounds (upval), u215 (upval), u216 (upval), u119 (val), u227 (upval), u6 (val), u142 (val)
        -- upvalues: p2 (val), u228 (upval), u302 (upval), u203 (upval)
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
        v1 = u119
        v2 = u227 ~= u6
        v1.Visible = v2
        v1 = u142
        v3 = u119
        local Visible = v3.Visible
        v1:SetVisible(Visible)
        if u119.Visible then
            local name, v4
            v1 = p2
            v2 = nil
            v3 = nil
            for m, i5 in v1, v2, v3 do
                if i5.isActive then
                    v4 = u119
                    name = i5.name
                    v4 = v4:FindFirstChild(name)
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
        v1 = setMode
        if not u119.Visible then
            v2 = "Nodes"
        else
            v2 = "Attachments"
        end
        v1(v2)
    end))
    v15 = #u148 + 1
    u148[v15] = (v13:Connect(function() -- Line: 1558 -- upvalues: u227 (upval), u302 (upval), u6 (val)
        if u227 then
            return
        end
        u302.HoveringOver = u6
    end))
    v15 = #u148 + 1
    u148[v15] = (v14:Connect(function() -- Line: 1562 -- upvalues: u227 (upval), u302 (upval), u6 (val)
        if u227 then
            return
        end
        if u302.HoveringOver == u6 then
            u302.HoveringOver = nil
        end
    end))
    u6.Parent = Nodes
    Nodes.CanvasSize = UDim2.new(0, 0, 0, Nodes.UIListLayout.AbsoluteContentSize.Y)
    v1 = #u148 + 1
    u148[v1] = (p3.Destroying:Connect(function() -- Line: 1573 -- upvalues: u6 (val), u119 (val), u99 (ref), u107 (val), u93 (val), u148 (val)
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
    end))
end

function removePreviewAttachments() -- Line: 1588 -- upvalues: u221 (ref)
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

function deepCopy(p1) -- Line: 1596
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        v1[k] = v
    end
    return v1
end

function wordsToSentence(p1) -- Line: 1607
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

function trim(p1) -- Line: 1618
    return ((p1:gsub("^%s+", "", 1)):gsub("%s+$", "", 1))
end

function updatePlayerData(p1) -- Line: 1623 -- upvalues: u200 (ref), u223 (val)
    u200 = p1
    local v1 = u223
    local v2 = nil
    local v3 = nil
    for i in v1, v2, v3 do
        i()
    end
end

function openPurchaseModPrompt(p1, p2, p3, p4) -- Line: 1630
    -- upvalues: u230 (ref), PurchaseMod (val), u200 (ref), u231 (ref)
    if u230 then
        closePurchaseModPrompt()
    end
    u230 = true
    PurchaseMod.NameLabel.Text = p3
    local v1 = PurchaseMod
    local BalanceLabel = v1.BalanceLabel
    local v2 = u200
    local ZBucks = v2.Progression.ZBucks
    BalanceLabel.Text = ("YOUR BALANCE: %d Z$"):format(ZBucks)
    PurchaseMod.InfoLabel.Text = ("UNLOCK FOR %d Z$"):format(p4)
    u231 = {WeaponID = p1, ModID = p2}
    PurchaseMod.Visible = true
end

local UnlockButton = PurchaseMod.UnlockButton
;(clickEvent(UnlockButton)):Connect(function() -- Line: 1649 -- upvalues: u231 (ref), ModificationEvent (val)
    if u231 and ModificationEvent then
        local v1 = ModificationEvent
        local v2 = {Type = "PurchaseMod", WeaponID = u231.WeaponID, ModID = u231.ModID}
        v1:FireServer(v2)
        closePurchaseModPrompt()
    end
end)

function closePurchaseModPrompt() -- Line: 1660 -- upvalues: u231 (ref), PurchaseMod (val), u230 (ref)
    u231 = nil
    PurchaseMod.Visible = false
    u230 = false
end

function deserializeUnlockedAttachments(p1) -- Line: 1666
    if p1 then
        return string.split(p1, ",")
    end
    return {}
end

local CancelButton = PurchaseMod.CancelButton
local v6 = clickEvent(CancelButton)
local v7 = closePurchaseModPrompt
v6:Connect(v7)
if ModificationEvent then
    ModificationEvent:SetClientListener(function(p1) -- Line: 1677 -- upvalues: u200 (ref), ItemData (val), u226 (ref), u222 (ref)
        if p1.Type and p1.Type == "ModUnlocked" then
            u200.Progression = p1.NewProgression
            updatePlayerData(u200)
            local v1 = ItemData
            local v2 = u226
            local ItemIdFromName = v1:GetItemIdFromName(v2)
            if p1.WeaponID == ItemIdFromName and u222[p1.ModID] then
                local v3 = u222[p1.ModID]
                v2 = nil
                local v4 = nil
                for i, j in v3, v2, v4 do
                    j()
                end
            end
        end
    end)
end
;((ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("Net")).OnClientEvent:Connect(function(p1, p2) -- Line: 1693 -- upvalues: u200 (ref)
    if p1 == "UpdateZBucks" and u200 and u200.Progression then
        u200.Progression.ZBucks = tonumber(p2) or 0
        updatePlayerData(u200)
    end
end)
return u302