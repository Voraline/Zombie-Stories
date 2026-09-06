local u26, u27
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
require("@game/ReplicatedStorage/common/NPCRegistry")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u20 = require("../Data/PlayerDatabase")
u26, u27 = require(ReplicatedStorage.Packages.Bin)()
local v1 = {}
local u32 = math.random(1, 2)
local function toggleHalfblind() -- Line: 15 -- upvalues: GameState (val), u27 (val), Fusion (val), u26 (val), u20 (val), u32 (val)
    u27()
    if GameState.Data.Variables.HalfBlindEnabled then
        local v1
        local u9 = Fusion.scoped(Fusion)
        u26(function() -- Line: 23 -- upvalues: u9 (val)
            u9:doCleanup()
        end)
        local v2 = u9:New("ScreenGui")
        local v3 = {
            Parent = u20.PlayerGui,
            IgnoreGuiInset = true,
            ScreenInsets = Enum.ScreenInsets.None,
            ResetOnSpawn = false,
            DisplayOrder = -10,
        }
        local Children = u9.Children
        local v4 = {}
        local v5 = u9:New("Frame")
        local v6 = {BackgroundTransparency = 0, Size = UDim2.new(0.5, 0, 1, 0)}
        if u32 ~= 1 then
            v1 = UDim2.new(0.5, 0, 0, 0)
        else
            v1 = UDim2.new(0, 0, 0, 0)
            if not v1 then
                v1 = UDim2.new(0.5, 0, 0, 0)
            end
        end
        v6.Position = v1
        v6.BackgroundColor3 = Color3.new(0, 0, 0)
        v4[1] = v5(v6)
        v3[Children] = v4
        v2(v3)
    end
end
toggleHalfblind()
GameState.Signals.Variables.HalfBlindEnabled:Connect(toggleHalfblind)
return v1