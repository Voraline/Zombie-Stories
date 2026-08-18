if game:GetService("RunService"):IsServer() then
	game:GetService("ServerScriptService")
	return require("@game/ServerScriptService/common/zap")
else
	game:GetService("ReplicatedStorage")
	return require("@game/ReplicatedStorage/common/zap")
end