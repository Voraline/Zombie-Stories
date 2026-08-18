local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.common:FindFirstChild("Fusion", true))
local v_u_3 = v2.New
local _ = v2.Children
local _ = v2.OnEvent
local _ = v2.OnChange
local _ = v2.Out
local _ = v2.Ref
local _ = v2.Value
local v4 = v2.Observer
local _ = v2.Computed
local _ = v2.ForPairs
local _ = v2.Spring
local v_u_5 = {}
for _, v6 in pairs(script.Syntaxes:GetChildren()) do
	v_u_5[v6.Name:lower()] = require(v6)
end
local v_u_7 = require("./theme")
local v_u_8 = {
	["background"] = "scriptBackground",
	["iden"] = "scriptText",
	["keyword"] = "scriptKeyword",
	["builtin"] = "scriptBuiltin",
	["string"] = "scriptString",
	["number"] = "scriptNumber",
	["comment"] = "scriptComment",
	["operator"] = "scriptOperator",
	["custom"] = "scriptCustom",
	["raw"] = "scriptText",
	["text"] = "scriptText",
	["header"] = "scriptBuiltin",
	["quote"] = "scriptString",
	["list"] = "scriptNumber",
	["ruler"] = "scriptComment",
	["code"] = "scriptKeyword"
}
local v_u_9 = table.create(7)
local v_u_10 = table.create(3)
local function v_u_12(p11) -- name: SanitizeRichText
	return string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(p11, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;"), "\'", "&apos;")
end
local function v_u_49(p_u_13, p14, p15) -- name: highlight
	-- upvalues: (copy) v_u_10, (copy) v_u_3, (copy) v_u_7, (copy) v_u_5, (copy) v_u_12, (copy) v_u_8, (copy) v_u_9, (copy) v_u_49
	local v16 = p14 or p_u_13.Text
	local v17 = string.gsub(v16, "[\0\1\2\3\4\5\6\7\8\11\f\r\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31]+", "")
	local v_u_18 = string.gsub(v17, "\t", "    ")
	local v_u_19 = string.lower(p15 or (p_u_13:GetAttribute("syntax") or "lua"))
	p_u_13:SetAttribute("syntax", v_u_19)
	p_u_13.RichText = false
	p_u_13.Text = v_u_18
	p_u_13.TextXAlignment = Enum.TextXAlignment.Left
	p_u_13.TextYAlignment = Enum.TextYAlignment.Top
	local v20 = p_u_13.TextSize
	local _, v21 = string.gsub(v_u_18, "\n", "")
	local v22 = v21 + 1
	local v23 = p_u_13.TextBounds.Y / v22
	local v_u_24 = v_u_10[p_u_13]
	if v_u_24 then
		local v25 = #v_u_24
		for v26 = 1, math.max(v22, v25) do
			local v27 = v_u_24[v26]
			if not v27 then
				v27 = v_u_3("TextLabel")({
					["Name"] = nil,
					["RichText"] = true,
					["BackgroundTransparency"] = 1,
					["TextXAlignment"] = nil,
					["TextYAlignment"] = nil,
					["TextColor3"] = nil,
					["Font"] = nil,
					["Parent"] = nil,
					["Name"] = "Line_" .. v26,
					["TextXAlignment"] = Enum.TextXAlignment.Left,
					["TextYAlignment"] = Enum.TextYAlignment.Top,
					["TextColor3"] = v_u_7.scriptText,
					["Font"] = p_u_13.Font,
					["Parent"] = p_u_13
				})
				v_u_24[v26] = v27
			end
			v27.Text = ""
			v27.TextSize = v20
			v27.Size = UDim2.new(1, 0, 0, (math.ceil(v23)))
			v27.Position = UDim2.fromScale(0, v23 * (v26 - 1) / p_u_13.AbsoluteSize.Y)
		end
	else
		v_u_24 = table.create(v22)
		for v28 = 1, v22 do
			v_u_24[v28] = v_u_3("TextLabel")({
				["Name"] = nil,
				["RichText"] = true,
				["BackgroundTransparency"] = 1,
				["TextXAlignment"] = nil,
				["TextYAlignment"] = nil,
				["TextColor3"] = nil,
				["Font"] = nil,
				["TextSize"] = nil,
				["Size"] = nil,
				["Position"] = nil,
				["Text"] = "",
				["Parent"] = nil,
				["Name"] = "Line_" .. v28,
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["TextYAlignment"] = Enum.TextYAlignment.Top,
				["TextColor3"] = v_u_7.scriptText,
				["Font"] = p_u_13.Font,
				["TextSize"] = v20,
				["Size"] = UDim2.new(1, 0, 0, (math.ceil(v23))),
				["Position"] = UDim2.fromScale(0, v23 * (v28 - 1) / p_u_13.AbsoluteSize.Y),
				["Parent"] = p_u_13
			})
		end
	end
	local v29 = 1
	local v30 = {}
	local v31 = 0
	for v32, v33 in (v_u_5[v_u_19] or v_u_5.lua).scan(v_u_18) do
		local v34 = string.split(v_u_12(v33), "\n")
		for v35, v36 in ipairs(v34) do
			if v35 > 1 then
				v_u_24[v29].Text = table.concat(v30)
				v29 = v29 + 1
				table.clear(v30)
				v31 = 0
			end
			v31 = v31 + 1
			if v_u_8[v32] == "scriptText" or not string.find(v36, "[%S%C]") then
				v30[v31] = v36
			else
				v30[v31] = string.format(v_u_9[v32], v36)
			end
		end
	end
	v_u_24[v29].Text = table.concat(v30)
	v_u_10[p_u_13] = v_u_24
	local v_u_37 = {}
	local function v_u_40() -- name: clean
		-- upvalues: (ref) v_u_24, (ref) v_u_10, (copy) p_u_13, (ref) v_u_37
		for _, v38 in ipairs(v_u_24) do
			v38:Destroy()
		end
		table.clear(v_u_24)
		v_u_10[p_u_13] = nil
		for _, v39 in ipairs(v_u_37) do
			v39:Disconnect()
		end
		v_u_37 = nil
	end
	local v41 = v_u_37
	local v42 = p_u_13.AncestryChanged
	table.insert(v41, v42:Connect(function()
		-- upvalues: (copy) p_u_13, (copy) v_u_40
		if not p_u_13:IsDescendantOf(game) then
			v_u_40()
		end
	end))
	local v43 = v_u_37
	local v44 = p_u_13:GetPropertyChangedSignal("TextBounds")
	local function v45()
		-- upvalues: (ref) v_u_49, (copy) p_u_13, (ref) v_u_18, (ref) v_u_19
		v_u_49(p_u_13, v_u_18, v_u_19)
	end
	table.insert(v43, v44:Connect(v45))
	local v46 = v_u_37
	local v47 = p_u_13:GetPropertyChangedSignal("AbsoluteSize")
	local function v48()
		-- upvalues: (ref) v_u_49, (copy) p_u_13, (ref) v_u_18, (ref) v_u_19
		v_u_49(p_u_13, v_u_18, v_u_19)
	end
	table.insert(v46, v47:Connect(v48))
	return v_u_40
end
local function v_u_54() -- name: updateColors
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10, (copy) v_u_49
	for v50, v51 in pairs(v_u_8) do
		local v52 = v_u_7[v51]:get(false)
		v_u_9[v50] = "<font color=\"#" .. string.format("%.2x%.2x%.2x", v52.R * 255, v52.G * 255, v52.B * 255) .. "\">%s</font>"
	end
	for v53 in pairs(v_u_10) do
		v_u_49(v53, v53.Text, v53:GetAttribute("syntax"))
	end
end
pcall(v_u_54)
for v55, v56 in pairs(v_u_7) do
	if string.match(v55, "^script") then
		v4(v56):onChange(function()
			-- upvalues: (copy) v_u_54
			task.defer(pcall, v_u_54)
		end)
	end
end
return {
	["UpdateColors"] = v_u_54,
	["Highlight"] = v_u_49
}