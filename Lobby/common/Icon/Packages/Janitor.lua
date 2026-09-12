local v1, v2
local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat

local function getPromiseReference() -- Line: 25 -- upvalues: RunService (val)
    if RunService:IsRunning() then
        return require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
end

local u9 = newproxy(true)
local v3 = getmetatable(u9)

function v3.__tostring() -- Line: 33
    return "IndicesReference"
end

local u16 = newproxy(true)
local v4 = getmetatable(u16)

function v4.__tostring() -- Line: 38
    return "LinkToInstanceIndex"
end

local u21 = {IGNORE_MEMORY_DEBUG = true, ClassName = "Janitor"}
local v5 = {CurrentlyCleaning = true}
v5[u9] = nil
u21.__index = v5
local u25 = {["function"] = true, Promise = "cancel", RBXScriptConnection = "Disconnect"}

function u21.new() -- Line: 64 -- upvalues: u9 (val), u21 (val)
    local v1 = {CurrentlyCleaning = false}
    v1[u9] = nil
    local v2 = u21
    return (setmetatable(v1, v2))
end

function u21.Is(p1) -- Line: 76 -- upvalues: u21 (val)
    local v1 = false
    if type(p1) == "table" then
        v1 = (getmetatable(p1)) == u21
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
            v1 = {}
            self[u9] = v1
        end
        v1[p4] = p2
    end
    v1 = typeof(p2)
    if v1 == "table" and string.match(tostring(p2), "Promise") then
        v1 = "Promise"
    end
    local v2 = p3
    if not v2 then
        v2 = u25[v1]
        if not v2 then
            v2 = "Destroy"
        end
    end
    local v3 = v2
    if type(p2) ~= "function" and not p2[v3] then
        warn(string.format(
            "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s",
            tostring(p2),
            tostring(v3),
            debug.traceback(nil, 2)
        ))
    end
    local v4 = {v3, (debug.traceback(""))}
    self[p2] = v4
    return p2
end

u21.__index.Give = u21.__index.Add

function u21.__index.AddPromise(p1, p2) -- Line: 126 -- upvalues: RunService (val)
    local Promise
    if not RunService:IsRunning() then
        Promise = nil
    else
        Promise = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
    if not Promise then
        return p2
    end
    if not Promise.is(p2) then
        error(string.format(
            "Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))",
            typeof(p2),
            (tostring(p2))
        ))
    end
    if (p2:getStatus()) ~= Promise.Status.Started then
        return p2
    end
    local v1 = newproxy(false)
    local v2 = Promise.new(function(p1, p2_2, p3) -- Line: 134 -- upvalues: p2 (val)
        if p3(function() -- Line: 135 -- upvalues: p2 (upval)
            local v0, v1
            p2:cancel()
            return
        end) then
            return
        end
        p1(p2)
    end)
    local v3 = p1:Add(v2, "cancel", v1)
    local Remove = p1.Remove
    v3:finallyCall(Remove, p1, v1)
    return v3
end

u21.__index.GivePromise = u21.__index.AddPromise

function u21.__index.AddObject(p1, p2) -- Line: 156 -- upvalues: RunService (val)
    local Promise
    local v1 = newproxy(false)
    if not RunService:IsRunning() then
        Promise = nil
    else
        Promise = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
    if Promise and Promise.is(p2) then
        if (p2:getStatus()) ~= Promise.Status.Started then
            return p2
        end
        local v2 = Promise.resolve(p2)
        local v3 = p1:Add(v2, "cancel", v1)
        local Remove = p1.Remove
        v3:finallyCall(Remove, p1, v1)
        return v3, v1
    end
    return (p1:Add(p2, false, v1)), v1
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
        local result, result_2, success, success_2, v1, v2, v3, v4, v5, v6, warnUser
        self.CurrentlyCleaning = nil
        local v7 = next
        local v8 = self
        local v9 = nil
        local v10 = self
        for k, v in v7, v8, v9 do
            if k ~= u9 then
                v5 = type(k)
                if v5 == "string" then
                    v10[k] = nil
                elseif v5 ~= "number" then
                    v6 = v[1]
                    local u37 = v[2]

                    function warnUser(p1) -- Line: 241 -- upvalues: u37 (val)
                        local v1 = debug.traceback("", 3)
                        local v2 = u37
                        warn("-------- Janitor Error --------" .. "\n" .. (tostring(p1)) .. "\n" .. v1 .. "" .. v2)
                    end

                    if v6 ~= true then
                        v1 = k[v6]
                        if v1 then
                            success_2, result_2 = pcall(v1, k)
                            v3 = false
                            if typeof(k) == "Instance" then
                                v3 = v1 == "Destroy"
                            end
                            if not success_2 and not v3 then
                                v4 = debug.traceback("", 3)
                                warn("-------- Janitor Error --------" .. "\n" .. (tostring(result_2)) .. "\n" .. v4 .. "" .. u37)
                            end
                        end
                    else
                        success, result = pcall(k)
                        if not success then
                            v2 = debug.traceback("", 3)
                            warn("-------- Janitor Error --------" .. "\n" .. (tostring(result)) .. "\n" .. v2 .. "" .. u37)
                        end
                    end
                    v10[k] = nil
                else
                    v10[k] = nil
                end
            end
        end
        v7 = v10[u9]
        if v7 then
            v8 = next
            v9 = v7
            local v11 = nil
            for k2 in v8, v9, v11 do
                v7[k2] = nil
            end
            v10[u9] = {}
        end
        v10.CurrentlyCleaning = false
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
    local Connected = p1.Connected
    return "Disconnect<" .. (tostring(Connected)) .. ">"
end

function u21.__index:LinkToInstance(p2, p3) -- Line: 315 -- upvalues: u16 (val), u60 (val), Heartbeat (val)
    local v1
    local u3 = nil
    if not p3 then
        v1 = u16
    else
        v1 = newproxy(false)
        if not v1 then
            v1 = u16
        end
    end
    local u12 = p2.Parent == nil
    local v2 = u60
    local u16_2 = setmetatable({}, v2)
    u3 = p2.AncestryChanged:Connect(function(p1, p2) -- Line: 321 -- upvalues: u16_2 (val), u12 (ref), Heartbeat (upval), u3 (ref), self (val)
        if u16_2.Connected then
            local v1 = p2 == nil
            u12 = v1
            if u12 then
                coroutine.wrap(function() -- Line: 327 -- upvalues: Heartbeat (upval), u16_2 (upval), u3 (upval), self (upval), u12 (upval)
                    Heartbeat:Wait()
                    if not u16_2.Connected then
                        return
                    end
                    if not u3.Connected then
                        self:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16_2.Connected then
                            break
                        end
                        Heartbeat:Wait()
                    end
                    if u16_2.Connected and u12 then
                        self:Cleanup()
                    end
                end)()
            end
        end
    end)
    u16_2.Connection = u3
    if u12 then
        local Parent = p2.Parent
        if u16_2.Connected then
            u12 = Parent == nil
            if u12 then
                coroutine.wrap(function() -- Line: 327 -- upvalues: Heartbeat (upval), u16_2 (val), u3 (ref), self (val), u12 (ref)
                    Heartbeat:Wait()
                    if not u16_2.Connected then
                        return
                    end
                    if not u3.Connected then
                        self:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16_2.Connected then
                            break
                        end
                        Heartbeat:Wait()
                    end
                    if u16_2.Connected and u12 then
                        self:Cleanup()
                    end
                end)()
            end
        end
    end
    v2 = self:Add(u16_2, "Disconnect", v1)
    return v2
end

function u21.__index.LinkToInstances(p1, ...) -- Line: 363 -- upvalues: u21 (val)
    local v1
    local v2 = u21.new()
    local v3 = ipairs
    local v4 = {...}
    for i, v in v3(v4) do
        v1 = p1:LinkToInstance(v, true)
        v2:Add(v1, "Disconnect")
    end
    return v2
end

local v6 = next
local __index = u21.__index
local v7 = nil
for k, v in v6, __index, v7 do
    v2 = string.lower(k)
    v1 = (string.sub(v2, 1, 1)) .. string.sub(k, 2)
    u21.__index[v1] = v
end
return u21