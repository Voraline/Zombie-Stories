local v_u_1 = Vector2.new
local v_u_2 = next
local v_u_3 = newproxy
local v_u_4 = getmetatable
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = false
local v_u_9 = 0
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_9, (copy) v_u_7
	v_u_9 = v_u_9 + 1
	if v_u_7[1] then
		for v10 = 1, #v_u_7 do
			local v11 = v_u_7[v10]
			if v11.State and v_u_9 % v11.FrameTime == 0 then
				v11:Advance(1)
			end
		end
	end
end)
function v_u_6.Play(p12)
	if p12.State then
		p12.CurrentFrame = 0
		return false
	end
	if not p12.Adornee then
		error("SpriteClip: No Instance assigned to this SpriteClip.")
		return false
	end
	p12.CurrentFrame = 0
	p12.State = true
	return true
end
function v_u_6.Pause(p13)
	if p13.State then
		p13.State = false
	end
	return false
end
function v_u_6.Stop(p14)
	p14:Pause()
	p14.CurrentFrame = 0
	return true
end
function v_u_6.Advance(p15, p16)
	-- upvalues: (copy) v_u_1
	local v17 = p15.CurrentFrame + (p16 or 1)
	if p15.SpriteCount - 1 < v17 then
		if not p15.Looped then
			p15:Stop()
			return
		end
		v17 = 0
	end
	p15.CurrentFrame = v17
	local v18 = p15.SpriteSizePixel
	local v19 = v18.X
	local v20 = v18.Y
	local v21 = p15.SpriteOffsetPixel
	local v22 = v21.X
	local v23 = v21.Y
	local v24 = p15.EdgeOffsetPixel
	local v25 = p15.SpriteCountX
	local _ = p15.SpriteCount
	local v26 = v17 % v25
	local v27 = (v17 - v26) / v25
	local v28 = v24.X + v26 * (v19 + v22)
	local v29 = v24.Y + v27 * (v20 + v23)
	p15.Adornee.ImageRectOffset = v_u_1(v28, v29)
end
function v_u_5.new()
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_6, (copy) v_u_3, (copy) v_u_4, (ref) v_u_8, (copy) v_u_7, (copy) v_u_5
	local v_u_30 = {
		["Adornee"] = nil,
		["SpriteSheet"] = nil,
		["InheritSpriteSheet"] = true,
		["CurrentFrame"] = 0,
		["SpriteSizePixel"] = nil,
		["EdgeOffsetPixel"] = nil,
		["SpriteOffsetPixel"] = nil,
		["SpriteCount"] = 25,
		["SpriteCountX"] = 5,
		["FrameRate"] = 15,
		["FrameTime"] = 4,
		["Looped"] = true,
		["State"] = false,
		["Sorted"] = true,
		["SpriteSizePixel"] = v_u_1(100, 100),
		["EdgeOffsetPixel"] = v_u_1(0, 0),
		["SpriteOffsetPixel"] = v_u_1(0, 0)
	}
	for v31, v32 in v_u_2, v_u_6 do
		v_u_30[v31] = v32
	end
	local v33 = v_u_3(true)
	local v_u_34 = v_u_4(v33)
	v_u_34.__index = v_u_30
	function v_u_34.__newindex(_, p35, p36)
		-- upvalues: (copy) v_u_30
		v_u_30[p35] = p36
		if p35 == "Adornee" or p35 == "SpriteSizePixel" then
			local v37 = v_u_30.Adornee
			local v38 = v_u_30.SpriteSizePixel
			if v37 then
				v37.ImageRectSize = v38
			end
			if p35 == "Adornee" then
				if v_u_30.InheritSpriteSheet then
					v_u_30.SpriteSheet = v37.Image
				else
					v37.Image = v_u_30.SpriteSheet
				end
			end
		elseif p35 == "SpriteSheet" then
			if v_u_30.Adornee then
				v_u_30.Adornee.Image = p36
				return
			end
		elseif p35 == "FrameRate" then
			v_u_30.FrameTime = 60 / p36
		end
	end
	v_u_34.__metatable = "The metatable is locked"
	function v_u_30.Destroy(p39)
		-- upvalues: (ref) v_u_8, (ref) v_u_7, (copy) v_u_30, (ref) v_u_2, (copy) v_u_34
		p39:Pause()
		while v_u_8 do
			wait()
		end
		v_u_8 = true
		for v40 = 1, #v_u_7 do
			if v_u_7[v40] == v_u_30 then
				local v41 = v_u_7
				local v42 = v_u_7
				local v43 = #v_u_7
				v41[v40] = v_u_7[#v_u_7]
				v42[v43] = nil
			end
		end
		v_u_8 = false
		for v44 in v_u_2, v_u_34 do
			v_u_34[v44] = nil
		end
	end
	function v_u_30.Clone(_)
		-- upvalues: (ref) v_u_5, (ref) v_u_2, (copy) v_u_30
		local v45 = v_u_5.new()
		for v46, v47 in v_u_2, v_u_30 do
			if v47 ~= "Adornee" then
				v45[v46] = v47
			end
		end
		return v45
	end
	v_u_7[#v_u_7 + 1] = v_u_30
	return v33
end
return v_u_5