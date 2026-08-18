return {
	["onActivate"] = nil,
	["OnHit"] = function(p1, p2, _, _, _) -- name: OnHit
		if p1.onActivate then
			p1.onActivate(p2)
		end
	end
}