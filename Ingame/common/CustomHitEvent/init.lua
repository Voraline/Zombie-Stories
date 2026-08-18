local _ = game.ReplicatedStorage.common
local v1 = game.ReplicatedStorage.common.RedEvents
local v_u_2 = require(v1.Framework.FrameworkEvents).CustomHit
local v_u_3 = game:GetService("RunService"):IsServer()
local v_u_4 = game:GetService("RunService"):IsStudio()
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local function v_u_10(p8, ...) -- name: debugLog
	-- upvalues: (copy) v_u_4
	if v_u_4 then
		local v9 = p8 or "General"
		if p8 then
			if p8 == "TurkeyTarget" then
				print("[CustomHitDebug]", v9, ...)
			end
		else
			return
		end
	else
		return
	end
end
local v_u_11, v12
if v_u_3 then
	v_u_11 = nil
	v12 = nil
else
	local v13 = game:GetService("ReplicatedStorage").common.ZS_Framework
	v_u_11 = require(v13.Modules.Classes.Weapon)
	v12 = require(v13.Modules.Controllers.WeaponController.WeaponControllerUtils.Melee)
end
function setupHitModule(p14) -- name: setupHitModule
	-- upvalues: (copy) v_u_5, (copy) v_u_10
	v_u_5[p14.Name] = require(p14)
	local v15 = v_u_5[p14.Name]
	v15.Model = p14:FindFirstChildWhichIsA("Model")
	local v16 = v_u_10
	local v17 = p14.Name
	local v18 = "setupHitModule"
	local v19 = p14:GetFullName()
	local v20 = v15.Model
	if v20 then
		v20 = v15.Model:GetFullName()
	end
	v16(v17, v18, v19, v20)
end
local v_u_51 = {
	["RegisterModel"] = function(_, p21, p22) -- name: RegisterModel
		-- upvalues: (copy) v_u_5, (copy) v_u_10, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_2
		local v23 = v_u_5[p21]
		if v23 then
			local v24
			if v23.new then
				v24 = v23.new()
			else
				v24 = setmetatable({}, v23)
			end
			local v25 = p22 or v24.Model
			local v26 = v_u_10
			local v27 = "RegisterModel"
			local v28
			if v25 then
				v28 = v25:GetFullName()
			else
				v28 = v25
			end
			v26(p21, v27, v28, "override", p22 ~= nil, v_u_3 and "server" or "client")
			if v25 then
				v_u_6[v25] = {
					["Event"] = v24,
					["db"] = {},
					["EventName"] = p21,
					["Model"] = v25
				}
				v_u_10(p21, "RegisterModel:registered", v25:GetFullName())
				return v25, v24
			end
			if v_u_3 then
				local v29 = {
					["Type"] = "RegisterModel",
					["Model"] = nil,
					["HitName"] = nil,
					["Model"] = p22,
					["HitName"] = p21
				}
				local v30 = v_u_7
				table.insert(v30, v29)
				local v31 = v_u_10
				local v32 = "RegisterModel:queuedPacket"
				if p22 then
					p22 = p22:GetFullName()
				end
				v31(p21, v32, p22)
				v_u_2:FireAllClients(v29)
			end
		else
			local v33 = v_u_10
			local v34 = "RegisterModel:missingEventModule"
			if p22 then
				p22 = p22:GetFullName()
			end
			v33(p21, v34, p22)
		end
	end,
	["GetPool"] = function(_) -- name: GetPool
		-- upvalues: (copy) v_u_6
		return v_u_6
	end,
	["Verify"] = function(_, p35, p36, p37, p38) -- name: Verify
		-- upvalues: (copy) v_u_10, (copy) v_u_6
		if p37 then
			local v39 = p37
			while true do
				local v40 = not p37 or v_u_6[p37]
				if v40 then
					break
				end
				p37 = p37.Parent
			end
			if v40 then
				local v41 = v_u_10
				local v42 = v40.EventName
				local v43 = "Verify:resolved"
				local v44
				if p35 then
					v44 = p35.Name
				else
					v44 = p35
				end
				v41(v42, v43, v44, v39:GetFullName(), p38)
				return true, v40.Event:OnHit(p35, p36, v39, p38)
			end
			local v45 = v_u_10
			local v46 = nil
			local v47 = "Verify:noEvent"
			if p35 then
				p35 = p35.Name
			end
			v45(v46, v47, p35, v39:GetFullName())
		else
			local v48 = v_u_10
			local v49 = nil
			local v50 = "Verify:missingHitPart"
			if p35 then
				p35 = p35.Name
			end
			v48(v49, v50, p35)
		end
	end
}
for _, v52 in script:GetChildren() do
	if v52:IsA("ModuleScript") then
		setupHitModule(v52)
	end
end
function setupCustomModulesFolder(p53) -- name: setupCustomModulesFolder
	for _, v54 in p53:GetChildren() do
		setupHitModule(v54)
	end
end
for _, v55 in game.ReplicatedStorage:GetChildren() do
	if v55:IsA("Folder") then
		local v56 = v55:FindFirstChild("CustomHitModules")
		if v56 then
			setupCustomModulesFolder(v56)
		end
	end
end
game.ReplicatedStorage.ChildAdded:Connect(function(p57)
	task.wait(1)
	local v58 = p57:IsA("Folder") and p57:FindFirstChild("CustomHitModules")
	if v58 then
		setupCustomModulesFolder(v58)
	end
end)
if v_u_3 then
	v_u_2:SetServerListener(function(p59, p60)
		-- upvalues: (copy) v_u_10, (copy) v_u_51, (copy) v_u_7, (copy) v_u_2
		if p60 then
			if p60.Type == "Hit" then
				local v61 = p60.HitResult
				local v62 = v_u_10
				local v63 = nil
				local v64 = "ServerListener:HitPacket"
				local v65
				if p59 then
					v65 = p59.Name
				else
					v65 = p59
				end
				local v66 = p60.WeaponID
				local v67 = v61 and v61.Instance
				if v67 then
					v67 = v61.Instance:GetFullName()
				end
				v62(v63, v64, v65, v66, v67)
				v_u_51:Verify(p59, v61.Position, v61.Instance, p60.WeaponID)
				return
			end
		else
			local v68 = v_u_10
			local v69 = nil
			local v70 = "ServerListener:syncRequest"
			if p59 then
				p59 = p59.Name
			end
			v68(v69, v70, p59, #v_u_7)
			for _, v71 in v_u_7 do
				v_u_2:FireAllClients(v71)
			end
		end
	end)
else
	v_u_2:SetClientListener(function(p72)
		-- upvalues: (copy) v_u_10, (copy) v_u_51
		if p72 and p72.Type == "RegisterModel" then
			local v73 = v_u_10
			local v74 = nil
			local v75 = "ClientListener:RegisterPacket"
			local v76 = p72.HitName
			local v77 = p72.Model
			if v77 then
				v77 = p72.Model:GetFullName()
			end
			v73(v74, v75, v76, v77)
			v_u_51:RegisterModel(p72.HitName, p72.Model)
		end
	end)
	function onHit(p78, p79) -- name: onHit
		-- upvalues: (copy) v_u_51, (copy) v_u_10, (ref) v_u_11, (copy) v_u_2
		local v80, v81 = v_u_51:Verify(game.Players.LocalPlayer, p78.Position, p78.Instance, p79)
		if v80 then
			local v82 = v_u_10
			local v83 = nil
			local v84 = "Client:onHitValid"
			local v85 = p78.Instance
			if v85 then
				v85 = p78.Instance:GetFullName()
			end
			v82(v83, v84, p79, v85)
			if v_u_11 and (v_u_11.HitEntity and v81 ~= false) then
				local v86 = "Flesh"
				local v87 = nil
				if typeof(v81) == "string" then
					v86 = v81
				elseif typeof(v81) == "table" then
					v86 = v81.hitType or v86
					v87 = v81.data or v81
				elseif v81 then
					v86 = tostring(v81)
				end
				v_u_11.HitEntity:Fire(v86, v87)
			end
			v_u_2:FireServer({
				["Type"] = "Hit",
				["WeaponID"] = nil,
				["HitResult"] = nil,
				["WeaponID"] = p79,
				["HitResult"] = {
					["Distance"] = p78.Distance,
					["Instance"] = p78.Instance,
					["Material"] = p78.Material,
					["Position"] = p78.Position,
					["Normal"] = p78.Normal
				}
			})
		end
	end
	v_u_11.Hit:Connect(onHit)
	v12.Hit:Connect(onHit)
	v_u_2:FireServer()
end
return v_u_51