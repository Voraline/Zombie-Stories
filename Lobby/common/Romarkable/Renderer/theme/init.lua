local Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.common:FindFirstChild("Fusion", true))
local Value = Fusion.Value
local Computed = Fusion.Computed
local u15 = {textSize = 0.02, headerSize = 0.025, subSize = 0.014, cornerSize = 0.0049}
local u16 = {}
local v1 = {}
for i, v in ipairs(script:GetChildren()) do
    if v:IsA("ModuleScript") then
        u16[v.Name] = (require(v))
        Name = v.Name
        table.insert(v1, Name)
    end
end
local u33 = {
    Nord = 1,
    Dark = 2,
    Light = 3,
    Ocean = 4,
    Autumn = 5,
    Demon = 6,
}
table.sort(v1, function(p1, p2) -- Line: 23 -- upvalues: u33 (val)
    local v1 = (u33[p1] or 100) < (u33[p2] or 100)
    return v1
end)
local u39 = {}
u39.options = v1

function u39.init(p1) -- Line: 31 -- upvalues: u39 (val), Value (val), u16 (val), Computed (val), u15 (val)
    local v1, v2
    u39.name = p1
    local u7 = Value(workspace.CurrentCamera.ViewportSize.Y)
    ;(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 35 -- upvalues: u7 (val)
        local v1 = u7
        local Y = workspace.CurrentCamera.ViewportSize.Y
        v1:set(Y)
    end)
    for k in pairs(u16.Nord) do
        v1 = u39
        v2 = Computed
        v1[k] = (v2(function() -- Line: 41 -- upvalues: p1 (val), u16 (upval), k (val)
            local v1 = p1:get()
            local Nord = u16[v1]
            if not Nord then
                Nord = u16.Nord
            end
            return Nord[k]:get()
        end))
    end
    for k2, v in pairs(u15) do
        v1 = u39
        v2 = Computed
        v1[k2] = (v2(function() -- Line: 50 -- upvalues: u7 (val), v (val)
            local v1 = u7:get()
            local v2 = v
            local v3 = v1 * v2
            return (math.floor(v3))
        end))
    end
end

return u39