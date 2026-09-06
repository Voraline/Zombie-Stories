local u9
local RunService = game:GetService("RunService")
if not (RunService:IsServer()) then
    u9 = "[BridgeNet2:C]: "
else
    u9 = "[BridgeNet2:S]: "
end
local u10 = {
    silent = function(p1) -- Line: 10 -- upvalues: RunService (val), u9 (val)
        if RunService:IsStudio() then
            print((("%*%*"):format(u9, p1)))
        end
    end,
    log = function(p1) -- Line: 16 -- upvalues: u9 (val)
        print((("%*%*"):format(u9, p1)))
    end,
}
function u10.logAssert(p1, p2) -- Line: 20 -- upvalues: u10 (val)
    if not p1 then
        u10.log(p2)
    end
end
function u10.warn(p1) -- Line: 26 -- upvalues: u9 (val)
    warn((("%*%*"):format(u9, p1)))
end
function u10.warnAssert(p1, p2) -- Line: 30 -- upvalues: u10 (val)
    if not p1 then
        u10.warn(p2)
    end
end
function u10.typecheck(p1, p2, p3, p4) -- Line: 43 -- upvalues: u9 (val)
    local v1 = typeof(p4)
    if v1 ~= p1 then
        local v2 = ("%*%* parameter %* takes %*, got %*"):format(u9, p2, p3, p1, v1)
        error(v2, 0)
    end
end
function u10.fatal(p1) -- Line: 51 -- upvalues: u9 (val)
    local v1 = ("%*%*"):format(u9, p1)
    error(v1, 0)
end
function u10.fatalAssert(p1, p2) -- Line: 55 -- upvalues: u9 (val)
    if not p1 then
        local v1 = ("%*%*"):format(u9, p2)
        error(v1, 0)
    end
end
return u10