local v1
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))
if RunService:IsClient() == false then
    error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end
local v2 = {
    Enabled = true,
    MashToEnable = false,
    ActivationUnlocksMouse = false,
    HideOnLostFocus = true,
    PlaceName = "Cmdr",
    ReplicatedRoot = script,
    RemoteFunction = script:WaitForChild("CmdrFunction"),
    RemoteEvent = script:WaitForChild("CmdrEvent"),
}
local v3 = {}
v3[Enum.KeyCode.F2] = true
v2.ActivationKeys = v3
v2.Util = Util
v2.Events = {}
local u55 = setmetatable(v2, {
    __index = function(p1, p2) -- Line: 28
        local u3 = p1.Dispatcher[p2]
        if not u3 then
            return
        end
        if type(u3) == "function" then
            return function(a1, ...) -- Line: 31 -- upvalues: u3 (val), p1 (val)
                return u3(p1.Dispatcher, ...)
            end
        end
    end,
})
local Registry = require(Shared.Registry)
u55.Registry = Registry(u55)
local Dispatcher = require(Shared.Dispatcher)
u55.Dispatcher = Dispatcher(u55)
if StarterGui:WaitForChild("Cmdr") and wait() then
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    if PlayerGui:FindFirstChild("Cmdr") == nil then
        v1 = StarterGui.Cmdr:Clone()
        v1.Parent = LocalPlayer.PlayerGui
    end
end
v1 = require("@self/CmdrInterface")
local u93 = v1(u55)
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
    u93.Window:SetVisible(not u93.Window:IsVisible())
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
    u55.Registry:RegisterTypesIn(script:WaitForChild("Types"))
    u55.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end
u55.RemoteEvent.OnClientEvent:Connect(function(p1, ...) -- Line: 118 -- upvalues: u55 (ref)
    if u55.Events[p1] then
        u55.Events[p1](...)
    end
end)
v2 = require("@self/DefaultEventHandlers")
v2(u55)
return u55