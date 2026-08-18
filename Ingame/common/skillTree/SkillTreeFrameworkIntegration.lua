local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GamepadService")
return {
	["new"] = function() -- name: new
		-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
		v_u_1.LocalPlayer:WaitForChild("PlayerScripts")
		local v4 = game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers
		local v_u_5 = require(v4.CameraController)
		local v_u_6 = require(v4.WeaponController)
		local v_u_7 = require(v4.LocalPlayerController)
		return {
			["onOpen"] = function(_) -- name: onOpen
				-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (ref) v_u_2, (ref) v_u_3
				v_u_5:SetEnabled(false)
				v_u_5:SetMouseUnlocked("Skilltree", true)
				v_u_6:ForceUnequip(nil)
				v_u_6:DisableSwapping()
				v_u_7:SetMovementEnabled(false)
				if v_u_2:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
					v_u_3:EnableGamepadCursor(nil)
				end
			end,
			["onClose"] = function(_) -- name: onClose
				-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_5
				v_u_7:SetMovementEnabled(true)
				v_u_6:DisableSwapping(false)
				v_u_5:SetEnabled(true)
				v_u_5:SetMouseUnlocked("Skilltree", false)
			end
		}
	end
}