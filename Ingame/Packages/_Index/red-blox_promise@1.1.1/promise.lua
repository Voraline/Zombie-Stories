local Spawn = require(script.Parent.Spawn)
local u5 = {}
u5.__index = u5

function u5.new(p1) -- Line: 6 -- upvalues: u5 (val)
    local v1 = u5
    local u4 = setmetatable({}, v1)
    u4.Status = "Pending"
    u4.OnResolve = {}
    u4.OnReject = {}
    u4.Value = {}
    u4.Thread = coroutine.create(xpcall)
    task.spawn(u4.Thread, p1, function(p1) -- Line: 17 -- upvalues: u4 (val)
        u4:_Reject(p1)
    end, function(...) -- Line: 19 -- upvalues: u4 (val)
        u4:_Resolve(...)
    end, function(...) -- Line: 21 -- upvalues: u4 (val)
        u4:_Reject(...)
    end)
    return u4
end

function u5.Resolve(...) -- Line: 30 -- upvalues: u5 (val)
    local v1 = u5
    local v2 = setmetatable({}, v1)
    v2.Status = "Resolved"
    v2.OnResolve = {}
    v2.OnReject = {}
    v2.Value = {...}
    v2.Thread = nil
    return v2
end

function u5.Reject(...) -- Line: 42 -- upvalues: u5 (val)
    local v1 = u5
    local v2 = setmetatable({}, v1)
    v2.Status = "Rejected"
    v2.OnResolve = {}
    v2.OnReject = {}
    v2.Value = {...}
    v2.Thread = nil
    return v2
end

function u5.All(p1) -- Line: 54 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Resolve({})
    end
    local v1 = u5
    return v1.new(function(p1_2, p2) -- Line: 59 -- upvalues: p1 (val)
        local OnReject, OnResolve
        local u2 = false
        local u17 = 0
        local u4 = {}
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Status ~= "Resolved" then
                if j.Status == "Rejected" then
                    p2(j.Value[1])
                    break
                end
                OnResolve = j.OnResolve
                table.insert(OnResolve, function(p1_3) -- Line: 74 -- upvalues: u2 (ref), u17 (ref), u4 (val), i (val), p1 (upval), p1_2 (val)
                    if u2 then
                        return
                    end
                    u17 = u17 + 1
                    u4[i] = p1_3
                    if u17 == #p1 then
                        p1_2(u4)
                        u2 = true
                    end
                end)
                OnReject = j.OnReject
                table.insert(OnReject, function(p1) -- Line: 88 -- upvalues: u2 (ref), p2 (val)
                    if u2 then
                        return
                    end
                    p2(p1)
                    u2 = true
                end)
            else
                u17 = u17 + 1
                u4[i] = j.Value[1]
            end
        end
        if u17 == #p1 then
            p1_2(u4)
        end
    end)
end

function u5.AllSettled(p1) -- Line: 106 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Resolve({})
    end
    local v1 = u5
    return v1.new(function(p1_2, p2) -- Line: 111 -- upvalues: p1 (val)
        local OnReject, OnResolve
        local u2 = false
        local u28 = 0
        local u4 = {}
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Status == "Resolved" then
                u28 = u28 + 1
                u4[i] = "Resolved"
            elseif j.Status ~= "Rejected" then
                OnResolve = j.OnResolve
                table.insert(OnResolve, function(p1_3) -- Line: 125 -- upvalues: u2 (ref), u28 (ref), u4 (val), i (val), p1 (upval), p1_2 (val)
                    if u2 then
                        return
                    end
                    u28 = u28 + 1
                    u4[i] = "Resolved"
                    if u28 == #p1 then
                        p1_2(u4)
                        u2 = true
                    end
                end)
                OnReject = j.OnReject
                table.insert(OnReject, function(p1_3) -- Line: 139 -- upvalues: u2 (ref), u28 (ref), u4 (val), i (val), p1 (upval), p1_2 (val)
                    if u2 then
                        return
                    end
                    u28 = u28 + 1
                    u4[i] = "Rejected"
                    if u28 == #p1 then
                        p1_2(u4)
                        u2 = true
                    end
                end)
            else
                u28 = u28 + 1
                u4[i] = "Rejected"
            end
        end
        if u28 == #p1 then
            p1_2(u4)
        end
    end)
end

function u5.Any(p1) -- Line: 162 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Reject({})
    end
    local v1 = u5
    return v1.new(function(p1_2, p2) -- Line: 167 -- upvalues: p1 (val)
        local OnReject, OnResolve
        local u2 = false
        local u35 = 0
        local u4 = {}
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Status == "Resolved" then
                p1_2(j.Value[1])
                break
            end
            if j.Status ~= "Rejected" then
                OnResolve = j.OnResolve
                table.insert(OnResolve, function(p1) -- Line: 182 -- upvalues: u2 (ref), p1_2 (val)
                    if u2 then
                        return
                    end
                    p1_2(p1)
                    u2 = true
                end)
                OnReject = j.OnReject
                table.insert(OnReject, function(p1_2) -- Line: 191 -- upvalues: u2 (ref), u35 (ref), u4 (val), i (val), p1 (upval), p2 (val)
                    if u2 then
                        return
                    end
                    u35 = u35 + 1
                    u4[i] = p1_2
                    if u35 == #p1 then
                        p2(u4)
                        u2 = true
                    end
                end)
            else
                u35 = u35 + 1
                u4[i] = j.Value[1]
            end
        end
        if u35 == #p1 then
            p2(u4)
        end
    end)
end

function u5.Race(p1) -- Line: 214 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Reject("No promises to resolve.")
    end
    local v1 = u5
    return v1.new(function(p1_2, p2) -- Line: 219 -- upvalues: p1 (val)
        local OnReject, OnResolve, Value, Value_2
        local u2 = false
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Status == "Resolved" then
                Value = j.Value
                p1_2(unpack(Value))
                break
            end
            if j.Status == "Rejected" then
                Value_2 = j.Value
                p2(unpack(Value_2))
                break
            end
            OnResolve = j.OnResolve
            table.insert(OnResolve, function(p1) -- Line: 232 -- upvalues: u2 (ref), p1_2 (val)
                if u2 then
                    return
                end
                p1_2(p1)
                u2 = true
            end)
            OnReject = j.OnReject
            table.insert(OnReject, function(p1) -- Line: 241 -- upvalues: u2 (ref), p2 (val)
                if u2 then
                    return
                end
                p2(p1)
                u2 = true
            end)
        end
    end)
end

function u5.Retry(p1, p2, ...) -- Line: 254 -- upvalues: u5 (val)
    local u2 = {}
    u2[1] = ...
    local v1 = u5
    return v1.new(function(p1_2, p2_2) -- Line: 257 -- upvalues: p1 (val), p2 (val), u2 (val)
        local v1, v2, v3, v4
        local v5 = 0
        while v5 < p1 do
            v5 = v5 + 1
            v1 = {}
            v2 = pcall
            v3 = p2
            v4 = u2
            v1[1] = v2(v3, unpack(v4))
            if table.remove(v1, 1) then
                p1_2(unpack(v1))
                return
            end
            if v5 == p1 then
                p2_2(unpack(v1))
                return
            end
        end
    end)
end

function u5.RetryWithDelay(p1, p2, p3, ...) -- Line: 276 -- upvalues: u5 (val)
    local u3 = {}
    u3[1] = ...
    local v1 = u5
    return v1.new(function(p1_2, p2_2) -- Line: 279 -- upvalues: p1 (val), p3 (val), u3 (val), p2 (val)
        local v1, v2, v3, v4
        local v5 = 0
        while v5 < p1 do
            v5 = v5 + 1
            v1 = {}
            v2 = pcall
            v3 = p3
            v4 = u3
            v1[1] = v2(v3, unpack(v4))
            if table.remove(v1, 1) then
                p1_2(unpack(v1))
                return
            end
            if v5 == p1 then
                p2_2(unpack(v1))
                return
            end
            task.wait(p2)
        end
    end)
end

function u5:_Resolve(...) -- Line: 300 -- upvalues: Spawn (val)
    local v1 = self.Status == "Pending"
    assert(v1, "Cannot resolve a promise that is not pending.")
    self.Status = "Resolved"
    self.Value = table.pack(...)
    local OnResolve = self.OnResolve
    v1 = nil
    local v2 = nil
    for i, j in OnResolve, v1, v2 do
        Spawn(j, ...)
    end
    task.defer(task.cancel, self.Thread)
end

function u5:_Reject(...) -- Line: 313 -- upvalues: Spawn (val)
    local v1 = self.Status == "Pending"
    assert(v1, "Cannot reject a promise that is not pending.")
    self.Status = "Rejected"
    self.Value = table.pack(...)
    local OnReject = self.OnReject
    v1 = nil
    local v2 = nil
    for i, j in OnReject, v1, v2 do
        Spawn(j, ...)
    end
    task.defer(task.cancel, self.Thread)
end

function u5.Then(p1, p2, p3) -- Line: 326 -- upvalues: u5 (val)
    local v1 = u5
    return v1.new(function(p1_2, p2_2) -- Line: 327 -- upvalues: u5 (upval), p1 (val), p2 (val), p3 (val)
        local v1, v2, v3

        local function PromiseResolutionProcedure(p1, ...) -- Line: 328 -- upvalues: u5 (upval), p1_2 (val), p2_2 (val)
            if type(p1) == "table" then
                local v1 = getmetatable(p1)
                if v1 == u5 then
                    if p1.Status == "Pending" then
                        local OnResolve = p1.OnResolve
                        local v2 = p1_2
                        table.insert(OnResolve, v2)
                        local OnReject = p1.OnReject
                        v2 = p2_2
                        table.insert(OnReject, v2)
                        return
                    end
                    if p1.Status == "Resolved" then
                        v1 = p1_2
                        local Value = p1.Value
                        v1(unpack(Value))
                        return
                    end
                    if p1.Status ~= "Rejected" then
                        return
                    end
                    v1 = p2_2
                    local Value_2 = p1.Value
                    v1(unpack(Value_2))
                    return
                end
            end
            p1_2(p1, ...)
        end

        if p1.Status == "Pending" then
            if not p2 then
                v1 = p1
                local OnResolve_2 = v1.OnResolve
                table.insert(OnResolve_2, PromiseResolutionProcedure)
            else
                v1 = p1
                local OnResolve = v1.OnResolve
                table.insert(OnResolve, function(...) -- Line: 345 -- upvalues: PromiseResolutionProcedure (val), p2 (upval)
                    PromiseResolutionProcedure(p2(...))
                end)
            end
            if p3 then
                v1 = p1
                local OnReject = v1.OnReject
                table.insert(OnReject, function(...) -- Line: 353 -- upvalues: PromiseResolutionProcedure (val), p3 (upval)
                    PromiseResolutionProcedure(p3(...))
                end)
                return
            end
            v1 = p1
            local OnReject_2 = v1.OnReject
            table.insert(OnReject_2, p2_2)
            return
        end
        if p1.Status == "Resolved" then
            if not p2 then
                v2 = p1
                local Value_2 = v2.Value
                p1_2(unpack(Value_2))
                return
            end
            v1 = p2
            v3 = p1
            local Value = v3.Value
            PromiseResolutionProcedure(v1(unpack(Value)))
            return
        end
        if p1.Status == "Rejected" then
            if p3 then
                v1 = p3
                v3 = p1
                local Value_3 = v3.Value
                PromiseResolutionProcedure(v1(unpack(Value_3)))
                return
            end
            v2 = p1
            local Value_4 = v2.Value
            p2_2(unpack(Value_4))
        end
    end)
end

function u5.Catch(p1, p2) -- Line: 375
    return p1:Then(nil, p2)
end

function u5.Finally(p1, p2) -- Line: 379
    return p1:Then(function(...) -- Line: 381 -- upvalues: p2 (val), p1 (val)
        p2(p1.Status)
        return p1
    end, function(p1_2) -- Line: 385 -- upvalues: p2 (val), p1 (val)
        p2(p1.Status)
        return p1
    end)
end

function u5.Await(p1) -- Line: 392
    if p1.Status == "Resolved" then
        local Value = p1.Value
        return unpack(Value)
    end
    if p1.Status == "Rejected" then
        local v1 = error
        local Value_2 = p1.Value
        return v1(unpack(Value_2))
    end
    local u12 = coroutine.running()

    local function Resume() -- Line: 400 -- upvalues: u12 (val)
        task.spawn(u12)
    end

    local OnResolve = p1.OnResolve
    table.insert(OnResolve, Resume)
    local OnReject = p1.OnReject
    table.insert(OnReject, Resume)
    coroutine.yield()
    if p1.Status == "Resolved" then
        local Value_3 = p1.Value
        return unpack(Value_3)
    end
    local v2 = error
    local Value_4 = p1.Value
    return v2(unpack(Value_4))
end

function u5.StatusAwait(p1) -- Line: 417
    if p1.Status == "Resolved" then
        local Status = p1.Status
        local Value = p1.Value
        return Status, unpack(Value)
    end
    if p1.Status == "Rejected" then
        local Status_2 = p1.Status
        local Value_2 = p1.Value
        return Status_2, unpack(Value_2)
    end
    local u12 = coroutine.running()

    local function Resume() -- Line: 425 -- upvalues: u12 (val)
        coroutine.resume(u12)
    end

    local OnResolve = p1.OnResolve
    table.insert(OnResolve, Resume)
    local OnReject = p1.OnReject
    table.insert(OnReject, Resume)
    coroutine.yield()
    local Status_3 = p1.Status
    local Value_3 = p1.Value
    return Status_3, unpack(Value_3)
end

return u5