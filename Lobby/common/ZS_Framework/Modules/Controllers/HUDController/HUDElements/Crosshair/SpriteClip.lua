local v_u_1 = Vector2.new
local v_u_2 = next
local v_u_3 = newproxy
local v_u_4 = getmetatable
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = false
local v_u_9 = 0
local v_u_10 = 0
game:GetService("RunService").Heartbeat:Connect(function(p11)
	-- upvalues: (ref) v_u_10, (ref) v_u_9, (copy) v_u_7
	v_u_10 = v_u_10 + p11
	while v_u_10 >= 0.016666666666666666 do
		v_u_10 = v_u_10 - 0.016666666666666666
		v_u_9 = v_u_9 + 1
		if v_u_7[1] then
			for v12 = 1, #v_u_7 do
				local v13 = v_u_7[v12]
				if v13.State and v_u_9 % v13.FrameTime == 0 then
					v13:Advance(1)
				end
			end
		end
	end
end)
function v_u_6.Play(p14)
	if p14.State then
		p14.CurrentFrame = 0
		return false
	end
	if not p14.Adornee then
		error("SpriteClip: No Instance assigned to this SpriteClip.")
		return false
	end
	p14.CurrentFrame = 0
	p14.State = true
	return true
end
function v_u_6.Pause(p15)
	if p15.State then
		p15.State = false
	end
	return false
end
function v_u_6.Stop(p16)
	p16:Pause()
	p16.CurrentFrame = 0
	return true
end
function v_u_6.Advance(p17, p18)
	-- upvalues: (copy) v_u_1
	local v19 = p17.CurrentFrame + (p18 or 1)
	if p17.SpriteCount - 1 < v19 then
		if not p17.Looped then
			p17:Stop()
			return
		end
		v19 = 0
	end
	p17.CurrentFrame = v19
	local v20 = p17.SpriteSizePixel
	local v21 = v20.X
	local v22 = v20.Y
	local v23 = p17.SpriteOffsetPixel
	local v24 = v23.X
	local v25 = v23.Y
	local v26 = p17.EdgeOffsetPixel
	local v27 = p17.SpriteCountX
	local _ = p17.SpriteCount
	local v28 = v19 % v27
	local v29 = (v19 - v28) / v27
	local v30 = v26.X + v28 * (v21 + v24)
	local v31 = v26.Y + v29 * (v22 + v25)
	p17.Adornee.ImageRectOffset = v_u_1(v30, v31)
end
function v_u_5.new()
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_6, (copy) v_u_3, (copy) v_u_4, (ref) v_u_8, (copy) v_u_7, (copy) v_u_5
	local v_u_32 = {
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
	for v33, v34 in v_u_2, v_u_6 do
		v_u_32[v33] = v34
	end
	local v35 = v_u_3(true)
	local v_u_36 = v_u_4(v35)
	v_u_36.__index = v_u_32
	function v_u_36.__newindex(_, p37, p38)
		-- upvalues: (copy) v_u_32
		v_u_32[p37] = p38
		if p37 == "Adornee" or p37 == "SpriteSizePixel" then
			local v39 = v_u_32.Adornee
			local v40 = v_u_32.SpriteSizePixel
			if v39 then
				v39.ImageRectSize = v40
			end
			if p37 == "Adornee" then
				if v_u_32.InheritSpriteSheet then
					v_u_32.SpriteSheet = v39.Image
				else
					v39.Image = v_u_32.SpriteSheet
				end
			end
		elseif p37 == "SpriteSheet" then
			if v_u_32.Adornee then
				v_u_32.Adornee.Image = p38
				return
			end
		elseif p37 == "FrameRate" then
			v_u_32.FrameTime = 60 / p38
		end
	end
	v_u_36.__metatable = "The metatable is locked"
	function v_u_32.Destroy(p41)
		-- upvalues: (ref) v_u_8, (ref) v_u_7, (copy) v_u_32, (ref) v_u_2, (copy) v_u_36
		p41:Pause()
		while v_u_8 do
			wait()
		end
		v_u_8 = true
		for v42 = 1, #v_u_7 do
			if v_u_7[v42] == v_u_32 then
				local v43 = v_u_7
				local v44 = v_u_7
				local v45 = #v_u_7
				v43[v42] = v_u_7[#v_u_7]
				v44[v45] = nil
			end
		end
		v_u_8 = false
		for v46 in v_u_2, v_u_36 do
			v_u_36[v46] = nil
		end
	end
	function v_u_32.Clone(_)
		-- upvalues: (ref) v_u_5, (ref) v_u_2, (copy) v_u_32
		local v47 = v_u_5.new()
		for v48, v49 in v_u_2, v_u_32 do
			if v49 ~= "Adornee" then
				v47[v48] = v49
			end
		end
		return v47
	end
	v_u_7[#v_u_7 + 1] = v_u_32
	return v35
end
return v_u_5