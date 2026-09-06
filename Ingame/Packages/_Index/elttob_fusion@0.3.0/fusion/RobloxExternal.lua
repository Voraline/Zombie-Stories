local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local External = require(script.Parent.External)
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
function v1.startScheduler() -- Line: 64 -- upvalues: u25 (ref), RunService (val), HttpService (val), performUpdateStep (val)
    local u25
    if u25 ~= nil then
        return
    end
    if not (RunService:IsClient()) then
        u25 = RunService.Heartbeat:Connect(performUpdateStep)
        function u25() -- Line: 82 -- upvalues: u25 (val)
            u25:Disconnect()
        end
        return
    end
    local u10 = "FusionUpdateStep_" .. HttpService:GenerateGUID()
    RunService:BindToRenderStep(u10, Enum.RenderPriority.First.Value, performUpdateStep)
    function u25() -- Line: 77 -- upvalues: RunService (upval), u10 (val)
        RunService:UnbindFromRenderStep(u10)
    end
end
function v1.stopScheduler() -- Line: 91 -- upvalues: u25 (ref)
    if u25 ~= nil then
        u25()
        u25 = nil
    end
end
return v1