local v1 = game:GetService("RunService")
local v_u_2 = require("@self/Client")
require("@self/PublicTypes")
local v_u_3 = require("@self/Server")
local v4 = require("@self/Utilities/NetworkUtils")
local v_u_5 = require("@self/Utilities/Output")
local v_u_6 = v1:IsServer()
task.spawn(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_2
	if v_u_6 then
		v_u_3.start()
	else
		v_u_2.start()
	end
end)
local v7 = {
	["ToHex"] = v4.ToHex,
	["ToReadableHex"] = v4.ToReadableHex,
	["FromHex"] = v4.FromHex,
	["CreateUUID"] = v4.CreateUUID,
	["NumberToBestForm"] = v4.NumberToBestForm
}
local v8
if v_u_6 then
	v8 = v_u_3.makeIdentifier
else
	v8 = v_u_2.makeIdentifier
end
v7.ReferenceIdentifier = v8
local v9
if v_u_6 then
	v9 = v_u_3.deser
else
	v9 = v_u_2.deser
end
v7.Deserialize = v9
local v10
if v_u_6 then
	v10 = v_u_3.ser
else
	v10 = v_u_2.ser
end
v7.Serialize = v10
v7.AllPlayers = v_u_3.playerContainers().All
v7.PlayersExcept = v_u_3.playerContainers().Except
v7.Players = v_u_3.playerContainers().Players
local v11
if v_u_6 then
	v11 = v_u_3.makeBridge
else
	v11 = v_u_2.makeBridge
end
v7.ReferenceBridge = v11
local v12
if v_u_6 then
	v12 = v_u_3.makeBridge
else
	v12 = nil
end
v7.ServerBridge = v12
local v13
if v_u_6 then
	v13 = nil
else
	v13 = v_u_2.makeBridge
end
v7.ClientBridge = v13
function v7.HandleInvalidPlayer(p14) -- name: HandleInvalidPlayer
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_3
	v_u_5.fatalAssert(v_u_6, "Cannot call from client")
	v_u_3.invalidPlayerhandler(p14)
end
table.freeze(v7)
return v7