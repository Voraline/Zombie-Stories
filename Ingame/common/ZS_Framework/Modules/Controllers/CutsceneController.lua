local RunService = game:GetService("RunService")
local Parent = script.Parent
local CameraController = require(Parent.CameraController)
local HUDController = require(Parent.HUDController)
local WeaponController = require(Parent.WeaponController)
local LocalPlayerController = require(Parent.LocalPlayerController)
local CutsceneEvent = require(game.ReplicatedStorage.common.RedEvents.General.CutsceneEvent)
local u30 = "Cinematic"
local u31 = false
local u33 = nil
local u34 = {
    SetCutsceneMode = function(p1, p2) -- Line: 22 -- upvalues: u31 (ref), u30 (ref)
        if u31 and p2 == "FirstPerson" and p2 ~= u30 then
            setupFirstPersonCutscene()
        end
        u30 = p2
    end,
    SetCutsceneEnabled = function(p1, p2) -- Line: 29 -- upvalues: CameraController (val), WeaponController (val), HUDController (val), LocalPlayerController (val), u30 (ref), RunService (val), u31 (ref)
        CameraController:SetEnabled(not p2)
        WeaponController:SetWeaponsEnabled(not p2)
        HUDController:SetVisible(not p2)
        LocalPlayerController:SetMovementEnabled(not p2)
        if u30 == "FirstPerson" then
            if not p2 then
                RunService:UnbindFromRenderStep("FirstPersonCutscene")
            else
                setupFirstPersonCutscene()
            end
        end
        u31 = p2
    end,
}
function setupFirstPersonCutscene() -- Line: 45 -- upvalues: RunService (val), u33 (ref)
    RunService:BindToRenderStep("FirstPersonCutscene", Enum.RenderPriority.Camera.Value, function() -- Line: 46 -- upvalues: u33 (upval)
        if u33 then
            workspace.CurrentCamera.CFrame = u33.CFrame
        end
    end)
end
CutsceneEvent:SetClientListener(function(p1) -- Line: 54 -- upvalues: u34 (val)
    if not p1 then
        return
    end
    if p1.Type == "SetCutsceneEnabled" then
        u34:SetCutsceneEnabled(p1.Enabled)
        return
    end
    if p1.Type == "SetCutsceneMode" then
        u34:SetCutsceneMode(p1.Mode)
    end
end)
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character
if Character then
    task.defer(function() -- Line: 70 -- upvalues: Character (ref), u33 (ref)
        u33 = Character:WaitForChild("Head", 1000)
    end)
end
LocalPlayer.CharacterAdded:Connect(function(p1) -- Line: 66 -- upvalues: u33 (ref)
    u33 = p1:WaitForChild("Head", 1000)
end)
return u34