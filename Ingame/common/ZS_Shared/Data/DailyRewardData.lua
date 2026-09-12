local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemData = require(ReplicatedStorage.common.ItemData)
local u9 = {
    Enabled = true,
    Days = {
        {Kind = "ZBucks", Amount = 25, ImageId = "rbxassetid://6817938722"},
        {Kind = "ZBucks", Amount = 50, ImageId = "rbxassetid://4936288857"},
        {Kind = "ZBucks", Amount = 75, ImageId = "rbxassetid://4936350857"},
        {Kind = "ZBucks", Amount = 100, ImageId = "rbxassetid://4936401476"},
        {Kind = "ZBucks", Amount = 250, ImageId = "rbxassetid://4936600166"},
        {Kind = "ZBucks", Amount = 400, ImageId = "rbxassetid://4936666860"},
        {Kind = "Crate", Amount = 1, CrateId = "Primary"},
    },
}

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
    local Amount = p1.Amount
    return (tostring(Amount or 0)) .. " Z$"
end

function u9.GetWeek(p1) -- Line: 38 -- upvalues: u9 (val)
    local v1 = tonumber(p1) or 0
    local v2 = u9
    local v3 = v1 / #v2.Days
    return math.floor(v3) + 1
end

function u9.BuildRewardList() -- Line: 42 -- upvalues: u9 (val)
    local v1
    local v2 = {}
    for i, v in ipairs(u9.Days) do
        v1 = {
            Kind = v.Kind,
            Amount = v.Amount,
            CrateId = v.CrateId,
            ImageId = u9.GetImage(v),
            Label = u9.GetLabel(v),
        }
        v2[i] = v1
    end
    return v2
end

return u9