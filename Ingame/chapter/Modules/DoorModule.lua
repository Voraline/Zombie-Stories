return {
    OpenDoor = function(p1, p2, p3, p4, p5) -- Line: 3
        local v1 = p3 or 1
        local Quad = p4 or Enum.EasingStyle.Quad
        local Out = p5 or Enum.EasingDirection.Out
        local Children = p2:GetChildren()
        local OriginalCF = p2:FindFirstChild("OriginalCF")
        local OpenOffset = p2:FindFirstChild("OpenOffset")
        if not OpenOffset then
            print("Door " .. p2.Name .. " had no open offset")
            return
        end
        local Value = OpenOffset.Value
        if not OriginalCF then
            local Weld
            for k, v in pairs(Children) do
                if v:IsA("BasePart") then
                    if not p2.PrimaryPart then
                        p2.PrimaryPart = v
                    else
                        Weld = Instance.new("Weld")
                        Weld.Part0 = p2.PrimaryPart
                        Weld.Parent = p2.PrimaryPart
                        Weld.Part1 = v
                        Weld.C0 = (p2.PrimaryPart.CFrame:Inverse()) * v.CFrame
                        v.Anchored = false
                    end
                end
            end
            OriginalCF = Instance.new("CFrameValue")
            OriginalCF.Value = p2.PrimaryPart.CFrame
            OriginalCF.Name = "OriginalCF"
            OriginalCF.Parent = p2
        end
        local Value_2 = OriginalCF.Value
        local TweenService = game:GetService("TweenService")
        local PrimaryPart = p2.PrimaryPart
        local v2 = TweenInfo.new(v1, Quad, Out)
        local v3 = {CFrame = Value_2 + Value}
        TweenService:Create(PrimaryPart, v2, v3):Play()
    end,
    CloseDoor = function(p1, p2, p3, p4, p5) -- Line: 43
        local Quad = p4 or Enum.EasingStyle.Quad
        local Out = p5 or Enum.EasingDirection.Out
        local OriginalCF = p2:FindFirstChild("OriginalCF")
        if not OriginalCF then
            print("Door " .. p2.Name .. " had no original CFrame")
            return
        end
        local Value = OriginalCF.Value
        local TweenService = game:GetService("TweenService")
        local PrimaryPart = p2.PrimaryPart
        local v1 = TweenInfo.new(p3 or 1, Quad, Out)
        local v2 = {CFrame = Value}
        TweenService:Create(PrimaryPart, v1, v2):Play()
    end,
}