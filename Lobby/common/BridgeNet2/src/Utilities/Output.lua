local u9
local RunService = game:GetService("RunService")
if not RunService:IsServer() then
    u9 = "[BridgeNet2:C]: "
else
    u9 = "[BridgeNet2:S]: "
end
local u10 = {}

function u10.silent(p1) -- Line: 10 -- upvalues: RunService (val), u9 (val)
    if RunService:IsStudio() then
        local v1 = print
        local v2 = u9
        v1((("%*%*"):format(v2, p1)))
    end
end

function u10.log(p1) -- Line: 16 -- upvalues: u9 (val)
    local v1 = print
    local v2 = u9
    v1((("%*%*"):format(v2, p1)))
end

function u10.logAssert(p1, p2) -- Line: 20 -- upvalues: u10 (val)
    if not p1 then
        u10.log(p2)
    end
end

function u10.warn(p1) -- Line: 26 -- upvalues: u9 (val)
    local v1 = warn
    local v2 = u9
    v1((("%*%*"):format(v2, p1)))
end

function u10.warnAssert(p1, p2) -- Line: 30 -- upvalues: u10 (val)
    if not p1 then
        u10.warn(p2)
    end
end

function u10.typecheck(p1, p2, p3, p4) -- Line: 43 -- upvalues: u9 (val)
    local v1 = typeof(p4)
    if v1 ~= p1 then
        local v2 = error
        local v3 = u9
        v2(("%*%* parameter %* takes %*, got %*"):format(v3, p2, p3, p1, v1), 0)
    end
end

function u10.fatal(p1) -- Line: 51 -- upvalues: u9 (val)
    local v1 = error
    local v2 = u9
    v1(("%*%*"):format(v2, p1), 0)
end

function u10.fatalAssert(p1, p2) -- Line: 55 -- upvalues: u9 (val)
    if not p1 then
        local v1 = error
        local v2 = u9
        v1(("%*%*"):format(v2, p2), 0)
    end
end

return u10