local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerRoles = require(ReplicatedStorage.common.ZS_Shared.Data.PlayerRoles)
local v1 = {}
if PlayerRoles.Config.Enabled then
    for i, v in ipairs(PlayerRoles.Definitions) do
        table.insert(v1, {
            Id = v.id,
            TagText = v.chatTagText,
            TagColor = v.Chat.Tag,
            NameColor = v.Chat.Name,
            ChatColor = v.Chat.Body,
        })
    end
end
return table.freeze(v1)