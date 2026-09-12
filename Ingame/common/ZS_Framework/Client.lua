local MblEdit, MblPresets
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Modules.Utils.LookAngleInbox)
local RedEvents = ReplicatedStorage.common.RedEvents
local IsLobby = (workspace:WaitForChild("Values")):WaitForChild("IsLobby")
local BindableEvent = Instance.new("BindableEvent")
BindableEvent.Name = "FrameworkEvent"
BindableEvent.Parent = game.Players.LocalPlayer:WaitForChild("PlayerScripts")
local common = ReplicatedStorage.common
local ForceTeleport = require(RedEvents.Framework.ForceTeleport)
local LookAtEvent = require(RedEvents.Framework.LookAtEvent)
local FrameworkEvents = require(RedEvents.Framework.FrameworkEvents)
local PreloadWeapon = FrameworkEvents.PreloadWeapon
require("./Data/Initializer")
for i, j in script.Parent.Controllers:GetChildren() do
    require(j)
end
for k, n in script.Parent.UI.Controllers:GetChildren() do
    require(n)
end
local WepConfig = require(common:WaitForChild("WepConfig"))
PreloadWeapon:SetClientListener(function(p1) -- Line: 34 -- upvalues: WepConfig (val)
    if type(p1) ~= "table" then
        if type(p1) == "string" then
            WepConfig:PreloadWeapon(p1)
        end
        return
    end
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        task.defer(function() -- Line: 37 -- upvalues: WepConfig (upval), j (val)
            local v1 = WepConfig
            local v2 = j
            v1:PreloadWeapon(v2)
        end)
    end
end)
local Modules = script.Parent:WaitForChild("Modules")
Modules:WaitForChild("Utils")
local Controllers = Modules:WaitForChild("Controllers")
Modules:WaitForChild("Classes")
require(Controllers:WaitForChild("HUDController")):Init()
local Remotes = game.ReplicatedStorage.common:FindFirstChild("Remotes")
local DataRemote = Remotes
if DataRemote then
    DataRemote = Remotes:FindFirstChild("DataRemote")
end
local v1 = nil
if DataRemote then
    v1 = DataRemote:InvokeServer("GetData")
    if not v1 then
        for m = 1, 5 do
            v1 = DataRemote:InvokeServer("GetData")
            if v1 then
                break
            end
            task.wait(2)
        end
    end
end
local MobileControls = require(Controllers.HUDController.HUDElements:WaitForChild("MobileControls"))
if not v1 then
    MblEdit = {}
else
    MblEdit = v1.Settings.MblEdit
end
MobileControls.EditData = MblEdit
if not v1 then
    MblPresets = {}
else
    MblPresets = v1.Settings.MblPresets
    if not MblPresets then
        MblPresets = {}
    end
end
MobileControls.PresetData = MblPresets
require(Controllers:WaitForChild("ReplicationController")).Init()
local WeaponController = require(Controllers:WaitForChild("WeaponController"))
local InputController = require(Controllers:WaitForChild("InputController"))
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
local CameraController = require(Controllers:WaitForChild("CameraController"))
require(Controllers:WaitForChild("CutsceneController"))
local HUDOverlayController = require(Controllers:WaitForChild("HUDOverlayController"))
local HealthBarController = require(Controllers:WaitForChild("HealthBarController"))
InputController:Init()
InputController:SetupBinds()
LocalPlayerController:Init()
CameraController:Init()
CameraController:SetEnabled(true)
script:SetAttribute("Initialized", true)
if not IsLobby.Value then
    local LocalPlayer = game.Players.LocalPlayer
    HealthBarController:Init(LocalPlayer)
else
    HUDOverlayController:SetEnabled(false)
end
ForceTeleport:OnClient(function(p1) -- Line: 117 -- upvalues: CameraController (val)
    CameraController:ForceTeleport(p1)
end)
LookAtEvent:SetClientListener(function(p1) -- Line: 121 -- upvalues: CameraController (val)
    CameraController:LookAt(p1)
end)
FrameworkEvents.RollbackHP:SetClientListener(function(p1) -- Line: 125
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        j[1].Value = j[2]
        j[1]:SetAttribute("Rollback", true)
    end
end)
PreloadWeapon:FireServer()
WeaponController:RequestLoadout()
;(FrameworkEvents.RequestPendingTeleport:Call()):After(function(p1, p2) -- Line: 141 -- upvalues: CameraController (val)
    if p1 and p2 then
        CameraController:ForceTeleport(p2)
    end
end)
return nil