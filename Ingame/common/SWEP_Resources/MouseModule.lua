repeat
	wait()
until game.Players.LocalPlayer
local v_u_1 = game.Players.LocalPlayer
local v_u_2 = {}
local v_u_3 = v_u_1:WaitForChild("PlayerGui"):WaitForChild("SettingsGui")
local v_u_4 = {
	["Visible"] = false
}
task.defer(function()
	-- upvalues: (copy) v_u_1, (ref) v_u_4
	local v5 = v_u_1.PlayerGui:WaitForChild("Panel", 30)
	if v5 then
		v_u_4 = v5:WaitForChild("Elements"):WaitForChild("Commander")
	end
end)
local function v_u_7(p6) -- name: findSurfaceGui
	while not (p6.Parent and p6.Parent:IsA("ScreenGui")) do
		if not p6.Parent then
			return p6
		end
		p6 = p6.Parent
	end
	return p6.Parent
end
local function v_u_10(p8) -- name: isPartOfNotify
	local v9 = nil
	while not p8.Parent or (not p8.Parent:IsA("ScreenGui") or p8.Parent.Name ~= "Notify") do
		if not p8.Parent then
			return v9
		end
		p8 = p8.Parent
	end
	local _ = p8.Parent
	return true
end
local v24 = {
	["MouseEnterLeaveEvent"] = function(p_u_11) -- name: MouseEnterLeaveEvent
		-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_10
		if v_u_2[p_u_11] then
			return v_u_2[p_u_11].EnteredEvent.Event, v_u_2[p_u_11].LeaveEvent.Event, v_u_2[p_u_11].ClickEvent.Event, v_u_2[p_u_11].DownEvent.Event, v_u_2[p_u_11].UpEvent.Event
		end
		p_u_11.Active = false
		local v12 = {}
		local v_u_13 = {}
		v12.UIObj = p_u_11
		local v_u_14 = Instance.new("BindableEvent")
		local v_u_15 = Instance.new("BindableEvent")
		local v_u_16 = Instance.new("BindableEvent")
		local v_u_17 = Instance.new("BindableEvent")
		local v_u_18 = Instance.new("BindableEvent")
		v12.EnteredEvent = v_u_14
		v12.MouseIn = false
		v12.MouseDownOnObj = false
		v12.LeaveEvent = v_u_15
		v12.ClickEvent = v_u_16
		v12.DownEvent = v_u_17
		v12.UpEvent = v_u_18
		v12.SurfaceGui = v_u_7(p_u_11)
		v12.IsPartOfNotify = v_u_10(p_u_11)
		v_u_2[p_u_11] = v12
		p_u_11.Destroying:Connect(function()
			-- upvalues: (copy) p_u_11, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16, (copy) v_u_17, (copy) v_u_18, (ref) v_u_2, (ref) v_u_13
			print("removing", p_u_11)
			v_u_14:Destroy()
			v_u_15:Destroy()
			v_u_16:Destroy()
			v_u_17:Destroy()
			v_u_18:Destroy()
			if p_u_11 and (v_u_2[p_u_11] and v_u_2[p_u_11].SelectRS) then
				v_u_2[p_u_11].SelectRS:Disconnect()
			end
			v_u_2[p_u_11] = nil
			v_u_13 = nil
		end)
		v_u_2[p_u_11].SelectRS = game:GetService("RunService").RenderStepped:connect(function()
			-- upvalues: (ref) v_u_13
			for v19, v20 in pairs(v_u_13) do
				local v21 = v20[1]
				local v22 = v20[2]
				local v23 = v21 + 0.1
				v19.BackgroundColor3 = v19.BackgroundColor3:lerp(v22, v23)
				if v23 >= 1 then
					v_u_13[v19] = nil
				end
			end
		end)
		return v_u_14.Event, v_u_15.Event, v_u_16.Event, v_u_17.Event, v_u_18.Event, v_u_16
	end
}
local v_u_25 = v_u_1:GetMouse()
local function v_u_29(p26) -- name: IsInFrame
	-- upvalues: (copy) v_u_25
	if p26.Visible == true then
		local v27 = v_u_25.X
		local v28 = v_u_25.Y
		return p26.AbsolutePosition.X < v27 and (p26.AbsolutePosition.Y < v28 and (v27 < p26.AbsolutePosition.X + p26.AbsoluteSize.X and v28 < p26.AbsolutePosition.Y + p26.AbsoluteSize.Y))
	end
end
local function v_u_32(p30) -- name: IsInClipping
	-- upvalues: (copy) v_u_29, (copy) v_u_32
	local v31 = not (p30.Parent:IsA("GuiObject") and p30.Parent.ClipsDescendants) or v_u_29(p30.Parent)
	if v31 then
		v31 = not p30.Parent:IsA("GuiObject") or v_u_32(p30.Parent)
	end
	return v31
end
game:GetService("RunService").Heartbeat:connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_29, (copy) v_u_1, (copy) v_u_32
	local v33 = nil
	for v34, v_u_35 in pairs(v_u_2) do
		if v_u_29(v_u_35.UIObj) and v34.Visible then
			local function v_u_38(p36) -- name: Check
				-- upvalues: (copy) v_u_35, (copy) v_u_38
				local v37 = v_u_35.SurfaceGui
				if not p36.Parent then
					return false
				end
				if not v37:IsA("ScreenGui") and v37:IsA("GuiObject") then
					return v37.Visible
				end
				if p36.Parent == v37 and (p36:IsA("GuiObject") and (p36.Visible == true and v37.Enabled == true)) or p36.Parent == v37 and (not p36:IsA("GuiObject") and v37.Enabled == true) then
					return true
				end
				if not p36:IsA("GuiObject") then
					return v_u_38(p36.Parent)
				end
				if p36.Visible == false then
					return false
				end
				if p36.Visible == true then
					return v_u_38(p36.Parent)
				end
			end
			if not v_u_38(v_u_35.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v34].IsPartOfNotify or v33 and v33.ZIndex >= v34.ZIndex or not v_u_32(v_u_35.UIObj)) then
				goto l4
			end
			v33 = v34
		else
			::l4::
			if v_u_35.MouseIn then
				v_u_35.MouseIn = false
				v_u_35.LeaveEvent:Fire()
			end
		end
	end
	if v33 and not v_u_2[v33].MouseIn then
		v_u_2[v33].MouseIn = true
		v_u_2[v33].EnteredEvent:Fire()
	end
end)
local function v_u_57(p39, _, p40) -- name: inputDown
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_32, (copy) v_u_25, (copy) v_u_3, (ref) v_u_4
	local v41 = nil
	for v42, v_u_43 in pairs(v_u_2) do
		if p40 then
			local v44 = p40.X
			local v45 = p40.Y
			local v46
			if v42.AbsolutePosition.X < v44 and (v42.AbsolutePosition.Y < v45 and v44 < v42.AbsolutePosition.X + v42.AbsoluteSize.X) then
				v46 = v45 < v42.AbsolutePosition.Y + v42.AbsoluteSize.Y
			else
				v46 = false
			end
			if v46 and v_u_43.UIObj.Visible then
				local function v_u_49(p47) -- name: Check
					-- upvalues: (copy) v_u_43, (copy) v_u_49
					local v48 = v_u_43.SurfaceGui
					if not p47.Parent then
						return false
					end
					if not v48:IsA("ScreenGui") and v48:IsA("GuiObject") then
						return v48.Visible
					end
					if p47.Parent == v48 and (p47:IsA("GuiObject") and (p47.Visible == true and v48.Enabled == true)) or p47.Parent == v48 and (not p47:IsA("GuiObject") and v48.Enabled == true) then
						return true
					end
					if not p47:IsA("GuiObject") then
						return v_u_49(p47.Parent)
					end
					if p47.Visible == false then
						return false
					end
					if p47.Visible == true then
						return v_u_49(p47.Parent)
					end
				end
				if not v_u_49(v_u_43.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v42].IsPartOfNotify or v41 and v41.ZIndex >= v42.ZIndex or not v_u_32(v_u_43.UIObj)) then
					goto l12
				end
				if v41 then
					v_u_2[v41].MouseDownOnObj = false
				end
				v41 = v42
			else
				::l12::
				v_u_43.MouseDownOnObj = false
			end
		elseif p39.KeyCode == Enum.KeyCode.ButtonA or p39.UserInputType == Enum.UserInputType.MouseButton1 then
			if v_u_43.MouseIn and v_u_43.UIObj.Visible then
				local function v_u_52(p50) -- name: Check
					-- upvalues: (copy) v_u_43, (copy) v_u_52
					local v51 = v_u_43.SurfaceGui
					if not p50.Parent then
						return false
					end
					if not v51:IsA("ScreenGui") and v51:IsA("GuiObject") then
						return v51.Visible
					end
					if p50.Parent == v51 and (p50:IsA("GuiObject") and (p50.Visible == true and v51.Enabled == true)) or p50.Parent == v51 and (not p50:IsA("GuiObject") and v51.Enabled == true) then
						return true
					end
					if not p50:IsA("GuiObject") then
						return v_u_52(p50.Parent)
					end
					if p50.Visible == false then
						return false
					end
					if p50.Visible == true then
						return v_u_52(p50.Parent)
					end
				end
				if not v_u_52(v_u_43.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v42].IsPartOfNotify or v41 and v41.ZIndex >= v42.ZIndex or not v_u_32(v_u_43.UIObj)) then
					goto l27
				end
				if v41 then
					v_u_2[v41].MouseDownOnObj = false
				end
				v41 = v42
			else
				::l27::
				v_u_43.MouseDownOnObj = false
			end
		end
	end
	if v41 then
		local v53 = v_u_1.PlayerGui:FindFirstChild("Notify")
		local v54 = v_u_2[v41]
		if v53 and v54.IsPartOfNotify or not (v53 or v54.IsPartOfNotify) then
			v54.MouseDownOnObj = true
			local v55, v56
			if p40 then
				v55 = p40.X
				v56 = p40.Y
				v54.EnteredEvent:Fire()
			else
				v55 = v_u_25.X
				v56 = v_u_25.Y
			end
			if not (v_u_3.Enabled or v_u_4.Visible) then
				v54.DownEvent:Fire(v55, v56)
			end
		end
	end
end
local function v_u_77(p58, p59) -- name: inputEnded
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_25, (copy) v_u_3, (ref) v_u_4
	local v60 = nil
	for v61, v62 in pairs(v_u_2) do
		if p59 then
			local v63 = p59.X
			local v64 = p59.Y
			local v65
			if v61.AbsolutePosition.X < v63 and (v61.AbsolutePosition.Y < v64 and v63 < v61.AbsolutePosition.X + v61.AbsoluteSize.X) then
				v65 = v64 < v61.AbsolutePosition.Y + v61.AbsoluteSize.Y
			else
				v65 = false
			end
			if v65 and (v62.UIObj.Visible and v62.MouseDownOnObj == true) and ((not v_u_1.PlayerGui:FindFirstChild("Notify") or v_u_2[v61].IsPartOfNotify) and (not v60 or v60.ZIndex < v61.ZIndex)) then
				v60 = v61
			end
		elseif (p58.KeyCode == Enum.KeyCode.ButtonA or p58.UserInputType == Enum.UserInputType.MouseButton1) and (v61.Visible == true and (v61.Visible and v62.MouseDownOnObj == true)) and ((not v_u_1.PlayerGui:FindFirstChild("Notify") or v_u_2[v61].IsPartOfNotify) and (not v60 or v60.ZIndex < v61.ZIndex)) then
			v60 = v61
		end
	end
	if v60 then
		local v_u_66 = v_u_2[v60]
		local v67, v68
		if p59 then
			v67 = p59.X
			v68 = p59.Y
		else
			v67 = v_u_25.X
			v68 = v_u_25.Y
		end
		if p59 then
			local function v_u_71(p69) -- name: Check
				-- upvalues: (copy) v_u_66, (copy) v_u_71
				local v70 = v_u_66.SurfaceGui
				if not p69.Parent then
					return false
				end
				if not v70:IsA("ScreenGui") and v70:IsA("GuiObject") then
					return v70.Visible
				end
				if p69.Parent == v70 and (p69:IsA("GuiObject") and (p69.Visible == true and v70.Enabled == true)) or p69.Parent == v70 and (not p69:IsA("GuiObject") and v70.Enabled == true) then
					return true
				end
				if not p69:IsA("GuiObject") then
					return v_u_71(p69.Parent)
				end
				if p69.Visible == false then
					return false
				end
				if p69.Visible == true then
					return v_u_71(p69.Parent)
				end
			end
			if v_u_71(v_u_66.UIObj) and not (v_u_3.Enabled or v_u_4.Visible) then
				local v72 = v_u_66.UIObj
				local v73
				if v72.AbsolutePosition.X < v67 and (v72.AbsolutePosition.Y < v68 and v67 < v72.AbsolutePosition.X + v72.AbsoluteSize.X) then
					v73 = v68 < v72.AbsolutePosition.Y + v72.AbsoluteSize.Y
				else
					v73 = false
				end
				if v73 then
					v_u_66.ClickEvent:Fire(v67, v68)
				else
					v_u_66.UpEvent:Fire(v67, v68)
				end
			end
		end
		if v_u_66.MouseIn then
			local function v_u_76(p74) -- name: Check
				-- upvalues: (copy) v_u_66, (copy) v_u_76
				local v75 = v_u_66.SurfaceGui
				if not p74.Parent then
					return false
				end
				if not v75:IsA("ScreenGui") and v75:IsA("GuiObject") then
					return v75.Visible
				end
				if p74.Parent == v75 and (p74:IsA("GuiObject") and (p74.Visible == true and v75.Enabled == true)) or p74.Parent == v75 and (not p74:IsA("GuiObject") and v75.Enabled == true) then
					return true
				end
				if not p74:IsA("GuiObject") then
					return v_u_76(p74.Parent)
				end
				if p74.Visible == false then
					return false
				end
				if p74.Visible == true then
					return v_u_76(p74.Parent)
				end
			end
			if v_u_76(v_u_66.UIObj) and not (v_u_3.Enabled or v_u_4.Visible) then
				v_u_66.ClickEvent:Fire(v67, v68)
				return
			end
		end
		if not v_u_66.MouseIn then
			v_u_66.UpEvent:Fire(v67, v68)
		end
	end
end
game:GetService("UserInputService").InputBegan:connect(function(p78, p79)
	-- upvalues: (copy) v_u_57
	if p78.KeyCode == Enum.KeyCode.ButtonA or p78.UserInputType == Enum.UserInputType.MouseButton1 then
		v_u_57(p78, p79)
	end
end)
if game:GetService("UserInputService").TouchEnabled then
	game:GetService("UserInputService").TouchStarted:Connect(function(p80, p81)
		-- upvalues: (copy) v_u_57
		v_u_57(nil, p81, p80.Position)
	end)
	game:GetService("UserInputService").TouchEnded:Connect(function(p82, _)
		-- upvalues: (copy) v_u_77
		v_u_77(nil, p82.Position)
	end)
end
game:GetService("UserInputService").InputEnded:connect(function(p83)
	-- upvalues: (copy) v_u_77
	v_u_77(p83)
end)
game:GetService("UserInputService").InputChanged:connect(function(p84, _)
	-- upvalues: (copy) v_u_2, (copy) v_u_29, (copy) v_u_1, (copy) v_u_32
	if p84.UserInputType ~= Enum.UserInputType.Gamepad1 or p84.KeyCode ~= Enum.KeyCode.Thumbstick1 then
		::l2::
		return
	end
	Vector2.new(p84.Position.X, p84.Position.Y)
	local v85 = nil
	for v86, v_u_87 in pairs(v_u_2) do
		if v_u_29(v_u_87.UIObj) and v86.Visible then
			local function v_u_90(p88) -- name: Check
				-- upvalues: (copy) v_u_87, (copy) v_u_90
				local v89 = v_u_87.SurfaceGui
				if not p88.Parent then
					return false
				end
				if not v89:IsA("ScreenGui") and v89:IsA("GuiObject") then
					return v89.Visible
				end
				if p88.Parent == v89 and (p88:IsA("GuiObject") and (p88.Visible == true and v89.Enabled == true)) or p88.Parent == v89 and (not p88:IsA("GuiObject") and v89.Enabled == true) then
					return true
				end
				if not p88:IsA("GuiObject") then
					return v_u_90(p88.Parent)
				end
				if p88.Visible == false then
					return false
				end
				if p88.Visible == true then
					return v_u_90(p88.Parent)
				end
			end
			if not v_u_90(v_u_87.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v86].IsPartOfNotify or v85 and v85.ZIndex >= v86.ZIndex or not v_u_32(v_u_87.UIObj)) then
				goto l7
			end
			v85 = v86
		else
			::l7::
			if v_u_87.MouseIn then
				v_u_87.MouseIn = false
				v_u_87.LeaveEvent:Fire()
			end
		end
	end
	if v85 and not v_u_2[v85].MouseIn then
		v_u_2[v85].MouseIn = true
		v_u_2[v85].EnteredEvent:Fire()
	end
	goto l2
end)
return v24