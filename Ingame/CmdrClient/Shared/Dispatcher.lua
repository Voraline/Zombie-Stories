local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("TeleportService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require("./Util")
local v_u_5 = require("./Command")
local v_u_6 = false
local v_u_54 = {
	["Cmdr"] = nil,
	["Registry"] = nil,
	["Evaluate"] = function(p7, p8, p9, p10, p11) -- name: Evaluate
		-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
		if v_u_1:IsClient() == true and p9 ~= v_u_3.LocalPlayer then
			error("Can\'t evaluate a command that isn\'t sent by the local player.")
		end
		local v12 = v_u_4.SplitString(p8)
		local v13 = table.remove(v12, 1)
		local v14 = p7.Registry:GetCommand(v13)
		if v14 then
			local v15 = {
				["Dispatcher"] = p7,
				["Text"] = p8,
				["CommandObject"] = v14,
				["Alias"] = v13,
				["Executor"] = p9,
				["Arguments"] = v_u_4.MashExcessArguments(v12, #v14.Args),
				["Data"] = p11
			}
			local v16 = v_u_5.new(v15)
			local v17, v18 = v16:Parse(p10)
			if v17 then
				return v16
			else
				return false, v18
			end
		else
			return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v13)))
		end
	end,
	["EvaluateAndRun"] = function(p19, p20, p21, p22) -- name: EvaluateAndRun
		-- upvalues: (copy) v_u_3, (copy) v_u_1
		local v23 = p21 or v_u_3.LocalPlayer
		local v24 = p22 or {}
		if v_u_1:IsClient() and v24.IsHuman then
			p19:PushHistory(p20)
		end
		local v_u_25, v26 = p19:Evaluate(p20, v23, nil, v24.Data)
		if not v_u_25 then
			return v26
		end
		local v30, v31 = xpcall(function()
			-- upvalues: (copy) v_u_25
			local v27, v28 = v_u_25:Validate(true)
			return v27 and (v_u_25:Run() or "Command executed.") or v28
		end, function(p29)
			return debug.traceback((tostring(p29)))
		end)
		if not v30 then
			warn(("Error occurred while evaluating command string %q\n%s"):format(p20, (tostring(v31))))
		end
		return v30 and v31 and v31 or "An error occurred while running this command. Check the console for more information."
	end,
	["Send"] = function(p32, p33, p34) -- name: Send
		-- upvalues: (copy) v_u_1
		if v_u_1:IsClient() == false then
			error("Dispatcher:Send can only be called from the client.")
		end
		return p32.Cmdr.RemoteFunction:InvokeServer(p33, {
			["Data"] = p34
		})
	end,
	["Run"] = function(p35, ...) -- name: Run
		-- upvalues: (copy) v_u_3
		if not v_u_3.LocalPlayer then
			error("Dispatcher:Run can only be called from the client.")
		end
		local v36 = { ... }
		local v37 = v36[1]
		for v38 = 2, #v36 do
			local v39 = v36[v38]
			v37 = v37 .. " " .. tostring(v39)
		end
		local v40, v41 = p35:Evaluate(v37, v_u_3.LocalPlayer)
		if not v40 then
			error(v41)
		end
		local v42, v43 = v40:Validate(true)
		if not v42 then
			error(v43)
		end
		return v40:Run()
	end,
	["RunHooks"] = function(p44, p45, p46, ...) -- name: RunHooks
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		if not p44.Registry.Hooks[p45] then
			error(("Invalid hook name: %q"):format(p45), 2)
		end
		if p45 == "BeforeRun" and (#p44.Registry.Hooks[p45] == 0 and (p46.Group ~= "DefaultUtil" and (p46.Group ~= "UserAlias" and p46:HasImplementation()))) then
			if not v_u_1:IsStudio() then
				return "Command blocked for security as no BeforeRun hook is configured."
			end
			if v_u_6 == false then
				p46:Reply((v_u_1:IsServer() and "<Server>" or "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26))
				v_u_6 = true
			end
		end
		for _, v47 in ipairs(p44.Registry.Hooks[p45]) do
			local v48 = v47.callback(p46, ...)
			if v48 ~= nil then
				return tostring(v48)
			end
		end
	end,
	["PushHistory"] = function(p49, p50) -- name: PushHistory
		-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_2
		local v51 = v_u_1:IsClient()
		assert(v51, "PushHistory may only be used from the client.")
		local v52 = p49:GetHistory()
		if v_u_4.TrimString(p50) ~= "" and p50 ~= v52[#v52] then
			v52[#v52 + 1] = p50
			v_u_2:SetTeleportSetting("CmdrCommandHistory", v52)
		end
	end,
	["GetHistory"] = function(_) -- name: GetHistory
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		local v53 = v_u_1:IsClient()
		assert(v53, "GetHistory may only be used from the client.")
		return v_u_2:GetTeleportSetting("CmdrCommandHistory") or {}
	end
}
return function(p55)
	-- upvalues: (copy) v_u_54
	v_u_54.Cmdr = p55
	v_u_54.Registry = p55.Registry
	return v_u_54
end