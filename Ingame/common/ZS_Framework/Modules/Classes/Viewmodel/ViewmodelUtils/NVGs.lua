local u0 = {Offset = CFrame.new(0, 0, 500)}
local MonetizationCatalog = require(game.ReplicatedStorage.common.ZS_Shared.Data.MonetizationCatalog)
local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
Remotes:WaitForChild("Net")
local LocalPlayer = game.Players.LocalPlayer
local u28 = nil
local u29 = false
local u30 = false
tick()
local SoundService = game:GetService("SoundService")
local u42 = Color3.new(0.384314, 1, 0.94902)
local u43 = nil
function u0.Init() -- Line: 20 -- upvalues: u28 (ref), LocalPlayer (val), MonetizationCatalog (val), u43 (ref), u42 (val), u29 (ref)
    if not (workspace:FindFirstChild("Values")) then
        local v1 = LocalPlayer:GetAttribute("HasNightVisionEntitlement") == true
        u28 = v1
        v1 = 10
        local v2 = 1
        for i = 1, v1, v2 do
            if u28 then
                break
            end
            pcall(function() -- Line: 35 -- upvalues: MonetizationCatalog (upval), LocalPlayer (upval), u28 (upval)
                local MarketplaceService
                for i, v in ipairs(MonetizationCatalog.GetPassIds("NightVision")) do
                    MarketplaceService = game:GetService("MarketplaceService")
                    if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, v) then
                        u28 = true
                        return
                    end
                end
            end)
            if u28 then
                break
            end
        end
        local u39 = nil
        pcall(function() -- Line: 47 -- upvalues: u39 (ref), LocalPlayer (upval)
            u39 = LocalPlayer:GetRankInGroup(3532462)
        end)
        if u39 and 254 <= u39 then
            u28 = true
        end
        u43 = game.Lighting.Ambient
        game.Lighting.Changed:Connect(function() -- Line: 86 -- upvalues: u42 (upval), u43 (upval), u29 (upval)
            if game.Lighting.Ambient ~= u42 and game.Lighting.Ambient ~= u43 then
                u43 = game.Lighting.Ambient
                if u29 then
                    task.wait()
                    if u29 then
                        game.Lighting.Ambient = u42
                    end
                end
            end
        end)
        return
    elseif workspace.Values:FindFirstChild("IsLobby") and workspace.Values.IsLobby.Value == true then
        return
    end
end
function u0.ToggleActivate() -- Line: 114 -- upvalues: u28 (ref), u29 (ref), u30 (ref), u0 (val), SoundService (val), u42 (val), u43 (ref)
    if not u28 then
        return
    end
    if u29 then
        u30 = true
        task.wait(0.1)
        u0.Offset = CFrame.new()
        u29 = false
        game.Lighting.Ambient = u43
        SoundService:PlayLocalSound(script.Parent.Parent.Resources.Sounds.Cloth)
        task.wait(0.5)
        u0.Offset = CFrame.new(0, 0, 500)
        u30 = false
        return
    end
    u30 = true
    task.wait(0.1)
    u0.Offset = CFrame.new()
    u29 = true
    SoundService:PlayLocalSound(script.Parent.Parent.Resources.Sounds.Cloth)
    task.wait()
    game.Lighting.Ambient = u42
    u0.Offset = CFrame.new(0, 0, 500)
    SoundService:PlayLocalSound(script.Parent.Parent.Resources.Sounds.Sound)
    u30 = false
end
return u0