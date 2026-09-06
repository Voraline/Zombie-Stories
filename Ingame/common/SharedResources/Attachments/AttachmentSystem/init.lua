local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedResources = ReplicatedStorage.common:WaitForChild("SharedResources")
SharedResources:WaitForChild("Attachments")
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
        local Nodes = p2:GetNodes()
        return processAttachmentQueue(Nodes, p3, v3, p4, p5, p6)
    end,
}
function processAttachmentQueue(p1, p2, p3, p4, p5, p6) -- Line: 101 -- upvalues: Promise (val)
    return Promise.new(function(a1, a2, a3) -- Line: 102 -- upvalues: p1 (val), p2 (val), p3 (val), p4 (val), p5 (val), p6 (val)
        local u27
        local u3 = {}
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            table.insert(u3, {depth = 0, nodeID = i, nodeData = j})
        end
        local u14 = 0
        local u15 = 1
        local u16 = false
        local u17 = false
        local u18 = false
        a3(function() -- Line: 127 -- upvalues: u18 (ref)
            u18 = true
        end)
        local function tryResolve() -- Line: 131 -- upvalues: u18 (ref), u16 (ref), u14 (ref), u15 (ref), u3 (val), a1 (val)
            if not u18 and u16 and u14 <= 0 and #u3 < u15 then
                a1()
            end
        end
        function u27() -- Line: 138 -- upvalues: u17 (ref), u18 (ref), u15 (ref), u3 (val), p2 (upval), u14 (ref), p3 (upval), p4 (upval), p5 (upval), p6 (upval), a2 (val), u16 (ref), a1 (val), u27 (ref)
            local AttachmentData, subNodePartsSnapshot, v1, v2, v3, v4
            if u17 then
                return
            end
            u17 = true
            while not u18 do
                if u15 > #u3 then
                    break
                end
                local u8 = u3[u15]
                u15 = u15 + 1
                local ConnectedAttachment = u8.nodeData.ConnectedAttachment
                if ConnectedAttachment then
                    if 50 >= u8.depth then
                        AttachmentData = ConnectedAttachment:GetAttachmentData()
                        v1 = nil
                        if u8.subNodePartsSnapshot then
                            subNodePartsSnapshot = u8.subNodePartsSnapshot
                            v3 = nil
                            v4 = nil
                            for i, j in subNodePartsSnapshot, v3, v4 do
                                if j.Name == p2[u8.nodeID].Name then
                                    v1 = j
                                    break
                                end
                            end
                        end
                        u14 = u14 + 1
                        v2 = attachSingleNode(ConnectedAttachment, AttachmentData, p2, p3, p4, p2[u8.nodeID].Name, v1, p5, p6, function() -- Line: 207 -- upvalues: u18 (upval)
                            return u18
                        end)
                        v2 = v2:andThen(function(p1, p2) -- Line: 211 -- upvalues: p4 (upval), u18 (upval), ConnectedAttachment (val), u3 (upval), u8 (val)
                            if not p4 then
                                if not u18 then
                                    for i, j in ConnectedAttachment:GetNodes() do
                                        table.insert(u3, {nodeID = i, nodeData = j, subNodePartsSnapshot = p2, depth = u8.depth + 1})
                                    end
                                end
                            elseif not p1 then
                            end
                        end)
                        v2 = v2:catch(function(p1) -- Line: 226 -- upvalues: u18 (upval), a2 (upval)
                            u18 = true
                            a2(p1)
                        end)
                        v2:finally(function() -- Line: 230 -- upvalues: u14 (upval), u18 (upval), u16 (upval), u15 (upval), u3 (upval), a1 (upval), u27 (upval), a2 (upval)
                            u14 = u14 - 1
                            if not u18 and u16 and u14 <= 0 and #u3 < u15 then
                                a1()
                            end
                            if not u18 then
                                local v1, v2
                                v1, v2 = pcall(u27)
                                if not v1 then
                                    u18 = true
                                    a2(v2)
                                end
                            end
                        end)
                    else
                        warn("[AttachmentSystem] Max attachment nesting depth (" .. 50 .. ") exceeded -- skipping further sub-attachments.")
                    end
                end
            end
            u17 = false
        end
        u27()
        u16 = true
        if not u18 and u16 and u14 <= 0 and #u3 < u15 then
            a1()
        end
    end)
end
function attachSingleNode(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 275 -- upvalues: Promise (val), u34 (ref), u39 (val), WepConfig (val), u17 (val)
    local u22, v1
    if not p2 then
        return Promise.resolve()
    end
    local Attachments = p5
    if Attachments then
        Attachments = p5.Attachments
    end
    v1, u22 = getAttachmentFolder(p2.Name):await()
    if not p10 then
        if v1 then
            return Promise.new(function(a1, a2, p3) -- Line: 283 -- upvalues: p5 (val), u34 (upval), p4 (val), p9 (val), p10 (val), p2 (val), u22 (val), p7 (ref), p6 (val), u39 (upval), p1 (val), WepConfig (upval), u17 (upval), Attachments (val), p8 (val)
                if not p5 then
                    if not p10 then
                        local AttachedAttachment, Children, GlobalParts, Name, v1, v2
                        local v3 = if p5 then GetReplacementModel(p5):FindFirstChild(p2.Name) else nil
                        if not v3 and u22 and u22:FindFirstChildOfClass("Model") then
                            v3 = u22:FindFirstChildOfClass("Model"):Clone()
                        end
                        local v4 = nil
                        local v5 = nil
                        if not p5 then
                            if p5 then
                                p7 = p7 or nil
                                if not p7 then
                                    GlobalParts = "GlobalParts"
                                    local GlobalParts_4 = p5:FindFirstChild(GlobalParts)
                                    if GlobalParts_4 then
                                        local CustomPoints_4 = GlobalParts_4:FindFirstChild("CustomPoints")
                                        GlobalParts = CustomPoints_4
                                        if GlobalParts then
                                            GlobalParts = CustomPoints_4:FindFirstChild(p6)
                                        end
                                        v2 = GlobalParts
                                        GlobalParts = p7
                                        if not GlobalParts then
                                            GlobalParts = v2
                                            if not GlobalParts then
                                                GlobalParts = p5.GlobalParts.BasePoints:FindFirstChild(p6)
                                            end
                                            p7 = GlobalParts
                                        end
                                    end
                                end
                                GlobalParts = p5.Name
                                local WeaponConfig_2 = WepConfig:GetWeaponConfig(GlobalParts)
                                if p7 and WeaponConfig_2.AttachedAttachment then
                                    WeaponConfig_2.AttachedAttachment(unpack({p5, p7.Name, p2.Name}))
                                    GlobalParts = nil
                                end
                            end
                        elseif v3 then
                            local PrimaryPart, v6
                            if not v3.PrimaryPart then
                                local AttachmentPoint = v3:FindFirstChild("AttachmentPoint")
                                if not AttachmentPoint then
                                    AttachmentPoint = v3:FindFirstChildOfClass("BasePart")
                                end
                                v3.PrimaryPart = AttachmentPoint
                                warn("No existing PrimaryPart for " .. v3.Name)
                            end
                            p7 = p7 or nil
                            if not p7 then
                                local GlobalParts_2 = p5:FindFirstChild("GlobalParts")
                                if GlobalParts_2 then
                                    local CustomPoints = GlobalParts_2:FindFirstChild("CustomPoints")
                                    v6 = CustomPoints
                                    if v6 then
                                        v6 = CustomPoints:FindFirstChild(p6)
                                    end
                                    v2 = v6
                                    if not p7 then
                                        v6 = v2
                                        if not v6 then
                                            v6 = p5.GlobalParts.BasePoints:FindFirstChild(p6)
                                        end
                                        p7 = v6
                                    end
                                end
                            end
                            if not p7 then
                                warn("NO VALID NODEPART TO WELD TO.")
                            else
                                local WeldConstraint, v7
                                v3 = v3:Clone()
                                PrimaryPart = v3.PrimaryPart
                                for i, j in v3:GetDescendants() do
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
                                    v6 = getAttachmentFolder(p2.BaseModule):expect():FindFirstChildOfClass("Model"):Clone()
                                    v3.Parent = v6
                                    local Weld = Instance.new("Weld")
                                    Weld.Part0 = v6.SwingingPart
                                    Weld.Part1 = v3.PrimaryPart
                                    Weld.Parent = v3
                                    v3 = v6
                                end
                                u39[p1] = script.Highlight:Clone()
                                u39[p1].Parent = v3
                                v3:ScaleTo(findScale(p7, v3.PrimaryPart))
                                v3:PivotTo(p7.CFrame)
                                local Weld_2 = Instance.new("Weld")
                                Weld_2.Part0 = v3.PrimaryPart
                                Weld_2.Part1 = p7
                                Weld_2.Parent = v3
                                local Name_2 = p5.Name
                                if not (WepConfig:IsStock(Name_2)) and u22.Parent.Name ~= "Charm" then
                                    u17(p5, v3)
                                end
                                v3.Parent = Attachments
                                GlobalParts = {p5, p7.Name, p2.Name, v3}
                                local WeaponConfig = WepConfig:GetWeaponConfig(p5.Name)
                                if not WeaponConfig.AttachedAttachment then
                                    v7 = not WeaponConfig.AttachedAttachment
                                    if v7 then
                                        v7 = not WeaponConfig.DontRunDefaultAttachedAttachment
                                    end
                                else
                                    v7 = WeaponConfig.AttachedAttachment(unpack(GlobalParts))
                                end
                                if v7 then
                                    AttachedAttachment(unpack(GlobalParts))
                                end
                                if WeaponConfig.SkipAttachmentModel and WeaponConfig.SkipAttachmentModel[p6] then
                                    for k, n in v3:GetDescendants() do
                                        if n:IsA("BasePart") then
                                            n.Transparency = 1
                                        end
                                    end
                                end
                                local CustomPoints_2 = v3:FindFirstChild("CustomPoints")
                                if CustomPoints_2 then
                                    local GlobalParts_3 = p5:FindFirstChild("GlobalParts")
                                    if GlobalParts_3 then
                                        local CustomPoints_3 = GlobalParts_3:FindFirstChild("CustomPoints")
                                        if CustomPoints_3 then
                                            local Weld_3, v8
                                            for m, i5 in CustomPoints_2:GetChildren() do
                                                Weld_3 = Instance.new("Weld")
                                                Weld_3.Part0 = v3.PrimaryPart
                                                Weld_3.Part1 = i5
                                                v8 = Weld_3.Part0.CFrame:Inverse()
                                                Weld_3.C0 = v8 * Weld_3.Part1.CFrame
                                                Weld_3.Parent = i5
                                                i5.Parent = CustomPoints_3
                                            end
                                        end
                                    end
                                end
                                Children = nil
                                v4 = v3
                                local NodeParts = v3:FindFirstChild("NodeParts")
                                local Children_5 = NodeParts
                                if Children_5 then
                                    Children_5 = NodeParts:GetChildren()
                                end
                                v5 = Children_5
                            end
                        end
                        local v9 = nil
                        local u357 = u22
                        if u357 then
                            u357 = getAttachmentFolder(u22.Parent.Name .. "_Shared")
                            u357:expect()
                            GlobalParts = u22:FindFirstChild("AttachmentModule")
                            v9 = GlobalParts
                            if not v9 then
                                GlobalParts = getAttachmentFolder(u22.Parent.Name .. "_Shared")
                                GlobalParts = GlobalParts:expect()
                                local AttachmentModule = GlobalParts
                                if AttachmentModule then
                                    AttachmentModule = GlobalParts:FindFirstChild("AttachmentModule")
                                end
                                v9 = AttachmentModule
                            end
                            if not v9 then
                                GlobalParts = p2.SharedModule
                                if GlobalParts then
                                    GlobalParts = getAttachmentFolder(p2.SharedModule)
                                    GlobalParts = GlobalParts:expect()
                                    local AttachmentModule_2 = GlobalParts
                                    if AttachmentModule_2 then
                                        AttachmentModule_2 = GlobalParts:FindFirstChild("AttachmentModule")
                                    end
                                    v9 = AttachmentModule_2
                                end
                            end
                        end
                        u357 = nil
                        GlobalParts = p8
                        if GlobalParts then
                            if not p5 then
                                GlobalParts = v3
                            else
                                GlobalParts = v4
                            end
                            u357 = p8(p1, GlobalParts, v9, u39)
                        end
                        GlobalParts = p5
                        if not GlobalParts then
                            v1 = a1
                        elseif not v9 then
                            v1 = a1
                        elseif not u357 then
                            v1 = a1
                        else
                            GlobalParts = u357.SettingChanges
                            if not GlobalParts then
                                v1 = a1
                            else
                                p5:WaitForChild("KeyParts", 5)
                                local Barrel = p5.KeyParts:FindFirstChild("Barrel")
                                if not Barrel then
                                    v1 = a1
                                elseif not u357.SettingChanges.BarrelAttachment then
                                    v1 = a1
                                else
                                    local Children_6, Children_7
                                    Children_6, Children_7, Children = Barrel:GetChildren()
                                    v1 = a1
                                    for i6, i7 in Barrel:GetChildren() do
                                        if i7:IsA("Attachment") then
                                            for i8, i9 in i7:GetChildren() do
                                                i9.Parent = u357.SettingChanges.BarrelAttachment
                                            end
                                        else
                                            i7.Parent = u357.SettingChanges.BarrelAttachment
                                        end
                                    end
                                    local u498 = nil
                                end
                            end
                        end
                        v1(v4, v5)
                        return
                    elseif p10() then
                        a1()
                        return
                    end
                elseif u34 ~= p4 and not p9 then
                    a1()
                    return
                end
            end)
        end
        warn("Failed to get folder for", p2.Name)
        return Promise.resolve()
    end
    if p10() then
        return Promise.resolve()
    end
    if v1 then
        return Promise.new(function(a1, a2, p3) -- Line: 283 -- upvalues: p5 (val), u34 (upval), p4 (val), p9 (val), p10 (val), p2 (val), u22 (val), p7 (ref), p6 (val), u39 (upval), p1 (val), WepConfig (upval), u17 (upval), Attachments (val), p8 (val)
            if not p5 then
                if not p10 then
                    local AttachedAttachment, Children, GlobalParts, Name, v1, v2
                    local v3 = if p5 then GetReplacementModel(p5):FindFirstChild(p2.Name) else nil
                    if not v3 and u22 and u22:FindFirstChildOfClass("Model") then
                        v3 = u22:FindFirstChildOfClass("Model"):Clone()
                    end
                    local v4 = nil
                    local v5 = nil
                    if not p5 then
                        if p5 then
                            p7 = p7 or nil
                            if not p7 then
                                GlobalParts = "GlobalParts"
                                local GlobalParts_4 = p5:FindFirstChild(GlobalParts)
                                if GlobalParts_4 then
                                    local CustomPoints_4 = GlobalParts_4:FindFirstChild("CustomPoints")
                                    GlobalParts = CustomPoints_4
                                    if GlobalParts then
                                        GlobalParts = CustomPoints_4:FindFirstChild(p6)
                                    end
                                    v2 = GlobalParts
                                    GlobalParts = p7
                                    if not GlobalParts then
                                        GlobalParts = v2
                                        if not GlobalParts then
                                            GlobalParts = p5.GlobalParts.BasePoints:FindFirstChild(p6)
                                        end
                                        p7 = GlobalParts
                                    end
                                end
                            end
                            GlobalParts = p5.Name
                            local WeaponConfig_2 = WepConfig:GetWeaponConfig(GlobalParts)
                            if p7 and WeaponConfig_2.AttachedAttachment then
                                WeaponConfig_2.AttachedAttachment(unpack({p5, p7.Name, p2.Name}))
                                GlobalParts = nil
                            end
                        end
                    elseif v3 then
                        local PrimaryPart, v6
                        if not v3.PrimaryPart then
                            local AttachmentPoint = v3:FindFirstChild("AttachmentPoint")
                            if not AttachmentPoint then
                                AttachmentPoint = v3:FindFirstChildOfClass("BasePart")
                            end
                            v3.PrimaryPart = AttachmentPoint
                            warn("No existing PrimaryPart for " .. v3.Name)
                        end
                        p7 = p7 or nil
                        if not p7 then
                            local GlobalParts_2 = p5:FindFirstChild("GlobalParts")
                            if GlobalParts_2 then
                                local CustomPoints = GlobalParts_2:FindFirstChild("CustomPoints")
                                v6 = CustomPoints
                                if v6 then
                                    v6 = CustomPoints:FindFirstChild(p6)
                                end
                                v2 = v6
                                if not p7 then
                                    v6 = v2
                                    if not v6 then
                                        v6 = p5.GlobalParts.BasePoints:FindFirstChild(p6)
                                    end
                                    p7 = v6
                                end
                            end
                        end
                        if not p7 then
                            warn("NO VALID NODEPART TO WELD TO.")
                        else
                            local WeldConstraint, v7
                            v3 = v3:Clone()
                            PrimaryPart = v3.PrimaryPart
                            for i, j in v3:GetDescendants() do
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
                                v6 = getAttachmentFolder(p2.BaseModule):expect():FindFirstChildOfClass("Model"):Clone()
                                v3.Parent = v6
                                local Weld = Instance.new("Weld")
                                Weld.Part0 = v6.SwingingPart
                                Weld.Part1 = v3.PrimaryPart
                                Weld.Parent = v3
                                v3 = v6
                            end
                            u39[p1] = script.Highlight:Clone()
                            u39[p1].Parent = v3
                            v3:ScaleTo(findScale(p7, v3.PrimaryPart))
                            v3:PivotTo(p7.CFrame)
                            local Weld_2 = Instance.new("Weld")
                            Weld_2.Part0 = v3.PrimaryPart
                            Weld_2.Part1 = p7
                            Weld_2.Parent = v3
                            local Name_2 = p5.Name
                            if not (WepConfig:IsStock(Name_2)) and u22.Parent.Name ~= "Charm" then
                                u17(p5, v3)
                            end
                            v3.Parent = Attachments
                            GlobalParts = {p5, p7.Name, p2.Name, v3}
                            local WeaponConfig = WepConfig:GetWeaponConfig(p5.Name)
                            if not WeaponConfig.AttachedAttachment then
                                v7 = not WeaponConfig.AttachedAttachment
                                if v7 then
                                    v7 = not WeaponConfig.DontRunDefaultAttachedAttachment
                                end
                            else
                                v7 = WeaponConfig.AttachedAttachment(unpack(GlobalParts))
                            end
                            if v7 then
                                AttachedAttachment(unpack(GlobalParts))
                            end
                            if WeaponConfig.SkipAttachmentModel and WeaponConfig.SkipAttachmentModel[p6] then
                                for k, n in v3:GetDescendants() do
                                    if n:IsA("BasePart") then
                                        n.Transparency = 1
                                    end
                                end
                            end
                            local CustomPoints_2 = v3:FindFirstChild("CustomPoints")
                            if CustomPoints_2 then
                                local GlobalParts_3 = p5:FindFirstChild("GlobalParts")
                                if GlobalParts_3 then
                                    local CustomPoints_3 = GlobalParts_3:FindFirstChild("CustomPoints")
                                    if CustomPoints_3 then
                                        local Weld_3, v8
                                        for m, i5 in CustomPoints_2:GetChildren() do
                                            Weld_3 = Instance.new("Weld")
                                            Weld_3.Part0 = v3.PrimaryPart
                                            Weld_3.Part1 = i5
                                            v8 = Weld_3.Part0.CFrame:Inverse()
                                            Weld_3.C0 = v8 * Weld_3.Part1.CFrame
                                            Weld_3.Parent = i5
                                            i5.Parent = CustomPoints_3
                                        end
                                    end
                                end
                            end
                            Children = nil
                            v4 = v3
                            local NodeParts = v3:FindFirstChild("NodeParts")
                            local Children_5 = NodeParts
                            if Children_5 then
                                Children_5 = NodeParts:GetChildren()
                            end
                            v5 = Children_5
                        end
                    end
                    local v9 = nil
                    local u357 = u22
                    if u357 then
                        u357 = getAttachmentFolder(u22.Parent.Name .. "_Shared")
                        u357:expect()
                        GlobalParts = u22:FindFirstChild("AttachmentModule")
                        v9 = GlobalParts
                        if not v9 then
                            GlobalParts = getAttachmentFolder(u22.Parent.Name .. "_Shared")
                            GlobalParts = GlobalParts:expect()
                            local AttachmentModule = GlobalParts
                            if AttachmentModule then
                                AttachmentModule = GlobalParts:FindFirstChild("AttachmentModule")
                            end
                            v9 = AttachmentModule
                        end
                        if not v9 then
                            GlobalParts = p2.SharedModule
                            if GlobalParts then
                                GlobalParts = getAttachmentFolder(p2.SharedModule)
                                GlobalParts = GlobalParts:expect()
                                local AttachmentModule_2 = GlobalParts
                                if AttachmentModule_2 then
                                    AttachmentModule_2 = GlobalParts:FindFirstChild("AttachmentModule")
                                end
                                v9 = AttachmentModule_2
                            end
                        end
                    end
                    u357 = nil
                    GlobalParts = p8
                    if GlobalParts then
                        if not p5 then
                            GlobalParts = v3
                        else
                            GlobalParts = v4
                        end
                        u357 = p8(p1, GlobalParts, v9, u39)
                    end
                    GlobalParts = p5
                    if not GlobalParts then
                        v1 = a1
                    elseif not v9 then
                        v1 = a1
                    elseif not u357 then
                        v1 = a1
                    else
                        GlobalParts = u357.SettingChanges
                        if not GlobalParts then
                            v1 = a1
                        else
                            p5:WaitForChild("KeyParts", 5)
                            local Barrel = p5.KeyParts:FindFirstChild("Barrel")
                            if not Barrel then
                                v1 = a1
                            elseif not u357.SettingChanges.BarrelAttachment then
                                v1 = a1
                            else
                                local Children_6, Children_7
                                Children_6, Children_7, Children = Barrel:GetChildren()
                                v1 = a1
                                for i6, i7 in Barrel:GetChildren() do
                                    if i7:IsA("Attachment") then
                                        for i8, i9 in i7:GetChildren() do
                                            i9.Parent = u357.SettingChanges.BarrelAttachment
                                        end
                                    else
                                        i7.Parent = u357.SettingChanges.BarrelAttachment
                                    end
                                end
                                local u498 = nil
                            end
                        end
                    end
                    v1(v4, v5)
                    return
                elseif p10() then
                    a1()
                    return
                end
            elseif u34 ~= p4 and not p9 then
                a1()
                return
            end
        end)
    end
    warn("Failed to get folder for", p2.Name)
    return Promise.resolve()
end
function GetReplacementModel(p1) -- Line: 575 -- upvalues: u35 (val), Folder (val)
    local AttReplaceModels = u35[p1]
    if not AttReplaceModels then
        AttReplaceModels = p1:FindFirstChild("AttReplaceModels")
        if not AttReplaceModels then
            AttReplaceModels = Folder
        end
    end
    if not (u35[p1]) then
        u35[p1] = AttReplaceModels
        if AttReplaceModels ~= Folder then
            p1.Destroying:Connect(function() -- Line: 580 -- upvalues: AttReplaceModels (val)
                AttReplaceModels:Destroy()
            end)
        end
        AttReplaceModels.Parent = nil
    end
    if not (p1:FindFirstChild("Attachments")) then
        local v1 = Instance.new("Folder", p1)
        v1.Name = "Attachments"
    end
    return AttReplaceModels
end
function AttachedAttachment(p1, p2, p3, p4, p5) -- Line: 593
    local Weapon = p1:FindFirstChild("Weapon")
    if Weapon then
        local AimPart, Aimpart, Attribute, Attribute_2, Attribute_3, Attribute_4, Attribute_5, Highlight, KeyParts, Weld, v1, v2, v3, v4, v5, v6
        local v7 = Weapon:FindFirstChild(p2 .. "_Hide")
        local v8 = Weapon:FindFirstChild(p2 .. "_Show")
        local v9 = {v7, v8}
        v2, v4, v6, v1 = p2, p3, p4, p1
        for k, v in pairs(v9) do
            for k2, i in pairs(v:GetDescendants()) do
                if i:IsA("BasePart") then
                    if k ~= 1 then
                        v3 = 0
                    else
                        v3 = 1
                    end
                    i.Transparency = v3
                elseif not (i:IsA("Texture")) and not (i:IsA("Decal")) then
                    if i:IsA("Beam") then
                        i.Enabled = false
                    elseif not (i:IsA("ParticleEmitter")) and not (i:IsA("Trail")) then
                    end
                end
            end
        end
        for j, k3 in Weapon:GetChildren() do
            if k3:IsA("Model") then
                Attribute = k3:GetAttribute("VisibilityRule")
                Attribute_2 = k3:GetAttribute("VisibilityTarget")
                if Attribute and Attribute_2 and Attribute_2 == v2 then
                    if Attribute == "Hide" then
                        for i9, i10 in k3:GetDescendants() do
                            if i10:IsA("BasePart") then
                                if i10:GetAttribute("VisibilityOrigTransparency") == nil then
                                    i10:SetAttribute("VisibilityOrigTransparency", i10.Transparency)
                                end
                                i10.Transparency = 1
                            elseif not (i10:IsA("Decal")) and not (i10:IsA("Texture")) then
                                if i10:IsA("Beam") then
                                    if i10:GetAttribute("VisibilityOrigEnabled") == nil then
                                        i10:SetAttribute("VisibilityOrigEnabled", i10.Enabled)
                                    end
                                    i10.Enabled = false
                                elseif not (i10:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                    elseif Attribute == "Show" then
                        for i7, i8 in k3:GetDescendants() do
                            if i8:IsA("BasePart") then
                                i8.Transparency = i8:GetAttribute("VisibilityOrigTransparency") or 0
                            elseif not (i8:IsA("Decal")) and not (i8:IsA("Texture")) then
                                if i8:IsA("Beam") then
                                    Attribute_3 = i8:GetAttribute("VisibilityOrigEnabled")
                                    if Attribute_3 == nil then
                                        v5 = true
                                    else
                                        v5 = Attribute_3
                                    end
                                    i8.Enabled = v5
                                elseif not (i8:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                    elseif Attribute == "Replace" and k3:GetAttribute("ReplaceAttachment") == v4 then
                        if v6 and v6.PrimaryPart and k3.PrimaryPart then
                            Attribute_4 = k3:GetAttribute("_ReplaceOffset")
                            if not Attribute_4 then
                                Attribute_4 = CFrame.new()
                            end
                            k3.PrimaryPart.Anchored = false
                            Weld = Instance.new("Weld")
                            Weld.Name = "ReplaceNodeWeld"
                            Weld.Part0 = k3.PrimaryPart
                            Weld.Part1 = v6.PrimaryPart
                            Weld.C1 = Attribute_4
                            Weld.Parent = k3
                        end
                        if v6 then
                            for n, m in v6:GetDescendants() do
                                if m:IsA("BasePart") then
                                    m:SetAttribute("ReplacedTransparency", m.Transparency)
                                    m.Transparency = 1
                                elseif not (m:IsA("Decal")) and not (m:IsA("Texture")) then
                                    if m:IsA("Beam") then
                                        m:SetAttribute("ReplacedEnabled", m.Enabled)
                                        m.Enabled = false
                                    elseif not (m:IsA("ParticleEmitter")) then
                                    end
                                end
                            end
                        end
                        for i5, i6 in k3:GetDescendants() do
                            if i6:IsA("BasePart") then
                                i6.Transparency = i6:GetAttribute("VisibilityOrigTransparency") or 0
                            elseif not (i6:IsA("Decal")) and not (i6:IsA("Texture")) then
                                if i6:IsA("Beam") then
                                    Attribute_5 = i6:GetAttribute("VisibilityOrigEnabled")
                                    if Attribute_5 == nil then
                                        v5 = true
                                    else
                                        v5 = Attribute_5
                                    end
                                    i6.Enabled = v5
                                elseif not (i6:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                        if v6 then
                            Highlight = v6:FindFirstChildWhichIsA("Highlight")
                            if Highlight then
                                Highlight.Adornee = k3
                            end
                        end
                        AimPart = k3:FindFirstChild("AimPart", true)
                        if AimPart and AimPart:IsA("BasePart") then
                            KeyParts = v1:FindFirstChild("KeyParts")
                            Aimpart = KeyParts
                            if Aimpart then
                                Aimpart = KeyParts:FindFirstChild("Aimpart")
                            end
                            if Aimpart then
                                Aimpart:SetAttribute("OrigAimpartCFrame", Aimpart.CFrame)
                                Aimpart.CFrame = AimPart.CFrame
                            end
                        end
                    end
                end
            end
        end
    end
end
function DetachedAttachment(p1, p2, p3, p4, p5) -- Line: 696
    local Weapon = p1:FindFirstChild("Weapon")
    if Weapon then
        local Aimpart, Attribute, Attribute_2, Attribute_3, Attribute_4, Attribute_5, Attribute_6, Attribute_7, Highlight, KeyParts, ReplaceNodeWeld, v1, v2, v3, v4, v5
        local v6 = Weapon:FindFirstChild(p2 .. "_Hide")
        local v7 = Weapon:FindFirstChild(p2 .. "_Show")
        local v8 = {v6, v7}
        v2, v3, v5, v1 = p2, p3, p4, p1
        for k, v in pairs(v8) do
            for k2, i in pairs(v:GetDescendants()) do
                if i:IsA("BasePart") then
                    if k ~= 1 then
                        Attribute_7 = 1
                    else
                        Attribute_7 = i:GetAttribute("Transparency")
                        if not Attribute_7 then
                            Attribute_7 = 0
                        end
                    end
                    i.Transparency = Attribute_7
                elseif not (i:IsA("Texture")) and not (i:IsA("Decal")) then
                end
            end
        end
        for j, k3 in Weapon:GetChildren() do
            if k3:IsA("Model") then
                Attribute = k3:GetAttribute("VisibilityRule")
                Attribute_2 = k3:GetAttribute("VisibilityTarget")
                if Attribute and Attribute_2 and Attribute_2 == v2 then
                    if Attribute == "Hide" then
                        for i9, i10 in k3:GetDescendants() do
                            if i10:IsA("BasePart") then
                                i10.Transparency = i10:GetAttribute("VisibilityOrigTransparency") or 0
                                i10:SetAttribute("VisibilityOrigTransparency", nil)
                            elseif not (i10:IsA("Decal")) and not (i10:IsA("Texture")) then
                                if i10:IsA("Beam") then
                                    Attribute_3 = i10:GetAttribute("VisibilityOrigEnabled")
                                    if Attribute_3 == nil then
                                        v4 = true
                                    else
                                        v4 = Attribute_3
                                    end
                                    i10.Enabled = v4
                                    i10:SetAttribute("VisibilityOrigEnabled", nil)
                                elseif not (i10:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                    elseif Attribute == "Show" then
                        for i7, i8 in k3:GetDescendants() do
                            if i8:IsA("BasePart") then
                                i8.Transparency = 1
                            elseif not (i8:IsA("Decal")) and not (i8:IsA("Texture")) then
                                if i8:IsA("Beam") then
                                    i8.Enabled = false
                                elseif not (i8:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                    elseif Attribute == "Replace" and k3:GetAttribute("ReplaceAttachment") == v3 then
                        ReplaceNodeWeld = k3:FindFirstChild("ReplaceNodeWeld")
                        if ReplaceNodeWeld then
                            ReplaceNodeWeld:Destroy()
                        end
                        if k3.PrimaryPart then
                            k3.PrimaryPart.Anchored = true
                        end
                        if v5 then
                            Highlight = v5:FindFirstChildWhichIsA("Highlight")
                            if Highlight then
                                Highlight.Adornee = nil
                            end
                        end
                        for n, m in k3:GetDescendants() do
                            if m:IsA("BasePart") then
                                m.Transparency = 1
                            elseif not (m:IsA("Decal")) and not (m:IsA("Texture")) then
                                if m:IsA("Beam") then
                                    m.Enabled = false
                                elseif not (m:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                        if v5 then
                            for i5, i6 in v5:GetDescendants() do
                                if i6:IsA("BasePart") then
                                    Attribute_5 = i6:GetAttribute("ReplacedTransparency")
                                    if Attribute_5 ~= nil then
                                        i6.Transparency = Attribute_5
                                        i6:SetAttribute("ReplacedTransparency", nil)
                                    end
                                elseif not (i6:IsA("Decal")) and not (i6:IsA("Texture")) then
                                    if i6:IsA("Beam") then
                                        Attribute_4 = i6:GetAttribute("ReplacedEnabled")
                                        if Attribute_4 ~= nil then
                                            i6.Enabled = Attribute_4
                                            i6:SetAttribute("ReplacedEnabled", nil)
                                        end
                                    elseif not (i6:IsA("ParticleEmitter")) then
                                    end
                                end
                            end
                        end
                        KeyParts = v1:FindFirstChild("KeyParts")
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
function getAttachmentFolder(p1) -- Line: 792 -- upvalues: Promise (val), WepConfig (val)
    return Promise.new(function(a1, p2, p3) -- Line: 793 -- upvalues: WepConfig (upval), p1 (val)
        a1(WepConfig:GetAttachmentFolder(p1))
    end)
end
function findScale(p1, p2) -- Line: 798
    return p1.Size.Magnitude / p2.Size.Magnitude
end
function scaleModelWithJoints(p1, p2) -- Line: 804
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Size = v.Size * p2
            v7 = v.Position - p1:GetPrimaryPartCFrame().p
            v.CFrame = CFrame.new(p1:GetPrimaryPartCFrame().p + v7 * p2) * (v.CFrame - v.Position)
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