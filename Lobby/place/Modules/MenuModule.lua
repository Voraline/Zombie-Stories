local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = {}
local v_u_3 = {}
function v_u_1.new(p4, p5, p6, p7) -- name: new
	-- upvalues: (copy) v_u_1
	local v8 = {
		["SubMenus"] = {},
		["CloseWithParent"] = p5 or false,
		["UI"] = p4,
		["IsOpen"] = p7
	}
	local v9 = v_u_1
	setmetatable(v8, v9)
	if p6 then
		v8:SetZone(p6)
	end
	return v8
end
function v_u_1.closeByZone(p10) -- name: closeByZone
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if v_u_2[p10] then
		for _, v11 in pairs(v_u_2[p10]) do
			if v11.IsOpen then
				v11.IsOpen = false
				v11:Close()
			end
		end
	end
	if v_u_3[p10] then
		for _, v12 in pairs(v_u_3[p10]) do
			v12.Visible = false
		end
	end
end
function v_u_1.hideWhenZoneClosed(p13, p14) -- name: hideWhenZoneClosed
	-- upvalues: (copy) v_u_3
	if not v_u_3[p14] then
		v_u_3[p14] = {}
	end
	local v15 = v_u_3[p14]
	table.insert(v15, p13)
end
function v_u_1.SetOpenFunction(p16, p17) -- name: SetOpenFunction
	p16.OpenFunction = p17
end
function v_u_1.SetCloseFunction(p18, p19) -- name: SetCloseFunction
	p18.CloseFunction = p19
end
function v_u_1.Open(p20) -- name: Open
	if p20.OpenFunction then
		p20.IsOpen = true
		p20.OpenFunction()
	end
end
function v_u_1.Close(p21) -- name: Close
	if p21.CloseFunction then
		p21.IsOpen = false
		p21.CloseFunction()
	end
	for _, v22 in pairs(p21.SubMenus) do
		if v22.CloseWithParent then
			p21.IsOpen = false
			v22:Close()
		end
	end
end
function v_u_1.AddSubMenu(p23, p24) -- name: AddSubMenu
	local v25 = p23.SubMenus
	table.insert(v25, p24)
end
function v_u_1.SetZone(p26, p27) -- name: SetZone
	-- upvalues: (copy) v_u_2
	p26.Zone = p27
	if not v_u_2[p27] then
		v_u_2[p27] = {}
	end
	local v28 = v_u_2[p27]
	table.insert(v28, p26)
end
function v_u_1.SetUI(p29, p30) -- name: SetUI
	p29.UI = p30
end
function v_u_1.GetUI(p31) -- name: GetUI
	return p31.UI
end
return v_u_1