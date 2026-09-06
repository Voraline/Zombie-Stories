local BridgeNet2 = require(game.ReplicatedStorage.common:WaitForChild("BridgeNet2"))
local u9 = {_cache = {}}
function u9.GetBridge(p1) -- Line: 11 -- upvalues: u9 (val), BridgeNet2 (val)
    local v1 = u9._cache[p1]
    if v1 then
        return v1
    end
    local v2 = BridgeNet2.ReferenceBridge(p1)
    u9._cache[p1] = v2
    return v2
end
function u9.ReferenceBridge(p1) -- Line: 22 -- upvalues: BridgeNet2 (val)
    return BridgeNet2.ReferenceBridge(p1)
end
return u9