local deepTraverse
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u12 = require("@game/ReplicatedStorage/common/Signal")
local v1 = {}
local v2 = game.GameId == 1970013852
if not (RunService:IsStudio()) then end
local v3 = os.date("*t")
local v4 = if v3.month == 12 then 20 <= v3.day else false
local Attribute = workspace:GetAttribute("PlaceType")
local v5 = Attribute == "Lobby"
local v6 = Attribute == "Arcade"
local v7 = Attribute == "Story"
v1.Data = {
    ServerLoaded = false,
    SkipSpecialAwards = false,
    EasyModifiersActive = false,
    ModifiersActive = false,
    QuestSystemActive = true,
    IsLobby = v5,
    IsArcade = v6,
    IsStory = v7,
    Events = {ChristmasActive = v4},
    IsTestUniverse = v2,
    Variables = {
        ZBucksMultiplier = 1,
        XPMultiplier = 1,
        PlayerDamageTaken = 1,
        PlayerDowns = 3,
        ZombieHealth = 1,
        ZombieSpeed = 1,
        ZombieDamage = 1,
        ZombieSpawnRate = 1,
        ZombieSlowdown = 1,
        ZombieSlowdownEnabled = true,
        ZombiesExplodeOnDeath = false,
        ZombieExplodeDamage = 1,
        ZombieExplodeRadius = 1,
        ZombieAttackSpeed = 1,
        ZombieAttackDelay = 1,
        HeadshotOnly = false,
        DefaultMusicEnabled = true,
        WallhackEnabled = false,
        MotionSicknessEnabled = false,
        HalfBlindEnabled = false,
        BreakdancingZombiesEnabled = false,
        PartyModeEnabled = false,
        PlayerSpeed = 1,
        FireRate = 1,
        WeaponSpread = 1,
        SlidingEnabled = true,
        GivePrimary = true,
        GiveSecondary = true,
        GiveMelee = true,
        GiveAbility = true,
        ForcePrimary = "",
        ForceSecondary = "",
        ForceMelee = "",
        ForceAbility = "",
    },
    ActiveModifiers = {},
}
v1.LocalState = {
    NPCRotation = CFrame.Angles(0, 0, 0),
    RotationAxis = {X = 0, Y = 0, Z = 0},
}
v1.Signals = {}
local u114 = {ActiveModifiers = true}
function deepTraverse(p1, p2) -- Line: 106 -- upvalues: u114 (val), deepTraverse (val), u12 (val)
    local v1 = p1
    local v2 = nil
    local v3 = nil
    local v4 = p2
    for i, j in v1, v2, v3 do
        if type(j) ~= "table" then
            v4[i] = u12.new()
        elseif not (u114[i]) then
            v4[i] = {}
            deepTraverse(j, v4[i])
        end
    end
end
deepTraverse(v1.Data, v1.Signals)
return v1