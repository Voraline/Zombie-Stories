local v_u_1 = game:GetService("RunService")
local v_u_2 = require("./Util")
local v_u_19 = {
	["TypeMethods"] = nil,
	["CommandMethods"] = nil,
	["CommandArgProps"] = nil,
	["Types"] = nil,
	["TypeAliases"] = nil,
	["Commands"] = nil,
	["CommandsArray"] = nil,
	["Cmdr"] = nil,
	["Hooks"] = nil,
	["Stores"] = nil,
	["AutoExecBuffer"] = nil,
	["TypeMethods"] = v_u_2.MakeDictionary({
		"Transform",
		"Validate",
		"Autocomplete",
		"Parse",
		"DisplayName",
		"Listable",
		"ValidateOnce",
		"Prefixes",
		"Default",
		"ArgumentOperatorAliases"
	}),
	["CommandMethods"] = v_u_2.MakeDictionary({
		"Name",
		"Aliases",
		"AutoExec",
		"Description",
		"Args",
		"Run",
		"ClientRun",
		"Data",
		"Group"
	}),
	["CommandArgProps"] = v_u_2.MakeDictionary({
		"Name",
		"Type",
		"Description",
		"Optional",
		"Default"
	}),
	["Types"] = {},
	["TypeAliases"] = {},
	["Commands"] = {},
	["CommandsArray"] = {},
	["Hooks"] = {
		["BeforeRun"] = {},
		["AfterRun"] = {}
	},
	["Stores"] = setmetatable({}, {
		["__index"] = function(p3, p4) -- name: __index
			p3[p4] = {}
			return p3[p4]
		end
	}),
	["AutoExecBuffer"] = {},
	["RegisterType"] = function(p5, p6, p7) -- name: RegisterType
		if not p6 or typeof(p6) ~= "string" then
			error("Invalid type name provided: nil")
		end
		if not p6:find("^[%d%l]%w*$") then
			error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p6))
		end
		for v8 in pairs(p7) do
			if p5.TypeMethods[v8] == nil then
				error("Unknown key/method in type \"" .. p6 .. "\": " .. v8)
			end
		end
		if p5.Types[p6] ~= nil then
			error(("Type \"%s\" has already been registered."):format(p6))
		end
		p7.Name = p6
		p7.DisplayName = p7.DisplayName or p6
		p5.Types[p6] = p7
		if p7.Prefixes then
			p5:RegisterTypePrefix(p6, p7.Prefixes)
		end
	end,
	["RegisterTypePrefix"] = function(p9, p10, p11) -- name: RegisterTypePrefix
		if not p9.TypeAliases[p10] then
			p9.TypeAliases[p10] = p10
		end
		p9.TypeAliases[p10] = ("%s %s"):format(p9.TypeAliases[p10], p11)
	end,
	["RegisterTypeAlias"] = function(p12, p13, p14) -- name: RegisterTypeAlias
		local v15 = p12.TypeAliases[p13] == nil
		assert(v15, ("Type alias %s already exists!"):format(p14))
		p12.TypeAliases[p13] = p14
	end,
	["RegisterTypesIn"] = function(p16, p17) -- name: RegisterTypesIn
		for _, v18 in pairs(p17:GetChildren()) do
			if v18:IsA("ModuleScript") then
				v18.Parent = p16.Cmdr.ReplicatedRoot.Types
				require(v18)(p16)
			else
				p16:RegisterTypesIn(v18)
			end
		end
	end
}
v_u_19.RegisterHooksIn = v_u_19.RegisterTypesIn
function v_u_19.RegisterCommandObject(p20, p21, _) -- name: RegisterCommandObject
	-- upvalues: (copy) v_u_1
	for v22 in pairs(p21) do
		if p20.CommandMethods[v22] == nil then
			error("Unknown key/method in command " .. (p21.Name or "unknown command") .. ": " .. v22)
		end
	end
	if p21.Args then
		for v23, v24 in pairs(p21.Args) do
			if type(v24) == "table" then
				for v25 in pairs(v24) do
					if p20.CommandArgProps[v25] == nil then
						error(("Unknown property in command \"%s\" argument #%d: %s"):format(p21.Name or "unknown", v23, v25))
					end
				end
			end
		end
	end
	if p21.AutoExec and v_u_1:IsClient() then
		local v26 = p20.AutoExecBuffer
		local v27 = p21.AutoExec
		table.insert(v26, v27)
		p20:FlushAutoExecBufferDeferred()
	end
	local v28 = p20.Commands[p21.Name:lower()]
	if v28 and v28.Aliases then
		for _, v29 in pairs(v28.Aliases) do
			p20.Commands[v29:lower()] = nil
		end
	elseif not v28 then
		local v30 = p20.CommandsArray
		table.insert(v30, p21)
	end
	p20.Commands[p21.Name:lower()] = p21
	if p21.Aliases then
		for _, v31 in pairs(p21.Aliases) do
			p20.Commands[v31:lower()] = p21
		end
	end
end
function v_u_19.RegisterCommand(p32, p33, p34, p35) -- name: RegisterCommand
	-- upvalues: (copy) v_u_1
	local v36 = require(p33)
	local v37 = typeof(v36) == "table"
	local v38 = ("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(p33.Name, (typeof(v36)))
	assert(v37, v38)
	if p34 then
		local v39 = v_u_1:IsServer()
		assert(v39, "The commandServerScript parameter is not valid for client usage.")
		v36.Run = require(p34)
	end
	if not p35 or p35(v36) then
		p32:RegisterCommandObject(v36)
		p33.Parent = p32.Cmdr.ReplicatedRoot.Commands
	end
end
function v_u_19.RegisterCommandsIn(p40, p41, p42) -- name: RegisterCommandsIn
	local v43 = {}
	local v44 = {}
	for _, v45 in pairs(p41:GetChildren()) do
		if v45:IsA("ModuleScript") then
			if v45.Name:find("Server") then
				v43[v45] = true
			else
				local v46 = p41:FindFirstChild(v45.Name .. "Server")
				if v46 then
					v44[v46] = true
				end
				p40:RegisterCommand(v45, v46, p42)
			end
		else
			p40:RegisterCommandsIn(v45, p42)
		end
	end
	for v47 in pairs(v43) do
		if not v44[v47] then
			warn("Command script " .. v47.Name .. " was skipped because it has \'Server\' in its name, and has no equivalent shared script.")
		end
	end
end
function v_u_19.RegisterDefaultCommands(p48, p_u_49) -- name: RegisterDefaultCommands
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v50 = v_u_1:IsServer()
	assert(v50, "RegisterDefaultCommands cannot be called from the client.")
	local v51 = type(p_u_49) == "table"
	if v51 then
		p_u_49 = v_u_2.MakeDictionary(p_u_49)
	end
	p48:RegisterCommandsIn(p48.Cmdr.DefaultCommandsFolder, v51 and function(p52)
		-- upvalues: (ref) p_u_49
		return p_u_49[p52.Group] or false
	end or p_u_49)
end
function v_u_19.GetCommand(p53, p54) -- name: GetCommand
	return p53.Commands[(p54 or ""):lower()]
end
function v_u_19.GetCommands(p55) -- name: GetCommands
	return p55.CommandsArray
end
function v_u_19.GetCommandNames(p56) -- name: GetCommandNames
	local v57 = {}
	for _, v58 in pairs(p56.CommandsArray) do
		local v59 = v58.Name
		table.insert(v57, v59)
	end
	return v57
end
v_u_19.GetCommandsAsStrings = v_u_19.GetCommandNames
function v_u_19.GetTypeNames(p60) -- name: GetTypeNames
	local v61 = {}
	for v62 in pairs(p60.Types) do
		table.insert(v61, v62)
	end
	return v61
end
function v_u_19.GetType(p63, p64) -- name: GetType
	return p63.Types[p64]
end
function v_u_19.GetTypeName(p65, p66) -- name: GetTypeName
	return p65.TypeAliases[p66] or p66
end
function v_u_19.RegisterHook(p67, p68, p69, p70) -- name: RegisterHook
	if not p67.Hooks[p68] then
		error(("Invalid hook name: %q"):format(p68), 2)
	end
	local v71 = p67.Hooks[p68]
	table.insert(v71, {
		["callback"] = p69,
		["priority"] = p70 or 0
	})
	table.sort(p67.Hooks[p68], function(p72, p73)
		return p72.priority < p73.priority
	end)
end
v_u_19.AddHook = v_u_19.RegisterHook
function v_u_19.GetStore(p74, p75) -- name: GetStore
	return p74.Stores[p75]
end
function v_u_19.FlushAutoExecBufferDeferred(p_u_76) -- name: FlushAutoExecBufferDeferred
	-- upvalues: (copy) v_u_1
	if not p_u_76.AutoExecFlushConnection then
		p_u_76.AutoExecFlushConnection = v_u_1.Heartbeat:Connect(function()
			-- upvalues: (copy) p_u_76
			p_u_76.AutoExecFlushConnection:Disconnect()
			p_u_76.AutoExecFlushConnection = nil
			p_u_76:FlushAutoExecBuffer()
		end)
	end
end
function v_u_19.FlushAutoExecBuffer(p77) -- name: FlushAutoExecBuffer
	for _, v78 in ipairs(p77.AutoExecBuffer) do
		for _, v79 in ipairs(v78) do
			p77.Cmdr.Dispatcher:EvaluateAndRun(v79)
		end
	end
	p77.AutoExecBuffer = {}
end
return function(p80)
	-- upvalues: (copy) v_u_19
	v_u_19.Cmdr = p80
	return v_u_19
end