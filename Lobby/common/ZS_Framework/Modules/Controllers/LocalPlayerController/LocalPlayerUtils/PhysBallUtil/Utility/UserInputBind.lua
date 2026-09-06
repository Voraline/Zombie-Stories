local UserInputService = game:GetService("UserInputService")
local v1 = {}
local u6 = {__index = v1}
function v1.new() -- Line: 8 -- upvalues: u6 (val)
    local v1 = {connections = {}}
    return (setmetatable(v1, u6))
end
function v1.BindToInput(p1, p2, p3, ...) -- Line: 18 -- upvalues: UserInputService (val)
    local v1, v2, v3, v4
    local v5 = {...}
    p1.connections[p2] = {}
    local v6 = #v5
    local v7 = 1
    for i = 1, v6, v7 do
        local u14 = v5[i]
        v3 = p1.connections[p2]
        v4 = {}
        v1 = UserInputService.InputBegan:Connect(function(p1, a2) -- Line: 25 -- upvalues: u14 (val), p3 (val), p2 (val)
            if p1.KeyCode == u14 then
                p3(p2, p1.UserInputState, p1)
            end
        end)
        v2 = UserInputService.InputChanged:Connect(function(p1, a2) -- Line: 31 -- upvalues: u14 (val), p3 (val), p2 (val)
            if p1.KeyCode == u14 then
                p3(p2, p1.UserInputState, p1)
            end
        end)
        v4[1] = v1
        v4[2] = v2
        v4[3] = UserInputService.InputEnded:Connect(function(p1, a2) -- Line: 37 -- upvalues: u14 (val), p3 (val), p2 (val)
            if p1.KeyCode == u14 then
                p3(p2, p1.UserInputState, p1)
            end
        end)
        v3[u14] = v4
    end
end
function v1.UnbindAction(p1, p2) -- Line: 46
    local v1, v2, v3, v4
    local v5 = next
    local v6 = p1.connections[p2]
    local v7 = nil
    v1, v2 = p1, p2
    for k, v in v5, v6, v7 do
        v3 = #v
        v4 = 1
        for i = 1, v3, v4 do
            v[i]:Disconnect()
        end
    end
    v1.connections[v2] = nil
end
return v1.new()