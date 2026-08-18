local v1 = script.Parent.Parent
require(v1.Types)
return function(p2) -- name: parseError
	return {
		["type"] = "Error",
		["raw"] = nil,
		["message"] = nil,
		["trace"] = nil,
		["raw"] = p2,
		["message"] = p2:gsub("^.+:%d+:%s*", ""),
		["trace"] = debug.traceback(nil, 2)
	}
end