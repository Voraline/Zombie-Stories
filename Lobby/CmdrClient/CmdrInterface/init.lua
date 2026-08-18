local v_u_1 = game:GetService("Players").LocalPlayer
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v_u_3 = p_u_2.Util
	local v_u_4 = require(script:WaitForChild("Window"))
	v_u_4.Cmdr = p_u_2
	local v_u_5 = require(script:WaitForChild("AutoComplete"))(p_u_2)
	v_u_4.AutoComplete = v_u_5
	function v_u_4.ProcessEntry(p6) -- name: ProcessEntry
		-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) p_u_2, (ref) v_u_1
		local v7 = v_u_3.TrimString(p6)
		if #v7 ~= 0 then
			v_u_4:AddLine(v_u_4:GetLabel() .. " " .. v7, Color3.fromRGB(255, 223, 93))
			v_u_4:AddLine(p_u_2.Dispatcher:EvaluateAndRun(v7, v_u_1, {
				["IsHuman"] = true
			}))
		end
	end
	function v_u_4.OnTextChanged(p8) -- name: OnTextChanged
		-- upvalues: (copy) p_u_2, (ref) v_u_1, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
		local v9 = p_u_2.Dispatcher:Evaluate(p8, v_u_1, true)
		local v10 = v_u_3.SplitString(p8)
		local v11 = table.remove(v10, 1)
		local v12
		if v9 then
			v10 = v_u_3.MashExcessArguments(v10, #v9.Object.Args)
			if #v10 == #v9.Object.Args then
				v12 = true
			else
				v12 = false
			end
		else
			v12 = false
		end
		local v13
		if v11 then
			v13 = #v10 > 0
		else
			v13 = v11
		end
		if p8:sub(#p8, #p8):match("%s") and not v12 then
			v10[#v10 + 1] = ""
			v13 = true
		end
		if v9 and v13 then
			local v14, v15 = v9:Validate()
			v_u_4:SetIsValidInput(v14, ("Validation errors: %s"):format(v15 or ""))
			local v16 = {}
			local v17 = v9:GetArgument(#v10)
			if v17 then
				local v18 = v17.TextSegmentInProgress
				local v19 = false
				if v17.RawSegmentsAreAutocomplete then
					for v20, v21 in ipairs(v17.RawSegments) do
						v16[v20] = { v21, v21 }
					end
				else
					local v22, v23 = v17:GetAutocomplete()
					v19 = (v23 or {}).IsPartial or false
					for v24, v25 in pairs(v22) do
						v16[v24] = { v18, v25 }
					end
				end
				local v26
				if #v18 > 0 then
					v26, v15 = v17:Validate()
				else
					v26 = true
				end
				if not v12 and v26 then
					v_u_4:HideInvalidState()
				end
				local v27 = v_u_5
				local v28 = {}
				if v12 then
					v12 = #p8 - #v18 + (p8:sub(#p8, #p8):match("%s") and -1 or 0)
				end
				v28.at = v12
				v28.prefix = #v17.RawSegments == 1 and (v17.Prefix or "") or ""
				local v29
				if #v9.Arguments == #v9.ArgumentDefinitions then
					v29 = #v18 > 0
				else
					v29 = false
				end
				v28.isLast = v29
				v28.numArgs = #v10
				v28.command = v9
				v28.arg = v17
				v28.name = v17.Name .. (v17.Required and "" or "?")
				v28.type = v17.Type.DisplayName
				v28.description = v26 == false and v15 and v15 or v17.Object.Description
				v28.invalid = not v26
				v28.isPartial = v19
				return v27:Show(v16, v28)
			end
		elseif v11 and #v10 == 0 then
			v_u_4:SetIsValidInput(true)
			local v30 = p_u_2.Registry:GetCommand(v11)
			local v31 = nil
			if v30 then
				v31 = {
					v30.Name,
					v30.Name,
					["options"] = {
						["name"] = v30.Name,
						["description"] = v30.Description
					}
				}
				local v32 = v30.Args
				if v32 then
					v32 = v30.Args[1]
				end
				if type(v32) == "function" then
					v32 = v32(v9)
				end
				if v32 and (not v32.Optional and v32.Default == nil) then
					v_u_4:SetIsValidInput(false, "This command has required arguments.")
					v_u_4:HideInvalidState()
				end
			else
				v_u_4:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v11))
			end
			local v33 = { v31 }
			for _, v34 in pairs(p_u_2.Registry:GetCommandNames()) do
				if v11:lower() == v34:lower():sub(1, #v11) and (v31 == nil or v31[1] ~= v11) then
					local v35 = p_u_2.Registry:GetCommand(v34)
					v33[#v33 + 1] = {
						v11,
						v34,
						["options"] = {
							["name"] = v35.Name,
							["description"] = v35.Description
						}
					}
				end
			end
			return v_u_5:Show(v33)
		end
		v_u_4:SetIsValidInput(false, "Use the help command to see all available commands.")
		v_u_5:Hide()
	end
	v_u_4:UpdateLabel()
	v_u_4:UpdateWindowHeight()
	return {
		["Window"] = v_u_4,
		["AutoComplete"] = v_u_5
	}
end