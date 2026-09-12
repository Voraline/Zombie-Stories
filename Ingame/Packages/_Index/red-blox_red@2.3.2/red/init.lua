local ReplicatedStorage = game:GetService("ReplicatedStorage")
if not game:GetService("RunService"):IsServer() then
    ReplicatedStorage:WaitForChild("ReliableRedEvent")
    ReplicatedStorage:WaitForChild("UnreliableRedEvent")
    require(script.Net).Client.Start()
else
    if not ReplicatedStorage:FindFirstChild("ReliableRedEvent") then
        local RemoteEvent = Instance.new("RemoteEvent")
        RemoteEvent.Name = "ReliableRedEvent"
        RemoteEvent.Parent = ReplicatedStorage
    end
    if not ReplicatedStorage:FindFirstChild("UnreliableRedEvent") then
        local UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent")
        UnreliableRemoteEvent.Name = "UnreliableRedEvent"
        UnreliableRemoteEvent.Parent = ReplicatedStorage
    end
    require(script.Net).Server.Start()
end
local SharedEvent = require(script.SharedEvent)
return {
    Event = require(script.Event),
    Function = require(script.Function),
    SharedEvent = SharedEvent.SharedCallEvent,
    SharedSignalEvent = SharedEvent.SharedSignalEvent,
}