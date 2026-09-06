local deser, makeBridge, makeBridge_2, makeBridge_3, makeIdentifier, ser
local RunService = game:GetService("RunService")
local u7 = require("@self/Client")
require("@self/PublicTypes")
local u13 = require("@self/Server")
local v1 = require("@self/Utilities/NetworkUtils")
local u19 = require("@self/Utilities/Output")
local u22 = RunService:IsServer()
task.spawn(function() -- Line: 12 -- upvalues: u22 (val), u13 (val), u7 (val)
    if u22 then
        u13.start()
        return
    end
    u7.start()
end)
local v2 = {
    ToHex = v1.ToHex,
    ToReadableHex = v1.ToReadableHex,
    FromHex = v1.FromHex,
    CreateUUID = v1.CreateUUID,
    NumberToBestForm = v1.NumberToBestForm,
}
if not u22 then
    makeIdentifier = u7.makeIdentifier
else
    makeIdentifier = u13.makeIdentifier
end
v2.ReferenceIdentifier = makeIdentifier
if not u22 then
    deser = u7.deser
else
    deser = u13.deser
end
v2.Deserialize = deser
if not u22 then
    ser = u7.ser
else
    ser = u13.ser
end
v2.Serialize = ser
v2.AllPlayers = u13.playerContainers().All
v2.PlayersExcept = u13.playerContainers().Except
v2.Players = u13.playerContainers().Players
if not u22 then
    makeBridge = u7.makeBridge
else
    makeBridge = u13.makeBridge
end
v2.ReferenceBridge = makeBridge
if not u22 then
    makeBridge_2 = nil
else
    makeBridge_2 = u13.makeBridge
end
v2.ServerBridge = makeBridge_2
if u22 then
    makeBridge_3 = nil
else
    makeBridge_3 = u7.makeBridge
end
v2.ClientBridge = makeBridge_3
function v2.HandleInvalidPlayer(p1) -- Line: 41 -- upvalues: u19 (val), u22 (val), u13 (val)
    u19.fatalAssert(u22, "Cannot call from client")
    u13.invalidPlayerhandler(p1)
end
table.freeze(v2)
return v2