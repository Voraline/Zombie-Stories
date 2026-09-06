local CurrentCamera
local v1 = {}
local v2 = {Hotbar = 100, Rail = 200, Dialogue = 300}
v1.Layers = v2
local u2 = {}
local u3 = 0
local u37 = false
local u5 = nil
local function viewportHeight() -- Line: 17
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.ViewportSize.Y
    end
    return 0
end
local function gap() -- Line: 22
    local Y
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        Y = 0
    else
        Y = CurrentCamera.ViewportSize.Y
    end
    return (math.max(8, Y * 0.012))
end
local function queueLayout() -- Line: 26 -- upvalues: u37 (ref), u2 (val)
    if u37 then
        return
    end
    u37 = true
    task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
        local CurrentCamera, Y, v1, v2, v3
        u37 = false
        local v4 = {}
        for k, v in pairs(u2) do
            if not (v4[v.layer]) then
                v4[v.layer] = true
            end
        end
        local v5 = {}
        for k2 in pairs(v4) do
            table.insert(v5, k2)
        end
        table.sort(v5)
        local v6 = 0
        for i, i2 in ipairs(v5) do
            v3 = 0
            for k3, j in pairs(u2) do
                if j.layer == i2 then
                    v1 = math.max(0, j.bottom())
                    CurrentCamera = workspace.CurrentCamera
                    if not CurrentCamera then
                        Y = 0
                    else
                        Y = CurrentCamera.ViewportSize.Y
                    end
                    v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                    j.apply(v2, not j.needsInitialApply)
                    j.needsInitialApply = false
                    if j.occupying then
                        v3 = math.max(v3, j.reserve() + v2)
                    end
                end
            end
            v6 = math.max(v6, v3)
        end
    end)
end
local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera")
PropertyChangedSignal:Connect(function() -- Line: 66 -- upvalues: u5 (ref), queueLayout (val), u37 (ref), u2 (val)
    if u5 then
        u5:Disconnect()
        u5 = nil
    end
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
        local PropertyChangedSignal = CurrentCamera:GetPropertyChangedSignal("ViewportSize")
        u5 = PropertyChangedSignal:Connect(queueLayout)
    end
    if u37 then
        return
    end
    u37 = true
    task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
        local CurrentCamera, Y, v1, v2, v3
        u37 = false
        local v4 = {}
        for k, v in pairs(u2) do
            if not (v4[v.layer]) then
                v4[v.layer] = true
            end
        end
        local v5 = {}
        for k2 in pairs(v4) do
            table.insert(v5, k2)
        end
        table.sort(v5)
        local v6 = 0
        for i, i2 in ipairs(v5) do
            v3 = 0
            for k3, j in pairs(u2) do
                if j.layer == i2 then
                    v1 = math.max(0, j.bottom())
                    CurrentCamera = workspace.CurrentCamera
                    if not CurrentCamera then
                        Y = 0
                    else
                        Y = CurrentCamera.ViewportSize.Y
                    end
                    v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                    j.apply(v2, not j.needsInitialApply)
                    j.needsInitialApply = false
                    if j.occupying then
                        v3 = math.max(v3, j.reserve() + v2)
                    end
                end
            end
            v6 = math.max(v6, v3)
        end
    end)
end)
if u5 then
    u5:Disconnect()
end
CurrentCamera = workspace.CurrentCamera
if CurrentCamera then
    local PropertyChangedSignal_2 = CurrentCamera:GetPropertyChangedSignal("ViewportSize")
end
if not u37 then
    u37 = true
    task.defer(function() -- Line: 31 -- upvalues: u37 (ref), u2 (val)
        local CurrentCamera, Y, v1, v2, v3
        u37 = false
        local v4 = {}
        for k, v in pairs(u2) do
            if not (v4[v.layer]) then
                v4[v.layer] = true
            end
        end
        local v5 = {}
        for k2 in pairs(v4) do
            table.insert(v5, k2)
        end
        table.sort(v5)
        local v6 = 0
        for i, i2 in ipairs(v5) do
            v3 = 0
            for k3, j in pairs(u2) do
                if j.layer == i2 then
                    v1 = math.max(0, j.bottom())
                    CurrentCamera = workspace.CurrentCamera
                    if not CurrentCamera then
                        Y = 0
                    else
                        Y = CurrentCamera.ViewportSize.Y
                    end
                    v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                    j.apply(v2, not j.needsInitialApply)
                    j.needsInitialApply = false
                    if j.occupying then
                        v3 = math.max(v3, j.reserve() + v2)
                    end
                end
            end
            v6 = math.max(v6, v3)
        end
    end)
end
function v1.Register(p1) -- Line: 81 -- upvalues: u3 (ref), u2 (val), u37 (ref)
    local v1 = type(p1) == "table"
    assert(v1, "BottomStack.Register expects a config table")
    v1 = type(p1.Layer) == "number"
    assert(v1, "BottomStack.Register requires Layer")
    v1 = type(p1.Reserve) == "function"
    assert(v1, "BottomStack.Register requires Reserve")
    v1 = type(p1.Bottom) == "function"
    assert(v1, "BottomStack.Register requires Bottom")
    v1 = type(p1.Apply) == "function"
    assert(v1, "BottomStack.Register requires Apply")
    u3 = u3 + 1
    local u52 = {occupying = false, needsInitialApply = true}
    local Name = p1.Name
    if not Name then
        Name = "BottomStack_" .. u3
    end
    u52.name = Name
    u52.layer = p1.Layer
    u52.reserve = p1.Reserve
    u52.bottom = p1.Bottom
    u52.apply = p1.Apply
    u2[u3] = u52
    local u67 = u3
    if not u37 then
        u37 = true
        task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
            local CurrentCamera, Y, v1, v2, v3
            u37 = false
            local v4 = {}
            for k, v in pairs(u2) do
                if not (v4[v.layer]) then
                    v4[v.layer] = true
                end
            end
            local v5 = {}
            for k2 in pairs(v4) do
                table.insert(v5, k2)
            end
            table.sort(v5)
            local v6 = 0
            for i, i2 in ipairs(v5) do
                v3 = 0
                for k3, j in pairs(u2) do
                    if j.layer == i2 then
                        v1 = math.max(0, j.bottom())
                        CurrentCamera = workspace.CurrentCamera
                        if not CurrentCamera then
                            Y = 0
                        else
                            Y = CurrentCamera.ViewportSize.Y
                        end
                        v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                        j.apply(v2, not j.needsInitialApply)
                        j.needsInitialApply = false
                        if j.occupying then
                            v3 = math.max(v3, j.reserve() + v2)
                        end
                    end
                end
                v6 = math.max(v6, v3)
            end
        end)
    end
    local v2 = {}
    function v2.SetOccupying(p1, p2) -- Line: 103 -- upvalues: u2 (upval), u67 (val), u52 (val), u37 (upval)
        if not (u2[u67]) then
            return
        end
        local v1 = p2 == true
        if u52.occupying == v1 then
            return
        end
        v1 = p2 == true
        u52.occupying = v1
        if u37 then
            return
        end
        u37 = true
        task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
            local CurrentCamera, Y, v1, v2, v3
            u37 = false
            local v4 = {}
            for k, v in pairs(u2) do
                if not (v4[v.layer]) then
                    v4[v.layer] = true
                end
            end
            local v5 = {}
            for k2 in pairs(v4) do
                table.insert(v5, k2)
            end
            table.sort(v5)
            local v6 = 0
            for i, i2 in ipairs(v5) do
                v3 = 0
                for k3, j in pairs(u2) do
                    if j.layer == i2 then
                        v1 = math.max(0, j.bottom())
                        CurrentCamera = workspace.CurrentCamera
                        if not CurrentCamera then
                            Y = 0
                        else
                            Y = CurrentCamera.ViewportSize.Y
                        end
                        v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                        j.apply(v2, not j.needsInitialApply)
                        j.needsInitialApply = false
                        if j.occupying then
                            v3 = math.max(v3, j.reserve() + v2)
                        end
                    end
                end
                v6 = math.max(v6, v3)
            end
        end)
    end
    function v2.Invalidate(p1) -- Line: 110 -- upvalues: u2 (upval), u67 (val), u37 (upval)
        if not (u2[u67]) or u37 then
            return
        end
        u37 = true
        task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
            local CurrentCamera, Y, v1, v2, v3
            u37 = false
            local v4 = {}
            for k, v in pairs(u2) do
                if not (v4[v.layer]) then
                    v4[v.layer] = true
                end
            end
            local v5 = {}
            for k2 in pairs(v4) do
                table.insert(v5, k2)
            end
            table.sort(v5)
            local v6 = 0
            for i, i2 in ipairs(v5) do
                v3 = 0
                for k3, j in pairs(u2) do
                    if j.layer == i2 then
                        v1 = math.max(0, j.bottom())
                        CurrentCamera = workspace.CurrentCamera
                        if not CurrentCamera then
                            Y = 0
                        else
                            Y = CurrentCamera.ViewportSize.Y
                        end
                        v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                        j.apply(v2, not j.needsInitialApply)
                        j.needsInitialApply = false
                        if j.occupying then
                            v3 = math.max(v3, j.reserve() + v2)
                        end
                    end
                end
                v6 = math.max(v6, v3)
            end
        end)
    end
    function v2.Destroy(p1) -- Line: 116 -- upvalues: u2 (upval), u67 (val), u37 (upval)
        if not (u2[u67]) then
            return
        end
        u2[u67] = nil
        if u37 then
            return
        end
        u37 = true
        task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
            local CurrentCamera, Y, v1, v2, v3
            u37 = false
            local v4 = {}
            for k, v in pairs(u2) do
                if not (v4[v.layer]) then
                    v4[v.layer] = true
                end
            end
            local v5 = {}
            for k2 in pairs(v4) do
                table.insert(v5, k2)
            end
            table.sort(v5)
            local v6 = 0
            for i, i2 in ipairs(v5) do
                v3 = 0
                for k3, j in pairs(u2) do
                    if j.layer == i2 then
                        v1 = math.max(0, j.bottom())
                        CurrentCamera = workspace.CurrentCamera
                        if not CurrentCamera then
                            Y = 0
                        else
                            Y = CurrentCamera.ViewportSize.Y
                        end
                        v2 = math.max(0, v6 + math.max(8, Y * 0.012) - v1)
                        j.apply(v2, not j.needsInitialApply)
                        j.needsInitialApply = false
                        if j.occupying then
                            v3 = math.max(v3, j.reserve() + v2)
                        end
                    end
                end
                v6 = math.max(v6, v3)
            end
        end)
    end
    return v2
end
return v1