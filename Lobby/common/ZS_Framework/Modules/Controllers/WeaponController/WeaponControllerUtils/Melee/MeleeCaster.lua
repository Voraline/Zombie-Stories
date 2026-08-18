local v1 = {}
local v_u_2 = workspace.CurrentCamera
local v_u_3 = require(script.Parent.Parent.Parent.Parent.Parent:WaitForChild("Utils"):WaitForChild("RaycastUtil"))
local v_u_4 = require("../../../LocalPlayerController")
function v1.StartCast(_, p5, p6, p7) -- name: StartCast
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3
	local v8 = p5.raysbeforedelay or 4
	local v9 = p5.num_rays or v8 * 5
	local v10 = p5.delaytime or 0
	local v11 = p5.max_dist or 9
	local v12 = p5.min_dist or 7
	local v13 = p5.direction or 1
	local v14 = (p5.yaw or 70) * v13
	local v15 = (p5.pitch or 0) * v13
	local v16 = p5.num_times or 1
	local v17 = p5.multi_data
	local v18 = 0
	p7.TimesHitEnemy.IgnoreTable = {}
	local v19 = p7.TimesHitEnemy.IgnoreTable
	local v20
	if p7.DoingHeavy or not p7.SwingRPMScaling then
		v20 = 1
	else
		local v21 = p7.Config
		local v22 = p7.DoingHeavy and v21.HeavySwingStart or v21.SwingStart
		local v23 = p7.DoingHeavy and v21.HeavySwingEnd or v21.SwingEnd
		local v24 = p7.DoingHeavy and v21.HeavyDelayPerShot or v21.DelayPerShot
		v20 = (v24 == 0 and 1 or v24) / (v22 + v23)
	end
	local v25 = game.Players.LocalPlayer.Character.Head
	for v26 = 1, v16 do
		if v17 then
			local v27 = v17[v26]
			local v28 = setmetatable(v27, p5)
			v8 = v28.raysbeforedelay or 4
			v9 = v28.num_rays or v8 * 5
			v10 = v28.delaytime or 0
			v11 = v28.max_dist or 9
			v12 = v28.min_dist or 7
			v13 = v28.direction or 1
			v14 = (v28.yaw or 70) * v13
			v15 = (v28.pitch or 0) * v13
			local _ = v28.num_times or 1
		end
		for v29 = 1, v9 do
			if not (p7 and p7.IsEquipped) then
				break
			end
			local v30 = v29 * math.rad(v14) / v9
			local v31 = v29 * math.rad(v15) / v9
			local v32 = v14 / 2
			local v33 = v30 - math.rad(v32)
			local v34 = v15 / 2
			local v35 = v31 - math.rad(v34)
			local v36 = (v29 - 1) / (v9 / 2 - 1) * (v9 - v29) / (v9 - v9 / 2)
			local v37 = v12 * (1 - v36) + v11 * v36
			local v38
			if v_u_4.ThirdPerson then
				v38 = v25.CFrame
			else
				v38 = v_u_2.CFrame
			end
			local v39 = v38.Position
			local v40 = (v38 * CFrame.Angles(v35, v33, 0)).LookVector.Unit * v37
			while true do
				if true then
					local v41 = v_u_3.StandardCast
					local v42
					if #v19 > 0 then
						v42 = v19
					else
						v42 = nil
					end
				end
				local v43 = v41(v39, v40, v42)
				if not (v43 and string.find(v43.Instance.Name, "HITBOX_ARMOR")) then
					break
				end
				local v44 = v43.Instance.Parent
				if p7.Config.Penetration < (v44:GetAttribute("ArmorLevel") or 1) then
					break
				end
				table.insert(v19, v44)
			end
			local v45
			if workspace:GetAttribute("DebugMelee") then
				v45 = Instance.new("Part")
				v45.Anchored = true
				v45.CanCollide = false
				v45.CanQuery = false
				v45.CastShadow = false
				v45.BrickColor = not v43 and BrickColor.new("New Yeller") or BrickColor.new("Really red")
				v45.Material = Enum.Material.ForceField
				v45.Size = Vector3.new(0.2, 0.2, v37)
				v45.CFrame = CFrame.new(v39 - Vector3.new(0, 1, 0), v39 + v40) * CFrame.new(0, 0, -v37 / 2)
				game.Debris:AddItem(v45, 3)
				v45.Parent = workspace.Ignore
			else
				v45 = nil
			end
			if v43 then
				p6:Fire(v39, v43, p7, v45)
			end
			v18 = v18 + 1
			if v8 <= v18 then
				task.wait(v10 * v20)
				v18 = 0
			end
		end
		p7.TimesHitEnemy = {}
		v13 = v13 * -1
		v14 = v14 * v13
		v15 = v15 * v13
	end
end
return v1