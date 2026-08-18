local v_u_1 = {
	["Stacks"] = false,
	["Refreshes"] = false
}
v_u_1.__index = v_u_1
function v_u_1.new() -- name: new
	-- upvalues: (copy) v_u_1
	local v2 = {}
	local v3 = v_u_1
	setmetatable(v2, v3)
	v2.Ticks = 0
	v2.MaxTicks = 30
	v2.ClientData = "1"
	return v2
end
function v_u_1.OnServerTick(p4, p5, p6) -- name: OnServerTick
	p4.Ticks = p4.Ticks + 1
	p4.ClientData = string.format("%.2f", 1 - p4.Ticks / p4.MaxTicks)
	p5:WaitForPlayerState(p6)
	if p4.Ticks >= p4.MaxTicks then
		return "Remove"
	end
end
function v_u_1.Destroy(p7) -- name: Destroy
	setmetatable(p7, nil)
	table.clear(p7)
	table.freeze(p7)
end
return v_u_1