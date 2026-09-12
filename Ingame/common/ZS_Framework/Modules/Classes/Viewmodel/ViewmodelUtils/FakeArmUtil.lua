workspace:WaitForChild("Ignore")
local TweenService = game:GetService("TweenService")
local u10 = nil
local u11 = nil
local u12 = nil
local u13 = {Arms = nil, ArmOwners = {}}

function u13.Hide(p1, p2) -- Line: 21 -- upvalues: u10 (ref), TweenService (val)
    if u10 then
        local v1, v2, v3, v4, v5, v6, v7
        local v8 = p1.ArmOwners.Left == p2
        local v9 = p1.ArmOwners.Right == p2
        local CFrame_2 = p2.PrimaryPart.CFrame
        local v10 = u10
        local CFrame_3 = v10.LeftShoulder.Part0.CFrame
        local v11 = CFrame_2:ToObjectSpace(CFrame_3)
        if v8 then
            u10.LeftWeld.Enabled = false
            v4 = u10
            local LeftShoulderC0 = v4.LeftShoulderC0
            v10 = u10
            local LeftShoulder_2 = v10.LeftShoulder
            LeftShoulder_2.C0 = (u10.LeftShoulder.Part0.CFrame:Inverse()) * p2.PrimaryPart.CFrame * v11
            v10 = u10
            local CFrame_4 = v10.LeftShoulder.Part0.CFrame
            local new = CFrame.new
            v7 = u10
            v6 = new(v7.LeftShoulder.C0.Position)
            v10 = CFrame_4:toWorldSpace(v6)
            u10.LeftShoulder.C0 = u10.LeftShoulder.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
            v5 = (CFrame.lookAt(v10.Position, u10.LeftShoulder.Part0.CFrame.Position, u10.Left.CFrame.UpVector)) * CFrame.Angles(1.5707963267948966, 0, 0)
            u10.LeftShoulder.C0 = u10.LeftShoulder.Part0.CFrame:toObjectSpace(v5)
            u10.LeftShoulder.Enabled = true
            v6 = TweenService
            v1 = u10
            local LeftShoulder_5 = v1.LeftShoulder
            v2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v3 = {C0 = LeftShoulderC0}
            v6:Create(LeftShoulder_5, v2, v3):Play()
            p1.ArmOwners.Left = nil
        end
        if v9 then
            u10.RightWeld.Enabled = false
            v4 = u10
            local RightShoulderC0 = v4.RightShoulderC0
            v10 = u10
            local RightShoulder = v10.RightShoulder
            RightShoulder.C0 = (u10.RightShoulder.Part0.CFrame:Inverse()) * p2.PrimaryPart.CFrame * v11
            v10 = u10
            local CFrame_5 = v10.RightShoulder.Part0.CFrame
            local new_2 = CFrame.new
            v7 = u10
            v6 = new_2(v7.RightShoulder.C0.Position)
            v10 = CFrame_5:toWorldSpace(v6)
            u10.RightShoulder.C0 = u10.RightShoulder.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
            v5 = (CFrame.lookAt(v10.Position, u10.RightShoulder.Part0.CFrame.Position, u10.Right.CFrame.UpVector)) * CFrame.Angles(1.5707963267948966, 0, 0)
            u10.RightShoulder.C0 = u10.RightShoulder.Part0.CFrame:toObjectSpace(v5)
            u10.RightShoulder.Enabled = true
            v6 = TweenService
            v1 = u10
            local RightShoulder_4 = v1.RightShoulder
            v2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v3 = {C0 = RightShoulderC0}
            v6:Create(RightShoulder_4, v2, v3):Play()
            p1.ArmOwners.Right = nil
        end
    end
end

function u13:Show(p2) -- Line: 71 -- upvalues: u11 (ref), u12 (ref), u10 (ref), u13 (val)
    local LeftWeld, RightWeld, v1
    u11 = p2
    local v2 = p2["Left Arm"]
    local v3 = 3 < v2.Size.Y
    local Character = game.Players.LocalPlayer.Character
    if not Character then
        Character = game.Players.LocalPlayer.CharacterAdded:Wait()
    end
    if Character ~= u12 then
        u12 = Character
        if u10 then
            u10.LeftWeld:Destroy()
            u10.RightWeld:Destroy()
            u10.LeftShoulder.Enabled = true
            u10.RightShoulder.Enabled = true
            u10 = nil
            u13.Arms = nil
        end
        self.ArmOwners.Left = nil
        self.ArmOwners.Right = nil
    end
    if u11 ~= p2 then
        return
    end
    if u10 then
        for k, n in v2.Parent:QueryDescendants("Motor6D") do
            if n.Part1 == v2 then
                u10.OGLArmWeld = n
                break
            end
        end
        u10.LeftShoulder.Enabled = false
        u10.RightShoulder.Enabled = false
        u10.LeftWeld.Enabled = true
        u10.RightWeld.Enabled = true
        u10.LeftWeld.Part0 = v2
        u10.RightWeld.Part0 = p2:WaitForChild("Right Arm")
        u10.MoveCF = v3
        LeftWeld = u10.LeftWeld
        if not v3 then
            v1 = CFrame.new()
        else
            v1 = CFrame.new(0, 1, 0)
            if not v1 then
                v1 = CFrame.new()
            end
        end
        LeftWeld.C1 = v1
        RightWeld = u10.RightWeld
        if not v3 then
            v1 = CFrame.new()
        else
            v1 = CFrame.new(0, 1, 0)
            if not v1 then
                v1 = CFrame.new()
            end
        end
        RightWeld.C1 = v1
        u13.Arms = u10
        self.ArmOwners.Left = p2
        self.ArmOwners.Right = p2
        return u10
    end
    local v4 = u12:WaitForChild("Left Arm", 5)
    if not v4 then
        return
    end
    v1 = u12:WaitForChild("Right Arm", 5)
    if not v1 then
        return
    end
    local Torso = u12:WaitForChild("Torso", 5)
    if not Torso then
        return
    end
    local v5 = Torso:WaitForChild("Left Shoulder", 5)
    local v6 = Torso:WaitForChild("Right Shoulder", 5)
    if u11 == p2 and u12.Parent and v5 and v6 then
        local v7 = {}
        local Motor6D = Instance.new("Motor6D")
        Motor6D.Part1 = v4
        Motor6D.Parent = v4
        local Motor6D_2 = Instance.new("Motor6D")
        Motor6D_2.Part1 = v1
        Motor6D_2.Parent = v1
        v7.LeftWeld = Motor6D
        v7.RightWeld = Motor6D_2
        v7.LeftShoulder = v5
        v7.RightShoulder = v6
        v7.LeftShoulderC0 = v5.C0
        v7.RightShoulderC0 = v6.C0
        v7.Left = v4
        v7.Right = v1
        u10 = v7
        for i, j in v2.Parent:QueryDescendants("Motor6D") do
            if j.Part1 == v2 then
                u10.OGLArmWeld = j
                break
            end
        end
        u10.LeftShoulder.Enabled = false
        u10.RightShoulder.Enabled = false
        u10.LeftWeld.Enabled = true
        u10.RightWeld.Enabled = true
        u10.LeftWeld.Part0 = v2
        u10.RightWeld.Part0 = p2:WaitForChild("Right Arm")
        u10.MoveCF = v3
        LeftWeld = u10.LeftWeld
        if not v3 then
            v1 = CFrame.new()
        else
            v1 = CFrame.new(0, 1, 0)
            if not v1 then
                v1 = CFrame.new()
            end
        end
        LeftWeld.C1 = v1
        RightWeld = u10.RightWeld
        if not v3 then
            v1 = CFrame.new()
        else
            v1 = CFrame.new(0, 1, 0)
            if not v1 then
                v1 = CFrame.new()
            end
        end
        RightWeld.C1 = v1
        u13.Arms = u10
        self.ArmOwners.Left = p2
        self.ArmOwners.Right = p2
        return u10
    end
end

function u13:SetArmOwner(p2, p3) -- Line: 159 -- upvalues: u10 (ref)
    local v1, v2, v3
    if not u10 then
        return
    end
    self.ArmOwners[p2] = p3
    if p2 == "Left" then
        v1 = p3:FindFirstChild("Left Arm")
        if not v1 then
            v1 = p3:FindFirstChild("Left Arm", true)
        end
        if not v1 then
            return
        end
        u10.LeftWeld.Part0 = v1
        v2 = 3 < v1.Size.Y
        local LeftWeld = u10.LeftWeld
        if not v2 then
            v3 = CFrame.new()
        else
            v3 = CFrame.new(0, 1, 0)
            if not v3 then
                v3 = CFrame.new()
            end
        end
        LeftWeld.C1 = v3
        return
    end
    if p2 == "Right" then
        v1 = p3:FindFirstChild("Right Arm")
        if not v1 then
            v1 = p3:FindFirstChild("Right Arm", true)
        end
        if v1 then
            u10.RightWeld.Part0 = v1
            v2 = 3 < v1.Size.Y
            local RightWeld = u10.RightWeld
            if not v2 then
                v3 = CFrame.new()
            else
                v3 = CFrame.new(0, 1, 0)
                if not v3 then
                    v3 = CFrame.new()
                end
            end
            RightWeld.C1 = v3
        end
    end
end

function u13.OwnsArm(p1, p2, p3) -- Line: 187
    local v1 = p1.ArmOwners[p3] == p2
    return v1
end

function u13.GetArmOwner(p1, p2) -- Line: 194
    return p1.ArmOwners[p2]
end

function u13.ReleaseArm(p1, p2) -- Line: 200
    p1.ArmOwners[p2] = nil
end

function u13.ShowForArms(p1, p2, p3, p4) -- Line: 208 -- upvalues: u10 (ref), u12 (ref), u13 (val)
    local Character = game.Players.LocalPlayer.Character
    if u10 and Character ~= u12 then
        u10 = nil
        u13.Arms = nil
    end
    if not u10 then
        p1:Show(p2)
        if not p3 then
            p1.ArmOwners.Left = nil
        end
        if not p4 then
            p1.ArmOwners.Right = nil
        end
        return u10
    end
    if p3 then
        p1:SetArmOwner("Left", p2)
        local v1 = p2:FindFirstChild("Left Arm")
        if not v1 then
            v1 = p2:FindFirstChild("Left Arm", true)
        end
        if v1 then
            for i, j in v1.Parent:QueryDescendants("Motor6D") do
                if j.Part1 == v1 then
                    u10.OGLArmWeld = j
                    break
                end
            end
        end
    end
    if p4 then
        p1:SetArmOwner("Right", p2)
    end
    return u10
end

return u13