local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ZSTeleport = ReplicatedFirst:FindFirstChild("ZSTeleport")
local TeleportPresenter = ZSTeleport
if TeleportPresenter then
    TeleportPresenter = ZSTeleport:FindFirstChild("TeleportPresenter")
end
if TeleportPresenter and TeleportPresenter:IsA("ModuleScript") then
    local success, result = pcall(require, TeleportPresenter)
    if not success or not result or not result.IsEnabled then
        if not success then
            warn("[TeleportPresenter] Controller failed to load: " .. tostring(result))
        end
    elseif result.IsEnabled() then
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer
        if PlayerGui then
            PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        end
        local ZSTeleportCard = PlayerGui
        if ZSTeleportCard then
            ZSTeleportCard = PlayerGui:FindFirstChild("ZSTeleportCard")
        end
        if not ZSTeleportCard then
            result.Arm("Generic")
        end
        TeleportService.TeleportInitFailed:Connect(function(p1, p2, p3) -- Line: 23 -- upvalues: Players (val), result (val)
            if p1 == Players.LocalPlayer then
                result.Dismiss("TeleportInitFailed: " .. tostring(p3 or p2))
            end
        end)
    elseif not success then
        warn("[TeleportPresenter] Controller failed to load: " .. tostring(result))
    end
end
return {}