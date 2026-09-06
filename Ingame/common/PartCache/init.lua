local Table = require(script:WaitForChild("Table"))
local u7 = {}
u7.__index = u7
u7.__type = "PartCache"
local u13 = CFrame.new(0, 1000000000, 0)
local function assertwarn(p1, p2) -- Line: 60
    if p1 == false then
        warn(p2)
    end
end
local function MakeFromTemplate(p1, p2) -- Line: 67 -- upvalues: u13 (val)
    local v1 = p1:Clone()
    v1.CFrame = u13
    v1.Anchored = true
    v1.Parent = p2
    return v1
end
function u7.new(p1, p2, p3) -- Line: 77 -- upvalues: u7 (val), Table (val), u13 (val)
    local Archivable, v1
    local v2 = p2 or 5
    local v3 = p3
    if not v3 then
        v3 = workspace
    end
    local v4 = 0 < v2
    assert(v4, "PrecreatedParts can not be negative!")
    local v5 = v2 ~= 0
    if not v5 then
        warn("PrecreatedParts is 0! This may have adverse effects when initially using the cache.")
    end
    if p1.Archivable == false then
        warn("The template's Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.")
    end
    Archivable = p1.Archivable
    p1.Archivable = true
    p1.Archivable = Archivable
    local v6 = p1:Clone()
    local v7 = {
        ExpansionSize = 10,
        Open = {},
        InUse = {},
        CurrentCacheParent = v3,
        Template = v6,
    }
    setmetatable(v7, u7)
    local v8 = v2
    local v9 = 1
    for i = 1, v8, v9 do
        v1 = v6:Clone()
        v1.CFrame = u13
        v1.Anchored = true
        v1.Parent = v7.CurrentCacheParent
        Table.insert(v7.Open, v1)
    end
    v7.Template.Parent = nil
    return v7
end
function u7.GetPart(p1) -- Line: 115 -- upvalues: u7 (val), Table (val), u13 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u7
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPart", "PartCache.new"))
    if #p1.Open == 0 then
        local v3
        local ExpansionSize = p1.ExpansionSize
        v2 = 1
        for i = 1, ExpansionSize, v2 do
            v3 = p1.Template:Clone()
            v3.CFrame = u13
            v3.Anchored = true
            v3.Parent = p1.CurrentCacheParent
            Table.insert(p1.Open, v3)
        end
    end
    local v4 = p1.Open[#p1.Open]
    p1.Open[#p1.Open] = nil
    Table.insert(p1.InUse, v4)
    return v4
end
function u7.ReturnPart(p1, p2) -- Line: 131 -- upvalues: u7 (val), Table (val), u13 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u7
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("ReturnPart", "PartCache.new"))
    local v3 = Table.indexOf(p1.InUse, p2)
    if v3 == nil then
        local Name = p2.Name
        local FullName = p2:GetFullName()
        error("Attempted to return part \"" .. Name .. "\" (" .. FullName .. ") to the cache, but it's not in-use! Did you call this on the wrong part?")
        return
    end
    Table.remove(p1.InUse, v3)
    Table.insert(p1.Open, p2)
    p2.CFrame = u13
    p2.Anchored = true
end
function u7.SetCacheParent(p1, p2) -- Line: 146 -- upvalues: u7 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u7
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetCacheParent", "PartCache.new"))
    v2 = p2:IsDescendantOf(workspace)
    if not v2 then
        v2 = p2 == workspace
    end
    assert(v2, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.")
    p1.CurrentCacheParent = p2
    local v3 = #p1.Open
    v2 = 1
    for i = 1, v3, v2 do
        p1.Open[i].Parent = p2
    end
    v3 = #p1.InUse
    v2 = 1
    for j = 1, v3, v2 do
        p1.InUse[j].Parent = p2
    end
end
function u7.Expand(p1, p2) -- Line: 160 -- upvalues: u7 (val), Table (val), u13 (val)
    local ExpansionSize, v1
    local v2 = getmetatable(p1)
    local v3 = v2 == u7
    assert(v3, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Expand", "PartCache.new"))
    if p2 ~= nil then
        ExpansionSize = p2
    else
        ExpansionSize = p1.ExpansionSize
    end
    local v4 = ExpansionSize
    v3 = 1
    for i = 1, v4, v3 do
        v1 = p1.Template:Clone()
        v1.CFrame = u13
        v1.Anchored = true
        v1.Parent = p1.CurrentCacheParent
        Table.insert(p1.Open, v1)
    end
end
function u7.Dispose(p1) -- Line: 172 -- upvalues: u7 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u7
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "PartCache.new"))
    local v3 = #p1.Open
    v2 = 1
    for i = 1, v3, v2 do
        p1.Open[i]:Destroy()
    end
    v3 = #p1.InUse
    v2 = 1
    for j = 1, v3, v2 do
        p1.InUse[j]:Destroy()
    end
    p1.Template:Destroy()
    p1.Open = {}
    p1.InUse = {}
    p1.CurrentCacheParent = nil
    p1.GetPart = nil
    p1.ReturnPart = nil
    p1.SetCacheParent = nil
    p1.Expand = nil
    p1.Dispose = nil
end
return u7