local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local u12 = {}
u12.__index = u12

function u12.new(p1, p2) -- Line: 96 -- upvalues: u12 (val), Trove (val), Signal (val)
    local u2 = {}
    local v1 = u12
    setmetatable(u2, v1)
    u2._trove = Trove.new()
    local _trove = u2._trove
    v1 = Signal
    u2._shown = _trove:Construct(v1)
    u2._shownTrove = Trove.new()
    local _trove_2 = u2._trove
    local _shownTrove = u2._shownTrove
    _trove_2:Add(_shownTrove)
    u2.Instance = p1:FindFirstChild(p2)

    local function OnInstanceSet() -- Line: 107 -- upvalues: u2 (val)
        local Instance = u2.Instance
        if typeof(Instance) == "Instance" then
            local v1 = u2
            local _shown = v1._shown
            local v2 = u2
            local _shownTrove = v2._shownTrove
            _shown:Fire(Instance, _shownTrove)
            v1 = u2
            local _shownTrove_2 = v1._shownTrove
            local PropertyChangedSignal = Instance:GetPropertyChangedSignal("Parent")
            _shownTrove_2:Connect(PropertyChangedSignal, function() -- Line: 111 -- upvalues: Instance (val), u2 (upval)
                if not Instance.Parent then
                    u2._shownTrove:Clean()
                end
            end)
            v1 = u2
            v1._shownTrove:Add(function() -- Line: 116 -- upvalues: u2 (upval), Instance (val)
                if u2.Instance == Instance then
                    u2.Instance = nil
                end
            end)
        end
    end

    local _trove_3 = u2._trove
    local ChildAdded = p1.ChildAdded
    _trove_3:Connect(ChildAdded, function(p1) -- Line: 124 -- upvalues: p2 (val), u2 (val), OnInstanceSet (val)
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
    local u1 = {}
    local v1 = u12
    setmetatable(u1, v1)
    u1._trove = Trove.new()
    local _trove = u1._trove
    v1 = Signal
    u1._shown = _trove:Construct(v1)
    u1._shownTrove = Trove.new()
    local _trove_2 = u1._trove
    local _shownTrove = u1._shownTrove
    _trove_2:Add(_shownTrove)
    u1.Instance = p1.PrimaryPart
    local _trove_3 = u1._trove
    local PropertyChangedSignal = p1:GetPropertyChangedSignal("PrimaryPart")
    _trove_3:Connect(PropertyChangedSignal, function() -- Line: 157 -- upvalues: p1 (val), u1 (val)
        local PrimaryPart = p1.PrimaryPart
        u1._shownTrove:Clean()
        u1.Instance = PrimaryPart
        if PrimaryPart then
            local v1 = u1
            local _shown = v1._shown
            local v2 = u1
            local _shownTrove = v2._shownTrove
            _shown:Fire(PrimaryPart, _shownTrove)
        end
    end)
    if u1.Instance then
        local PrimaryPart = p1.PrimaryPart
        u1._shownTrove:Clean()
        u1.Instance = PrimaryPart
        if PrimaryPart then
            local _shown = u1._shown
            local _shownTrove_2 = u1._shownTrove
            _shown:Fire(PrimaryPart, _shownTrove_2)
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