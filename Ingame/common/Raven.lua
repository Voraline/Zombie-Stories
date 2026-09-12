local HttpService = game:GetService("HttpService")
local u6 = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "a", "b", "c", "d", "e", "f"}
local u24 = Random.new()

local function RandomHex(p1) -- Line: 150 -- upvalues: u6 (val), u24 (val)
    local v1 = ""
    local v2 = p1
    for i = 1, v2 do
        v1 = v1 .. u6[u24:NextInteger(1, 16)]
    end
    return v1
end

local function u26() -- Line: 158 -- upvalues: RandomHex (val), u6 (val), u24 (val)
    return string.format(
        "%s4%s8%s%s",
        RandomHex(12),
        (("" .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)],
        (("" .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)]) .. u6[u24:NextInteger(1, 16)],
        (RandomHex(12))
    )
end

local function GetTimestamp() -- Line: 163
    local v1 = os.date("!*t")
    local year = v1.year
    local month = v1.month
    local day = v1.day
    local hour = v1.hour
    local min = v1.min
    local sec = v1.sec
    return ("%04d-%02d-%02dT%02d:%02d:%02d"):format(year, month, day, hour, min, sec)
end

local function TrySend(p1, p2, p3) -- Line: 168 -- upvalues: HttpService (val)
    if not p1.enabled then
        return false, "SDK disabled."
    end
    local success, result = pcall(HttpService.JSONEncode, HttpService, p2)
    if not success then
        return false, result
    end
    local success_2, result_2 = pcall(HttpService.PostAsync, HttpService, p1.requestUrl, result, Enum.HttpContentType.ApplicationJson, true, p3)
    if success_2 then
        local success_3, result_3 = pcall(HttpService.JSONDecode, HttpService, result_2)
        if success_3 then
            return true, result_3
        end
        return false, result_3
    end
    local v1 = result_2:match("^HTTP (%d+)")
    local v2 = tonumber(v1)
    if v2 then
        if not (400 <= v2) then
            if v2 == 429 then
                warn("Raven: HTTP 429 Retry-After in TrySend, disabling SDK for this server.")
                p1.enabled = false
            end
        elseif v2 < 500 then
            warn(("Raven: HTTP %d in TrySend, JSON packet:"):format(v2))
            warn(result)
            warn("Headers:")
            for k, v in pairs(p3) do
                warn(k .. " " .. v)
            end
            warn("Response:")
            warn(result_2)
            if v2 == 401 then
                warn("Please check the validity of your DSN.")
            end
        elseif v2 == 429 then
            warn("Raven: HTTP 429 Retry-After in TrySend, disabling SDK for this server.")
            p1.enabled = false
        end
    end
    return false, result_2
end

local function SendEvent(p1, p2, p3) -- Line: 220 -- upvalues: u26 (ref), TrySend (val)
    local v1
    local v2 = type(p2) == "table"
    assert(v2)
    v2 = os.date("!*t")
    local year = v2.year
    local month = v2.month
    local day = v2.day
    local hour = v2.hour
    local min = v2.min
    local sec = v2.sec
    local v3 = ("%04d-%02d-%02dT%02d:%02d:%02d"):format(year, month, day, hour, min, sec)
    p2.event_id = u26()
    p2.timestamp = v3
    p2.logger = "server"
    p2.platform = "other"
    p2.sdk = {name = "raven-rbxlua", version = "1.0"}
    for k, v in pairs(p1.config) do
        p2[k] = v
    end
    local v4, v5 = p1, p2
    for k2, i in pairs(p3) do
        if k2 ~= "tags" then
            v5[k2] = i
        else
            v1 = v5[k2]
            if type(v1) ~= "table" then
                v5[k2] = i
            else
                for k3, j in pairs(i) do
                    v5[k2][k3] = j
                end
            end
        end
    end
    v2 = {Authorization = v4.authHeader:format(v3)}
    local v6, v7 = TrySend(v4, v5, v2)
    return v6, v7
end

local function StringTraceToTable(p1) -- Line: 256
    local v1, v2, v3, v4
    local v5 = {}
    for i in p1:gmatch("[^\n\r]+") do
        if not i:match("^Stack Begin$") and not i:match("^Stack End$") then
            v2, v3, v4 = i:match("^Script '(.-)', Line (%d+)%s?%-?%s?(.*)$")
            if v2 and v3 and v4 then
                v1 = #v5 + 1
                v5[v1] = {filename = v2, ["function"] = v4 or "nil", lineno = v3}
                continue
            end
            return false, "invalid traceback"
        end
    end
    if #v5 == 0 then
        return false, "invalid traceback"
    end
    local v6 = {}
    for j = #v5, 1, -1 do
        v6[j] = v5[j]
    end
    return true, v6
end

local u31 = {
    EventLevel = {
        Fatal = "fatal",
        Error = "error",
        Warning = "warning",
        Info = "info",
        Debug = "debug",
    },
    ExceptionType = {Server = "ServerError", Client = "ClientError"},
}

function u31.Client(p1, p2, p3) -- Line: 301
    local v1 = {DSN = p2}
    local v2, v3, v4, v5, v6, v7 = p2:match("^([^:]+)://([^:]+):([^@]+)@([^/]+)(.*/)(.+)$")
    local v8 = v2
    if v8 then
        v8 = v2:lower():match("^https?$")
    end
    assert(v8, "invalid DSN: protocol not valid")
    assert(v3, "invalid DSN: public key not valid")
    assert(v4, "invalid DSN: secret key not valid")
    assert(v5, "invalid DSN: host not valid")
    assert(v6, "invalid DSN: path not valid")
    assert(v7, "invalid DSN: project ID not valid")
    v1.requestUrl = ("%s://%s%sapi/%d/store/"):format(v2, v5, v6, v7)
    local v9 = ("%s/%s"):format("raven-rbxlua", "1.0")
    v1.authHeader = ("Sentry sentry_version=%d,sentry_timestamp=%s,sentry_key=%s,sentry_secret=%s,sentry_client=%s"):format(
        "7",
        "%s",
        v3,
        v4,
        v9
    )
    local v10 = p3 or {}
    v1.config = v10
    v1.enabled = true
    local v11 = {__index = p1}
    return (setmetatable(v1, v11))
end

function u31.SendMessage(p1, p2, p3, p4) -- Line: 335 -- upvalues: SendEvent (val)
    local v1 = p4 or {}
    local v2 = v1
    v1 = {}
    local Info = p3
    if not Info then
        Info = p1.EventLevel.Info
    end
    v1.level = Info
    v1.message = p2
    return SendEvent(p1, v1, v2)
end

function u31.SendException(p1, p2, p3, p4, p5) -- Line: 346
    -- upvalues: StringTraceToTable (val), u31 (val), SendEvent (val)
    local v1
    local v2 = type(p2) == "string"
    assert(v2, "invalid exception type")
    local v3 = p5 or {}
    local v4 = v3
    v3 = {type = p2, value = p3}
    local filename = nil
    if type(p4) == "string" then
        local v5
        v1, v5 = StringTraceToTable(p4)
        if not v1 then
            warn(("Raven: Failed to convert string traceback to stacktrace: %s"):format(v5))
            warn(p4)
        else
            v3.stacktrace = {frames = v5}
            filename = v5[#v5].filename
        end
    elseif type(p4) == "table" then
        v3.stacktrace = {frames = p4}
        filename = p4[#p4].filename
    end
    v1 = {
        level = u31.EventLevel.Error,
        exception = {v3},
        culprit = filename,
    }
    return SendEvent(p1, v1, v4)
end

local function ScrubData(p1, p2, p3) -- Line: 382 -- upvalues: StringTraceToTable (val)
    local v1
    local v2 = p2:gsub(p1, "<Player>")
    local v3 = nil
    if p3 == nil then
        v1 = true
    else
        local v4, v5 = StringTraceToTable(p3)
        v1 = v4
        v3 = v5
        if v1 then
            for k, v in pairs(v3) do
                v.filename = v.filename:gsub(p1, "<Player>")
            end
        end
    end
    if v1 and v2 ~= "" then
        return true, v2, v3
    end
    return false, "invalid exception"
end

local u41 = setmetatable({}, {__mode = "k"})

function u31.ConnectRemoteEvent(p1, p2) -- Line: 405 -- upvalues: u41 (val), ScrubData (val), u31 (val)
    local v1 = false
    if typeof(p2) == "Instance" then
        v1 = p2.ClassName == "RemoteEvent"
    end
    assert(v1, "ConnectRemoteEvent did not receive RemoteEvent instance")
    p2.OnServerEvent:Connect(function(p1_2, p2, p3) -- Line: 408 -- upvalues: u41 (upval), ScrubData (upval), p1 (val), u31 (upval)
        local v1 = u41[p1_2]
        if not v1 then
            v1 = 5
        end
        if 0 < v1 then
            local Name_2, v2
            if type(p2) ~= "string" then
                v2 = warn
                Name_2 = p1_2.Name
                v2(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(Name_2))
                warn("errorMessage:")
                warn(p2)
                warn("traceback:")
                warn(p3)
                v1 = 0
            else
                local Client, Name, v3, v4, v5, v6
                if type(p3) == "string" then
                    v2, v3, v4 = ScrubData(p1_2.Name, p2, p3)
                    if not v2 then
                        v5 = warn
                        Name = p1_2.Name
                        v5(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(Name))
                        warn("errorMessage:")
                        warn(p2)
                        warn("traceback:")
                        warn(p3)
                        v1 = 0
                    else
                        v1 = v1 - 1
                        v5 = p1
                        v6 = u31
                        Client = v6.ExceptionType.Client
                        v5:SendException(Client, v3, v4)
                    end
                elseif p3 ~= nil then
                    v2 = warn
                    Name_2 = p1_2.Name
                    v2(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(Name_2))
                    warn("errorMessage:")
                    warn(p2)
                    warn("traceback:")
                    warn(p3)
                    v1 = 0
                else
                    v2, v3, v4 = ScrubData(p1_2.Name, p2, p3)
                    if not v2 then
                        v5 = warn
                        Name = p1_2.Name
                        v5(("Raven: Player '%s' tried to send spoofed data, their ability to report errors has been disabled."):format(Name))
                        warn("errorMessage:")
                        warn(p2)
                        warn("traceback:")
                        warn(p3)
                        v1 = 0
                    else
                        v1 = v1 - 1
                        v5 = p1
                        v6 = u31
                        Client = v6.ExceptionType.Client
                        v5:SendException(Client, v3, v4)
                    end
                end
            end
        end
        u41[p1_2] = v1
    end)
end

return u31