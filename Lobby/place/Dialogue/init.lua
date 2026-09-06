local v1 = {}
local u1 = {}
for i, v in ipairs(script:GetChildren()) do
    (function(p1) -- Line: 4 -- upvalues: u1 (val)
        local v1, v2
        if not (p1:IsA("ModuleScript")) then
            return
        end
        v1, v2 = pcall(require, p1)
        if not v1 then
            local FullName = p1:GetFullName()
            warn(string.format("[LobbyDialogue] Failed to require %s: %s", FullName, (tostring(v2))))
            return
        end
        if type(v2) ~= "table" or type(v2.id) ~= "string" then
            warn(string.format("[LobbyDialogue] %s did not return a dialogue tree with an id", p1:GetFullName()))
            return
        end
        u1[v2.id] = v2
    end)(v)
end
function v1.Get(p1) -- Line: 24 -- upvalues: u1 (val)
    return u1[p1]
end
function v1.GetIds() -- Line: 28 -- upvalues: u1 (val)
    local v1 = {}
    for k in pairs(u1) do
        table.insert(v1, k)
    end
    table.sort(v1)
    return v1
end
return v1