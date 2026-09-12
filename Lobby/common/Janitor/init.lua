local v1 = require("@self/GetPromiseLibrary")
local u5 = require("@self/RbxScriptConnection")
local v2 = require("@self/Symbol")
local u10, u11 = v1()
local IndicesReference = v2("IndicesReference")
local LinkToInstanceIndex = v2("LinkToInstanceIndex")
local u18 = {ClassName = "Janitor", CurrentlyCleaning = true}
u18[IndicesReference] = nil
u18.__index = u18
local u22 = {["function"] = true, thread = true, RBXScriptConnection = "Disconnect"}

function u18.new() -- Line: 53 -- upvalues: IndicesReference (val), u18 (val)
    local v1 = {CurrentlyCleaning = false}
    v1[IndicesReference] = nil
    local v2 = u18
    return (setmetatable(v1, v2))
end

function u18.Is(p1) -- Line: 66 -- upvalues: u18 (val)
    local v1 = false
    if type(p1) == "table" then
        v1 = (getmetatable(p1)) == u18
    end
    return v1
end

function u18:Add(p2, p3, p4) -- Line: 150 -- upvalues: IndicesReference (val), u22 (val)
    local v1
    if p4 then
        self:Remove(p4)
        v1 = self[IndicesReference]
        if not v1 then
            v1 = {}
            self[IndicesReference] = v1
        end
        v1[p4] = p2
    end
    v1 = typeof(p2)
    local v2 = p3
    if not v2 then
        v2 = u22[v1]
        if not v2 then
            v2 = "Destroy"
        end
    end
    if v1 == "function" then
        if v2 ~= true then
            warn(string.format(
                "Object is a %s and as such expected `true?` for the method name and instead got %s. Traceback: %s",
                v1,
                tostring(v2),
                debug.traceback(nil, 2)
            ))
        end
    elseif v1 ~= "thread" then
        if not p2[v2] then
            warn(string.format(
                "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s",
                tostring(p2),
                tostring(v2),
                debug.traceback(nil, 2)
            ))
        end
    elseif v2 ~= true then
        warn(string.format(
            "Object is a %s and as such expected `true?` for the method name and instead got %s. Traceback: %s",
            v1,
            tostring(v2),
            debug.traceback(nil, 2)
        ))
    end
    self[p2] = v2
    return p2
end

function u18.AddPromise(p1, p2) -- Line: 206 -- upvalues: u10 (val), u11 (val)
    if not u10 then
        return p2
    end
    if not u11.is(p2) then
        error(string.format(
            "Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s)) Traceback: %s",
            typeof(p2),
            tostring(p2),
            debug.traceback(nil, 2)
        ))
    end
    if (p2:getStatus()) ~= u11.Status.Started then
        return p2
    end
    local v1 = newproxy(false)
    local v2 = u11
    v2 = v2.new(function(p1, p2_2, p3) -- Line: 214 -- upvalues: p2 (val)
        if p3(function() -- Line: 215 -- upvalues: p2 (upval)
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

function u18:Remove(p2) -- Line: 259 -- upvalues: IndicesReference (val)
    local v1 = self[IndicesReference]
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
                elseif type(v2) ~= "function" then
                    task.cancel(v2)
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

function u18.RemoveList(p1, ...) -- Line: 333 -- upvalues: IndicesReference (val)
    local v1
    local v2 = p1[IndicesReference]
    if not v2 then
        v1 = p1
    else
        local v3, v4, v5
        local v6 = select("#", ...)
        if v6 == 1 then
            return p1:Remove(...)
        end
        local v7 = v6
        v1 = p1
        for i = 1, v7 do
            v3 = v2[select(i, ...)]
            if v3 then
                v4 = v1[v3]
                if v4 then
                    if v4 ~= true then
                        v5 = v3[v4]
                        if v5 then
                            v5(v3)
                        end
                    elseif type(v3) ~= "function" then
                        task.cancel(v3)
                    else
                        v3()
                    end
                    v1[v3] = nil
                end
                v2[i] = nil
            end
        end
    end
    return v1
end

function u18.Get(p1, p2) -- Line: 397 -- upvalues: IndicesReference (val)
    local v1 = p1[IndicesReference]
    if v1 then
        return v1[p2]
    end
    return nil
end

local function GetFenv(p1) -- Line: 402 -- upvalues: IndicesReference (val)
    return function() -- Line: 403 -- upvalues: p1 (val), IndicesReference (upval)
        local v1 = next
        local v2 = p1
        local v3 = nil
        for k, v in v1, v2, v3 do
            if k ~= IndicesReference then
                return k, v
            end
        end
    end
end

function u18:Cleanup() -- Line: 429 -- upvalues: IndicesReference (val)
    if not self.CurrentlyCleaning then
        local v1, v2
        self.CurrentlyCleaning = nil

        local function v3() -- Line: 403 -- upvalues: self (val), IndicesReference (upval)
            local v1 = next
            local v2 = self
            local v3 = nil
            for k, v in v1, v2, v3 do
                if k ~= IndicesReference then
                    return k, v
                end
            end
        end

        local v4, v5 = v3()
        while v4 do
            if not v5 then
                break
            end
            if v5 ~= true then
                v1 = v4[v5]
                if v1 then
                    v1(v4)
                end
            elseif type(v4) ~= "function" then
                task.cancel(v4)
            else
                v4()
            end
            self[v4] = nil
            v1, v2 = v3()
            v4 = v1
            v5 = v2
        end
        v1 = self[IndicesReference]
        if v1 then
            table.clear(v1)
            self[IndicesReference] = {}
        end
        self.CurrentlyCleaning = false
    end
end

function u18.Destroy(p1) -- Line: 471
    p1:Cleanup()
    table.clear(p1)
    setmetatable(p1, nil)
end

u18.__call = u18.Cleanup

function u18:LinkToInstance(p2, p3) -- Line: 520 -- upvalues: LinkToInstanceIndex (val)
    local v1
    if not p3 then
        v1 = LinkToInstanceIndex
    else
        v1 = newproxy(false)
        if not v1 then
            v1 = LinkToInstanceIndex
        end
    end
    local v2 = p2.Destroying:Connect(function() -- Line: 523 -- upvalues: self (val)
        self:Cleanup()
    end)
    return self:Add(v2, "Disconnect", v1)
end

function u18.LegacyLinkToInstance(p1, p2, p3) -- Line: 573 -- upvalues: LinkToInstanceIndex (val), u5 (val)
    local v1
    local u3 = nil
    if not p3 then
        v1 = LinkToInstanceIndex
    else
        v1 = newproxy(false)
        if not v1 then
            v1 = LinkToInstanceIndex
        end
    end
    local u12 = p2.Parent == nil
    local v2 = u5
    local u16 = setmetatable({}, v2)
    u3 = p2.AncestryChanged:Connect(function(p1_2, p2) -- Line: 579 -- upvalues: u16 (val), u12 (ref), u3 (ref), p1 (val)
        if u16.Connected then
            local v1 = p2 == nil
            u12 = v1
            if u12 then
                task.defer(function() -- Line: 585 -- upvalues: u16 (upval), u3 (upval), p1 (upval), u12 (upval)
                    if not u16.Connected then
                        return
                    end
                    if not u3.Connected then
                        p1:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16.Connected then
                            break
                        end
                        task.wait()
                    end
                    if u16.Connected and u12 then
                        p1:Cleanup()
                    end
                end)
            end
        end
    end)
    u16.Connection = u3
    if u12 then
        local Parent = p2.Parent
        if u16.Connected then
            u12 = Parent == nil
            if u12 then
                task.defer(function() -- Line: 585 -- upvalues: u16 (val), u3 (ref), p1 (val), u12 (ref)
                    if not u16.Connected then
                        return
                    end
                    if not u3.Connected then
                        p1:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16.Connected then
                            break
                        end
                        task.wait()
                    end
                    if u16.Connected and u12 then
                        p1:Cleanup()
                    end
                end)
            end
        end
    end
    v2 = p1:Add(u16, "Disconnect", v1)
    return v2
end

function u18.LinkToInstances(p1, ...) -- Line: 621 -- upvalues: u18 (val)
    local v1
    local v2 = u18.new()
    local v3 = ipairs
    local v4 = {...}
    for i, v in v3(v4) do
        v1 = p1:LinkToInstance(v, true)
        v2:Add(v1, "Disconnect")
    end
    return v2
end

function u18.__tostring(p1) -- Line: 630
    return "Janitor"
end

table.freeze(u18)
return u18