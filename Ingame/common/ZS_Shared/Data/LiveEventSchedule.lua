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
    DailyShowingsUTC = {"09:00", "21:00"},
}

local function parseUtcTime(p1) -- Line: 16
    local v1, v2 = string.match(p1, "^(%d%d):(%d%d)$")
    local v3 = tonumber(v1)
    local v4 = tonumber(v2)
    if v3 and v4 and not (23 < v3) and not (59 < v4) then
        return v3 * 3600 + v4 * 60
    end
    return nil
end

local function isConfigured() -- Line: 26 -- upvalues: u0 (val)
    local v1 = false
    if 0 < u0.ActiveFrom then
        local v2 = u0
        local ActiveUntil = v2.ActiveUntil
        v1 = u0.ActiveFrom < ActiveUntil
    end
    return v1
end

local function makeShowing(p1, p2, p3, p4, p5) -- Line: 30 -- upvalues: u0 (val)
    local v1
    local v2 = false
    if p3 ~= "Premiere" then
        if not (p2 < p1) then
            v1 = "Catchup"
            v2 = true
        else
            v1 = "Holding"
        end
    elseif p2 < p1 - u0.SynchronizedEntryCloseLeadSeconds then
        v1 = "Holding"
    elseif not (p2 < p1) then
        v1 = "Catchup"
        v2 = true
    else
        v1 = "FinalLoading"
    end
    local v3 = {eventId = u0.EventId}
    local format = string.format
    local v4 = u0
    v3.showingId = format("%s:%s:%d", v4.EventId, string.lower(p3), p1)
    v3.showingKind = p3
    v3.showAt = p1
    v3.entryOpenAt = p4
    v3.phase = v1
    local v5 = false
    if p4 <= p2 then
        v5 = p2 <= p5
    end
    v3.canEnter = v5
    v3.immediatePlayback = v2
    v3.entryClosesAt = p5
    local v6 = u0
    local CutsceneLength = v6.CutsceneLength
    v3.windowEndsAt = p5 + math.ceil(CutsceneLength) + u0.WindowGraceSeconds
    return v3
end

function u0.GetShowingForStartTime(p1, p2, p3, p4) -- Line: 69 -- upvalues: u0 (val), makeShowing (val)
    if type(p1) == "number" and p1 == p1 and math.abs(p1) ~= (1 / 0) and not (p1 <= 0) then
        local v1, v2
        local v3 = p2
        if not v3 then
            v3 = os.time()
        end
        local v4 = math.floor(v3)
        local v5 = math.floor(p1)
        if type(p4) ~= "number" or not (0 < p4) then
            v2 = v5 - u0.PreShowLeadSeconds
        else
            v2 = math.floor(p4)
        end
        v3 = v5 + u0.LateCatchupSeconds
        if v3 < v4 then
            return nil
        end
        if not p3 and v4 < v2 then
            return nil
        end
        local v6 = makeShowing
        if not p3 then
            v1 = v2
        else
            v1 = v4
        end
        return (v6(v5, v4, "Premiere", v1, v3))
    end
    return nil
end

local function getDailyShowing(p1, p2, p3) -- Line: 91 -- upvalues: u0 (val), makeShowing (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = p1 - p1 % 86400
    local v8, v9, v10 = p1, p2, p3
    for i = -1, 0 do
        v6 = v7 + i * 86400
        for i2, v in ipairs(u0.DailyShowingsUTC) do
            v2, v3 = string.match(v, "^(%d%d):(%d%d)$")
            v4 = tonumber(v2)
            v5 = tonumber(v3)
            if not v4 or not v5 or 23 < v4 then
                v1 = nil
            elseif not (59 < v5) then
                v1 = v4 * 3600 + v5 * 60
            else
                v1 = nil
            end
            if v1 then
                v2 = v6 + v1
                v3 = v2 - u0.ReplayPreShowLeadSeconds
                v4 = v2 + u0.ReplayEntryCutoffSeconds
                if v3 <= v8 and v8 <= v4 and v9 <= v2 then
                    if v10 and not (v2 <= v10) then
                        continue
                    end
                    return (makeShowing(v2, v8, "Replay", v3, v4))
                end
            end
        end
    end
    return nil
end

function u0.GetCurrentReplayShowing(p1, p2) -- Line: 115 -- upvalues: u0 (val), getDailyShowing (val)
    if type(p1) == "number" and not (p1 <= 0) then
        local v1 = p2
        if not v1 then
            v1 = os.time()
        end
        local v2 = math.floor(v1)
        local v3 = (math.floor(p1)) + u0.LateCatchupSeconds + 1
        if v2 < v3 then
            return nil
        end
        return (getDailyShowing(v2, v3, nil))
    end
    return nil
end

function u0.IsConfigured() -- Line: 127 -- upvalues: u0 (val)
    local v1 = false
    if 0 < u0.ActiveFrom then
        local v2 = u0
        local ActiveUntil = v2.ActiveUntil
        v1 = u0.ActiveFrom < ActiveUntil
    end
    return v1
end

function u0.GetCurrentShowing(p1) -- Line: 131 -- upvalues: u0 (val), getDailyShowing (val)
    local v1
    local v2 = false
    if 0 < u0.ActiveFrom then
        v1 = u0
        local ActiveUntil = v1.ActiveUntil
        v2 = u0.ActiveFrom < ActiveUntil
    end
    if not v2 then
        return nil
    end
    v1 = p1
    if not v1 then
        v1 = os.time()
    end
    local v3 = math.floor(v1)
    return (getDailyShowing(v3, u0.ActiveFrom, u0.ActiveUntil))
end

function u0.GetNextShowing(p1) -- Line: 140 -- upvalues: u0 (val), makeShowing (val)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = false
    if 0 < u0.ActiveFrom then
        v6 = u0
        local ActiveUntil = v6.ActiveUntil
        v8 = u0.ActiveFrom < ActiveUntil
    end
    if not v8 then
        return nil
    end
    v6 = p1
    if not v6 then
        v6 = os.time()
    end
    local v9 = math.floor(v6)
    v6 = v9 + 1
    local v10 = u0
    local ActiveFrom = v10.ActiveFrom
    v8 = math.max(v6, ActiveFrom)
    v6 = v8 - v8 % 86400
    for i = 0, 2 do
        v7 = v6 + i * 86400
        for i2, v in ipairs(u0.DailyShowingsUTC) do
            v2, v3 = string.match(v, "^(%d%d):(%d%d)$")
            v4 = tonumber(v2)
            v5 = tonumber(v3)
            if not v4 or not v5 or 23 < v4 then
                v1 = nil
            elseif not (59 < v5) then
                v1 = v4 * 3600 + v5 * 60
            else
                v1 = nil
            end
            v2 = v1
            if v2 then
                v2 = v7 + v1
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