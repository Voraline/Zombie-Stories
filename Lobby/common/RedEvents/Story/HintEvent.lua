local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = {
	["Image"] = true,
	["Paper"] = true
}
local v_u_3 = {
	["Show"] = true,
	["Hide"] = true
}
local function v_u_7(p_u_4) -- name: sanitizeFont
	if typeof(p_u_4) == "EnumItem" and p_u_4.EnumType == Enum.Font then
		return p_u_4
	end
	if typeof(p_u_4) == "string" then
		local v5, v6 = pcall(function()
			-- upvalues: (copy) p_u_4
			return Enum.Font[p_u_4]
		end)
		if v5 then
			return v6
		end
	end
	return nil
end
local function v_u_11(p8) -- name: sanitizeVector2
	if typeof(p8) == "Vector2" then
		return Vector2.new(p8.X, p8.Y)
	end
	if typeof(p8) == "table" then
		local v9 = p8.X or p8.x
		local v10 = p8.Y or p8.y
		if typeof(v9) == "number" and typeof(v10) == "number" then
			return Vector2.new(v9, v10)
		end
	end
	return nil
end
local function v_u_15(p_u_12) -- name: sanitizeTextAlignmentX
	if typeof(p_u_12) == "EnumItem" and p_u_12.EnumType == Enum.TextXAlignment then
		return p_u_12
	end
	if typeof(p_u_12) == "string" then
		local v13, v14 = pcall(function()
			-- upvalues: (copy) p_u_12
			return Enum.TextXAlignment[p_u_12]
		end)
		if v13 then
			return v14
		end
	end
	return nil
end
local function v_u_19(p_u_16) -- name: sanitizeTextAlignmentY
	if typeof(p_u_16) == "EnumItem" and p_u_16.EnumType == Enum.TextYAlignment then
		return p_u_16
	end
	if typeof(p_u_16) == "string" then
		local v17, v18 = pcall(function()
			-- upvalues: (copy) p_u_16
			return Enum.TextYAlignment[p_u_16]
		end)
		if v17 then
			return v18
		end
	end
	return nil
end
return require(v1:WaitForChild("Packages"):WaitForChild("Red")).SharedEvent("Hint", function(p20)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_11, (copy) v_u_7, (copy) v_u_15, (copy) v_u_19
	if typeof(p20) ~= "table" then
		return nil
	end
	local v21 = p20.action
	local v22
	if typeof(v21) == "string" then
		v22 = string.upper((string.sub(v21, 1, 1))) .. string.lower((string.sub(v21, 2)))
		if not v_u_3[v22] then
			v22 = nil
		end
	else
		v22 = nil
	end
	if not v22 then
		return nil
	end
	if v22 == "Hide" then
		local v23 = {
			["action"] = v22
		}
		local v24 = p20.hintId
		if typeof(v24) ~= "string" then
			if typeof(v24) == "number" then
				v24 = tostring(v24)
			else
				v24 = nil
			end
		end
		if v24 then
			v23.hintId = v24
		end
		return v23
	end
	local v25 = p20.hintType
	local v26
	if typeof(v25) == "string" then
		local v27 = string.lower(v25)
		v26 = v27 == "image" and "Image" or (v27 == "paper" and "Paper" or nil)
	else
		v26 = nil
	end
	if not v26 then
		return nil
	end
	if not v_u_2[v26] then
		return nil
	end
	local v28 = {
		["action"] = v22,
		["hintType"] = v26
	}
	local v29 = p20.hintId
	if typeof(v29) ~= "string" then
		if typeof(v29) == "number" then
			v29 = tostring(v29)
		else
			v29 = nil
		end
	end
	if v29 then
		v28.hintId = v29
	end
	local v30 = p20.title
	if typeof(v30) ~= "string" then
		if typeof(v30) == "number" then
			v30 = tostring(v30)
		else
			v30 = nil
		end
	end
	if v30 then
		v28.title = v30
	end
	local v31 = p20.subtitle
	if typeof(v31) ~= "string" then
		if typeof(v31) == "number" then
			v31 = tostring(v31)
		else
			v31 = nil
		end
	end
	if v31 then
		v28.subtitle = v31
	end
	local v32 = p20.overlayTransparency
	if typeof(v32) == "number" then
		v28.overlayTransparency = math.clamp(v32, 0, 1)
	end
	local v33 = p20.promptText
	if typeof(v33) ~= "string" then
		if typeof(v33) == "number" then
			v33 = tostring(v33)
		else
			v33 = nil
		end
	end
	if v33 then
		v28.promptText = v33
	end
	if v26 == "Image" then
		local v34 = p20.imageId or p20.assetId
		if typeof(v34) == "string" then
			if v34 == "" then
				v34 = nil
			else
				local v35 = v34:match("%d+")
				if v35 then
					v34 = "rbxassetid://" .. v35
				end
			end
		elseif typeof(v34) == "number" then
			v34 = ("rbxassetid://%d"):format(v34)
		else
			v34 = nil
		end
		if not v34 then
			return nil
		end
		v28.imageId = v34
		local v36 = p20.aspectRatio
		if typeof(v36) == "number" then
			v28.aspectRatio = math.clamp(v36, 0.1, 10)
		end
		local v37 = p20.imageColor3 or p20.imageColor
		if typeof(v37) == "Color3" then
			v28.imageColor3 = v37
		end
		local v38 = p20.backgroundColor3 or p20.backgroundColor
		if typeof(v38) == "Color3" then
			v28.backgroundColor3 = v38
		end
		local v39 = p20.backgroundTransparency
		if typeof(v39) == "number" then
			v28.backgroundTransparency = math.clamp(v39, 0, 1)
		end
		local v40 = v_u_11(p20.padding)
		if v40 then
			v28.padding = v40
		end
		return v28
	end
	local v41 = p20.text
	if typeof(v41) ~= "string" then
		return nil
	end
	v28.text = v41
	local v42 = p20.fontFace
	if typeof(v42) ~= "Font" then
		v42 = nil
	end
	if v42 then
		v28.fontFace = v42
	end
	local v43 = v_u_7(p20.font)
	if v43 then
		v28.font = v43
	end
	if not (v28.font or v28.fontFace) then
		v28.font = Enum.Font.Gotham
	end
	local v44 = p20.textSize
	if typeof(v44) == "number" then
		local v45 = v44 + 0.5
		local v46 = math.floor(v45)
		v28.textSize = math.clamp(v46, 6, 200)
	end
	local v47 = p20.textWrapped
	if typeof(v47) == "boolean" then
		v28.textWrapped = v47
	end
	local v48 = p20.textScaled
	if typeof(v48) == "boolean" then
		v28.textScaled = v48
	end
	local v49 = p20.richText
	if typeof(v49) == "boolean" then
		v28.richText = v49
	end
	local v50 = p20.textColor3 or p20.textColor
	if typeof(v50) == "Color3" then
		v28.textColor3 = v50
	end
	local v51 = p20.textTransparency
	if typeof(v51) == "number" then
		v28.textTransparency = math.clamp(v51, 0, 1)
	end
	local v52 = p20.textStrokeColor3 or p20.textStrokeColor
	if typeof(v52) == "Color3" then
		v28.textStrokeColor3 = v52
	end
	local v53 = p20.textStrokeTransparency
	if typeof(v53) == "number" then
		v28.textStrokeTransparency = math.clamp(v53, 0, 1)
	end
	local v54 = v_u_15(p20.textXAlignment)
	if v54 then
		v28.textXAlignment = v54
	end
	local v55 = v_u_19(p20.textYAlignment)
	if v55 then
		v28.textYAlignment = v55
	end
	local v56 = v_u_11(p20.frameSize or p20.textSizePixels)
	if v56 then
		local v57 = v56.X
		local v58 = math.max(v57, 1)
		local v59 = v56.Y
		local v60 = math.max(v59, 1)
		v28.frameSize = Vector2.new(v58, v60)
	end
	local v61 = v_u_11(p20.canvasSize)
	if v61 then
		local v62 = v61.X
		local v63 = math.max(v62, 1)
		local v64 = v61.Y
		local v65 = math.max(v64, 1)
		v28.canvasSize = Vector2.new(v63, v65)
	end
	local v66 = p20.backgroundColor3 or p20.backgroundColor
	if typeof(v66) == "Color3" then
		v28.backgroundColor3 = v66
	end
	local v67 = p20.backgroundTransparency
	if typeof(v67) == "number" then
		v28.backgroundTransparency = math.clamp(v67, 0, 1)
	end
	local v68 = v_u_11(p20.padding)
	if v68 then
		v28.padding = v68
	end
	local v69 = p20.sizeUDim or p20.textSizeUDim
	if typeof(v69) ~= "UDim2" then
		v69 = nil
	end
	if v69 then
		v28.sizeUDim = v69
	end
	local v70 = p20.lineHeight or p20.textLineHeight
	if typeof(v70) == "number" then
		v28.lineHeight = math.clamp(v70, 0, 10)
	end
	return v28
end)