local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = v1.common:WaitForChild("NPCs_Shared")
local v_u_4 = require(v1.common.PartCache)
local v_u_5 = require("@game/ReplicatedStorage/common/Settings")
local v_u_6 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_7 = nil
return {
	["Init"] = function() -- name: Init
		-- upvalues: (copy) v_u_6, (copy) v_u_5, (ref) v_u_7, (copy) v_u_3, (copy) v_u_4
		if v_u_6(v_u_5.Graphics.DisplayDamageIndicators) and not v_u_7 then
			local v8 = v_u_3.Resources.Misc.DamagePart
			v_u_7 = v_u_4.new(v8, 100, workspace.Ignore)
		end
	end,
	["Display"] = function(p9, p10) -- name: Display
		-- upvalues: (ref) v_u_7, (copy) v_u_6, (copy) v_u_5, (copy) v_u_2
		if v_u_7 and v_u_6(v_u_5.Graphics.DisplayDamageIndicators) then
			local v11 = p9.Position
			local v12 = string.find(p9.Name, "Head")
			local v_u_13 = v_u_7:GetPart()
			local v_u_14 = v_u_13:FindFirstChild("DamageText", true)
			v_u_14.Text = string.format("%.2f", p10)
			v_u_14.TextTransparency = 1
			v_u_14.TextStrokeTransparency = 1
			if v12 then
				v_u_14.Size = UDim2.fromScale(0.78, 0.78)
				v_u_14.TextColor3 = Color3.fromRGB(255, 71, 71)
			else
				v_u_14.Size = UDim2.fromScale(0.65, 0.65)
				v_u_14.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
			v_u_13.Position = v11
			local v15 = workspace.CurrentCamera.CFrame.lookVector:Cross(Vector3.new(0, 1, 0)) * (0.25 * (math.random(200) / 100))
			local v16 = 0.5 + math.random(100) / 100
			local v17 = Vector3.new(0, v16, 0)
			local v18 = {
				["Position"] = v11 + v15 + v17
			}
			v_u_2:Create(v_u_13, TweenInfo.new(0.25, Enum.EasingStyle.Back), v18):Play()
			local v19 = v_u_2:Create(v_u_14, TweenInfo.new(0.2), {
				["TextTransparency"] = 0,
				["TextStrokeTransparency"] = 0
			})
			v19:Play()
			v19.Completed:Connect(function(_)
				-- upvalues: (ref) v_u_2, (copy) v_u_14, (ref) v_u_7, (copy) v_u_13
				task.wait(2)
				local v20 = v_u_2:Create(v_u_14, TweenInfo.new(1), {
					["TextTransparency"] = 1,
					["TextStrokeTransparency"] = 1
				})
				v20:Play()
				v20.Completed:Wait()
				v_u_7:ReturnPart(v_u_13)
			end)
		end
	end
}