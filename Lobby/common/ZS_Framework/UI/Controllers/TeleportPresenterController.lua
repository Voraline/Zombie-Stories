local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ZSTeleport = ReplicatedFirst:FindFirstChild("ZSTeleport")
local TeleportPresenter = ZSTeleport
if TeleportPresenter then
    TeleportPresenter = ZSTeleport:FindFirstChild("TeleportPresenter")
end
if TeleportPresenter and TeleportPresenter:IsA("ModuleScript") then
    local u33, v1
    v1, u33 = pcall(require, TeleportPresenter)
    if not v1 then
        if not v1 then
            warn("[TeleportPresenter] Controller failed to load: " .. tostring(u33))
        end
    elseif not u33 then
        if not v1 then
            warn("[TeleportPresenter] Controller failed to load: " .. tostring(u33))
        end
    elseif not u33.IsEnabled then
        if not v1 then
            warn("[TeleportPresenter] Controller failed to load: " .. tostring(u33))
        end
    elseif u33.IsEnabled() then
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
            u33.Arm("Generic")
        end
        TeleportService.TeleportInitFailed:Connect(function(p1, p2, p3) -- Line: 23 -- upvalues: Players (val), u33 (val)
            if p1 == Players.LocalPlayer then
                u33.Dismiss("TeleportInitFailed: " .. tostring(p3 or p2))
            end
        end)
    elseif not v1 then
        warn("[TeleportPresenter] Controller failed to load: " .. tostring(u33))
    end
end
return {}