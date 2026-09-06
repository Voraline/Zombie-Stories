local v1, v2, v3, v4, v5
local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat
local function getPromiseReference() -- Line: 25 -- upvalues: RunService (val)
    if RunService:IsRunning() then
        return require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
end
local u9 = newproxy(true)
local v6 = getmetatable(u9)
function v6.__tostring() -- Line: 33
    return "IndicesReference"
end
local u16 = newproxy(true)
local v7 = getmetatable(u16)
function v7.__tostring() -- Line: 38
    return "LinkToInstanceIndex"
end
local u21 = {IGNORE_MEMORY_DEBUG = true, ClassName = "Janitor"}
local v8 = {CurrentlyCleaning = true}
v8[u9] = nil
u21.__index = v8
local u25 = {}
u25["function"] = true
u25.Promise = "cancel"
u25.RBXScriptConnection = "Disconnect"
function u21.new() -- Line: 64 -- upvalues: u9 (val), u21 (val)
    local v1 = {CurrentlyCleaning = false}
    v1[u9] = nil
    return (setmetatable(v1, u21))
end
function u21.Is(p1) -- Line: 76 -- upvalues: u21 (val)
    local v1 = false
    if type(p1) == "table" then
        local v2 = getmetatable(p1)
        v1 = v2 == u21
    end
    return v1
end
u21.is = u21.Is
function u21.__index:Add(p2, p3, p4) -- Line: 89 -- upvalues: u9 (val), u25 (val)
    local v1
    if p4 then
        self:Remove(p4)
        v1 = self[u9]
        if not v1 then
            self[u9] = {}
        end
        v1[p4] = p2
    end
    v1 = typeof(p2)
    if v1 == "table" then
        local v2 = tostring(p2)
        if string.match(v2, "Promise") then
            v1 = "Promise"
        end
    end
    local v3 = p3
    if not v3 then
        v3 = u25[v1]
        if not v3 then
            v3 = "Destroy"
        end
    end
    local v4 = v3
    if type(p2) ~= "function" and not (p2[v4]) then
        local v5 = tostring(p2)
        local v6 = tostring(v4)
        warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", v5, v6, debug.traceback(nil, 2)))
    end
    v3 = debug.traceback("")
    self[p2] = {v4, v3}
    return p2
end
u21.__index.Give = u21.__index.Add
function u21.__index.AddPromise(p1, p2) -- Line: 126 -- upvalues: RunService (val)
    local Promise, v1
    if not (RunService:IsRunning()) then
        Promise = nil
    else
        Promise = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
    if not Promise then
        return p2
    end
    if not (Promise.is(p2)) then
        v1 = typeof(p2)
        error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", v1, (tostring(p2))))
    end
    local v2 = p2:getStatus()
    if v2 ~= Promise.Status.Started then
        return p2
    end
    v2 = newproxy(false)
    v1 = Promise.new(function(p1, a2, p3) -- Line: 134 -- upvalues: p2 (val)
        if p3(function() -- Line: 135 -- upvalues: p2 (upval)
    local v1, v2
    p2:cancel()
    return
end) then
            return
        end
        p1(p2)
    end)
    local v3 = p1:Add(v1, "cancel", v2)
    v3:finallyCall(p1.Remove, p1, v2)
    return v3
end
u21.__index.GivePromise = u21.__index.AddPromise
function u21.__index.AddObject(p1, p2) -- Line: 156 -- upvalues: RunService (val)
    local Promise, v1
    local v2 = newproxy(false)
    if not (RunService:IsRunning()) then
        Promise = nil
    else
        Promise = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
    if not Promise or not (Promise.is(p2)) then
        v1 = p1:Add(p2, false, v2)
        return v1, v2
    end
    v1 = p2:getStatus()
    if v1 ~= Promise.Status.Started then
        return p2
    end
    local v3 = Promise.resolve(p2)
    v1 = p1:Add(v3, "cancel", v2)
    v1:finallyCall(p1.Remove, p1, v2)
    return v1, v2
end
u21.__index.GiveObject = u21.__index.AddObject
function u21.__index:Remove(p2) -- Line: 179 -- upvalues: u9 (val)
    local v1 = self[u9]
    if v1 then
        local v2 = v1[p2]
        if v2 then
            local v3 = self[v2]
            local v4 = v3
            if v4 then
                v4 = v3[1]
            end
            if v4 then
                if v4 ~= true then
                    local v5 = v2[v4]
                    if v5 then
                        v5(v2)
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
function u21.__index.Get(p1, p2) -- Line: 213 -- upvalues: u9 (val)
    local v1 = p1[u9]
    if v1 then
        return v1[p2]
    end
end
function u21.__index:Cleanup() -- Line: 224 -- upvalues: u9 (val)
    if not self.CurrentlyCleaning then
        local v1, v2, v3, v4, v5, v6, v7, v8, v9, warnUser
        self.CurrentlyCleaning = nil
        local v10 = next
        local v11 = self
        local v12 = nil
        local v13 = self
        for k, v in v10, v11, v12 do
            if k ~= u9 then
                v8 = type(k)
                if v8 == "string" then
                    v13[k] = nil
                elseif v8 ~= "number" then
                    v9 = v[1]
                    local u37 = v[2]
                    function warnUser(p1) -- Line: 241 -- upvalues: u37 (val)
                        local v1 = debug.traceback("", 3)
                        local v2 = tostring(p1)
                        warn("-------- Janitor Error --------" .. "\n" .. v2 .. "\n" .. v1 .. "" .. u37)
                    end
                    if v9 ~= true then
                        v1 = k[v9]
                        if v1 then
                            v2, v3 = pcall(v1, k)
                            v4 = if typeof(k) == "Instance" then v1 == "Destroy" else false
                            if not v2 and not v4 then
                                v5 = debug.traceback("", 3)
                                v7 = tostring(v3)
                                warn("-------- Janitor Error --------" .. "\n" .. v7 .. "\n" .. v5 .. "" .. u37)
                            end
                        end
                    else
                        v1, v2 = pcall(k)
                        if not v1 then
                            v3 = debug.traceback("", 3)
                            v6 = tostring(v2)
                            warn("-------- Janitor Error --------" .. "\n" .. v6 .. "\n" .. v3 .. "" .. u37)
                        end
                    end
                    v13[k] = nil
                end
            end
        end
        v10 = v13[u9]
        if v10 then
            v11 = next
            v12 = v10
            local v14 = nil
            for k2 in v11, v12, v14 do
                v10[k2] = nil
            end
            v13[u9] = {}
        end
        v13.CurrentlyCleaning = false
    end
end
u21.__index.Clean = u21.__index.Cleanup
function u21.__index.Destroy(p1) -- Line: 284
    p1:Cleanup()
end
u21.__call = u21.__index.Cleanup
local u60 = {Connected = true}
u60.__index = u60
function u60:Disconnect() -- Line: 298
    if self.Connected then
        self.Connected = false
        self.Connection:Disconnect()
    end
end
function u60.__tostring(p1) -- Line: 305
    local v1 = tostring(p1.Connected)
    return "Disconnect<" .. v1 .. ">"
end
function u21.__index:LinkToInstance(p2, p3) -- Line: 315 -- upvalues: u16 (val), u60 (val), Heartbeat (val)
    local u16, v1
    local u3 = nil
    if not p3 then
        v1 = u16
    else
        v1 = newproxy(false)
    end
    local u12 = p2.Parent == nil
    u16 = setmetatable({}, u60)
    u3 = p2.AncestryChanged:Connect(function(p1, p2) -- Line: 321 -- upvalues: u16 (val), u12 (ref), Heartbeat (upval), u3 (ref), self (val)
        if u16.Connected then
            local v1 = p2 == nil
            u12 = v1
            if u12 then
                coroutine.wrap(function() -- Line: 327 -- upvalues: Heartbeat (upval), u16 (upval), u3 (upval), self (upval), u12 (upval)
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
            coroutine.wrap(function() -- Line: 327 -- upvalues: Heartbeat (upval), u16 (val), u3 (ref), self (val), u12 (ref)
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
function u21.__index.LinkToInstances(p1, ...) -- Line: 363 -- upvalues: u21 (val)
    local v1
    local v2 = u21.new()
    local v3 = {...}
    for i, v in ipairs(v3) do
        v1 = p1:LinkToInstance(v, true)
        v2:Add(v1, "Disconnect")
    end
    return v2
end
v5 = next
local __index = u21.__index
v1 = nil
for k, v in v5, __index, v1 do
    v4 = string.lower(k)
    v3 = string.sub(v4, 1, 1)
    v2 = v3 .. string.sub(k, 2)
    u21.__index[v2] = v
end
return u21