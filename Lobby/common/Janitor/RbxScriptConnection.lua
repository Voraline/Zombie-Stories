local u0 = {Connected = true}
u0.__index = u0

function u0:Disconnect() -- Line: 20
    if self.Connected then
        self.Connected = false
        self.Connection:Disconnect()
    end
end

function u0._new(p1) -- Line: 27 -- upvalues: u0 (val)
    local v1 = {Connection = p1}
    local v2 = u0
    return (setmetatable(v1, v2))
end

function u0.__tostring(p1) -- Line: 33
    local Connected = p1.Connected
    return "RbxScriptConnection<" .. (tostring(Connected)) .. ">"
end

return u0