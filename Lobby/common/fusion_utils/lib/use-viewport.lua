local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
require(script.Parent.utils["lock-value"])
local v3 = require(script.Parent["use-camera"])
local v_u_4 = v2.scoped(v2)
local v_u_5 = v3()
local v_u_6 = v_u_4:Value(Vector2.zero)
onViewportChanged = nil
local function v8() -- name: setupHook
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	local v_u_7 = v_u_4.peek(v_u_5)
	if onViewportChanged then
		onViewportChanged:Disconnect()
	end
	onViewportChanged = v_u_7:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		-- upvalues: (ref) v_u_6, (copy) v_u_7
		v_u_6:set(v_u_7.ViewportSize)
	end)
	v_u_6:set(v_u_7.ViewportSize)
end
v8()
v_u_4:Observer(v_u_5):onChange(v8)
return function()
	-- upvalues: (copy) v_u_6
	return v_u_6
end