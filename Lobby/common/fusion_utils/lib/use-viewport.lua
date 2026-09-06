local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
require(script.Parent.utils["lock-value"])
local v1 = require(script.Parent["use-camera"])
local u22 = Fusion.scoped(Fusion)
local u24 = v1()
local u28 = u22:Value(Vector2.zero)
onViewportChanged = nil
local function setupHook() -- Line: 18 -- upvalues: u22 (val), u24 (val), u28 (val)
    local u3 = u22.peek(u24)
    if onViewportChanged then
        onViewportChanged:Disconnect()
    end
    local PropertyChangedSignal = u3:GetPropertyChangedSignal("ViewportSize")
    onViewportChanged = PropertyChangedSignal:Connect(function() -- Line: 23 -- upvalues: u28 (upval), u3 (val)
        u28:set(u3.ViewportSize)
    end)
    u28:set(u3.ViewportSize)
end
setupHook()
local v2 = u22:Observer(u24)
v2:onChange(setupHook)
return function() -- Line: 32 -- upvalues: u28 (val)
    return u28
end