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
    local CurrentCacheParent, Open, insert, v1, v2
    local v3 = p2 or 5
    local v4 = p3 or workspace
    local v5 = 0 < v3
    assert(v5, "PrecreatedParts can not be negative!")
    local v6 = v3 ~= 0
    if not v6 then
        warn("PrecreatedParts is 0! This may have adverse effects when initially using the cache.")
    end
    if p1.Archivable == false then
        warn("The template's Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.")
    end
    local Archivable = p1.Archivable
    p1.Archivable = true
    v5 = p1:Clone()
    p1.Archivable = Archivable
    local v7 = v5
    local v8 = {ExpansionSize = 10, Open = {}, InUse = {}}
    v8.CurrentCacheParent = v4
    v8.Template = v7
    local v9 = u7
    setmetatable(v8, v9)
    local v10 = v3
    for i = 1, v10 do
        v1 = Table
        insert = v1.insert
        Open = v8.Open
        CurrentCacheParent = v8.CurrentCacheParent
        v2 = v7:Clone()
        v2.CFrame = u13
        v2.Anchored = true
        v2.Parent = CurrentCacheParent
        insert(Open, v2)
    end
    v8.Template.Parent = nil
    return v8
end

function u7.GetPart(p1) -- Line: 115 -- upvalues: u7 (val), Table (val), u13 (val)
    local v1 = (getmetatable(p1)) == u7
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "GetPart",
        "PartCache.new"
    )
    assert(v1, v2)
    if #p1.Open == 0 then
        local CurrentCacheParent, Open, Template, insert, v3, v4
        local ExpansionSize = p1.ExpansionSize
        for i = 1, ExpansionSize do
            v3 = Table
            insert = v3.insert
            Open = p1.Open
            Template = p1.Template
            CurrentCacheParent = p1.CurrentCacheParent
            v4 = Template:Clone()
            v4.CFrame = u13
            v4.Anchored = true
            v4.Parent = CurrentCacheParent
            insert(Open, v4)
        end
    end
    local v5 = p1.Open[#p1.Open]
    local Open_2 = p1.Open
    v2 = #p1.Open
    Open_2[v2] = nil
    Table.insert(p1.InUse, v5)
    return v5
end

function u7.ReturnPart(p1, p2) -- Line: 131 -- upvalues: u7 (val), Table (val), u13 (val)
    local v1 = (getmetatable(p1)) == u7
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "ReturnPart",
        "PartCache.new"
    )
    assert(v1, v2)
    local v3 = Table.indexOf(p1.InUse, p2)
    if v3 == nil then
        error("Attempted to return part \"" .. p2.Name .. "\" (" .. (p2:GetFullName()) .. ") to the cache, but it's not in-use! Did you call this on the wrong part?")
        return
    end
    Table.remove(p1.InUse, v3)
    Table.insert(p1.Open, p2)
    p2.CFrame = u13
    p2.Anchored = true
end

function u7.SetCacheParent(p1, p2) -- Line: 146 -- upvalues: u7 (val)
    local v1 = (getmetatable(p1)) == u7
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "SetCacheParent",
        "PartCache.new"
    )
    assert(v1, v2)
    local v3 = workspace
    v1 = p2:IsDescendantOf(v3)
    if not v1 then
        v1 = p2 == workspace
    end
    assert(
        v1,
        "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world."
    )
    p1.CurrentCacheParent = p2
    local v4 = #p1.Open
    for i = 1, v4 do
        p1.Open[i].Parent = p2
    end
    v4 = #p1.InUse
    for j = 1, v4 do
        p1.InUse[j].Parent = p2
    end
end

function u7.Expand(p1, p2) -- Line: 160 -- upvalues: u7 (val), Table (val), u13 (val)
    local CurrentCacheParent, ExpansionSize, Open, Template, insert, v1, v2
    local v3 = (getmetatable(p1)) == u7
    local v4 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Expand",
        "PartCache.new"
    )
    assert(v3, v4)
    if p2 ~= nil then
        ExpansionSize = p2
    else
        ExpansionSize = p1.ExpansionSize
    end
    local v5 = ExpansionSize
    for i = 1, v5 do
        v2 = Table
        insert = v2.insert
        Open = p1.Open
        Template = p1.Template
        CurrentCacheParent = p1.CurrentCacheParent
        v1 = Template:Clone()
        v1.CFrame = u13
        v1.Anchored = true
        v1.Parent = CurrentCacheParent
        insert(Open, v1)
    end
end

function u7.Dispose(p1) -- Line: 172 -- upvalues: u7 (val)
    local v1 = (getmetatable(p1)) == u7
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Dispose",
        "PartCache.new"
    )
    assert(v1, v2)
    local v3 = #p1.Open
    for i = 1, v3 do
        p1.Open[i]:Destroy()
    end
    v3 = #p1.InUse
    for j = 1, v3 do
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