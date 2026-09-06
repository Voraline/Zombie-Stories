local u0 = {}
local u3 = require("../../../Utils/RaycastUtil")
u0.LastTarget = os.clock()
function u0.CheckTarget(p1) -- Line: 7 -- upvalues: u3 (val), u0 (val)
    local v1
    local Instance = u3.CastBaseRay().Instance
    if not Instance then
        return
    end
    if not (Instance:IsDescendantOf(workspace.Zombies)) then
        v1 = os.clock() < u0.LastTarget
        return v1
    end
    v1 = Instance:FindFirstAncestorWhichIsA("Model")
    if not v1 then
        v1 = os.clock() < u0.LastTarget
        return v1
    end
    local v2 = v1:GetAttribute("Health") or 100
    if 0 < v2 then
        u0.LastTarget = os.clock() + 0.05
        return true
    end
    v1 = os.clock() < u0.LastTarget
    return v1
end
return u0