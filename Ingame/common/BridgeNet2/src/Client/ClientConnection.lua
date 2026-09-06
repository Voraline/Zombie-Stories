local u2 = require("./ClientProcess")
local v1 = {}
local u4 = {
    __index = v1,
    __tostring = function(p1) -- Line: 9
        return "ClientConnection"
    end,
}
function v1.Disconnect(p1) -- Line: 13
    p1.Connected = nil
    p1._disconnectCallback()
    table.clear(p1)
    setmetatable(p1, nil)
end
return function(p1, p2) -- Line: 22 -- upvalues: u4 (val), u2 (val)
    local v1 = setmetatable({
        Connected = true,
        _disconnectCallback = function() end,
    }, u4)
    v1._disconnectCallback = u2.connect(p1, p2)
    return v1
end