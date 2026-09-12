local v1 = {
    Layers = {Hotbar = 100, Rail = 200, Dialogue = 300},
}
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
    local v1 = Y * 0.012
    return (math.max(8, v1))
end

local function queueLayout() -- Line: 26 -- upvalues: u37 (ref), u2 (val)
    if u37 then
        return
    end
    u37 = true
    task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
        local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
        u37 = false
        local v8 = {}
        for k, v in pairs(u2) do
            if not v8[v.layer] then
                v8[v.layer] = true
            end
        end
        local v9 = {}
        for k2 in pairs(v8) do
            table.insert(v9, k2)
        end
        table.sort(v9)
        local v10 = 0
        for i, i2 in ipairs(v9) do
            v7 = 0
            for k3, j in pairs(u2) do
                if j.layer == i2 then
                    v3 = j.bottom()
                    v1 = math.max(0, v3)
                    CurrentCamera = workspace.CurrentCamera
                    if not CurrentCamera then
                        Y = 0
                    else
                        Y = CurrentCamera.ViewportSize.Y
                    end
                    v6 = Y * 0.012
                    v5 = v10 + (math.max(8, v6))
                    v4 = v5 - v1
                    v2 = math.max(0, v4)
                    j.apply(v2, not j.needsInitialApply)
                    j.needsInitialApply = false
                    if j.occupying then
                        v5 = (j.reserve()) + v2
                        v7 = math.max(v7, v5)
                    end
                end
            end
            v10 = math.max(v10, v7)
        end
    end)
end

;(workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 66 -- upvalues: u5 (ref), queueLayout (val), u37 (ref), u2 (val)
    if u5 then
        u5:Disconnect()
        u5 = nil
    end
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
        local PropertyChangedSignal = CurrentCamera:GetPropertyChangedSignal("ViewportSize")
        local v1 = queueLayout
        u5 = PropertyChangedSignal:Connect(v1)
    end
    if u37 then
        return
    end
    u37 = true
    task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
        local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
        u37 = false
        local v8 = {}
        for k, v in pairs(u2) do
            if not v8[v.layer] then
                v8[v.layer] = true
            end
        end
        local v9 = {}
        for k2 in pairs(v8) do
            table.insert(v9, k2)
        end
        table.sort(v9)
        local v10 = 0
        for i, i2 in ipairs(v9) do
            v7 = 0
            for k3, j in pairs(u2) do
                if j.layer == i2 then
                    v3 = j.bottom()
                    v1 = math.max(0, v3)
                    CurrentCamera = workspace.CurrentCamera
                    if not CurrentCamera then
                        Y = 0
                    else
                        Y = CurrentCamera.ViewportSize.Y
                    end
                    v6 = Y * 0.012
                    v5 = v10 + (math.max(8, v6))
                    v4 = v5 - v1
                    v2 = math.max(0, v4)
                    j.apply(v2, not j.needsInitialApply)
                    j.needsInitialApply = false
                    if j.occupying then
                        v5 = (j.reserve()) + v2
                        v7 = math.max(v7, v5)
                    end
                end
            end
            v10 = math.max(v10, v7)
        end
    end)
end)
if u5 then
    u5:Disconnect()
end
local CurrentCamera = workspace.CurrentCamera
if CurrentCamera then
    local v2 = (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(queueLayout)
end
if not u37 then
    u37 = true
    task.defer(function() -- Line: 31 -- upvalues: u37 (ref), u2 (val)
        local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
        u37 = false
        local v8 = {}
        for k, v in pairs(u2) do
            if not v8[v.layer] then
                v8[v.layer] = true
            end
        end
        local v9 = {}
        for k2 in pairs(v8) do
            table.insert(v9, k2)
        end
        table.sort(v9)
        local v10 = 0
        for i, i2 in ipairs(v9) do
            v7 = 0
            for k3, j in pairs(u2) do
                if j.layer == i2 then
                    v3 = j.bottom()
                    v1 = math.max(0, v3)
                    CurrentCamera = workspace.CurrentCamera
                    if not CurrentCamera then
                        Y = 0
                    else
                        Y = CurrentCamera.ViewportSize.Y
                    end
                    v6 = Y * 0.012
                    v5 = v10 + (math.max(8, v6))
                    v4 = v5 - v1
                    v2 = math.max(0, v4)
                    j.apply(v2, not j.needsInitialApply)
                    j.needsInitialApply = false
                    if j.occupying then
                        v5 = (j.reserve()) + v2
                        v7 = math.max(v7, v5)
                    end
                end
            end
            v10 = math.max(v10, v7)
        end
    end)
end

function v1.Register(p1) -- Line: 81 -- upvalues: u3 (ref), u2 (val), u37 (ref)
    local v1 = type(p1) == "table"
    assert(v1, "BottomStack.Register expects a config table")
    local Layer = p1.Layer
    v1 = type(Layer) == "number"
    assert(v1, "BottomStack.Register requires Layer")
    local Reserve = p1.Reserve
    v1 = type(Reserve) == "function"
    assert(v1, "BottomStack.Register requires Reserve")
    local Bottom = p1.Bottom
    v1 = type(Bottom) == "function"
    assert(v1, "BottomStack.Register requires Bottom")
    local Apply = p1.Apply
    v1 = type(Apply) == "function"
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
            local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
            u37 = false
            local v8 = {}
            for k, v in pairs(u2) do
                if not v8[v.layer] then
                    v8[v.layer] = true
                end
            end
            local v9 = {}
            for k2 in pairs(v8) do
                table.insert(v9, k2)
            end
            table.sort(v9)
            local v10 = 0
            for i, i2 in ipairs(v9) do
                v7 = 0
                for k3, j in pairs(u2) do
                    if j.layer == i2 then
                        v3 = j.bottom()
                        v1 = math.max(0, v3)
                        CurrentCamera = workspace.CurrentCamera
                        if not CurrentCamera then
                            Y = 0
                        else
                            Y = CurrentCamera.ViewportSize.Y
                        end
                        v6 = Y * 0.012
                        v5 = v10 + (math.max(8, v6))
                        v4 = v5 - v1
                        v2 = math.max(0, v4)
                        j.apply(v2, not j.needsInitialApply)
                        j.needsInitialApply = false
                        if j.occupying then
                            v5 = (j.reserve()) + v2
                            v7 = math.max(v7, v5)
                        end
                    end
                end
                v10 = math.max(v10, v7)
            end
        end)
    end
    return {
        SetOccupying = function(p1, p2) -- Line: 103 -- upvalues: u2 (upval), u67 (val), u52 (val), u37 (upval)
            if u2[u67] then
                local occupying = u52.occupying
                local v1 = p2 == true
                if occupying ~= v1 then
                    local v2 = u52
                    v1 = p2 == true
                    v2.occupying = v1
                    if u37 then
                        return
                    end
                    u37 = true
                    task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
                        local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
                        u37 = false
                        local v8 = {}
                        for k, v in pairs(u2) do
                            if not v8[v.layer] then
                                v8[v.layer] = true
                            end
                        end
                        local v9 = {}
                        for k2 in pairs(v8) do
                            table.insert(v9, k2)
                        end
                        table.sort(v9)
                        local v10 = 0
                        for i, i2 in ipairs(v9) do
                            v7 = 0
                            for k3, j in pairs(u2) do
                                if j.layer == i2 then
                                    v3 = j.bottom()
                                    v1 = math.max(0, v3)
                                    CurrentCamera = workspace.CurrentCamera
                                    if not CurrentCamera then
                                        Y = 0
                                    else
                                        Y = CurrentCamera.ViewportSize.Y
                                    end
                                    v6 = Y * 0.012
                                    v5 = v10 + (math.max(8, v6))
                                    v4 = v5 - v1
                                    v2 = math.max(0, v4)
                                    j.apply(v2, not j.needsInitialApply)
                                    j.needsInitialApply = false
                                    if j.occupying then
                                        v5 = (j.reserve()) + v2
                                        v7 = math.max(v7, v5)
                                    end
                                end
                            end
                            v10 = math.max(v10, v7)
                        end
                    end)
                end
            end
        end,
        Invalidate = function(p1) -- Line: 110 -- upvalues: u2 (upval), u67 (val), u37 (upval)
            if u2[u67] then
                if u37 then
                    return
                end
                u37 = true
                task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
                    local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
                    u37 = false
                    local v8 = {}
                    for k, v in pairs(u2) do
                        if not v8[v.layer] then
                            v8[v.layer] = true
                        end
                    end
                    local v9 = {}
                    for k2 in pairs(v8) do
                        table.insert(v9, k2)
                    end
                    table.sort(v9)
                    local v10 = 0
                    for i, i2 in ipairs(v9) do
                        v7 = 0
                        for k3, j in pairs(u2) do
                            if j.layer == i2 then
                                v3 = j.bottom()
                                v1 = math.max(0, v3)
                                CurrentCamera = workspace.CurrentCamera
                                if not CurrentCamera then
                                    Y = 0
                                else
                                    Y = CurrentCamera.ViewportSize.Y
                                end
                                v6 = Y * 0.012
                                v5 = v10 + (math.max(8, v6))
                                v4 = v5 - v1
                                v2 = math.max(0, v4)
                                j.apply(v2, not j.needsInitialApply)
                                j.needsInitialApply = false
                                if j.occupying then
                                    v5 = (j.reserve()) + v2
                                    v7 = math.max(v7, v5)
                                end
                            end
                        end
                        v10 = math.max(v10, v7)
                    end
                end)
            end
        end,
        Destroy = function(p1) -- Line: 116 -- upvalues: u2 (upval), u67 (val), u37 (upval)
            if u2[u67] then
                u2[u67] = nil
                if u37 then
                    return
                end
                u37 = true
                task.defer(function() -- Line: 31 -- upvalues: u37 (upval), u2 (upval)
                    local CurrentCamera, Y, v1, v2, v3, v4, v5, v6, v7
                    u37 = false
                    local v8 = {}
                    for k, v in pairs(u2) do
                        if not v8[v.layer] then
                            v8[v.layer] = true
                        end
                    end
                    local v9 = {}
                    for k2 in pairs(v8) do
                        table.insert(v9, k2)
                    end
                    table.sort(v9)
                    local v10 = 0
                    for i, i2 in ipairs(v9) do
                        v7 = 0
                        for k3, j in pairs(u2) do
                            if j.layer == i2 then
                                v3 = j.bottom()
                                v1 = math.max(0, v3)
                                CurrentCamera = workspace.CurrentCamera
                                if not CurrentCamera then
                                    Y = 0
                                else
                                    Y = CurrentCamera.ViewportSize.Y
                                end
                                v6 = Y * 0.012
                                v5 = v10 + (math.max(8, v6))
                                v4 = v5 - v1
                                v2 = math.max(0, v4)
                                j.apply(v2, not j.needsInitialApply)
                                j.needsInitialApply = false
                                if j.occupying then
                                    v5 = (j.reserve()) + v2
                                    v7 = math.max(v7, v5)
                                end
                            end
                        end
                        v10 = math.max(v10, v7)
                    end
                end)
            end
        end,
    }
end

return v1