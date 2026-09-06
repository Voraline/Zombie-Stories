local SoundService = game:GetService("SoundService")
local Folder = Instance.new("Folder")
Folder.Name = "SoundHolder"
Folder.Parent = workspace.Ignore
local v1 = {}
local v2 = {}
v1.SoundCache = v2
function v1.CreateSound(p1, p2) -- Line: 14 -- upvalues: Folder (val)
    local v1
    if not p2 then
        return
    end
    local Sound = Instance.new("Sound")
    local v2 = p2
    if typeof(p2) == "table" then
        v2 = p2.SoundId or ""
        Sound.Volume = math.min(p2.Volume, 0.75)
        v1 = p2.PlaybackStart ~= nil
        Sound.PlaybackRegionsEnabled = v1
        if Sound.PlaybackRegionsEnabled then
            Sound.PlaybackRegion = NumberRange.new(p2.PlaybackStart, 999999)
        end
    end
    if string.find(v2, "rbxassetid://") then
        v1 = ""
    else
        v1 = "rbxassetid://"
    end
    Sound.SoundId = v1 .. v2
    Sound.Parent = Folder
    for i, j in script.Effects:GetChildren() do
        j:Clone().Parent = Sound
    end
    return {Sound = Sound}
end
function v1:CreateSoundGroup(p2) -- Line: 45
    local SoundId, v1
    local v2 = {SoundIndex = 1, SFX = {}}
    if typeof(p2) ~= "table" then
        SoundId = p2
    else
        SoundId = p2.SoundId
    end
    local v3 = 15
    local v4 = 1
    for i = 1, v3, v4 do
        v1 = self:CreateSound(p2)
        table.insert(v2.SFX, v1)
    end
    self.SoundCache[SoundId] = v2
end
function v1.PlaySound(p1, p2, p3) -- Line: 64 -- upvalues: Folder (val), SoundService (val)
    local SoundId
    if not p2 then
        return
    end
    if typeof(p2) ~= "table" then
        SoundId = p2
    else
        SoundId = p2.SoundId
    end
    if not (p1.SoundCache[SoundId]) then
        p1:CreateSoundGroup(p2)
    end
    local v1 = p1.SoundCache[SoundId]
    local u25 = v1.SFX[v1.SoundIndex]
    local Sound = u25.Sound
    Sound.Pitch = 1 + math.random(-100, 100) * 0.001
    v1.SoundIndex = v1.SoundIndex % #v1.SFX + 1
    if not p3 then
        u25.Sound.Parent = Folder
        SoundService:PlayLocalSound(u25.Sound)
        return
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Position = p3
    Attachment.Parent = workspace.Terrain
    u25.Sound.Parent = Attachment
    u25.Sound:Play()
    task.delay(5, function() -- Line: 97 -- upvalues: u25 (val), Attachment (val), Folder (upval)
        if u25.Sound.Parent == Attachment then
            u25.Sound.Parent = Folder
        end
        Attachment:Destroy()
    end)
end
return v1