local v1 = game:GetService("ReplicatedStorage")
if game:GetService("RunService"):IsServer() then
	if not v1:FindFirstChild("ReliableRedEvent") then
		local v2 = Instance.new("RemoteEvent")
		v2.Name = "ReliableRedEvent"
		v2.Parent = v1
	end
	if not v1:FindFirstChild("UnreliableRedEvent") then
		local v3 = Instance.new("UnreliableRemoteEvent")
		v3.Name = "UnreliableRedEvent"
		v3.Parent = v1
	end
	require(script.Net).Server.Start()
else
	v1:WaitForChild("ReliableRedEvent")
	v1:WaitForChild("UnreliableRedEvent")
	require(script.Net).Client.Start()
end
local v4 = require(script.SharedEvent)
return {
	["Event"] = require(script.Event),
	["Function"] = require(script.Function),
	["SharedEvent"] = v4.SharedCallEvent,
	["SharedSignalEvent"] = v4.SharedSignalEvent
}