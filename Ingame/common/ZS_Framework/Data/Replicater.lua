local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u7 = require("./PlayerDatabase")
local v1 = require("@game/ReplicatedStorage/common/zap")
local peek = require(ReplicatedStorage.Packages.Fusion).peek
local u16 = {}

function u16.SplitPath(p1) -- Line: 11
    local v1 = {}
    for i in string.gmatch(p1, "[^.]+") do
        table.insert(v1, i)
    end
    return v1
end

local function findPosition(p1) -- Line: 19 -- upvalues: u7 (val), u16 (val)
    local v1 = p1:gsub("Public.", ""):gsub("Profile.", "")
    local v2 = u7
    if v2 == nil then
        return nil
    end
    local v3 = u16.SplitPath(v1)
    local v4 = v2
    for i, v in ipairs(v3) do
        if v4 == nil then
            return nil
        end
        v4 = v4[v]
    end
    return v4
end

v1.UpdateValue.On(function(p1) -- Line: 42 -- upvalues: findPosition (val)
    local path = p1.path
    local value = p1.value
    local v1 = findPosition(path)
    if not v1 or v1.type ~= "State" then
        return
    end
    v1:set(value)
end)
v1.RemoveIndex.On(function(p1) -- Line: 59 -- upvalues: findPosition (val), peek (val)
    local path = p1.path
    local index = p1.index
    local v1 = findPosition(path)
    if not v1 then
        return
    end
    if v1.type ~= "State" then
        table.remove(v1, index)
        return
    end
    local v2 = peek(v1)
    table.remove(v2, index)
    v1:set(v2)
end)
v1.InsertIndex.On(function(p1) -- Line: 78 -- upvalues: findPosition (val), peek (val)
    local path = p1.path
    local index = p1.index
    local value = p1.value
    local v1 = findPosition(path)
    if not v1 then
        return
    end
    if v1.type ~= "State" then
        table.insert(v1, index, value)
        return
    end
    local v2 = peek(v1)
    table.insert(v2, index, value)
    v1:set(v2)
end)
v1.InsertKey.On(function(p1) -- Line: 98 -- upvalues: findPosition (val), peek (val)
    local path = p1.path
    local key = p1.key
    local value = p1.value
    local v1 = findPosition(path)
    if not v1 then
        return
    end
    if v1.type ~= "State" then
        v1[key] = value
        return
    end
    local v2 = peek(v1)
    v2[key] = value
    v1:set(v2)
end)
v1.RemoveKey.On(function(p1) -- Line: 118 -- upvalues: findPosition (val), peek (val)
    local path = p1.path
    local key = p1.key
    local v1 = findPosition(path)
    if not v1 then
        return
    end
    if v1.type ~= "State" then
        v1[key] = nil
        return
    end
    local v2 = peek(v1)
    v2[key] = nil
    v1:set(v2)
end)
return u16