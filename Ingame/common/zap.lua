local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local u10 = nil
local u11 = nil
local u12 = nil
local u13 = nil
local u14 = nil
local u15 = nil
local u16 = nil
local u17 = nil
local u18 = nil
local v1 = {}
local v2 = CFrame.Angles(0, 0, 0)
local v3 = CFrame.Angles(1.5707963267948966, 0, 0)
local v4 = CFrame.Angles(0, 3.141592653589793, 3.141592653589793)
local v5 = CFrame.Angles(-1.5707963267948966, 0, 0)
local v6 = CFrame.Angles(0, 3.141592653589793, 1.5707963267948966)
local v7 = CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
local v8 = CFrame.Angles(0, 0, 1.5707963267948966)
local v9 = CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
local v10 = CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0)
local v11 = CFrame.Angles(0, -1.5707963267948966, 0)
local v12 = CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
local v13 = CFrame.Angles(0, 1.5707963267948966, 3.141592653589793)
local v14 = CFrame.Angles(0, -1.5707963267948966, 3.141592653589793)
local v15 = CFrame.Angles(0, 3.141592653589793, 0)
local v16 = CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0)
v1[1] = v2
v1[2] = v3
v1[3] = v4
v1[4] = v5
v1[5] = v6
v1[6] = v7
v1[7] = v8
v1[8] = v9
v1[9] = v10
v1[10] = v11
v1[11] = v12
v1[12] = v13
v1[13] = v14
v1[14] = v15
v1[15] = v16
v1[16] = (CFrame.Angles(0, 0, 3.141592653589793))
v2 = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
v3 = CFrame.Angles(0, 0, -1.5707963267948966)
v4 = CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966)
v5 = CFrame.Angles(0, -3.141592653589793, -1.5707963267948966)
v6 = CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966)
v7 = CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)
v8 = CFrame.Angles(0, 1.5707963267948966, 0)
v1[17] = v2
v1[18] = v3
v1[19] = v4
v1[20] = v5
v1[21] = v6
v1[22] = v7
v1[23] = v8
v1[24] = CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
local function alloc(p1) -- Line: 49 -- upvalues: u11 (ref), u12 (ref), u10 (ref), u14 (ref)
    local v1 = u11 + p1
    if u12 < v1 then
        while true do
            v1 = u11 + p1
            if u12 >= v1 then
                break
            end
            u12 = u12 * 2
        end
        v1 = buffer.create(u12)
        buffer.copy(v1, 0, u10, 0, u11)
        u10 = v1
    end
    u14 = u11
    u11 = u11 + p1
    return u14
end
local function read(p1) -- Line: 67 -- upvalues: u16 (ref)
    u16 = u16 + p1
    return u16
end
local function save() -- Line: 74 -- upvalues: u10 (ref), u11 (ref), u12 (ref), u13 (ref)
    return {buff = u10, used = u11, size = u12, inst = u13}
end
local function load(p1) -- Line: 83 -- upvalues: u10 (ref), u11 (ref), u12 (ref), u13 (ref)
    u10 = p1.buff
    u11 = p1.used
    u12 = p1.size
    u13 = p1.inst
end
local function load_empty() -- Line: 95 -- upvalues: u10 (ref), u11 (ref), u12 (ref), u13 (ref)
    u10 = buffer.create(64)
    u11 = 0
    u12 = 64
    u13 = {}
end
u10 = buffer.create(64)
u11 = 0
u12 = 64
u13 = {}
v7 = {}
v8 = {}
if not (RunService:IsRunning()) then
    function v9() end
    v11 = {
        SendEvents = v9,
        InitUser = table.freeze({On = v9}),
        UpdateValue = table.freeze({On = v9}),
        RemoveIndex = table.freeze({On = v9}),
        InsertIndex = table.freeze({On = v9}),
        InsertKey = table.freeze({On = v9}),
        RemoveKey = table.freeze({On = v9}),
        StartSelection = table.freeze({On = v9}),
        UpdateSelectionTimer = table.freeze({On = v9}),
        UpdatePlayerSelection = table.freeze({On = v9}),
        EndSelection = table.freeze({On = v9}),
        SelectionVote = table.freeze({Fire = v9}),
        StatusMessage = table.freeze({On = v9}),
        BannerMessage = table.freeze({On = v9}),
        AdminAnnouncement = table.freeze({On = v9}),
        RefreshServers = table.freeze({Fire = v9}),
        ServerList = table.freeze({On = v9}),
        JoinServer = table.freeze({Fire = v9}),
        JoinServerResponse = table.freeze({On = v9}),
        SetupPodium = table.freeze({On = v9}),
        TellServerLoaded = table.freeze({Fire = v9}),
        OpenGamemodeEndScoreboard = table.freeze({On = v9}),
        CloseGamemodeEndScoreboard = table.freeze({On = v9}),
        PreloadWeapons = table.freeze({On = v9}),
        ClearPreloadedWeapons = table.freeze({On = v9}),
        StartPrivateServer = table.freeze({Fire = v9}),
        PrivateServerCreated = table.freeze({On = v9}),
        JoinPrivateServer = table.freeze({Fire = v9}),
        PositionChangedEvent = table.freeze({On = v9}),
        UpdateLookAngle = table.freeze({Fire = v9}),
        LookAngleEvent = table.freeze({On = v9}),
        NPCRegistryEvent = table.freeze({On = v9}),
        TogglePointsUIEvent = table.freeze({On = v9}),
        ToggleSurvivalShopUIEvent = table.freeze({On = v9}),
        InitSurvivalShopEvent = table.freeze({On = v9}),
        TriggerSelfExplosionEvent = table.freeze({Fire = v9}),
        RenderExplosionEvent = table.freeze({On = v9}),
        Reloading = table.freeze({Fire = v9}),
        SetGameStateKey = table.freeze({On = v9}),
        SetGameStateVariable = table.freeze({On = v9}),
        InitGameState = table.freeze({On = v9}),
        InitQuests = table.freeze({On = v9}),
        UpdateQuestCategory = table.freeze({On = v9}),
        UpdateQuestProgress = table.freeze({On = v9}),
        ChristmasGiftCollected = table.freeze({On = v9}),
        FocusDeactivated = table.freeze({On = v9}),
        InitSkillTree = table.freeze({On = v9}),
        UpdateSkillRank = table.freeze({On = v9}),
        RespecSkillTree = table.freeze({Fire = v9}),
        SyncSkillTreeEconomy = table.freeze({On = v9}),
        RequestPrestige = table.freeze({Fire = v9}),
        HitRegClaim = table.freeze({Fire = v9}),
        RushNpcAttacking = table.freeze({On = v9}),
        RushNpcParried = table.freeze({Fire = v9}),
        RushPhaseChanged = table.freeze({On = v9}),
        RushPtsUpdate = table.freeze({On = v9}),
        RushVoteState = table.freeze({On = v9}),
        RushMissionResult = table.freeze({On = v9}),
        RushBossResult = table.freeze({On = v9}),
        RushContinueChoice = table.freeze({Fire = v9}),
        HintSystemMessage = table.freeze({On = v9}),
        RushShopStock = table.freeze({On = v9}),
        RushShopSync = table.freeze({On = v9}),
        RushShopBuy = table.freeze({Fire = v9}),
        RushShopSell = table.freeze({Fire = v9}),
        RushShopAction = table.freeze({Fire = v9}),
        ActivateFocus = table.freeze({Call = v9}),
    }
    return (table.freeze(v11))
end
if RunService:IsServer() then
    error("Cannot use the client module on the server!")
end
local ZAP = ReplicatedStorage:WaitForChild("ZAP")
local ZAP_RELIABLE = ZAP:WaitForChild("ZAP_RELIABLE")
v12 = ZAP_RELIABLE:IsA("RemoteEvent")
assert(v12, "Expected ZAP_RELIABLE to be a RemoteEvent")
local u381 = {}
local ZAP_UNRELIABLE_0 = ZAP:WaitForChild("ZAP_UNRELIABLE_0")
u381[1] = ZAP_UNRELIABLE_0
u381[2] = ZAP:WaitForChild("ZAP_UNRELIABLE_1")
v13 = u381[1]:IsA("UnreliableRemoteEvent")
assert(v13, "Expected ZAP_UNRELIABLE_0 to be an UnreliableRemoteEvent")
v13 = u381[2]:IsA("UnreliableRemoteEvent")
assert(v13, "Expected ZAP_UNRELIABLE_1 to be an UnreliableRemoteEvent")
local function SendEvents() -- Line: 323 -- upvalues: u11 (ref), u10 (ref), ZAP_RELIABLE (val), u13 (ref), u12 (ref)
    if u11 ~= 0 then
        local v1 = buffer.create(u11)
        buffer.copy(v1, 0, u10, 0, u11)
        ZAP_RELIABLE:FireServer(v1, u13)
        u10 = buffer.create(64)
        u11 = 0
        u12 = 64
        table.clear(u13)
    end
end
RunService.Heartbeat:Connect(SendEvents)
local u419 = table.create(47)
local u422 = table.create(47)
local u425 = table.create(2)
local u428 = table.create(2)
local u429 = 0
u419[0] = {}
u422[0] = {}
u419[1] = {}
u422[1] = {}
u419[2] = {}
u422[2] = {}
u419[3] = {}
u422[3] = {}
u419[4] = {}
u422[4] = {}
u419[5] = {}
u422[5] = {}
u419[6] = {}
u422[6] = {}
u419[7] = {}
u422[7] = {}
u419[8] = {}
u422[8] = {}
u419[9] = {}
u422[9] = {}
u419[10] = {}
u422[10] = {}
u419[11] = {}
u422[11] = {}
u419[12] = {}
u422[12] = {}
u419[13] = {}
u422[13] = {}
u419[14] = {}
u422[14] = {}
u419[15] = {}
u422[15] = {}
u419[16] = {}
u422[16] = {}
u419[17] = {}
u422[17] = {}
u419[18] = {}
u422[18] = {}
u419[19] = {}
u422[19] = {}
u419[20] = {}
u422[20] = {}
u425[0] = {}
u428[0] = {}
u425[1] = {}
u428[1] = {}
u419[21] = {}
u422[21] = {}
u419[22] = {}
u422[22] = {}
u419[23] = {}
u422[23] = {}
u419[24] = {}
u422[24] = {}
u419[25] = {}
u422[25] = {}
u419[26] = {}
u422[26] = {}
u419[27] = {}
u422[27] = {}
u419[28] = {}
u422[28] = {}
u419[29] = {}
u422[29] = {}
u419[30] = {}
u422[30] = {}
u419[31] = {}
u422[31] = {}
u419[32] = {}
u422[32] = {}
u419[33] = {}
u422[33] = {}
u419[34] = {}
u422[34] = {}
u419[35] = {}
u422[35] = {}
u419[36] = {}
u422[36] = {}
u419[37] = {}
u422[37] = {}
u419[38] = {}
u422[38] = {}
u419[39] = {}
u422[39] = {}
u419[40] = {}
u422[40] = {}
u419[41] = {}
u422[41] = {}
u419[42] = {}
u422[42] = {}
u419[43] = {}
u422[43] = {}
u419[44] = {}
u422[44] = {}
u419[45] = {}
u422[45] = {}
u422[46] = table.create(255)
ZAP_RELIABLE.OnClientEvent:Connect(function(p1, p2) -- Line: 441 -- upvalues: u15 (ref), u17 (ref), u16 (ref), u18 (ref), u419 (val), u422 (val)
    local Magnitude, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    u15 = p1
    u17 = p2
    u16 = 0
    u18 = 0
    local v11 = buffer.len(p1)
    local v12 = p1
    while u16 < v11 do
        u16 = u16 + 1
        v4 = buffer.readu8(v12, u16)
        if v4 == 0 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Data = nil
            else
                u18 = u18 + 1
                v5.Data = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.State = nil
            else
                u18 = u18 + 1
                v5.State = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Game = nil
            else
                u18 = u18 + 1
                v5.Game = u17[u18]
            end
            if not (u419[0][1]) then
                table.insert(u422[0], v5)
                v6 = #u422[0]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for InitUser. Did you forget to attach a listener?"):format(#u422[0])))
                end
            else
                v6 = u419[0]
                v7 = nil
                v8 = nil
                for i94, i95 in v6, v7, v8 do
                    task.spawn(i95, v5)
                end
            end
        elseif v4 == 1 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.value = nil
            else
                u18 = u18 + 1
                v5.value = u17[u18]
            end
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.path = buffer.readstring(u15, v9, v6)
            if not (u419[1][1]) then
                table.insert(u422[1], v5)
                v7 = #u422[1]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for UpdateValue. Did you forget to attach a listener?"):format(#u422[1])))
                end
            else
                v7 = u419[1]
                v8 = nil
                v9 = nil
                for i92, i93 in v7, v8, v9 do
                    task.spawn(i93, v5)
                end
            end
        elseif v4 == 2 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.path = buffer.readstring(u15, v9, v6)
            u16 = u16 + 4
            v5.index = buffer.readi32(u15, u16)
            if not (u419[2][1]) then
                table.insert(u422[2], v5)
                v7 = #u422[2]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for RemoveIndex. Did you forget to attach a listener?"):format(#u422[2])))
                end
            else
                v7 = u419[2]
                v8 = nil
                v9 = nil
                for i90, i91 in v7, v8, v9 do
                    task.spawn(i91, v5)
                end
            end
        elseif v4 == 3 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.path = buffer.readstring(u15, v9, v6)
            u16 = u16 + 4
            v5.index = buffer.readi32(u15, u16)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.value = nil
            else
                u18 = u18 + 1
                v5.value = u17[u18]
            end
            if not (u419[3][1]) then
                table.insert(u422[3], v5)
                v7 = #u422[3]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for InsertIndex. Did you forget to attach a listener?"):format(#u422[3])))
                end
            else
                v7 = u419[3]
                v8 = nil
                v9 = nil
                for i88, i89 in v7, v8, v9 do
                    task.spawn(i89, v5)
                end
            end
        elseif v4 == 4 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.path = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.key = buffer.readstring(u15, v10, v7)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.value = nil
            else
                u18 = u18 + 1
                v5.value = u17[u18]
            end
            if not (u419[4][1]) then
                table.insert(u422[4], v5)
                v8 = #u422[4]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for InsertKey. Did you forget to attach a listener?"):format(#u422[4])))
                end
            else
                v8 = u419[4]
                v9 = nil
                v10 = nil
                for i86, i87 in v8, v9, v10 do
                    task.spawn(i87, v5)
                end
            end
        elseif v4 == 5 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.path = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.key = buffer.readstring(u15, v10, v7)
            if not (u419[5][1]) then
                table.insert(u422[5], v5)
                v8 = #u422[5]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for RemoveKey. Did you forget to attach a listener?"):format(#u422[5])))
                end
            else
                v8 = u419[5]
                v9 = nil
                v10 = nil
                for i84, i85 in v8, v9, v10 do
                    task.spawn(i85, v5)
                end
            end
        elseif v4 == 6 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Maps = nil
            else
                u18 = u18 + 1
                v5.Maps = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Difficulties = nil
            else
                u18 = u18 + 1
                v5.Difficulties = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Timer = nil
            else
                u18 = u18 + 1
                v5.Timer = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Selections = nil
            else
                u18 = u18 + 1
                v5.Selections = u17[u18]
            end
            if not (u419[6][1]) then
                table.insert(u422[6], v5)
                v6 = #u422[6]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for StartSelection. Did you forget to attach a listener?"):format(#u422[6])))
                end
            else
                v6 = u419[6]
                v7 = nil
                v8 = nil
                for i82, i83 in v6, v7, v8 do
                    task.spawn(i83, v5)
                end
            end
        elseif v4 == 7 then
            v5 = {}
            u16 = u16 + 8
            v5.Timer = buffer.readf64(u15, u16)
            if not (u419[7][1]) then
                table.insert(u422[7], v5)
                v6 = #u422[7]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for UpdateSelectionTimer. Did you forget to attach a listener?"):format(#u422[7])))
                end
            else
                v6 = u419[7]
                v7 = nil
                v8 = nil
                for i80, i81 in v6, v7, v8 do
                    task.spawn(i81, v5)
                end
            end
        elseif v4 == 8 then
            v5 = {}
            u16 = u16 + 8
            v5.PlayerID = buffer.readf64(u15, u16)
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Type = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.Value = buffer.readstring(u15, v10, v7)
            if not (u419[8][1]) then
                table.insert(u422[8], v5)
                v8 = #u422[8]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for UpdatePlayerSelection. Did you forget to attach a listener?"):format(#u422[8])))
                end
            else
                v8 = u419[8]
                v9 = nil
                v10 = nil
                for i78, i79 in v8, v9, v10 do
                    task.spawn(i79, v5)
                end
            end
        elseif v4 == 9 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Map = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.Difficulty = buffer.readstring(u15, v10, v7)
            if not (u419[9][1]) then
                table.insert(u422[9], v5)
                v8 = #u422[9]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for EndSelection. Did you forget to attach a listener?"):format(#u422[9])))
                end
            else
                v8 = u419[9]
                v9 = nil
                v10 = nil
                for i76, i77 in v8, v9, v10 do
                    task.spawn(i77, v5)
                end
            end
        elseif v4 == 10 then
            v5 = {}
            u16 = u16 + 1
            v5.type = buffer.readu8(u15, u16)
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.message = buffer.readstring(u15, v9, v6)
            if not (u419[10][1]) then
                table.insert(u422[10], v5)
                v7 = #u422[10]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for StatusMessage. Did you forget to attach a listener?"):format(#u422[10])))
                end
            else
                v7 = u419[10]
                v8 = nil
                v9 = nil
                for i74, i75 in v7, v8, v9 do
                    task.spawn(i75, v5)
                end
            end
        elseif v4 == 11 then
            v5 = {}
            u16 = u16 + 1
            v5.type = buffer.readu8(u15, u16)
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.header = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.message = buffer.readstring(u15, v10, v7)
            if not (u419[11][1]) then
                table.insert(u422[11], v5)
                v8 = #u422[11]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for BannerMessage. Did you forget to attach a listener?"):format(#u422[11])))
                end
            else
                v8 = u419[11]
                v9 = nil
                v10 = nil
                for i72, i73 in v8, v9, v10 do
                    task.spawn(i73, v5)
                end
            end
        elseif v4 == 12 then
            v5 = {}
            u16 = u16 + 8
            v5.userId = buffer.readf64(u15, u16)
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.username = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.message = buffer.readstring(u15, v10, v7)
            u16 = u16 + 4
            v5.duration = buffer.readf32(u15, u16)
            if not (u419[12][1]) then
                table.insert(u422[12], v5)
                v8 = #u422[12]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for AdminAnnouncement. Did you forget to attach a listener?"):format(#u422[12])))
                end
            else
                v8 = u419[12]
                v9 = nil
                v10 = nil
                for i70, i71 in v8, v9, v10 do
                    task.spawn(i71, v5)
                end
            end
        elseif v4 == 13 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.ServerType = buffer.readstring(u15, v9, v6)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Servers = nil
            else
                u18 = u18 + 1
                v5.Servers = u17[u18]
            end
            if not (u419[13][1]) then
                table.insert(u422[13], v5)
                v7 = #u422[13]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for ServerList. Did you forget to attach a listener?"):format(#u422[13])))
                end
            else
                v7 = u419[13]
                v8 = nil
                v9 = nil
                for i68, i69 in v7, v8, v9 do
                    task.spawn(i69, v5)
                end
            end
        elseif v4 == 14 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Message = buffer.readstring(u15, v9, v6)
            if not (u419[14][1]) then
                table.insert(u422[14], v5)
                v7 = #u422[14]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for JoinServerResponse. Did you forget to attach a listener?"):format(#u422[14])))
                end
            else
                v7 = u419[14]
                v8 = nil
                v9 = nil
                for i66, i67 in v7, v8, v9 do
                    task.spawn(i67, v5)
                end
            end
        elseif v4 == 15 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Players = nil
            else
                u18 = u18 + 1
                v5.Players = u17[u18]
            end
            if not (u419[15][1]) then
                table.insert(u422[15], v5)
                v6 = #u422[15]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for SetupPodium. Did you forget to attach a listener?"):format(#u422[15])))
                end
            else
                v6 = u419[15]
                v7 = nil
                v8 = nil
                for i64, i65 in v6, v7, v8 do
                    task.spawn(i65, v5)
                end
            end
        elseif v4 == 16 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Players = nil
            else
                u18 = u18 + 1
                v5.Players = u17[u18]
            end
            if not (u419[16][1]) then
                table.insert(u422[16], v5)
                v6 = #u422[16]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for OpenGamemodeEndScoreboard. Did you forget to attach a listener?"):format(#u422[16])))
                end
            else
                v6 = u419[16]
                v7 = nil
                v8 = nil
                for i62, i63 in v6, v7, v8 do
                    task.spawn(i63, v5)
                end
            end
        elseif v4 == 17 then
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5 = nil
            else
                u18 = u18 + 1
                v5 = u17[u18]
            end
            if not (u419[17][1]) then
                table.insert(u422[17], v5)
                v6 = #u422[17]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for CloseGamemodeEndScoreboard. Did you forget to attach a listener?"):format(#u422[17])))
                end
            else
                v6 = u419[17]
                v7 = nil
                v8 = nil
                for i60, i61 in v6, v7, v8 do
                    task.spawn(i61, v5)
                end
            end
        elseif v4 == 18 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Weapons = nil
            else
                u18 = u18 + 1
                v5.Weapons = u17[u18]
            end
            if not (u419[18][1]) then
                table.insert(u422[18], v5)
                v6 = #u422[18]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for PreloadWeapons. Did you forget to attach a listener?"):format(#u422[18])))
                end
            else
                v6 = u419[18]
                v7 = nil
                v8 = nil
                for i58, i59 in v6, v7, v8 do
                    task.spawn(i59, v5)
                end
            end
        elseif v4 == 19 then
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5 = nil
            else
                u18 = u18 + 1
                v5 = u17[u18]
            end
            if not (u419[19][1]) then
                table.insert(u422[19], v5)
                v6 = #u422[19]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for ClearPreloadedWeapons. Did you forget to attach a listener?"):format(#u422[19])))
                end
            else
                v6 = u419[19]
                v7 = nil
                v8 = nil
                for i56, i57 in v6, v7, v8 do
                    task.spawn(i57, v5)
                end
            end
        elseif v4 == 20 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.PrivateServerId = buffer.readstring(u15, v9, v6)
            if not (u419[20][1]) then
                table.insert(u422[20], v5)
                v7 = #u422[20]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for PrivateServerCreated. Did you forget to attach a listener?"):format(#u422[20])))
                end
            else
                v7 = u419[20]
                v8 = nil
                v9 = nil
                for i54, i55 in v7, v8, v9 do
                    task.spawn(i55, v5)
                end
            end
        elseif v4 == 21 then
            v5 = {}
            u16 = u16 + 8
            v5.UID = buffer.readf64(u15, u16)
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Type = buffer.readstring(u15, v9, v6)
            if not (u419[21][1]) then
                table.insert(u422[21], v5)
                v7 = #u422[21]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for NPCRegistryEvent. Did you forget to attach a listener?"):format(#u422[21])))
                end
            else
                v7 = u419[21]
                v8 = nil
                v9 = nil
                for i52, i53 in v7, v8, v9 do
                    task.spawn(i53, v5)
                end
            end
        elseif v4 == 22 then
            v5 = {}
            u16 = u16 + 1
            v6 = buffer.readu8(u15, u16) == 1
            v5.IsVisible = v6
            if not (u419[22][1]) then
                table.insert(u422[22], v5)
                v6 = #u422[22]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for TogglePointsUIEvent. Did you forget to attach a listener?"):format(#u422[22])))
                end
            else
                v6 = u419[22]
                v7 = nil
                v8 = nil
                for i50, i51 in v6, v7, v8 do
                    task.spawn(i51, v5)
                end
            end
        elseif v4 == 23 then
            v5 = {}
            u16 = u16 + 1
            v6 = buffer.readu8(u15, u16) == 1
            v5.IsVisible = v6
            if not (u419[23][1]) then
                table.insert(u422[23], v5)
                v6 = #u422[23]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for ToggleSurvivalShopUIEvent. Did you forget to attach a listener?"):format(#u422[23])))
                end
            else
                v6 = u419[23]
                v7 = nil
                v8 = nil
                for i48, i49 in v6, v7, v8 do
                    task.spawn(i49, v5)
                end
            end
        elseif v4 == 24 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.SurvivalShopItemsInfo = nil
            else
                u18 = u18 + 1
                v5.SurvivalShopItemsInfo = u17[u18]
            end
            if not (u419[24][1]) then
                table.insert(u422[24], v5)
                v6 = #u422[24]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for InitSurvivalShopEvent. Did you forget to attach a listener?"):format(#u422[24])))
                end
            else
                v6 = u419[24]
                v7 = nil
                v8 = nil
                for i46, i47 in v6, v7, v8 do
                    task.spawn(i47, v5)
                end
            end
        elseif v4 == 25 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v5.ExplosionType = buffer.readstring(u15, u16, v6)
            u16 = u16 + 4
            v8 = buffer.readf32(u15, u16)
            u16 = u16 + 4
            v9 = buffer.readf32(u15, u16)
            u16 = u16 + 4
            v5.Position = vector.create(v8, v9, (buffer.readf32(u15, u16)))
            u16 = u16 + 8
            v5.BlastRadius = buffer.readf64(u15, u16)
            if not (u419[25][1]) then
                table.insert(u422[25], v5)
                v7 = #u422[25]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for RenderExplosionEvent. Did you forget to attach a listener?"):format(#u422[25])))
                end
            else
                v7 = u419[25]
                v8 = nil
                v9 = nil
                for i44, i45 in v7, v8, v9 do
                    task.spawn(i45, v5)
                end
            end
        elseif v4 == 26 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Key = buffer.readstring(u15, v9, v6)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Value = nil
            else
                u18 = u18 + 1
                v5.Value = u17[u18]
            end
            if not (u419[26][1]) then
                table.insert(u422[26], v5)
                v7 = #u422[26]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for SetGameStateKey. Did you forget to attach a listener?"):format(#u422[26])))
                end
            else
                v7 = u419[26]
                v8 = nil
                v9 = nil
                for i42, i43 in v7, v8, v9 do
                    task.spawn(i43, v5)
                end
            end
        elseif v4 == 27 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Key = buffer.readstring(u15, v9, v6)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Value = nil
            else
                u18 = u18 + 1
                v5.Value = u17[u18]
            end
            if not (u419[27][1]) then
                table.insert(u422[27], v5)
                v7 = #u422[27]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for SetGameStateVariable. Did you forget to attach a listener?"):format(#u422[27])))
                end
            else
                v7 = u419[27]
                v8 = nil
                v9 = nil
                for i40, i41 in v7, v8, v9 do
                    task.spawn(i41, v5)
                end
            end
        elseif v4 == 28 then
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5 = nil
            else
                u18 = u18 + 1
                v5 = u17[u18]
            end
            if not (u419[28][1]) then
                table.insert(u422[28], v5)
                v6 = #u422[28]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for InitGameState. Did you forget to attach a listener?"):format(#u422[28])))
                end
            else
                v6 = u419[28]
                v7 = nil
                v8 = nil
                for i38, i39 in v6, v7, v8 do
                    task.spawn(i39, v5)
                end
            end
        elseif v4 == 29 then
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5 = nil
            else
                u18 = u18 + 1
                v5 = u17[u18]
            end
            if not (u419[29][1]) then
                table.insert(u422[29], v5)
                v6 = #u422[29]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for InitQuests. Did you forget to attach a listener?"):format(#u422[29])))
                end
            else
                v6 = u419[29]
                v7 = nil
                v8 = nil
                for i36, i37 in v6, v7, v8 do
                    task.spawn(i37, v5)
                end
            end
        elseif v4 == 30 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Category = buffer.readstring(u15, v9, v6)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.Quests = nil
            else
                u18 = u18 + 1
                v5.Quests = u17[u18]
            end
            if not (u419[30][1]) then
                table.insert(u422[30], v5)
                v7 = #u422[30]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for UpdateQuestCategory. Did you forget to attach a listener?"):format(#u422[30])))
                end
            else
                v7 = u419[30]
                v8 = nil
                v9 = nil
                for i34, i35 in v7, v8, v9 do
                    task.spawn(i35, v5)
                end
            end
        elseif v4 == 31 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.Category = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.QuestKey = buffer.readstring(u15, v10, v7)
            u16 = u16 + 8
            v5.Progress = buffer.readf64(u15, u16)
            if not (u419[31][1]) then
                table.insert(u422[31], v5)
                v8 = #u422[31]
                if 64 < v8 then
                    warn((("[ZAP] %* events in queue for UpdateQuestProgress. Did you forget to attach a listener?"):format(#u422[31])))
                end
            else
                v8 = u419[31]
                v9 = nil
                v10 = nil
                for i32, i33 in v8, v9, v10 do
                    task.spawn(i33, v5)
                end
            end
        elseif v4 == 32 then
            v5 = {}
            u18 = u18 + 1
            v5.Player = u17[u18]
            v7 = v5.Player ~= nil
            assert(v7)
            u16 = u16 + 4
            v7 = buffer.readf32(u15, u16)
            u16 = u16 + 4
            v8 = buffer.readf32(u15, u16)
            u16 = u16 + 4
            v6 = Vector3.new(v7, v8, (buffer.readf32(u15, u16)))
            u16 = u16 + 4
            v8 = buffer.readf32(u15, u16)
            u16 = u16 + 4
            v9 = buffer.readf32(u15, u16)
            u16 = u16 + 4
            v7 = Vector3.new(v8, v9, (buffer.readf32(u15, u16)))
            Magnitude = v7.Magnitude
            if Magnitude == 0 then
                v5.Gift = CFrame.new(v6)
            else
                v5.Gift = CFrame.fromAxisAngle(v7, Magnitude) + v6
            end
            if not (u419[32][1]) then
                table.insert(u422[32], v5)
                v9 = #u422[32]
                if 64 < v9 then
                    warn((("[ZAP] %* events in queue for ChristmasGiftCollected. Did you forget to attach a listener?"):format(#u422[32])))
                end
            else
                v9 = u419[32]
                v10 = nil
                v1 = nil
                for i30, i31 in v9, v10, v1 do
                    task.spawn(i31, v5)
                end
            end
        elseif v4 == 33 then
            v5 = {}
            if not (u419[33][1]) then
                table.insert(u422[33], v5)
                v6 = #u422[33]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for FocusDeactivated. Did you forget to attach a listener?"):format(#u422[33])))
                end
            else
                v6 = u419[33]
                v7 = nil
                v8 = nil
                for i28, i29 in v6, v7, v8 do
                    task.spawn(i29, v5)
                end
            end
        elseif v4 == 34 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            v7 = 1
            for i25 = 1, v6, v7 do
                u16 = u16 + 2
                v1 = buffer.readu16(u15, u16)
                u16 = u16 + v1
                v9 = buffer.readstring(u15, u16, v1)
                u16 = u16 + 2
                v5[v9] = buffer.readi16(u15, u16)
            end
            if not (u419[34][1]) then
                table.insert(u422[34], v5)
                v6 = #u422[34]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for InitSkillTree. Did you forget to attach a listener?"):format(#u422[34])))
                end
            else
                v6 = u419[34]
                v7 = nil
                v8 = nil
                for i26, i27 in v6, v7, v8 do
                    task.spawn(i27, v5)
                end
            end
        elseif v4 == 35 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.SkillId = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v5.Rank = buffer.readi16(u15, u16)
            if not (u419[35][1]) then
                table.insert(u422[35], v5)
                v7 = #u422[35]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for UpdateSkillRank. Did you forget to attach a listener?"):format(#u422[35])))
                end
            else
                v7 = u419[35]
                v8 = nil
                v9 = nil
                for i23, i24 in v7, v8, v9 do
                    task.spawn(i24, v5)
                end
            end
        elseif v4 == 36 then
            v5 = {}
            u16 = u16 + 2
            v5.SP = buffer.readi16(u15, u16)
            u16 = u16 + 2
            v5.SPCap = buffer.readi16(u15, u16)
            u16 = u16 + 2
            v5.SPSpent = buffer.readi16(u15, u16)
            u16 = u16 + 4
            v5.XPBar = buffer.readi32(u15, u16)
            u16 = u16 + 2
            v5.DailyEarned = buffer.readi16(u15, u16)
            u16 = u16 + 2
            v5.DailyEarnCap = buffer.readi16(u15, u16)
            u16 = u16 + 2
            v5.PrestigeLevel = buffer.readi16(u15, u16)
            u16 = u16 + 4
            v5.ZBucks = buffer.readi32(u15, u16)
            u16 = u16 + 4
            v5.ZBucksInvested = buffer.readi32(u15, u16)
            if not (u419[36][1]) then
                table.insert(u422[36], v5)
                v6 = #u422[36]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for SyncSkillTreeEconomy. Did you forget to attach a listener?"):format(#u422[36])))
                end
            else
                v6 = u419[36]
                v7 = nil
                v8 = nil
                for i21, i22 in v6, v7, v8 do
                    task.spawn(i22, v5)
                end
            end
        elseif v4 == 37 then
            v5 = {}
            u16 = u16 + 4
            v5.entityId = buffer.readu32(u15, u16)
            if not (u419[37][1]) then
                table.insert(u422[37], v5)
                v6 = #u422[37]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for RushNpcAttacking. Did you forget to attach a listener?"):format(#u422[37])))
                end
            else
                v6 = u419[37]
                v7 = nil
                v8 = nil
                for i19, i20 in v6, v7, v8 do
                    task.spawn(i20, v5)
                end
            end
        elseif v4 == 38 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.phase = buffer.readstring(u15, v9, v6)
            u16 = u16 + 1
            v5.cycle = buffer.readu8(u15, u16)
            u16 = u16 + 1
            v5.missionIndex = buffer.readu8(u15, u16)
            u16 = u16 + 1
            v5.livesRemaining = buffer.readu8(u15, u16)
            if not (u419[38][1]) then
                table.insert(u422[38], v5)
                v7 = #u422[38]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for RushPhaseChanged. Did you forget to attach a listener?"):format(#u422[38])))
                end
            else
                v7 = u419[38]
                v8 = nil
                v9 = nil
                for i17, i18 in v7, v8, v9 do
                    task.spawn(i18, v5)
                end
            end
        elseif v4 == 39 then
            v5 = {}
            u16 = u16 + 4
            v5.pts = buffer.readi32(u15, u16)
            if not (u419[39][1]) then
                table.insert(u422[39], v5)
                v6 = #u422[39]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for RushPtsUpdate. Did you forget to attach a listener?"):format(#u422[39])))
                end
            else
                v6 = u419[39]
                v7 = nil
                v8 = nil
                for i15, i16 in v6, v7, v8 do
                    task.spawn(i16, v5)
                end
            end
        elseif v4 == 40 then
            v5 = {}
            u16 = u16 + 1
            v5.pad1Count = buffer.readu8(u15, u16)
            u16 = u16 + 1
            v5.pad2Count = buffer.readu8(u15, u16)
            u16 = u16 + 1
            v5.pad3Count = buffer.readu8(u15, u16)
            u16 = u16 + 4
            v5.countdown = buffer.readf32(u15, u16)
            u16 = u16 + 1
            v6 = buffer.readu8(u15, u16) == 1
            v5.isCountingDown = v6
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.pad1Label = buffer.readstring(u15, v9, v6)
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            u16 = u16 + v7
            v10 = u16
            v5.pad2Label = buffer.readstring(u15, v10, v7)
            u16 = u16 + 2
            v8 = buffer.readu16(u15, u16)
            u16 = u16 + v8
            v1 = u16
            v5.pad3Label = buffer.readstring(u15, v1, v8)
            if not (u419[40][1]) then
                table.insert(u422[40], v5)
                v9 = #u422[40]
                if 64 < v9 then
                    warn((("[ZAP] %* events in queue for RushVoteState. Did you forget to attach a listener?"):format(#u422[40])))
                end
            else
                v9 = u419[40]
                v10 = nil
                v1 = nil
                for i13, i14 in v9, v10, v1 do
                    task.spawn(i14, v5)
                end
            end
        elseif v4 == 41 then
            v5 = {}
            u16 = u16 + 1
            v6 = buffer.readu8(u15, u16) == 1
            v5.success = v6
            u16 = u16 + 4
            v5.ptsEarned = buffer.readi32(u15, u16)
            if not (u419[41][1]) then
                table.insert(u422[41], v5)
                v6 = #u422[41]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for RushMissionResult. Did you forget to attach a listener?"):format(#u422[41])))
                end
            else
                v6 = u419[41]
                v7 = nil
                v8 = nil
                for i11, i12 in v6, v7, v8 do
                    task.spawn(i12, v5)
                end
            end
        elseif v4 == 42 then
            v5 = {}
            u16 = u16 + 1
            v6 = buffer.readu8(u15, u16) == 1
            v5.success = v6
            u16 = u16 + 4
            v5.zbucksEarned = buffer.readi32(u15, u16)
            if not (u419[42][1]) then
                table.insert(u422[42], v5)
                v6 = #u422[42]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for RushBossResult. Did you forget to attach a listener?"):format(#u422[42])))
                end
            else
                v6 = u419[42]
                v7 = nil
                v8 = nil
                for i9, i10 in v6, v7, v8 do
                    task.spawn(i10, v5)
                end
            end
        elseif v4 == 43 then
            v5 = {}
            u16 = u16 + 2
            v6 = buffer.readu16(u15, u16)
            u16 = u16 + v6
            v9 = u16
            v5.message = buffer.readstring(u15, v9, v6)
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.duration = nil
            else
                u16 = u16 + 4
                v5.duration = buffer.readf32(u15, u16)
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.key = nil
            else
                u16 = u16 + 2
                v7 = buffer.readu16(u15, u16)
                u16 = u16 + v7
                v5.key = buffer.readstring(u15, u16, v7)
            end
            if not (u419[43][1]) then
                table.insert(u422[43], v5)
                v7 = #u422[43]
                if 64 < v7 then
                    warn((("[ZAP] %* events in queue for HintSystemMessage. Did you forget to attach a listener?"):format(#u422[43])))
                end
            else
                v7 = u419[43]
                v8 = nil
                v9 = nil
                for i7, i8 in v7, v8, v9 do
                    task.spawn(i8, v5)
                end
            end
        elseif v4 == 44 then
            v5 = {primary = {}}
            u16 = u16 + 2
            v7 = buffer.readu16(u15, u16)
            v8 = 1
            for k = 1, v7, v8 do
                u16 = u16 + 2
                v1 = buffer.readu16(u15, u16)
                u16 = u16 + v1
                v10 = buffer.readstring(u15, u16, v1)
                v5.primary[k] = v10
            end
            v5.secondary = {}
            u16 = u16 + 2
            v8 = buffer.readu16(u15, u16)
            v9 = 1
            for n = 1, v8, v9 do
                u16 = u16 + 2
                v2 = buffer.readu16(u15, u16)
                u16 = u16 + v2
                v1 = buffer.readstring(u15, u16, v2)
                v5.secondary[n] = v1
            end
            v5.melee = {}
            u16 = u16 + 2
            v9 = buffer.readu16(u15, u16)
            v10 = 1
            for m = 1, v9, v10 do
                u16 = u16 + 2
                v3 = buffer.readu16(u15, u16)
                u16 = u16 + v3
                v2 = buffer.readstring(u15, u16, v3)
                v5.melee[m] = v2
            end
            if not (u419[44][1]) then
                table.insert(u422[44], v5)
                v9 = #u422[44]
                if 64 < v9 then
                    warn((("[ZAP] %* events in queue for RushShopStock. Did you forget to attach a listener?"):format(#u422[44])))
                end
            else
                v9 = u419[44]
                v10 = nil
                v1 = nil
                for i5, i6 in v9, v10, v1 do
                    task.spawn(i6, v5)
                end
            end
        elseif v4 == 45 then
            v5 = {}
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.ownedWeapons = nil
            else
                u18 = u18 + 1
                v5.ownedWeapons = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.equippedWeapons = nil
            else
                u18 = u18 + 1
                v5.equippedWeapons = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.weaponUpgrades = nil
            else
                u18 = u18 + 1
                v5.weaponUpgrades = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.purchasedAttachments = nil
            else
                u18 = u18 + 1
                v5.purchasedAttachments = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.weaponAttachments = nil
            else
                u18 = u18 + 1
                v5.weaponAttachments = u17[u18]
            end
            u16 = u16 + 1
            if buffer.readu8(u15, u16) ~= 1 then
                v5.weaponInvestment = nil
            else
                u18 = u18 + 1
                v5.weaponInvestment = u17[u18]
            end
            if not (u419[45][1]) then
                table.insert(u422[45], v5)
                v6 = #u422[45]
                if 64 < v6 then
                    warn((("[ZAP] %* events in queue for RushShopSync. Did you forget to attach a listener?"):format(#u422[45])))
                end
            else
                v6 = u419[45]
                v7 = nil
                v8 = nil
                for i, j in v6, v7, v8 do
                    task.spawn(j, v5)
                end
            end
        elseif v4 ~= 46 then
            error("Unknown event id")
        else
            u16 = u16 + 1
            v5 = buffer.readu8(u15, u16)
            u16 = u16 + 1
            v6 = buffer.readu8(u15, u16) == 1
            v7 = u422[46][v5]
            if v7 then
                task.spawn(v7, v6)
            end
            v8 = u422[46]
            v8[v5] = nil
        end
    end
end)
u381[1].OnClientEvent:Connect(function(p1, p2) -- Line: 1382 -- upvalues: u15 (ref), u17 (ref), u16 (ref), u18 (ref), u425 (val), u428 (val)
    local v1, v2, v3, v4
    u15 = p1
    u17 = p2
    u16 = 0
    u18 = 0
    local v5 = {NPCs = {}}
    u16 = u16 + 2
    local v6 = buffer.readu16(u15, u16)
    local v7 = 1
    for i = 1, v6, v7 do
        u16 = u16 + 2
        v2 = buffer.readu16(u15, u16)
        u16 = u16 + 4
        v4 = buffer.readf32(u15, u16)
        u16 = u16 + 4
        v1 = buffer.readf32(u15, u16)
        u16 = u16 + 4
        v3 = vector.create(v4, v1, (buffer.readf32(u15, u16)))
        v5.NPCs[v2] = v3
    end
    u16 = u16 + 8
    v5.ServerTick = buffer.readf64(u15, u16)
    u16 = u16 + 1
    v5.GroupIndex = buffer.readu8(u15, u16)
    if not (u425[0][1]) then
        table.insert(u428[0], v5)
        v6 = #u428[0]
        if 64 < v6 then
            warn((("[ZAP] %* events in queue for PositionChangedEvent. Did you forget to attach a listener?"):format(#u428[0])))
        end
        return
    end
    v6 = u425[0]
    v7 = nil
    local v8 = nil
    for j, k in v6, v7, v8 do
        task.spawn(k, v5)
    end
end)
u381[2].OnClientEvent:Connect(function(p1, p2) -- Line: 1410 -- upvalues: u15 (ref), u17 (ref), u16 (ref), u18 (ref), u425 (val), u428 (val)
    local v1
    u15 = p1
    u17 = p2
    u16 = 0
    u18 = 0
    local v2 = {}
    u16 = u16 + 4
    v2.Pitch = buffer.readf32(u15, u16)
    u16 = u16 + 4
    v2.Yaw = buffer.readf32(u15, u16)
    u16 = u16 + 8
    v2.ClientTick = buffer.readf64(u15, u16)
    u18 = u18 + 1
    v2.Player = u17[u18]
    local v3 = v2.Player ~= nil
    assert(v3)
    if not (u425[1][1]) then
        table.insert(u428[1], v2)
        v1 = #u428[1]
        if 64 < v1 then
            warn((("[ZAP] %* events in queue for LookAngleEvent. Did you forget to attach a listener?"):format(#u428[1])))
        end
        return
    end
    v1 = u425[1]
    v3 = nil
    local v4 = nil
    for i, j in v1, v3, v4 do
        task.spawn(j, v2)
    end
end)
table.freeze(v8)
return {
    SendEvents = SendEvents,
    SelectionVote = {
        Fire = function(p1) -- Line: 1439 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 0)
            local v1 = #p1.Type
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.Type, v1)
            local v2 = #p1.Value
            alloc(2)
            buffer.writeu16(u10, u14, v2)
            alloc(v2)
            buffer.writestring(u10, u14, p1.Value, v2)
        end,
    },
    RefreshServers = {
        Fire = function(p1) -- Line: 1458 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 1)
            local v1 = #p1.ServerType
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.ServerType, v1)
        end,
    },
    JoinServer = {
        Fire = function(p1) -- Line: 1471 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 2)
            local v1 = #p1.ServerType
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.ServerType, v1)
            local v2 = #p1.ServerID
            alloc(2)
            buffer.writeu16(u10, u14, v2)
            alloc(v2)
            buffer.writestring(u10, u14, p1.ServerID, v2)
        end,
    },
    TellServerLoaded = {
        Fire = function(p1) -- Line: 1490 -- upvalues: alloc (val), u10 (ref), u14 (ref), u13 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 3)
            if p1 == nil then
                alloc(1)
                buffer.writeu8(u10, u14, 0)
                return
            end
            alloc(1)
            buffer.writeu8(u10, u14, 1)
            table.insert(u13, p1)
        end,
    },
    StartPrivateServer = {
        Fire = function(p1) -- Line: 1504 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 4)
        end,
    },
    JoinPrivateServer = {
        Fire = function(p1) -- Line: 1511 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 5)
            local v1 = #p1.PrivateServerId
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.PrivateServerId, v1)
        end,
    },
    UpdateLookAngle = {
        Fire = function(p1) -- Line: 1524 -- upvalues: u10 (ref), u11 (ref), u12 (ref), u13 (ref), alloc (val), u14 (ref), u381 (val)
            local v1 = {buff = u10, used = u11, size = u12, inst = u13}
            u10 = buffer.create(64)
            u11 = 0
            u12 = 64
            u13 = {}
            alloc(4)
            buffer.writef32(u10, u14, p1.Pitch)
            alloc(4)
            buffer.writef32(u10, u14, p1.Yaw)
            alloc(8)
            buffer.writef64(u10, u14, p1.ClientTick)
            local v2 = buffer.create(u11)
            buffer.copy(v2, 0, u10, 0, u11)
            u381[1]:FireServer(v2, u13)
            u10 = v1.buff
            u11 = v1.used
            u12 = v1.size
            u13 = v1.inst
        end,
    },
    TriggerSelfExplosionEvent = {
        Fire = function(p1) -- Line: 1544 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 6)
            local v1 = #p1.ExplosionType
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.ExplosionType, v1)
        end,
    },
    Reloading = {
        Fire = function(p1) -- Line: 1557 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 7)
            alloc(2)
            buffer.writeu16(u10, u14, p1.Slot)
        end,
    },
    RespecSkillTree = {
        Fire = function(p1) -- Line: 1567 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 8)
        end,
    },
    RequestPrestige = {
        Fire = function(p1) -- Line: 1574 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 9)
        end,
    },
    HitRegClaim = {
        Fire = function(p1) -- Line: 1581 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            local v1, v2
            alloc(1)
            buffer.writeu8(u10, u14, 10)
            alloc(1)
            buffer.writeu8(u10, u14, p1.moduleId)
            local v3 = #p1.hits
            alloc(2)
            buffer.writeu16(u10, u14, v3)
            local v4 = v3
            local v5 = 1
            local v6 = p1
            for i = 1, v4, v5 do
                v1 = v6.hits[i]
                v2 = #v1.partName
                alloc(2)
                buffer.writeu16(u10, u14, v2)
                alloc(v2)
                buffer.writestring(u10, u14, v1.partName, v2)
                alloc(4)
                buffer.writef32(u10, u14, v1.hitPos.x)
                alloc(4)
                buffer.writef32(u10, u14, v1.hitPos.y)
                alloc(4)
                buffer.writef32(u10, u14, v1.hitPos.z)
                alloc(4)
                buffer.writef32(u10, u14, v1.origin.x)
                alloc(4)
                buffer.writef32(u10, u14, v1.origin.y)
                alloc(4)
                buffer.writef32(u10, u14, v1.origin.z)
                alloc(4)
                buffer.writeu32(u10, u14, v1.targetId)
                alloc(2)
                buffer.writeu16(u10, u14, v1.bullet)
                if v1.hitPosDiff ~= nil then
                    alloc(1)
                    buffer.writeu8(u10, u14, 1)
                    alloc(4)
                    buffer.writef32(u10, u14, v1.hitPosDiff.x)
                    alloc(4)
                    buffer.writef32(u10, u14, v1.hitPosDiff.y)
                    alloc(4)
                    buffer.writef32(u10, u14, v1.hitPosDiff.z)
                else
                    alloc(1)
                    buffer.writeu8(u10, u14, 0)
                end
            end
        end,
    },
    RushNpcParried = {
        Fire = function(p1) -- Line: 1639 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 11)
            alloc(4)
            buffer.writeu32(u10, u14, p1.entityId)
        end,
    },
    RushContinueChoice = {
        Fire = function(p1) -- Line: 1649 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            local v1
            alloc(1)
            buffer.writeu8(u10, u14, 12)
            alloc(1)
            if not p1.continueRun then
                v1 = 0
            else
                v1 = 1
            end
            buffer.writeu8(u10, u14, v1)
        end,
    },
    RushShopBuy = {
        Fire = function(p1) -- Line: 1659 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 13)
            local v1 = #p1.weaponName
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.weaponName, v1)
        end,
    },
    RushShopSell = {
        Fire = function(p1) -- Line: 1672 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 14)
            local v1 = #p1.weaponId
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.weaponId, v1)
        end,
    },
    RushShopAction = {
        Fire = function(p1) -- Line: 1685 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            buffer.writeu8(u10, u14, 15)
            local v1 = #p1.action
            alloc(2)
            buffer.writeu16(u10, u14, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.action, v1)
            local v2 = #p1.weaponId
            alloc(2)
            buffer.writeu16(u10, u14, v2)
            alloc(v2)
            buffer.writestring(u10, u14, p1.weaponId, v2)
            if p1.param ~= nil then
                alloc(1)
                buffer.writeu8(u10, u14, 1)
                local v3 = #p1.param
                alloc(2)
                buffer.writeu16(u10, u14, v3)
                alloc(v3)
                buffer.writestring(u10, u14, p1.param, v3)
            else
                alloc(1)
                buffer.writeu8(u10, u14, 0)
            end
            if p1.cost == nil then
                alloc(1)
                buffer.writeu8(u10, u14, 0)
                return
            end
            alloc(1)
            buffer.writeu8(u10, u14, 1)
            alloc(4)
            buffer.writei32(u10, u14, p1.cost)
        end,
    },
    InitUser = {
        On = function(p1) -- Line: 1727 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[0], p1)
            local v1 = u422[0]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[0] = {}
            return function() -- Line: 1737 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[0], table.find(u419[0], p1))
            end
        end,
    },
    UpdateValue = {
        On = function(p1) -- Line: 1743 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[1], p1)
            local v1 = u422[1]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[1] = {}
            return function() -- Line: 1752 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[1], table.find(u419[1], p1))
            end
        end,
    },
    RemoveIndex = {
        On = function(p1) -- Line: 1758 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[2], p1)
            local v1 = u422[2]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[2] = {}
            return function() -- Line: 1767 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[2], table.find(u419[2], p1))
            end
        end,
    },
    InsertIndex = {
        On = function(p1) -- Line: 1773 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[3], p1)
            local v1 = u422[3]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[3] = {}
            return function() -- Line: 1783 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[3], table.find(u419[3], p1))
            end
        end,
    },
    InsertKey = {
        On = function(p1) -- Line: 1789 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[4], p1)
            local v1 = u422[4]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[4] = {}
            return function() -- Line: 1799 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[4], table.find(u419[4], p1))
            end
        end,
    },
    RemoveKey = {
        On = function(p1) -- Line: 1805 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[5], p1)
            local v1 = u422[5]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[5] = {}
            return function() -- Line: 1814 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[5], table.find(u419[5], p1))
            end
        end,
    },
    StartSelection = {
        On = function(p1) -- Line: 1820 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[6], p1)
            local v1 = u422[6]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[6] = {}
            return function() -- Line: 1831 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[6], table.find(u419[6], p1))
            end
        end,
    },
    UpdateSelectionTimer = {
        On = function(p1) -- Line: 1837 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[7], p1)
            local v1 = u422[7]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[7] = {}
            return function() -- Line: 1845 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[7], table.find(u419[7], p1))
            end
        end,
    },
    UpdatePlayerSelection = {
        On = function(p1) -- Line: 1851 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[8], p1)
            local v1 = u422[8]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[8] = {}
            return function() -- Line: 1861 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[8], table.find(u419[8], p1))
            end
        end,
    },
    EndSelection = {
        On = function(p1) -- Line: 1867 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[9], p1)
            local v1 = u422[9]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[9] = {}
            return function() -- Line: 1876 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[9], table.find(u419[9], p1))
            end
        end,
    },
    StatusMessage = {
        On = function(p1) -- Line: 1882 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[10], p1)
            local v1 = u422[10]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[10] = {}
            return function() -- Line: 1891 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[10], table.find(u419[10], p1))
            end
        end,
    },
    BannerMessage = {
        On = function(p1) -- Line: 1897 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[11], p1)
            local v1 = u422[11]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[11] = {}
            return function() -- Line: 1907 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[11], table.find(u419[11], p1))
            end
        end,
    },
    AdminAnnouncement = {
        On = function(p1) -- Line: 1913 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[12], p1)
            local v1 = u422[12]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[12] = {}
            return function() -- Line: 1924 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[12], table.find(u419[12], p1))
            end
        end,
    },
    ServerList = {
        On = function(p1) -- Line: 1930 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[13], p1)
            local v1 = u422[13]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[13] = {}
            return function() -- Line: 1939 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[13], table.find(u419[13], p1))
            end
        end,
    },
    JoinServerResponse = {
        On = function(p1) -- Line: 1945 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[14], p1)
            local v1 = u422[14]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[14] = {}
            return function() -- Line: 1953 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[14], table.find(u419[14], p1))
            end
        end,
    },
    SetupPodium = {
        On = function(p1) -- Line: 1959 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[15], p1)
            local v1 = u422[15]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[15] = {}
            return function() -- Line: 1967 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[15], table.find(u419[15], p1))
            end
        end,
    },
    OpenGamemodeEndScoreboard = {
        On = function(p1) -- Line: 1973 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[16], p1)
            local v1 = u422[16]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[16] = {}
            return function() -- Line: 1981 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[16], table.find(u419[16], p1))
            end
        end,
    },
    CloseGamemodeEndScoreboard = {
        On = function(p1) -- Line: 1987 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[17], p1)
            local v1 = u422[17]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[17] = {}
            return function() -- Line: 1993 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[17], table.find(u419[17], p1))
            end
        end,
    },
    PreloadWeapons = {
        On = function(p1) -- Line: 1999 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[18], p1)
            local v1 = u422[18]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[18] = {}
            return function() -- Line: 2007 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[18], table.find(u419[18], p1))
            end
        end,
    },
    ClearPreloadedWeapons = {
        On = function(p1) -- Line: 2013 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[19], p1)
            local v1 = u422[19]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[19] = {}
            return function() -- Line: 2019 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[19], table.find(u419[19], p1))
            end
        end,
    },
    PrivateServerCreated = {
        On = function(p1) -- Line: 2025 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[20], p1)
            local v1 = u422[20]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[20] = {}
            return function() -- Line: 2033 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[20], table.find(u419[20], p1))
            end
        end,
    },
    PositionChangedEvent = {
        On = function(p1) -- Line: 2039 -- upvalues: u425 (val), u428 (val)
            table.insert(u425[0], p1)
            local v1 = u428[0]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u428[0] = {}
            return function() -- Line: 2049 -- upvalues: u425 (upval), p1 (val)
                table.remove(u425[0], table.find(u425[0], p1))
            end
        end,
    },
    LookAngleEvent = {
        On = function(p1) -- Line: 2055 -- upvalues: u425 (val), u428 (val)
            table.insert(u425[1], p1)
            local v1 = u428[1]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u428[1] = {}
            return function() -- Line: 2066 -- upvalues: u425 (upval), p1 (val)
                table.remove(u425[1], table.find(u425[1], p1))
            end
        end,
    },
    NPCRegistryEvent = {
        On = function(p1) -- Line: 2072 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[21], p1)
            local v1 = u422[21]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[21] = {}
            return function() -- Line: 2081 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[21], table.find(u419[21], p1))
            end
        end,
    },
    TogglePointsUIEvent = {
        On = function(p1) -- Line: 2087 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[22], p1)
            local v1 = u422[22]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[22] = {}
            return function() -- Line: 2095 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[22], table.find(u419[22], p1))
            end
        end,
    },
    ToggleSurvivalShopUIEvent = {
        On = function(p1) -- Line: 2101 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[23], p1)
            local v1 = u422[23]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[23] = {}
            return function() -- Line: 2109 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[23], table.find(u419[23], p1))
            end
        end,
    },
    InitSurvivalShopEvent = {
        On = function(p1) -- Line: 2115 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[24], p1)
            local v1 = u422[24]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[24] = {}
            return function() -- Line: 2123 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[24], table.find(u419[24], p1))
            end
        end,
    },
    RenderExplosionEvent = {
        On = function(p1) -- Line: 2129 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[25], p1)
            local v1 = u422[25]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[25] = {}
            return function() -- Line: 2139 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[25], table.find(u419[25], p1))
            end
        end,
    },
    SetGameStateKey = {
        On = function(p1) -- Line: 2145 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[26], p1)
            local v1 = u422[26]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[26] = {}
            return function() -- Line: 2154 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[26], table.find(u419[26], p1))
            end
        end,
    },
    SetGameStateVariable = {
        On = function(p1) -- Line: 2160 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[27], p1)
            local v1 = u422[27]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[27] = {}
            return function() -- Line: 2169 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[27], table.find(u419[27], p1))
            end
        end,
    },
    InitGameState = {
        On = function(p1) -- Line: 2175 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[28], p1)
            local v1 = u422[28]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[28] = {}
            return function() -- Line: 2181 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[28], table.find(u419[28], p1))
            end
        end,
    },
    InitQuests = {
        On = function(p1) -- Line: 2187 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[29], p1)
            local v1 = u422[29]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[29] = {}
            return function() -- Line: 2193 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[29], table.find(u419[29], p1))
            end
        end,
    },
    UpdateQuestCategory = {
        On = function(p1) -- Line: 2199 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[30], p1)
            local v1 = u422[30]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[30] = {}
            return function() -- Line: 2208 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[30], table.find(u419[30], p1))
            end
        end,
    },
    UpdateQuestProgress = {
        On = function(p1) -- Line: 2214 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[31], p1)
            local v1 = u422[31]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[31] = {}
            return function() -- Line: 2224 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[31], table.find(u419[31], p1))
            end
        end,
    },
    ChristmasGiftCollected = {
        On = function(p1) -- Line: 2230 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[32], p1)
            local v1 = u422[32]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[32] = {}
            return function() -- Line: 2239 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[32], table.find(u419[32], p1))
            end
        end,
    },
    FocusDeactivated = {
        On = function(p1) -- Line: 2245 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[33], p1)
            local v1 = u422[33]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[33] = {}
            return function() -- Line: 2252 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[33], table.find(u419[33], p1))
            end
        end,
    },
    InitSkillTree = {
        On = function(p1) -- Line: 2258 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[34], p1)
            local v1 = u422[34]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[34] = {}
            return function() -- Line: 2264 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[34], table.find(u419[34], p1))
            end
        end,
    },
    UpdateSkillRank = {
        On = function(p1) -- Line: 2270 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[35], p1)
            local v1 = u422[35]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[35] = {}
            return function() -- Line: 2279 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[35], table.find(u419[35], p1))
            end
        end,
    },
    SyncSkillTreeEconomy = {
        On = function(p1) -- Line: 2285 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[36], p1)
            local v1 = u422[36]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[36] = {}
            return function() -- Line: 2301 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[36], table.find(u419[36], p1))
            end
        end,
    },
    RushNpcAttacking = {
        On = function(p1) -- Line: 2307 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[37], p1)
            local v1 = u422[37]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[37] = {}
            return function() -- Line: 2315 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[37], table.find(u419[37], p1))
            end
        end,
    },
    RushPhaseChanged = {
        On = function(p1) -- Line: 2321 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[38], p1)
            local v1 = u422[38]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[38] = {}
            return function() -- Line: 2332 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[38], table.find(u419[38], p1))
            end
        end,
    },
    RushPtsUpdate = {
        On = function(p1) -- Line: 2338 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[39], p1)
            local v1 = u422[39]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[39] = {}
            return function() -- Line: 2346 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[39], table.find(u419[39], p1))
            end
        end,
    },
    RushVoteState = {
        On = function(p1) -- Line: 2352 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[40], p1)
            local v1 = u422[40]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[40] = {}
            return function() -- Line: 2367 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[40], table.find(u419[40], p1))
            end
        end,
    },
    RushMissionResult = {
        On = function(p1) -- Line: 2373 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[41], p1)
            local v1 = u422[41]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[41] = {}
            return function() -- Line: 2382 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[41], table.find(u419[41], p1))
            end
        end,
    },
    RushBossResult = {
        On = function(p1) -- Line: 2388 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[42], p1)
            local v1 = u422[42]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[42] = {}
            return function() -- Line: 2397 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[42], table.find(u419[42], p1))
            end
        end,
    },
    HintSystemMessage = {
        On = function(p1) -- Line: 2403 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[43], p1)
            local v1 = u422[43]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[43] = {}
            return function() -- Line: 2413 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[43], table.find(u419[43], p1))
            end
        end,
    },
    RushShopStock = {
        On = function(p1) -- Line: 2419 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[44], p1)
            local v1 = u422[44]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[44] = {}
            return function() -- Line: 2429 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[44], table.find(u419[44], p1))
            end
        end,
    },
    RushShopSync = {
        On = function(p1) -- Line: 2435 -- upvalues: u419 (val), u422 (val)
            table.insert(u419[45], p1)
            local v1 = u422[45]
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                task.spawn(p1, j)
            end
            u422[45] = {}
            return function() -- Line: 2448 -- upvalues: u419 (upval), p1 (val)
                table.remove(u419[45], table.find(u419[45], p1))
            end
        end,
    },
    ActivateFocus = {
        Call = function() -- Line: 2454 -- upvalues: alloc (val), u10 (ref), u14 (ref), u429 (ref), u422 (val)
            alloc(1)
            buffer.writeu8(u10, u14, 16)
            u429 = u429 + 1
            u429 = u429 % 256
            local v1 = u422[46]
            if v1[u429] then
                u429 = u429 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            alloc(1)
            buffer.writeu8(u10, u14, u429)
            local v2 = u422[46]
            v2[u429] = coroutine.running()
            return coroutine.yield()
        end,
    },
}