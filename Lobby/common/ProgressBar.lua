return {
    InitBar = function(p1) -- Line: 4
        local u1 = nil
        local v1 = (game:GetService("RunService")).RenderStepped:Connect(function() -- Line: 6 -- upvalues: p1 (val), u1 (ref)
            local v1, v2, v3, v4, v5
            if not p1.Parent then
                u1:Disconnect()
                return
            end
            if 100 < p1.Percentage.Value then
                p1.Percentage.Value = 0
            end
            local v6 = p1.Percentage.Value * 3.6
            local v7 = math.clamp(v6, 0, 360)
            local ImageLabel = p1.Frame1.ImageLabel
            local ImageLabel_2 = p1.Frame2.ImageLabel
            local UIGradient = ImageLabel.UIGradient
            if p1.FlipProgress.Value ~= false then
                v1 = 180 - math.clamp(v7, 0, 180)
            else
                v1 = math.clamp(v7, 180, 360)
                if not v1 then
                    v1 = 180 - math.clamp(v7, 0, 180)
                end
            end
            UIGradient.Rotation = v1
            local UIGradient_2 = ImageLabel_2.UIGradient
            if p1.FlipProgress.Value ~= false then
                v1 = 180 - math.clamp(v7, 180, 360)
            else
                v1 = math.clamp(v7, 0, 180)
                if not v1 then
                    v1 = 180 - math.clamp(v7, 180, 360)
                end
            end
            UIGradient_2.Rotation = v1
            ImageLabel.ImageColor3 = p1.ImageColor.Value
            ImageLabel_2.ImageColor3 = p1.ImageColor.Value
            ImageLabel.ImageTransparency = p1.ImageTrans.Value
            ImageLabel_2.ImageTransparency = p1.ImageTrans.Value
            ImageLabel.Image = "rbxassetid://" .. p1.ImageId.Value
            ImageLabel_2.Image = "rbxassetid://" .. p1.ImageId.Value
            if p1.MissingPartType.Value == "Color" then
                local UIGradient_3 = ImageLabel.UIGradient
                local new = ColorSequence.new
                v2 = {}
                v3 = ColorSequenceKeypoint.new(0, p1.ColorOfPercentPart.Value)
                v4 = ColorSequenceKeypoint.new(0.5, p1.ColorOfPercentPart.Value)
                v5 = ColorSequenceKeypoint.new(0.501, p1.ColorOfMissingPart.Value)
                v2[1] = v3
                v2[2] = v4
                v2[3] = v5
                v2[4] = ColorSequenceKeypoint.new(1, p1.ColorOfMissingPart.Value)
                UIGradient_3.Color = new(v2)
                local UIGradient_4 = ImageLabel_2.UIGradient
                local new_2 = ColorSequence.new
                v2 = {}
                v3 = ColorSequenceKeypoint.new(0, p1.ColorOfPercentPart.Value)
                v4 = ColorSequenceKeypoint.new(0.5, p1.ColorOfPercentPart.Value)
                v5 = ColorSequenceKeypoint.new(0.501, p1.ColorOfMissingPart.Value)
                v2[1] = v3
                v2[2] = v4
                v2[3] = v5
                v2[4] = ColorSequenceKeypoint.new(1, p1.ColorOfMissingPart.Value)
                UIGradient_4.Color = new_2(v2)
                ImageLabel.UIGradient.Transparency = NumberSequence.new(0)
                ImageLabel_2.UIGradient.Transparency = NumberSequence.new(0)
                return
            end
            if p1.MissingPartType.Value == "Trans" then
                local UIGradient_5 = ImageLabel.UIGradient
                local new_3 = NumberSequence.new
                v2 = {}
                v3 = NumberSequenceKeypoint.new(0, p1.TransOfPercentPart.Value)
                v4 = NumberSequenceKeypoint.new(0.5, p1.TransOfPercentPart.Value)
                v5 = NumberSequenceKeypoint.new(0.501, p1.TransOfMissingPart.Value)
                v2[1] = v3
                v2[2] = v4
                v2[3] = v5
                v2[4] = NumberSequenceKeypoint.new(1, p1.TransOfMissingPart.Value)
                UIGradient_5.Transparency = new_3(v2)
                local UIGradient_6 = ImageLabel_2.UIGradient
                local new_4 = NumberSequence.new
                v2 = {}
                v3 = NumberSequenceKeypoint.new(0, p1.TransOfPercentPart.Value)
                v4 = NumberSequenceKeypoint.new(0.5, p1.TransOfPercentPart.Value)
                v5 = NumberSequenceKeypoint.new(0.501, p1.TransOfMissingPart.Value)
                v2[1] = v3
                v2[2] = v4
                v2[3] = v5
                v2[4] = NumberSequenceKeypoint.new(1, p1.TransOfMissingPart.Value)
                UIGradient_6.Transparency = new_4(v2)
                ImageLabel.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
                ImageLabel_2.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
                return
            end
            if p1.MissingPartType.Value ~= "TransAndColor" then
                p1.MissingPartType.Value = "Trans"
                error("Unknown Type. Only 3 available: “Trans”, “Color” and “TransAndColor”, changing to “Trans”.")
                return
            end
            local UIGradient_7 = ImageLabel.UIGradient
            local new_5 = NumberSequence.new
            v2 = {}
            v3 = NumberSequenceKeypoint.new(0, p1.TransOfPercentPart.Value)
            v4 = NumberSequenceKeypoint.new(0.5, p1.TransOfPercentPart.Value)
            v5 = NumberSequenceKeypoint.new(0.501, p1.TransOfMissingPart.Value)
            v2[1] = v3
            v2[2] = v4
            v2[3] = v5
            v2[4] = NumberSequenceKeypoint.new(1, p1.TransOfMissingPart.Value)
            UIGradient_7.Transparency = new_5(v2)
            local UIGradient_8 = ImageLabel_2.UIGradient
            local new_6 = NumberSequence.new
            v2 = {}
            v3 = NumberSequenceKeypoint.new(0, p1.TransOfPercentPart.Value)
            v4 = NumberSequenceKeypoint.new(0.5, p1.TransOfPercentPart.Value)
            v5 = NumberSequenceKeypoint.new(0.501, p1.TransOfMissingPart.Value)
            v2[1] = v3
            v2[2] = v4
            v2[3] = v5
            v2[4] = NumberSequenceKeypoint.new(1, p1.TransOfMissingPart.Value)
            UIGradient_8.Transparency = new_6(v2)
            if not (180 < v7) then
                local UIGradient_10 = ImageLabel.UIGradient
                local new_8 = ColorSequence.new
                v2 = {}
                v3 = ColorSequenceKeypoint.new(0, p1.ColorOfMissingPart.Value)
                v4 = ColorSequenceKeypoint.new(0.5, p1.ColorOfMissingPart.Value)
                v5 = ColorSequenceKeypoint.new(0.501, p1.ColorOfMissingPart.Value)
                v2[1] = v3
                v2[2] = v4
                v2[3] = v5
                v2[4] = ColorSequenceKeypoint.new(1, p1.ColorOfMissingPart.Value)
                UIGradient_10.Color = new_8(v2)
            else
                local UIGradient_9 = ImageLabel.UIGradient
                local new_7 = ColorSequence.new
                v2 = {}
                v3 = ColorSequenceKeypoint.new(0, p1.ColorOfPercentPart.Value)
                v4 = ColorSequenceKeypoint.new(0.5, p1.ColorOfPercentPart.Value)
                v5 = ColorSequenceKeypoint.new(0.501, p1.ColorOfMissingPart.Value)
                v2[1] = v3
                v2[2] = v4
                v2[3] = v5
                v2[4] = ColorSequenceKeypoint.new(1, p1.ColorOfMissingPart.Value)
                UIGradient_9.Color = new_7(v2)
            end
            local UIGradient_11 = ImageLabel_2.UIGradient
            local new_9 = ColorSequence.new
            v2 = {}
            v3 = ColorSequenceKeypoint.new(0, p1.ColorOfPercentPart.Value)
            v4 = ColorSequenceKeypoint.new(0.5, p1.ColorOfPercentPart.Value)
            v5 = ColorSequenceKeypoint.new(0.501, p1.ColorOfMissingPart.Value)
            v2[1] = v3
            v2[2] = v4
            v2[3] = v5
            v2[4] = ColorSequenceKeypoint.new(1, p1.ColorOfMissingPart.Value)
            UIGradient_11.Color = new_9(v2)
        end)
    end,
}