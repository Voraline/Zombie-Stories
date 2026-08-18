local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage").Packages
local v_u_3 = require(v2.Fusion)
local v_u_4 = v_u_3.Children
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	local v6 = p5.scope
	local v_u_7 = v6:Value(1)
	local v8 = v6:New("ScreenGui")
	local v9 = {
		["Name"] = "FadeFrame",
		["DisplayOrder"] = 100,
		["IgnoreGuiInset"] = true,
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		[v_u_4] = { v6:New("Frame")({
				["Name"] = "Overlay",
				["BackgroundColor3"] = nil,
				["BackgroundTransparency"] = nil,
				["BorderSizePixel"] = 0,
				["Size"] = nil,
				["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
				["BackgroundTransparency"] = v_u_7,
				["Size"] = UDim2.fromScale(1, 1)
			}) }
	}
	local v10 = v8(v9)
	v10.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
	return {
		["gui"] = v10,
		["transparency"] = v_u_7,
		["fadeIn"] = function(_, p11, p_u_12) -- name: fadeIn
			-- upvalues: (ref) v_u_3, (copy) v_u_7
			local v_u_13 = p11 or 0.4
			local v_u_14 = v_u_3.peek(v_u_7)
			local v_u_15 = 0
			task.spawn(function()
				-- upvalues: (ref) v_u_15, (copy) v_u_13, (ref) v_u_7, (copy) v_u_14, (copy) p_u_12
				while v_u_15 < v_u_13 do
					v_u_15 = v_u_15 + task.wait()
					local v16 = v_u_15 / v_u_13
					local v17 = 1 - (1 - math.min(v16, 1)) ^ 2
					v_u_7:set(v_u_14 + (0 - v_u_14) * v17)
				end
				v_u_7:set(0)
				if p_u_12 then
					p_u_12()
				end
			end)
		end,
		["fadeOut"] = function(_, p18, p_u_19) -- name: fadeOut
			-- upvalues: (ref) v_u_3, (copy) v_u_7
			local v_u_20 = p18 or 0.4
			local v_u_21 = v_u_3.peek(v_u_7)
			local v_u_22 = 0
			task.spawn(function()
				-- upvalues: (ref) v_u_22, (copy) v_u_20, (ref) v_u_7, (copy) v_u_21, (copy) p_u_19
				while v_u_22 < v_u_20 do
					v_u_22 = v_u_22 + task.wait()
					local v23 = v_u_22 / v_u_20
					local v24 = 1 - (1 - math.min(v23, 1)) ^ 2
					v_u_7:set(v_u_21 + (1 - v_u_21) * v24)
				end
				v_u_7:set(1)
				if p_u_19 then
					p_u_19()
				end
			end)
		end,
		["setTransparency"] = function(_, p25) -- name: setTransparency
			-- upvalues: (copy) v_u_7
			v_u_7:set(p25)
		end
	}
end