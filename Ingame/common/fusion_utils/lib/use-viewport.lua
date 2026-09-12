local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
require(script.Parent.utils["lock-value"])
local v1 = require(script.Parent["use-camera"])
local u22 = Fusion.scoped(Fusion)
local u24 = v1()
local zero = Vector2.zero
local u28 = u22:Value(zero)
onViewportChanged = nil

local function setupHook() -- Line: 18 -- upvalues: u22 (val), u24 (val), u28 (val)
    local u3 = u22.peek(u24)
    if onViewportChanged then
        onViewportChanged:Disconnect()
    end
    onViewportChanged = (u3:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 23 -- upvalues: u28 (upval), u3 (val)
        local v1 = u28
        local v2 = u3
        local ViewportSize = v2.ViewportSize
        v1:set(ViewportSize)
    end)
    local v1 = u28
    local ViewportSize = u3.ViewportSize
    v1:set(ViewportSize)
end

setupHook()
;(u22:Observer(u24)):onChange(setupHook)
return function() -- Line: 32 -- upvalues: u28 (val)
    return u28
end