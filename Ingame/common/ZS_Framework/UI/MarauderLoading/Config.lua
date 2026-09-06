local v1 = {
    LoadingMusicSoundId = "rbxassetid://1599645254",
    LoadingMusicVolume = 0.22,
    MenuAmbienceSoundId = "rbxassetid://115931517266800",
    MenuAmbienceVolume = 0.35,
    SceneOrigin = CFrame.new(0, -5000, 0),
    LobbyFieldOfView = 48,
    StoryFieldOfView = 60,
    MinimumLobbyDuration = 5,
    LobbyProgressTimeConstant = 7,
    LobbyProgressCap = 0.9,
    TipInterval = 5,
    ContinuePrompt = "Press any button to continue",
    ContinuePromptMobile = "Tap anywhere to continue",
    ContinueInputDelay = 0.2,
    SeatSpacing = 2.85,
    LobbySeatIndex = 1,
}
local v2 = {}
local v3 = Vector2.new(1, 0)
local v4 = Vector2.new(-1, 0)
local v5 = Vector2.new(1, 1)
local v6 = Vector2.new(-1, 1)
local v7 = Vector2.new(1, 2)
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
v2[5] = v7
v2[6] = Vector2.new(-1, 2)
v1.PassengerSlots = v2
v1.FallbackSeatPosition = Vector3.new(-3.799999952316284, -0.75, 4.400000095367432)
v1.FallbackDoorPosition = Vector3.new(0, 0.30000001192092896, 9.5)
v1.LobbyCameraAisleOffset = 4.8
v1.LobbyCameraLongitudinalOffset = 1.8
v1.LobbyCameraHeight = 2.25
v1.LobbyDoorCompositionWeight = 0.18
v1.StoryCameraLongitudinalOffset = 4.2
v1.StoryCameraLateralOffset = 0
v1.StoryCameraHeight = 1.9
v1.StoryCameraTargetRow = 1
v1.StoryCameraTargetHeight = 0.9
v1.ExtractionWideCameraLongitudinalOffset = 4.2
v1.ExtractionWideCameraLateralOffset = 0
v1.ExtractionWideCameraHeight = 1.9
v1.ExtractionWideCameraTargetRow = 1
v1.ExtractionWideCameraTargetHeight = 0.9
v1.ExtractionSpotlightDistance = 5.2
v1.ExtractionSpotlightHeight = 0.65
v1.ExtractionSpotlightYaw = 0.13962634015954636
v1.ExtractionSpotlightFieldOfView = 50
v1.ExtractionCameraMoveTime = 0.65
v1.ExtractionCameraMoveEasing = Enum.EasingStyle.Sine
v1.ExtractionCameraMoveDirection = Enum.EasingDirection.InOut
v1.ExtractionWideFieldOfView = 60
v1.ExtractionSecondsPerPlayer = 3
v1.ExtractionIntroHold = 0.8
v1.ExtractionOutroHold = 0.8
v1.ExtractionCoverFadeTime = 0.45
v1.ExtractionServerStopWatchdog = 10
v1.ExtractionNameFadeTime = 0.18
v1.ExtractionTitleFadeTime = 0.28
v1.ExtractionDescriptorDelay = 0.12
v1.ExtractionDescriptorFadeTime = 0.25
v1.ExtractionValueCountUpTime = 2
v1.ExtractionValueMinimumCountUpTime = 0.35
v1.ExtractionValueFlashScale = 1.35
v1.ExtractionValueFlashInTime = 0.15
v1.ExtractionValueFlashHoldTime = 0.4
v1.ExtractionValueFlashOutTime = 0.45
v1.ExtractionValueFlashColor = Color3.new(1, 1, 1)
v1.ExtractionCardExitTime = 0.25
v1.ExtractionCardHitSoundId = "rbxassetid://132272806571011"
v1.ExtractionCardHitVolume = 0.65
v1.ExtractionCardWhooshSoundId = "rbxassetid://97531415718761"
v1.ExtractionCardWhooshVolume = 0.45
v1.ExtractionCameraMoveSoundId = "rbxassetid://72401113846031"
v1.ExtractionCameraMoveVolume = 0.4
v1.ExtractionCountUpLoopSoundId = "rbxassetid://107834321746027"
v1.ExtractionCountUpLoopVolume = 0.65
v1.ExtractionCountUpFinishSoundId = "rbxassetid://115309388464514"
v1.ExtractionCountUpFinishVolume = 0.65
v1.CameraBobPosition = Vector3.new(0.017999999225139618, 0.04500000178813934, 0.014000000432133675)
v1.CameraBobRotation = Vector3.new(0.0020943949930369854, 0.0013962633674964309, 0.0027925267349928617)
v1.ParallaxYaw = 0.026179938779914945
v1.ParallaxPitch = 0.013962634015954637
v1.ParallaxSpring = 34
v1.ParallaxDamping = 10
v1.SeatedIdleAnimations = {"rbxassetid://138456593729774", "rbxassetid://107622015700798", "rbxassetid://120137752770811", "rbxassetid://136926757335614"}
v1.SeatedIdleFadeTime = 0.35
v1.SeatedIdleSpeedJitter = 0.06
v1.HeliInteriorSoundId = "rbxassetid://109810223981955"
v1.HeliEngineSoundId = "rbxassetid://119773355244525"
v1.StoryPlayerReadySoundId = "rbxassetid://135623677024794"
v1.StoryAllReadySoundId = "rbxassetid://118652989988861"
v1.HeliInteriorVolume = 0.65
v1.HeliEngineVolume = 0.45
v1.StoryPlayerReadyVolume = 0.5
v1.StoryAllReadyVolume = 0.65
v1.HeliAudioMinDistance = 10
v1.HeliAudioMaxDistance = 300
v1.HeliAudioFadeIn = 0.35
v1.HeliAudioFadeOut = 0.6
v1.StoryCameraShake = {
    Magnitude = 0.65,
    Roughness = 0.85,
    FadeIn = 0.35,
    FadeOut = 0.2,
    PositionInfluence = Vector3.new(0.05999999865889549, 0.10000000149011612, 0.03999999910593033),
    RotationInfluence = Vector3.new(1, 0.4000000059604645, 1.2000000476837158),
}
v1.ArrivalFadeOutTime = 0.6
v1.StoryRevealReadyStableTime = 0.25
v1.StoryRevealReadyTimeout = 15
v1.ExtractionAvatarReadyTimeout = 5
v1.ArrivalFadeMaxHold = 30
v1.StoryLoadingLabel = "LOADING PLAYERS"
v1.StoryCountdownLabel = "DEPLOYING IN"
v1.StoryReadyLabel = "PREPARING STORY"
v1.StoryReadyProgress = 0.9
v1.StoryUIFadeLeadCount = 3
v1.StoryUIFadeTime = 3.5
v1.StoryReadyTagReadyText = "READY"
v1.StoryReadyTagNotReadyText = "NOT READY"
v1.StoryReadyTagReadyColor = Color3.fromRGB(118, 226, 122)
v1.StoryReadyTagNotReadyColor = Color3.fromRGB(232, 94, 86)
v1.StoryReadyTagStrokeColor = Color3.fromRGB(4, 8, 12)
v1.StoryReadyTagStrokeThickness = 2
v1.StoryReadyTagFont = Enum.Font.GothamBold
v1.StoryReadyTagSize = UDim2.fromScale(2.2, 0.45)
v1.StoryReadyTagStudsOffset = Vector3.new(0, 0.3499999940395355, 0)
v1.StoryReadyTagMaxDistance = 60
v1.StoryReadyTagMaxTextSize = 30
v1.ClassIcons = {Assault = "rbxassetid://4458718282", Medic = "rbxassetid://2706886795", Support = "rbxassetid://2706886028", Sniper = "rbxassetid://4458692655"}
v1.CountdownBeep = "rbxassetid://10080515826"
v1.CountdownFinalBeep = "rbxassetid://10080515739"
v1.Tips = {
    "Stay close to your squad. No one likes to backtrack to revive a teammate.",
    "Clear nearby threats before reviving a teammate.",
    "A good zombie is a dead zombie. Don't forget to double tap.",
    "Don't forget to deploy your equipment. Your teammates will thank you.",
    "Most enemies have a wind up before they attack. A well-timed block can stagger them.",
    "Keep your health above 0; thats how you stay alive!",
    "Choose your class and loadout before entering a briefing room.",
    "Need some ammo or a medkit? Press G to open the QuickChat to request for help.",
    "Make sure to land your shots. The Rangemaster respects individuals with precision.",
    "Skins give you no tactical advantage whatsoever, unless they come with an integrated flashlight.",
    "John Slasher sends his regards.",
}
return table.freeze(v1)