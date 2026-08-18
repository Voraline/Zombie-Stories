local v_u_1 = game:GetService("TweenService")
local v_u_2 = TweenInfo.new(0)
local v3 = {
	["Cache"] = {}
}
local v_u_4 = {
	"BackgroundTransparency",
	"ImageTransparency",
	"TextTransparency",
	"TextStrokeTransparency"
}
local function v_u_9(p_u_5, p6) -- name: CreateCache
	-- upvalues: (copy) v_u_4
	local v7 = {}
	for _, v_u_8 in next, v_u_4 do
		if pcall(function()
			-- upvalues: (copy) p_u_5, (copy) v_u_8
			return p_u_5[v_u_8]
		end) then
			v7[v_u_8] = p_u_5[v_u_8]
		end
	end
	p6[p_u_5] = v7
end
local function v_u_19(p10, p11, p12) -- name: Set
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	for v13, v14 in next, p10 do
		local v15 = {}
		for v16, v17 in next, v14 do
			v15[v16] = v17 + (1 - v17) * p11
		end
		local v_u_18 = v_u_1:Create(v13, p12 or v_u_2, v15)
		v_u_18:Play()
		v_u_18.Completed:Connect(function()
			-- upvalues: (copy) v_u_18
			v_u_18:Destroy()
		end)
	end
end
function v3.Revert(p20, p21, p22) -- name: Revert
	-- upvalues: (copy) v_u_19
	local v23 = p20.Cache[p21]
	if v23 then
		v_u_19(v23, 0, p22)
	end
end
function v3.SetTransparency(p24, p25, p26, p27) -- name: SetTransparency
	-- upvalues: (copy) v_u_9, (copy) v_u_19
	local v28 = p24.Cache[p25]
	if not v28 then
		v28 = {}
		v_u_9(p25, v28)
		local v29 = next
		local v30, v31 = p25:GetDescendants()
		for _, v32 in v29, v30, v31 do
			v_u_9(v32, v28)
		end
		p24.Cache[p25] = v28
	end
	v_u_19(v28, p26, p27)
end
return v3