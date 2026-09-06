require("./types/fusion")
local function connect(p1, p2) -- Line: 15
    local u49, u5, v1
    if typeof(p1) == "RBXScriptSignal" then
        u5 = nil
        u5 = p1:Connect(function(...) -- Line: 19 -- upvalues: u5 (ref), p2 (val)
            if u5.Connected then
                p2(...)
            end
        end)
        return u5
    end
    v1, u49 = p1, p2
    local v2 = typeof(v1) == "table"
    assert(v2, "[pretty-fusion-utils] Event-like should be an object")
    u5 = typeof(v1.Connect)
    if u5 == "function" then
        u5 = v1:Connect(u49)
        return u5
    end
    u5 = typeof(v1.connect)
    if u5 == "function" then
        u5 = v1:connect(u49)
        return u5
    end
    u5 = typeof(v1.subscribe)
    if u5 == "function" then
        u5 = v1:subscribe(u49)
        return u5
    end
    error("[pretty-fusion-utils] Event-like has no supported connect method")
end
local function bindDisconnect(p1) -- Line: 40
    if typeof(p1) == "function" then
        return p1
    end
    if typeof(p1) == "RBXScriptConnection" then
        return function() -- Line: 44 -- upvalues: p1 (val)
            if p1.Connected then
                p1:Disconnect()
            end
        end
    end
    local v1 = typeof(p1) == "table"
    assert(v1, "[pretty-fusion-utils] Connection-like should be an object")
    local Disconnect = p1.Disconnect
    if not Disconnect then
        Disconnect = p1.disconnect
    end
    return function() -- Line: 53 -- upvalues: Disconnect (val), p1 (val)
        Disconnect(p1)
    end
end
return function(p1, p2, p3) -- Line: 64 -- upvalues: bindDisconnect (val), connect (val)
    local v1 = bindDisconnect(connect(p2, p3))
    table.insert(p1, v1)
    return v1
end