local utils = require(script.Parent.utils)
local getConnectFunction = utils.getConnectFunction
local u8 = {}
return {
    timePassed = function(p1) -- Line: 22
        local u1 = nil
        return function() -- Line: 25 -- upvalues: u1 (ref), p1 (val)
            if u1 ~= nil then
                local v1 = os.clock() - u1
                if not (p1 <= v1) then
                    return false
                end
            end
            u1 = os.clock()
            return true
        end
    end,
    runOnce = function() -- Line: 39
        local u0 = false
        return function() -- Line: 42 -- upvalues: u0 (ref)
            if u0 then
                return false
            end
            u0 = true
            return true
        end
    end,
    onEvent = function(p1, p2) -- Line: 107 -- upvalues: getConnectFunction (val), utils (val), u8 (val)
        local v1 = getConnectFunction(p1, p2)
        assert(v1, "Event passed to .onEvent is not valid")
        local u10 = false
        local u11 = {}
        local u12 = nil

        local function disconnect() -- Line: 119 -- upvalues: u12 (ref), utils (upval)
            if not u12 then
                return
            end
            utils.disconnectEvent(u12)
            u12 = nil
        end

        local v2 = v1(function(...) -- Line: 128 -- upvalues: u10 (ref), u11 (val)
            u10 = true
            local v1 = u11
            local v2 = {...}
            table.insert(v1, v2)
        end)

        local function hasNewEvent() -- Line: 135 -- upvalues: u10 (ref), u11 (val)
            if u10 then
                u10 = false
                return true
            end
            table.clear(u11)
            return false
        end

        u8[hasNewEvent] = disconnect
        return hasNewEvent, function() -- Line: 145 -- upvalues: u11 (val)
            local u0 = 0
            return function() -- Line: 147 -- upvalues: u0 (ref), u11 (upval)
                u0 = u0 + 1
                local v1 = table.remove(u11, 1)
                if v1 then
                    return u0, table.unpack(v1)
                end
                return nil
            end
        end, function() -- Line: 160 -- upvalues: disconnect (val)
            return disconnect
        end
    end,
    isNot = function(p1, ...) -- Line: 176
        return function() -- Line: 177 -- upvalues: p1 (val)
            return not p1()
        end
    end,
    cleanupCondition = function(p1) -- Line: 56 -- upvalues: u8 (val)
        local v1 = u8[p1]
        if v1 then
            v1()
            u8[p1] = nil
        end
    end,
}