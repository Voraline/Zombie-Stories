local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u9 = require("./LocalPlayerController")
local PlayerHandler = require(common.PlayerHandler)
local FlashlightEvent = require(RedEvents.Framework.FlashlightEvent)
local u17 = {}
local u18 = {}
local u19 = {}
local u20 = {}
local u21 = {}
local LocalPlayer = game.Players.LocalPlayer
local u25 = {}

function u25.SetFlashlightEnabled(p1, p2, p3, p4) -- Line: 21
    -- upvalues: LocalPlayer (val), u19 (val), u17 (val), u18 (val), u20 (val), FlashlightEvent (val)
    local v1 = p3
    if not v1 then
        v1 = LocalPlayer
    end
    local v2 = v1
    local v3 = true
    if u19[v2] == nil then
        v3 = not p2
    end
    local Name = v2.Name
    local v4 = ("Player '%s' has no flashlight folder"):format(Name)
    assert(v3, v4)
    local v5 = u17[v2]
    u17[v2] = p2
    if not p4 then
        u18[v2] = p2
    end
    v3 = u20[v2]
    if p2 then
        if v5 then
            removeFlashlight(v2)
            v3 = nil
        end
        if not v3 then
            v3 = createFlashlight(v2)
            u20[v2] = v3
        end
    end
    if v3 then
        for i, j in v3:GetChildren() do
            if j:IsA("Light") then
                j.Enabled = p2
            end
        end
    end
    if v2 == LocalPlayer then
        v4 = FlashlightEvent
        local v6 = {Type = "SetEnabled", Enabled = p2}
        v4:FireServer(v6)
    end
end

function u25.SetFlashlightFolder(p1, p2, p3) -- Line: 58
    -- upvalues: LocalPlayer (val), u19 (val), u20 (val), u17 (val), FlashlightEvent (val)
    local v1 = p3
    if not v1 then
        v1 = LocalPlayer
    end
    local v2 = v1
    local v3 = p2:IsA("Folder")
    assert(v3, "Must pass a folder with lights")
    u19[v2] = p2
    if u20[v2] then
        removeFlashlight(v2)
    end
    v1 = createFlashlight(v2, u17[v2])
    u20[v2] = v1
    if v2 ~= LocalPlayer then
        createFlashlightConstraints(v2)
        return
    end
    v3 = FlashlightEvent
    local v4 = {Type = "SetFolder", Folder = p2}
    v3:FireServer(v4)
end

function u25.UpdatePlayerLookDirection(p1, p2, p3) -- Line: 79
    -- upvalues: u20 (val), LocalPlayer (val), u21 (val), u9 (val)
    local v1 = u20[p3]
    if v1 then
        if p3 == LocalPlayer then
            if u9.ThirdPerson and LocalPlayer.character then
                v1.CFrame = workspace.CurrentCamera.CFrame.Rotation + u9.head.Position
                return
            end
            v1.CFrame = workspace.CurrentCamera.CFrame
        elseif v1 then
            local v2 = u21[p3]
            if v2 and v2.HRPAttachment.Parent then
                local Parent = v2.HRPAttachment.Parent
                local HRPAttachment_2 = v2.HRPAttachment
                local Rotation = Parent.CFrame.Rotation
                local v3 = CFrame.new(Vector3.new(0, 0, 0), p2)
                HRPAttachment_2.CFrame = Rotation:ToObjectSpace(v3)
                return
            end
        end
    end
end

function createFlashlight(p1, p2) -- Line: 102 -- upvalues: u19 (val), LocalPlayer (val), u20 (val)
    local v1
    local v2 = u19[p1]
    local v3 = v2 ~= nil
    local Name = p1.Name
    local v4 = ("Player '%s' has no flashlight folder"):format(Name)
    assert(v3, v4)
    local Part = Instance.new("Part")
    Part.Name = p1.Name .. "Flashlight"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Massless = true
    for i, j in v2:QueryDescendants("Light") do
        v1 = j:Clone()
        v1.Parent = Part
        if p2 ~= nil then
            v1.Enabled = p2
        end
    end
    Part.Parent = workspace.Ignore
    if p1 ~= LocalPlayer then
        createFlashlightConstraints(p1)
    end
    Part.Destroying:Connect(function() -- Line: 129 -- upvalues: u20 (upval), p1 (val)
        u20[p1] = nil
    end)
    return Part
end

function removeFlashlight(p1) -- Line: 136 -- upvalues: u20 (val), u21 (val)
    local v1 = u20[p1]
    local v2 = u21[p1]
    if v1 then
        v1:Destroy()
        u20[p1] = nil
    end
    if v2 then
        local v3 = v2
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            j:Destroy()
        end
    end
end

function createFlashlightConstraints(p1) -- Line: 150 -- upvalues: u20 (val), u21 (val)
    local v1 = u20[p1]
    local v2 = u21[p1]
    if v2 then
        local v3 = v2
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            j:Destroy()
        end
        u21[p1] = nil
    end
    if v1
        and p1.Character
        and p1.Character:FindFirstChild("HumanoidRootPart")
        and p1.Character:FindFirstChild("Head") then
        local HumanoidRootPart = p1.Character.HumanoidRootPart
        local Head = p1.Character.Head
        v1.Anchored = false
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = v1
        local Attachment_2 = Instance.new("Attachment")
        Attachment_2.Parent = Head
        Attachment_2.Name = "FlashlightHeadAttachment"
        local Attachment_3 = Instance.new("Attachment")
        Attachment_3.Parent = HumanoidRootPart
        Attachment_3.Name = "FlashlightHRPAttachment"
        local AlignPosition = Instance.new("AlignPosition")
        AlignPosition.Attachment0 = Attachment
        AlignPosition.Attachment1 = Attachment_2
        AlignPosition.Responsiveness = 200
        AlignPosition.MaxForce = (1 / 0)
        AlignPosition.Parent = v1
        local AlignOrientation = Instance.new("AlignOrientation")
        AlignOrientation.Attachment0 = Attachment
        AlignOrientation.Attachment1 = Attachment_3
        AlignOrientation.Responsiveness = 100
        AlignOrientation.Parent = v1
        u21[p1] = {
            FlashlightAttachment = Attachment,
            HeadAttachment = Attachment_2,
            HRPAttachment = Attachment_3,
            AlignPosition = AlignPosition,
            AlignOrientation = AlignOrientation,
        }
    end
end

local u32 = {}
FlashlightEvent:SetClientListener(function(p1) -- Line: 205 -- upvalues: u19 (val), u25 (val), u32 (val)
    if p1 then
        local v1
        if p1.Type == "SetEnabled" then
            if not u19[p1.Player] then
                u32[p1.Player] = p1.Enabled
                return
            end
            v1 = u25
            local Enabled = p1.Enabled
            local Player = p1.Player
            v1:SetFlashlightEnabled(Enabled, Player)
            return
        end
        if p1.Type == "SetFolder" then
            v1 = u25
            local Folder = p1.Folder
            local Player_2 = p1.Player
            v1:SetFlashlightFolder(Folder, Player_2)
            if u32[p1.Player] then
                v1 = u25
                local v2 = u32[p1.Player]
                local Player_3 = p1.Player
                v1:SetFlashlightEnabled(v2, Player_3)
                u32[p1.Player] = nil
            end
        end
    end
end)

local function setupPlayer(p1) -- Line: 224
    -- upvalues: u25 (val), LocalPlayer (val), u20 (val), PlayerHandler (val), u18 (val)
    u25:SetFlashlightEnabled(false, p1)
    p1.CharacterAdded:Connect(function(p1_2) -- Line: 226 -- upvalues: p1 (val), LocalPlayer (upval), u20 (upval)
        if p1 ~= LocalPlayer and u20[p1] then
            p1_2:WaitForChild("HumanoidRootPart")
            createFlashlightConstraints(p1)
        end
    end)
    local v1 = PlayerHandler:WaitForPlayerState(p1)
    if v1 then
        (v1:GetPropertyChangedSignal("IsDead")):Connect(function(p1_2) -- Line: 234 -- upvalues: u25 (upval), p1 (val), u18 (upval)
            local v1, v2
            if p1_2 then
                v1 = u25
                v2 = p1
                v1:SetFlashlightEnabled(false, v2, true)
                return
            end
            if u18[p1] then
                v1 = u25
                v2 = p1
                v1:SetFlashlightEnabled(true, v2, true)
            end
        end)
        if v1.IsDead then
            u25:SetFlashlightEnabled(false, p1, true)
            return
        end
        if u18[p1] then
            u25:SetFlashlightEnabled(true, p1, true)
        end
    end
end

game.Players.PlayerAdded:Connect(setupPlayer)
for i, j in game.Players:GetPlayers() do
    setupPlayer(j)
end
FlashlightEvent:FireServer()
return u25