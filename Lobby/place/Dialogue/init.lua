local v1 = {}
local u1 = {}

local function register(p1) -- Line: 4 -- upvalues: u1 (val)
    if not p1:IsA("ModuleScript") then
        return
    end
    local success, result = pcall(require, p1)
    if not success then
        warn(string.format("[LobbyDialogue] Failed to require %s: %s", p1:GetFullName(), (tostring(result))))
        return
    end
    if type(result) == "table" then
        local id = result.id
        if type(id) == "string" then
            u1[result.id] = result
            return
        end
    end
    warn(string.format("[LobbyDialogue] %s did not return a dialogue tree with an id", p1:GetFullName()))
end

for i, v in ipairs(script:GetChildren()) do
    register(v)
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