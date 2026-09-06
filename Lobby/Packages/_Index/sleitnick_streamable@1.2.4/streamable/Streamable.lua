local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local u12 = {}
u12.__index = u12
function u12.new(p1, p2) -- Line: 96 -- upvalues: u12 (val), Trove (val), Signal (val)
    local u2 = {}
    setmetatable(u2, u12)
    u2._trove = Trove.new()
    u2._shown = u2._trove:Construct(Signal)
    u2._shownTrove = Trove.new()
    u2._trove:Add(u2._shownTrove)
    u2.Instance = p1:FindFirstChild(p2)
    local function OnInstanceSet() -- Line: 107 -- upvalues: u2 (val)
        local Instance = u2.Instance
        if typeof(Instance) == "Instance" then
            u2._shown:Fire(Instance, u2._shownTrove)
            local PropertyChangedSignal = Instance:GetPropertyChangedSignal("Parent")
            u2._shownTrove:Connect(PropertyChangedSignal, function() -- Line: 111 -- upvalues: Instance (val), u2 (upval)
                if not Instance.Parent then
                    u2._shownTrove:Clean()
                end
            end)
            u2._shownTrove:Add(function() -- Line: 116 -- upvalues: u2 (upval), Instance (val)
                if u2.Instance == Instance then
                    u2.Instance = nil
                end
            end)
        end
    end
    u2._trove:Connect(p1.ChildAdded, function(p1) -- Line: 124 -- upvalues: p2 (val), u2 (val), OnInstanceSet (val)
        if p1.Name == p2 and not u2.Instance then
            u2.Instance = p1
            OnInstanceSet()
        end
    end)
    if u2.Instance then
        OnInstanceSet()
    end
    return u2
end
function u12.primary(p1) -- Line: 146 -- upvalues: u12 (val), Trove (val), Signal (val)
    local PrimaryPart
    local u1 = {}
    setmetatable(u1, u12)
    u1._trove = Trove.new()
    u1._shown = u1._trove:Construct(Signal)
    u1._shownTrove = Trove.new()
    u1._trove:Add(u1._shownTrove)
    u1.Instance = p1.PrimaryPart
    local _trove = u1._trove
    local PropertyChangedSignal = p1:GetPropertyChangedSignal("PrimaryPart")
    _trove:Connect(PropertyChangedSignal, function() -- Line: 157 -- upvalues: p1 (val), u1 (val)
        local PrimaryPart = p1.PrimaryPart
        u1._shownTrove:Clean()
        u1.Instance = PrimaryPart
        if PrimaryPart then
            u1._shown:Fire(PrimaryPart, u1._shownTrove)
        end
    end)
    if u1.Instance then
        PrimaryPart = p1.PrimaryPart
        u1._shownTrove:Clean()
        u1.Instance = PrimaryPart
        if PrimaryPart then
            u1._shown:Fire(PrimaryPart, u1._shownTrove)
        end
    end
    return u1
end
function u12.Observe(p1, p2) -- Line: 184
    if p1.Instance then
        task.spawn(p2, p1.Instance, p1._shownTrove)
    end
    return p1._shown:Connect(p2)
end
function u12:Destroy() -- Line: 196
    self._trove:Destroy()
end
return u12