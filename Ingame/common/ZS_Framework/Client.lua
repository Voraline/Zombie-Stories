local v1 = game:GetService("ReplicatedStorage")
local v2 = v1.common.RedEvents
local v3 = workspace:WaitForChild("Values"):WaitForChild("IsLobby")
local v4 = Instance.new("BindableEvent")
v4.Name = "FrameworkEvent"
v4.Parent = game.Players.LocalPlayer:WaitForChild("PlayerScripts")
local v5 = v1.common
local v6 = require(v2.Framework.ForceTeleport)
local v7 = require(v2.Framework.LookAtEvent)
local v8 = require(v2.Framework.FrameworkEvents)
local v9 = v8.PreloadWeapon
require("./Data/Initializer")
for _, v10 in script.Parent.Controllers:GetChildren() do
	require(v10)
end
for _, v11 in script.Parent.UI.Controllers:GetChildren() do
	require(v11)
end
local v_u_12 = require(v5:WaitForChild("WepConfig"))
v9:SetClientListener(function(p13)
	-- upvalues: (copy) v_u_12
	if type(p13) == "table" then
		for _, v_u_14 in p13 do
			task.defer(function()
				-- upvalues: (ref) v_u_12, (copy) v_u_14
				v_u_12:PreloadWeapon(v_u_14)
			end)
		end
	elseif type(p13) == "string" then
		v_u_12:PreloadWeapon(p13)
	end
end)
local v15 = script.Parent:WaitForChild("Modules")
v15:WaitForChild("Utils")
local v16 = v15:WaitForChild("Controllers")
v15:WaitForChild("Classes")
require(v16:WaitForChild("HUDController")):Init()
local v17 = game.ReplicatedStorage.common:FindFirstChild("Remotes")
if v17 then
	v17 = v17:FindFirstChild("DataRemote")
end
local v18
if v17 then
	v18 = v17:InvokeServer("GetData")
	if not v18 then
		for _ = 1, 5 do
			v18 = v17:InvokeServer("GetData")
			if v18 then
				break
			end
			task.wait(2)
		end
	end
else
	v18 = nil
end
local v19 = require(v16.HUDController.HUDElements:WaitForChild("MobileControls"))
v19.EditData = not v18 and {} or v18.Settings.MblEdit
v19.PresetData = v18 and v18.Settings.MblPresets or {}
require(v16:WaitForChild("ReplicationController")).Init()
local v20 = require(v16:WaitForChild("WeaponController"))
local v21 = require(v16:WaitForChild("InputController"))
local v22 = require(v16:WaitForChild("LocalPlayerController"))
local v_u_23 = require(v16:WaitForChild("CameraController"))
require(v16:WaitForChild("CutsceneController"))
local v24 = require(v16:WaitForChild("HUDOverlayController"))
local v25 = require(v16:WaitForChild("HealthBarController"))
v21:Init()
v21:SetupBinds()
v22:Init()
v_u_23:Init()
v_u_23:SetEnabled(true)
script:SetAttribute("Initialized", true)
if v3.Value then
	v24:SetEnabled(false)
else
	v25:Init(game.Players.LocalPlayer)
end
v6:OnClient(function(p26)
	-- upvalues: (copy) v_u_23
	v_u_23:ForceTeleport(p26)
end)
v7:SetClientListener(function(p27)
	-- upvalues: (copy) v_u_23
	v_u_23:LookAt(p27)
end)
v8.RollbackHP:SetClientListener(function(p28)
	for _, v29 in p28 do
		v29[1].Value = v29[2]
		v29[1]:SetAttribute("Rollback", true)
	end
end)
v9:FireServer()
v20:RequestLoadout()
v8.RequestPendingTeleport:Call():After(function(p30, p31)
	-- upvalues: (copy) v_u_23
	if p30 and p31 then
		v_u_23:ForceTeleport(p31)
	end
end)
return nil