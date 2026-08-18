local v1 = game:GetService("RunService")
local v_u_2 = v1:IsServer()
v1:IsClient()
local v3 = script.Parent.Parent.StatusEffects
local v_u_4 = {}
local v_u_5 = {}
local function v_u_14(p6) -- name: createIconLabel
	if p6.Label then
		return p6.Label
	end
	local v7 = p6.Icon
	local v8 = p6.ShowPotency
	local v9 = p6.ShowCount
	local v10 = Instance.new("ImageLabel")
	v10.Name = "ImageLabel"
	v10.Image = "rbxassetid://" .. v7
	v10.AnchorPoint = Vector2.new(0.5, 0.5)
	v10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v10.BackgroundTransparency = 1
	v10.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v10.BorderSizePixel = 0
	v10.Size = UDim2.fromScale(0.65, 0.65)
	local v11 = Instance.new("UIAspectRatioConstraint")
	v11.Name = "UIAspectRatioConstraint"
	v11.Parent = v10
	local v12 = Instance.new("TextLabel")
	v12.Name = "Count"
	v12.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	v12.Text = p6.Count
	v12.TextColor3 = Color3.fromRGB(255, 255, 255)
	v12.TextScaled = true
	v12.TextSize = 14
	v12.TextStrokeTransparency = 0
	v12.TextWrapped = true
	v12.AnchorPoint = Vector2.new(1, 1)
	v12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v12.BackgroundTransparency = 1
	v12.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v12.BorderSizePixel = 0
	v12.Position = UDim2.fromScale(1, 1.15)
	v12.Size = UDim2.fromScale(0.45, 0.45)
	v12.Visible = v9
	v12.Parent = v10
	local v13 = Instance.new("TextLabel")
	v13.Name = "Potency"
	v13.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	v13.Text = p6.Potency
	v13.TextColor3 = Color3.fromRGB(255, 255, 255)
	v13.TextScaled = true
	v13.TextSize = 14
	v13.TextStrokeTransparency = 0
	v13.TextWrapped = true
	v13.AnchorPoint = Vector2.new(0, 1)
	v13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v13.BackgroundTransparency = 1
	v13.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v13.BorderSizePixel = 0
	v13.Position = UDim2.fromScale(0, 1.15)
	v13.Size = UDim2.fromScale(0.45, 0.45)
	v13.Visible = v8
	v13.Parent = v10
	p6.Label = v10
	p6.AddConnection(v10, "Destroy")
	return v10
end
function v_u_4.GetIconLabel(p15) -- name: GetIconLabel
	-- upvalues: (copy) v_u_14
	return v_u_14(p15)
end
function v_u_4.GetStatusEffect(p16) -- name: GetStatusEffect
	-- upvalues: (copy) v_u_5
	return v_u_5[p16]
end
function v_u_4.ConstructEffect(p17, p18, p19) -- name: ConstructEffect
	-- upvalues: (copy) v_u_4
	return v_u_4.GetStatusEffect(p17)(p19, (v_u_4.GetStatusEffect("BaseEffect")(p19, p18)))
end
function v_u_4.ApplyEffect(p_u_20, p_u_21, p22) -- name: ApplyEffect
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	if not p_u_20.CurrentEffects then
		p_u_20.CurrentEffects = {}
		p_u_20.Died:Once(function()
			-- upvalues: (copy) p_u_20
			for _, v23 in p_u_20.CurrentEffects do
				v23:Destroy()
			end
			p_u_20.CurrentEffects = nil
		end)
	end
	local v24 = p_u_20.CurrentEffects[p_u_21]
	if p_u_20.CurrentEffects[p_u_21] then
		if v_u_2 then
			if p22.Count then
				local v25 = p_u_20.CurrentEffects[p_u_21].Count + (p22.Count or 1)
				local v26 = v24.CountCeiling or 99
				v24.Count = math.clamp(v25, 0, v26)
			end
			if p22.Potency then
				local v27 = p_u_20.CurrentEffects[p_u_21].Potency + (p22.Potency or 1)
				local v28 = v24.PotencyCeiling or 99
				v24.Potency = math.clamp(v27, 0, v28)
			end
		end
	else
		local v29 = v_u_4.ConstructEffect(p_u_21, p_u_20, p22)
		v29.Potency = p22.StartPotency or v29.Potency
		v29.Count = p22.StartCount or v29.Count
		function v29.clearFunc()
			-- upvalues: (copy) p_u_20, (copy) p_u_21
			if p_u_20.CurrentEffects and not p_u_20.IsDead then
				p_u_20:RemoveEffect(p_u_21)
			end
		end
		p_u_20.CurrentEffects[p_u_21] = v29
		p_u_20.StatusUpdated:Fire("Apply", v29)
	end
	if v24 and v_u_2 then
		v24:UpdateIcon()
	end
end
function v_u_4.RemoveEffect(p30, p31) -- name: RemoveEffect
	local v32 = p30.CurrentEffects and p30.CurrentEffects[p31]
	if v32 then
		p30.StatusUpdated:Fire("Remove", v32)
		p30.CurrentEffects[p31] = nil
		v32:Destroy()
	end
end
for _, v33 in v3:GetChildren() do
	v_u_5[v33.Name] = require(v33)
end
return v_u_4