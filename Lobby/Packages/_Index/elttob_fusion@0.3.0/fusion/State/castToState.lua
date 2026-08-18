local v1 = script.Parent.Parent
require(v1.Types)
return function(p2) -- name: castToState
	if typeof(p2) == "table" and p2.type == "State" then
		return p2
	else
		return nil
	end
end