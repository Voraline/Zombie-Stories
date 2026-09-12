local UserInputService = game:GetService("UserInputService")
local v1 = {}
local u6 = {}
u6.__index = v1

function v1.new() -- Line: 8 -- upvalues: u6 (val)
    local v1 = u6
    return (setmetatable({connections = {}}, v1))
end

function v1.BindToInput(p1, p2, p3, ...) -- Line: 18 -- upvalues: UserInputService (val)
    local InputEnded, v1, v2, v3, v4, v5
    local v6 = {...}
    p1.connections[p2] = {}
    local v7 = #v6
    for i = 1, v7 do
        local u14 = v6[i]
        v4 = p1.connections[p2]
        v5 = {}
        v1 = UserInputService
        v1 = v1.InputBegan:Connect(function(p1, p2_2) -- Line: 25 -- upvalues: u14 (val), p3 (val), p2 (val)
            if p1.KeyCode == u14 then
                p3(p2, p1.UserInputState, p1)
            end
        end)
        v2 = UserInputService
        v2 = v2.InputChanged:Connect(function(p1, p2_2) -- Line: 31 -- upvalues: u14 (val), p3 (val), p2 (val)
            if p1.KeyCode == u14 then
                p3(p2, p1.UserInputState, p1)
            end
        end)
        v3 = UserInputService
        InputEnded = v3.InputEnded
        v5[1] = v1
        v5[2] = v2
        v5[3] = InputEnded:Connect(function(p1, p2_2) -- Line: 37 -- upvalues: u14 (val), p3 (val), p2 (val)
            if p1.KeyCode == u14 then
                p3(p2, p1.UserInputState, p1)
            end
        end)
        v4[u14] = v5
    end
end

function v1.UnbindAction(p1, p2) -- Line: 46
    local v1
    local v2 = next
    local v3 = p1.connections[p2]
    local v4 = nil
    local v5, v6 = p1, p2
    for k, v in v2, v3, v4 do
        v1 = #v
        for i = 1, v1 do
            v[i]:Disconnect()
        end
    end
    v5.connections[v6] = nil
end

return v1.new()