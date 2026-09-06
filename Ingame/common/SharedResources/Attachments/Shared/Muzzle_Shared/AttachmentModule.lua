local u0 = {}
u0.__index = u0
function u0.new(p1, p2) -- Line: 4 -- upvalues: u0 (val)
    local v1 = {}
    setmetatable(v1, u0)
    v1.SettingChanges = {HasSuppressor = false}
    if p2.MuzzleModule and p2.MuzzleModule == "Smoke" then
        p2.MuzzleModule = "Rifle"
    end
    v1.AttModel = p1
    local NewBarrel = p1
    if NewBarrel then
        NewBarrel = p1:WaitForChild("NewBarrel", 2)
    end
    if NewBarrel then
        local Attachment = Instance.new("Attachment")
        Attachment.Name = "BarrelAttachment"
        Attachment.Parent = NewBarrel
        v1.SettingChanges.BarrelAttachment = Attachment
    end
    return v1
end
return u0