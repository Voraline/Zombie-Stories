local function findClosestPart2(p1, p2, p3, p4) -- Line: 2
    local Magnitude, Magnitude_2
    local v1 = nil
    local v2 = (1 / 0)
    local v3 = (1 / 0)
    for i, v in ipairs(p4) do
        if v:IsA("BasePart") and v ~= p1 then
            Magnitude_2 = (p2 - v.Position).Magnitude
            if Magnitude_2 < v2 then
                v1 = v
                v2 = Magnitude_2
            end
        end
    end
    if v1 then
        return v1
    end
    for i2, i3 in ipairs(p4) do
        if i3:IsA("BasePart") and i3 ~= p1 and (p2 - i3.Position).Magnitude < 1 then
            Magnitude = (p3 - i3.Size).Magnitude
            if Magnitude < v3 then
                v3 = Magnitude
                v1 = i3
            end
        end
    end
    return v1
end
local function split(p1, p2) -- Line: 34
    local v1 = {}
    for i in p1:gmatch((("([^%s]+)"):format(p2))) do
        table.insert(v1, (tonumber(i)))
    end
    return unpack(v1)
end
local HttpService = game:GetService("HttpService")
local v1 = {}
local function WeldTogether(p1, p2, p3, p4, p5) -- Line: 48
    local v1 = Instance.new(p3 or "Weld")
    v1.Name = p1.Name .. ":" .. p2.Name
    v1.Part0 = p1
    v1.Part1 = p2
    if not p5 then
        v1.C0 = CFrame.new()
        v1.C1 = p2.CFrame:toObjectSpace(p1.CFrame)
    end
    v1.Parent = p4 or p1
    return v1
end
local function ApplyAttributes(p1, p2) -- Line: 69
    for i, j in p1:GetAttributes() do
        if i ~= "Skin" then
            p2:SetAttribute(i, j)
        end
    end
end
function v1.ApplyFolder(p1, p2, p3) -- Line: 94 -- upvalues: ApplyAttributes (val)
    local Model, PrimaryPart, PrimaryPart_2, Weld_2, Weld_3, v1, v2, v3, v4
    if not (p3:GetAttribute("DontHideGun")) then
        p2.Weapon:ClearAllChildren()
    end
    v2, v1 = p3, p2
    for i, j in p3:GetChildren() do
        if j:IsA("Model") then
            v3 = j:Clone()
            if not (v3:GetAttribute("CustomWelded")) then
                for k, n in v3:QueryDescendants("BasePart") do
                    if n ~= v3.PrimaryPart then
                        PrimaryPart = v3.PrimaryPart
                        Weld_2 = Instance.new("Weld")
                        Weld_2.Name = PrimaryPart.Name .. ":" .. n.Name
                        Weld_2.Part0 = PrimaryPart
                        Weld_2.Part1 = n
                        Weld_2.C0 = CFrame.new()
                        Weld_2.C1 = n.CFrame:toObjectSpace(PrimaryPart.CFrame)
                        Weld_2.Parent = PrimaryPart
                    end
                    n.Anchored = false
                    n.CanCollide = false
                    n.CanTouch = false
                    n.CanQuery = false
                end
            end
            v4 = v1.KeyParts[v3.Name]
            PrimaryPart_2 = v3.PrimaryPart
            Weld_3 = Instance.new("Weld")
            Weld_3.Name = PrimaryPart_2.Name .. ":" .. v4.Name
            Weld_3.Part0 = PrimaryPart_2
            Weld_3.Part1 = v4
            Weld_3.Parent = PrimaryPart_2
            for m, i5 in v3:GetChildren() do
                if i5.Name == "Override" then
                    i5.Name = v4.Name
                    v4.Name = "Overidden"
                    i5.Parent = v4.Parent
                elseif i5 ~= v3.PrimaryPart then
                    i5.Parent = v1.Weapon
                end
            end
            v3.Parent = v1.Weapon
        end
    end
    ApplyAttributes(v2, v1)
    if v1:FindFirstChild("Animations") and v2:FindFirstChild("Animations") then
        for i6, i7 in v1.Animations:GetChildren() do
            v3 = v2.Animations:FindFirstChild(i7.Name)
            if v3 then
                v4 = v3:Clone()
                v4.Parent = i7.Parent
                i7:Destroy()
            end
        end
    end
    v1.Parent = workspace
    local GlobalParts = v1:FindFirstChild("GlobalParts")
    local GlobalParts_2 = v2:FindFirstChild("GlobalParts")
    local Handle = v2:FindFirstChild("Handle")
    if GlobalParts_2 and GlobalParts and Handle and Handle.PrimaryPart then
        local Part1, Weld, v5, v6
        local v7 = GlobalParts_2:Clone()
        local v8 = Handle.PrimaryPart:Clone()
        Model = Instance.new("Model")
        v8.Parent = Model
        v7.Parent = Model
        Model.PrimaryPart = v8
        local Handle_2 = v1.KeyParts.Handle
        Model:PivotTo(Handle_2.CFrame)
        v7.Parent = nil
        Model:Destroy()
        local v9 = {}
        for i8, i9 in GlobalParts:QueryDescendants("BasePart") do
            for i10, i11 in i9:GetJoints() do
                if i11:IsA("JointInstance") then
                    if i11.Part0 ~= i9 then
                        Part1 = i11.Part0
                    else
                        Part1 = i11.Part1
                    end
                    if Part1 then
                        if Part1.Name ~= "Handle" then
                            v9[i9.Name] = Part1
                            break
                        end
                        if not (v9[i9.Name]) then
                            v9[i9.Name] = Part1
                        end
                    end
                end
            end
            v5 = v7.BasePoints:FindFirstChild(i9.Name)
            if v5 then
                if not (v9[i9.Name]) then
                    v6 = Handle_2
                else
                    v6 = v9[i9.Name]
                end
                Weld = Instance.new("Weld")
                Weld.Name = v6.Name .. ":" .. v5.Name
                Weld.Part0 = v6
                Weld.Part1 = v5
                Weld.C0 = CFrame.new()
                Weld.C1 = v5.CFrame:toObjectSpace(v6.CFrame)
                Weld.Parent = v6
                v5.Parent = i9.Parent
                i9:Destroy()
            end
        end
    end
    v1.Parent = nil
end
function v1.DecodeSkin(p1, p2, p3) -- Line: 202 -- upvalues: ApplyAttributes (val), HttpService (val), split (val)
    local Attribute_2
    ApplyAttributes(p3, p2)
    local Attribute = p3:GetAttribute("Skin")
    if not Attribute then
        return
    end
    local v1 = {}
    local v2 = p2
    for k, v in pairs(HttpService:JSONDecode(Attribute)) do
        for i, j in v2.Weapon:QueryDescendants("BasePart") do
            if j:GetAttribute("uid") == k then
                Attribute_2 = j:GetAttribute("uid")
                v1[Attribute_2] = true
                if v.Color then
                    j.Color = Color3.new(split(v.Color, ","))
                end
                if v.Material then
                    j.Material = Enum.Material[v.Material]
                end
                if v.Reflectance then
                    j.Reflectance = v.Reflectance
                end
                if v.Transparency then
                    j.Transparency = v.Transparency
                end
                if not (j:IsA("UnionOperation")) or not v.UsePartColor then
                    break
                end
                j.UsePartColor = v.UsePartColor
                break
            end
        end
    end
end
function v1.AddGlobalParts(p1, p2, p3) -- Line: 244
    local BulletEjection, Name
    local v1 = p3:Clone()
    v1.Parent = workspace.Ignore
    if not (p2.KeyParts:FindFirstChild("BulletEjection", true)) then
        BulletEjection = v1.KeyParts:FindFirstChild("BulletEjection", true)
        if BulletEjection then
            local v2 = BulletEjection:Clone()
            v2.Parent = p2.KeyParts.Handle
        end
    end
    if not (p2:FindFirstChild("Animations")) then
        v1.Animations:Clone().Parent = p2
    elseif p2:FindFirstChild("Animations") then
        local v3
        for i, j in v1:WaitForChild("Animations"):GetChildren() do
            if j.Name ~= "3P" and j.Name ~= "Idle" and j.Name ~= "Shoot" and not (p2.Animations:FindFirstChild(j.Name)) then
                v3 = j:Clone()
                v3.Parent = p2.Animations
            end
        end
    end
    local GlobalParts = v1:FindFirstChild("GlobalParts")
    local GlobalParts_2 = p2:FindFirstChild("GlobalParts")
    if GlobalParts then
        local Handle, Handle_2, Part1, Weld_2, v4
        p2:PivotTo(v1.PrimaryPart.CFrame)
        local v5 = GlobalParts:Clone()
        local v6 = {}
        if not GlobalParts_2 then
            v4 = p2
        else
            if v5:FindFirstChild("BasePoints") and GlobalParts_2:FindFirstChild("BasePoints") then
                v4 = p2
                for k, n in GlobalParts_2.BasePoints:GetChildren() do
                    if v5.BasePoints:FindFirstChild(n.Name) then
                        v6[n.Name] = false
                        v5.BasePoints[n.Name]:Destroy()
                    end
                    n.Parent = v5.BasePoints
                end
            end
            for m, i5 in v5:GetChildren() do
                if i5.Name ~= "BasePoints" and i5:IsA("Folder") and GlobalParts_2:FindFirstChild(i5.Name) then
                    i5:Destroy()
                end
            end
        end
        for i6, i7 in GlobalParts:QueryDescendants("BasePart") do
            if v6[i7.Name] ~= false then
                Name = nil
                for i8, i9 in i7:GetJoints() do
                    if i9:IsA("JointInstance") then
                        if i9.Part0 ~= i7 then
                            Part1 = i9.Part0
                        else
                            Part1 = i9.Part1
                        end
                        if Part1 then
                            if Part1.Name ~= "Handle" then
                                Name = Part1.Name
                                break
                            end
                            if not Name then
                                Name = Part1.Name
                            end
                        end
                    end
                end
                if Name then
                    v6[i7.Name] = Name
                end
            end
        end
        for i10, i11 in v5:QueryDescendants("BasePart") do
            i11:BreakJoints()
            if v6[i11.Name] then
                Handle_2 = v4.KeyParts:FindFirstChild(v6[i11.Name])
                if not Handle_2 then
                    Handle_2 = v4.KeyParts.Handle
                end
                Weld_2 = Instance.new("Weld")
                Weld_2.Name = Handle_2.Name .. ":" .. i11.Name
                Weld_2.Part0 = Handle_2
                Weld_2.Part1 = i11
                Weld_2.C0 = CFrame.new()
                Weld_2.C1 = i11.CFrame:toObjectSpace(Handle_2.CFrame)
                Weld_2.Parent = Handle_2
            end
        end
        if GlobalParts_2 then
            for i12, i13 in v5:GetChildren() do
                if i13.Name ~= "BasePoints" then
                    i13.Parent = GlobalParts_2
                else
                    for i14, i15 in i13:GetChildren() do
                        i15.Parent = GlobalParts_2.BasePoints
                    end
                end
            end
            v5:Destroy()
        else
            v5.Parent = v4
            GlobalParts_2 = v5
        end
        if GlobalParts_2 and GlobalParts_2:FindFirstChild("ToWeapon") then
            local Weld
            for i16, i17 in GlobalParts_2.ToWeapon:QueryDescendants("BasePart") do
                Handle = v4.KeyParts.Handle
                Weld = Instance.new("Weld")
                Weld.Name = Handle.Name .. ":" .. i17.Name
                Weld.Part0 = Handle
                Weld.Part1 = i17
                Weld.C0 = CFrame.new()
                Weld.C1 = i17.CFrame:toObjectSpace(Handle.CFrame)
                Weld.Parent = Handle
            end
            for i18, i19 in GlobalParts_2.ToWeapon:GetChildren() do
                if v4.Weapon:FindFirstChild(i19.Name) then
                    for i20, i21 in i19:GetChildren() do
                        i21.Parent = v4.Weapon[i19.Name]
                    end
                    i19:Destroy()
                else
                    i19.Parent = v4.Weapon
                end
            end
        end
    end
    v1:Destroy()
end
function v1.ApplyCreatorSkin(p1, p2, p3) -- Line: 377
    local BasePart, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    if not (p3:GetAttribute("DontHideGun")) then
        p2.Weapon:ClearAllChildren()
    end
    p2.Parent = workspace
    local Geometry = p3:FindFirstChild("Geometry")
    if not Geometry then
        v11, v1 = p3, p2
    else
        local AttachmentWeld, Attribute, Handle, PrimaryPart, PrimaryPart_2, Weld, Weld_2
        v1, v11 = p2, p3
        for i, j in Geometry:GetChildren() do
            if j:IsA("Model") then
                v12 = j:Clone()
                v2 = v12:GetAttribute("WeldTarget") or "Handle"
                Handle = v1.KeyParts:FindFirstChild(v2)
                if not Handle then
                    Handle = v1.KeyParts.Handle
                end
                AttachmentWeld = v12:FindFirstChild("AttachmentWeld", true)
                if not AttachmentWeld then
                    if not v12.PrimaryPart then
                        for k, n in v12:GetDescendants() do
                            if n:IsA("BasePart") then
                                v12.PrimaryPart = n
                                break
                            end
                        end
                    end
                elseif AttachmentWeld:IsA("BasePart") then
                    v12.PrimaryPart = AttachmentWeld
                end
                Attribute = v12:GetAttribute("VisibilityRule")
                v6 = Attribute == "Replace"
                if not v6 then
                    if v12.PrimaryPart then
                        v12:PivotTo(Handle.CFrame * v12:GetPivot())
                    end
                elseif v12.PrimaryPart then
                    v12:PivotTo(Handle.CFrame)
                end
                if v12.PrimaryPart and not (v12:GetAttribute("CustomWelded")) then
                    for m, i5 in v12:GetDescendants() do
                        if i5:IsA("BasePart") then
                            if i5 ~= v12.PrimaryPart then
                                PrimaryPart = v12.PrimaryPart
                                Weld = Instance.new("Weld")
                                Weld.Name = PrimaryPart.Name .. ":" .. i5.Name
                                Weld.Part0 = PrimaryPart
                                Weld.Part1 = i5
                                Weld.C0 = CFrame.new()
                                Weld.C1 = i5.CFrame:toObjectSpace(PrimaryPart.CFrame)
                                Weld.Parent = PrimaryPart
                            end
                            if not v6 then
                                i5.Anchored = false
                            elseif i5 == v12.PrimaryPart then
                            end
                            i5.CanCollide = false
                            i5.CanTouch = false
                            i5.CanQuery = false
                        end
                    end
                end
                if not v6 and v12.PrimaryPart then
                    v7 = Handle
                    PrimaryPart_2 = v12.PrimaryPart
                    Weld_2 = Instance.new("Weld")
                    Weld_2.Name = v7.Name .. ":" .. PrimaryPart_2.Name
                    Weld_2.Part0 = v7
                    Weld_2.Part1 = PrimaryPart_2
                    Weld_2.C0 = CFrame.new()
                    Weld_2.C1 = PrimaryPart_2.CFrame:toObjectSpace(v7.CFrame)
                    Weld_2.Parent = v7
                end
                v12.Parent = v1.Weapon
                if Attribute == "Show" then
                    for i6, i7 in v12:GetDescendants() do
                        if i7:IsA("BasePart") then
                            i7:SetAttribute("VisibilityOrigTransparency", i7.Transparency)
                            i7.Transparency = 1
                        elseif not (i7:IsA("Decal")) and not (i7:IsA("Texture")) then
                            if i7:IsA("Beam") then
                                i7:SetAttribute("VisibilityOrigEnabled", i7.Enabled)
                                i7.Enabled = false
                            elseif not (i7:IsA("ParticleEmitter")) then
                            end
                        end
                    end
                elseif not v6 then
                end
            end
        end
    end
    local BasePoints = v11:FindFirstChild("BasePoints")
    local GlobalParts = v1:FindFirstChild("GlobalParts")
    if BasePoints and GlobalParts then
        local BasePoints_2 = GlobalParts:FindFirstChild("BasePoints")
        if BasePoints_2 then
            local C0, Handle_2, Weld_3, Weld_4, Weld_5
            for i8, i9 in BasePoints:GetChildren() do
                if i9:IsA("BasePart") then
                    v4 = BasePoints_2:FindFirstChild(i9.Name)
                    v5 = i9:GetAttribute("WeldTarget") or "Handle"
                    Handle_2 = v1.KeyParts:FindFirstChild(v5)
                    if not Handle_2 then
                        Handle_2 = v1.KeyParts.Handle
                    end
                    Weld_3 = i9:FindFirstChildWhichIsA("Weld")
                    if not Weld_3 then
                        C0 = CFrame.new()
                    else
                        C0 = Weld_3.C0
                    end
                    v9 = i9:Clone()
                    v9.Anchored = false
                    v9.CanCollide = false
                    v9.CanTouch = false
                    v9.CanQuery = false
                    Weld_4 = v9:FindFirstChildWhichIsA("Weld")
                    if Weld_4 then
                        Weld_4:Destroy()
                    end
                    v9.CFrame = Handle_2.CFrame * C0
                    Weld_5 = Instance.new("Weld")
                    Weld_5.Name = Handle_2.Name .. ":" .. v9.Name
                    Weld_5.Part0 = Handle_2
                    Weld_5.Part1 = v9
                    Weld_5.C0 = CFrame.new()
                    Weld_5.C1 = v9.CFrame:toObjectSpace(Handle_2.CFrame)
                    Weld_5.Parent = Handle_2
                    v9.Parent = BasePoints_2
                    if v4 then
                        v4:BreakJoints()
                        v4:Destroy()
                    end
                end
            end
        end
    end
    local Animations = v11:FindFirstChild("Animations")
    if Animations and v1:FindFirstChild("Animations") then
        for i10, i11 in Animations:GetChildren() do
            if i11:IsA("Animation") then
                v4 = v1.Animations:FindFirstChild(i11.Name)
                if v4 then
                    v4:Destroy()
                end
                v5 = i11:Clone()
                v5.Parent = v1.Animations
            end
        end
    end
    local v13 = {
        SkinSDKVersion = true,
        BaseWeapon = true,
        DontHideGun = true,
        Author = true,
        Category = true,
    }
    for i12, i13 in v11:GetAttributes() do
        if not (v13[i12]) then
            v1:SetAttribute(i12, i13)
        end
    end
    local KeyPartOverrides = v11:FindFirstChild("KeyPartOverrides")
    if KeyPartOverrides then
        local Attribute_2 = KeyPartOverrides:GetAttribute("BarrelOffset")
        local Attribute_3 = KeyPartOverrides:GetAttribute("BarrelSize")
        if Attribute_2 then
            local Barrel = v1.KeyParts:FindFirstChild("Barrel")
            if Barrel then
                local CFrame
                local BulletEjection = Barrel:FindFirstChild("BulletEjection")
                if not BulletEjection then
                    CFrame = nil
                elseif BulletEjection:IsA("BasePart") then
                    CFrame = BulletEjection.CFrame
                end
                if Attribute_2 then
                    Barrel.CFrame = Barrel.CFrame * Attribute_2
                end
                if Attribute_3 then
                    Barrel.Size = Attribute_3
                end
                if BulletEjection and CFrame then
                    BulletEjection:BreakJoints()
                    BulletEjection.CFrame = CFrame
                    local Weld_6 = Instance.new("Weld")
                    Weld_6.Name = Barrel.Name .. ":" .. BulletEjection.Name
                    Weld_6.Part0 = Barrel
                    Weld_6.Part1 = BulletEjection
                    Weld_6.C0 = CFrame.new()
                    Weld_6.C1 = BulletEjection.CFrame:toObjectSpace(Barrel.CFrame)
                    Weld_6.Parent = Barrel
                end
            end
        elseif not Attribute_3 then
        end
        local Attribute_4 = KeyPartOverrides:GetAttribute("AimPartOffset")
        if Attribute_4 then
            v1:SetAttribute("SkinAimPartOffset", Attribute_4)
        end
    end
    if Geometry then
        local Attribute_5, Weapon, isDefault, v14
        v12 = {}
        for i14, i15 in Geometry:GetChildren() do
            if i15:IsA("Model") then
                Attribute_5 = i15:GetAttribute("OptionGroup")
                if Attribute_5 and Attribute_5 ~= "" then
                    if not (v12[Attribute_5]) then
                        v12[Attribute_5] = {}
                    end
                    table.insert(v12[Attribute_5], {name = i15.Name, isDefault = i15:GetAttribute("OptionGroupDefault") or false})
                end
            end
        end
        v2 = v12
        v3 = nil
        v4 = nil
        for i16, i17 in v2, v3, v4 do
            v7 = false
            v8 = i17
            v9 = nil
            v10 = nil
            for i18, i19 in v8, v9, v10 do
                if i19.isDefault then
                    v7 = true
                    break
                end
            end
            v8 = i17
            v9 = nil
            v10 = nil
            for i20, i21 in v8, v9, v10 do
                if not v7 then
                    isDefault = i20 == 1
                else
                    isDefault = i21.isDefault
                end
                if not isDefault then
                    Weapon = v1:FindFirstChild("Weapon")
                    v14 = Weapon
                    if v14 then
                        v14 = Weapon:FindFirstChild(i21.name)
                    end
                    if v14 then
                        for i22, i23 in v14:GetDescendants() do
                            if i23:IsA("BasePart") then
                                i23:SetAttribute("OptionGroupHidden", true)
                                i23:SetAttribute("OrigTransparency", i23.Transparency)
                                i23.Transparency = 1
                            elseif not (i23:IsA("Decal")) and not (i23:IsA("Texture")) then
                                if i23:IsA("Beam") then
                                    i23:SetAttribute("OptionGroupHidden", true)
                                    i23:SetAttribute("OrigEnabled", i23.Enabled)
                                    i23.Enabled = false
                                elseif not (i23:IsA("ParticleEmitter")) then
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if Geometry then
        local Attribute_6
        local Weapon_2 = v1:FindFirstChild("Weapon")
        v2 = {}
        for i24, i25 in Geometry:GetChildren() do
            if i25:IsA("Model") then
                v8 = Weapon_2
                if v8 then
                    v8 = Weapon_2:FindFirstChild(i25.Name)
                end
                if not v8 then
                    Attribute_6 = i25:GetAttribute("LockedNodes")
                    if Attribute_6 and Attribute_6 ~= "" then
                        for i26, i27 in string.split(Attribute_6, ",") do
                            v2[i27] = true
                        end
                    end
                else
                    BasePart = v8:FindFirstChildWhichIsA("BasePart", true)
                    if BasePart and BasePart:GetAttribute("OptionGroupHidden") then end
                end
            end
        end
        if not (next(v2)) then
            v1:SetAttribute("SkinLockedNodes", nil)
        else
            v3 = {}
            v4 = v2
            v5 = nil
            v6 = nil
            for i28 in v4, v5, v6 do
                table.insert(v3, i28)
            end
            v1:SetAttribute("SkinLockedNodes", table.concat(v3, ","))
        end
    end
    if Geometry then
        local GlobalParts_2 = v1:FindFirstChild("GlobalParts")
        local BasePoints_3 = GlobalParts_2
        if BasePoints_3 then
            BasePoints_3 = GlobalParts_2:FindFirstChild("BasePoints")
        end
        if BasePoints_3 then
            local BasePart_2, Weapon_3, v15, v16, v17, v18, v19, v20, v21
            v3 = {}
            for i29, i30 in Geometry:GetChildren() do
                if i30:IsA("Model") then
                    Weapon_3 = v1:FindFirstChild("Weapon")
                    v10 = Weapon_3
                    if v10 then
                        v10 = Weapon_3:FindFirstChild(i30.Name)
                    end
                    if not v10 then
                        for i31, i32 in i30:GetAttributes() do
                            if string.sub(i31, 1, 13) == "NodeOverride_" then
                                v17 = string.sub(i31, 14)
                                v19 = tostring(i32)
                                v18 = string.split(v19, ",")
                                if #v18 == 3 then
                                    v20 = tonumber(v18[1]) or 0
                                    v21 = tonumber(v18[2]) or 0
                                    v3[v17] = Vector3.new(v20, v21, tonumber(v18[3]) or 0)
                                end
                            end
                        end
                    else
                        BasePart_2 = v10:FindFirstChildWhichIsA("BasePart", true)
                        if BasePart_2 and BasePart_2:GetAttribute("OptionGroupHidden") then end
                    end
                end
            end
            local Handle_3 = v1:FindFirstChild("Handle")
            if not Handle_3 then
                Handle_3 = v1.PrimaryPart
            end
            v5 = v3
            v6 = nil
            v7 = nil
            for i33, i34 in v5, v6, v7 do
                v10 = BasePoints_3:FindFirstChild(i33)
                if v10 and v10:IsA("BasePart") then
                    if not Handle_3 then
                        v15 = i34
                    else
                        v15 = Handle_3.CFrame:VectorToWorldSpace(i34)
                    end
                    v16 = CFrame.new(v10.CFrame.Position + v15)
                    v10.CFrame = v16 * v10.CFrame.Rotation
                end
            end
        end
    end
    v1.Parent = nil
end
return v1