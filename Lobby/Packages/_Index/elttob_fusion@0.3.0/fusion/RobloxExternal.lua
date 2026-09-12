local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Parent = script.Parent
local External = require(Parent.External)
local v1 = {
    policies = {allowWebLinks = RunService:IsStudio()},
    doTaskImmediate = function(p1) -- Line: 24
        task.spawn(p1)
    end,
    doTaskDeferred = function(p1) -- Line: 33
        task.defer(p1)
    end,
    logErrorNonFatal = function(p1) -- Line: 42
        task.spawn(error, p1, 0)
    end,
    logWarn = warn,
}

local function performUpdateStep() -- Line: 56 -- upvalues: External (val)
    External.performUpdateStep(os.clock())
end

local u25 = nil

function v1.startScheduler() -- Line: 64
    -- upvalues: u25 (ref), RunService (val), HttpService (val), performUpdateStep (val)
    if u25 ~= nil then
        return
    end
    if not RunService:IsClient() then
        local v1 = RunService
        local Heartbeat = v1.Heartbeat
        local v2 = performUpdateStep
        local u25_2 = Heartbeat:Connect(v2)

        function u25() -- Line: 82 -- upvalues: u25_2 (val)
            u25_2:Disconnect()
        end

        return
    end
    local u10 = "FusionUpdateStep_" .. HttpService:GenerateGUID()
    local v3 = RunService
    local Value = Enum.RenderPriority.First.Value
    local v4 = performUpdateStep
    v3:BindToRenderStep(u10, Value, v4)

    function u25() -- Line: 77 -- upvalues: RunService (upval), u10 (val)
        local v1 = RunService
        local v2 = u10
        v1:UnbindFromRenderStep(v2)
    end
end

function v1.stopScheduler() -- Line: 91 -- upvalues: u25 (ref)
    if u25 ~= nil then
        u25()
        u25 = nil
    end
end

return v1