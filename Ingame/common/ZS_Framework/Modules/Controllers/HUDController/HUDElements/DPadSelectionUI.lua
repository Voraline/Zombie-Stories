require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
game:GetService("TweenService")
local v_u_1 = script:WaitForChild("DPadSelection")
local v_u_2 = v_u_1:WaitForChild("DPadSelect")
local v_u_3 = v_u_2:WaitForChild("ImageLabel")
local v_u_4 = nil
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = Vector2.new()
local v_u_12 = Vector2.new()
local v_u_13 = os.clock()
local v_u_14 = false
local v_u_15 = false
local v_u_16 = UDim2.new(0.01, 0, 0.5, 0)
local v_u_17 = UDim2.new(0.01, -500, 0.5, 0)
local v_u_18 = {
	["Up"] = Vector2.new(0, 1),
	["Down"] = Vector2.new(0, -1),
	["Left"] = Vector2.new(-1, 0),
	["Right"] = Vector2.new(1, 0)
}
v_u_1.ResetOnSpawn = false
v_u_1.Parent = game.Players.LocalPlayer.PlayerGui
local v_u_63 = {
	["IsShowing"] = true,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_63, (copy) v_u_1
		v_u_63.IsShowing = true
		v_u_1.Enabled = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_63, (copy) v_u_1
		v_u_63.IsShowing = false
		v_u_1.Enabled = false
	end,
	["HoldingMobile"] = function(_) -- name: HoldingMobile
		-- upvalues: (ref) v_u_15
		v_u_15 = true
	end,
	["StopHoldingMobile"] = function(_) -- name: StopHoldingMobile
		-- upvalues: (ref) v_u_15
		v_u_15 = false
	end,
	["Interact"] = function(_, p19, p20) -- name: Interact
		-- upvalues: (copy) v_u_18, (ref) v_u_11, (ref) v_u_12, (copy) v_u_8, (copy) v_u_3, (ref) v_u_13
		local v21 = v_u_18[p19]
		local v22 = v_u_11
		if v_u_12 then
			if v21.X == 0 or v_u_12.Y == 0 then
				if v21.Y == 0 or v_u_12.X == 0 then
					v_u_11 = v_u_11 + v21
				else
					v_u_11 = Vector2.new(0, 0) + v21
				end
			else
				v_u_11 = Vector2.new(0, 0) + v21
			end
		else
			v_u_11 = v_u_11 + v21
		end
		if v_u_11 == Vector2.new() then
			v_u_11 = v_u_11 + v21
		end
		v_u_12 = v21
		if v_u_11 ~= Vector2.new() then
			local v23 = v_u_11.X
			local v24 = tostring(v23)
			local v25 = v_u_11.Y
			if not v_u_8[v24 .. "," .. tostring(v25)] then
				v_u_11 = v22
				local v26 = v_u_11.X
				local v27 = tostring(v26)
				local v28 = v_u_11.Y
				if not v_u_8[v27 .. "," .. tostring(v28)] then
					v_u_11 = Vector2.new()
				end
				return
			end
		end
		local v29 = v_u_11
		local v30 = 0
		local v31 = 0
		if v29.X > 1 then
			v30 = 23
		elseif v29.X < -1 then
			v30 = -23
		elseif v29.Y > 1 then
			v31 = 20
		elseif v29.Y < -1 then
			v31 = -20
		end
		local v32 = v_u_3.Frame
		local v33 = UDim2.new
		local v34 = v_u_11.X
		local v35 = math.clamp(v34, -2, 2) * 80 + v30
		local v36 = v_u_11.Y
		v32:TweenPosition(v33(0.5, v35, 0.5, math.clamp(v36, -2, 2) * -82 + v31), "Out", "Quad", 0.25, true)
		if v_u_11.X <= -3 then
			v_u_3.Long.Frame:TweenPosition(UDim2.new(1, 103 * ((v_u_11.X + 2) * -1), 0.5, 0), "Out", "Quad", 0.25, true)
		elseif v_u_11.X > -3 then
			v_u_3.Long.Frame:TweenPosition(UDim2.new(1, 0, 0.5, 0), "Out", "Quad", 0.25, true)
		end
		if p20 then
			v_u_13 = os.clock() + 0.5
		else
			v_u_13 = os.clock() + 3
		end
		local v37 = v_u_11.X
		local v38 = tostring(v37)
		local v39 = v_u_11.Y
		return v_u_8[v38 .. "," .. tostring(v39)]
	end,
	["UpdateSelected"] = function(_, p40) -- name: UpdateSelected
		-- upvalues: (copy) v_u_8, (ref) v_u_11, (ref) v_u_12, (copy) v_u_3
		for v41, v42 in pairs(v_u_8) do
			if v42 == p40 then
				local v43, v44 = string.match(v41, "(%-?%d+),(%-?%d+)")
				v_u_11 = Vector2.new(tonumber(v43), (tonumber(v44)))
				v_u_12 = v_u_11
				local v45 = v_u_11
				local v46 = 0
				local v47 = 0
				if v45.X > 1 then
					v46 = 23
				elseif v45.X < -1 then
					v46 = -23
				elseif v45.Y > 1 then
					v47 = 20
				elseif v45.Y < -1 then
					v47 = -20
				end
				local v48 = v_u_3.Frame
				local v49 = UDim2.new
				local v50 = v_u_11.X
				local v51 = math.clamp(v50, -2, 2) * 80 + v46
				local v52 = v_u_11.Y
				v48.Position = v49(0.5, v51, 0.5, math.clamp(v52, -2, 2) * -82 + v47)
				if v_u_11.X <= -3 then
					v_u_3.Long.Frame.Position = UDim2.new(1, 103 * ((v_u_11.X + 2) * -1), 0.5, 0)
					return
				end
				if v_u_11.X > -3 then
					v_u_3.Long.Frame.Position = UDim2.new(1, 0, 0.5, 0)
					return
				end
				break
			end
		end
	end,
	["AddItem"] = function(_, p53, p54) -- name: AddItem
		-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10
		if p53.Config then
			local v55 = p53.Config.HideFromHotbar
			if type(v55) == "function" then
				v55 = v55(p53.Config, p53)
			end
			if v55 then
				return
			end
		end
		local v56 = p54:Clone()
		v56.Cover.BackgroundTransparency = 1
		v56.Size = UDim2.new(0, 100, 0, 100)
		v56.Visible = true
		v56.NumberLabel.Visible = false
		if p53.Config.IsAPistol or p53.Config.IsMelee then
			if p53.Config.IsAPistol then
				local v57 = v_u_6
				table.insert(v57, true)
				v_u_8[#v_u_6 .. ",0"] = p53.Slot
				v56.LayoutOrder = #v_u_6
				v56.Parent = v_u_3.Short.Frame
			else
				local v58 = v_u_7
				table.insert(v58, true)
				v_u_8["0,-" .. #v_u_7] = p53.Slot
				v56.LayoutOrder = #v_u_7
				v56.Parent = v_u_3.Misc.Frame
			end
		else
			local v59 = v_u_5
			table.insert(v59, true)
			v_u_8["-" .. #v_u_5 .. ",0"] = p53.Slot
			v56.LayoutOrder = -#v_u_5
			v56.Parent = v_u_3.Long.Frame
		end
		v_u_9[p53.Slot] = p53.HotbarSlot
		local v60 = v_u_10
		table.insert(v60, v56)
	end,
	["ResetInventory"] = function(_) -- name: ResetInventory
		-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (ref) v_u_11, (ref) v_u_12, (copy) v_u_3
		table.clear(v_u_5)
		table.clear(v_u_6)
		table.clear(v_u_7)
		table.clear(v_u_8)
		table.clear(v_u_9)
		for _, v61 in v_u_10 do
			v61:Destroy()
		end
		table.clear(v_u_10)
		v_u_11 = Vector2.new()
		v_u_12 = Vector2.new()
		v_u_3.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		v_u_3.Long.Frame.Position = UDim2.new(1, 0, 0.5, 0)
	end,
	["GetHotbarSlot"] = function(_, p62) -- name: GetHotbarSlot
		-- upvalues: (copy) v_u_9
		return v_u_9[p62] or p62
	end
}
v_u_3.Settings.Button.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_63, (ref) v_u_4, (copy) v_u_9
	local v64 = v_u_63:Interact("Up", true)
	if v64 then
		v_u_4:SwapWeapon(v_u_9[v64] or v64, nil)
	end
end)
v_u_3.Long.Button.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_63, (ref) v_u_4, (copy) v_u_9
	local v65 = v_u_63:Interact("Left", true)
	if v65 then
		v_u_4:SwapWeapon(v_u_9[v65] or v65, nil)
	end
end)
v_u_3.Short.Button.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_63, (ref) v_u_4, (copy) v_u_9
	local v66 = v_u_63:Interact("Right", true)
	if v66 then
		v_u_4:SwapWeapon(v_u_9[v66] or v66, nil)
	end
end)
v_u_3.Misc.Button.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_63, (ref) v_u_4, (copy) v_u_9
	local v67 = v_u_63:Interact("Down", true)
	if v67 then
		v_u_4:SwapWeapon(v_u_9[v67] or v67, nil)
	end
end)
task.spawn(function()
	-- upvalues: (ref) v_u_4, (ref) v_u_15, (ref) v_u_13, (ref) v_u_14, (copy) v_u_2, (copy) v_u_16, (copy) v_u_17
	v_u_4 = require("../../WeaponController")
	while task.wait() do
		if v_u_15 then
			v_u_13 = os.clock() + 1
		end
		if v_u_13 > os.clock() then
			if not v_u_14 then
				v_u_14 = true
				v_u_2:TweenPosition(v_u_16, "Out", "Quad", 0.5, true)
			end
		elseif v_u_14 then
			v_u_14 = false
			v_u_2:TweenPosition(v_u_17, "Out", "Quad", 0.5, true)
		end
	end
end)
return v_u_63