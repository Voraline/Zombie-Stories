local u2 = require("./ServerProcess")
local v1 = {}
local u4 = {}
u4.__index = v1

function u4.__tostring(p1) -- Line: 10
    return "ServerConnection"
end

function v1.Disconnect(p1) -- Line: 14
    p1.Connected = nil
    p1._disconnectCallback()
    table.clear(p1)
    setmetatable(p1, nil)
end

return function(p1, p2) -- Line: 23 -- upvalues: u4 (val), u2 (val)
    local v1 = {
        Connected = true,
        _disconnectCallback = function() end,
    }
    local v2 = u4
    local v3 = setmetatable(v1, v2)
    v3._disconnectCallback = u2.connect(p1, p2)
    return v3
end