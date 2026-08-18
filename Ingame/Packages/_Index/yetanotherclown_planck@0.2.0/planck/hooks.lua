return {
	["Hooks"] = {
		["SystemAdd"] = "SystemAdd",
		["SystemRemove"] = "SystemRemove",
		["SystemReplace"] = "SystemReplace",
		["SystemError"] = "SystemError",
		["OuterSystemCall"] = "OuterSystemCall",
		["InnerSystemCall"] = "InnerSystemCall",
		["SystemCall"] = "SystemCall",
		["PhaseAdd"] = "PhaseAdd",
		["PhaseBegan"] = "PhaseBegan"
	},
	["systemAdd"] = function(p1, p2) -- name: systemAdd
		local v3 = {
			["scheduler"] = p1,
			["system"] = p2
		}
		for _, v4 in p1._hooks[p1.Hooks.SystemAdd] do
			local v5, v6 = pcall(v4, v3)
			if not v5 then
				warn("Unexpected error in hook:", v6)
			end
		end
	end,
	["systemRemove"] = function(p7, p8) -- name: systemRemove
		local v9 = {
			["scheduler"] = p7,
			["system"] = p8
		}
		for _, v10 in p7._hooks[p7.Hooks.SystemRemove] do
			local v11, v12 = pcall(v10, v9)
			if not v11 then
				warn("Unexpected error in hook:", v12)
			end
		end
	end,
	["systemReplace"] = function(p13, p14, p15) -- name: systemReplace
		local v16 = {
			["scheduler"] = p13,
			["new"] = p15,
			["old"] = p14
		}
		for _, v17 in p13._hooks[p13.Hooks.SystemReplace] do
			local v18, v19 = pcall(v17, v16)
			if not v18 then
				warn("Unexpected error in hook:", v19)
			end
		end
	end,
	["systemCall"] = function(p20, p21, p22, p23) -- name: systemCall
		local v24 = p20._hooks[p20.Hooks[p21]]
		if v24 then
			for _, v25 in v24 do
				p23 = v25({
					["scheduler"] = nil,
					["system"] = nil,
					["nextFn"] = nil,
					["system"] = p22,
					["nextFn"] = p23
				})
				if not p23 then
					local v26, v27 = debug.info(v25, "sl")
					warn((("%*:%*: Expected \'SystemCall\' hook to return a function"):format(v26, v27)))
				end
			end
		end
		p23()
	end,
	["systemError"] = function(p28, p29, p30) -- name: systemError
		local v31 = p28._hooks[p28.Hooks.SystemError]
		if v31 then
			for _, v32 in v31 do
				v32({
					["scheduler"] = p28,
					["system"] = p29,
					["error"] = p30
				})
			end
		end
	end,
	["phaseAdd"] = function(p33, p34) -- name: phaseAdd
		local v35 = {
			["scheduler"] = p33,
			["phase"] = p34
		}
		for _, v36 in p33._hooks[p33.Hooks.PhaseAdd] do
			local v37, v38 = pcall(v36, v35)
			if not v37 then
				warn("Unexpected error in hook:", v38)
			end
		end
	end,
	["phaseBegan"] = function(p39, p40) -- name: phaseBegan
		local v41 = {
			["scheduler"] = p39,
			["phase"] = p40
		}
		for _, v42 in p39._hooks[p39.Hooks.PhaseBegan] do
			local v43, v44 = pcall(v42, v41)
			if not v43 then
				warn("Unexpected error in hook:", v44)
			end
		end
	end
}