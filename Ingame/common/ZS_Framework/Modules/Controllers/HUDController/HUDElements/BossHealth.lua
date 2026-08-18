game:GetService("TweenService")
local v1 = script:WaitForChild("BossHealth")
local v_u_2 = v1:WaitForChild("MainFrame")
local v_u_3 = v_u_2:WaitForChild("Template")
local v4 = game.ReplicatedStorage.common
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_5 = require(v4:WaitForChild("NPCRegistry"))
local v_u_6 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/StatusEffect_Util")
local v_u_7 = Color3.fromRGB(255, 120, 120)
local v_u_8 = Color3.fromRGB(255, 162, 2)
local v_u_9 = Color3.fromRGB(120, 255, 120)
v1.Parent = game.Players.LocalPlayer.PlayerGui
local v_u_30 = {
	["IsShowing"] = false,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_30, (copy) v_u_2
		v_u_30.IsShowing = true
		v_u_2:TweenPosition(UDim2.new(0.5, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_30, (copy) v_u_2
		v_u_30.IsShowing = false
		v_u_2:TweenPosition(UDim2.new(0.5, 0, -0.5, -36), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	end,
	["AddBoss"] = function(_, p10, p_u_11) -- name: AddBoss
		-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_2, (copy) v_u_6, (copy) v_u_9, (copy) v_u_8, (copy) v_u_7
		local v_u_12 = v_u_5:WaitForNPC(p10)
		if v_u_12 ~= nil then
			task.defer(function()
				-- upvalues: (copy) v_u_12, (ref) p_u_11, (ref) v_u_3, (ref) v_u_2, (ref) v_u_6, (ref) v_u_9, (ref) v_u_8, (ref) v_u_7
				if (v_u_12.new ~= nil or v_u_12.IsCompat) and not v_u_12.IsDead then
					local v13
					if p_u_11 == nil then
						v13 = v_u_12.Name
					else
						v13 = p_u_11
					end
					p_u_11 = v13
					local v_u_14 = v_u_12.MaxHP
					local v_u_15 = v_u_3:Clone()
					local v_u_16 = v_u_15:WaitForChild("HealthBar"):WaitForChild("Bar")
					local v_u_17 = v_u_15:WaitForChild("Status")
					v_u_15.Visible = true
					v_u_15.NameLabel.Text = p_u_11
					v_u_15.Parent = v_u_2
					if v_u_12.CurrentEffects then
						for _, v18 in v_u_12.CurrentEffects() do
							v_u_6.GetIconLabel(v18).Parent = v_u_17
						end
					end
					local function v22(p19) -- name: updateHealth
						-- upvalues: (copy) v_u_14, (copy) v_u_16, (ref) v_u_9, (ref) v_u_8, (ref) v_u_7
						local v20 = p19 / v_u_14
						local v21 = math.max(v20, 0)
						v_u_16:TweenSize(UDim2.new(v21, 0, 1, 0), nil, nil, 0.25, true)
						if v21 > 0.6 then
							v_u_16.BackgroundColor3 = v_u_9
							return
						elseif v21 > 0.3 then
							v_u_16.BackgroundColor3 = v_u_8
						else
							v_u_16.BackgroundColor3 = v_u_7
						end
					end
					local function v25(p23, p24) -- name: updateStatus
						-- upvalues: (copy) v_u_17, (ref) v_u_6
						if p23 == "Apply" then
							if v_u_17:FindFirstChild(p24._Name) then
								v_u_17[p24._Name]:Destroy()
							end
							v_u_6.GetIconLabel(p24).Parent = v_u_17
						else
							local _ = p23 == "Remove"
						end
					end
					local v_u_26 = v_u_12.HealthChanged:Connect(v22)
					local v_u_27 = v_u_12.StatusUpdated:Connect(v25)
					v22(v_u_12.HP)
					local v_u_28 = nil
					local v_u_29 = nil
					v_u_29 = v_u_12.Died:Connect(function()
						-- upvalues: (copy) v_u_26, (ref) v_u_29, (ref) v_u_28, (copy) v_u_15, (copy) v_u_27
						v_u_26:Disconnect()
						v_u_29:Disconnect()
						v_u_28:Disconnect()
						v_u_15:Destroy()
						v_u_27:Disconnect()
					end)
					v_u_28 = v_u_12.Destroyed:Connect(function()
						-- upvalues: (copy) v_u_26, (ref) v_u_29, (ref) v_u_28, (copy) v_u_15
						v_u_26:Disconnect()
						v_u_29:Disconnect()
						v_u_28:Disconnect()
						v_u_15:Destroy()
					end)
				end
			end)
		end
	end
}
return v_u_30