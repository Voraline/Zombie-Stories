local v1, v2, v3, v4, v5
local Heartbeat = game:GetService("RunService").Heartbeat
local u8 = newproxy(true)
local v6 = getmetatable(u8)
function v6.__tostring() -- Line: 11
    return "IndicesReference"
end
local u15 = newproxy(true)
local v7 = getmetatable(u15)
function v7.__tostring() -- Line: 16
    return "LinkToInstanceIndex"
end
local u20 = {ClassName = "Janitor"}
local v8 = {CurrentlyCleaning = true}
v8[u8] = nil
u20.__index = v8
local u24 = {}
u24["function"] = true
u24.RBXScriptConnection = "Disconnect"
function u20.new() -- Line: 40 -- upvalues: u8 (val), u20 (val)
    local v1 = {CurrentlyCleaning = false}
    v1[u8] = nil
    return (setmetatable(v1, u20))
end
function u20.Is(p1) -- Line: 52 -- upvalues: u20 (val)
    local v1 = false
    if type(p1) == "table" then
        local v2 = getmetatable(p1)
        v1 = v2 == u20
    end
    return v1
end
u20.is = u20.Is
function u20.__index:Add(p2, p3, p4) -- Line: 65 -- upvalues: u8 (val), u24 (val)
    local v1, v2
    if p4 ~= nil then
        v1 = p4
    else
        v1 = newproxy(false)
    end
    if v1 then
        self:Remove(v1)
        v2 = self[u8]
        if not v2 then
            self[u8] = {}
        end
        v2[v1] = p2
    end
    v2 = p3
    if not v2 then
        v2 = u24[typeof(p2)]
        if not v2 then
            v2 = "Destroy"
        end
    end
    local v3 = v2
    if type(p2) ~= "function" and not (p2[v3]) then
        local v4 = tostring(p2)
        local v5 = tostring(v3)
        warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", v4, v5, debug.traceback(nil, 2)))
    end
    self[p2] = v3
    return p2, v1
end
u20.__index.Give = u20.__index.Add
function u20.__index.AddObject(p1, p2) -- Line: 131
    local v1 = newproxy(false)
    local v2 = p1:Add(p2, false, v1)
    return v2, v1
end
u20.__index.GiveObject = u20.__index.AddObject
function u20.__index:Remove(p2) -- Line: 155 -- upvalues: u8 (val)
    local v1 = self[u8]
    if v1 then
        local v2 = v1[p2]
        if v2 then
            local v3 = self[v2]
            if v3 then
                if v3 ~= true then
                    local v4 = v2[v3]
                    if v4 then
                        v4(v2)
                    end
                else
                    v2()
                end
                self[v2] = nil
            end
            v1[p2] = nil
        end
    end
    return self
end
function u20.__index.Get(p1, p2) -- Line: 189 -- upvalues: u8 (val)
    local v1 = p1[u8]
    if v1 then
        return v1[p2]
    end
end
function u20.__index:Cleanup() -- Line: 200 -- upvalues: u8 (val)
    if not self.CurrentlyCleaning then
        local v1, v2
        self.CurrentlyCleaning = nil
        local v3 = next
        local v4 = self
        local v5 = nil
        local v6 = self
        for k, v in v3, v4, v5 do
            if k ~= u8 then
                v1 = type(k)
                if v1 == "string" then
                    v6[k] = nil
                elseif v1 ~= "number" then
                    if v ~= true then
                        v2 = k[v]
                        if v2 then
                            v2(k)
                        end
                    else
                        k()
                    end
                    v6[k] = nil
                end
            end
        end
        v3 = v6[u8]
        if v3 then
            v4 = next
            v5 = v3
            local v7 = nil
            for k2 in v4, v5, v7 do
                v3[k2] = nil
            end
            v6[u8] = {}
        end
        v6.CurrentlyCleaning = false
    end
end
u20.__index.Clean = u20.__index.Cleanup
function u20.__index.Destroy(p1) -- Line: 246
    p1:Cleanup()
end
u20.__call = u20.__index.Cleanup
local u53 = {Connected = true}
u53.__index = u53
function u53:Disconnect() -- Line: 260
    if self.Connected then
        self.Connected = false
        self.Connection:Disconnect()
    end
end
function u53.__tostring(p1) -- Line: 267
    local v1 = tostring(p1.Connected)
    return "Disconnect<" .. v1 .. ">"
end
function u20.__index:LinkToInstance(p2, p3) -- Line: 277 -- upvalues: u15 (val), u53 (val), Heartbeat (val)
    local v1
    local u3 = nil
    if not p3 then
        v1 = u15
    else
        v1 = newproxy(false)
    end
    local u12 = p2.Parent == nil
    local u16 = setmetatable({}, u53)
    u3 = p2.AncestryChanged:Connect(function(p1, p2) -- Line: 283 -- upvalues: u16 (val), u12 (ref), Heartbeat (upval), u3 (ref), self (val)
        if u16.Connected then
            local v1 = p2 == nil
            u12 = v1
            if u12 then
                coroutine.wrap(function() -- Line: 289 -- upvalues: Heartbeat (upval), u16 (upval), u3 (upval), self (upval), u12 (upval)
                    Heartbeat:Wait()
                    if not u16.Connected then
                        return
                    end
                    if not u3.Connected then
                        self:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16.Connected then
                            break
                        end
                        Heartbeat:Wait()
                    end
                    if u16.Connected and u12 then
                        self:Cleanup()
                    end
                end)()
            end
        end
    end)
    u16.Connection = u3
    if u12 and u16.Connected then
        u12 = p2.Parent == nil
        if u12 then
            coroutine.wrap(function() -- Line: 289 -- upvalues: Heartbeat (upval), u16 (val), u3 (ref), self (val), u12 (ref)
                Heartbeat:Wait()
                if not u16.Connected then
                    return
                end
                if not u3.Connected then
                    self:Cleanup()
                    return
                end
                while u12 do
                    if not u3.Connected or not u16.Connected then
                        break
                    end
                    Heartbeat:Wait()
                end
                if u16.Connected and u12 then
                    self:Cleanup()
                end
            end)()
        end
    end
    return self:Add(u16, "Disconnect", v1)
end
function u20.__index.LinkToInstances(p1, ...) -- Line: 325 -- upvalues: u20 (val)
    local v1
    local v2 = u20.new()
    local v3 = {...}
    for i, v in ipairs(v3) do
        v1 = p1:LinkToInstance(v, true)
        v2:Add(v1, "Disconnect")
    end
    return v2
end
v4 = next
local __index = u20.__index
v5 = nil
for k, v in v4, __index, v5 do
    v3 = string.lower(k)
    v2 = string.sub(v3, 1, 1)
    v1 = v2 .. string.sub(k, 2)
    u20.__index[v1] = v
end
return u20