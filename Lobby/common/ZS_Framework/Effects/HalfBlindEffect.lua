local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
require("@game/ReplicatedStorage/common/NPCRegistry")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u20 = require("../Data/PlayerDatabase")
local u26, u27 = require(ReplicatedStorage.Packages.Bin)()
local u32 = math.random(1, 2)

local function toggleHalfblind() -- Line: 15
    -- upvalues: GameState (val), u27 (val), Fusion (val), u26 (val), u20 (val), u32 (val)
    local v1 = GameState
    local HalfBlindEnabled = v1.Data.Variables.HalfBlindEnabled
    u27()
    if HalfBlindEnabled then
        local v2
        local u9 = Fusion.scoped(Fusion)
        local v3 = u26
        v3(function() -- Line: 23 -- upvalues: u9 (val)
            u9:doCleanup()
        end)
        v3 = u9:New("ScreenGui")
        local v4 = {}
        v4.Parent = u20.PlayerGui
        v4.IgnoreGuiInset = true
        v4.ScreenInsets = Enum.ScreenInsets.None
        v4.ResetOnSpawn = false
        v4.DisplayOrder = -10
        local Children = u9.Children
        local v5 = {}
        local v6 = u9:New("Frame")
        local v7 = {BackgroundTransparency = 0}
        v7.Size = UDim2.new(0.5, 0, 1, 0)
        if u32 ~= 1 then
            v2 = UDim2.new(0.5, 0, 0, 0)
        else
            v2 = UDim2.new(0, 0, 0, 0)
            if not v2 then
                v2 = UDim2.new(0.5, 0, 0, 0)
            end
        end
        v7.Position = v2
        v7.BackgroundColor3 = Color3.new(0, 0, 0)
        v5[1] = v6(v7)
        v4[Children] = v5
        v3(v4)
    end
end

toggleHalfblind()
GameState.Signals.Variables.HalfBlindEnabled:Connect(toggleHalfblind)
return {}