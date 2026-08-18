repeat
	wait()
until game.Players.LocalPlayer
local v_u_1 = game.Players.LocalPlayer
local v_u_2 = {}
local v_u_3 = {
	["Visible"] = false
}
task.defer(function()
	-- upvalues: (copy) v_u_1, (ref) v_u_3
	local v4 = v_u_1.PlayerGui:WaitForChild("Panel", 30)
	if v4 then
		v_u_3 = v4:WaitForChild("Elements"):WaitForChild("Commander")
	end
end)
local function v_u_6(p5) -- name: findSurfaceGui
	while not (p5.Parent and p5.Parent:IsA("ScreenGui")) do
		if not p5.Parent then
			return p5
		end
		p5 = p5.Parent
	end
	return p5.Parent
end
local function v_u_9(p7) -- name: isPartOfNotify
	local v8 = nil
	while not p7.Parent or (not p7.Parent:IsA("ScreenGui") or p7.Parent.Name ~= "Notify") do
		if not p7.Parent then
			return v8
		end
		p7 = p7.Parent
	end
	local _ = p7.Parent
	return true
end
local v23 = {
	["MouseEnterLeaveEvent"] = function(p_u_10) -- name: MouseEnterLeaveEvent
		-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_9
		if v_u_2[p_u_10] then
			return v_u_2[p_u_10].EnteredEvent.Event, v_u_2[p_u_10].LeaveEvent.Event, v_u_2[p_u_10].ClickEvent.Event, v_u_2[p_u_10].DownEvent.Event, v_u_2[p_u_10].UpEvent.Event
		end
		p_u_10.Active = false
		local v11 = {}
		local v_u_12 = {}
		v11.UIObj = p_u_10
		local v_u_13 = Instance.new("BindableEvent")
		local v_u_14 = Instance.new("BindableEvent")
		local v_u_15 = Instance.new("BindableEvent")
		local v_u_16 = Instance.new("BindableEvent")
		local v_u_17 = Instance.new("BindableEvent")
		v11.EnteredEvent = v_u_13
		v11.MouseIn = false
		v11.MouseDownOnObj = false
		v11.LeaveEvent = v_u_14
		v11.ClickEvent = v_u_15
		v11.DownEvent = v_u_16
		v11.UpEvent = v_u_17
		v11.SurfaceGui = v_u_6(p_u_10)
		v11.IsPartOfNotify = v_u_9(p_u_10)
		v_u_2[p_u_10] = v11
		p_u_10.Destroying:Connect(function()
			-- upvalues: (copy) v_u_13, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16, (copy) v_u_17, (copy) p_u_10, (ref) v_u_2, (ref) v_u_12
			v_u_13:Destroy()
			v_u_14:Destroy()
			v_u_15:Destroy()
			v_u_16:Destroy()
			v_u_17:Destroy()
			if p_u_10 and (v_u_2[p_u_10] and v_u_2[p_u_10].SelectRS) then
				v_u_2[p_u_10].SelectRS:Disconnect()
			end
			v_u_2[p_u_10] = nil
			v_u_12 = nil
		end)
		v_u_2[p_u_10].SelectRS = game:GetService("RunService").RenderStepped:connect(function()
			-- upvalues: (ref) v_u_12
			for v18, v19 in pairs(v_u_12) do
				local v20 = v19[1]
				local v21 = v19[2]
				local v22 = v20 + 0.1
				v18.BackgroundColor3 = v18.BackgroundColor3:lerp(v21, v22)
				if v22 >= 1 then
					v_u_12[v18] = nil
				end
			end
		end)
		return v_u_13.Event, v_u_14.Event, v_u_15.Event, v_u_16.Event, v_u_17.Event, v_u_15
	end
}
local v_u_24 = v_u_1:GetMouse()
local function v_u_28(p25) -- name: IsInFrame
	-- upvalues: (copy) v_u_24
	if p25.Visible == true then
		local v26 = v_u_24.X
		local v27 = v_u_24.Y
		return p25.AbsolutePosition.X < v26 and (p25.AbsolutePosition.Y < v27 and (v26 < p25.AbsolutePosition.X + p25.AbsoluteSize.X and v27 < p25.AbsolutePosition.Y + p25.AbsoluteSize.Y))
	end
end
local function v_u_31(p29) -- name: IsInClipping
	-- upvalues: (copy) v_u_28, (copy) v_u_31
	local v30 = not (p29.Parent:IsA("GuiObject") and p29.Parent.ClipsDescendants) or v_u_28(p29.Parent)
	if v30 then
		v30 = not p29.Parent:IsA("GuiObject") or v_u_31(p29.Parent)
	end
	return v30
end
game:GetService("RunService").Heartbeat:connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_28, (copy) v_u_1, (copy) v_u_31
	local v32 = nil
	for v33, v_u_34 in pairs(v_u_2) do
		if v_u_28(v_u_34.UIObj) and v33.Visible then
			local function v_u_37(p35) -- name: Check
				-- upvalues: (copy) v_u_34, (copy) v_u_37
				local v36 = v_u_34.SurfaceGui
				if not p35.Parent then
					return false
				end
				if not v36:IsA("ScreenGui") and v36:IsA("GuiObject") then
					return v36.Visible
				end
				if p35.Parent == v36 and (p35:IsA("GuiObject") and (p35.Visible == true and v36.Enabled == true)) or p35.Parent == v36 and (not p35:IsA("GuiObject") and v36.Enabled == true) then
					return true
				end
				if not p35:IsA("GuiObject") then
					return v_u_37(p35.Parent)
				end
				if p35.Visible == false then
					return false
				end
				if p35.Visible == true then
					return v_u_37(p35.Parent)
				end
			end
			if not v_u_37(v_u_34.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v33].IsPartOfNotify or v32 and v32.ZIndex >= v33.ZIndex or not v_u_31(v_u_34.UIObj)) then
				goto l4
			end
			v32 = v33
		else
			::l4::
			if v_u_34.MouseIn then
				v_u_34.MouseIn = false
				v_u_34.LeaveEvent:Fire()
			end
		end
	end
	if v32 and not v_u_2[v32].MouseIn then
		v_u_2[v32].MouseIn = true
		v_u_2[v32].EnteredEvent:Fire()
	end
end)
local function v_u_57(p38, _, p39) -- name: inputDown
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_31, (copy) v_u_24, (ref) v_u_3
	local v40 = nil
	for v41, v_u_42 in pairs(v_u_2) do
		if p39 then
			local v43 = p39.X
			local v44 = p39.Y
			local v45
			if v41.AbsolutePosition.X < v43 and (v41.AbsolutePosition.Y < v44 and v43 < v41.AbsolutePosition.X + v41.AbsoluteSize.X) then
				v45 = v44 < v41.AbsolutePosition.Y + v41.AbsoluteSize.Y
			else
				v45 = false
			end
			if v45 and v_u_42.UIObj.Visible then
				local function v_u_48(p46) -- name: Check
					-- upvalues: (copy) v_u_42, (copy) v_u_48
					local v47 = v_u_42.SurfaceGui
					if not p46.Parent then
						return false
					end
					if not v47:IsA("ScreenGui") and v47:IsA("GuiObject") then
						return v47.Visible
					end
					if p46.Parent == v47 and (p46:IsA("GuiObject") and (p46.Visible == true and v47.Enabled == true)) or p46.Parent == v47 and (not p46:IsA("GuiObject") and v47.Enabled == true) then
						return true
					end
					if not p46:IsA("GuiObject") then
						return v_u_48(p46.Parent)
					end
					if p46.Visible == false then
						return false
					end
					if p46.Visible == true then
						return v_u_48(p46.Parent)
					end
				end
				if not v_u_48(v_u_42.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v41].IsPartOfNotify or v40 and v40.ZIndex >= v41.ZIndex or not v_u_31(v_u_42.UIObj)) then
					goto l12
				end
				if v40 then
					v_u_2[v40].MouseDownOnObj = false
				end
				v40 = v41
			else
				::l12::
				v_u_42.MouseDownOnObj = false
			end
		elseif p38.KeyCode == Enum.KeyCode.ButtonA or p38.UserInputType == Enum.UserInputType.MouseButton1 then
			if v_u_42.MouseIn and v_u_42.UIObj.Visible then
				local function v_u_51(p49) -- name: Check
					-- upvalues: (copy) v_u_42, (copy) v_u_51
					local v50 = v_u_42.SurfaceGui
					if not p49.Parent then
						return false
					end
					if not v50:IsA("ScreenGui") and v50:IsA("GuiObject") then
						return v50.Visible
					end
					if p49.Parent == v50 and (p49:IsA("GuiObject") and (p49.Visible == true and v50.Enabled == true)) or p49.Parent == v50 and (not p49:IsA("GuiObject") and v50.Enabled == true) then
						return true
					end
					if not p49:IsA("GuiObject") then
						return v_u_51(p49.Parent)
					end
					if p49.Visible == false then
						return false
					end
					if p49.Visible == true then
						return v_u_51(p49.Parent)
					end
				end
				if not v_u_51(v_u_42.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v41].IsPartOfNotify or v40 and v40.ZIndex >= v41.ZIndex or not v_u_31(v_u_42.UIObj)) then
					goto l27
				end
				if v40 then
					v_u_2[v40].MouseDownOnObj = false
				end
				v40 = v41
			else
				::l27::
				v_u_42.MouseDownOnObj = false
			end
		end
	end
	if v40 then
		local v52 = v_u_1.PlayerGui:FindFirstChild("Notify")
		local v53 = v_u_2[v40]
		if v52 and v53.IsPartOfNotify or not (v52 or v53.IsPartOfNotify) then
			v53.MouseDownOnObj = true
			local v54, v55
			if p39 then
				v54 = p39.X
				v55 = p39.Y
				v53.EnteredEvent:Fire()
			else
				v54 = v_u_24.X
				v55 = v_u_24.Y
			end
			if not v_u_3.Visible then
				local v56 = v_u_1.PlayerGui:FindFirstChild("SettingsGui")
				if v56 then
					v56 = v56.Enabled
				end
				if not v56 then
					v53.DownEvent:Fire(v54, v55)
				end
			end
		end
	end
end
local function v_u_79(p58, p59) -- name: inputEnded
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_24, (ref) v_u_3
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
			v67 = v_u_24.X
			v68 = v_u_24.Y
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
			if v_u_71(v_u_66.UIObj) and not v_u_3.Visible then
				local v72 = v_u_1.PlayerGui:FindFirstChild("SettingsGui")
				if v72 then
					v72 = v72.Enabled
				end
				if not v72 then
					local v73 = v_u_66.UIObj
					local v74
					if v73.AbsolutePosition.X < v67 and (v73.AbsolutePosition.Y < v68 and v67 < v73.AbsolutePosition.X + v73.AbsoluteSize.X) then
						v74 = v68 < v73.AbsolutePosition.Y + v73.AbsoluteSize.Y
					else
						v74 = false
					end
					if v74 then
						v_u_66.ClickEvent:Fire(v67, v68)
					else
						v_u_66.UpEvent:Fire(v67, v68)
					end
				end
			end
		end
		if v_u_66.MouseIn then
			local function v_u_77(p75) -- name: Check
				-- upvalues: (copy) v_u_66, (copy) v_u_77
				local v76 = v_u_66.SurfaceGui
				if not p75.Parent then
					return false
				end
				if not v76:IsA("ScreenGui") and v76:IsA("GuiObject") then
					return v76.Visible
				end
				if p75.Parent == v76 and (p75:IsA("GuiObject") and (p75.Visible == true and v76.Enabled == true)) or p75.Parent == v76 and (not p75:IsA("GuiObject") and v76.Enabled == true) then
					return true
				end
				if not p75:IsA("GuiObject") then
					return v_u_77(p75.Parent)
				end
				if p75.Visible == false then
					return false
				end
				if p75.Visible == true then
					return v_u_77(p75.Parent)
				end
			end
			if v_u_77(v_u_66.UIObj) and not v_u_3.Visible then
				local v78 = v_u_1.PlayerGui:FindFirstChild("SettingsGui")
				if v78 then
					v78 = v78.Enabled
				end
				if not v78 then
					v_u_66.ClickEvent:Fire(v67, v68)
					return
				end
			end
		end
		if not v_u_66.MouseIn then
			v_u_66.UpEvent:Fire(v67, v68)
		end
	end
end
game:GetService("UserInputService").InputBegan:connect(function(p80, p81)
	-- upvalues: (copy) v_u_57
	if p80.KeyCode == Enum.KeyCode.ButtonA or p80.UserInputType == Enum.UserInputType.MouseButton1 then
		v_u_57(p80, p81)
	end
end)
if game:GetService("UserInputService").TouchEnabled then
	game:GetService("UserInputService").TouchStarted:Connect(function(p82, p83)
		-- upvalues: (copy) v_u_57
		v_u_57(nil, p83, p82.Position)
	end)
	game:GetService("UserInputService").TouchEnded:Connect(function(p84, _)
		-- upvalues: (copy) v_u_79
		v_u_79(nil, p84.Position)
	end)
end
game:GetService("UserInputService").InputEnded:connect(function(p85)
	-- upvalues: (copy) v_u_79
	v_u_79(p85)
end)
game:GetService("UserInputService").InputChanged:connect(function(p86, _)
	-- upvalues: (copy) v_u_2, (copy) v_u_28, (copy) v_u_1, (copy) v_u_31
	if p86.UserInputType ~= Enum.UserInputType.Gamepad1 or p86.KeyCode ~= Enum.KeyCode.Thumbstick1 then
		::l2::
		return
	end
	Vector2.new(p86.Position.X, p86.Position.Y)
	local v87 = nil
	for v88, v_u_89 in pairs(v_u_2) do
		if v_u_28(v_u_89.UIObj) and v88.Visible then
			local function v_u_92(p90) -- name: Check
				-- upvalues: (copy) v_u_89, (copy) v_u_92
				local v91 = v_u_89.SurfaceGui
				if not p90.Parent then
					return false
				end
				if not v91:IsA("ScreenGui") and v91:IsA("GuiObject") then
					return v91.Visible
				end
				if p90.Parent == v91 and (p90:IsA("GuiObject") and (p90.Visible == true and v91.Enabled == true)) or p90.Parent == v91 and (not p90:IsA("GuiObject") and v91.Enabled == true) then
					return true
				end
				if not p90:IsA("GuiObject") then
					return v_u_92(p90.Parent)
				end
				if p90.Visible == false then
					return false
				end
				if p90.Visible == true then
					return v_u_92(p90.Parent)
				end
			end
			if not v_u_92(v_u_89.UIObj) or (v_u_1.PlayerGui:FindFirstChild("Notify") and not v_u_2[v88].IsPartOfNotify or v87 and v87.ZIndex >= v88.ZIndex or not v_u_31(v_u_89.UIObj)) then
				goto l7
			end
			v87 = v88
		else
			::l7::
			if v_u_89.MouseIn then
				v_u_89.MouseIn = false
				v_u_89.LeaveEvent:Fire()
			end
		end
	end
	if v87 and not v_u_2[v87].MouseIn then
		v_u_2[v87].MouseIn = true
		v_u_2[v87].EnteredEvent:Fire()
	end
	goto l2
end)
return v23