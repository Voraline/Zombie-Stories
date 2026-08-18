local v_u_1 = game:GetService("UserInputService")
game.Players.LocalPlayer:GetMouse()
local v_u_2 = Vector2.new()
local function v5(p3) -- name: updateMousePosition
	-- upvalues: (ref) v_u_2
	if p3.UserInputType == Enum.UserInputType.MouseMovement or p3.UserInputType == Enum.UserInputType.Touch then
		local v4 = p3.Position
		v_u_2 = Vector2.new(v4.X, v4.Y)
	end
end
v_u_1.InputChanged:Connect(v5)
v_u_1.InputBegan:Connect(v5)
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p_u_7, p_u_8, p9, p10) -- name: new
	-- upvalues: (copy) v_u_6, (ref) v_u_2, (copy) v_u_1
	local v_u_11 = false
	local v_u_12 = {
		["ScrollBarFrame"] = nil,
		["ScrollingFrame"] = nil,
		["Button"] = nil,
		["Connections"] = nil,
		["MoveDimension"] = nil,
		["AutoHide"] = nil,
		["Visible"] = true,
		["Hidden"] = false,
		["ScrollBarFrame"] = p_u_7,
		["ScrollingFrame"] = p_u_8,
		["Button"] = p_u_7:WaitForChild("ScrollButton"),
		["Connections"] = {},
		["MoveDimension"] = p9 or "Y",
		["AutoHide"] = p10 or true
	}
	local v13 = v_u_6
	setmetatable(v_u_12, v13)
	local function v14() -- name: updateSize
		-- upvalues: (copy) v_u_12
		v_u_12:_UpdateSize()
	end
	v_u_12:_UpdateSize()
	local v15 = v_u_12.Connections
	local v16 = p_u_8:GetPropertyChangedSignal("CanvasSize")
	table.insert(v15, v16:Connect(v14))
	local v17 = v_u_12.Connections
	local v18 = p_u_8:GetPropertyChangedSignal("AbsoluteSize")
	table.insert(v17, v18:Connect(v14))
	local v19 = v_u_12.Connections
	local v20 = p_u_8:GetPropertyChangedSignal("CanvasPosition")
	table.insert(v19, v20:Connect(function()
		-- upvalues: (copy) v_u_12
		v_u_12:_UpdatePosition()
	end))
	local v21 = v_u_12.Connections
	local v22 = v_u_12.Button.MouseButton1Down
	local function v29(p23, p24)
		-- upvalues: (ref) v_u_2, (copy) v_u_12, (ref) v_u_11, (copy) p_u_7, (copy) p_u_8
		v_u_2 = Vector2.new(p23, p24 - 36)
		local v25 = v_u_12.MoveDimension
		v_u_11 = true
		local v26 = (v_u_12.Button.AbsolutePosition[v25] - v_u_2[v25]) / p_u_7.AbsoluteSize[v25]
		v_u_12:_UpdateSize()
		while v_u_11 do
			local _ = 1 - v_u_12.Button.Size[v25].Scale
			local v27 = (v_u_2[v25] - p_u_7.AbsolutePosition[v25]) / p_u_7.AbsoluteSize[v25] + v26
			local v28 = p_u_8.AbsoluteCanvasSize[v25]
			if v_u_12.MoveDimension == "X" then
				p_u_8.CanvasPosition = Vector2.new(Lerp(0, v28, v27), 0)
			else
				p_u_8.CanvasPosition = Vector2.new(0, Lerp(0, v28, v27))
			end
			task.wait()
		end
	end
	table.insert(v21, v22:Connect(v29))
	local v30 = v_u_12.Connections
	local v31 = v_u_1.InputEnded
	local function v33(p32)
		-- upvalues: (ref) v_u_11
		if p32.UserInputType == Enum.UserInputType.MouseButton1 or p32.UserInputType == Enum.UserInputType.Touch then
			v_u_11 = false
		end
	end
	table.insert(v30, v31:Connect(v33))
	return v_u_12
end
function v_u_6.Destroy(p34) -- name: Destroy
	for _, v35 in p34.Connections do
		v35:Disconnect()
	end
	p34.ScrollBarFrame:Destroy()
end
function v_u_6.SetVisible(p36, p37) -- name: SetVisible
	p36.Visible = p37
	local v38 = p36.ScrollBarFrame
	if p37 then
		p37 = not p36.Hidden
	end
	v38.Visible = p37
end
function v_u_6._UpdateSize(p39) -- name: _UpdateSize
	local v40 = p39.ScrollingFrame.AbsoluteWindowSize / p39.ScrollingFrame.AbsoluteCanvasSize
	if p39.AutoHide and p39.ScrollingFrame.AbsoluteWindowSize[p39.MoveDimension] >= p39.ScrollingFrame.AbsoluteCanvasSize[p39.MoveDimension] then
		p39.Hidden = true
		p39.ScrollBarFrame.Visible = false
	else
		p39.Hidden = false
		p39.ScrollBarFrame.Visible = p39.Visible
		if p39.MoveDimension == "X" then
			p39.Button.Size = UDim2.fromScale(v40.X, 1)
		else
			p39.Button.Size = UDim2.fromScale(1, v40.Y)
		end
	end
	p39:_UpdatePosition()
end
function v_u_6._UpdatePosition(p41) -- name: _UpdatePosition
	if p41.MoveDimension == "X" then
		p41.Button.Position = UDim2.new(p41.ScrollingFrame.CanvasPosition.X / p41.ScrollingFrame.AbsoluteCanvasSize.X, 0, 0.5, 0)
	else
		p41.Button.Position = UDim2.new(0.5, 0, p41.ScrollingFrame.CanvasPosition.Y / p41.ScrollingFrame.AbsoluteCanvasSize.Y, 0)
	end
end
function Lerp(p42, p43, p44) -- name: Lerp
	return p42 + (p43 - p42) * p44
end
return v_u_6