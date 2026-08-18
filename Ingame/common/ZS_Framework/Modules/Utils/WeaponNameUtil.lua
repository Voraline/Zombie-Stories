return {
	["GetDisplayName"] = function(p1, p2) -- name: GetDisplayName
		if not p2 then
			return p1
		end
		if p2.CustomName then
			return p2.CustomName
		end
		if p2.Prefix then
			p1 = p2.Prefix .. p1
		end
		if p2.Suffix then
			p1 = p1 .. p2.Suffix
		end
		return p1
	end
}