local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Assets = (ReplicatedStorage.common:WaitForChild("SharedResources")):WaitForChild("Assets")
local Controllers = script.Parent.Parent.Parent.Parent.Controllers
local u25 = nil

local function GetTransparencyUtil() -- Line: 23 -- upvalues: u25 (ref), Controllers (val)
    if u25 then
        return u25
    end
    local CameraController = Controllers:FindFirstChild("CameraController")
    if CameraController then
        local CameraUtils = CameraController:FindFirstChild("CameraUtils")
        if CameraUtils then
            local TransparencyUtil = CameraUtils:FindFirstChild("TransparencyUtil")
            if TransparencyUtil then
                u25 = require(TransparencyUtil)
            end
        end
    end
    return u25
end

local v1 = {}

local function GetPlayerAppearance() -- Line: 42 -- upvalues: Players (val)
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer
    if Character then
        Character = LocalPlayer.Character
    end
    local Color = Color3.fromRGB(255, 204, 153)
    local ShirtTemplate = nil
    if Character then
        local BodyColors = Character:FindFirstChildOfClass("BodyColors")
        if not BodyColors then
            local v1 = Character:FindFirstChild("Right Arm")
            if v1 then
                Color = v1.Color
            end
        else
            local RightArmColor3 = BodyColors.RightArmColor3
            if not RightArmColor3 then
                RightArmColor3 = BodyColors.LeftArmColor3
                if not RightArmColor3 then
                    RightArmColor3 = Color
                end
            end
            Color = RightArmColor3
        end
        local Shirt = Character:FindFirstChildOfClass("Shirt")
        if Shirt and Shirt.ShirtTemplate and Shirt.ShirtTemplate ~= "" then
            ShirtTemplate = Shirt.ShirtTemplate
        end
    end
    return Color, ShirtTemplate
end

local function ApplyPlayerAppearance(p1) -- Line: 73 -- upvalues: GetPlayerAppearance (val)
    local v1, v2 = GetPlayerAppearance()
    p1.Color = v1
    local Clothing = p1:FindFirstChild("Clothing")
    if Clothing and Clothing:IsA("Decal") then
        if v2 then
            Clothing.Texture = v2
            return
        end
        Clothing.Transparency = 1
    end
end

local u30 = {RightHidden = false, LeftHidden = false}

local function HideRealArms(p1, p2) -- Line: 101 -- upvalues: Players (val), u25 (ref), Controllers (val), u30 (val)
    local v1, v2
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer
    if Character then
        Character = LocalPlayer.Character
    end
    if not Character then
        return
    end
    if not u25 then
        local CameraController = Controllers:FindFirstChild("CameraController")
        if CameraController then
            local CameraUtils = CameraController:FindFirstChild("CameraUtils")
            if CameraUtils then
                local TransparencyUtil = CameraUtils:FindFirstChild("TransparencyUtil")
                if TransparencyUtil then
                    u25 = require(TransparencyUtil)
                end
            end
        end
        v1 = u25
    else
        v1 = u25
    end
    if p1 then
        v2 = Character:FindFirstChild("Right Arm")
        if v2 then
            v2.LocalTransparencyModifier = 1
            u30.RightArm = v2
            u30.RightHidden = true
            if v1 and v1.CustomList then
                v1.CustomList["Right Arm"] = 1
            end
        end
    end
    if p2 then
        v2 = Character:FindFirstChild("Left Arm")
        if v2 then
            v2.LocalTransparencyModifier = 1
            u30.LeftArm = v2
            u30.LeftHidden = true
            if v1 and v1.CustomList then
                v1.CustomList["Left Arm"] = 1
            end
        end
    end
end

local function ShowRealArms(p1, p2) -- Line: 138 -- upvalues: u25 (ref), Controllers (val), u30 (val)
    local v1
    if not u25 then
        local CameraController = Controllers:FindFirstChild("CameraController")
        if CameraController then
            local CameraUtils = CameraController:FindFirstChild("CameraUtils")
            if CameraUtils then
                local TransparencyUtil = CameraUtils:FindFirstChild("TransparencyUtil")
                if TransparencyUtil then
                    u25 = require(TransparencyUtil)
                end
            end
        end
        v1 = u25
    else
        v1 = u25
    end
    if p1 and u30.RightHidden then
        if u30.RightArm and u30.RightArm.Parent then
            u30.RightArm.LocalTransparencyModifier = 0
        end
        u30.RightHidden = false
        u30.RightArm = nil
        if v1 and v1.CustomList then
            v1.CustomList["Right Arm"] = 0
        end
    end
    if p2 and u30.LeftHidden then
        if u30.LeftArm and u30.LeftArm.Parent then
            u30.LeftArm.LocalTransparencyModifier = 0
        end
        u30.LeftHidden = false
        u30.LeftArm = nil
        if v1 and v1.CustomList then
            v1.CustomList["Left Arm"] = 0
        end
    end
end

local u33 = {}

local function GetArmTemplate(p1) -- Line: 174 -- upvalues: u33 (val), Assets (val)
    if u33[p1] then
        return u33[p1]
    end
    local v1 = p1 .. "Arm"
    local v2 = Assets:FindFirstChild(v1)
    if v2 then
        u33[p1] = v2
        return v2
    end
    warn("[ArmModelUtil] Could not find arm template: " .. v1)
    return nil
end

v1.ViewmodelArms = {}

function v1.AttachArms(p1, p2, p3, p4, p5) -- Line: 204
    -- upvalues: HideRealArms (val), u33 (val), Assets (val), GetPlayerAppearance (val)
    local Name, v1, v2
    local v3 = print
    local format = string.format
    local v4 = "[ArmModelUtil-DEBUG] AttachArms called: viewmodel=%s, attachRight=%s, attachLeft=%s, mirrorLeft=%s"
    if not p2 then
        Name = "nil"
    else
        Name = p2.Name
        if not Name then
            Name = "nil"
        end
    end
    local v5 = tostring(p3)
    local v6 = tostring(p4)
    v3(format(v4, Name, v5, v6, (tostring(p5))))
    if not p2 then
        warn("[ArmModelUtil] Cannot attach arms - viewmodel is nil")
        return {}
    end
    p1:DetachArms(p2)
    HideRealArms(p3, p4)
    v3 = {}
    if p3 then
        v1 = p2:FindFirstChild("Right Arm")
        if v1 then
            local Right
            if not u33.Right then
                local RightArm = Assets:FindFirstChild("RightArm")
                if not RightArm then
                    warn("[ArmModelUtil] Could not find arm template: RightArm")
                    Right = nil
                else
                    u33.Right = RightArm
                    Right = RightArm
                end
            else
                Right = u33.Right
            end
            if Right then
                v2 = Right:Clone()
                v2.Name = "ArmModel_Right"
                v2.CanCollide = false
                v2.Anchored = false
                v5, v6 = GetPlayerAppearance()
                v2.Color = v5
                local Clothing = v2:FindFirstChild("Clothing")
                if Clothing and Clothing:IsA("Decal") then
                    if not v6 then
                        Clothing.Transparency = 1
                    else
                        Clothing.Texture = v6
                    end
                end
                local Motor6D = Instance.new("Motor6D")
                Motor6D.Name = "ArmModelWeld"
                Motor6D.Part0 = v1
                Motor6D.Part1 = v2
                Motor6D.C0 = CFrame.new(0, 0, 0)
                Motor6D.C1 = CFrame.new(0, 0, 0)
                Motor6D.Parent = v2
                v2.Parent = p2
                v3.Right = v2
                v3.RightWeld = Motor6D
            end
        end
    end
    if p4 then
        local Right_2
        if not p5 then
            v1 = p2:FindFirstChild("Left Arm")
            if not u33.Left then
                local LeftArm = Assets:FindFirstChild("LeftArm")
                if not LeftArm then
                    warn("[ArmModelUtil] Could not find arm template: LeftArm")
                    Right_2 = nil
                else
                    u33.Left = LeftArm
                    Right_2 = LeftArm
                end
            else
                Right_2 = u33.Left
            end
        else
            v1 = p2:FindFirstChild("Right Arm")
            if not u33.Right then
                local RightArm_2 = Assets:FindFirstChild("RightArm")
                if not RightArm_2 then
                    warn("[ArmModelUtil] Could not find arm template: RightArm")
                    Right_2 = nil
                else
                    u33.Right = RightArm_2
                    Right_2 = RightArm_2
                end
            else
                Right_2 = u33.Right
            end
        end
        if v1 and Right_2 then
            v2 = Right_2:Clone()
            v2.Name = "ArmModel_Left"
            v2.CanCollide = false
            v2.Anchored = false
            if p5 then
                local FileMesh = v2:FindFirstChildOfClass("FileMesh")
                if not FileMesh then
                    FileMesh = v2:FindFirstChildOfClass("SpecialMesh")
                end
                if FileMesh then
                    FileMesh.Scale = Vector3.new(-1, 1, 1)
                end
            end
            v5, v6 = GetPlayerAppearance()
            v2.Color = v5
            local Clothing_2 = v2:FindFirstChild("Clothing")
            if Clothing_2 and Clothing_2:IsA("Decal") then
                if not v6 then
                    Clothing_2.Transparency = 1
                else
                    Clothing_2.Texture = v6
                end
            end
            local Motor6D_2 = Instance.new("Motor6D")
            Motor6D_2.Name = "ArmModelWeld"
            Motor6D_2.Part0 = v1
            Motor6D_2.Part1 = v2
            if not p5 then
                Motor6D_2.C0 = CFrame.new(0, 0, 0)
            else
                Motor6D_2.C0 = CFrame.Angles(0, -3.141592653589793, 0)
            end
            Motor6D_2.C1 = CFrame.new(0, 0, 0)
            Motor6D_2.Parent = v2
            v2.Parent = p2
            v3.Left = v2
            v3.LeftWeld = Motor6D_2
        end
    end
    p1.ViewmodelArms[p2] = v3
    v1 = print
    local format_2 = string.format
    if not v3.Right then
        v5 = "none"
    else
        v5 = "attached"
    end
    if not v3.Left then
        v6 = "none"
    else
        v6 = "attached"
    end
    v1(format_2("[ArmModelUtil-DEBUG] AttachArms complete: Right=%s, Left=%s", v5, v6))
    return v3
end

function v1:DetachArms(p2) -- Line: 333 -- upvalues: ShowRealArms (val)
    local v1 = self.ViewmodelArms[p2]
    if not v1 then
        return
    end
    local v2 = v1.Right ~= nil
    local v3 = v1.Left ~= nil
    if v1.Right then
        v1.Right:Destroy()
    end
    if v1.Left then
        v1.Left:Destroy()
    end
    self.ViewmodelArms[p2] = nil
    ShowRealArms(v2, v3)
end

function v1.GetArms(p1, p2) -- Line: 363
    return p1.ViewmodelArms[p2]
end

function v1.HasArms(p1, p2) -- Line: 373
    local v1 = p1.ViewmodelArms[p2]
    local v2 = false
    if v1 ~= nil then
        v2 = true
        if v1.Right == nil then
            v2 = v1.Left ~= nil
        end
    end
    return v2
end

function v1.SetArmVisibility(p1, p2, p3, p4) -- Line: 385
    local v1
    local v2 = p1.ViewmodelArms[p2]
    if not v2 then
        return
    end
    if v2.Right then
        local Right = v2.Right
        if not p3 then
            v1 = 1
        else
            v1 = 0
        end
        Right.Transparency = v1
    end
    if v2.Left then
        local Left = v2.Left
        if not p4 then
            v1 = 1
        else
            v1 = 0
        end
        Left.Transparency = v1
    end
end

return v1