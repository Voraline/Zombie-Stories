local u0 = {
    TrackingEnabled = true,
    CATEGORIES = {
        {Key = "ZK", Field = "ZK", Title = "MOST ZOMBIE KILLS", Scope = "Story"},
        {Key = "ZHK", Field = "ZHK", Title = "MOST HEADSHOTS", Scope = "Story"},
        {Key = "MC", Field = "MC", Title = "MOST MISSIONS", Scope = "Story"},
        {Key = "QC", Field = "QC", Title = "MOST QUESTS", Scope = "All"},
    },
    FACE_ORDER = {"ZK", "ZHK", "MC", "QC"},
}
local u12 = {
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER",
}
local u25 = {}
for i, v in ipairs(u0.CATEGORIES) do
    u25[v.Key] = v
end

local function utcOffset(p1) -- Line: 56
    return os.time(os.date("!*t", p1)) - p1
end

local function monthStart(p1, p2) -- Line: 60
    local v1 = os.time({
        day = 1,
        hour = 0,
        min = 0,
        sec = 0,
        year = p1,
        month = p2,
    })
    return v1 - (os.time(os.date("!*t", v1)) - v1)
end

local function parsePeriod(p1) -- Line: 72
    local v1, v2 = string.match(p1, "^(%d%d%d%d)%-(%d%d)$")
    local v3 = tonumber(v1)
    local v4 = tonumber(v2)
    local v5 = false
    if v3 ~= nil then
        v5 = false
        if v4 ~= nil then
            v5 = false
            if 1 <= v4 then
                v5 = v4 <= 12
            end
        end
    end
    assert(v5, "Invalid monthly leaderboard period")
    return v3, v4
end

function u0.GetCategory(p1) -- Line: 80 -- upvalues: u25 (val)
    return u25[p1]
end

function u0.StoreName(p1, p2) -- Line: 84
    return ("ZSM_%s_%s"):format(p1, p2)
end

function u0.PeriodKey(p1) -- Line: 88
    local date = os.date
    local v1 = p1
    if not v1 then
        v1 = os.time()
    end
    local v2 = date("!*t", v1)
    return string.format("%04d-%02d", v2.year, v2.month)
end

function u0.PreviousPeriodKey(p1) -- Line: 93 -- upvalues: u0 (val)
    local v1, v2 = string.match(p1, "^(%d%d%d%d)%-(%d%d)$")
    local v3 = tonumber(v1)
    local v4 = tonumber(v2)
    local v5 = false
    if v3 ~= nil then
        v5 = false
        if v4 ~= nil then
            v5 = false
            if 1 <= v4 then
                v5 = v4 <= 12
            end
        end
    end
    assert(v5, "Invalid monthly leaderboard period")
    local v6 = v3
    v1 = u0
    local PeriodKey = v1.PeriodKey
    v3 = v4 - 1
    v4 = os.time({
        day = 1,
        hour = 0,
        min = 0,
        sec = 0,
        year = v6,
        month = v3,
    })
    return PeriodKey(v4 - (os.time(os.date("!*t", v4)) - v4))
end

function u0.NextResetAt(p1) -- Line: 98
    local v1, v2 = string.match(p1, "^(%d%d%d%d)%-(%d%d)$")
    local v3 = tonumber(v1)
    local v4 = tonumber(v2)
    local v5 = false
    if v3 ~= nil then
        v5 = false
        if v4 ~= nil then
            v5 = false
            if 1 <= v4 then
                v5 = v4 <= 12
            end
        end
    end
    assert(v5, "Invalid monthly leaderboard period")
    v2 = v4 + 1
    v3 = os.time({
        day = 1,
        hour = 0,
        min = 0,
        sec = 0,
        year = v3,
        month = v2,
    })
    return v3 - (os.time(os.date("!*t", v3)) - v3)
end

function u0.PeriodLabel(p1) -- Line: 103 -- upvalues: u12 (val)
    local v1, v2 = string.match(p1, "^(%d%d%d%d)%-(%d%d)$")
    local v3 = tonumber(v1)
    local v4 = tonumber(v2)
    local v5 = false
    if v3 ~= nil then
        v5 = false
        if v4 ~= nil then
            v5 = false
            if 1 <= v4 then
                v5 = v4 <= 12
            end
        end
    end
    assert(v5, "Invalid monthly leaderboard period")
    local v6 = v3
    return string.format("%s %04d", u12[v4], v6)
end

return u0