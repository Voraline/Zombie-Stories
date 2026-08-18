local v1 = script.Parent
local v2 = require(v1.RemoteType)
local v3 = require(v1.ResponseType)
local v4 = {
	["FormId"] = "1FAIpQLScKlw04NLRd2p2hbeVNPQH9dOaY_TYd2H-3a3B6Ef5Mv4Gp_g",
	["CacheForm"] = true,
	["FilterText"] = false,
	["DisableTouchInputs"] = true,
	["AllowMultipleResponses"] = true,
	["DataStoreName"] = "FormResponses",
	["Icon"] = "http://www.roblox.com/asset/?id=6023426957",
	["Notifications"] = nil,
	["RateLimits"] = nil,
	["Metadata"] = nil,
	["Notifications"] = {
		[v3.Success] = {
			["Icon"] = "http://www.roblox.com/asset/?id=6023426957",
			["Title"] = "Form Submitted",
			["Text"] = "Thank you ? Your feedback is appreciated!",
			["Duration"] = 5
		},
		[v3.Error] = {
			["Icon"] = "http://www.roblox.com/asset/?id=6023426957",
			["Title"] = "Feedback Form Unavailable",
			["Text"] = "Please try again later or contact the developer.",
			["Duration"] = 5
		},
		[v3.RateLimit] = {
			["Icon"] = "http://www.roblox.com/asset/?id=6023426957",
			["Title"] = "Slow Down",
			["Text"] = "Please wait before trying again.",
			["Duration"] = 3
		},
		[v3.NotAllowed] = {
			["Icon"] = "http://www.roblox.com/asset/?id=6023426957",
			["Title"] = "Not Allowed",
			["Text"] = "You have already submitted this form.",
			["Duration"] = 3
		}
	},
	["RateLimits"] = {
		[v2.FetchFormData] = 1,
		[v2.SubmitFormData] = 5,
		[v2.FilterText] = 0.5
	},
	["Metadata"] = {
		["Username"] = "__username__",
		["UserId"] = "__userid__",
		["DisplayName"] = "__displayname__",
		["PlaceId"] = "__placeid__",
		["PlaceVersion"] = "__placeversion__",
		["ClientVersion"] = "__clientversion__",
		["Time"] = "__time__",
		["ElapsedTime"] = "__elapsedtime__",
		["GcInfo"] = "__gcinfo__",
		["ServerSize"] = "__serversize__"
	}
}
return v4