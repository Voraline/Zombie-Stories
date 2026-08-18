local v_u_1 = game:GetService("RunService")
local _ = game.ReplicatedStorage.common
local v2 = script.Parent
local v3 = game.ReplicatedStorage.common.RedEvents
local v_u_4 = require(v2.CameraController)
local v_u_5 = require(v2.HUDController)
local v_u_6 = require(v2.WeaponController)
local v_u_7 = require(v2.LocalPlayerController)
local v8 = require(v3.General.CutsceneEvent)
local v_u_9 = "Cinematic"
local v_u_10 = false
local v_u_11 = nil
local v_u_14 = {
	["SetCutsceneMode"] = function(_, p12) -- name: SetCutsceneMode
		-- upvalues: (ref) v_u_10, (ref) v_u_9
		if v_u_10 and (p12 == "FirstPerson" and p12 ~= v_u_9) then
			setupFirstPersonCutscene()
		end
		v_u_9 = p12
	end,
	["SetCutsceneEnabled"] = function(_, p13) -- name: SetCutsceneEnabled
		-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_7, (ref) v_u_9, (copy) v_u_1, (ref) v_u_10
		v_u_4:SetEnabled(not p13)
		v_u_6:SetWeaponsEnabled(not p13)
		v_u_5:SetVisible(not p13)
		v_u_7:SetMovementEnabled(not p13)
		if v_u_9 == "FirstPerson" then
			if p13 then
				setupFirstPersonCutscene()
			else
				v_u_1:UnbindFromRenderStep("FirstPersonCutscene")
			end
		end
		v_u_10 = p13
	end
}
function setupFirstPersonCutscene() -- name: setupFirstPersonCutscene
	-- upvalues: (copy) v_u_1, (ref) v_u_11
	v_u_1:BindToRenderStep("FirstPersonCutscene", Enum.RenderPriority.Camera.Value, function()
		-- upvalues: (ref) v_u_11
		if v_u_11 then
			workspace.CurrentCamera.CFrame = v_u_11.CFrame
		end
	end)
end
v8:SetClientListener(function(p15)
	-- upvalues: (copy) v_u_14
	if p15 then
		if p15.Type == "SetCutsceneEnabled" then
			v_u_14:SetCutsceneEnabled(p15.Enabled)
			return
		end
		if p15.Type == "SetCutsceneMode" then
			v_u_14:SetCutsceneMode(p15.Mode)
		end
	end
end)
local v16 = game.Players.LocalPlayer
local v_u_17 = v16.Character
local function v19(p18) -- name: characterAdded
	-- upvalues: (ref) v_u_11
	v_u_11 = p18:WaitForChild("Head", 1000)
end
if v_u_17 then
	task.defer(function()
		-- upvalues: (ref) v_u_17, (ref) v_u_11
		v_u_11 = v_u_17:WaitForChild("Head", 1000)
	end)
end
v16.CharacterAdded:Connect(v19)
return v_u_14