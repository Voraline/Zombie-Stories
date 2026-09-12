require("./types/fusion")
local u8 = require(script.Parent.utils["cast-to-state"])
local u14 = require(script.Parent.utils["lock-value"])
return function(p1, p2, p3) -- Line: 18 -- upvalues: u8 (val), u14 (val)
    local process
    local u5 = p1:scoped()
    local peek = u5.peek
    local u10 = u5:Value(p2)
    local u11 = {}
    local u12 = nil

    local function become(p1) -- Line: 34 -- upvalues: u10 (val)
        return u10:set(p1)
    end

    local function clear() -- Line: 38 -- upvalues: u12 (ref), u11 (val), u10 (val), p2 (val)
        if u12 then
            u12:doCleanup()
            u12 = nil
        end
        if next(u11) ~= nil then
            for k, v in pairs(u11) do
                pcall(v)
            end
            table.clear(u11)
        end
        local v1 = u10
        local v2 = p2
        v1:set(v2)
    end

    function process() -- Line: 54
        -- upvalues: clear (val), u8 (upval), u11 (val), u5 (val), process (val), peek (val), u12 (ref), p3 (val)
        -- upvalues: become (val), u10 (val), p2 (val)
        clear()
        u12 = u5:innerScope()
        local success, result = xpcall(p3, debug.traceback, function(p1) -- Line: 56 -- upvalues: u8 (upval), u11 (upval), u5 (upval), process (upval), peek (upval)
            if not u8(p1) then
                return p1
            end
            local v1 = u11
            local v2 = u5:Observer(p1)
            v1[p1] = (v2:onChange(function() -- Line: 61 -- upvalues: process (upval)
                task.spawn(process)
            end))
            return peek(p1)
        end, become, u12)
        if success then
            u10:set(result)
        end
        warn((("[pretty-fusion-utils] useEventual processor thrown error during processing:\n%*"):format(result)))
        local v1 = u10
        local v2 = p2
        v1:set(v2)
    end

    local v1 = u14
    v1 = v1(u10)
    return v1
end