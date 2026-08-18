local v1 = game:GetService("RunService")
local v2 = {}
local v_u_3 = setmetatable({}, v2)
local v_u_4 = {}
local v_u_5 = Instance.new
local v_u_6 = type
local v_u_7 = require
local v_u_8 = nil
local v_u_9 = v1:IsServer()
local v_u_15 = setmetatable({
	["Folder"] = false,
	["RemoteEvent"] = false,
	["BindableEvent"] = false,
	["RemoteFunction"] = false,
	["BindableFunction"] = false,
	["Library"] = true
}, {
	["__index"] = function(p10, p11) -- name: __index
		-- upvalues: (copy) v_u_5
		local v12, v13 = pcall(v_u_5, p11)
		local v14
		if v12 and v13 then
			v13:Destroy()
			v14 = false
		else
			v14 = true
		end
		p10[p11] = v14
		return v14
	end
})
function v_u_3.GetLocalTable(p16, p17) -- name: GetLocalTable
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	if p16 ~= v_u_3 and p16 then
		p17 = p16
	end
	local v18 = v_u_4[p17]
	if not v18 then
		v18 = {}
		v_u_4[p17] = v18
	end
	return v18
end
local function v_u_23(p19, p20, p21) -- name: GetFirstChild
	-- upvalues: (copy) v_u_15, (copy) v_u_5
	local v22 = p19:FindFirstChild(p20)
	if not v22 then
		if v_u_15[p21] then
			error("[Resources] " .. p21 .. " \"" .. p20 .. "\" is not installed within " .. p19:GetFullName() .. ".", 2)
		end
		v22 = v_u_5(p21)
		v22.Name = p20
		v22.Parent = p19
	end
	return v22
end
function v2.__index(p_u_24, p_u_25) -- name: __index
	-- upvalues: (copy) v_u_6, (copy) v_u_23, (ref) v_u_8, (copy) v_u_3, (copy) v_u_4, (copy) v_u_9
	if v_u_6(p_u_25) ~= "string" then
		error("[Resources] Attempt to index Resources with invalid key: string expected, got " .. typeof(p_u_25), 2)
	end
	if p_u_25:sub(1, 3) ~= "Get" then
		error("[Resources] Methods should begin with \"Get\"", 2)
	end
	local v_u_26 = p_u_25:sub(4)
	local v27, v28 = v_u_26:byte(-2, -1)
	local v_u_29 = v28 == 121 and (v27 ~= 97 and (v27 ~= 101 and (v27 ~= 105 and (v27 ~= 111 and v27 ~= 117)))) and v_u_26:sub(1, -2) .. "ies" or v_u_26 .. "s"
	local v_u_30 = v_u_26:sub(1, 5) == "Local"
	local v_u_31 = nil
	local v_u_32 = nil
	local v_u_33
	if v_u_30 then
		v_u_26 = v_u_26:sub(6)
		if v_u_26 == "Folder" then
			v_u_33 = function()
				-- upvalues: (ref) v_u_23, (ref) v_u_8
				return v_u_23(v_u_8, "Resources", "Folder")
			end
		else
			v_u_33 = v_u_3.GetLocalFolder
		end
	elseif v_u_26 == "Folder" then
		v_u_33 = function()
			return script
		end
	else
		v_u_33 = v_u_3.GetFolder
	end
	local function v40(p34, p35) -- name: GetFunction
		-- upvalues: (copy) p_u_24, (ref) v_u_6, (copy) p_u_25, (ref) v_u_32, (ref) v_u_31, (ref) v_u_4, (copy) v_u_29, (ref) v_u_33, (copy) v_u_30, (ref) v_u_9, (ref) v_u_23, (ref) v_u_26
		if p34 ~= p_u_24 and p34 then
			p35 = p34
		end
		if v_u_6(p35) ~= "string" then
			error("[Resources] " .. p_u_25 .. " expected a string parameter, got " .. typeof(p35), 2)
		end
		if not v_u_32 then
			v_u_31 = v_u_4[v_u_29]
			v_u_32 = v_u_33(v_u_30 and v_u_29:sub(6) or v_u_29)
			if not v_u_31 then
				v_u_31 = v_u_32:GetChildren()
				v_u_4[v_u_29] = v_u_31
				for v36 = 1, #v_u_31 do
					local v37 = v_u_31[v36]
					v_u_31[v37.Name] = v37
					v_u_31[v36] = nil
				end
			end
		end
		local v38 = v_u_31[p35]
		if not v38 then
			if v_u_9 or v_u_30 then
				v38 = v_u_23(v_u_32, p35, v_u_26)
			else
				v38 = v_u_32:WaitForChild(p35, 5)
				if not v38 then
					local v39 = getfenv(0).script
					if v39 and (v39.Parent and v39.Parent.Parent == script) then
						warn("[Resources] Make sure a Script in ServerScriptService calls `Resources:LoadLibrary(\"" .. v39.Name .. "\")`")
					elseif v_u_26 == "Library" then
						warn("[Resources] Did you forget to install " .. p35 .. "?")
					elseif v_u_26 == "Folder" then
						warn("[Resources] Make sure a Script in ServerScriptService calls `require(ReplicatedStorage:WaitForChild(\"Resources\"))`")
					end
					v38 = v_u_32:WaitForChild(p35)
				end
			end
			v_u_31[p35] = v38
		end
		return v38
	end
	v_u_3[p_u_25] = v40
	return v40
end
if v_u_9 then
	v_u_8 = game:GetService("ServerStorage")
	local v41 = v_u_8:FindFirstChild("Repository") or game:GetService("ServerScriptService"):FindFirstChild("Repository")
	local function v45(p42, p43, p44) -- name: CacheLibrary
		if p42[p43.Name] then
			error("[Resources] Duplicate " .. p44 .. " Found:\n\t" .. p42[p43.Name]:GetFullName() .. " and \n\t" .. p43:GetFullName() .. "\nOvershadowing is only permitted when a server-only library overshadows a replicated library", 0)
		else
			p42[p43.Name] = p43
		end
	end
	if v41 then
		local v46 = v_u_3:GetLocalTable("Libraries")
		local v47 = v41:GetChildren()
		local v48 = {}
		local v49 = false
		local v50 = {}
		while v47 do
			v48[v47] = nil
			for v51 = 1, #v47 do
				local v52 = v47[v51]
				local v53 = v52.ClassName
				local v54 = v49 or (v52.Name:find("Server", 1, true) and true or false)
				if v53 == "ModuleScript" then
					if v54 then
						v52.Parent = v_u_3:GetLocalFolder("Libraries")
						v45(v50, v52, "ServerLibraries")
					else
						local v55 = v52:GetDescendants()
						local v56 = nil
						for v57 = 1, #v55 do
							local v58 = v55[v57]
							if v58.Name:find("Server", 1, true) then
								v56 = v56 or v52:Clone()
								v58:Destroy()
							end
						end
						if v56 then
							v56.Parent = v_u_3:GetLocalFolder("Libraries")
							v45(v50, v56, "ServerLibraries")
						end
						v52.Parent = v_u_3:GetFolder("Libraries")
						v45(v46, v52, "ReplicatedLibraries")
					end
				elseif v53 == "Folder" then
					v48[v52:GetChildren()] = v54
				else
					error("[Resources] Instances within your Repository must be either a ModuleScript or a Folder, found: " .. v53 .. " " .. v52:GetFullName(), 0)
				end
			end
			v47, v49 = next(v48)
		end
		for v59, v60 in next, v50 do
			v46[v59] = v60
		end
		v41:Destroy()
	end
else
	repeat
		local v61 = game:GetService("Players").LocalPlayer
	until v61 or not wait()
	repeat
		v_u_8 = v61:FindFirstChildOfClass("PlayerScripts")
	until v_u_8 or not wait()
end
local v_u_62 = v_u_3:GetLocalTable("LoadedLibraries")
local v_u_63 = {}
function v_u_3.LoadLibrary(p64, p65) -- name: LoadLibrary
	-- upvalues: (copy) v_u_3, (copy) v_u_62, (copy) v_u_63, (copy) v_u_7
	if p64 ~= v_u_3 and p64 then
		p65 = p64
	end
	local v66 = v_u_62[p65]
	if v66 == nil then
		local v67 = getfenv(0).script or {
			["Name"] = "Command bar"
		}
		local v68 = v_u_3:GetLibrary(p65)
		v_u_63[v67] = v68
		local v69 = v68
		local v70 = 0
		while v68 do
			v70 = v70 + 1
			v68 = v_u_63[v68]
			if v68 == v69 then
				local v71 = v68.Name
				for _ = 1, v70 do
					v68 = v_u_63[v68]
					v71 = v71 .. " -> " .. v68.Name
				end
				error("[Resources] Circular dependency chain detected: " .. v71)
			end
		end
		v66 = v_u_7(v69)
		if v_u_63[v67] == v69 then
			v_u_63[v67] = nil
		end
		if v66 == nil then
			error("[Resources] " .. p65 .. " must return a non-nil value. Return false instead.")
		end
		v_u_62[p65] = v66
	end
	return v66
end
v2.__call = v_u_3.LoadLibrary
return v_u_3