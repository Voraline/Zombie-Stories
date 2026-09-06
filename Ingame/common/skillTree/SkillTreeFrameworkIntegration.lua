local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")
return {
    new = function() -- Line: 28 -- upvalues: Players (val), UserInputService (val), GamepadService (val)
        Players.LocalPlayer:WaitForChild("PlayerScripts")
        local Controllers = game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers
        local CameraController = require(Controllers.CameraController)
        local WeaponController = require(Controllers.WeaponController)
        local LocalPlayerController = require(Controllers.LocalPlayerController)
        return {
            onOpen = function(p1) -- Line: 40 -- upvalues: CameraController (val), WeaponController (val), LocalPlayerController (val), UserInputService (upval), GamepadService (upval)
                CameraController:SetEnabled(false)
                CameraController:SetMouseUnlocked("Skilltree", true)
                WeaponController:ForceUnequip(nil)
                WeaponController:DisableSwapping()
                LocalPlayerController:SetMovementEnabled(false)
                if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
                    GamepadService:EnableGamepadCursor(nil)
                end
            end,
            onClose = function(p1) -- Line: 52 -- upvalues: LocalPlayerController (val), WeaponController (val), CameraController (val)
                LocalPlayerController:SetMovementEnabled(true)
                WeaponController:DisableSwapping(false)
                CameraController:SetEnabled(true)
                CameraController:SetMouseUnlocked("Skilltree", false)
            end,
        }
    end,
}