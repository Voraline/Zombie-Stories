local v1
local HttpService = game:GetService("HttpService")
local u6 = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
}
local u24 = Random.new()
local function RandomHex(p1) -- Line: 150 -- upvalues: u6 (val), u24 (val)
    local v1 = ""
    local v2 = p1
    local v3 = 1
    for i = 1, v2, v3 do
        v1 = v1 .. u6[u24:NextInteger(1, 16)]
    end
    return v1
end
local function u26() -- Line: 158 -- upvalues: RandomHex (val), u6 (val), u24 (val)
    local v1 = RandomHex(12)
    local v2 = (("" .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)]
    local v3 = (("" .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)]
    return string.format("%s4%s8%s%s", v1, v2, v3, (RandomHex(12)))
end
local function GetTimestamp() -- Line: 163
    local v1 = os.date("!*t")
    return ("%04d-%02d-%02dT%02d:%02d:%02d"):format(v1.year, v1.month, v1.day, v1.hour, v1.min, v1.sec)
end
local function TrySend(p1, p2, p3) -- Line: 168 -- upvalues: HttpService (val)
    local v1, v2, v3, v4, v5
    if not p1.enabled then
        return false, "SDK disabled."
    end
    v1, v2 = pcall(HttpService.JSONEncode, HttpService, p2)
    if not v1 then
        return false, v2
    end
    v3, v4 = pcall(HttpService.PostAsync, HttpService, p1.requestUrl, v2, Enum.HttpContentType.ApplicationJson, true, p3)
    if v3 then
        local v6
        v5, v6 = pcall(HttpService.JSONDecode, HttpService, v4)
        if v5 then
            return true, v6
        end
        return false, v6
    end
    v5 = tonumber(v4:match("^HTTP (%d+)"))
    if v5 then
        if 400 > v5 then
            if v5 == 429 then
                warn("Raven: HTTP 429 Retry-After in TrySend, disabling SDK for this server.")
                p1.enabled = false
            end
        elseif v5 < 500 then
            warn(("Raven: HTTP %d in TrySend, JSON packet:"):format(v5))
            warn(v2)
            warn("Headers:")
            for k, v in pairs(p3) do
                warn(k .. " " .. v)
            end
            warn("Response:")
            warn(v4)
            if v5 == 401 then
                warn("Please check the validity of your DSN.")
            end
        elseif v5 == 429 then
            warn("Raven: HTTP 429 Retry-After in TrySend, disabling SDK for this server.")
            p1.enabled = false
        end
    end
    return false, v4
end
local function SendEvent(p1, p2, p3) -- Line: 220 -- upvalues: u26 (ref), TrySend (val)
    local v1, v2, v3, v4
    local v5 = type(p2) == "table"
    assert(v5)
    v5 = os.date("!*t")
    local v6 = ("%04d-%02d-%02dT%02d:%02d:%02d"):format(v5.year, v5.month, v5.day, v5.hour, v5.min, v5.sec)
    p2.event_id = u26()
    p2.timestamp = v6
    p2.logger = "server"
    p2.platform = "other"
    p2.sdk = {name = "raven-rbxlua", version = "1.0"}
    for k, v in pairs(p1.config) do
        p2[k] = v
    end
    v1, v2 = p1, p2
    for k2, i in pairs(p3) do
        if k2 ~= "tags" then
            v2[k2] = i
        elseif type(v2[k2]) == "table" then
            for k3, j in pairs(i) do
                v2[k2][k3] = j
            end
        end
    end
    v3, v4 = TrySend(v1, v2, {Authorization = v1.authHeader:format(v6)})
    return v3, v4
end
local function StringTraceToTable(p1) -- Line: 256
    local v1, v2, v3, v4, v5
    local v6 = {}
    for i in p1:gmatch("[^\n\r]+") do
        if not (i:match("^Stack Begin$")) and not (i:match("^Stack End$")) then
            v3, v4, v5 = i:match("^Script '(.-)', Line (%d+)%s?%-?%s?(.*)$")
            if v3 and v4 and v5 then
                v1 = #v6 + 1
                v2 = {filename = v3}
                v2["function"] = v5 or "nil"
                v2.lineno = v4
                v6[v1] = v2
                continue
            end
            return false, "invalid traceback"
        end
    end
    if #v6 == 0 then
        return false, "invalid traceback"
    end
    local v7 = {}
    local v8 = 1
    local v9 = -1
    for j = #v6, v8, v9 do
        v7[j] = v6[j]
    end
    return true, v7
end
local u31 = {
    EventLevel = {
        Fatal = "fatal",
        Error = "error",
        Warning = "warning",
        Info = "info",
        Debug = "debug",
    },
}
v1 = {Server = "ServerError", Client = "ClientError"}
u31.ExceptionType = v1
function u31.Client(p1, p2, p3) -- Line: 301
    local v1, v2, v3, v4, v5, v6
    local v7 = {DSN = p2}
    v1, v2, v3, v4, v5, v6 = p2:match("^([^:]+)://([^:]+):([^@]+)@([^/]+)(.*/)(.+)$")
    local v8 = v1
    if v8 then
        v8 = v1:lower():match("^https?$")
    end
    assert(v8, "invalid DSN: protocol not valid")
    assert(v2, "invalid DSN: public key not valid")
    assert(v3, "invalid DSN: secret key not valid")
    assert(v4, "invalid DSN: host not valid")
    assert(v5, "invalid DSN: path not valid")
    assert(v6, "invalid DSN: project ID not valid")
    v7.requestUrl = ("%s://%s%sapi/%d/store/"):format(v1, v4, v5, v6)
    v7.authHeader = ("Sentry sentry_version=%d,sentry_timestamp=%s,sentry_key=%s,sentry_secret=%s,sentry_client=%s"):format("7", "%s", v2, v3, ("%s/%s"):format("raven-rbxlua", "1.0"))
    local v9 = p3
    if not v9 then
        v9 = {}
    end
    v7.config = v9
    v7.enabled = true
    local v10 = {__index = p1}
    return (setmetatable(v7, v10))
end
function u31.SendMessage(p1, p2, p3, p4) -- Line: 335 -- upvalues: SendEvent (val)
    local v1 = p4
    if not v1 then
        v1 = {}
    end
    v1 = {}
    local Info = p3
    if not Info then
        Info = p1.EventLevel.Info
    end
    v1.level = Info
    v1.message = p2
    return SendEvent(p1, v1, v1)
end
function u31.SendException(p1, p2, p3, p4, p5) -- Line: 346 -- upvalues: StringTraceToTable (val), u31 (val), SendEvent (val)
    local v1 = type(p2) == "string"
    assert(v1, "invalid exception type")
    local v2 = p5
    if not v2 then
        v2 = {}
    end
    v2 = {type = p2, value = p3}
    local filename = nil
    if type(p4) == "string" then
        local v3, v4
        v3, v4 = StringTraceToTable(p4)
        if not v3 then
            warn(("Raven: Failed to convert string traceback to stacktrace: %s"):format(v4))
            warn(p4)
        else
            v2.stacktrace = {frames = v4}
            filename = v4[#v4].filename
        end
    elseif type(p4) == "table" then
        v2.stacktrace = {frames = p4}
        filename = p4[#p4].filename
    end
    return SendEvent(p1, {
        level = u31.EventLevel.Error,
        exception = {v2},
        culprit = filename,
    }, v2)
end
local function ScrubData(p1, p2, p3) -- Line: 382 -- upvalues: StringTraceToTable (val)
    local v1
    local v2 = p2:gsub(p1, "<Player>")
    local v3 = nil
    if p3 == nil then
        v1 = true
    else
        local v4, v5
        v4, v5 = StringTraceToTable(p3)
        v1 = v4
        v3 = v5
        if v1 then
            for k, v in pairs(v3) do
                v.filename = v.filename:gsub(p1, "<Player>")
            end
        end
    end
    if not v1 then
        return false, "invalid exception"
    end
    if v2 ~= "" then
        return true, v2, v3
    end
    return false, "invalid exception"
end
local u41 = setmetatable({}, {__mode = "k"})
function u31.ConnectRemoteEvent(p1, p2) -- Line: 405 -- upvalues: u41 (val), ScrubData (val), u31 (val)
    local v1 = if typeof(p2) == "Instance" then p2.ClassName == "RemoteEvent" else false
    assert(v1, "ConnectRemoteEvent did not receive RemoteEvent instance")
    p2.OnServerEvent:Connect(function(a1, p2, p3) -- Line: 408 -- upvalues: u41 (upval), ScrubData (upval), p1 (val), u31 (upval)
        local v1 = u41[a1]
        if not v1 then
            v1 = 5
        end
        if 0 < v1 then
            if type(p2) ~= "string" then
                warn(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(a1.Name))
                warn("errorMessage:")
                warn(p2)
                warn("traceback:")
                warn(p3)
                v1 = 0
            else
                local v2, v3, v4
                if type(p3) == "string" then
                    v2, v3, v4 = ScrubData(a1.Name, p2, p3)
                    if not v2 then
                        warn(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(a1.Name))
                        warn("errorMessage:")
                        warn(p2)
                        warn("traceback:")
                        warn(p3)
                        v1 = 0
                    else
                        v1 = v1 - 1
                        p1:SendException(u31.ExceptionType.Client, v3, v4)
                    end
                elseif p3 ~= nil then
                    warn(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(a1.Name))
                    warn("errorMessage:")
                    warn(p2)
                    warn("traceback:")
                    warn(p3)
                    v1 = 0
                else
                    v2, v3, v4 = ScrubData(a1.Name, p2, p3)
                    if not v2 then
                        warn(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(a1.Name))
                        warn("errorMessage:")
                        warn(p2)
                        warn("traceback:")
                        warn(p3)
                        v1 = 0
                    else
                        v1 = v1 - 1
                        p1:SendException(u31.ExceptionType.Client, v3, v4)
                    end
                end
            end
        end
        u41[a1] = v1
    end)
end
return u31