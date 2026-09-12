local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u21, u22 = require(ReplicatedStorage.Packages.Bin)()
local u24 = nil

local function destroyHighlight() -- Line: 12 -- upvalues: u24 (ref)
    if u24 then
        u24:Destroy()
        u24 = nil
    end
end

local function createHighlight(p1) -- Line: 19 -- upvalues: u24 (ref)
    if u24 then
        u24:Destroy()
        u24 = nil
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "WallhackHighlight"
    Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    Highlight.FillTransparency = 1
    Highlight.Parent = p1
    u24 = Highlight
end

local function toggleWallhack() -- Line: 30
    -- upvalues: GameState (val), u22 (val), u24 (ref), CollectionService (val), u21 (val)
    local WallhackEnabled = GameState.Data.Variables.WallhackEnabled
    u22()
    if u24 then
        u24:Destroy()
        u24 = nil
    end
    if not WallhackEnabled then
        return
    end
    local v1 = CollectionService:GetTagged("ZombieFolder")[1]
    if v1 then
        if u24 then
            u24:Destroy()
            u24 = nil
        end
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "WallhackHighlight"
        Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        Highlight.FillTransparency = 1
        Highlight.Parent = v1
        u24 = Highlight
    end
    local v2 = u21
    v2((CollectionService:GetInstanceAddedSignal("ZombieFolder")):Connect(function(p1) -- Line: 45 -- upvalues: GameState (upval), u24 (upval)
        if GameState.Data.Variables.WallhackEnabled then
            if u24 then
                u24:Destroy()
                u24 = nil
            end
            local Highlight = Instance.new("Highlight")
            Highlight.Name = "WallhackHighlight"
            Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            Highlight.FillTransparency = 1
            Highlight.Parent = p1
            u24 = Highlight
        end
    end))
end

task.spawn(function() -- Line: 52 -- upvalues: toggleWallhack (val)
    toggleWallhack()
end)
GameState.Signals.Variables.WallhackEnabled:Connect(function(p1) -- Line: 56 -- upvalues: toggleWallhack (val)
    toggleWallhack()
end)
return {}