local u0 = {}
local u4 = setmetatable({}, {__mode = "k"})

local function disconnect(p1) -- Line: 5
    if p1.Connection then
        p1.Connection:Disconnect()
        p1.Connection = nil
    end
end

local function isAppearanceItem(p1) -- Line: 12
    local v1 = p1:IsA("Accessory")
    if not v1 then
        v1 = true
        if p1.ClassName ~= "Hat" then
            v1 = p1:IsA("Shirt")
            if not v1 then
                v1 = p1:IsA("Pants")
                if not v1 then
                    v1 = p1:IsA("ShirtGraphic")
                    if not v1 then
                        v1 = p1:IsA("CharacterMesh")
                    end
                end
            end
        end
    end
    return v1
end

local function shouldBlock(p1, p2) -- Line: 21 -- upvalues: isAppearanceItem (val)
    if p1.Allowed[p2] then
        return false
    end
    if p1.Mode == "Strict" then
        return (isAppearanceItem(p2))
    end
    if p1.Mode ~= "ClothingOnly" then
        return false
    end
    local v1 = p2:IsA("Shirt")
    if not v1 then
        v1 = p2:IsA("Pants")
        if not v1 then
            v1 = p2:IsA("ShirtGraphic")
            if not v1 then
                v1 = p2:IsA("CharacterMesh")
            end
        end
    end
    return v1
end

local function connect(p1) -- Line: 35 -- upvalues: u4 (val), shouldBlock (val)
    if p1.Connection then
        p1.Connection:Disconnect()
        p1.Connection = nil
    end
    if p1.Mode ~= "Off" and not p1.Cancelled and u4[p1.Character] == p1 then
        local ChildAdded = p1.Character.ChildAdded
        p1.Connection = ChildAdded:Connect(function(p1_2) -- Line: 41 -- upvalues: p1 (val), u4 (upval), shouldBlock (upval)
            task.delay(0.1, function() -- Line: 42 -- upvalues: p1 (upval), u4 (upval), p1_2 (val), shouldBlock (upval)
                if not p1.Cancelled and u4[p1.Character] == p1 and p1_2.Parent == p1.Character then
                    if shouldBlock(p1, p1_2) then
                        p1_2:Destroy()
                    end
                    return
                end
            end)
        end)
        return
    end
end

function u0.Begin(p1) -- Line: 53 -- upvalues: u4 (val)
    local v1 = u4[p1]
    if v1 then
        v1.Cancelled = true
        if v1.Connection then
            v1.Connection:Disconnect()
            v1.Connection = nil
        end
    end
    local v2 = {Cancelled = false, Mode = "Off", Character = p1, Allowed = setmetatable({}, {__mode = "k"})}
    u4[p1] = v2
    return v2
end

function u0.IsCurrent(p1) -- Line: 71 -- upvalues: u4 (val)
    local v1 = false
    if p1 ~= nil then
        v1 = not p1.Cancelled
        if v1 then
            v1 = u4[p1.Character] == p1
        end
    end
    return v1
end

function u0.Allow(p1, p2) -- Line: 75 -- upvalues: u0 (val)
    if u0.IsCurrent(p1) and p2 then
        p1.Allowed[p2] = true
    end
end

function u0.AllowCurrent(p1, p2) -- Line: 81 -- upvalues: u0 (val), u4 (val)
    local v1 = u0
    v1.Allow(u4[p1], p2)
end

function u0.Arm(p1, p2) -- Line: 85 -- upvalues: u0 (val), connect (val)
    local v1 = true
    if p2 ~= "Off" then
        v1 = true
        if p2 ~= "Strict" then
            v1 = p2 == "ClothingOnly"
        end
    end
    assert(v1, "Invalid outfit watcher mode")
    if not u0.IsCurrent(p1) then
        return
    end
    p1.Mode = p2
    connect(p1)
end

function u0.Suspend(p1) -- Line: 95 -- upvalues: u0 (val)
    if u0.IsCurrent(p1) and p1.Connection then
        p1.Connection:Disconnect()
        p1.Connection = nil
    end
end

function u0.Resume(p1) -- Line: 101 -- upvalues: u0 (val), connect (val)
    if u0.IsCurrent(p1) then
        connect(p1)
    end
end

function u0.Finish(p1) -- Line: 107 -- upvalues: u4 (val)
    if not p1 then
        return
    end
    if p1.Connection then
        p1.Connection:Disconnect()
        p1.Connection = nil
    end
    if u4[p1.Character] == p1 then
        u4[p1.Character] = nil
    end
    p1.Cancelled = true
end

function u0.FinishAfter(p1, p2) -- Line: 119 -- upvalues: u0 (val)
    task.delay(p2, function() -- Line: 120 -- upvalues: u0 (upval), p1 (val)
        if u0.IsCurrent(p1) then
            u0.Finish(p1)
        end
    end)
end

function u0.Cancel(p1) -- Line: 127 -- upvalues: u4 (val), u0 (val)
    local v1 = u4[p1]
    if v1 then
        u0.Finish(v1)
    end
end

return u0