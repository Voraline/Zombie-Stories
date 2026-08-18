local v1 = game:GetService("Workspace")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Packages.Fusion)
local v_u_4 = v3.scoped(v3):Value(v1.CurrentCamera)
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	-- upvalues: (copy) v_u_4
	if workspace.CurrentCamera then
		v_u_4:set(workspace.CurrentCamera)
	end
end)
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end