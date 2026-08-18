local v_u_1 = {}
local v_u_2 = require("../../../Utils/RaycastUtil")
v_u_1.LastTarget = os.clock()
function v_u_1.CheckTarget(_) -- name: CheckTarget
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v3 = v_u_2.CastBaseRay().Instance
	if v3 then
		if v3:IsDescendantOf(workspace.Zombies) then
			local v4 = v3:FindFirstAncestorWhichIsA("Model")
			if v4 and (v4:GetAttribute("Health") or 100) > 0 then
				v_u_1.LastTarget = os.clock() + 0.05
				return true
			end
		end
		return os.clock() < v_u_1.LastTarget
	end
end
return v_u_1