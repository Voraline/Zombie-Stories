local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemData = require(ReplicatedStorage.common.ItemData)
local u9 = {Enabled = true}
local v1 = {}
local v2 = {Kind = "ZBucks", Amount = 25, ImageId = "rbxassetid://6817938722"}
v1[1] = v2
v1[2] = {Kind = "ZBucks", Amount = 50, ImageId = "rbxassetid://4936288857"}
v1[3] = {Kind = "ZBucks", Amount = 75, ImageId = "rbxassetid://4936350857"}
v1[4] = {Kind = "ZBucks", Amount = 100, ImageId = "rbxassetid://4936401476"}
v1[5] = {Kind = "ZBucks", Amount = 250, ImageId = "rbxassetid://4936600166"}
v1[6] = {Kind = "ZBucks", Amount = 400, ImageId = "rbxassetid://4936666860"}
v1[7] = {Kind = "Crate", Amount = 1, CrateId = "Primary"}
u9.Days = v1
function u9.GetImage(p1) -- Line: 23 -- upvalues: ItemData (val)
    local ImageId
    if p1.Kind ~= "Crate" then
        return p1.ImageId or ""
    end
    local v1 = ItemData.LootBoxes[p1.CrateId]
    if not v1 then
        ImageId = ""
    else
        ImageId = v1.ImageId
        if not ImageId then
            ImageId = ""
        end
    end
    return ImageId
end
function u9.GetLabel(p1) -- Line: 31
    if p1.Kind == "Crate" then
        return string.upper((p1.CrateId or "Reward") .. " Crate")
    end
    local v1 = tostring(p1.Amount or 0)
    return v1 .. " Z$"
end
function u9.GetWeek(p1) -- Line: 38 -- upvalues: u9 (val)
    local v1 = tonumber(p1) or 0
    return math.floor(v1 / #u9.Days) + 1
end
function u9.BuildRewardList() -- Line: 42 -- upvalues: u9 (val)
    local v1 = {}
    for i, v in ipairs(u9.Days) do
        v1[i] = {
            Kind = v.Kind,
            Amount = v.Amount,
            CrateId = v.CrateId,
            ImageId = u9.GetImage(v),
            Label = u9.GetLabel(v),
        }
    end
    return v1
end
return u9