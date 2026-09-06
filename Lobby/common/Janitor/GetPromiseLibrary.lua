local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local u20 = {
    script.Parent.Parent,
    ReplicatedFirst,
    ReplicatedStorage,
    ServerScriptService,
    ServerStorage,
}
local function FindFirstDescendantWithNameAndClassName(p1, p2, p3) -- Line: 9
    local v1 = p1:QueryDescendants(p3 .. "#" .. p2)
    if 0 < #v1 then
        return v1[1]
    end
    return nil
end
return function() -- Line: 17 -- upvalues: u20 (val)
    local v1, v2
    local v3 = script:FindFirstAncestorOfClass("Plugin")
    if v3 then
        local v4 = v3:QueryDescendants("ModuleScript#Promise")
        if 0 >= #v4 then
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
        if 0 >= #v2 then
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