local ReplicatedStorage = game:GetService("ReplicatedStorage")
;(ReplicatedStorage.common:WaitForChild("SharedResources")):WaitForChild("Attachments")
local common = ReplicatedStorage.common
local u17 = require("@self/PaletteSystem")
require("@self/AttachmentsRoot")
local WepConfig = require(common:WaitForChild("WepConfig"))
local Promise = require(common:WaitForChild("Promise"))
local u34 = os.clock()
local u35 = {}
local Folder = Instance.new("Folder")
local u39 = {}
local v1 = {
    DressWeapon = function(p1, p2, p3, p4, p5, p6) -- Line: 37 -- upvalues: u39 (val), u34 (ref)
        if p4 then
            local Attachments = p4:FindFirstChild("Attachments")
            if Attachments then
                Attachments:Destroy()
            end
            local GlobalParts = p4:FindFirstChild("GlobalParts")
            if GlobalParts then
                local CustomPoints = GlobalParts:FindFirstChild("CustomPoints")
                if CustomPoints then
                    CustomPoints:Destroy()
                end
            end
            local v1 = Instance.new("Folder", p4)
            v1.Name = "Attachments"
            local v2 = Instance.new("Folder", GlobalParts)
            v2.Name = "CustomPoints"
        end
        table.clear(u39)
        local v3 = os.clock()
        u34 = v3
        return processAttachmentQueue(p2:GetNodes(), p3, v3, p4, p5, p6)
    end,
}

function processAttachmentQueue(p1, p2, p3, p4, p5, p6) -- Line: 101 -- upvalues: Promise (val)
    local v1 = Promise
    return v1.new(function(p1_2, p2_2, p3_2) -- Line: 102 -- upvalues: p1 (val), p2 (val), p3 (val), p4 (val), p5 (val), p6 (val)
        local u27, v1, v2
        local u46 = {}
        local v3 = p1
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v2 = p2
            if v2 then
                v2 = p2[i]
            end
            if not v2 or not v2.RuntimeDisabled then
                v1 = {depth = 0, nodeID = i, nodeData = j}
                table.insert(u46, v1)
            end
        end
        local u14 = 0
        local u15 = 1
        local u16 = false
        local u17 = false
        local u18 = false
        p3_2(function() -- Line: 133 -- upvalues: u18 (ref)
            u18 = true
        end)

        local function tryResolve() -- Line: 137
            -- upvalues: u18 (ref), u16 (ref), u14 (ref), u15 (ref), u46 (val), p1_2 (val)
            if not u18 and u16 and u14 <= 0 then
                local v1 = u15
                if #u46 < v1 then
                    p1_2()
                end
            end
        end

        function u27() -- Line: 144
            -- upvalues: u17 (ref), u18 (ref), u15 (ref), u46 (val), p2 (upval), u14 (ref), p3 (upval), p4 (upval)
            -- upvalues: p5 (upval), p6 (upval), p2_2 (val), u16 (ref), p1_2 (val), u27 (ref)
            local AttachmentData, Name, nodeID, subNodePartsSnapshot, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
            if u17 then
                return
            end
            u17 = true
            while not u18 do
                if not (u15 <= #u46) then
                    break
                end
                local u8 = u46[u15]
                u15 = u15 + 1
                local ConnectedAttachment = u8.nodeData.ConnectedAttachment
                if ConnectedAttachment then
                    if not (50 < u8.depth) then
                        v4 = p2
                        if v4 then
                            v4 = p2[u8.nodeID]
                        end
                        if v4 then
                            AttachmentData = ConnectedAttachment:GetAttachmentData()
                            v6 = nil
                            if u8.subNodePartsSnapshot then
                                subNodePartsSnapshot = u8.subNodePartsSnapshot
                                v8 = nil
                                v9 = nil
                                for i, j in subNodePartsSnapshot, v8, v9 do
                                    if j.Name == v4.Name then
                                        v6 = j
                                        break
                                    end
                                end
                            end
                            u14 = u14 + 1
                            v7 = attachSingleNode
                            v10 = p2
                            v11 = p3
                            v1 = p4
                            Name = v4.Name
                            v2 = p5
                            v3 = p6
                            v7 = v7(ConnectedAttachment, AttachmentData, v10, v11, v1, Name, v6, v2, v3, function() -- Line: 224 -- upvalues: u18 (upval)
                                return u18
                            end)
                            v7 = v7:andThen(function(p1, p2) -- Line: 228 -- upvalues: p4 (upval), u18 (upval), ConnectedAttachment (val), u46 (upval), u8 (val)
                                local v1, v2
                                if not p4 then
                                    if not u18 then
                                        for i, j in ConnectedAttachment:GetNodes() do
                                            v1 = u46
                                            v2 = {
                                                nodeID = i,
                                                nodeData = j,
                                                subNodePartsSnapshot = p2,
                                                depth = u8.depth + 1,
                                            }
                                            table.insert(v1, v2)
                                        end
                                    end
                                elseif p1 and not u18 then
                                    for k, n in ConnectedAttachment:GetNodes() do
                                        v1 = u46
                                        v2 = {
                                            nodeID = k,
                                            nodeData = n,
                                            subNodePartsSnapshot = p2,
                                            depth = u8.depth + 1,
                                        }
                                        table.insert(v1, v2)
                                    end
                                end
                            end)
                            v7 = v7:catch(function(p1) -- Line: 243 -- upvalues: u18 (upval), p2_2 (upval)
                                u18 = true
                                p2_2(p1)
                            end)
                            v7:finally(function() -- Line: 247
                                -- upvalues: u14 (upval), u18 (upval), u16 (upval), u15 (upval), u46 (upval)
                                -- upvalues: p1_2 (upval), u27 (upval), p2_2 (upval)
                                u14 = u14 - 1
                                if not u18 and u16 and u14 <= 0 then
                                    local v1 = u15
                                    if #u46 < v1 then
                                        p1_2()
                                    end
                                end
                                if not u18 then
                                    local success, result = pcall(u27)
                                    if not success then
                                        u18 = true
                                        p2_2(result)
                                    end
                                end
                            end)
                        else
                            u8.nodeData.ConnectedAttachment = nil
                            v5 = warn
                            nodeID = u8.nodeID
                            v5("[AttachmentSystem] Node '" .. (tostring(nodeID)) .. "' no longer exists on this weapon -- unequipping its attachment.")
                        end
                    else
                        warn("[AttachmentSystem] Max attachment nesting depth (" .. 50 .. ") exceeded -- skipping further sub-attachments.")
                    end
                end
            end
            u17 = false
        end

        u27()
        u16 = true
        if not u18 and u16 and u14 <= 0 and #u46 < u15 then
            p1_2()
        end
    end)
end

function attachSingleNode(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 292
    -- upvalues: Promise (val), u34 (ref), u39 (val), WepConfig (val), u17 (val)
    local v1
    if not p2 then
        local v2 = Promise
        v2 = v2.resolve()
        return v2
    end
    local Attachments = p5
    if Attachments then
        Attachments = p5.Attachments
    end
    local v3, u22 = getAttachmentFolder(p2.Name):await()
    if p10 and p10() then
        v1 = Promise
        v1 = v1.resolve()
        return v1
    end
    if v3 then
        v1 = Promise
        v1 = v1.new(function(p1_2, p2_2, p3) -- Line: 300
            -- upvalues: p5 (val), u34 (upval), p4 (val), p9 (val), p10 (val), p2 (val), u22 (val), p7 (ref), p6 (val)
            -- upvalues: u39 (upval), p1 (val), WepConfig (upval), u17 (upval), Attachments (val), p8 (val)
            local AttachedAttachment_3, BasePoints_2, CustomPoints_4, GlobalParts_4, Name_4, WeaponConfig_2, u357, u368, v1, v2, v3, v4, v5, v6, v7, v8, v9
            if p5 and u34 ~= p4 and not p9 then
                p1_2()
                return
            end
            if p10 and p10() then
                p1_2()
                return
            end
            local v10 = nil
            if p5 then
                v4 = GetReplacementModel
                v5 = p5
                v4 = v4(v5)
                local Name = p2.Name
                v10 = v4:FindFirstChild(Name)
            end
            if not v10 and u22 and u22:FindFirstChildOfClass("Model") then
                v10 = u22:FindFirstChildOfClass("Model"):Clone()
            end
            v4 = nil
            v5 = nil
            if not p5 then
                if p5 then
                    p7 = p7 or nil
                    if not p7 then
                        GlobalParts_4 = p5:FindFirstChild("GlobalParts")
                        if GlobalParts_4 then
                            CustomPoints_4 = GlobalParts_4:FindFirstChild("CustomPoints")
                            v8 = CustomPoints_4
                            if v8 then
                                v2 = p6
                                v8 = CustomPoints_4:FindFirstChild(v2)
                            end
                            v7 = v8
                            if not p7 then
                                v8 = v7
                                if not v8 then
                                    v8 = p5
                                    BasePoints_2 = v8.GlobalParts.BasePoints
                                    v2 = p6
                                    v8 = BasePoints_2:FindFirstChild(v2)
                                end
                                p7 = v8
                            end
                        end
                    end
                    v6 = WepConfig
                    Name_4 = p5.Name
                    WeaponConfig_2 = v6:GetWeaponConfig(Name_4)
                    if p7 and WeaponConfig_2.AttachedAttachment then
                        u357 = {}
                        u357[1] = p5
                        u357[2] = p7.Name
                        u357[3] = p2.Name
                        AttachedAttachment_3 = WeaponConfig_2.AttachedAttachment
                        v2 = u357
                        AttachedAttachment_3(unpack(v2))
                        u368 = nil
                        v9 = Attachments
                        v9 = v9.Destroying:Connect(function() -- Line: 508 -- upvalues: u368 (ref), WeaponConfig_2 (val), u357 (ref)
                            local v1
                            u368:Disconnect()
                            u368 = nil
                            if not WeaponConfig_2.DetachedAttachment then
                                v1 = not WeaponConfig_2.DetachedAttachment and not WeaponConfig_2.DontRunDefaultDetachedAttachment
                            else
                                v1 = WeaponConfig_2
                                local DetachedAttachment_2 = v1.DetachedAttachment
                                local v2 = u357
                                v1 = DetachedAttachment_2(unpack(v2))
                                if not v1 then
                                    v1 = not WeaponConfig_2.DetachedAttachment and not WeaponConfig_2.DontRunDefaultDetachedAttachment
                                end
                            end
                            if v1 then
                                local v3 = DetachedAttachment
                                local v4 = u357
                                v3(unpack(v4))
                            end
                            u357 = nil
                        end)
                    end
                end
            elseif v10 then
                if not v10.PrimaryPart then
                    local AttachmentPoint = v10:FindFirstChild("AttachmentPoint")
                    if not AttachmentPoint then
                        AttachmentPoint = v10:FindFirstChildOfClass("BasePart")
                    end
                    v10.PrimaryPart = AttachmentPoint
                    warn("No existing PrimaryPart for " .. v10.Name)
                end
                p7 = p7 or nil
                if not p7 then
                    local GlobalParts = p5:FindFirstChild("GlobalParts")
                    if GlobalParts then
                        local CustomPoints = GlobalParts:FindFirstChild("CustomPoints")
                        v8 = CustomPoints
                        if v8 then
                            v2 = p6
                            v8 = CustomPoints:FindFirstChild(v2)
                        end
                        v7 = v8
                        if not p7 then
                            v8 = v7
                            if not v8 then
                                v8 = p5
                                local BasePoints = v8.GlobalParts.BasePoints
                                v2 = p6
                                v8 = BasePoints:FindFirstChild(v2)
                            end
                            p7 = v8
                        end
                    end
                end
                if not p7 then
                    warn("NO VALID NODEPART TO WELD TO.")
                else
                    local WeldConstraint, v11
                    v10 = v10:Clone()
                    local PrimaryPart = v10.PrimaryPart
                    for i, j in v10:GetDescendants() do
                        if j:IsA("BasePart") then
                            j.CastShadow = false
                            if j ~= PrimaryPart then
                                WeldConstraint = Instance.new("WeldConstraint")
                                WeldConstraint.Part0 = PrimaryPart
                                WeldConstraint.Part1 = j
                                WeldConstraint.Parent = j
                                j.Anchored = false
                            end
                        end
                    end
                    if p2.BaseModule then
                        v8 = getAttachmentFolder(p2.BaseModule):expect():FindFirstChildOfClass("Model"):Clone()
                        v10.Parent = v8
                        local Weld = Instance.new("Weld")
                        Weld.Part0 = v8.SwingingPart
                        Weld.Part1 = v10.PrimaryPart
                        Weld.Parent = v10
                        v10 = v8
                    end
                    u39[p1] = (script.Highlight:Clone())
                    u39[p1].Parent = v10
                    v9 = findScale
                    v2 = p7
                    v9 = v9(v2, v10.PrimaryPart)
                    v10:ScaleTo(v9)
                    local CFrame = p7.CFrame
                    v10:PivotTo(CFrame)
                    local Weld_2 = Instance.new("Weld")
                    Weld_2.Part0 = v10.PrimaryPart
                    Weld_2.Part1 = p7
                    Weld_2.Parent = v10
                    v8 = WepConfig
                    local Name_2 = p5.Name
                    if not v8:IsStock(Name_2) and u22.Parent.Name ~= "Charm" then
                        u17(p5, v10)
                    end
                    v10.Parent = Attachments
                    local u179 = {}
                    u179[1] = p5
                    u179[2] = p7.Name
                    u179[3] = p2.Name
                    u179[4] = v10
                    v9 = WepConfig
                    v3 = p5
                    local Name_3 = v3.Name
                    local WeaponConfig = v9:GetWeaponConfig(Name_3)
                    if not WeaponConfig.AttachedAttachment then
                        v2 = not WeaponConfig.AttachedAttachment and not WeaponConfig.DontRunDefaultAttachedAttachment
                    else
                        local AttachedAttachment_2 = WeaponConfig.AttachedAttachment
                        local v12 = u179
                        v2 = AttachedAttachment_2(unpack(v12))
                        if not v2 then
                            v2 = not WeaponConfig.AttachedAttachment and not WeaponConfig.DontRunDefaultAttachedAttachment
                        end
                    end
                    if v2 then
                        v3 = AttachedAttachment
                        v11 = u179
                        v3(unpack(v11))
                    end
                    if WeaponConfig.SkipAttachmentModel and WeaponConfig.SkipAttachmentModel[p6] then
                        for k, n in v10:GetDescendants() do
                            if n:IsA("BasePart") then
                                n.Transparency = 1
                            end
                        end
                    end
                    local CustomPoints_2 = v10:FindFirstChild("CustomPoints")
                    if CustomPoints_2 then
                        local GlobalParts_3 = p5:FindFirstChild("GlobalParts")
                        if GlobalParts_3 then
                            local CustomPoints_3 = GlobalParts_3:FindFirstChild("CustomPoints")
                            if CustomPoints_3 then
                                local Weld_3
                                for m, i5 in CustomPoints_2:GetChildren() do
                                    Weld_3 = Instance.new("Weld")
                                    Weld_3.Part0 = v10.PrimaryPart
                                    Weld_3.Part1 = i5
                                    Weld_3.C0 = (Weld_3.Part0.CFrame:Inverse()) * Weld_3.Part1.CFrame
                                    Weld_3.Parent = i5
                                    i5.Parent = CustomPoints_3
                                end
                            end
                        end
                    end
                    local u278 = nil
                    v11 = v10.Destroying:Connect(function() -- Line: 440 -- upvalues: u278 (ref), WeaponConfig (val), u179 (ref)
                        local v1
                        u278:Disconnect()
                        u278 = nil
                        if not WeaponConfig.DetachedAttachment then
                            v1 = not WeaponConfig.DetachedAttachment and not WeaponConfig.DontRunDefaultDetachedAttachment
                        else
                            v1 = WeaponConfig
                            local DetachedAttachment_2 = v1.DetachedAttachment
                            local v2 = u179
                            v1 = DetachedAttachment_2(unpack(v2))
                            if not v1 then
                                v1 = not WeaponConfig.DetachedAttachment and not WeaponConfig.DontRunDefaultDetachedAttachment
                            end
                        end
                        if v1 then
                            local v3 = DetachedAttachment
                            local v4 = u179
                            v3(unpack(v4))
                        end
                        u179 = nil
                    end)
                    v4 = v10
                    local NodeParts = v10:FindFirstChild("NodeParts")
                    local Children_4 = NodeParts
                    if Children_4 then
                        Children_4 = NodeParts:GetChildren()
                    end
                    v5 = Children_4
                end
            elseif p5 then
                p7 = p7 or nil
                if not p7 then
                    GlobalParts_4 = p5:FindFirstChild("GlobalParts")
                    if GlobalParts_4 then
                        CustomPoints_4 = GlobalParts_4:FindFirstChild("CustomPoints")
                        v8 = CustomPoints_4
                        if v8 then
                            v2 = p6
                            v8 = CustomPoints_4:FindFirstChild(v2)
                        end
                        v7 = v8
                        if not p7 then
                            v8 = v7
                            if not v8 then
                                v8 = p5
                                BasePoints_2 = v8.GlobalParts.BasePoints
                                v2 = p6
                                v8 = BasePoints_2:FindFirstChild(v2)
                            end
                            p7 = v8
                        end
                    end
                end
                v6 = WepConfig
                Name_4 = p5.Name
                WeaponConfig_2 = v6:GetWeaponConfig(Name_4)
                if p7 and WeaponConfig_2.AttachedAttachment then
                    u357 = {}
                    u357[1] = p5
                    u357[2] = p7.Name
                    u357[3] = p2.Name
                    AttachedAttachment_3 = WeaponConfig_2.AttachedAttachment
                    v2 = u357
                    AttachedAttachment_3(unpack(v2))
                    u368 = nil
                    v9 = Attachments
                    v9 = v9.Destroying:Connect(function() -- Line: 508 -- upvalues: u368 (ref), WeaponConfig_2 (val), u357 (ref)
                        local v1
                        u368:Disconnect()
                        u368 = nil
                        if not WeaponConfig_2.DetachedAttachment then
                            v1 = not WeaponConfig_2.DetachedAttachment and not WeaponConfig_2.DontRunDefaultDetachedAttachment
                        else
                            v1 = WeaponConfig_2
                            local DetachedAttachment_2 = v1.DetachedAttachment
                            local v2 = u357
                            v1 = DetachedAttachment_2(unpack(v2))
                            if not v1 then
                                v1 = not WeaponConfig_2.DetachedAttachment and not WeaponConfig_2.DontRunDefaultDetachedAttachment
                            end
                        end
                        if v1 then
                            local v3 = DetachedAttachment
                            local v4 = u357
                            v3(unpack(v4))
                        end
                        u357 = nil
                    end)
                end
            end
            v6 = nil
            if u22 then
                getAttachmentFolder(u22.Parent.Name .. "_Shared"):expect()
                v6 = u22:FindFirstChild("AttachmentModule")
                if not v6 then
                    v8 = getAttachmentFolder(u22.Parent.Name .. "_Shared"):expect()
                    local AttachmentModule = v8
                    if AttachmentModule then
                        AttachmentModule = v8:FindFirstChild("AttachmentModule")
                    end
                    v6 = AttachmentModule
                end
                if not v6 and p2.SharedModule then
                    v8 = getAttachmentFolder(p2.SharedModule):expect()
                    local AttachmentModule_2 = v8
                    if AttachmentModule_2 then
                        AttachmentModule_2 = v8:FindFirstChild("AttachmentModule")
                    end
                    v6 = AttachmentModule_2
                end
            end
            local u529 = nil
            if p8 then
                if not p5 then
                    v8 = v10
                else
                    v8 = v4
                end
                u529 = p8(p1, v8, v6, u39)
            end
            if not p5 or not v6 or not u529 or not u529.SettingChanges then
                v1 = p1_2
            else
                p5:WaitForChild("KeyParts", 5)
                local Barrel = p5.KeyParts:FindFirstChild("Barrel")
                if not Barrel or not u529.SettingChanges.BarrelAttachment then
                    v1 = p1_2
                else
                    v1 = p1_2
                    for i6, i7 in Barrel:GetChildren() do
                        if i7:IsA("Attachment") then
                            for i8, i9 in i7:GetChildren() do
                                i9.Parent = u529.SettingChanges.BarrelAttachment
                            end
                        else
                            i7.Parent = u529.SettingChanges.BarrelAttachment
                        end
                    end
                    local u498 = nil
                    v3 = v10.Destroying:connect(function() -- Line: 573 -- upvalues: u498 (ref), Barrel (val), u529 (ref)
                        local v1
                        u498:Disconnect()
                        u498 = nil
                        local Attachment = Barrel:FindFirstChildOfClass("Attachment")
                        for i, j in u529.SettingChanges.BarrelAttachment:GetChildren() do
                            v1 = Attachment
                            if not v1 then
                                v1 = Barrel
                            end
                            j.Parent = v1
                        end
                    end)
                end
            end
            v1(v4, v5)
        end)
        return v1
    end
    warn("Failed to get folder for", p2.Name)
    v1 = Promise
    v1 = v1.resolve()
    return v1
end

function GetReplacementModel(p1) -- Line: 592 -- upvalues: u35 (val), Folder (val)
    local AttReplaceModels = u35[p1]
    if not AttReplaceModels then
        AttReplaceModels = p1:FindFirstChild("AttReplaceModels")
        if not AttReplaceModels then
            AttReplaceModels = Folder
        end
    end
    if not u35[p1] then
        u35[p1] = AttReplaceModels
        if AttReplaceModels ~= Folder then
            p1.Destroying:Connect(function() -- Line: 597 -- upvalues: AttReplaceModels (val)
                AttReplaceModels:Destroy()
            end)
        end
        AttReplaceModels.Parent = nil
    end
    if not p1:FindFirstChild("Attachments") then
        local v1 = Instance.new("Folder", p1)
        v1.Name = "Attachments"
    end
    return AttReplaceModels
end

function AttachedAttachment(p1, p2, p3, p4, p5) -- Line: 610
    local Weapon = p1:FindFirstChild("Weapon")
    if Weapon then
        local AimPart, Aimpart, Attribute, Attribute_2, Attribute_3, Attribute_4, Attribute_5, CFrame_2, Enabled, Enabled_2, Highlight, KeyParts, Transparency, Transparency_2, Weld, v1, v2
        local v3 = p2 .. "_Hide"
        local v4 = Weapon:FindFirstChild(v3)
        local v5 = p2 .. "_Show"
        local v6 = Weapon:FindFirstChild(v5)
        v3 = pairs
        v5 = {v4, v6}
        local v7, v8, v9, v10 = p2, p3, p4, p1
        for k, v in v3(v5) do
            for k2, i in pairs(v:GetDescendants()) do
                if i:IsA("BasePart") or i:IsA("Texture") or i:IsA("Decal") then
                    if k ~= 1 then
                        v1 = 0
                    else
                        v1 = 1
                    end
                    i.Transparency = v1
                elseif i:IsA("Beam") or i:IsA("ParticleEmitter") or i:IsA("Trail") then
                    i.Enabled = false
                end
            end
        end
        for j, k3 in Weapon:GetChildren() do
            if k3:IsA("Model") then
                Attribute = k3:GetAttribute("VisibilityRule")
                Attribute_2 = k3:GetAttribute("VisibilityTarget")
                if Attribute and Attribute_2 and Attribute_2 == v7 then
                    if Attribute == "Hide" then
                        for i9, i10 in k3:GetDescendants() do
                            if i10:IsA("BasePart") or i10:IsA("Decal") or i10:IsA("Texture") then
                                if i10:GetAttribute("VisibilityOrigTransparency") == nil then
                                    Transparency = i10.Transparency
                                    i10:SetAttribute("VisibilityOrigTransparency", Transparency)
                                end
                                i10.Transparency = 1
                            elseif i10:IsA("Beam") or i10:IsA("ParticleEmitter") then
                                if i10:GetAttribute("VisibilityOrigEnabled") == nil then
                                    Enabled = i10.Enabled
                                    i10:SetAttribute("VisibilityOrigEnabled", Enabled)
                                end
                                i10.Enabled = false
                            end
                        end
                    elseif Attribute == "Show" then
                        for i7, i8 in k3:GetDescendants() do
                            if i8:IsA("BasePart") or i8:IsA("Decal") or i8:IsA("Texture") then
                                i8.Transparency = i8:GetAttribute("VisibilityOrigTransparency") or 0
                            elseif i8:IsA("Beam") or i8:IsA("ParticleEmitter") then
                                Attribute_3 = i8:GetAttribute("VisibilityOrigEnabled")
                                if Attribute_3 == nil then
                                    v2 = true
                                else
                                    v2 = Attribute_3
                                end
                                i8.Enabled = v2
                            end
                        end
                    elseif Attribute == "Replace" and k3:GetAttribute("ReplaceAttachment") == v8 then
                        if v9 and v9.PrimaryPart and k3.PrimaryPart then
                            Attribute_4 = k3:GetAttribute("_ReplaceOffset")
                            if not Attribute_4 then
                                Attribute_4 = CFrame.new()
                            end
                            k3.PrimaryPart.Anchored = false
                            Weld = Instance.new("Weld")
                            Weld.Name = "ReplaceNodeWeld"
                            Weld.Part0 = k3.PrimaryPart
                            Weld.Part1 = v9.PrimaryPart
                            Weld.C1 = Attribute_4
                            Weld.Parent = k3
                        end
                        if v9 then
                            for n, m in v9:GetDescendants() do
                                if m:IsA("BasePart") or m:IsA("Decal") or m:IsA("Texture") then
                                    Transparency_2 = m.Transparency
                                    m:SetAttribute("ReplacedTransparency", Transparency_2)
                                    m.Transparency = 1
                                elseif m:IsA("Beam") or m:IsA("ParticleEmitter") then
                                    Enabled_2 = m.Enabled
                                    m:SetAttribute("ReplacedEnabled", Enabled_2)
                                    m.Enabled = false
                                end
                            end
                        end
                        for i5, i6 in k3:GetDescendants() do
                            if i6:IsA("BasePart") or i6:IsA("Decal") or i6:IsA("Texture") then
                                i6.Transparency = i6:GetAttribute("VisibilityOrigTransparency") or 0
                            elseif i6:IsA("Beam") or i6:IsA("ParticleEmitter") then
                                Attribute_5 = i6:GetAttribute("VisibilityOrigEnabled")
                                if Attribute_5 == nil then
                                    v2 = true
                                else
                                    v2 = Attribute_5
                                end
                                i6.Enabled = v2
                            end
                        end
                        if v9 then
                            Highlight = v9:FindFirstChildWhichIsA("Highlight")
                            if Highlight then
                                Highlight.Adornee = k3
                            end
                        end
                        AimPart = k3:FindFirstChild("AimPart", true)
                        if AimPart and AimPart:IsA("BasePart") then
                            KeyParts = v10:FindFirstChild("KeyParts")
                            Aimpart = KeyParts
                            if Aimpart then
                                Aimpart = KeyParts:FindFirstChild("Aimpart")
                            end
                            if Aimpart then
                                CFrame_2 = Aimpart.CFrame
                                Aimpart:SetAttribute("OrigAimpartCFrame", CFrame_2)
                                Aimpart.CFrame = AimPart.CFrame
                            end
                        end
                    end
                end
            end
        end
    end
end

function DetachedAttachment(p1, p2, p3, p4, p5) -- Line: 713
    local Weapon = p1:FindFirstChild("Weapon")
    if Weapon then
        local Aimpart, Attribute, Attribute_2, Attribute_3, Attribute_4, Attribute_5, Attribute_6, Attribute_7, Highlight, KeyParts, ReplaceNodeWeld, v1
        local v2 = p2 .. "_Hide"
        local v3 = Weapon:FindFirstChild(v2)
        local v4 = p2 .. "_Show"
        local v5 = Weapon:FindFirstChild(v4)
        v2 = pairs
        v4 = {v3, v5}
        local v6, v7, v8, v9 = p2, p3, p4, p1
        for k, v in v2(v4) do
            for k2, i in pairs(v:GetDescendants()) do
                if i:IsA("BasePart") or i:IsA("Texture") or i:IsA("Decal") then
                    if k ~= 1 then
                        Attribute_7 = 1
                    else
                        Attribute_7 = i:GetAttribute("Transparency")
                        if not Attribute_7 then
                            Attribute_7 = 0
                        end
                    end
                    i.Transparency = Attribute_7
                end
            end
        end
        for j, k3 in Weapon:GetChildren() do
            if k3:IsA("Model") then
                Attribute = k3:GetAttribute("VisibilityRule")
                Attribute_2 = k3:GetAttribute("VisibilityTarget")
                if Attribute and Attribute_2 and Attribute_2 == v6 then
                    if Attribute == "Hide" then
                        for i9, i10 in k3:GetDescendants() do
                            if i10:IsA("BasePart") or i10:IsA("Decal") or i10:IsA("Texture") then
                                i10.Transparency = i10:GetAttribute("VisibilityOrigTransparency") or 0
                                i10:SetAttribute("VisibilityOrigTransparency", nil)
                            elseif i10:IsA("Beam") or i10:IsA("ParticleEmitter") then
                                Attribute_3 = i10:GetAttribute("VisibilityOrigEnabled")
                                if Attribute_3 == nil then
                                    v1 = true
                                else
                                    v1 = Attribute_3
                                end
                                i10.Enabled = v1
                                i10:SetAttribute("VisibilityOrigEnabled", nil)
                            end
                        end
                    elseif Attribute == "Show" then
                        for i7, i8 in k3:GetDescendants() do
                            if i8:IsA("BasePart") or i8:IsA("Decal") or i8:IsA("Texture") then
                                i8.Transparency = 1
                            elseif i8:IsA("Beam") or i8:IsA("ParticleEmitter") then
                                i8.Enabled = false
                            end
                        end
                    elseif Attribute == "Replace" and k3:GetAttribute("ReplaceAttachment") == v7 then
                        ReplaceNodeWeld = k3:FindFirstChild("ReplaceNodeWeld")
                        if ReplaceNodeWeld then
                            ReplaceNodeWeld:Destroy()
                        end
                        if k3.PrimaryPart then
                            k3.PrimaryPart.Anchored = true
                        end
                        if v8 then
                            Highlight = v8:FindFirstChildWhichIsA("Highlight")
                            if Highlight then
                                Highlight.Adornee = nil
                            end
                        end
                        for n, m in k3:GetDescendants() do
                            if m:IsA("BasePart") or m:IsA("Decal") or m:IsA("Texture") then
                                m.Transparency = 1
                            elseif m:IsA("Beam") or m:IsA("ParticleEmitter") then
                                m.Enabled = false
                            end
                        end
                        if v8 then
                            for i5, i6 in v8:GetDescendants() do
                                if i6:IsA("BasePart") or i6:IsA("Decal") or i6:IsA("Texture") then
                                    Attribute_5 = i6:GetAttribute("ReplacedTransparency")
                                    if Attribute_5 ~= nil then
                                        i6.Transparency = Attribute_5
                                        i6:SetAttribute("ReplacedTransparency", nil)
                                    end
                                elseif i6:IsA("Beam") or i6:IsA("ParticleEmitter") then
                                    Attribute_4 = i6:GetAttribute("ReplacedEnabled")
                                    if Attribute_4 ~= nil then
                                        i6.Enabled = Attribute_4
                                        i6:SetAttribute("ReplacedEnabled", nil)
                                    end
                                end
                            end
                        end
                        KeyParts = v9:FindFirstChild("KeyParts")
                        Aimpart = KeyParts
                        if Aimpart then
                            Aimpart = KeyParts:FindFirstChild("Aimpart")
                        end
                        if Aimpart then
                            Attribute_6 = Aimpart:GetAttribute("OrigAimpartCFrame")
                            if Attribute_6 then
                                Aimpart.CFrame = Attribute_6
                                Aimpart:SetAttribute("OrigAimpartCFrame", nil)
                            end
                        end
                    end
                end
            end
        end
    end
end

function getAttachmentFolder(p1) -- Line: 809 -- upvalues: Promise (val), WepConfig (val)
    local v1 = Promise
    return v1.new(function(p1_2, p2, p3) -- Line: 810 -- upvalues: WepConfig (upval), p1 (val)
        local v1 = WepConfig
        local v2 = p1
        p1_2(v1:GetAttachmentFolder(v2))
    end)
end

function findScale(p1, p2) -- Line: 815
    return p1.Size.Magnitude / p2.Size.Magnitude
end

function scaleModelWithJoints(p1, p2) -- Line: 821
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Size = v.Size * p2
            v7 = v.Position - p1:GetPrimaryPartCFrame().p
            v8 = v.CFrame - v.Position
            v.CFrame = CFrame.new(p1:GetPrimaryPartCFrame().p + v7 * p2) * v8
        elseif v:IsA("JointInstance") then
            v7 = v.C0.p * p2
            v8, v9, v1 = v.C0:ToEulerAnglesXYZ()
            v2 = v.C1.p * p2
            v3, v4, v5 = v.C1:ToEulerAnglesXYZ()
            v6 = CFrame.new(v7)
            v.C0 = v6 * CFrame.Angles(v8, v9, v1)
            v6 = CFrame.new(v2)
            v.C1 = v6 * CFrame.Angles(v3, v4, v5)
        end
    end
end

return v1