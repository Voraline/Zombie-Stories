local u0 = {
    EventId = "LIVEEVENT_S1",
    ActiveFrom = 0,
    ActiveUntil = 0,
    PreShowLeadSeconds = 1800,
    SynchronizedEntryCloseLeadSeconds = 300,
    LateCatchupSeconds = 1800,
    ReplayPreShowLeadSeconds = 1800,
    ReplayEntryCutoffSeconds = 900,
    WindowGraceSeconds = 30,
    CutsceneLength = 395.9133333333333,
}
local v1 = {"09:00", "21:00"}
u0.DailyShowingsUTC = v1
local function parseUtcTime(p1) -- Line: 16
    local v1, v2
    v1, v2 = string.match(p1, "^(%d%d):(%d%d)$")
    local v3 = tonumber(v1)
    local v4 = tonumber(v2)
    if not v3 or not v4 or 23 < v3 or 59 < v4 then
        return nil
    end
    return v3 * 3600 + v4 * 60
end
local function isConfigured() -- Line: 26 -- upvalues: u0 (val)
    local v1 = if 0 < u0.ActiveFrom then u0.ActiveFrom < u0.ActiveUntil else false
    return v1
end
local function makeShowing(p1, p2, p3, p4, p5) -- Line: 30 -- upvalues: u0 (val)
    local v1
    local v2 = false
    if p3 ~= "Premiere" then
        if p2 >= p1 then
            v1 = "Catchup"
            v2 = true
        else
            v1 = "Holding"
        end
    elseif p2 < p1 - u0.SynchronizedEntryCloseLeadSeconds then
        v1 = "Holding"
    elseif p2 >= p1 then
        v1 = "Catchup"
        v2 = true
    else
        v1 = "FinalLoading"
    end
    local v3 = {eventId = u0.EventId}
    local v4 = string.lower(p3)
    v3.showingId = string.format("%s:%s:%d", u0.EventId, v4, p1)
    v3.showingKind = p3
    v3.showAt = p1
    v3.entryOpenAt = p4
    v3.phase = v1
    local v5 = if p4 <= p2 then p2 <= p5 else false
    v3.canEnter = v5
    v3.immediatePlayback = v2
    v3.entryClosesAt = p5
    local v6 = p5 + math.ceil(u0.CutsceneLength)
    v3.windowEndsAt = v6 + u0.WindowGraceSeconds
    return v3
end
function u0.GetShowingForStartTime(p1, p2, p3, p4) -- Line: 69 -- upvalues: u0 (val), makeShowing (val)
    local v1, v2
    if type(p1) ~= "number" or p1 ~= p1 or math.abs(p1) == (1 / 0) or p1 <= 0 then
        return nil
    end
    local v3 = p2
    if not v3 then
        v3 = os.time()
    end
    local v4 = math.floor(v3)
    local v5 = math.floor(p1)
    if type(p4) ~= "number" then
        v2 = v5 - u0.PreShowLeadSeconds
    elseif 0 < p4 then
        v2 = math.floor(p4)
    end
    v3 = v5 + u0.LateCatchupSeconds
    if v3 < v4 then
        return nil
    end
    if p3 then
        if not p3 then
            v1 = v2
        else
            v1 = v4
        end
        return (makeShowing(v5, v4, "Premiere", v1, v3))
    end
    if v4 < v2 then
        return nil
    end
    if not p3 then
        v1 = v2
    else
        v1 = v4
    end
    return (makeShowing(v5, v4, "Premiere", v1, v3))
end
local function getDailyShowing(p1, p2, p3) -- Line: 91 -- upvalues: u0 (val), makeShowing (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = p1 - p1 % 86400
    local v11 = 0
    local v12 = 1
    v1, v2, v8 = p1, p2, p3
    for i = -1, v11, v12 do
        v9 = v10 + i * 86400
        for i2, v in ipairs(u0.DailyShowingsUTC) do
            v4, v5 = string.match(v, "^(%d%d):(%d%d)$")
            v6 = tonumber(v4)
            v7 = tonumber(v5)
            if not v6 then
                v3 = nil
            elseif v7 and 23 >= v6 and 59 >= v7 then
                v3 = v6 * 3600 + v7 * 60
            end
            if v3 then
                v4 = v9 + v3
                v5 = v4 - u0.ReplayPreShowLeadSeconds
                v6 = v4 + u0.ReplayEntryCutoffSeconds
                if v5 <= v1 and v1 <= v6 and v2 <= v4 then
                    if v8 and v4 > v8 then
                        continue
                    end
                    return (makeShowing(v4, v1, "Replay", v5, v6))
                end
            end
        end
    end
    return nil
end
function u0.GetCurrentReplayShowing(p1, p2) -- Line: 115 -- upvalues: u0 (val), getDailyShowing (val)
    if type(p1) ~= "number" or p1 <= 0 then
        return nil
    end
    local v1 = p2
    if not v1 then
        v1 = os.time()
    end
    local v2 = math.floor(v1)
    local v3 = math.floor(p1)
    local v4 = v3 + u0.LateCatchupSeconds + 1
    if v2 < v4 then
        return nil
    end
    return (getDailyShowing(v2, v4, nil))
end
function u0.IsConfigured() -- Line: 127 -- upvalues: u0 (val)
    local v1 = if 0 < u0.ActiveFrom then u0.ActiveFrom < u0.ActiveUntil else false
    return v1
end
function u0.GetCurrentShowing(p1) -- Line: 131 -- upvalues: u0 (val), getDailyShowing (val)
    local v1 = if 0 < u0.ActiveFrom then u0.ActiveFrom < u0.ActiveUntil else false
    if not v1 then
        return nil
    end
    local v2 = p1
    if not v2 then
        v2 = os.time()
    end
    local v3 = math.floor(v2)
    return (getDailyShowing(v3, u0.ActiveFrom, u0.ActiveUntil))
end
function u0.GetNextShowing(p1) -- Line: 140 -- upvalues: u0 (val), makeShowing (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = if 0 < u0.ActiveFrom then u0.ActiveFrom < u0.ActiveUntil else false
    if not v7 then
        return nil
    end
    local v8 = p1
    if not v8 then
        v8 = os.time()
    end
    local v9 = math.floor(v8)
    v7 = math.max(v9 + 1, u0.ActiveFrom)
    v8 = v7 - v7 % 86400
    local v10 = 2
    local v11 = 1
    for i = 0, v10, v11 do
        v6 = v8 + i * 86400
        for i2, v in ipairs(u0.DailyShowingsUTC) do
            v2, v3 = string.match(v, "^(%d%d):(%d%d)$")
            v4 = tonumber(v2)
            v5 = tonumber(v3)
            if not v4 then
                v1 = nil
            elseif v5 and 23 >= v4 and 59 >= v5 then
                v1 = v4 * 3600 + v5 * 60
            end
            v2 = v1
            if v2 then
                v2 = v6 + v1
            end
            if v2 and v9 < v2 and u0.ActiveFrom <= v2 and v2 <= u0.ActiveUntil then
                v3 = v2 - u0.ReplayPreShowLeadSeconds
                v4 = v2 + u0.ReplayEntryCutoffSeconds
                return (makeShowing(v2, v9, "Replay", v3, v4))
            end
        end
    end
    return nil
end
return table.freeze(u0)