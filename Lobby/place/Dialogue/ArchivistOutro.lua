local u0 = {
    "Good luck out there, operative.",
    "Return when you have something new for the archive.",
    "Remember what you read. It may keep you alive.",
    "Until next time, operative.",
}
local u6 = Random.new()
local u7 = nil
return {
    id = "ArchivistOutro",
    speaker = "ARCHIVIST",
    root = "root",
    interactRange = 9,
    leaveRange = 15,
    nodes = {
        root = {
            lines = {
                function(p1) -- Line: 11 -- upvalues: u0 (val), u7 (ref), u6 (val)
                    local v1
                    if p1.values.firstVisit then
                        return "If that's all, then I will see you another time. Welcome to the Odysseus."
                    end
                    if #u0 == 1 then
                        v1 = 1
                    else
                        local v2, v3
                        if not u7 then
                            v2 = u6
                            local v4 = u0
                            v3 = #v4
                            v1 = v2:NextInteger(1, v3)
                        else
                            v2 = u6
                            local v5 = u0
                            v3 = #v5 - 1
                            v1 = v2:NextInteger(1, v3)
                            if u7 <= v1 then
                                v1 = v1 + 1
                            end
                        end
                    end
                    u7 = v1
                    return u0[v1]
                end,
            },
        },
    },
}