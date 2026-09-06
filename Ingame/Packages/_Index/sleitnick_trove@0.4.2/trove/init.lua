local u1 = newproxy()
local u3 = newproxy()
local RunService = game:GetService("RunService")
local function GetObjectCleanupFunction(p1, p2) -- Line: 10 -- upvalues: u1 (val), u3 (val)
    local v1
    local v2 = typeof(p1)
    if v2 == "function" then
        return u1
    end
    if v2 == "thread" then
        return u3
    end
    if p2 then
        return p2
    end
    if v2 == "Instance" then
        return "Destroy"
    end
    if v2 == "RBXScriptConnection" then
        return "Disconnect"
    end
    if v2 ~= "table" then
        v1 = "Failed to get cleanup function for object " .. v2 .. ": " .. tostring(p1)
        error(v1, 3)
        return
    end
    if typeof(p1.Destroy) == "function" then
        return "Destroy"
    end
    if typeof(p1.Disconnect) == "function" then
        return "Disconnect"
    end
    v1 = "Failed to get cleanup function for object " .. v2 .. ": " .. tostring(p1)
    error(v1, 3)
end
local function AssertPromiseLike(p1) -- Line: 34
    if type(p1) ~= "table" then
        error("Did not receive a Promise as an argument", 3)
    elseif type(p1.getStatus) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    elseif type(p1.finally) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    elseif type(p1.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    end
end
local u11 = {}
u11.__index = u11
function u11.new() -- Line: 57 -- upvalues: u11 (val)
    local v1 = setmetatable({}, u11)
    v1._objects = {}
    return v1
end
function u11.Extend(p1) -- Line: 82 -- upvalues: u11 (val)
    return p1:Construct(u11)
end
function u11:Clone(p2) -- Line: 90
    return self:Add(p2:Clone())
end
function u11:Construct(p2, ...) -- Line: 127
    local v1 = nil
    local v2 = type(p2)
    if v2 == "table" then
        v1 = p2.new(...)
    elseif v2 == "function" then
        v1 = p2(...)
    end
    return self:Add(v1)
end
function u11:Connect(p2, p3) -- Line: 153
    return self:Add(p2:Connect(p3))
end
function u11:BindToRenderStep(p2, p3, p4) -- Line: 170 -- upvalues: RunService (val)
    RunService:BindToRenderStep(p2, p3, p4)
    self:Add(function() -- Line: 172 -- upvalues: RunService (upval), p2 (val)
        RunService:UnbindFromRenderStep(p2)
    end)
end
function u11.AddPromise(p1, p2) -- Line: 200
    if type(p2) ~= "table" then
        error("Did not receive a Promise as an argument", 3)
    elseif type(p2.getStatus) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    elseif type(p2.finally) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    elseif type(p2.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    end
    if p2:getStatus() == "Started" then
        p2:finally(function() -- Line: 203 -- upvalues: p1 (val), p2 (val)
            return p1:_findAndRemoveFromObjects(p2, false)
        end)
        p1:Add(p2, "cancel")
    end
    return p2
end
function u11:Add(p2, p3) -- Line: 259 -- upvalues: GetObjectCleanupFunction (val)
    local v1 = GetObjectCleanupFunction(p2, p3)
    table.insert(self._objects, {p2, v1})
    return p2
end
function u11.Remove(p1, p2) -- Line: 275
    return p1:_findAndRemoveFromObjects(p2, true)
end
function u11:Clean() -- Line: 284
    for i, v in ipairs(self._objects) do
        self:_cleanupObject(v[1], v[2])
    end
    table.clear(self._objects)
end
function u11:_findAndRemoveFromObjects(p2, p3) -- Line: 291
    local v1
    local _objects = self._objects
    for i, v in ipairs(_objects) do
        if v[1] == p2 then
            v1 = #_objects
            _objects[i] = _objects[v1]
            _objects[v1] = nil
            if p3 then
                self:_cleanupObject(v[1], v[2])
            end
            return true
        end
    end
    return false
end
function u11._cleanupObject(p1, p2, p3) -- Line: 307 -- upvalues: u1 (val), u3 (val)
    if p3 == u1 then
        p2()
        return
    end
    if p3 == u3 then
        coroutine.close(p2)
        return
    end
    p2[p3](p2)
end
function u11.AttachToInstance(p1, p2) -- Line: 330
    local v1 = p2:IsDescendantOf(game)
    assert(v1, "Instance is not a descendant of the game hierarchy")
    return p1:Connect(p2.Destroying, function() -- Line: 332 -- upvalues: p1 (val)
        p1:Destroy()
    end)
end
function u11:Destroy() -- Line: 340
    self:Clean()
end
return u11