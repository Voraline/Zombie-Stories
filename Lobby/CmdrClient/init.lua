local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))
if RunService:IsClient() == false then
    error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end
local v1 = {
    Enabled = true,
    MashToEnable = false,
    ActivationUnlocksMouse = false,
    HideOnLostFocus = true,
    PlaceName = "Cmdr",
    ReplicatedRoot = script,
    RemoteFunction = script:WaitForChild("CmdrFunction"),
    RemoteEvent = script:WaitForChild("CmdrEvent"),
}
local v2 = {}
v2[Enum.KeyCode.F2] = true
v1.ActivationKeys = v2
v1.Util = Util
v1.Events = {}
v2 = {
    __index = function(p1, p2) -- Line: 28
        local u3 = p1.Dispatcher[p2]
        if u3 and type(u3) == "function" then
            return function(p1_2, ...) -- Line: 31 -- upvalues: u3 (val), p1 (val)
                return u3(p1.Dispatcher, ...)
            end
        end
    end,
}
local u55 = setmetatable(v1, v2)
local Registry = require(Shared.Registry)
u55.Registry = Registry(u55)
local Dispatcher = require(Shared.Dispatcher)
u55.Dispatcher = Dispatcher(u55)
if StarterGui:WaitForChild("Cmdr")
    and wait()
    and (LocalPlayer:WaitForChild("PlayerGui")):FindFirstChild("Cmdr") == nil then
    local v3 = StarterGui.Cmdr:Clone()
    v3.Parent = LocalPlayer.PlayerGui
end
local u93 = require("@self/CmdrInterface")(u55)

function u55.SetActivationKeys(p1, p2) -- Line: 49 -- upvalues: Util (val)
    p1.ActivationKeys = Util.MakeDictionary(p2)
end

function u55.SetPlaceName(p1, p2) -- Line: 54 -- upvalues: u93 (val)
    p1.PlaceName = p2
    u93.Window:UpdateLabel()
end

function u55:SetEnabled(p2) -- Line: 60
    self.Enabled = p2
end

function u55.SetActivationUnlocksMouse(p1, p2) -- Line: 65
    p1.ActivationUnlocksMouse = p2
end

function u55:Show() -- Line: 70 -- upvalues: u93 (val)
    if not self.Enabled then
        return
    end
    u93.Window:Show()
end

function u55.Hide(p1) -- Line: 79 -- upvalues: u93 (val)
    u93.Window:Hide()
end

function u55.Toggle(p1) -- Line: 84 -- upvalues: u93 (val)
    if not p1.Enabled then
        return p1:Hide()
    end
    local v1 = u93
    local Window = v1.Window
    local v2 = u93.Window:IsVisible()
    Window:SetVisible(not v2)
end

function u55.SetMashToEnable(p1, p2) -- Line: 93
    p1.MashToEnable = p2
    if p2 then
        p1:SetEnabled(false)
    end
end

function u55.SetHideOnLostFocus(p1, p2) -- Line: 102
    p1.HideOnLostFocus = p2
end

function u55.HandleEvent(p1, p2, p3) -- Line: 107
    p1.Events[p2] = p3
end

if RunService:IsServer() == false then
    local Registry_2 = u55.Registry
    local Types = script:WaitForChild("Types")
    Registry_2:RegisterTypesIn(Types)
    local Registry_3 = u55.Registry
    local Commands = script:WaitForChild("Commands")
    Registry_3:RegisterCommandsIn(Commands)
end
u55.RemoteEvent.OnClientEvent:Connect(function(p1, ...) -- Line: 118 -- upvalues: u55 (ref)
    if u55.Events[p1] then
        u55.Events[p1](...)
    end
end)
require("@self/DefaultEventHandlers")(u55)
return u55