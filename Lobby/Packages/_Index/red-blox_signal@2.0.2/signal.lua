local v_u_1 = require(script.Parent.Spawn)
local v_u_2 = {}
v_u_2.__index = v_u_2
local function v_u_6(p3, p4) -- name: Disconnect
	if p3.Root == p4 then
		p3.Root = p4.Next
	else
		local v5 = p3.Root
		while v5 do
			if v5.Next == p4 then
				v5.Next = p4.Next
				return
			end
			v5 = v5.Next
		end
	end
end
function v_u_2.Connect(p_u_7, p8) -- name: Connect
	-- upvalues: (copy) v_u_6
	local v_u_9 = {
		["Next"] = p_u_7.Root,
		["Callback"] = p8
	}
	p_u_7.Root = v_u_9
	return function()
		-- upvalues: (ref) v_u_6, (copy) p_u_7, (copy) v_u_9
		v_u_6(p_u_7, v_u_9)
	end
end
function v_u_2.Wait(p10) -- name: Wait
	local v_u_11 = coroutine.running()
	local v_u_12 = nil
	v_u_12 = p10:Connect(function(...)
		-- upvalues: (ref) v_u_12, (copy) v_u_11
		v_u_12()
		coroutine.resume(v_u_11, ...)
	end)
	return coroutine.yield()
end
function v_u_2.Once(p13, p_u_14) -- name: Once
	local v_u_15 = nil
	v_u_15 = p13:Connect(function(...)
		-- upvalues: (ref) v_u_15, (copy) p_u_14
		v_u_15()
		p_u_14(...)
	end)
	return v_u_15
end
function v_u_2.Fire(p16, ...) -- name: Fire
	-- upvalues: (copy) v_u_1
	local v17 = p16.Root
	while v17 do
		v_u_1(v17.Callback, ...)
		v17 = v17.Next
	end
end
function v_u_2.DisconnectAll(p18) -- name: DisconnectAll
	p18.Root = nil
end
return function()
	-- upvalues: (copy) v_u_2
	local v19 = v_u_2
	return setmetatable({
		["Root"] = nil
	}, v19)
end