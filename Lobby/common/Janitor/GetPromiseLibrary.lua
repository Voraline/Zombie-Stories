local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local u20 = {}
u20[1] = script.Parent.Parent
u20[2] = ReplicatedFirst
u20[3] = ReplicatedStorage
u20[4] = ServerScriptService
u20[5] = ServerStorage

local function FindFirstDescendantWithNameAndClassName(p1, p2, p3) -- Line: 9
    local v1 = p3 .. "#" .. p2
    local v2 = p1:QueryDescendants(v1)
    if 0 < #v2 then
        return v2[1]
    end
    return nil
end

return function() -- Line: 17 -- upvalues: u20 (val)
    local v1, v2
    local v3 = script:FindFirstAncestorOfClass("Plugin")
    if v3 then
        local v4 = v3:QueryDescendants("ModuleScript#Promise")
        if not (0 < #v4) then
            v1 = nil
        else
            v1 = v4[1]
        end
        if v1 then
            return true, require(v1)
        end
        return false
    end
    v1 = nil
    for i, v in ipairs(u20) do
        v2 = v:QueryDescendants("ModuleScript#Promise")
        if not (0 < #v2) then
            v1 = nil
        else
            v1 = v2[1]
        end
        if v1 then
            break
        end
    end
    if v1 then
        return true, require(v1)
    end
    return false
end