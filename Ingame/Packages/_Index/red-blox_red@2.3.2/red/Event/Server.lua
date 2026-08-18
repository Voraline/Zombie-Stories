local v_u_1 = game:GetService("Players")
local v_u_2 = require(script.Parent.Parent.Parent.Spawn)
local v_u_3 = require(script.Parent.Parent.Net)
local function v_u_6(p4, p5, ...) -- name: Fire
	-- upvalues: (copy) v_u_3
	if p4.Unreliable then
		v_u_3.Server.SendUnreliableEvent(p5, p4.Id, table.pack(...))
	else
		v_u_3.Server.SendReliableEvent(p5, p4.Id, table.pack(...))
	end
end
local function v_u_10(p7, ...) -- name: FireAll
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v8 = table.pack(...)
	for _, v9 in v_u_1:GetPlayers() do
		if p7.Unreliable then
			v_u_3.Server.SendUnreliableEvent(v9, p7.Id, v8)
		else
			v_u_3.Server.SendReliableEvent(v9, p7.Id, v8)
		end
	end
end
local function v_u_15(p11, p12, ...) -- name: FireAllExcept
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v13 = table.pack(...)
	for _, v14 in v_u_1:GetPlayers() do
		if v14 ~= p12 then
			if p11.Unreliable then
				v_u_3.Server.SendUnreliableEvent(v14, p11.Id, v13)
			else
				v_u_3.Server.SendReliableEvent(v14, p11.Id, v13)
			end
		end
	end
end
local function v_u_20(p16, p17, ...) -- name: FireList
	-- upvalues: (copy) v_u_3
	local v18 = table.pack(...)
	for _, v19 in p17 do
		if p16.Unreliable then
			v_u_3.Server.SendUnreliableEvent(v19, p16.Id, v18)
		else
			v_u_3.Server.SendReliableEvent(v19, p16.Id, v18)
		end
	end
end
local function v_u_25(p21, p22, ...) -- name: FireWithFilter
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v23 = table.pack(...)
	for _, v24 in v_u_1:GetPlayers() do
		if p22(v24) then
			if p21.Unreliable then
				v_u_3.Server.SendUnreliableEvent(v24, p21.Id, v23)
			else
				v_u_3.Server.SendReliableEvent(v24, p21.Id, v23)
			end
		end
	end
end
local function v_u_32(p_u_26, p_u_27) -- name: On
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3.Server.SetListener(p_u_26.Id, function(p28, p29)
		-- upvalues: (ref) v_u_2, (copy) p_u_27, (copy) p_u_26
		v_u_2(function(p30, p31, ...)
			-- upvalues: (ref) p_u_27
			if pcall(p30.Validate, ...) then
				p_u_27(p31, ...)
			end
		end, p_u_26, p28, table.unpack(p29))
	end)
end
return function(p33, p34, p35) -- name: Server
	-- upvalues: (copy) v_u_6, (copy) v_u_10, (copy) v_u_15, (copy) v_u_20, (copy) v_u_25, (copy) v_u_32
	return {
		["Id"] = p33,
		["Validate"] = p34,
		["Unreliable"] = p35,
		["Fire"] = v_u_6,
		["FireAll"] = v_u_10,
		["FireAllExcept"] = v_u_15,
		["FireList"] = v_u_20,
		["FireWithFilter"] = v_u_25,
		["On"] = v_u_32
	}
end