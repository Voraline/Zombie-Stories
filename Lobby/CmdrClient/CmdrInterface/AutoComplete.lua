local v_u_1 = game:GetService("Players").LocalPlayer
return function(p2)
	-- upvalues: (copy) v_u_1
	local v_u_3 = {
		["Items"] = nil,
		["ItemOptions"] = nil,
		["SelectedItem"] = 0,
		["Items"] = {},
		["ItemOptions"] = {}
	}
	local v_u_4 = p2.Util
	local v_u_5 = v_u_1:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete")
	local v_u_6 = v_u_5:WaitForChild("TextButton")
	local v_u_7 = v_u_5:WaitForChild("Title")
	local v_u_8 = v_u_5:WaitForChild("Description")
	local v_u_9 = v_u_5.Parent:WaitForChild("Frame"):WaitForChild("Entry")
	v_u_6.Parent = nil
	local v_u_10 = v_u_5.ScrollBarThickness
	local function v_u_15(p11, p12, p13, p14) -- name: SetText
		-- upvalues: (copy) v_u_4
		p11.Visible = p13 ~= nil
		p12.Text = p13 or ""
		if p14 then
			p12.Size = UDim2.new(0, v_u_4.GetTextSize(p13 or "", p12, Vector2.new(1000, 1000), 1, 0).X, p11.Size.Y.Scale, p11.Size.Y.Offset)
		end
	end
	local function v_u_23() -- name: UpdateContainerSize
		-- upvalues: (copy) v_u_5, (copy) v_u_7
		local v16 = v_u_5
		local v17 = UDim2.new
		local v18 = v_u_7.Field.TextBounds.X + v_u_7.Field.Type.TextBounds.X
		local v19 = v_u_5.Size.X.Offset
		local v20 = math.max(v18, v19)
		local v21 = v_u_5.UIListLayout.AbsoluteContentSize.Y
		local v22 = v_u_5.Parent.AbsoluteSize.Y - v_u_5.AbsolutePosition.Y - 10
		v16.Size = v17(0, v20, 0, (math.min(v21, v22)))
	end
	local function v_u_31(p24) -- name: UpdateInfoDisplay
		-- upvalues: (copy) v_u_15, (copy) v_u_7, (copy) v_u_8, (copy) v_u_5, (copy) v_u_23, (copy) v_u_10
		v_u_15(v_u_7, v_u_7.Field, p24.name, true)
		local v25 = v_u_7.Field.Type
		local v26 = v_u_7.Field.Type
		local v27 = p24.type
		if v27 then
			v27 = ": " .. p24.type:sub(1, 1):upper() .. p24.type:sub(2)
		end
		v25.Visible = v27 ~= nil
		v26.Text = v27 or ""
		local v28 = v_u_8
		local v29 = v_u_8.Label
		local v30 = p24.description
		v28.Visible = v30 ~= nil
		v29.Text = v30 or ""
		v_u_8.Label.TextColor3 = p24.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
		v_u_8.Size = UDim2.new(1, 0, 0, 40)
		while not v_u_8.Label.TextFits do
			v_u_8.Size = v_u_8.Size + UDim2.new(0, 0, 0, 2)
			if v_u_8.Size.Y.Offset > 500 then
				break
			end
		end
		task.wait()
		v_u_5.UIListLayout:ApplyLayout()
		v_u_23()
		v_u_5.ScrollBarThickness = v_u_10
	end
	function v_u_3.Show(p32, p33, p34) -- name: Show
		-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_31
		local v35 = p34 or {}
		for _, v36 in pairs(p32.Items) do
			if v36.gui then
				v36.gui:Destroy()
			end
		end
		p32.SelectedItem = 1
		p32.Items = p33
		p32.Prefix = v35.prefix or ""
		p32.LastItem = v35.isLast or false
		p32.Command = v35.command
		p32.Arg = v35.arg
		p32.NumArgs = v35.numArgs
		p32.IsPartial = v35.isPartial
		v_u_5.ScrollBarThickness = 0
		local v37 = 200
		for v38, v39 in pairs(p32.Items) do
			local v40 = v39[1]
			local v41 = v39[2]
			local v42 = v_u_6:Clone()
			v42.Name = v40 .. v41
			v42.BackgroundTransparency = v38 == p32.SelectedItem and 0.5 or 1
			local v43, v44 = string.find(v41:lower(), v40:lower(), 1, true)
			v42.Typed.Text = string.rep(" ", v43 - 1) .. v40
			local v45 = v42.Suggest
			local v46 = v43 - 1
			local v47 = string.sub(v41, 0, v46)
			local v48 = string.rep(" ", #v40)
			local v49 = v44 + 1
			v45.Text = v47 .. v48 .. string.sub(v41, v49)
			v42.Parent = v_u_5
			v42.LayoutOrder = v38
			local v50 = v42.Typed.TextBounds.X
			local v51 = v42.Suggest.TextBounds.X
			local v52 = math.max(v50, v51) + 20
			if v37 < v52 then
				v37 = v52
			end
			v39.gui = v42
		end
		v_u_5.UIListLayout:ApplyLayout()
		local v53 = v_u_9.TextBox.Text
		local v54 = v_u_4.SplitString(v53)
		if v53:sub(#v53, #v53) == " " and not v35.at then
			v54[#v54 + 1] = "e"
		end
		table.remove(v54, #v54)
		local v55 = (v35.at and v35.at or #table.concat(v54, " ") + 1) * 7
		v_u_5.Position = UDim2.new(0, v_u_9.TextBox.AbsolutePosition.X - 10 + v55, 0, v_u_9.TextBox.AbsolutePosition.Y + 30)
		v_u_5.Size = UDim2.new(0, v37, 0, v_u_5.UIListLayout.AbsoluteContentSize.Y)
		v_u_5.Visible = true
		local v56 = v_u_31
		if p32.Items[1] then
			v35 = p32.Items[1].options or v35
		end
		v56(v35)
	end
	function v_u_3.GetSelectedItem(_) -- name: GetSelectedItem
		-- upvalues: (copy) v_u_5, (copy) v_u_3
		if v_u_5.Visible == false then
			return nil
		else
			return v_u_3.Items[v_u_3.SelectedItem]
		end
	end
	function v_u_3.Hide(_) -- name: Hide
		-- upvalues: (copy) v_u_5
		v_u_5.Visible = false
	end
	function v_u_3.IsVisible(_) -- name: IsVisible
		-- upvalues: (copy) v_u_5
		return v_u_5.Visible
	end
	function v_u_3.Select(p57, p58) -- name: Select
		-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_8, (copy) v_u_6, (copy) v_u_31
		if v_u_5.Visible then
			p57.SelectedItem = p57.SelectedItem + p58
			if p57.SelectedItem > #p57.Items then
				p57.SelectedItem = 1
			elseif p57.SelectedItem < 1 then
				p57.SelectedItem = #p57.Items
			end
			for v59, v60 in pairs(p57.Items) do
				v60.gui.BackgroundTransparency = v59 == p57.SelectedItem and 0.5 or 1
			end
			local v61 = v_u_5
			local v62 = Vector2.new
			local v63 = v_u_7.Size.Y.Offset + v_u_8.Size.Y.Offset + p57.SelectedItem * v_u_6.Size.Y.Offset - v_u_5.Size.Y.Offset
			v61.CanvasPosition = v62(0, (math.max(0, v63)))
			if p57.Items[p57.SelectedItem] and p57.Items[p57.SelectedItem].options then
				v_u_31(p57.Items[p57.SelectedItem].options or {})
			end
		end
	end
	v_u_5.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(v_u_23)
	return v_u_3
end