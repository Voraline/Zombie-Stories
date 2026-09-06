local v1
local v2 = {
    Lobby = 2984072291,
    StoryVoxel = 6554938877,
    StoryFuture = 5595752541,
    Arcade = 97735511535421,
    LiveEvent = 100844610243904,
}
local v3 = {
    Lobby = 5621183319,
    StoryVoxel = 9377674517,
    StoryFuture = 9377693378,
    Arcade = 120355117665363,
    LiveEvent = 94647312974854,
}
local v4 = game.GameId == 1970013852
if not v4 then
    v1 = v2
else
    v1 = v3
end
return table.freeze({
    Lobby = v1.Lobby,
    StoryVoxel = v1.StoryVoxel,
    StoryFuture = v1.StoryFuture,
    Arcade = v1.Arcade,
    LiveEvent = v1.LiveEvent,
    IsTestUniverse = v4,
    UniverseIds = {Live = 653118530, Testing = 1970013852},
    Live = v2,
    Test = v3,
})