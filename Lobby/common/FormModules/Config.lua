local Parent = script.Parent
local RemoteType = require(Parent.RemoteType)
local ResponseType = require(Parent.ResponseType)
local v1 = {
    FormId = "1FAIpQLScKlw04NLRd2p2hbeVNPQH9dOaY_TYd2H-3a3B6Ef5Mv4Gp_g",
    CacheForm = true,
    FilterText = false,
    DisableTouchInputs = true,
    AllowMultipleResponses = true,
    DataStoreName = "FormResponses",
    Icon = "http://www.roblox.com/asset/?id=6023426957",
}
local v2 = {}
v2[ResponseType.Success] = {
    Icon = "http://www.roblox.com/asset/?id=6023426957",
    Title = "Form Submitted",
    Text = "Thank you ? Your feedback is appreciated!",
    Duration = 5,
}
v2[ResponseType.Error] = {
    Icon = "http://www.roblox.com/asset/?id=6023426957",
    Title = "Feedback Form Unavailable",
    Text = "Please try again later or contact the developer.",
    Duration = 5,
}
v2[ResponseType.RateLimit] = {
    Icon = "http://www.roblox.com/asset/?id=6023426957",
    Title = "Slow Down",
    Text = "Please wait before trying again.",
    Duration = 3,
}
v2[ResponseType.NotAllowed] = {
    Icon = "http://www.roblox.com/asset/?id=6023426957",
    Title = "Not Allowed",
    Text = "You have already submitted this form.",
    Duration = 3,
}
v1.Notifications = v2
v2 = {}
v2[RemoteType.FetchFormData] = 1
v2[RemoteType.SubmitFormData] = 5
v2[RemoteType.FilterText] = 0.5
v1.RateLimits = v2
v1.Metadata = {
    Username = "__username__",
    UserId = "__userid__",
    DisplayName = "__displayname__",
    PlaceId = "__placeid__",
    PlaceVersion = "__placeversion__",
    ClientVersion = "__clientversion__",
    Time = "__time__",
    ElapsedTime = "__elapsedtime__",
    GcInfo = "__gcinfo__",
    ServerSize = "__serversize__",
}
return v1