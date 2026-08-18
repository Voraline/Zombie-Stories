return {
	["InitBar"] = function(p_u_1) -- name: InitBar
		local v_u_2 = nil
		v_u_2 = game:GetService("RunService").RenderStepped:Connect(function()
			-- upvalues: (copy) p_u_1, (ref) v_u_2
			if p_u_1.Parent then
				if p_u_1.Percentage.Value > 100 then
					p_u_1.Percentage.Value = 0
				end
				local v3 = p_u_1.Percentage.Value * 3.6
				local v4 = math.clamp(v3, 0, 360)
				local v5 = p_u_1.Frame1.ImageLabel
				local v6 = p_u_1.Frame2.ImageLabel
				v5.UIGradient.Rotation = p_u_1.FlipProgress.Value == false and math.clamp(v4, 180, 360) or 180 - math.clamp(v4, 0, 180)
				v6.UIGradient.Rotation = p_u_1.FlipProgress.Value == false and math.clamp(v4, 0, 180) or 180 - math.clamp(v4, 180, 360)
				v5.ImageColor3 = p_u_1.ImageColor.Value
				v6.ImageColor3 = p_u_1.ImageColor.Value
				v5.ImageTransparency = p_u_1.ImageTrans.Value
				v6.ImageTransparency = p_u_1.ImageTrans.Value
				v5.Image = "rbxassetid://" .. p_u_1.ImageId.Value
				v6.Image = "rbxassetid://" .. p_u_1.ImageId.Value
				if p_u_1.MissingPartType.Value == "Color" then
					v5.UIGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, p_u_1.ColorOfPercentPart.Value),
						ColorSequenceKeypoint.new(0.5, p_u_1.ColorOfPercentPart.Value),
						ColorSequenceKeypoint.new(0.501, p_u_1.ColorOfMissingPart.Value),
						ColorSequenceKeypoint.new(1, p_u_1.ColorOfMissingPart.Value)
					})
					v6.UIGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, p_u_1.ColorOfPercentPart.Value),
						ColorSequenceKeypoint.new(0.5, p_u_1.ColorOfPercentPart.Value),
						ColorSequenceKeypoint.new(0.501, p_u_1.ColorOfMissingPart.Value),
						ColorSequenceKeypoint.new(1, p_u_1.ColorOfMissingPart.Value)
					})
					v5.UIGradient.Transparency = NumberSequence.new(0)
					v6.UIGradient.Transparency = NumberSequence.new(0)
					return
				elseif p_u_1.MissingPartType.Value == "Trans" then
					v5.UIGradient.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.5, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.501, p_u_1.TransOfMissingPart.Value),
						NumberSequenceKeypoint.new(1, p_u_1.TransOfMissingPart.Value)
					})
					v6.UIGradient.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.5, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.501, p_u_1.TransOfMissingPart.Value),
						NumberSequenceKeypoint.new(1, p_u_1.TransOfMissingPart.Value)
					})
					v5.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
					v6.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
					return
				elseif p_u_1.MissingPartType.Value == "TransAndColor" then
					v5.UIGradient.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.5, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.501, p_u_1.TransOfMissingPart.Value),
						NumberSequenceKeypoint.new(1, p_u_1.TransOfMissingPart.Value)
					})
					v6.UIGradient.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.5, p_u_1.TransOfPercentPart.Value),
						NumberSequenceKeypoint.new(0.501, p_u_1.TransOfMissingPart.Value),
						NumberSequenceKeypoint.new(1, p_u_1.TransOfMissingPart.Value)
					})
					if v4 > 180 then
						v5.UIGradient.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, p_u_1.ColorOfPercentPart.Value),
							ColorSequenceKeypoint.new(0.5, p_u_1.ColorOfPercentPart.Value),
							ColorSequenceKeypoint.new(0.501, p_u_1.ColorOfMissingPart.Value),
							ColorSequenceKeypoint.new(1, p_u_1.ColorOfMissingPart.Value)
						})
					else
						v5.UIGradient.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, p_u_1.ColorOfMissingPart.Value),
							ColorSequenceKeypoint.new(0.5, p_u_1.ColorOfMissingPart.Value),
							ColorSequenceKeypoint.new(0.501, p_u_1.ColorOfMissingPart.Value),
							ColorSequenceKeypoint.new(1, p_u_1.ColorOfMissingPart.Value)
						})
					end
					v6.UIGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, p_u_1.ColorOfPercentPart.Value),
						ColorSequenceKeypoint.new(0.5, p_u_1.ColorOfPercentPart.Value),
						ColorSequenceKeypoint.new(0.501, p_u_1.ColorOfMissingPart.Value),
						ColorSequenceKeypoint.new(1, p_u_1.ColorOfMissingPart.Value)
					})
				else
					p_u_1.MissingPartType.Value = "Trans"
					error("Unknown Type. Only 3 available: \226\128\156Trans\226\128\157, \226\128\156Color\226\128\157 and \226\128\156TransAndColor\226\128\157, changing to \226\128\156Trans\226\128\157.")
				end
			else
				v_u_2:Disconnect()
				return
			end
		end)
	end
}