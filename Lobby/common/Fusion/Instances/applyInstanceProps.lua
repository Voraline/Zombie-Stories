local Parent = script.Parent.Parent
require(Parent.PubTypes)
local cleanup = require(Parent.Utility.cleanup)
local xtypeof = require(Parent.Utility.xtypeof)
local logError = require(Parent.Logging.logError)
local Observer = require(Parent.State.Observer)
local function setProperty_unsafe(p1, p2, p3) -- Line: 23
    p1[p2] = p3
end
local function testPropertyAssignable(p1, p2) -- Line: 27
    p1[p2] = p1[p2]
end
local function setProperty(p1, p2, p3) -- Line: 31 -- upvalues: setProperty_unsafe (val), testPropertyAssignable (val), logError (val)
    if pcall(setProperty_unsafe, p1, p2, p3) then
        return
    end
    if pcall(testPropertyAssignable, p1, p2) then
        local v1 = typeof(p3)
        local v2 = typeof(p1[p2])
        logError("invalidPropertyType", nil, p1.ClassName, p2, v2, v1)
        return
    end
    if p1 == nil then
        logError("setPropertyNilRef", nil, p2, (tostring(p3)))
        return
    end
    logError("cannotAssignProperty", nil, p1.ClassName, p2)
end
local function bindProperty(p1, p2, p3, p4) -- Line: 51 -- upvalues: xtypeof (val), setProperty (val), Observer (val)
    if xtypeof(p3) ~= "State" then
        setProperty(p1, p2, p3)
        return
    end
    local u7 = false
    setProperty(p1, p2, p3:get(false))
    table.insert(p4, Observer(p3):onChange(function() -- Line: 55 -- upvalues: u7 (ref), setProperty (upval), p1 (val), p2 (val), p3 (val)
        if not u7 then
            u7 = true
            task.defer(function() -- Line: 58 -- upvalues: u7 (upval), setProperty (upval), p1 (upval), p2 (upval), p3 (upval)
                u7 = false
                setProperty(p1, p2, p3:get(false))
            end)
        end
    end))
end
return function(p1, p2) -- Line: 73 -- upvalues: xtypeof (val), bindProperty (val), logError (val), cleanup (val)
    local stage, v1, v2
    local v3 = {self = {}, descendants = {}, ancestor = {}, observer = {}}
    local u7 = {}
    for k, v in pairs(p1) do
        v2 = xtypeof(k)
        if v2 ~= "string" then
            if v2 ~= "SpecialKey" then
                logError("unrecognisedPropertyKey", nil, xtypeof(k))
            else
                stage = k.stage
                v1 = v3[stage]
                if v1 ~= nil then
                    v1[k] = v
                else
                    logError("unrecognisedPropertyStage", nil, stage)
                end
            end
        elseif k ~= "Parent" then
            bindProperty(p2, k, v, u7)
        end
    end
    for k2, i in pairs(v3.self) do
        k2:apply(i, p2, u7)
    end
    for k3, j in pairs(v3.descendants) do
        k3:apply(j, p2, u7)
    end
    if p1.Parent ~= nil then
        bindProperty(p2, "Parent", p1.Parent, u7)
    end
    for k4, k5 in pairs(v3.ancestor) do
        k4:apply(k5, p2, u7)
    end
    for k6, n in pairs(v3.observer) do
        k6:apply(n, p2, u7)
    end
    p2.Destroying:Connect(function() -- Line: 121 -- upvalues: cleanup (upval), u7 (val)
        cleanup(u7)
    end)
end