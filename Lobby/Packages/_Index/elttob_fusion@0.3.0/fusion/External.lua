local Parent = script.Parent
local formatError = require(Parent.Logging.formatError)
require(Parent.Types)
local u9 = {safetyTimerMultiplier = 1}
local u11 = {}
local u12 = nil
local u13 = 0
function u9.setExternalProvider(p1) -- Line: 36 -- upvalues: u12 (ref)
    local v1 = u12
    if v1 ~= nil then
        v1.stopScheduler()
    end
    u12 = p1
    if p1 ~= nil then
        p1.startScheduler()
    end
    return v1
end
function u9.isTimeCritical() -- Line: 53
    return false
end
function u9.doTaskImmediate(p1) -- Line: 60 -- upvalues: u12 (ref), u9 (val)
    if u12 == nil then
        u9.logError("noTaskScheduler")
        return
    end
    u12.doTaskImmediate(p1)
end
function u9.doTaskDeferred(p1) -- Line: 73 -- upvalues: u12 (ref), u9 (val)
    if u12 == nil then
        u9.logError("noTaskScheduler")
        return
    end
    u12.doTaskDeferred(p1)
end
function u9.logError(p1, p2, ...) -- Line: 86 -- upvalues: formatError (val), u12 (ref)
    local v1 = formatError(u12, p1, p2, ...)
    error(v1, 0)
end
function u9.logErrorNonFatal(p1, p2, ...) -- Line: 97 -- upvalues: formatError (val), u12 (ref)
    local v1 = formatError(u12, p1, p2, ...)
    if u12 ~= nil then
        u12.logErrorNonFatal(v1)
        return
    end
    print(v1)
end
function u9.logWarn(p1, ...) -- Line: 113 -- upvalues: formatError (val), u12 (ref)
    local v1 = debug.traceback(nil, 2)
    local v2 = formatError(u12, p1, v1, ...)
    if u12 ~= nil then
        u12.logWarn(v2)
        return
    end
    print(v2)
end
function u9.bindToUpdateStep(p1) -- Line: 135 -- upvalues: u11 (val)
    local u1 = {}
    u11[u1] = p1
    return function() -- Line: 142 -- upvalues: u11 (upval), u1 (val)
        u11[u1] = nil
    end
end
function u9.performUpdateStep(p1) -- Line: 152 -- upvalues: u13 (ref), u11 (val)
    u13 = p1
    local v1 = u11
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        j(p1)
    end
end
function u9.lastUpdateStep() -- Line: 164 -- upvalues: u13 (ref)
    return u13
end
return u9