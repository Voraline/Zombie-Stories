if game:GetService("RunService"):IsServer() then
    game:GetService("ServerScriptService")
    return require("@game/ServerScriptService/common/zap")
end
game:GetService("ReplicatedStorage")
return require("@game/ReplicatedStorage/common/zap")