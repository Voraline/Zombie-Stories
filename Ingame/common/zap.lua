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
            if not (u12 < v1) then
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
    local v1 = u16
    u16 = u16 + p1
    return v1
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
if not RunService:IsRunning() then
    function v9() end

    return (table.freeze({
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
    }))
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
        local v2 = ZAP_RELIABLE
        local v3 = u13
        v2:FireServer(v1, v3)
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
u422[46] = (table.create(255))
ZAP_RELIABLE.OnClientEvent:Connect(function(p1, p2) -- Line: 441 -- upvalues: u15 (ref), u17 (ref), u16 (ref), u18 (ref), u419 (val), u422 (val)
    local Magnitude, readstring, readstring_10, readstring_11, readstring_12, readstring_13, readstring_14, readstring_15, readstring_16, readstring_17, readstring_18, readstring_19, readstring_2, readstring_20, readstring_21, readstring_22, readstring_23, readstring_24, readstring_25, readstring_26, readstring_3, readstring_4, readstring_5, readstring_6, readstring_7, readstring_8, readstring_9, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    u15 = p1
    u17 = p2
    u16 = 0
    u18 = 0
    local v15 = buffer.len(p1)
    local v16 = p1
    while u16 < v15 do
        v11 = u16
        u16 = u16 + 1
        v8 = buffer.readu8(v16, v11)
        if v8 == 0 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Data = nil
            else
                u18 = u18 + 1
                v9.Data = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.State = nil
            else
                u18 = u18 + 1
                v9.State = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Game = nil
            else
                u18 = u18 + 1
                v9.Game = u17[u18]
            end
            if not u419[0][1] then
                v11 = u422[0]
                table.insert(v11, v9)
                v10 = #u422[0]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[0]
                    v10((("[ZAP] %* events in queue for InitUser. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[0]
                v11 = nil
                v12 = nil
                for i94, i95 in v10, v11, v12 do
                    task.spawn(i95, v9)
                end
            end
        elseif v8 == 1 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.value = nil
            else
                u18 = u18 + 1
                v9.value = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.path = readstring(v12, v13, v10)
            if not u419[1][1] then
                v12 = u422[1]
                table.insert(v12, v9)
                v11 = #u422[1]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[1]
                    v11((("[ZAP] %* events in queue for UpdateValue. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[1]
                v12 = nil
                v13 = nil
                for i92, i93 in v11, v12, v13 do
                    task.spawn(i93, v9)
                end
            end
        elseif v8 == 2 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_2 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.path = readstring_2(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 4
            v9.index = buffer.readi32(v12, v14)
            if not u419[2][1] then
                v12 = u422[2]
                table.insert(v12, v9)
                v11 = #u422[2]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[2]
                    v11((("[ZAP] %* events in queue for RemoveIndex. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[2]
                v12 = nil
                v13 = nil
                for i90, i91 in v11, v12, v13 do
                    task.spawn(i91, v9)
                end
            end
        elseif v8 == 3 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_3 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.path = readstring_3(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 4
            v9.index = buffer.readi32(v12, v14)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.value = nil
            else
                u18 = u18 + 1
                v9.value = u17[u18]
            end
            if not u419[3][1] then
                v12 = u422[3]
                table.insert(v12, v9)
                v11 = #u422[3]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[3]
                    v11((("[ZAP] %* events in queue for InsertIndex. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[3]
                v12 = nil
                v13 = nil
                for i88, i89 in v11, v12, v13 do
                    task.spawn(i89, v9)
                end
            end
        elseif v8 == 4 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_4 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.path = readstring_4(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_5 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.key = readstring_5(v13, v14, v11)
            v13 = u15
            v1 = u16
            u16 = u16 + 1
            if buffer.readu8(v13, v1) ~= 1 then
                v9.value = nil
            else
                u18 = u18 + 1
                v9.value = u17[u18]
            end
            if not u419[4][1] then
                v13 = u422[4]
                table.insert(v13, v9)
                v12 = #u422[4]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[4]
                    v12((("[ZAP] %* events in queue for InsertKey. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[4]
                v13 = nil
                v14 = nil
                for i86, i87 in v12, v13, v14 do
                    task.spawn(i87, v9)
                end
            end
        elseif v8 == 5 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_6 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.path = readstring_6(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_7 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.key = readstring_7(v13, v14, v11)
            if not u419[5][1] then
                v13 = u422[5]
                table.insert(v13, v9)
                v12 = #u422[5]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[5]
                    v12((("[ZAP] %* events in queue for RemoveKey. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[5]
                v13 = nil
                v14 = nil
                for i84, i85 in v12, v13, v14 do
                    task.spawn(i85, v9)
                end
            end
        elseif v8 == 6 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Maps = nil
            else
                u18 = u18 + 1
                v9.Maps = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Difficulties = nil
            else
                u18 = u18 + 1
                v9.Difficulties = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Timer = nil
            else
                u18 = u18 + 1
                v9.Timer = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Selections = nil
            else
                u18 = u18 + 1
                v9.Selections = u17[u18]
            end
            if not u419[6][1] then
                v11 = u422[6]
                table.insert(v11, v9)
                v10 = #u422[6]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[6]
                    v10((("[ZAP] %* events in queue for StartSelection. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[6]
                v11 = nil
                v12 = nil
                for i82, i83 in v10, v11, v12 do
                    task.spawn(i83, v9)
                end
            end
        elseif v8 == 7 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 8
            v9.Timer = buffer.readf64(v11, v13)
            if not u419[7][1] then
                v11 = u422[7]
                table.insert(v11, v9)
                v10 = #u422[7]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[7]
                    v10((("[ZAP] %* events in queue for UpdateSelectionTimer. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[7]
                v11 = nil
                v12 = nil
                for i80, i81 in v10, v11, v12 do
                    task.spawn(i81, v9)
                end
            end
        elseif v8 == 8 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 8
            v9.PlayerID = buffer.readf64(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_8 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.Type = readstring_8(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_9 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.Value = readstring_9(v13, v14, v11)
            if not u419[8][1] then
                v13 = u422[8]
                table.insert(v13, v9)
                v12 = #u422[8]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[8]
                    v12((("[ZAP] %* events in queue for UpdatePlayerSelection. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[8]
                v13 = nil
                v14 = nil
                for i78, i79 in v12, v13, v14 do
                    task.spawn(i79, v9)
                end
            end
        elseif v8 == 9 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_10 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.Map = readstring_10(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_11 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.Difficulty = readstring_11(v13, v14, v11)
            if not u419[9][1] then
                v13 = u422[9]
                table.insert(v13, v9)
                v12 = #u422[9]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[9]
                    v12((("[ZAP] %* events in queue for EndSelection. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[9]
                v13 = nil
                v14 = nil
                for i76, i77 in v12, v13, v14 do
                    task.spawn(i77, v9)
                end
            end
        elseif v8 == 10 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            v9.type = buffer.readu8(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_12 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.message = readstring_12(v12, v13, v10)
            if not u419[10][1] then
                v12 = u422[10]
                table.insert(v12, v9)
                v11 = #u422[10]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[10]
                    v11((("[ZAP] %* events in queue for StatusMessage. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[10]
                v12 = nil
                v13 = nil
                for i74, i75 in v11, v12, v13 do
                    task.spawn(i75, v9)
                end
            end
        elseif v8 == 11 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            v9.type = buffer.readu8(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_13 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.header = readstring_13(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_14 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.message = readstring_14(v13, v14, v11)
            if not u419[11][1] then
                v13 = u422[11]
                table.insert(v13, v9)
                v12 = #u422[11]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[11]
                    v12((("[ZAP] %* events in queue for BannerMessage. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[11]
                v13 = nil
                v14 = nil
                for i72, i73 in v12, v13, v14 do
                    task.spawn(i73, v9)
                end
            end
        elseif v8 == 12 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 8
            v9.userId = buffer.readf64(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_15 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.username = readstring_15(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_16 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.message = readstring_16(v13, v14, v11)
            v13 = u15
            v1 = u16
            u16 = u16 + 4
            v9.duration = buffer.readf32(v13, v1)
            if not u419[12][1] then
                v13 = u422[12]
                table.insert(v13, v9)
                v12 = #u422[12]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[12]
                    v12((("[ZAP] %* events in queue for AdminAnnouncement. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[12]
                v13 = nil
                v14 = nil
                for i70, i71 in v12, v13, v14 do
                    task.spawn(i71, v9)
                end
            end
        elseif v8 == 13 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_17 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.ServerType = readstring_17(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.Servers = nil
            else
                u18 = u18 + 1
                v9.Servers = u17[u18]
            end
            if not u419[13][1] then
                v12 = u422[13]
                table.insert(v12, v9)
                v11 = #u422[13]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[13]
                    v11((("[ZAP] %* events in queue for ServerList. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[13]
                v12 = nil
                v13 = nil
                for i68, i69 in v11, v12, v13 do
                    task.spawn(i69, v9)
                end
            end
        elseif v8 == 14 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_18 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.Message = readstring_18(v12, v13, v10)
            if not u419[14][1] then
                v12 = u422[14]
                table.insert(v12, v9)
                v11 = #u422[14]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[14]
                    v11((("[ZAP] %* events in queue for JoinServerResponse. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[14]
                v12 = nil
                v13 = nil
                for i66, i67 in v11, v12, v13 do
                    task.spawn(i67, v9)
                end
            end
        elseif v8 == 15 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Players = nil
            else
                u18 = u18 + 1
                v9.Players = u17[u18]
            end
            if not u419[15][1] then
                v11 = u422[15]
                table.insert(v11, v9)
                v10 = #u422[15]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[15]
                    v10((("[ZAP] %* events in queue for SetupPodium. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[15]
                v11 = nil
                v12 = nil
                for i64, i65 in v10, v11, v12 do
                    task.spawn(i65, v9)
                end
            end
        elseif v8 == 16 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Players = nil
            else
                u18 = u18 + 1
                v9.Players = u17[u18]
            end
            if not u419[16][1] then
                v11 = u422[16]
                table.insert(v11, v9)
                v10 = #u422[16]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[16]
                    v10((("[ZAP] %* events in queue for OpenGamemodeEndScoreboard. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[16]
                v11 = nil
                v12 = nil
                for i62, i63 in v10, v11, v12 do
                    task.spawn(i63, v9)
                end
            end
        elseif v8 == 17 then
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9 = nil
            else
                u18 = u18 + 1
                v9 = u17[u18]
            end
            if not u419[17][1] then
                v11 = u422[17]
                table.insert(v11, v9)
                v10 = #u422[17]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[17]
                    v10((("[ZAP] %* events in queue for CloseGamemodeEndScoreboard. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[17]
                v11 = nil
                v12 = nil
                for i60, i61 in v10, v11, v12 do
                    task.spawn(i61, v9)
                end
            end
        elseif v8 == 18 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.Weapons = nil
            else
                u18 = u18 + 1
                v9.Weapons = u17[u18]
            end
            if not u419[18][1] then
                v11 = u422[18]
                table.insert(v11, v9)
                v10 = #u422[18]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[18]
                    v10((("[ZAP] %* events in queue for PreloadWeapons. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[18]
                v11 = nil
                v12 = nil
                for i58, i59 in v10, v11, v12 do
                    task.spawn(i59, v9)
                end
            end
        elseif v8 == 19 then
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9 = nil
            else
                u18 = u18 + 1
                v9 = u17[u18]
            end
            if not u419[19][1] then
                v11 = u422[19]
                table.insert(v11, v9)
                v10 = #u422[19]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[19]
                    v10((("[ZAP] %* events in queue for ClearPreloadedWeapons. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[19]
                v11 = nil
                v12 = nil
                for i56, i57 in v10, v11, v12 do
                    task.spawn(i57, v9)
                end
            end
        elseif v8 == 20 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_19 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.PrivateServerId = readstring_19(v12, v13, v10)
            if not u419[20][1] then
                v12 = u422[20]
                table.insert(v12, v9)
                v11 = #u422[20]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[20]
                    v11((("[ZAP] %* events in queue for PrivateServerCreated. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[20]
                v12 = nil
                v13 = nil
                for i54, i55 in v11, v12, v13 do
                    task.spawn(i55, v9)
                end
            end
        elseif v8 == 21 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 8
            v9.UID = buffer.readf64(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_20 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.Type = readstring_20(v12, v13, v10)
            if not u419[21][1] then
                v12 = u422[21]
                table.insert(v12, v9)
                v11 = #u422[21]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[21]
                    v11((("[ZAP] %* events in queue for NPCRegistryEvent. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[21]
                v12 = nil
                v13 = nil
                for i52, i53 in v11, v12, v13 do
                    task.spawn(i53, v9)
                end
            end
        elseif v8 == 22 then
            v9 = {}
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v10 = buffer.readu8(v12, v14) == 1
            v9.IsVisible = v10
            if not u419[22][1] then
                v11 = u422[22]
                table.insert(v11, v9)
                v10 = #u422[22]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[22]
                    v10((("[ZAP] %* events in queue for TogglePointsUIEvent. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[22]
                v11 = nil
                v12 = nil
                for i50, i51 in v10, v11, v12 do
                    task.spawn(i51, v9)
                end
            end
        elseif v8 == 23 then
            v9 = {}
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v10 = buffer.readu8(v12, v14) == 1
            v9.IsVisible = v10
            if not u419[23][1] then
                v11 = u422[23]
                table.insert(v11, v9)
                v10 = #u422[23]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[23]
                    v10((("[ZAP] %* events in queue for ToggleSurvivalShopUIEvent. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[23]
                v11 = nil
                v12 = nil
                for i48, i49 in v10, v11, v12 do
                    task.spawn(i49, v9)
                end
            end
        elseif v8 == 24 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.SurvivalShopItemsInfo = nil
            else
                u18 = u18 + 1
                v9.SurvivalShopItemsInfo = u17[u18]
            end
            if not u419[24][1] then
                v11 = u422[24]
                table.insert(v11, v9)
                v10 = #u422[24]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[24]
                    v10((("[ZAP] %* events in queue for InitSurvivalShopEvent. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[24]
                v11 = nil
                v12 = nil
                for i46, i47 in v10, v11, v12 do
                    task.spawn(i47, v9)
                end
            end
        elseif v8 == 25 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_21 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.ExplosionType = readstring_21(v12, v14, v10)
            v13 = u15
            v1 = u16
            u16 = u16 + 4
            v12 = buffer.readf32(v13, v1)
            v14 = u15
            v2 = u16
            u16 = u16 + 4
            v13 = buffer.readf32(v14, v2)
            v1 = u15
            v3 = u16
            u16 = u16 + 4
            v14 = buffer.readf32(v1, v3)
            v9.Position = vector.create(v12, v13, v14)
            v12 = u15
            v14 = u16
            u16 = u16 + 8
            v9.BlastRadius = buffer.readf64(v12, v14)
            if not u419[25][1] then
                v12 = u422[25]
                table.insert(v12, v9)
                v11 = #u422[25]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[25]
                    v11((("[ZAP] %* events in queue for RenderExplosionEvent. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[25]
                v12 = nil
                v13 = nil
                for i44, i45 in v11, v12, v13 do
                    task.spawn(i45, v9)
                end
            end
        elseif v8 == 26 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_22 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.Key = readstring_22(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.Value = nil
            else
                u18 = u18 + 1
                v9.Value = u17[u18]
            end
            if not u419[26][1] then
                v12 = u422[26]
                table.insert(v12, v9)
                v11 = #u422[26]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[26]
                    v11((("[ZAP] %* events in queue for SetGameStateKey. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[26]
                v12 = nil
                v13 = nil
                for i42, i43 in v11, v12, v13 do
                    task.spawn(i43, v9)
                end
            end
        elseif v8 == 27 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_23 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.Key = readstring_23(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.Value = nil
            else
                u18 = u18 + 1
                v9.Value = u17[u18]
            end
            if not u419[27][1] then
                v12 = u422[27]
                table.insert(v12, v9)
                v11 = #u422[27]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[27]
                    v11((("[ZAP] %* events in queue for SetGameStateVariable. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[27]
                v12 = nil
                v13 = nil
                for i40, i41 in v11, v12, v13 do
                    task.spawn(i41, v9)
                end
            end
        elseif v8 == 28 then
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9 = nil
            else
                u18 = u18 + 1
                v9 = u17[u18]
            end
            if not u419[28][1] then
                v11 = u422[28]
                table.insert(v11, v9)
                v10 = #u422[28]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[28]
                    v10((("[ZAP] %* events in queue for InitGameState. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[28]
                v11 = nil
                v12 = nil
                for i38, i39 in v10, v11, v12 do
                    task.spawn(i39, v9)
                end
            end
        elseif v8 == 29 then
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9 = nil
            else
                u18 = u18 + 1
                v9 = u17[u18]
            end
            if not u419[29][1] then
                v11 = u422[29]
                table.insert(v11, v9)
                v10 = #u422[29]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[29]
                    v10((("[ZAP] %* events in queue for InitQuests. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[29]
                v11 = nil
                v12 = nil
                for i36, i37 in v10, v11, v12 do
                    task.spawn(i37, v9)
                end
            end
        elseif v8 == 30 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_24 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.Category = readstring_24(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.Quests = nil
            else
                u18 = u18 + 1
                v9.Quests = u17[u18]
            end
            if not u419[30][1] then
                v12 = u422[30]
                table.insert(v12, v9)
                v11 = #u422[30]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[30]
                    v11((("[ZAP] %* events in queue for UpdateQuestCategory. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[30]
                v12 = nil
                v13 = nil
                for i34, i35 in v11, v12, v13 do
                    task.spawn(i35, v9)
                end
            end
        elseif v8 == 31 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            readstring_25 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.Category = readstring_25(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            readstring_26 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v14 = v1
            v9.QuestKey = readstring_26(v13, v14, v11)
            v13 = u15
            v1 = u16
            u16 = u16 + 8
            v9.Progress = buffer.readf64(v13, v1)
            if not u419[31][1] then
                v13 = u422[31]
                table.insert(v13, v9)
                v12 = #u422[31]
                if 64 < v12 then
                    v12 = warn
                    v3 = u422
                    v1 = #v3[31]
                    v12((("[ZAP] %* events in queue for UpdateQuestProgress. Did you forget to attach a listener?"):format(v1)))
                end
            else
                v12 = u419[31]
                v13 = nil
                v14 = nil
                for i32, i33 in v12, v13, v14 do
                    task.spawn(i33, v9)
                end
            end
        elseif v8 == 32 then
            v9 = {}
            u18 = u18 + 1
            v9.Player = u17[u18]
            v11 = v9.Player ~= nil
            assert(v11)
            v12 = u15
            v14 = u16
            u16 = u16 + 4
            v11 = buffer.readf32(v12, v14)
            v13 = u15
            v1 = u16
            u16 = u16 + 4
            v12 = buffer.readf32(v13, v1)
            v14 = u15
            v2 = u16
            u16 = u16 + 4
            v13 = buffer.readf32(v14, v2)
            v10 = Vector3.new(v11, v12, v13)
            v13 = u15
            v1 = u16
            u16 = u16 + 4
            v12 = buffer.readf32(v13, v1)
            v14 = u15
            v2 = u16
            u16 = u16 + 4
            v13 = buffer.readf32(v14, v2)
            v1 = u15
            v3 = u16
            u16 = u16 + 4
            v14 = buffer.readf32(v1, v3)
            v11 = Vector3.new(v12, v13, v14)
            Magnitude = v11.Magnitude
            if Magnitude == 0 then
                v9.Gift = CFrame.new(v10)
            else
                v9.Gift = CFrame.fromAxisAngle(v11, Magnitude) + v10
            end
            if not u419[32][1] then
                v14 = u422[32]
                table.insert(v14, v9)
                v13 = #u422[32]
                if 64 < v13 then
                    v13 = warn
                    v4 = u422
                    v2 = #v4[32]
                    v13((("[ZAP] %* events in queue for ChristmasGiftCollected. Did you forget to attach a listener?"):format(v2)))
                end
            else
                v13 = u419[32]
                v14 = nil
                v1 = nil
                for i30, i31 in v13, v14, v1 do
                    task.spawn(i31, v9)
                end
            end
        elseif v8 == 33 then
            v9 = {}
            if not u419[33][1] then
                v11 = u422[33]
                table.insert(v11, v9)
                v10 = #u422[33]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[33]
                    v10((("[ZAP] %* events in queue for FocusDeactivated. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[33]
                v11 = nil
                v12 = nil
                for i28, i29 in v10, v11, v12 do
                    task.spawn(i29, v9)
                end
            end
        elseif v8 == 34 then
            v9 = {}
            v14 = u15
            v2 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v14, v2)
            for i25 = 1, v10 do
                v2 = u15
                v4 = u16
                u16 = u16 + 2
                v1 = buffer.readu16(v2, v4)
                v2 = buffer.readstring
                v3 = u15
                v5 = u16
                u16 = u16 + v1
                v13 = v2(v3, v5, v1)
                v3 = u15
                v5 = u16
                u16 = u16 + 2
                v9[v13] = (buffer.readi16(v3, v5))
            end
            if not u419[34][1] then
                v11 = u422[34]
                table.insert(v11, v9)
                v10 = #u422[34]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[34]
                    v10((("[ZAP] %* events in queue for InitSkillTree. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[34]
                v11 = nil
                v12 = nil
                for i26, i27 in v10, v11, v12 do
                    task.spawn(i27, v9)
                end
            end
        elseif v8 == 35 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            v11 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.SkillId = v11(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v9.Rank = buffer.readi16(v12, v14)
            if not u419[35][1] then
                v12 = u422[35]
                table.insert(v12, v9)
                v11 = #u422[35]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[35]
                    v11((("[ZAP] %* events in queue for UpdateSkillRank. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[35]
                v12 = nil
                v13 = nil
                for i23, i24 in v11, v12, v13 do
                    task.spawn(i24, v9)
                end
            end
        elseif v8 == 36 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v9.SP = buffer.readi16(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v9.SPCap = buffer.readi16(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v9.SPSpent = buffer.readi16(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.XPBar = buffer.readi32(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v9.DailyEarned = buffer.readi16(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v9.DailyEarnCap = buffer.readi16(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v9.PrestigeLevel = buffer.readi16(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.ZBucks = buffer.readi32(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.ZBucksInvested = buffer.readi32(v11, v13)
            if not u419[36][1] then
                v11 = u422[36]
                table.insert(v11, v9)
                v10 = #u422[36]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[36]
                    v10((("[ZAP] %* events in queue for SyncSkillTreeEconomy. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[36]
                v11 = nil
                v12 = nil
                for i21, i22 in v10, v11, v12 do
                    task.spawn(i22, v9)
                end
            end
        elseif v8 == 37 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.entityId = buffer.readu32(v11, v13)
            if not u419[37][1] then
                v11 = u422[37]
                table.insert(v11, v9)
                v10 = #u422[37]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[37]
                    v10((("[ZAP] %* events in queue for RushNpcAttacking. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[37]
                v11 = nil
                v12 = nil
                for i19, i20 in v10, v11, v12 do
                    task.spawn(i20, v9)
                end
            end
        elseif v8 == 38 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            v11 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.phase = v11(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v9.cycle = buffer.readu8(v12, v14)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v9.missionIndex = buffer.readu8(v12, v14)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v9.livesRemaining = buffer.readu8(v12, v14)
            if not u419[38][1] then
                v12 = u422[38]
                table.insert(v12, v9)
                v11 = #u422[38]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[38]
                    v11((("[ZAP] %* events in queue for RushPhaseChanged. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[38]
                v12 = nil
                v13 = nil
                for i17, i18 in v11, v12, v13 do
                    task.spawn(i18, v9)
                end
            end
        elseif v8 == 39 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.pts = buffer.readi32(v11, v13)
            if not u419[39][1] then
                v11 = u422[39]
                table.insert(v11, v9)
                v10 = #u422[39]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[39]
                    v10((("[ZAP] %* events in queue for RushPtsUpdate. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[39]
                v11 = nil
                v12 = nil
                for i15, i16 in v10, v11, v12 do
                    task.spawn(i16, v9)
                end
            end
        elseif v8 == 40 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            v9.pad1Count = buffer.readu8(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            v9.pad2Count = buffer.readu8(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            v9.pad3Count = buffer.readu8(v11, v13)
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.countdown = buffer.readf32(v11, v13)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v10 = buffer.readu8(v12, v14) == 1
            v9.isCountingDown = v10
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            v11 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v9.pad1Label = v11(v12, v14, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v12, v14)
            v12 = buffer.readstring
            v13 = u15
            v1 = u16
            u16 = u16 + v11
            v9.pad2Label = v12(v13, v1, v11)
            v13 = u15
            v1 = u16
            u16 = u16 + 2
            v12 = buffer.readu16(v13, v1)
            v13 = buffer.readstring
            v14 = u15
            v2 = u16
            u16 = u16 + v12
            v1 = v2
            v9.pad3Label = v13(v14, v1, v12)
            if not u419[40][1] then
                v14 = u422[40]
                table.insert(v14, v9)
                v13 = #u422[40]
                if 64 < v13 then
                    v13 = warn
                    v4 = u422
                    v2 = #v4[40]
                    v13((("[ZAP] %* events in queue for RushVoteState. Did you forget to attach a listener?"):format(v2)))
                end
            else
                v13 = u419[40]
                v14 = nil
                v1 = nil
                for i13, i14 in v13, v14, v1 do
                    task.spawn(i14, v9)
                end
            end
        elseif v8 == 41 then
            v9 = {}
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v10 = buffer.readu8(v12, v14) == 1
            v9.success = v10
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.ptsEarned = buffer.readi32(v11, v13)
            if not u419[41][1] then
                v11 = u422[41]
                table.insert(v11, v9)
                v10 = #u422[41]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[41]
                    v10((("[ZAP] %* events in queue for RushMissionResult. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[41]
                v11 = nil
                v12 = nil
                for i11, i12 in v10, v11, v12 do
                    task.spawn(i12, v9)
                end
            end
        elseif v8 == 42 then
            v9 = {}
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v10 = buffer.readu8(v12, v14) == 1
            v9.success = v10
            v11 = u15
            v13 = u16
            u16 = u16 + 4
            v9.zbucksEarned = buffer.readi32(v11, v13)
            if not u419[42][1] then
                v11 = u422[42]
                table.insert(v11, v9)
                v10 = #u422[42]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[42]
                    v10((("[ZAP] %* events in queue for RushBossResult. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[42]
                v11 = nil
                v12 = nil
                for i9, i10 in v10, v11, v12 do
                    task.spawn(i10, v9)
                end
            end
        elseif v8 == 43 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v10 = buffer.readu16(v11, v13)
            v11 = buffer.readstring
            v12 = u15
            v14 = u16
            u16 = u16 + v10
            v13 = v14
            v9.message = v11(v12, v13, v10)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.duration = nil
            else
                v12 = u15
                v14 = u16
                u16 = u16 + 4
                v9.duration = buffer.readf32(v12, v14)
            end
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            if buffer.readu8(v12, v14) ~= 1 then
                v9.key = nil
            else
                v12 = u15
                v14 = u16
                u16 = u16 + 2
                v11 = buffer.readu16(v12, v14)
                v12 = buffer.readstring
                v13 = u15
                v1 = u16
                u16 = u16 + v11
                v9.key = v12(v13, v1, v11)
            end
            if not u419[43][1] then
                v12 = u422[43]
                table.insert(v12, v9)
                v11 = #u422[43]
                if 64 < v11 then
                    v11 = warn
                    v2 = u422
                    v14 = #v2[43]
                    v11((("[ZAP] %* events in queue for HintSystemMessage. Did you forget to attach a listener?"):format(v14)))
                end
            else
                v11 = u419[43]
                v12 = nil
                v13 = nil
                for i7, i8 in v11, v12, v13 do
                    task.spawn(i8, v9)
                end
            end
        elseif v8 == 44 then
            v9 = {primary = {}}
            v11 = u15
            v13 = u16
            u16 = u16 + 2
            v11 = buffer.readu16(v11, v13)
            for k = 1, v11 do
                v2 = u15
                v4 = u16
                u16 = u16 + 2
                v1 = buffer.readu16(v2, v4)
                v2 = buffer.readstring
                v3 = u15
                v5 = u16
                u16 = u16 + v1
                v14 = v2(v3, v5, v1)
                v9.primary[k] = v14
            end
            v9.secondary = {}
            v12 = u15
            v14 = u16
            u16 = u16 + 2
            v12 = buffer.readu16(v12, v14)
            for n = 1, v12 do
                v3 = u15
                v5 = u16
                u16 = u16 + 2
                v2 = buffer.readu16(v3, v5)
                v3 = buffer.readstring
                v4 = u15
                v6 = u16
                u16 = u16 + v2
                v1 = v3(v4, v6, v2)
                v9.secondary[n] = v1
            end
            v9.melee = {}
            v13 = u15
            v1 = u16
            u16 = u16 + 2
            v13 = buffer.readu16(v13, v1)
            for m = 1, v13 do
                v4 = u15
                v6 = u16
                u16 = u16 + 2
                v3 = buffer.readu16(v4, v6)
                v4 = buffer.readstring
                v5 = u15
                v7 = u16
                u16 = u16 + v3
                v2 = v4(v5, v7, v3)
                v9.melee[m] = v2
            end
            if not u419[44][1] then
                v14 = u422[44]
                table.insert(v14, v9)
                v13 = #u422[44]
                if 64 < v13 then
                    v13 = warn
                    v4 = u422
                    v2 = #v4[44]
                    v13((("[ZAP] %* events in queue for RushShopStock. Did you forget to attach a listener?"):format(v2)))
                end
            else
                v13 = u419[44]
                v14 = nil
                v1 = nil
                for i5, i6 in v13, v14, v1 do
                    task.spawn(i6, v9)
                end
            end
        elseif v8 == 45 then
            v9 = {}
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.ownedWeapons = nil
            else
                u18 = u18 + 1
                v9.ownedWeapons = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.equippedWeapons = nil
            else
                u18 = u18 + 1
                v9.equippedWeapons = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.weaponUpgrades = nil
            else
                u18 = u18 + 1
                v9.weaponUpgrades = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.purchasedAttachments = nil
            else
                u18 = u18 + 1
                v9.purchasedAttachments = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.weaponAttachments = nil
            else
                u18 = u18 + 1
                v9.weaponAttachments = u17[u18]
            end
            v11 = u15
            v13 = u16
            u16 = u16 + 1
            if buffer.readu8(v11, v13) ~= 1 then
                v9.weaponInvestment = nil
            else
                u18 = u18 + 1
                v9.weaponInvestment = u17[u18]
            end
            if not u419[45][1] then
                v11 = u422[45]
                table.insert(v11, v9)
                v10 = #u422[45]
                if 64 < v10 then
                    v10 = warn
                    v1 = u422
                    v13 = #v1[45]
                    v10((("[ZAP] %* events in queue for RushShopSync. Did you forget to attach a listener?"):format(v13)))
                end
            else
                v10 = u419[45]
                v11 = nil
                v12 = nil
                for i, j in v10, v11, v12 do
                    task.spawn(j, v9)
                end
            end
        elseif v8 ~= 46 then
            error("Unknown event id")
        else
            v10 = u15
            v12 = u16
            u16 = u16 + 1
            v9 = buffer.readu8(v10, v12)
            v12 = u15
            v14 = u16
            u16 = u16 + 1
            v10 = buffer.readu8(v12, v14) == 1
            v11 = u422[46][v9]
            if v11 then
                task.spawn(v11, v10)
            end
            v12 = u422[46]
            v12[v9] = nil
        end
    end
end)
u381[1].OnClientEvent:Connect(function(p1, p2) -- Line: 1382 -- upvalues: u15 (ref), u17 (ref), u16 (ref), u18 (ref), u425 (val), u428 (val)
    local v1, v2, v3, v4, v5, v6
    u15 = p1
    u17 = p2
    u16 = 0
    u18 = 0
    local v7 = {NPCs = {}}
    local v8 = u15
    local v9 = u16
    u16 = u16 + 2
    local v10 = buffer.readu16(v8, v9)
    for i = 1, v10 do
        v9 = u15
        v2 = u16
        u16 = u16 + 2
        v6 = buffer.readu16(v9, v2)
        v1 = u15
        v3 = u16
        u16 = u16 + 4
        v9 = buffer.readf32(v1, v3)
        v2 = u15
        v4 = u16
        u16 = u16 + 4
        v1 = buffer.readf32(v2, v4)
        v3 = u15
        v5 = u16
        u16 = u16 + 4
        v2 = buffer.readf32(v3, v5)
        v8 = vector.create(v9, v1, v2)
        v7.NPCs[v6] = v8
    end
    local v11 = u15
    v6 = u16
    u16 = u16 + 8
    v7.ServerTick = buffer.readf64(v11, v6)
    v11 = u15
    v6 = u16
    u16 = u16 + 1
    v7.GroupIndex = buffer.readu8(v11, v6)
    if u425[0][1] then
        v10 = u425[0]
        v11 = nil
        local v12 = nil
        for j, k in v10, v11, v12 do
            task.spawn(k, v7)
        end
        return
    end
    v11 = u428[0]
    table.insert(v11, v7)
    v10 = #u428[0]
    if 64 < v10 then
        v10 = warn
        local v13 = u428
        v6 = #v13[0]
        v10((("[ZAP] %* events in queue for PositionChangedEvent. Did you forget to attach a listener?"):format(v6)))
    end
end)
u381[2].OnClientEvent:Connect(function(p1, p2) -- Line: 1410 -- upvalues: u15 (ref), u17 (ref), u16 (ref), u18 (ref), u425 (val), u428 (val)
    local v1
    u15 = p1
    u17 = p2
    u16 = 0
    u18 = 0
    local v2 = {}
    local v3 = u15
    local v4 = u16
    u16 = u16 + 4
    v2.Pitch = buffer.readf32(v3, v4)
    v3 = u15
    v4 = u16
    u16 = u16 + 4
    v2.Yaw = buffer.readf32(v3, v4)
    v3 = u15
    v4 = u16
    u16 = u16 + 8
    v2.ClientTick = buffer.readf64(v3, v4)
    u18 = u18 + 1
    v2.Player = u17[u18]
    v3 = v2.Player ~= nil
    assert(v3)
    if u425[1][1] then
        v1 = u425[1]
        v3 = nil
        local v5 = nil
        for i, j in v1, v3, v5 do
            task.spawn(j, v2)
        end
        return
    end
    v3 = u428[1]
    table.insert(v3, v2)
    v1 = #u428[1]
    if 64 < v1 then
        v1 = warn
        local v6 = u428
        v4 = #v6[1]
        v1((("[ZAP] %* events in queue for LookAngleEvent. Did you forget to attach a listener?"):format(v4)))
    end
end)
table.freeze({})
return {
    SendEvents = SendEvents,
    SelectionVote = {
        Fire = function(p1) -- Line: 1439 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 0)
            local v3 = #p1.Type
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.Type, v3)
            v1 = #p1.Value
            alloc(2)
            v4 = u10
            local v5 = u14
            buffer.writeu16(v4, v5, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.Value, v1)
        end,
    },
    RefreshServers = {
        Fire = function(p1) -- Line: 1458 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 1)
            local v3 = #p1.ServerType
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.ServerType, v3)
        end,
    },
    JoinServer = {
        Fire = function(p1) -- Line: 1471 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 2)
            local v3 = #p1.ServerType
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.ServerType, v3)
            v1 = #p1.ServerID
            alloc(2)
            v4 = u10
            local v5 = u14
            buffer.writeu16(v4, v5, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.ServerID, v1)
        end,
    },
    TellServerLoaded = {
        Fire = function(p1) -- Line: 1490 -- upvalues: alloc (val), u10 (ref), u14 (ref), u13 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 3)
            if p1 == nil then
                alloc(1)
                v1 = u10
                v2 = u14
                buffer.writeu8(v1, v2, 0)
                return
            end
            alloc(1)
            v1 = u10
            v2 = u14
            buffer.writeu8(v1, v2, 1)
            v1 = u13
            table.insert(v1, p1)
        end,
    },
    StartPrivateServer = {
        Fire = function(p1) -- Line: 1504 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 4)
        end,
    },
    JoinPrivateServer = {
        Fire = function(p1) -- Line: 1511 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 5)
            local v3 = #p1.PrivateServerId
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.PrivateServerId, v3)
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
            local v2 = u10
            local v3 = u14
            local Pitch = p1.Pitch
            buffer.writef32(v2, v3, Pitch)
            alloc(4)
            v2 = u10
            v3 = u14
            local Yaw = p1.Yaw
            buffer.writef32(v2, v3, Yaw)
            alloc(8)
            v2 = u10
            v3 = u14
            local ClientTick = p1.ClientTick
            buffer.writef64(v2, v3, ClientTick)
            local v4 = buffer.create(u11)
            buffer.copy(v4, 0, u10, 0, u11)
            v3 = u381
            v2 = v3[1]
            local v5 = u13
            v2:FireServer(v4, v5)
            u10 = v1.buff
            u11 = v1.used
            u12 = v1.size
            u13 = v1.inst
        end,
    },
    TriggerSelfExplosionEvent = {
        Fire = function(p1) -- Line: 1544 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 6)
            local v3 = #p1.ExplosionType
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.ExplosionType, v3)
        end,
    },
    Reloading = {
        Fire = function(p1) -- Line: 1557 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 7)
            alloc(2)
            v1 = u10
            v2 = u14
            local Slot = p1.Slot
            buffer.writeu16(v1, v2, Slot)
        end,
    },
    RespecSkillTree = {
        Fire = function(p1) -- Line: 1567 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 8)
        end,
    },
    RequestPrestige = {
        Fire = function(p1) -- Line: 1574 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 9)
        end,
    },
    HitRegClaim = {
        Fire = function(p1) -- Line: 1581 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            local bullet, targetId, v1, v2, v3, v4, x, x_2, x_3, y, y_2, y_3, z, z_2, z_3
            alloc(1)
            local v5 = u10
            local v6 = u14
            buffer.writeu8(v5, v6, 10)
            alloc(1)
            v5 = u10
            v6 = u14
            local moduleId = p1.moduleId
            buffer.writeu8(v5, v6, moduleId)
            local v7 = #p1.hits
            alloc(2)
            v6 = u10
            local v8 = u14
            buffer.writeu16(v6, v8, v7)
            v5 = v7
            local v9 = p1
            for i = 1, v5 do
                v1 = v9.hits[i]
                v2 = #v1.partName
                alloc(2)
                v3 = u10
                v4 = u14
                buffer.writeu16(v3, v4, v2)
                alloc(v2)
                buffer.writestring(u10, u14, v1.partName, v2)
                alloc(4)
                v3 = u10
                v4 = u14
                x = v1.hitPos.x
                buffer.writef32(v3, v4, x)
                alloc(4)
                v3 = u10
                v4 = u14
                y = v1.hitPos.y
                buffer.writef32(v3, v4, y)
                alloc(4)
                v3 = u10
                v4 = u14
                z = v1.hitPos.z
                buffer.writef32(v3, v4, z)
                alloc(4)
                v3 = u10
                v4 = u14
                x_2 = v1.origin.x
                buffer.writef32(v3, v4, x_2)
                alloc(4)
                v3 = u10
                v4 = u14
                y_2 = v1.origin.y
                buffer.writef32(v3, v4, y_2)
                alloc(4)
                v3 = u10
                v4 = u14
                z_2 = v1.origin.z
                buffer.writef32(v3, v4, z_2)
                alloc(4)
                v3 = u10
                v4 = u14
                targetId = v1.targetId
                buffer.writeu32(v3, v4, targetId)
                alloc(2)
                v3 = u10
                v4 = u14
                bullet = v1.bullet
                buffer.writeu16(v3, v4, bullet)
                if v1.hitPosDiff ~= nil then
                    alloc(1)
                    v3 = u10
                    v4 = u14
                    buffer.writeu8(v3, v4, 1)
                    alloc(4)
                    v3 = u10
                    v4 = u14
                    x_3 = v1.hitPosDiff.x
                    buffer.writef32(v3, v4, x_3)
                    alloc(4)
                    v3 = u10
                    v4 = u14
                    y_3 = v1.hitPosDiff.y
                    buffer.writef32(v3, v4, y_3)
                    alloc(4)
                    v3 = u10
                    v4 = u14
                    z_3 = v1.hitPosDiff.z
                    buffer.writef32(v3, v4, z_3)
                else
                    alloc(1)
                    v3 = u10
                    v4 = u14
                    buffer.writeu8(v3, v4, 0)
                end
            end
        end,
    },
    RushNpcParried = {
        Fire = function(p1) -- Line: 1639 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 11)
            alloc(4)
            v1 = u10
            v2 = u14
            local entityId = p1.entityId
            buffer.writeu32(v1, v2, entityId)
        end,
    },
    RushContinueChoice = {
        Fire = function(p1) -- Line: 1649 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            local v1
            alloc(1)
            local v2 = u10
            local v3 = u14
            buffer.writeu8(v2, v3, 12)
            alloc(1)
            v2 = u10
            v3 = u14
            if not p1.continueRun then
                v1 = 0
            else
                v1 = 1
            end
            buffer.writeu8(v2, v3, v1)
        end,
    },
    RushShopBuy = {
        Fire = function(p1) -- Line: 1659 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 13)
            local v3 = #p1.weaponName
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.weaponName, v3)
        end,
    },
    RushShopSell = {
        Fire = function(p1) -- Line: 1672 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 14)
            local v3 = #p1.weaponId
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.weaponId, v3)
        end,
    },
    RushShopAction = {
        Fire = function(p1) -- Line: 1685 -- upvalues: alloc (val), u10 (ref), u14 (ref)
            alloc(1)
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 15)
            local v3 = #p1.action
            alloc(2)
            v2 = u10
            local v4 = u14
            buffer.writeu16(v2, v4, v3)
            alloc(v3)
            buffer.writestring(u10, u14, p1.action, v3)
            v1 = #p1.weaponId
            alloc(2)
            v4 = u10
            local v5 = u14
            buffer.writeu16(v4, v5, v1)
            alloc(v1)
            buffer.writestring(u10, u14, p1.weaponId, v1)
            if p1.param ~= nil then
                alloc(1)
                v4 = u10
                v5 = u14
                buffer.writeu8(v4, v5, 1)
                v2 = #p1.param
                alloc(2)
                v5 = u10
                local v6 = u14
                buffer.writeu16(v5, v6, v2)
                alloc(v2)
                buffer.writestring(u10, u14, p1.param, v2)
            else
                alloc(1)
                v4 = u10
                v5 = u14
                buffer.writeu8(v4, v5, 0)
            end
            if p1.cost == nil then
                alloc(1)
                v4 = u10
                v5 = u14
                buffer.writeu8(v4, v5, 0)
                return
            end
            alloc(1)
            v4 = u10
            v5 = u14
            buffer.writeu8(v4, v5, 1)
            alloc(4)
            v4 = u10
            v5 = u14
            local cost = p1.cost
            buffer.writei32(v4, v5, cost)
        end,
    },
    InitUser = {
        On = function(p1) -- Line: 1727 -- upvalues: u419 (val), u422 (val)
            local v1 = u419[0]
            table.insert(v1, p1)
            local v2 = u422[0]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[1]
            table.insert(v1, p1)
            local v2 = u422[1]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[2]
            table.insert(v1, p1)
            local v2 = u422[2]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[3]
            table.insert(v1, p1)
            local v2 = u422[3]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[4]
            table.insert(v1, p1)
            local v2 = u422[4]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[5]
            table.insert(v1, p1)
            local v2 = u422[5]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[6]
            table.insert(v1, p1)
            local v2 = u422[6]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[7]
            table.insert(v1, p1)
            local v2 = u422[7]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[8]
            table.insert(v1, p1)
            local v2 = u422[8]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[9]
            table.insert(v1, p1)
            local v2 = u422[9]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[10]
            table.insert(v1, p1)
            local v2 = u422[10]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[11]
            table.insert(v1, p1)
            local v2 = u422[11]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[12]
            table.insert(v1, p1)
            local v2 = u422[12]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[13]
            table.insert(v1, p1)
            local v2 = u422[13]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[14]
            table.insert(v1, p1)
            local v2 = u422[14]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[15]
            table.insert(v1, p1)
            local v2 = u422[15]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[16]
            table.insert(v1, p1)
            local v2 = u422[16]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[17]
            table.insert(v1, p1)
            local v2 = u422[17]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[18]
            table.insert(v1, p1)
            local v2 = u422[18]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[19]
            table.insert(v1, p1)
            local v2 = u422[19]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[20]
            table.insert(v1, p1)
            local v2 = u422[20]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u425[0]
            table.insert(v1, p1)
            local v2 = u428[0]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u425[1]
            table.insert(v1, p1)
            local v2 = u428[1]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[21]
            table.insert(v1, p1)
            local v2 = u422[21]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[22]
            table.insert(v1, p1)
            local v2 = u422[22]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[23]
            table.insert(v1, p1)
            local v2 = u422[23]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[24]
            table.insert(v1, p1)
            local v2 = u422[24]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[25]
            table.insert(v1, p1)
            local v2 = u422[25]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[26]
            table.insert(v1, p1)
            local v2 = u422[26]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[27]
            table.insert(v1, p1)
            local v2 = u422[27]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[28]
            table.insert(v1, p1)
            local v2 = u422[28]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[29]
            table.insert(v1, p1)
            local v2 = u422[29]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[30]
            table.insert(v1, p1)
            local v2 = u422[30]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[31]
            table.insert(v1, p1)
            local v2 = u422[31]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[32]
            table.insert(v1, p1)
            local v2 = u422[32]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[33]
            table.insert(v1, p1)
            local v2 = u422[33]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[34]
            table.insert(v1, p1)
            local v2 = u422[34]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[35]
            table.insert(v1, p1)
            local v2 = u422[35]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[36]
            table.insert(v1, p1)
            local v2 = u422[36]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[37]
            table.insert(v1, p1)
            local v2 = u422[37]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[38]
            table.insert(v1, p1)
            local v2 = u422[38]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[39]
            table.insert(v1, p1)
            local v2 = u422[39]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[40]
            table.insert(v1, p1)
            local v2 = u422[40]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[41]
            table.insert(v1, p1)
            local v2 = u422[41]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[42]
            table.insert(v1, p1)
            local v2 = u422[42]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[43]
            table.insert(v1, p1)
            local v2 = u422[43]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[44]
            table.insert(v1, p1)
            local v2 = u422[44]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u419[45]
            table.insert(v1, p1)
            local v2 = u422[45]
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
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
            local v1 = u10
            local v2 = u14
            buffer.writeu8(v1, v2, 16)
            u429 = u429 + 1
            u429 = u429 % 256
            if u422[46][u429] then
                u429 = u429 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            alloc(1)
            v1 = u10
            v2 = u14
            local v3 = u429
            buffer.writeu8(v1, v2, v3)
            local v4 = u422[46]
            v4[u429] = (coroutine.running())
            return coroutine.yield()
        end,
    },
}