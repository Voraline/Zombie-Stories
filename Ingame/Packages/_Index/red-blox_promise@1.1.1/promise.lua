local Spawn = require(script.Parent.Spawn)
local u5 = {}
u5.__index = u5
function u5.new(p1) -- Line: 6 -- upvalues: u5 (val)
    local u4 = setmetatable({}, u5)
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
    local v1 = setmetatable({}, u5)
    v1.Status = "Resolved"
    v1.OnResolve = {}
    v1.OnReject = {}
    v1.Value = {...}
    v1.Thread = nil
    return v1
end
function u5.Reject(...) -- Line: 42 -- upvalues: u5 (val)
    local v1 = setmetatable({}, u5)
    v1.Status = "Rejected"
    v1.OnResolve = {}
    v1.OnReject = {}
    v1.Value = {...}
    v1.Thread = nil
    return v1
end
function u5.All(p1) -- Line: 54 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Resolve({})
    end
    return u5.new(function(a1, p2) -- Line: 59 -- upvalues: p1 (val)
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
                table.insert(j.OnResolve, function(a1_2) -- Line: 74 -- upvalues: u2 (ref), u17 (ref), u4 (val), i (val), p1 (upval), a1 (val)
                    if u2 then
                        return
                    end
                    u17 = u17 + 1
                    u4[i] = a1_2
                    if u17 == #p1 then
                        a1(u4)
                        u2 = true
                    end
                end)
                table.insert(j.OnReject, function(p1) -- Line: 88 -- upvalues: u2 (ref), p2 (val)
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
            a1(u4)
        end
    end)
end
function u5.AllSettled(p1) -- Line: 106 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Resolve({})
    end
    return u5.new(function(a1, p2) -- Line: 111 -- upvalues: p1 (val)
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
                table.insert(j.OnResolve, function(a1_2) -- Line: 125 -- upvalues: u2 (ref), u28 (ref), u4 (val), i (val), p1 (upval), a1 (val)
                    if u2 then
                        return
                    end
                    u28 = u28 + 1
                    u4[i] = "Resolved"
                    if u28 == #p1 then
                        a1(u4)
                        u2 = true
                    end
                end)
                table.insert(j.OnReject, function(a1_2) -- Line: 139 -- upvalues: u2 (ref), u28 (ref), u4 (val), i (val), p1 (upval), a1 (val)
                    if u2 then
                        return
                    end
                    u28 = u28 + 1
                    u4[i] = "Rejected"
                    if u28 == #p1 then
                        a1(u4)
                        u2 = true
                    end
                end)
            else
                u28 = u28 + 1
                u4[i] = "Rejected"
            end
        end
        if u28 == #p1 then
            a1(u4)
        end
    end)
end
function u5.Any(p1) -- Line: 162 -- upvalues: u5 (val)
    if #p1 == 0 then
        return u5.Reject({})
    end
    return u5.new(function(a1, p2) -- Line: 167 -- upvalues: p1 (val)
        local u2 = false
        local u35 = 0
        local u4 = {}
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Status == "Resolved" then
                a1(j.Value[1])
                break
            end
            if j.Status ~= "Rejected" then
                table.insert(j.OnResolve, function(p1) -- Line: 182 -- upvalues: u2 (ref), a1 (val)
                    if u2 then
                        return
                    end
                    a1(p1)
                    u2 = true
                end)
                table.insert(j.OnReject, function(a1) -- Line: 191 -- upvalues: u2 (ref), u35 (ref), u4 (val), i (val), p1 (upval), p2 (val)
                    if u2 then
                        return
                    end
                    u35 = u35 + 1
                    u4[i] = a1
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
    return u5.new(function(a1, p2) -- Line: 219 -- upvalues: p1 (val)
        local u2 = false
        local v1 = p1
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Status == "Resolved" then
                a1(unpack(j.Value))
                break
            end
            if j.Status == "Rejected" then
                p2(unpack(j.Value))
                break
            end
            table.insert(j.OnResolve, function(p1) -- Line: 232 -- upvalues: u2 (ref), a1 (val)
                if u2 then
                    return
                end
                a1(p1)
                u2 = true
            end)
            table.insert(j.OnReject, function(p1) -- Line: 241 -- upvalues: u2 (ref), p2 (val)
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
    local u2 = {...}
    return u5.new(function(a1, a2) -- Line: 257 -- upvalues: p1 (val), p2 (val), u2 (val)
        local v1
        local v2 = 0
        while v2 < p1 do
            v2 = v2 + 1
            v1 = {pcall(p2, unpack(u2))}
            if table.remove(v1, 1) then
                a1(unpack(v1))
                return
            end
            if v2 == p1 then
                a2(unpack(v1))
                return
            end
        end
    end)
end
function u5.RetryWithDelay(p1, p2, p3, ...) -- Line: 276 -- upvalues: u5 (val)
    local u3 = {...}
    return u5.new(function(a1, a2) -- Line: 279 -- upvalues: p1 (val), p3 (val), u3 (val), p2 (val)
        local v1
        local v2 = 0
        while v2 < p1 do
            v2 = v2 + 1
            v1 = {pcall(p3, unpack(u3))}
            if table.remove(v1, 1) then
                a1(unpack(v1))
                return
            end
            if v2 == p1 then
                a2(unpack(v1))
                return
            end
            task.wait(p2)
        end
    end)
end
function u5:_Resolve(, ...) -- Line: 300 -- upvalues: Spawn (val)
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
function u5:_Reject(, ...) -- Line: 313 -- upvalues: Spawn (val)
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
    return u5.new(function(a1, a2) -- Line: 327 -- upvalues: u5 (upval), p1 (val), p2 (val), p3 (val)
        local function PromiseResolutionProcedure(p1, ...) -- Line: 328 -- upvalues: u5 (upval), a1 (val), a2 (val)
            if type(p1) ~= "table" then
                a1(p1, ...)
                return
            end
            local v1 = getmetatable(p1)
            if v1 ~= u5 then
                a1(p1, ...)
                return
            end
            if p1.Status == "Pending" then
                table.insert(p1.OnResolve, a1)
                table.insert(p1.OnReject, a2)
                return
            end
            if p1.Status == "Resolved" then
                a1(unpack(p1.Value))
                return
            end
            if p1.Status ~= "Rejected" then
                return
            end
            a2(unpack(p1.Value))
        end
        if p1.Status == "Pending" then
            if not p2 then
                table.insert(p1.OnResolve, PromiseResolutionProcedure)
            else
                table.insert(p1.OnResolve, function(...) -- Line: 345 -- upvalues: PromiseResolutionProcedure (val), p2 (upval)
                    PromiseResolutionProcedure(p2(...))
                end)
            end
            if p3 then
                table.insert(p1.OnReject, function(...) -- Line: 353 -- upvalues: PromiseResolutionProcedure (val), p3 (upval)
                    PromiseResolutionProcedure(p3(...))
                end)
                return
            end
            table.insert(p1.OnReject, a2)
            return
        end
        if p1.Status == "Resolved" then
            if p2 then
                PromiseResolutionProcedure(p2(unpack(p1.Value)))
                return
            end
            a1(unpack(p1.Value))
            return
        end
        if p1.Status ~= "Rejected" then
            return
        end
        if p3 then
            PromiseResolutionProcedure(p3(unpack(p1.Value)))
            return
        end
        a2(unpack(p1.Value))
    end)
end
function u5.Catch(p1, p2) -- Line: 375
    return p1:Then(nil, p2)
end
function u5.Finally(p1, p2) -- Line: 379
    return p1:Then(function(...) -- Line: 381 -- upvalues: p2 (val), p1 (val)
        p2(p1.Status)
        return p1
    end, function(a1) -- Line: 385 -- upvalues: p2 (val), p1 (val)
        p2(p1.Status)
        return p1
    end)
end
function u5.Await(p1) -- Line: 392
    if p1.Status == "Resolved" then
        return unpack(p1.Value)
    end
    if p1.Status == "Rejected" then
        return error(unpack(p1.Value))
    end
    local u12 = coroutine.running()
    local function Resume() -- Line: 400 -- upvalues: u12 (val)
        task.spawn(u12)
    end
    table.insert(p1.OnResolve, Resume)
    table.insert(p1.OnReject, Resume)
    coroutine.yield()
    if p1.Status == "Resolved" then
        return unpack(p1.Value)
    end
    return error(unpack(p1.Value))
end
function u5.StatusAwait(p1) -- Line: 417
    if p1.Status == "Resolved" or p1.Status == "Rejected" then
        return p1.Status, unpack(p1.Value)
    end
    local u12 = coroutine.running()
    local function Resume() -- Line: 425 -- upvalues: u12 (val)
        coroutine.resume(u12)
    end
    table.insert(p1.OnResolve, Resume)
    table.insert(p1.OnReject, Resume)
    coroutine.yield()
    return p1.Status, unpack(p1.Value)
end
return u5