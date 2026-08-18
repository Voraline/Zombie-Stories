local v_u_1 = game:GetService("UserInputService")
local v2 = {}
local v_u_3 = {
	["__index"] = v2
}
function v2.new() -- name: new
	-- upvalues: (copy) v_u_3
	local v4 = v_u_3
	return setmetatable({
		["connections"] = {}
	}, v4)
end
function v2.BindToInput(p5, p_u_6, p_u_7, ...) -- name: BindToInput
	-- upvalues: (copy) v_u_1
	local v8 = { ... }
	p5.connections[p_u_6] = {}
	for v9 = 1, #v8 do
		local v_u_10 = v8[v9]
		p5.connections[p_u_6][v_u_10] = { v_u_1.InputBegan:Connect(function(p11, _)
				-- upvalues: (copy) v_u_10, (copy) p_u_7, (copy) p_u_6
				if p11.KeyCode == v_u_10 then
					p_u_7(p_u_6, p11.UserInputState, p11)
				end
			end), v_u_1.InputChanged:Connect(function(p12, _)
				-- upvalues: (copy) v_u_10, (copy) p_u_7, (copy) p_u_6
				if p12.KeyCode == v_u_10 then
					p_u_7(p_u_6, p12.UserInputState, p12)
				end
			end), v_u_1.InputEnded:Connect(function(p13, _)
				-- upvalues: (copy) v_u_10, (copy) p_u_7, (copy) p_u_6
				if p13.KeyCode == v_u_10 then
					p_u_7(p_u_6, p13.UserInputState, p13)
				end
			end) }
	end
end
function v2.UnbindAction(p14, p15) -- name: UnbindAction
	for _, v16 in next, p14.connections[p15] do
		for v17 = 1, #v16 do
			v16[v17]:Disconnect()
		end
	end
	p14.connections[p15] = nil
end
return v2.new()