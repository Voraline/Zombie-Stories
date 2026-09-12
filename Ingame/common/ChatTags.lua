local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerRoles = require(ReplicatedStorage.common.ZS_Shared.Data.PlayerRoles)
local v1 = {}
if PlayerRoles.Config.Enabled then
    local v2
    for i, v in ipairs(PlayerRoles.Definitions) do
        v2 = {
            Id = v.id,
            TagText = v.chatTagText,
            TagColor = v.Chat.Tag,
            NameColor = v.Chat.Name,
            ChatColor = v.Chat.Body,
        }
        table.insert(v1, v2)
    end
end
return table.freeze(v1)