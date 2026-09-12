local u0 = {}
u0.__index = u0
local u1 = {}
local u2 = {}

function u0.new(p1, p2, p3, p4) -- Line: 7 -- upvalues: u0 (val)
    local v1 = {SubMenus = {}, CloseWithParent = p2 or false, UI = p1, IsOpen = p4}
    local v2 = u0
    setmetatable(v1, v2)
    if p3 then
        v1:SetZone(p3)
    end
    return v1
end

function u0.closeByZone(p1) -- Line: 23 -- upvalues: u1 (val), u2 (val)
    if u1[p1] then
        for k, v in pairs(u1[p1]) do
            if v.IsOpen then
                v.IsOpen = false
                v:Close()
            end
        end
    end
    if u2[p1] then
        for k2, i in pairs(u2[p1]) do
            i.Visible = false
        end
    end
end

function u0.hideWhenZoneClosed(p1, p2) -- Line: 39 -- upvalues: u2 (val)
    if not u2[p2] then
        u2[p2] = {}
    end
    local v1 = u2[p2]
    table.insert(v1, p1)
end

function u0.SetOpenFunction(p1, p2) -- Line: 48
    p1.OpenFunction = p2
end

function u0.SetCloseFunction(p1, p2) -- Line: 52
    p1.CloseFunction = p2
end

function u0.Open(p1) -- Line: 56
    if p1.OpenFunction then
        p1.IsOpen = true
        p1.OpenFunction()
    end
end

function u0:Close() -- Line: 63
    if self.CloseFunction then
        self.IsOpen = false
        self.CloseFunction()
    end
    for k, v in pairs(self.SubMenus) do
        if v.CloseWithParent then
            self.IsOpen = false
            v:Close()
        end
    end
end

function u0.AddSubMenu(p1, p2) -- Line: 76
    local SubMenus = p1.SubMenus
    table.insert(SubMenus, p2)
end

function u0:SetZone(p2) -- Line: 80 -- upvalues: u1 (val)
    self.Zone = p2
    if not u1[p2] then
        u1[p2] = {}
    end
    local v1 = u1[p2]
    table.insert(v1, self)
end

function u0.SetUI(p1, p2) -- Line: 86
    p1.UI = p2
end

function u0.GetUI(p1) -- Line: 90
    return p1.UI
end

return u0