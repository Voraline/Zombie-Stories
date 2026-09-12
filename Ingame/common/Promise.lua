local u0 = {__mode = "k"}

local function isCallable(p1) -- Line: 10
    if type(p1) == "function" then
        return true
    end
    if type(p1) == "table" then
        local v1 = getmetatable(p1)
        if v1 then
            local v2 = rawget(v1, "__call")
            if type(v2) == "function" then
                return true
            end
        end
    end
    return false
end

local function makeEnum(p1, p2) -- Line: 28
    local v1 = {}
    for i, v in ipairs(p2) do
        v1[v] = v
    end
    local v2 = {
        __index = function(p1_2, p2) -- Line: 36 -- upvalues: p1 (val)
            error(string.format("%s is not in %s!", p2, p1), 2)
        end,
        __newindex = function() -- Line: 39 -- upvalues: p1 (val)
            error(string.format("Creating new members in %s is not allowed!", p1), 2)
        end,
    }
    return (setmetatable(v1, v2))
end

local u13 = {
    Kind = makeEnum("Promise.Error.Kind", {"ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut"}),
}
u13.__index = u13

function u13.new(p1, p2) -- Line: 64 -- upvalues: u13 (ref)
    local v1 = p1 or {}
    local v2 = v1
    local v3 = {}
    local error = v2.error
    v3.error = tostring(error) or "[This error has no error text.]"
    v3.trace = v2.trace
    v3.context = v2.context
    v3.kind = v2.kind
    v3.parent = p2
    v3.createdTick = os.clock()
    v3.createdTrace = debug.traceback()
    local v4 = u13
    return (setmetatable(v3, v4))
end

function u13.is(p1) -- Line: 77
    if type(p1) == "table" then
        local v1 = getmetatable(p1)
        if type(v1) == "table" then
            local v2 = false
            if rawget(p1, "error") ~= nil then
                local v3 = rawget(v1, "extend")
                v2 = type(v3) == "function"
            end
            return v2
        end
    end
    return false
end

function u13.isKind(p1, p2) -- Line: 89 -- upvalues: u13 (ref)
    local v1 = p2 ~= nil
    assert(v1, "Argument #2 to Promise.Error.isKind must not be nil")
    local v2 = u13.is(p1)
    if v2 then
        v2 = p1.kind == p2
    end
    return v2
end

function u13:extend(p2) -- Line: 95 -- upvalues: u13 (ref)
    local v1 = p2 or {}
    local v2 = v1
    local kind = v2.kind
    if not kind then
        kind = self.kind
    end
    v2.kind = kind
    return u13.new(v2, self)
end

function u13.getErrorChain(p1) -- Line: 103
    local parent
    local v1 = {p1}
    while v1[#v1].parent do
        parent = v1[#v1].parent
        table.insert(v1, parent)
    end
    return v1
end

function u13.__tostring(p1) -- Line: 113
    local concat, trace, v1, v2
    local v3 = {}
    v3[1] = string.format("-- Promise.Error(%s) --", p1.kind or "?")
    for i, v in ipairs(p1:getErrorChain()) do
        concat = table.concat
        v1 = {}
        trace = v.trace
        if not trace then
            trace = v.error
        end
        v1[1] = trace
        v1[2] = v.context
        v2 = concat(v1, "\n")
        table.insert(v3, v2)
    end
    return table.concat(v3, "\n")
end

local function pack(...) -- Line: 137
    return (select("#", ...)), {...}
end

local function packResult(p1, ...) -- Line: 144
    local v1 = select("#", ...)
    local v2 = {...}
    return p1, v1, v2
end

local function makeErrorHandler(p1) -- Line: 148 -- upvalues: u13 (ref)
    local v1 = p1 ~= nil
    assert(v1, "traceback is nil")
    return function(p1_2) -- Line: 151 -- upvalues: u13 (upval), p1 (val)
        if type(p1_2) == "table" then
            return p1_2
        end
        local v1 = u13
        return v1.new({
            error = p1_2,
            kind = u13.Kind.ExecutionError,
            trace = debug.traceback(tostring(p1_2), 2),
            context = "Promise created at:\n\n" .. p1,
        })
    end
end

local function runExecutor(p1, p2, ...) -- Line: 171 -- upvalues: packResult (val), u13 (ref)
    local v1 = packResult
    local v2 = xpcall
    local v3 = p1 ~= nil
    assert(v3, "traceback is nil")
    return v1(v2(p2, function(p1_2) -- Line: 151 -- upvalues: u13 (upval), p1 (val)
        if type(p1_2) == "table" then
            return p1_2
        end
        local v1 = u13
        return v1.new({
            error = p1_2,
            kind = u13.Kind.ExecutionError,
            trace = debug.traceback(tostring(p1_2), 2),
            context = "Promise created at:\n\n" .. p1,
        })
    end, ...))
end

local function createAdvancer(p1, p2, p3, p4) -- Line: 179 -- upvalues: runExecutor (val)
    return function(...) -- Line: 180 -- upvalues: runExecutor (upval), p1 (val), p2 (val), p3 (val), p4 (val)
        local v1, v2, v3 = runExecutor(p1, p2, ...)
        if v1 then
            p3(unpack(v3, 1, v2))
            return
        end
        p4(v3[1])
    end
end

local function isEmpty(p1) -- Line: 191
    local v1 = next(p1) == nil
    return v1
end

local u26 = {}
u26.Error = u13
u26.Status = makeEnum("Promise.Status", {"Started", "Resolved", "Rejected", "Cancelled"})
u26._getTime = os.clock
u26._timeEvent = game:GetService("RunService").Heartbeat
u26._unhandledRejectionCallbacks = {}
u26.prototype = {}
u26.__index = u26.prototype

function u26._new(p1, p2, p3) -- Line: 230 -- upvalues: u26 (val), u0 (val), runExecutor (val)
    if p3 ~= nil and not u26.is(p3) then
        error("Argument #2 to Promise.new must be a promise or nil", 2)
    end
    local u11 = {_valuesLength = -1, _unhandledRejection = true}
    u11._source = p1
    u11._status = u26.Status.Started
    u11._queuedResolve = {}
    u11._queuedReject = {}
    u11._queuedFinally = {}
    u11._parent = p3
    local v1 = u0
    u11._consumers = setmetatable({}, v1)
    if p3 and p3._status == u26.Status.Started then
        p3._consumers[u11] = true
    end
    v1 = u26
    setmetatable(u11, v1)

    local function resolve(...) -- Line: 278 -- upvalues: u11 (val)
        u11:_resolve(...)
    end

    local function reject(...) -- Line: 282 -- upvalues: u11 (val)
        u11:_reject(...)
    end

    local function onCancel(p1) -- Line: 286 -- upvalues: u11 (val), u26 (upval)
        if p1 then
            if u11._status ~= u26.Status.Cancelled then
                u11._cancellationHook = p1
            else
                p1()
            end
        end
        local v1 = u11._status == u26.Status.Cancelled
        return v1
    end

    local create = coroutine.create
    u11._thread = create(function() -- Line: 298
        -- upvalues: runExecutor (upval), u11 (val), p2 (val), resolve (val), reject (val), onCancel (val)
        local v1, v2
        v1, _, v2 = runExecutor(u11._source, p2, resolve, reject, onCancel)
        if not v1 then
            reject(v2[1])
        end
    end)
    task.spawn(u11._thread)
    return u11
end

function u26.new(p1) -- Line: 349 -- upvalues: u26 (val)
    local v1 = u26
    return v1._new(debug.traceback(nil, 2), p1)
end

function u26.__tostring(p1) -- Line: 353
    return string.format("Promise(%s)", p1._status)
end

function u26.defer(p1) -- Line: 375 -- upvalues: u26 (val), runExecutor (val)
    local u4 = debug.traceback(nil, 2)
    local v1 = u26
    return (v1._new(u4, function(p1_2, p2, p3) -- Line: 378 -- upvalues: u26 (upval), runExecutor (upval), u4 (val), p1 (val)
        local u3 = nil
        local v1 = u26
        v1 = v1._timeEvent:Connect(function() -- Line: 380
            -- upvalues: u3 (ref), runExecutor (upval), u4 (upval), p1 (upval), p1_2 (val), p2 (val), p3 (val)
            local v1, v2
            u3:Disconnect()
            v1, _, v2 = runExecutor(u4, p1, p1_2, p2, p3)
            if not v1 then
                p2(v2[1])
            end
        end)
    end))
end

u26.async = u26.defer

function u26.resolve(...) -- Line: 418 -- upvalues: pack (val), u26 (val)
    local u2, u3 = pack(...)
    local v1 = u26
    return v1._new(debug.traceback(nil, 2), function(p1) -- Line: 420 -- upvalues: u3 (val), u2 (val)
        local v1 = u3
        local v2 = u2
        p1(unpack(v1, 1, v2))
    end)
end

function u26.reject(...) -- Line: 435 -- upvalues: pack (val), u26 (val)
    local u2, u3 = pack(...)
    local v1 = u26
    return v1._new(debug.traceback(nil, 2), function(p1, p2) -- Line: 437 -- upvalues: u3 (val), u2 (val)
        local v1 = u3
        local v2 = u2
        p2(unpack(v1, 1, v2))
    end)
end

function u26._try(p1, p2, ...) -- Line: 446 -- upvalues: pack (val), u26 (val)
    local u4, u5 = pack(...)
    local v1 = u26
    return v1._new(p1, function(p1) -- Line: 449 -- upvalues: p2 (val), u5 (val), u4 (val)
        local v1 = p2
        local v2 = u5
        local v3 = u4
        p1(v1(unpack(v2, 1, v3)))
    end)
end

function u26.try(p1, ...) -- Line: 477 -- upvalues: u26 (val)
    local v1 = u26
    return v1._try(debug.traceback(nil, 2), p1, ...)
end

function u26._all(p1, p2, p3) -- Line: 486 -- upvalues: u26 (val)
    if type(p2) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
    end
    for k, v in pairs(p2) do
        if not u26.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(k))), 3)
        end
    end
    if #p2 ~= 0 and p3 ~= 0 then
        local v1 = u26
        return v1._new(p1, function(p1, p2_2, p3_2) -- Line: 504 -- upvalues: p3 (val), p2 (val)
            local u3 = {}
            local u4 = {}
            local u5 = 0
            local u6 = 0
            local u7 = false

            local function resolveOne(p1_2, ...) -- Line: 522
                -- upvalues: u7 (ref), u5 (ref), p3 (upval), u3 (val), p2 (upval), p1 (val), u4 (val)
                if u7 then
                    return
                end
                u5 = u5 + 1
                if p3 ~= nil then
                    u3[u5] = (...)
                else
                    u3[p1_2] = (...)
                end
                local v1 = u5
                local v2 = p3
                if not v2 then
                    v2 = #p2
                end
                if v2 <= v1 then
                    u7 = true
                    p1(u3)
                    for i, v in ipairs(u4) do
                        v:cancel()
                    end
                end
            end

            p3_2(function() -- Line: 515 -- upvalues: u4 (val)
                for i, v in ipairs(u4) do
                    v:cancel()
                end
            end)
            for i, v in ipairs(p2) do
                u4[i] = (v:andThen(function(...) -- Line: 547 -- upvalues: resolveOne (val), i (val)
                    resolveOne(i, ...)
                end, function(...) -- Line: 549 -- upvalues: u6 (ref), p3 (upval), p2 (upval), u4 (val), u7 (ref), p2_2 (val)
                    u6 = u6 + 1
                    if p3 == nil then
                        for i, v in ipairs(u4) do
                            v:cancel()
                        end
                        u7 = true
                        p2_2(...)
                    elseif #p2 - u6 < p3 then
                        for i2, i3 in ipairs(u4) do
                            i3:cancel()
                        end
                        u7 = true
                        p2_2(...)
                    end
                end))
            end
            if u7 then
                for i2, i3 in ipairs(u4) do
                    i3:cancel()
                end
            end
        end)
    end
    return u26.resolve({})
end

function u26.all(p1) -- Line: 591 -- upvalues: u26 (val)
    local v1 = u26
    return v1._all(debug.traceback(nil, 2), p1)
end

function u26.fold(p1, p2, p3) -- Line: 620 -- upvalues: u26 (val)
    local v1 = type(p1) == "table"
    assert(v1, "Bad argument #1 to Promise.fold: must be a table")
    if type(p2) == "function" then
        v1 = true
    elseif type(p2) ~= "table" then
        v1 = false
    else
        local v2 = getmetatable(p2)
        if not v2 then
            v1 = false
        else
            local v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    assert(v1, "Bad argument #2 to Promise.fold: must be a function")
    local u41 = u26.resolve(p3)
    v1 = u26
    v1 = v1.each(p1, function(p1, p2_2) -- Line: 625 -- upvalues: u41 (ref), p2 (val)
        local v1 = u41
        u41 = v1:andThen(function(p1_2) -- Line: 626 -- upvalues: p2 (upval), p1 (val), p2_2 (val)
            return p2(p1_2, p1, p2_2)
        end)
    end)
    v1 = v1:andThen(function() -- Line: 629 -- upvalues: u41 (ref)
        return u41
    end)
    return v1
end

function u26.some(p1, p2) -- Line: 653 -- upvalues: u26 (val)
    local v1 = type(p2) == "number"
    assert(v1, "Bad argument #2 to Promise.some: must be a number")
    local v2 = u26
    return v2._all(debug.traceback(nil, 2), p1, p2)
end

function u26.any(p1) -- Line: 677 -- upvalues: u26 (val)
    local v1 = u26
    return (v1._all(debug.traceback(nil, 2), p1, 1)):andThen(function(p1) -- Line: 678
        return p1[1]
    end)
end

function u26.allSettled(p1) -- Line: 699 -- upvalues: u26 (val)
    if type(p1) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
    end
    for k, v in pairs(p1) do
        if not u26.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(k))), 2)
        end
    end
    if #p1 == 0 then
        return u26.resolve({})
    end
    local v1 = u26
    return v1._new(debug.traceback(nil, 2), function(p1_2, p2, p3) -- Line: 717 -- upvalues: p1 (val)
        local u3 = {}
        local u4 = {}
        local u5 = 0

        local function resolveOne(p1_3, ...) -- Line: 727 -- upvalues: u5 (ref), u3 (val), p1 (upval), p1_2 (val)
            u5 = u5 + 1
            u3[p1_3] = (...)
            local v1 = u5
            if #p1 <= v1 then
                p1_2(u3)
            end
        end

        p3(function() -- Line: 737 -- upvalues: u4 (val)
            for i, v in ipairs(u4) do
                v:cancel()
            end
        end)
        for i, v in ipairs(p1) do
            u4[i] = (v:finally(function(...) -- Line: 746 -- upvalues: resolveOne (val), i (val)
                resolveOne(i, ...)
            end))
        end
    end)
end

function u26.race(p1) -- Line: 777 -- upvalues: u26 (val)
    local v1, v2
    local v3 = type(p1) == "table"
    local v4 = string.format("Please pass a list of promises to %s", "Promise.race")
    assert(v3, v4)
    for k, v in pairs(p1) do
        v1 = u26.is(v)
        v2 = string.format("Non-promise value passed into %s at index %s", "Promise.race", (tostring(k)))
        assert(v1, v2)
    end
    local v5 = u26
    return v5._new(debug.traceback(nil, 2), function(p1_2, p2, p3) -- Line: 784 -- upvalues: p1 (val)
        local u3 = {}
        local u4 = false

        local function cancel() -- Line: 788 -- upvalues: u3 (val)
            for i, v in ipairs(u3) do
                v:cancel()
            end
        end

        local function finalize(p1) -- Line: 794 -- upvalues: u3 (val), u4 (ref)
            return function(...) -- Line: 795 -- upvalues: u3 (upval), u4 (upval), p1 (val)
                for i, v in ipairs(u3) do
                    v:cancel()
                end
                u4 = true
                return p1(...)
            end
        end

        if p3(function(...) -- Line: 795 -- upvalues: u3 (val), u4 (ref), p2 (val)
            local v3, v4, v5, v6
            for i, v in ipairs(u3) do
                v:cancel()
            end
            u4 = true
            return p2(...)
        end) then
            return
        end
        for i, v in ipairs(p1) do
            u3[i] = (v:andThen(function(...) -- Line: 795 -- upvalues: u3 (val), u4 (ref), p1_2 (val)
                for i, v in ipairs(u3) do
                    v:cancel()
                end
                u4 = true
                return p1_2(...)
            end, function(...) -- Line: 795 -- upvalues: u3 (val), u4 (ref), p2 (val)
                for i, v in ipairs(u3) do
                    v:cancel()
                end
                u4 = true
                return p2(...)
            end))
        end
        if u4 then
            for i2, i3 in ipairs(u3) do
                i3:cancel()
            end
        end
    end)
end

function u26.each(p1, p2) -- Line: 872 -- upvalues: u26 (val), u13 (ref)
    local v1 = type(p1) == "table"
    local v2 = string.format("Please pass a list of promises to %s", "Promise.each")
    assert(v1, v2)
    if type(p2) == "function" then
        v1 = true
    elseif type(p2) ~= "table" then
        v1 = false
    else
        v2 = getmetatable(p2)
        if not v2 then
            v1 = false
        else
            local v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    v2 = string.format("Please pass a handler function to %s!", "Promise.each")
    assert(v1, v2)
    local v4 = u26
    return v4._new(debug.traceback(nil, 2), function(p1_2, p2_2, p3) -- Line: 876 -- upvalues: p1 (val), u26 (upval), u13 (upval), p2 (val)
        local v1, v2, v3, v4
        local v5 = {}
        local u85 = {}
        local u5 = false

        local function cancel() -- Line: 882 -- upvalues: u85 (val)
            for i, v in ipairs(u85) do
                v:cancel()
            end
        end

        p3(function() -- Line: 888 -- upvalues: u5 (ref), u85 (val)
            u5 = true
            for i, v in ipairs(u85) do
                v:cancel()
            end
        end)
        local v6 = {}
        for i, v in ipairs(p1) do
            if not u26.is(v) then
                v6[i] = v
            else
                v1 = v:getStatus()
                if v1 == u26.Status.Cancelled then
                    for i4, j in ipairs(u85) do
                        j:cancel()
                    end
                    v2 = u13
                    v2 = v2.new({
                        error = "Promise is cancelled",
                        kind = u13.Kind.AlreadyCancelled,
                        context = string.format(
                            "The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s",
                            i,
                            v._source
                        ),
                    })
                    v1 = p2_2(v2)
                    return v1
                end
                v1 = v:getStatus()
                if v1 == u26.Status.Rejected then
                    for i2, i3 in ipairs(u85) do
                        i3:cancel()
                    end
                    v2 = select
                    v4 = v:await()
                    v2 = v2(2, v4)
                    v1 = p2_2(v2)
                    return v1
                end
                v1 = v:andThen(function(...) -- Line: 921
                    return ...
                end)
                table.insert(u85, v1)
                v6[i] = v1
            end
        end
        for i5, k in ipairs(v6) do
            if u26.is(k) then
                v2, v3 = k:await()
                k = v3
                if not v2 then
                    for i6, n in ipairs(u85) do
                        n:cancel()
                    end
                    v2 = v7(k)
                    return v2
                end
            end
            if u5 then
                return
            end
            v1 = u26.resolve(p2(k, i5))
            table.insert(u85, v1)
            v2, v3 = v1:await()
            if not v2 then
                for i7, m in ipairs(u85) do
                    m:cancel()
                end
                v4 = v7(v3)
                return v4
            end
            v5[i5] = v3
        end
        p1_2(v5)
    end)
end

function u26.is(p1) -- Line: 971 -- upvalues: u26 (val)
    local v1, v2
    if type(p1) ~= "table" then
        return false
    end
    local v3 = getmetatable(p1)
    if v3 == u26 then
        return true
    end
    if v3 == nil then
        local andThen = p1.andThen
        if type(andThen) == "function" then
            return true
        end
        if type(andThen) == "table" then
            v1 = getmetatable(andThen)
            if v1 then
                v2 = rawget(v1, "__call")
                if type(v2) == "function" then
                    return true
                end
            end
        end
        return false
    end
    if type(v3) == "table" then
        local v4 = rawget(v3, "__index")
        if type(v4) == "table" then
            local v5
            v1 = rawget(v3, "__index")
            v4 = rawget(v1, "andThen")
            if type(v4) == "function" then
                v5 = true
            elseif type(v4) ~= "table" then
                v5 = false
            else
                v1 = getmetatable(v4)
                if not v1 then
                    v5 = false
                else
                    v2 = rawget(v1, "__call")
                    v5 = not (type(v2) ~= "function")
                end
            end
            if v5 then
                return true
            end
        end
    end
    return false
end

function u26.promisify(p1) -- Line: 1020 -- upvalues: u26 (val)
    return function(...) -- Line: 1021 -- upvalues: u26 (upval), p1 (val)
        local v1 = u26
        return v1._try(debug.traceback(nil, 2), p1, ...)
    end
end

local u64 = nil
local u65 = nil

function u26.delay(p1) -- Line: 1051 -- upvalues: u26 (val), u65 (ref), u64 (ref)
    local v1 = p1
    local v2 = type(v1) == "number"
    assert(v2, "Bad argument #1 to Promise.delay, must be a number.")
    if not (0.016666666666666666 <= p1) or p1 == (1 / 0) then
        p1 = 0.016666666666666666
    end
    local v3 = u26
    v3 = v3._new(debug.traceback(nil, 2), function(p1_2, p2, p3) -- Line: 1059 -- upvalues: u26 (upval), p1 (ref), u65 (upval), u64 (upval)
        local v1
        local v2 = u26._getTime()
        local v3 = v2 + p1
        local u8 = {}
        u8.resolve = p1_2
        u8.startTime = v2
        u8.endTime = v3
        if u65 == nil then
            u64 = u8
            v1 = u26
            u65 = v1._timeEvent:Connect(function() -- Line: 1071 -- upvalues: u26 (upval), u64 (upval), u65 (upval)
                local v1
                local v2 = u26._getTime()
                while u64 ~= nil do
                    if not (u64.endTime < v2) then
                        break
                    end
                    v1 = u64
                    u64 = v1.next
                    if u64 ~= nil then
                        u64.previous = nil
                    else
                        u65:Disconnect()
                        u65 = nil
                    end
                    v1.resolve(u26._getTime() - v1.startTime)
                end
            end)
        elseif not (u64.endTime < v3) then
            u8.next = u64
            u64.previous = u8
            u64 = u8
        else
            v1 = u64
            local next = v1.next
            while next ~= nil do
                if not (next.endTime < v3) then
                    break
                end
                v1 = next
                next = v1.next
            end
            v1.next = u8
            u8.previous = v1
            if next ~= nil then
                u8.next = next
                next.previous = u8
            end
        end
        p3(function() -- Line: 1116 -- upvalues: u8 (val), u64 (upval), u65 (upval)
            local next = u8.next
            if u64 ~= u8 then
                local previous = u8.previous
                previous.next = next
                if next ~= nil then
                    next.previous = previous
                end
                return
            end
            if next ~= nil then
                next.previous = nil
            else
                u65:Disconnect()
                u65 = nil
            end
            u64 = next
        end)
    end)
    return v3
end

function u26.prototype.timeout(p1, p2, p3) -- Line: 1180 -- upvalues: u26 (val), u13 (ref)
    local u6 = debug.traceback(nil, 2)
    local v1 = u26
    local race = v1.race
    local v2 = {}
    local v3 = u26
    v3 = v3.delay(p2)
    v3 = v3:andThen(function() -- Line: 1184 -- upvalues: u26 (upval), p3 (val), u13 (upval), p2 (val), u6 (val)
        local v1
        local reject = u26.reject
        if p3 ~= nil then
            v1 = p3
        else
            v1 = u13
            v1 = v1.new({
                error = "Timed out",
                kind = u13.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", p2, u6),
            })
            if not v1 then
                v1 = p3
            end
        end
        return reject(v1)
    end)
    v2[1] = v3
    v2[2] = p1
    return race(v2)
end

function u26.prototype:getStatus() -- Line: 1204
    return self._status
end

function u26.prototype:_andThen(p2, p3, p4) -- Line: 1213 -- upvalues: u26 (val), runExecutor (val)
    local v1
    self._unhandledRejection = false
    if self._status ~= u26.Status.Cancelled then
        v1 = u26
        return v1._new(p2, function(p1, p2_2, p3_2) -- Line: 1225
            -- upvalues: p3 (val), p2 (val), runExecutor (upval), p4 (val), self (val), u26 (upval)
            local v1
            local u7 = p1
            if p3 then
                local u5 = p2
                local u6 = p3

                function u7(...) -- Line: 180 -- upvalues: runExecutor (upval), u5 (val), u6 (val), p1 (val), p2_2 (val)
                    local v1, v2, v3 = runExecutor(u5, u6, ...)
                    if v1 then
                        p1(unpack(v3, 1, v2))
                        return
                    end
                    p2_2(v3[1])
                end
            end
            local u13 = p2_2
            if p4 then
                local u11 = p2
                local u12 = p4

                function u13(...) -- Line: 180
                    -- upvalues: runExecutor (upval), u11 (val), u12 (val), p1 (val), p2_2 (val)
                    local v1, v2, v3 = runExecutor(u11, u12, ...)
                    if v1 then
                        p1(unpack(v3, 1, v2))
                        return
                    end
                    p2_2(v3[1])
                end
            end
            if self._status == u26.Status.Started then
                local v2 = self
                local _queuedResolve = v2._queuedResolve
                v1 = u7
                table.insert(_queuedResolve, v1)
                v2 = self
                local _queuedReject = v2._queuedReject
                v1 = u13
                table.insert(_queuedReject, v1)
                p3_2(function() -- Line: 1244 -- upvalues: self (upval), u26 (upval), u7 (ref), u13 (ref)
                    if self._status == u26.Status.Started then
                        table.remove(self._queuedResolve, table.find(self._queuedResolve, u7))
                        table.remove(self._queuedReject, table.find(self._queuedReject, u13))
                    end
                end)
            else
                local v3, v4
                if self._status == u26.Status.Resolved then
                    v3 = u7
                    v1 = self
                    local _values = v1._values
                    v4 = self
                    local _valuesLength = v4._valuesLength
                    v3(unpack(_values, 1, _valuesLength))
                elseif self._status == u26.Status.Rejected then
                    v3 = u13
                    v1 = self
                    local _values_2 = v1._values
                    v4 = self
                    local _valuesLength_2 = v4._valuesLength
                    v3(unpack(_values_2, 1, _valuesLength_2))
                end
            end
        end, self)
    end
    v1 = u26.new(function() end)
    v1:cancel()
    return v1
end

function u26.prototype:andThen(p2, p3) -- Line: 1283
    local v1, v2
    local v3 = true
    if p2 ~= nil then
        if type(p2) == "function" then
            v3 = true
        elseif type(p2) ~= "table" then
            v3 = false
        else
            v1 = getmetatable(p2)
            if not v1 then
                v3 = false
            else
                v2 = rawget(v1, "__call")
                v3 = not (type(v2) ~= "function")
            end
        end
    end
    v1 = string.format("Please pass a handler function to %s!", "Promise:andThen")
    assert(v3, v1)
    v3 = true
    if p3 ~= nil then
        if type(p3) == "function" then
            v3 = true
        elseif type(p3) ~= "table" then
            v3 = false
        else
            v1 = getmetatable(p3)
            if not v1 then
                v3 = false
            else
                v2 = rawget(v1, "__call")
                v3 = not (type(v2) ~= "function")
            end
        end
    end
    v1 = string.format("Please pass a handler function to %s!", "Promise:andThen")
    assert(v3, v1)
    v1 = debug.traceback(nil, 2)
    return self:_andThen(v1, p2, p3)
end

function u26.prototype:catch(p2) -- Line: 1310
    local v1
    local v2 = true
    if p2 ~= nil then
        if type(p2) == "function" then
            v2 = true
        elseif type(p2) ~= "table" then
            v2 = false
        else
            v1 = getmetatable(p2)
            if not v1 then
                v2 = false
            else
                local v3 = rawget(v1, "__call")
                v2 = not (type(v3) ~= "function")
            end
        end
    end
    v1 = string.format("Please pass a handler function to %s!", "Promise:catch")
    assert(v2, v1)
    v1 = debug.traceback(nil, 2)
    return self:_andThen(v1, nil, p2)
end

function u26.prototype.tap(p1, p2) -- Line: 1331 -- upvalues: u26 (val), pack (val)
    local v1, v2
    if type(p2) == "function" then
        v1 = true
    elseif type(p2) ~= "table" then
        v1 = false
    else
        v2 = getmetatable(p2)
        if not v2 then
            v1 = false
        else
            local v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    v2 = string.format("Please pass a handler function to %s!", "Promise:tap")
    assert(v1, v2)
    v2 = debug.traceback(nil, 2)
    return p1:_andThen(v2, function(...) -- Line: 1333 -- upvalues: p2 (val), u26 (upval), pack (upval)
        local v1 = p2(...)
        if not u26.is(v1) then
            return ...
        end
        local u9, u10 = pack(...)
        return v1:andThen(function() -- Line: 1338 -- upvalues: u10 (val), u9 (val)
            local v1 = u10
            local v2 = u9
            return unpack(v1, 1, v2)
        end)
    end)
end

function u26.prototype.andThenCall(p1, p2, ...) -- Line: 1366 -- upvalues: pack (val)
    local v1, v2, v3
    if type(p2) == "function" then
        v1 = true
    elseif type(p2) ~= "table" then
        v1 = false
    else
        v2 = getmetatable(p2)
        if not v2 then
            v1 = false
        else
            v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    v2 = string.format("Please pass a handler function to %s!", "Promise:andThenCall")
    assert(v1, v2)
    local u29, u30 = pack(...)
    v3 = debug.traceback(nil, 2)
    return p1:_andThen(v3, function() -- Line: 1369 -- upvalues: p2 (val), u30 (val), u29 (val)
        local v1 = p2
        local v2 = u30
        local v3 = u29
        return v1(unpack(v2, 1, v3))
    end)
end

function u26.prototype.andThenReturn(p1, ...) -- Line: 1396 -- upvalues: pack (val)
    local u3, u4 = pack(...)
    local v1 = debug.traceback(nil, 2)
    return p1:_andThen(v1, function() -- Line: 1398 -- upvalues: u4 (val), u3 (val)
        local v1 = u4
        local v2 = u3
        return unpack(v1, 1, v2)
    end)
end

function u26.prototype:cancel() -- Line: 1414 -- upvalues: u26 (val)
    if self._status ~= u26.Status.Started then
        return
    end
    self._status = u26.Status.Cancelled
    if self._cancellationHook then
        self._cancellationHook()
    end
    coroutine.close(self._thread)
    if self._parent then
        self._parent:_consumerCancelled(self)
    end
    for k in pairs(self._consumers) do
        k:cancel()
    end
    self:_finalize()
end

function u26.prototype:_consumerCancelled(p2) -- Line: 1442 -- upvalues: u26 (val)
    if self._status ~= u26.Status.Started then
        return
    end
    self._consumers[p2] = nil
    if next(self._consumers) == nil then
        self:cancel()
    end
end

function u26.prototype:_finally(p2, p3) -- Line: 1458 -- upvalues: u26 (val)
    self._unhandledRejection = false
    local v1 = u26
    return (v1._new(p2, function(p1, p2, p3_2) -- Line: 1461 -- upvalues: self (val), p3 (val), u26 (upval)
        local u3 = nil
        p3_2(function() -- Line: 1464 -- upvalues: self (upval), u3 (ref)
            local v1 = self
            local v2 = self
            v1:_consumerCancelled(v2)
            if u3 then
                u3:cancel()
            end
        end)
        local v1 = p1
        if p3 then
            function v1(...) -- Line: 1477
                -- upvalues: p3 (upval), u26 (upval), u3 (ref), p1 (val), self (upval), p2 (val)
                local v1 = p3(...)
                if not u26.is(v1) then
                    p1(self)
                    return
                end
                u3 = v1
                ;(v1:finally(function(p1_2) -- Line: 1484 -- upvalues: u26 (upval), p1 (upval), self (upval)
                    if p1_2 ~= u26.Status.Rejected then
                        p1(self)
                    end
                end)):catch(function(...) -- Line: 1489 -- upvalues: p2 (upval)
                    p2(...)
                end)
            end
        end
        if self._status ~= u26.Status.Started then
            v1(self._status)
        else
            local v2 = self
            local _queuedFinally = v2._queuedFinally
            table.insert(_queuedFinally, v1)
        end
    end))
end

function u26.prototype:finally(p2) -- Line: 1559
    local v1
    local v2 = true
    if p2 ~= nil then
        if type(p2) == "function" then
            v2 = true
        elseif type(p2) ~= "table" then
            v2 = false
        else
            v1 = getmetatable(p2)
            if not v1 then
                v2 = false
            else
                local v3 = rawget(v1, "__call")
                v2 = not (type(v3) ~= "function")
            end
        end
    end
    v1 = string.format("Please pass a handler function to %s!", "Promise:finally")
    assert(v2, v1)
    v1 = debug.traceback(nil, 2)
    return self:_finally(v1, p2)
end

function u26.prototype.finallyCall(p1, p2, ...) -- Line: 1573 -- upvalues: pack (val)
    local v1, v2, v3
    if type(p2) == "function" then
        v1 = true
    elseif type(p2) ~= "table" then
        v1 = false
    else
        v2 = getmetatable(p2)
        if not v2 then
            v1 = false
        else
            v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    v2 = string.format("Please pass a handler function to %s!", "Promise:finallyCall")
    assert(v1, v2)
    local u29, u30 = pack(...)
    v3 = debug.traceback(nil, 2)
    return p1:_finally(v3, function() -- Line: 1576 -- upvalues: p2 (val), u30 (val), u29 (val)
        local v1 = p2
        local v2 = u30
        local v3 = u29
        return v1(unpack(v2, 1, v3))
    end)
end

function u26.prototype.finallyReturn(p1, ...) -- Line: 1599 -- upvalues: pack (val)
    local u3, u4 = pack(...)
    local v1 = debug.traceback(nil, 2)
    return p1:_finally(v1, function() -- Line: 1601 -- upvalues: u4 (val), u3 (val)
        local v1 = u4
        local v2 = u3
        return unpack(v1, 1, v2)
    end)
end

function u26.prototype:awaitStatus() -- Line: 1613 -- upvalues: u26 (val)
    self._unhandledRejection = false
    if self._status == u26.Status.Started then
        local u7 = coroutine.running()
        ;(self:finally(function() -- Line: 1620 -- upvalues: u7 (val)
            task.spawn(u7)
        end)):catch(function() end)
        coroutine.yield()
    end
    if self._status == u26.Status.Resolved then
        local _status = self._status
        local _values = self._values
        local _valuesLength = self._valuesLength
        return _status, unpack(_values, 1, _valuesLength)
    end
    if self._status ~= u26.Status.Rejected then
        return self._status
    end
    local _status_2 = self._status
    local _values_2 = self._values
    local _valuesLength_2 = self._valuesLength
    return _status_2, unpack(_values_2, 1, _valuesLength_2)
end

local function awaitHelper(p1, ...) -- Line: 1641 -- upvalues: u26 (val)
    local v1 = p1 == u26.Status.Resolved
    return v1, ...
end

function u26.prototype:await() -- Line: 1666 -- upvalues: awaitHelper (val)
    return awaitHelper(self:awaitStatus())
end

local function expectHelper(p1, ...) -- Line: 1670 -- upvalues: u26 (val)
    if p1 ~= u26.Status.Resolved then
        local v1
        local v2 = error
        if (...) ~= nil then
            v1 = ...
        else
            v1 = "Expected Promise rejected with no value."
        end
        v2(v1, 3)
    end
    return ...
end

function u26.prototype.expect(p1) -- Line: 1703 -- upvalues: expectHelper (val)
    return expectHelper(p1:awaitStatus())
end

u26.prototype.awaitValue = u26.prototype.expect

function u26.prototype._unwrap(p1) -- Line: 1717 -- upvalues: u26 (val)
    if p1._status == u26.Status.Started then
        error("Promise has not resolved or rejected.", 2)
    end
    local v1 = p1._status == u26.Status.Resolved
    local _values = p1._values
    local _valuesLength = p1._valuesLength
    return v1, unpack(_values, 1, _valuesLength)
end

function u26.prototype:_resolve(...) -- Line: 1727 -- upvalues: u26 (val), u13 (ref), pack (val)
    local v1, v2
    if self._status ~= u26.Status.Started then
        if u26.is((...)) then
            ...:_consumerCancelled(self)
        end
        return
    end
    if not u26.is((...)) then
        self._status = u26.Status.Resolved
        v1, v2 = pack(...)
        self._valuesLength = v1
        self._values = v2
        for i, v in ipairs(self._queuedResolve) do
            coroutine.wrap(v)(...)
        end
        self:_finalize()
        return
    end
    v1 = select("#", ...)
    if 1 < v1 then
        v1 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", self._source)
        warn(v1)
    end
    local u30 = ...
    v2 = u30:andThen(function(...) -- Line: 1748 -- upvalues: self (val)
        self:_resolve(...)
    end, function(...) -- Line: 1750 -- upvalues: u30 (val), u13 (upval), self (val)
        local v1
        local v2 = u30._values[1]
        if u30._error then
            v1 = u13
            v2 = v1.new({
                context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                error = u30._error,
                kind = u13.Kind.ExecutionError,
            })
        end
        if not u13.isKind(v2, u13.Kind.ExecutionError) then
            self:_reject(...)
            return
        end
        v1 = self
        local v3 = {
            error = "This Promise was chained to a Promise that errored.",
            trace = "",
            context = string.format(
                "The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n",
                self._source
            ),
        }
        local v4 = v2:extend(v3)
        return v1:_reject(v4)
    end)
    if v2._status == u26.Status.Cancelled then
        self:cancel()
        return
    end
    if v2._status == u26.Status.Started then
        self._parent = v2
        v2._consumers[self] = true
    end
end

function u26.prototype:_reject(...) -- Line: 1798 -- upvalues: u26 (val), pack (val)
    if self._status ~= u26.Status.Started then
        return
    end
    self._status = u26.Status.Rejected
    local v1, v2 = pack(...)
    self._valuesLength = v1
    self._values = v2
    local _queuedReject = self._queuedReject
    v1 = next(_queuedReject) == nil
    if v1 then
        local u39 = tostring((...))
        coroutine.wrap(function() -- Line: 1820 -- upvalues: u26 (upval), self (val), u39 (val)
            local _values, _valuesLength, spawn, v1, v2, v3
            u26._timeEvent:Wait()
            if not self._unhandledRejection then
                return
            end
            local v4 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u39, self._source)
            for i, v in ipairs(u26._unhandledRejectionCallbacks) do
                spawn = task.spawn
                v3 = self
                v1 = self
                _values = v1._values
                v2 = self
                _valuesLength = v2._valuesLength
                spawn(v, v3, unpack(_values, 1, _valuesLength))
            end
            if u26.TEST then
                return
            end
            warn(v4)
        end)()
    else
        for i, v in ipairs(self._queuedReject) do
            coroutine.wrap(v)(...)
        end
    end
    self:_finalize()
end

function u26.prototype:_finalize() -- Line: 1852 -- upvalues: u26 (val)
    for i, v in ipairs(self._queuedFinally) do
        coroutine.wrap(v)(self._status)
    end
    self._queuedFinally = nil
    self._queuedReject = nil
    self._queuedResolve = nil
    if not u26.TEST then
        self._parent = nil
        self._consumers = nil
    end
    task.defer(coroutine.close, self._thread)
end

function u26.prototype.now(p1, p2) -- Line: 1889 -- upvalues: u26 (val), u13 (ref)
    local v1
    local v2 = debug.traceback(nil, 2)
    if p1._status == u26.Status.Resolved then
        return p1:_andThen(v2, function(...) -- Line: 1892
            return ...
        end)
    end
    local reject = u26.reject
    if p2 ~= nil then
        v1 = p2
    else
        v1 = u13
        v1 = v1.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u13.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. v2,
        })
        if not v1 then
            v1 = p2
        end
    end
    return reject(v1)
end

function u26.retry(p1, p2, ...) -- Line: 1934 -- upvalues: u26 (val)
    local v1, v2
    if type(p1) == "function" then
        v1 = true
    elseif type(p1) ~= "table" then
        v1 = false
    else
        v2 = getmetatable(p1)
        if not v2 then
            v1 = false
        else
            local v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    assert(v1, "Parameter #1 to Promise.retry must be a function")
    v1 = type(p2) == "number"
    assert(v1, "Parameter #2 to Promise.retry must be a number")
    local u35 = {}
    u35[1] = ...
    local u40 = select("#", ...)
    v2 = u26
    local resolve = v2.resolve
    local v4 = p1(...)
    return (resolve(v4)):catch(function(...) -- Line: 1940 -- upvalues: p2 (val), u26 (upval), p1 (val), u35 (val), u40 (val)
        if not (0 < p2) then
            return u26.reject(...)
        end
        local v1 = u26
        local retry = v1.retry
        local v2 = p1
        local v3 = p2 - 1
        local v4 = u35
        local v5 = u40
        return retry(v2, v3, unpack(v4, 1, v5))
    end)
end

function u26.retryWithDelay(p1, p2, p3, ...) -- Line: 1962 -- upvalues: u26 (val)
    local v1, v2
    if type(p1) == "function" then
        v1 = true
    elseif type(p1) ~= "table" then
        v1 = false
    else
        v2 = getmetatable(p1)
        if not v2 then
            v1 = false
        else
            local v3 = rawget(v2, "__call")
            v1 = not (type(v3) ~= "function")
        end
    end
    assert(v1, "Parameter #1 to Promise.retry must be a function")
    v1 = type(p2) == "number"
    assert(v1, "Parameter #2 (times) to Promise.retry must be a number")
    v1 = type(p3) == "number"
    assert(v1, "Parameter #3 (seconds) to Promise.retry must be a number")
    local u48 = {}
    u48[1] = ...
    local u53 = select("#", ...)
    v2 = u26
    local resolve = v2.resolve
    local v4 = p1(...)
    return (resolve(v4)):catch(function(...) -- Line: 1969 -- upvalues: p2 (val), u26 (upval), p3 (val), p1 (val), u48 (val), u53 (val)
        if not (0 < p2) then
            return u26.reject(...)
        end
        u26.delay(p3):await()
        local v1 = u26
        local retryWithDelay = v1.retryWithDelay
        local v2 = p1
        local v3 = p2 - 1
        local v4 = p3
        local v5 = u48
        local v6 = u53
        return retryWithDelay(v2, v3, v4, unpack(v5, 1, v6))
    end)
end

function u26.fromEvent(p1, p2) -- Line: 2004 -- upvalues: u26 (val)
    local v1 = p2 or function() -- Line: 2005
        return true
    end
    local u5 = v1
    v1 = u26
    v1 = v1._new(debug.traceback(nil, 2), function(p1_2, p2, p3) -- Line: 2009 -- upvalues: p1 (val), u5 (ref)
        local u3 = nil
        local u4 = false

        local function disconnect() -- Line: 2013 -- upvalues: u3 (ref)
            u3:Disconnect()
            u3 = nil
        end

        local v1 = p1
        v1 = v1:Connect(function(...) -- Line: 2022 -- upvalues: u5 (upval), p1_2 (val), u3 (ref), u4 (ref)
            local v1 = u5(...)
            if v1 ~= true then
                if type(v1) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean")
                end
                return
            end
            p1_2(...)
            if not u3 then
                u4 = true
                return
            end
            u3:Disconnect()
            u3 = nil
        end)
        u3 = v1
        if u4 and u3 then
            v1 = disconnect()
            return v1
        end
        p3(disconnect)
    end)
    return v1
end

function u26.onUnhandledRejection(p1) -- Line: 2056 -- upvalues: u26 (val)
    local v1 = u26
    local _unhandledRejectionCallbacks = v1._unhandledRejectionCallbacks
    table.insert(_unhandledRejectionCallbacks, p1)
    return function() -- Line: 2059 -- upvalues: u26 (upval), p1 (val)
        local v1 = table.find(u26._unhandledRejectionCallbacks, p1)
        if v1 then
            table.remove(u26._unhandledRejectionCallbacks, v1)
        end
    end
end

return u26