local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u7 = require("../Shared/Util")
local AnnouncementScopes = require(ReplicatedStorage.common.ZS_Shared.Data.AnnouncementScopes)
local u14 = {
    DisplayName = "Announcement scope",
    Prefixes = "",
    Transform = function(p1) -- Line: 10 -- upvalues: u7 (val), AnnouncementScopes (val)
        return u7.MakeFuzzyFinder(AnnouncementScopes.Names)(p1)
    end,
    Validate = function(p1) -- Line: 15
        local v1 = 0 < #p1
        return v1, "No announcement scope with that name exists."
    end,
    Autocomplete = function(p1) -- Line: 19
        return p1
    end,
    Parse = function(p1) -- Line: 23
        return p1[1]
    end,
}
return function(p1) -- Line: 28 -- upvalues: u14 (val)
    p1:RegisterType("announceScope", u14)
end