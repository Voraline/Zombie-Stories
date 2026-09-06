return {
    OpenDoor = function(p1, p2, p3, p4, p5) -- Line: 3
        local v1 = p3 or 1
        local Quad = p4
        if not Quad then
            Quad = Enum.EasingStyle.Quad
        end
        local Out = p5
        if not Out then
            Out = Enum.EasingDirection.Out
        end
        local Children = p2:GetChildren()
        local OriginalCF = p2:FindFirstChild("OriginalCF")
        local OpenOffset = p2:FindFirstChild("OpenOffset")
        if not OpenOffset then
            print("Door " .. p2.Name .. " had no open offset")
            return
        end
        local Value = OpenOffset.Value
        if not OriginalCF then
            local Weld, v2
            for k, v in pairs(Children) do
                if v:IsA("BasePart") then
                    if not p2.PrimaryPart then
                        p2.PrimaryPart = v
                    else
                        Weld = Instance.new("Weld")
                        Weld.Part0 = p2.PrimaryPart
                        Weld.Parent = p2.PrimaryPart
                        Weld.Part1 = v
                        v2 = p2.PrimaryPart.CFrame:Inverse()
                        Weld.C0 = v2 * v.CFrame
                        v.Anchored = false
                    end
                end
            end
            OriginalCF = Instance.new("CFrameValue")
            OriginalCF.Value = p2.PrimaryPart.CFrame
            OriginalCF.Name = "OriginalCF"
            OriginalCF.Parent = p2
        end
        local TweenService = game:GetService("TweenService")
        local v3 = TweenInfo.new(v1, Quad, Out)
        TweenService:Create(p2.PrimaryPart, v3, {CFrame = OriginalCF.Value + Value}):Play()
    end,
    CloseDoor = function(p1, p2, p3, p4, p5) -- Line: 43
        local Quad = p4
        if not Quad then
            Quad = Enum.EasingStyle.Quad
        end
        local Out = p5
        if not Out then
            Out = Enum.EasingDirection.Out
        end
        local OriginalCF = p2:FindFirstChild("OriginalCF")
        if not OriginalCF then
            print("Door " .. p2.Name .. " had no original CFrame")
            return
        end
        local TweenService = game:GetService("TweenService")
        local v1 = TweenInfo.new(p3 or 1, Quad, Out)
        TweenService:Create(p2.PrimaryPart, v1, {CFrame = OriginalCF.Value}):Play()
    end,
}