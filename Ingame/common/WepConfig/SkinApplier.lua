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
    local v1
    local v2 = {}
    local v3 = ("([^%s]+)"):format(p2)
    for i in p1:gmatch(v3) do
        v1 = tonumber(i)
        table.insert(v2, v1)
    end
    return unpack(v2)
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
        local CFrame_2 = p2.CFrame
        local CFrame_3 = p1.CFrame
        v1.C1 = CFrame_2:toObjectSpace(CFrame_3)
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
    local CFrame_5, CFrame_6, PrimaryPart, PrimaryPart_2, Weld_2, Weld_3, v1, v2
    if not p3:GetAttribute("DontHideGun") then
        p2.Weapon:ClearAllChildren()
    end
    local v3, v4 = p3, p2
    for i, j in p3:GetChildren() do
        if j:IsA("Model") then
            v1 = j:Clone()
            if not v1:GetAttribute("CustomWelded") then
                for k, n in v1:QueryDescendants("BasePart") do
                    if n ~= v1.PrimaryPart then
                        PrimaryPart = v1.PrimaryPart
                        Weld_2 = Instance.new("Weld")
                        Weld_2.Name = PrimaryPart.Name .. ":" .. n.Name
                        Weld_2.Part0 = PrimaryPart
                        Weld_2.Part1 = n
                        Weld_2.C0 = CFrame.new()
                        CFrame_5 = n.CFrame
                        CFrame_6 = PrimaryPart.CFrame
                        Weld_2.C1 = CFrame_5:toObjectSpace(CFrame_6)
                        Weld_2.Parent = PrimaryPart
                    end
                    n.Anchored = false
                    n.CanCollide = false
                    n.CanTouch = false
                    n.CanQuery = false
                end
            end
            v2 = v4.KeyParts[v1.Name]
            PrimaryPart_2 = v1.PrimaryPart
            Weld_3 = Instance.new("Weld")
            Weld_3.Name = PrimaryPart_2.Name .. ":" .. v2.Name
            Weld_3.Part0 = PrimaryPart_2
            Weld_3.Part1 = v2
            Weld_3.Parent = PrimaryPart_2
            for m, i5 in v1:GetChildren() do
                if i5.Name == "Override" then
                    i5.Name = v2.Name
                    v2.Name = "Overidden"
                    i5.Parent = v2.Parent
                elseif i5 ~= v1.PrimaryPart then
                    i5.Parent = v4.Weapon
                end
            end
            v1.Parent = v4.Weapon
        end
    end
    ApplyAttributes(v3, v4)
    if v4:FindFirstChild("Animations") and v3:FindFirstChild("Animations") then
        local Animations, Name
        for i6, i7 in v4.Animations:GetChildren() do
            Animations = v3.Animations
            Name = i7.Name
            v1 = Animations:FindFirstChild(Name)
            if v1 then
                v2 = v1:Clone()
                v2.Parent = i7.Parent
                i7:Destroy()
            end
        end
    end
    v4.Parent = workspace
    local GlobalParts = v4:FindFirstChild("GlobalParts")
    local GlobalParts_2 = v3:FindFirstChild("GlobalParts")
    local Handle = v3:FindFirstChild("Handle")
    if GlobalParts_2 and GlobalParts and Handle and Handle.PrimaryPart then
        local BasePoints, CFrame_3, CFrame_4, Name_2, Part1, Weld, v5, v6
        local v7 = GlobalParts_2:Clone()
        local v8 = Handle.PrimaryPart:Clone()
        local Model = Instance.new("Model")
        v8.Parent = Model
        v7.Parent = Model
        Model.PrimaryPart = v8
        local Handle_2 = v4.KeyParts.Handle
        local CFrame_2 = Handle_2.CFrame
        Model:PivotTo(CFrame_2)
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
                        if not v9[i9.Name] then
                            v9[i9.Name] = Part1
                        end
                    end
                end
            end
            BasePoints = v7.BasePoints
            Name_2 = i9.Name
            v5 = BasePoints:FindFirstChild(Name_2)
            if v5 then
                if not v9[i9.Name] then
                    v6 = Handle_2
                else
                    v6 = v9[i9.Name]
                end
                Weld = Instance.new("Weld")
                Weld.Name = v6.Name .. ":" .. v5.Name
                Weld.Part0 = v6
                Weld.Part1 = v5
                Weld.C0 = CFrame.new()
                CFrame_3 = v5.CFrame
                CFrame_4 = v6.CFrame
                Weld.C1 = CFrame_3:toObjectSpace(CFrame_4)
                Weld.Parent = v6
                v5.Parent = i9.Parent
                i9:Destroy()
            end
        end
    end
    v4.Parent = nil
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
                if not j:IsA("UnionOperation") or not v.UsePartColor then
                    break
                end
                j.UsePartColor = v.UsePartColor
                break
            end
        end
    end
end

function v1.AddGlobalParts(p1, p2, p3) -- Line: 244
    local v1 = p3:Clone()
    v1.Parent = workspace.Ignore
    if not p2.KeyParts:FindFirstChild("BulletEjection", true) then
        local BulletEjection = v1.KeyParts:FindFirstChild("BulletEjection", true)
        if BulletEjection then
            local v2 = BulletEjection:Clone()
            v2.Parent = p2.KeyParts.Handle
        end
    end
    if not p2:FindFirstChild("Animations") then
        v1.Animations:Clone().Parent = p2
    elseif p2:FindFirstChild("Animations") then
        local Animations, Name, v3
        for i, j in v1:WaitForChild("Animations"):GetChildren() do
            if j.Name ~= "3P" and j.Name ~= "Idle" and j.Name ~= "Shoot" then
                Animations = p2.Animations
                Name = j.Name
                if not Animations:FindFirstChild(Name) then
                    v3 = j:Clone()
                    v3.Parent = p2.Animations
                end
            end
        end
    end
    local GlobalParts = v1:FindFirstChild("GlobalParts")
    local GlobalParts_2 = p2:FindFirstChild("GlobalParts")
    if GlobalParts then
        local CFrame_5, CFrame_6, Handle_2, KeyParts, Name_6, Part1, Weld_2, v4, v5
        local CFrame_2 = v1.PrimaryPart.CFrame
        p2:PivotTo(CFrame_2)
        local v6 = GlobalParts:Clone()
        local v7 = {}
        if not GlobalParts_2 then
            v4 = p2
        else
            local Name_3
            if v6:FindFirstChild("BasePoints") and GlobalParts_2:FindFirstChild("BasePoints") then
                local BasePoints, Name_2
                v4 = p2
                for k, n in GlobalParts_2.BasePoints:GetChildren() do
                    BasePoints = v6.BasePoints
                    Name_2 = n.Name
                    if BasePoints:FindFirstChild(Name_2) then
                        v7[n.Name] = false
                        v6.BasePoints[n.Name]:Destroy()
                    end
                    n.Parent = v6.BasePoints
                end
            end
            for m, i5 in v6:GetChildren() do
                if i5.Name ~= "BasePoints" and i5:IsA("Folder") then
                    Name_3 = i5.Name
                    if GlobalParts_2:FindFirstChild(Name_3) then
                        i5:Destroy()
                    end
                end
            end
        end
        for i6, i7 in GlobalParts:QueryDescendants("BasePart") do
            if v7[i7.Name] ~= false then
                Name_6 = nil
                for i8, i9 in i7:GetJoints() do
                    if i9:IsA("JointInstance") then
                        if i9.Part0 ~= i7 then
                            Part1 = i9.Part0
                        else
                            Part1 = i9.Part1
                        end
                        if Part1 then
                            if Part1.Name ~= "Handle" then
                                Name_6 = Part1.Name
                                break
                            end
                            if not Name_6 then
                                Name_6 = Part1.Name
                            end
                        end
                    end
                end
                if Name_6 then
                    v7[i7.Name] = Name_6
                end
            end
        end
        for i10, i11 in v6:QueryDescendants("BasePart") do
            i11:BreakJoints()
            if v7[i11.Name] then
                KeyParts = v4.KeyParts
                v5 = v7[i11.Name]
                Handle_2 = KeyParts:FindFirstChild(v5)
                if not Handle_2 then
                    Handle_2 = v4.KeyParts.Handle
                end
                Weld_2 = Instance.new("Weld")
                Weld_2.Name = Handle_2.Name .. ":" .. i11.Name
                Weld_2.Part0 = Handle_2
                Weld_2.Part1 = i11
                Weld_2.C0 = CFrame.new()
                CFrame_5 = i11.CFrame
                CFrame_6 = Handle_2.CFrame
                Weld_2.C1 = CFrame_5:toObjectSpace(CFrame_6)
                Weld_2.Parent = Handle_2
            end
        end
        if GlobalParts_2 then
            for i12, i13 in v6:GetChildren() do
                if i13.Name ~= "BasePoints" then
                    i13.Parent = GlobalParts_2
                else
                    for i14, i15 in i13:GetChildren() do
                        i15.Parent = GlobalParts_2.BasePoints
                    end
                end
            end
            v6:Destroy()
        else
            v6.Parent = v4
            GlobalParts_2 = v6
        end
        if GlobalParts_2 and GlobalParts_2:FindFirstChild("ToWeapon") then
            local CFrame_3, CFrame_4, Handle, Name_4, Weapon, Weld
            for i16, i17 in GlobalParts_2.ToWeapon:QueryDescendants("BasePart") do
                Handle = v4.KeyParts.Handle
                Weld = Instance.new("Weld")
                Weld.Name = Handle.Name .. ":" .. i17.Name
                Weld.Part0 = Handle
                Weld.Part1 = i17
                Weld.C0 = CFrame.new()
                CFrame_3 = i17.CFrame
                CFrame_4 = Handle.CFrame
                Weld.C1 = CFrame_3:toObjectSpace(CFrame_4)
                Weld.Parent = Handle
            end
            for i18, i19 in GlobalParts_2.ToWeapon:GetChildren() do
                Weapon = v4.Weapon
                Name_4 = i19.Name
                if Weapon:FindFirstChild(Name_4) then
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
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    if not p3:GetAttribute("DontHideGun") then
        p2.Weapon:ClearAllChildren()
    end
    p2.Parent = workspace
    local Geometry = p3:FindFirstChild("Geometry")
    if not Geometry then
        v11, v1 = p3, p2
    else
        local AttachmentWeld, Attribute, CFrame_2, CFrame_4, CFrame_5, CFrame_6, CFrame_7, Enabled, Handle, PrimaryPart, PrimaryPart_2, Transparency, Weld, Weld_2
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
                elseif not v12.PrimaryPart then
                    for m, i5 in v12:GetDescendants() do
                        if i5:IsA("BasePart") then
                            v12.PrimaryPart = i5
                            break
                        end
                    end
                end
                Attribute = v12:GetAttribute("VisibilityRule")
                v6 = Attribute == "Replace"
                if not v6 then
                    if v12.PrimaryPart then
                        v9 = Handle.CFrame * (v12:GetPivot())
                        v12:PivotTo(v9)
                    end
                elseif v12.PrimaryPart then
                    CFrame_2 = Handle.CFrame
                    v12:PivotTo(CFrame_2)
                end
                if v12.PrimaryPart and not v12:GetAttribute("CustomWelded") then
                    for i6, i7 in v12:GetDescendants() do
                        if i7:IsA("BasePart") then
                            if i7 ~= v12.PrimaryPart then
                                PrimaryPart = v12.PrimaryPart
                                Weld = Instance.new("Weld")
                                Weld.Name = PrimaryPart.Name .. ":" .. i7.Name
                                Weld.Part0 = PrimaryPart
                                Weld.Part1 = i7
                                Weld.C0 = CFrame.new()
                                CFrame_4 = i7.CFrame
                                CFrame_5 = PrimaryPart.CFrame
                                Weld.C1 = CFrame_4:toObjectSpace(CFrame_5)
                                Weld.Parent = PrimaryPart
                            end
                            if not v6 or i7 ~= v12.PrimaryPart then
                                i7.Anchored = false
                            end
                            i7.CanCollide = false
                            i7.CanTouch = false
                            i7.CanQuery = false
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
                    CFrame_6 = PrimaryPart_2.CFrame
                    CFrame_7 = v7.CFrame
                    Weld_2.C1 = CFrame_6:toObjectSpace(CFrame_7)
                    Weld_2.Parent = v7
                end
                v12.Parent = v1.Weapon
                if Attribute == "Show" then
                    for i8, i9 in v12:GetDescendants() do
                        if i9:IsA("BasePart") or i9:IsA("Decal") or i9:IsA("Texture") then
                            Transparency = i9.Transparency
                            i9:SetAttribute("VisibilityOrigTransparency", Transparency)
                            i9.Transparency = 1
                        elseif i9:IsA("Beam") or i9:IsA("ParticleEmitter") then
                            Enabled = i9.Enabled
                            i9:SetAttribute("VisibilityOrigEnabled", Enabled)
                            i9.Enabled = false
                        end
                    end
                elseif v6 then
                    for i10, i11 in v12:GetDescendants() do
                        if i11:IsA("BasePart") or i11:IsA("Decal") or i11:IsA("Texture") then
                            Transparency = i11.Transparency
                            i11:SetAttribute("VisibilityOrigTransparency", Transparency)
                            i11.Transparency = 1
                        elseif i11:IsA("Beam") or i11:IsA("ParticleEmitter") then
                            Enabled = i11.Enabled
                            i11:SetAttribute("VisibilityOrigEnabled", Enabled)
                            i11.Enabled = false
                        end
                    end
                end
            end
        end
    end
    local BasePoints = v11:FindFirstChild("BasePoints")
    local GlobalParts = v1:FindFirstChild("GlobalParts")
    if BasePoints and GlobalParts then
        local BasePoints_2 = GlobalParts:FindFirstChild("BasePoints")
        if BasePoints_2 then
            local C0, CFrame_8, CFrame_9, Handle_2, Name, Weld_3, Weld_4, Weld_5
            for i12, i13 in BasePoints:GetChildren() do
                if i13:IsA("BasePart") then
                    Name = i13.Name
                    v4 = BasePoints_2:FindFirstChild(Name)
                    v5 = i13:GetAttribute("WeldTarget") or "Handle"
                    Handle_2 = v1.KeyParts:FindFirstChild(v5)
                    if not Handle_2 then
                        Handle_2 = v1.KeyParts.Handle
                    end
                    Weld_3 = i13:FindFirstChildWhichIsA("Weld")
                    if not Weld_3 then
                        C0 = CFrame.new()
                    else
                        C0 = Weld_3.C0
                        if not C0 then
                            C0 = CFrame.new()
                        end
                    end
                    v9 = i13:Clone()
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
                    CFrame_8 = v9.CFrame
                    CFrame_9 = Handle_2.CFrame
                    Weld_5.C1 = CFrame_8:toObjectSpace(CFrame_9)
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
        local Animations_2, Name_2
        for i14, i15 in Animations:GetChildren() do
            if i15:IsA("Animation") then
                Animations_2 = v1.Animations
                Name_2 = i15.Name
                v4 = Animations_2:FindFirstChild(Name_2)
                if v4 then
                    v4:Destroy()
                end
                v5 = i15:Clone()
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
    for i16, i17 in v11:GetAttributes() do
        if not v13[i16] then
            v1:SetAttribute(i16, i17)
        end
    end
    local KeyPartOverrides = v11:FindFirstChild("KeyPartOverrides")
    if KeyPartOverrides then
        local Attribute_2 = KeyPartOverrides:GetAttribute("BarrelOffset")
        local Attribute_3 = KeyPartOverrides:GetAttribute("BarrelSize")
        if Attribute_2 or Attribute_3 then
            local Barrel = v1.KeyParts:FindFirstChild("Barrel")
            if Barrel then
                local CFrame_10
                local BulletEjection = Barrel:FindFirstChild("BulletEjection")
                if not BulletEjection or not BulletEjection:IsA("BasePart") then
                    CFrame_10 = nil
                else
                    CFrame_10 = BulletEjection.CFrame
                    if not CFrame_10 then
                        CFrame_10 = nil
                    end
                end
                if Attribute_2 then
                    Barrel.CFrame = Barrel.CFrame * Attribute_2
                end
                if Attribute_3 then
                    Barrel.Size = Attribute_3
                end
                if BulletEjection and CFrame_10 then
                    BulletEjection:BreakJoints()
                    BulletEjection.CFrame = CFrame_10
                    local Weld_6 = Instance.new("Weld")
                    Weld_6.Name = Barrel.Name .. ":" .. BulletEjection.Name
                    Weld_6.Part0 = Barrel
                    Weld_6.Part1 = BulletEjection
                    Weld_6.C0 = CFrame.new()
                    local CFrame_11 = BulletEjection.CFrame
                    local CFrame_12 = Barrel.CFrame
                    Weld_6.C1 = CFrame_11:toObjectSpace(CFrame_12)
                    Weld_6.Parent = Barrel
                end
            end
        end
        local Attribute_4 = KeyPartOverrides:GetAttribute("AimPartOffset")
        if Attribute_4 then
            v1:SetAttribute("SkinAimPartOffset", Attribute_4)
        end
    end
    if Geometry then
        local Attribute_5, Enabled_2, Transparency_2, Weapon, isDefault, name, v14
        v12 = {}
        for i18, i19 in Geometry:GetChildren() do
            if i19:IsA("Model") then
                Attribute_5 = i19:GetAttribute("OptionGroup")
                if Attribute_5 and Attribute_5 ~= "" then
                    if not v12[Attribute_5] then
                        v12[Attribute_5] = {}
                    end
                    v9 = v12[Attribute_5]
                    v10 = {name = i19.Name, isDefault = i19:GetAttribute("OptionGroupDefault") or false}
                    table.insert(v9, v10)
                end
            end
        end
        v2 = v12
        v3 = nil
        v4 = nil
        for i20, i21 in v2, v3, v4 do
            v7 = false
            v8 = i21
            v9 = nil
            v10 = nil
            for i22, i23 in v8, v9, v10 do
                if i23.isDefault then
                    v7 = true
                    break
                end
            end
            v8 = i21
            v9 = nil
            v10 = nil
            for i24, i25 in v8, v9, v10 do
                if not v7 then
                    isDefault = i24 == 1
                else
                    isDefault = i25.isDefault
                end
                if not isDefault then
                    Weapon = v1:FindFirstChild("Weapon")
                    v14 = Weapon
                    if v14 then
                        name = i25.name
                        v14 = Weapon:FindFirstChild(name)
                    end
                    if v14 then
                        for i26, i27 in v14:GetDescendants() do
                            if i27:IsA("BasePart") or i27:IsA("Decal") or i27:IsA("Texture") then
                                i27:SetAttribute("OptionGroupHidden", true)
                                Transparency_2 = i27.Transparency
                                i27:SetAttribute("OrigTransparency", Transparency_2)
                                i27.Transparency = 1
                            elseif i27:IsA("Beam") or i27:IsA("ParticleEmitter") then
                                i27:SetAttribute("OptionGroupHidden", true)
                                Enabled_2 = i27.Enabled
                                i27:SetAttribute("OrigEnabled", Enabled_2)
                                i27.Enabled = false
                            end
                        end
                    end
                end
            end
        end
    end
    if Geometry then
        local Attribute_6, BasePart, Name_3
        local Weapon_2 = v1:FindFirstChild("Weapon")
        v2 = {}
        for i28, i29 in Geometry:GetChildren() do
            if i29:IsA("Model") then
                v8 = Weapon_2
                if v8 then
                    Name_3 = i29.Name
                    v8 = Weapon_2:FindFirstChild(Name_3)
                end
                if not v8 then
                    Attribute_6 = i29:GetAttribute("LockedNodes")
                    if Attribute_6 and Attribute_6 ~= "" then
                        for i30, i31 in string.split(Attribute_6, ",") do
                            v2[i31] = true
                        end
                    end
                else
                    BasePart = v8:FindFirstChildWhichIsA("BasePart", true)
                    if not BasePart then
                        Attribute_6 = i29:GetAttribute("LockedNodes")
                        if Attribute_6 and Attribute_6 ~= "" then
                            for i32, i33 in string.split(Attribute_6, ",") do
                                v2[i33] = true
                            end
                        end
                    elseif not BasePart:GetAttribute("OptionGroupHidden") then
                        Attribute_6 = i29:GetAttribute("LockedNodes")
                        if Attribute_6 and Attribute_6 ~= "" then
                            for i34, i35 in string.split(Attribute_6, ",") do
                                v2[i35] = true
                            end
                        end
                    end
                end
            end
        end
        if not next(v2) then
            v1:SetAttribute("SkinLockedNodes", nil)
        else
            v3 = {}
            v4 = v2
            v5 = nil
            v6 = nil
            for i36 in v4, v5, v6 do
                table.insert(v3, i36)
            end
            v7 = table.concat(v3, ",")
            v1:SetAttribute("SkinLockedNodes", v7)
        end
    end
    if Geometry then
        local GlobalParts_2 = v1:FindFirstChild("GlobalParts")
        local BasePoints_3 = GlobalParts_2
        if BasePoints_3 then
            BasePoints_3 = GlobalParts_2:FindFirstChild("BasePoints")
        end
        if BasePoints_3 then
            local BasePart_2, Name_4, Weapon_3, v15, v16, v17, v18, v19, v20, v21, v22
            v3 = {}
            for i37, i38 in Geometry:GetChildren() do
                if i38:IsA("Model") then
                    Weapon_3 = v1:FindFirstChild("Weapon")
                    v10 = Weapon_3
                    if v10 then
                        Name_4 = i38.Name
                        v10 = Weapon_3:FindFirstChild(Name_4)
                    end
                    if not v10 then
                        for i39, i40 in i38:GetAttributes() do
                            if string.sub(i39, 1, 13) == "NodeOverride_" then
                                v16 = string.sub(i39, 14)
                                v17 = string.split(tostring(i40), ",")
                                if #v17 == 3 then
                                    v20 = v17[1]
                                    v18 = tonumber(v20) or 0
                                    v21 = v17[2]
                                    v19 = tonumber(v21) or 0
                                    v22 = v17[3]
                                    v21 = tonumber(v22)
                                    v3[v16] = (Vector3.new(v18, v19, v21 or 0))
                                end
                            end
                        end
                    else
                        BasePart_2 = v10:FindFirstChildWhichIsA("BasePart", true)
                        if not BasePart_2 then
                            for i41, i42 in i38:GetAttributes() do
                                if string.sub(i41, 1, 13) == "NodeOverride_" then
                                    v16 = string.sub(i41, 14)
                                    v17 = string.split(tostring(i42), ",")
                                    if #v17 == 3 then
                                        v20 = v17[1]
                                        v18 = tonumber(v20) or 0
                                        v21 = v17[2]
                                        v19 = tonumber(v21) or 0
                                        v22 = v17[3]
                                        v21 = tonumber(v22)
                                        v3[v16] = (Vector3.new(v18, v19, v21 or 0))
                                    end
                                end
                            end
                        elseif not BasePart_2:GetAttribute("OptionGroupHidden") then
                            for i43, i44 in i38:GetAttributes() do
                                if string.sub(i43, 1, 13) == "NodeOverride_" then
                                    v16 = string.sub(i43, 14)
                                    v17 = string.split(tostring(i44), ",")
                                    if #v17 == 3 then
                                        v20 = v17[1]
                                        v18 = tonumber(v20) or 0
                                        v21 = v17[2]
                                        v19 = tonumber(v21) or 0
                                        v22 = v17[3]
                                        v21 = tonumber(v22)
                                        v3[v16] = (Vector3.new(v18, v19, v21 or 0))
                                    end
                                end
                            end
                        end
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
            for i45, i46 in v5, v6, v7 do
                v10 = BasePoints_3:FindFirstChild(i45)
                if v10 and v10:IsA("BasePart") then
                    if not Handle_3 then
                        v15 = i46
                    else
                        v15 = Handle_3.CFrame:VectorToWorldSpace(i46)
                    end
                    v10.CFrame = (CFrame.new(v10.CFrame.Position + v15)) * v10.CFrame.Rotation
                end
            end
        end
    end
    v1.Parent = nil
end

return v1