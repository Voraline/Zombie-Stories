local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
return {
    new = function(p1, p2, p3) -- Line: 8 -- upvalues: Players (val), TeleportService (val), Workspace (val)
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local Panel = p1.Panel
        local u10 = false
        local u11 = false
        local u12 = {}
        local u13 = {}
        local u14 = {}
        local u15 = {}
        local success, result = pcall(TeleportService.GetLocalPlayerTeleportData, TeleportService)
        local u29 = success
        if u29 then
            u29 = false
            if type(result) == "table" then
                u29 = result.isSoftShutdownReserveServer == true
            end
        end

        local function connect(p1, p2) -- Line: 21 -- upvalues: u13 (val)
            local v1 = p1:Connect(p2)
            local v2 = u13
            table.insert(v2, v1)
            return v1
        end

        local function isSuppressed() -- Line: 27
            -- upvalues: u12 (val), u29 (val), Workspace (upval), u14 (val), PlayerGui (val)
            if next(u12) == nil
                and not u29
                and Workspace:GetAttribute("IsSoftShutdownLobby") ~= true
                and Workspace:GetAttribute("IsSoftshutdownRebootingServers") ~= true then
                for k in pairs(u14) do
                    if k.Parent == PlayerGui and k.Enabled then
                        return true
                    end
                end
                return false
            end
            return true
        end

        function u15.SetOpened(p1_2) -- Line: 44
            -- upvalues: u11 (ref), isSuppressed (val), u10 (ref), Panel (val), p1 (val), p3 (val), p2 (val)
            if u11 then
                return false
            end
            local v1 = not p1_2 or not isSuppressed()
            local v2 = p1_2 and v1
            local v3 = u10 ~= v2
            u10 = v2
            Panel.Visible = v2
            p1.Enabled = v2
            if not v2 then
                p3()
            end
            if v3 and u10 == v2 then
                p2(v2)
            end
            local v4 = v1
            if v4 then
                v4 = u10 == p1_2
            end
            return v4
        end

        function u15.SetSuppressed(p1, p2) -- Line: 64 -- upvalues: u12 (val), isSuppressed (val), u15 (val)
            local v1 = false
            if type(p1) == "string" then
                v1 = p1 ~= ""
            end
            assert(v1, "A non-empty suppression reason is required")
            local v2 = u12
            if not p2 then
                v1 = nil
            else
                v1 = true
            end
            v2[p1] = v1
            if isSuppressed() then
                u15.SetOpened(false)
            end
        end

        local function enforceSuppression() -- Line: 72 -- upvalues: isSuppressed (val), u15 (val)
            if isSuppressed() then
                u15.SetOpened(false)
            end
        end

        local v1 = (p1:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 78 -- upvalues: p1 (val), u10 (ref), isSuppressed (val), u15 (val)
            if p1.Enabled ~= u10 or p1.Enabled and isSuppressed() then
                u15.SetOpened(false)
            end
        end)
        table.insert(u13, v1)

        local function observeOverlay(p1) -- Line: 86
            -- upvalues: PlayerGui (val), u14 (val), enforceSuppression (val), isSuppressed (val), u15 (val)
            if p1.Parent == PlayerGui and p1:IsA("ScreenGui") then
                if p1.Name ~= "SoftShutdownScreenGui" and p1.Name ~= "ZSTeleportCard" then
                    return
                end
                if not u14[p1] then
                    local v1 = u14
                    local PropertyChangedSignal = p1:GetPropertyChangedSignal("Enabled")
                    local v2 = enforceSuppression
                    v1[p1] = (PropertyChangedSignal:Connect(v2))
                    if isSuppressed() then
                        u15.SetOpened(false)
                    end
                    return
                end
            end
        end

        v1 = PlayerGui.ChildAdded:Connect(observeOverlay)
        table.insert(u13, v1)
        local v2 = PlayerGui.ChildRemoved:Connect(function(p1) -- Line: 100 -- upvalues: PlayerGui (val), u14 (val)
            if p1.Parent ~= PlayerGui and u14[p1] then
                u14[p1]:Disconnect()
                u14[p1] = nil
            end
        end)
        table.insert(u13, v2)
        for i, v in ipairs(PlayerGui:GetChildren()) do
            observeOverlay(v)
        end
        v1 = Workspace:GetAttributeChangedSignal("IsSoftShutdownLobby"):Connect(enforceSuppression)
        table.insert(u13, v1)
        v1 = Workspace:GetAttributeChangedSignal("IsSoftshutdownRebootingServers"):Connect(enforceSuppression)
        table.insert(u13, v1)
        v2 = LocalPlayer.OnTeleport:Connect(function(p1) -- Line: 112 -- upvalues: u15 (val)
            if p1 ~= Enum.TeleportState.Started
                and p1 ~= Enum.TeleportState.WaitingForServer
                and p1 ~= Enum.TeleportState.InProgress then
                if p1 == Enum.TeleportState.Failed then
                    u15.SetSuppressed("TeleportDeparture", false)
                end
                return
            end
            u15.SetSuppressed("TeleportDeparture", true)
        end)
        table.insert(u13, v2)
        local v3 = TeleportService
        v2 = v3.TeleportInitFailed:Connect(function(p1) -- Line: 123 -- upvalues: LocalPlayer (val), u15 (val)
            if p1 == LocalPlayer then
                u15.SetSuppressed("TeleportDeparture", false)
            end
        end)
        table.insert(u13, v2)
        v2 = p1.Destroying:Connect(function() -- Line: 128 -- upvalues: u11 (ref), u13 (val), u14 (val)
            u11 = true
            for i, v in ipairs(u13) do
                v:Disconnect()
            end
            for k, i2 in pairs(u14) do
                i2:Disconnect()
            end
            table.clear(u13)
            table.clear(u14)
        end)
        table.insert(u13, v2)
        u15.SetOpened(false)
        return u15
    end,
}