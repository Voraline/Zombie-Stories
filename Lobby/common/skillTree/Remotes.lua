local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = {}
local u6 = nil
local function getOrCreateRemote(p1) -- Line: 11 -- upvalues: u6 (ref), ReplicatedStorage (val)
    if not u6 then
        u6 = ReplicatedStorage:FindFirstChild("SkillTreeRemotes")
        if not u6 then
            u6 = Instance.new("Folder")
            u6.Name = "SkillTreeRemotes"
            u6.Parent = ReplicatedStorage
        end
    end
    local v1 = u6:FindFirstChild(p1)
    if not v1 then
        v1 = Instance.new("RemoteEvent")
        v1.Name = p1
        v1.Parent = u6
    end
    return v1
end
v1.PurchaseSkill = getOrCreateRemote("PurchaseSkill")
v1.SkillsUpdated = getOrCreateRemote("SkillsUpdated")
v1.RequestSync = getOrCreateRemote("RequestSync")
return v1