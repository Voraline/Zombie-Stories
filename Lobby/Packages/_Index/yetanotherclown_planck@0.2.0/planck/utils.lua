local u5 = {"Connect", "On", "on", "connect"}
local u10 = {"disconnect", "Disconnect", "destroy", "Destroy"}
local function getConnectFunction(p1, p2) -- Line: 135 -- upvalues: u5 (val)
    local u12 = p1
    if typeof(p2) == "RBXScriptSignal" then
        u12 = p2
    elseif type(p2) ~= "table" and type(p2) == "string" then
        u12 = p1[p2]
    end
    if type(u12) == "function" then
        return u12
    end
    if typeof(u12) == "RBXScriptSignal" then
        return function(p1) -- Line: 147 -- upvalues: u12 (ref)
            return u12:Connect(p1)
        end
    end
    if type(u12) ~= "table" then
        return nil
    end
    if type(p2) == "function" then
        return function(p1) -- Line: 154 -- upvalues: p2 (val), u12 (ref)
            return p2(u12, p1)
        end
    end
    local v1 = u5
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if type(u12[j]) == "function" then
            return function(p1) -- Line: 164 -- upvalues: u12 (ref), j (val)
                return u12[j](u12, p1)
            end
        end
    end
    return nil
end
return {
    getSystem = function(p1) -- Line: 14
        if type(p1) == "function" then
            return p1
        end
        if type(p1) ~= "table" then
            return nil
        end
        if p1.system then
            return p1.system
        end
        return nil
    end,
    getSystemName = function(p1) -- Line: 24
        local v1, v2
        local v3 = debug.info(p1, "n")
        if not v3 then
            v1, v2 = debug.info(p1, "sl")
            v3 = ("%*:%*"):format(v1, v2)
        elseif string.len(v3) == 0 then
            v1, v2 = debug.info(p1, "sl")
            v3 = ("%*:%*"):format(v1, v2)
        end
        return v3
    end,
    isPhase = function(p1) -- Line: 34
        if type(p1) ~= "table" then
            return nil
        end
        if p1._type == "phase" then
            return p1
        end
        return nil
    end,
    isPipeline = function(p1) -- Line: 42
        if type(p1) ~= "table" then
            return nil
        end
        if p1._type == "pipeline" then
            return p1
        end
        return nil
    end,
    getEventIdentifier = function(p1, p2) -- Line: 50
        local v1
        local v2 = "%*%*"
        local v3 = p1
        if not p2 then
            v1 = ""
        else
            v1 = ("@%*"):format(p2)
            if not v1 then
                v1 = ""
            end
        end
        return (v2:format(v3, v1))
    end,
    isValidEvent = function(p1, p2) -- Line: 173 -- upvalues: getConnectFunction (val)
        local v1 = getConnectFunction(p1, p2) ~= nil
        return v1
    end,
    getConnectFunction = getConnectFunction,
    disconnectEvent = function(p1) -- Line: 73 -- upvalues: u10 (val)
        if type(p1) == "function" then
            p1()
            return
        end
        if typeof(p1) == "RBXScriptConnection" then
            p1:Disconnect()
            return
        end
        if type(p1) ~= "table" then
            return
        end
        local v1 = u10
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if p1[j] and type(p1[j]) == "function" then
                p1[j](p1)
                return
            end
        end
    end,
}