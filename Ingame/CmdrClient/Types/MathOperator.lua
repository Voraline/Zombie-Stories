return function(p1)
	p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			["Name"] = "+",
			["Perform"] = nil,
			["Perform"] = function(p2, p3) -- name: Perform
				return p2 + p3
			end
		},
		{
			["Name"] = "-",
			["Perform"] = nil,
			["Perform"] = function(p4, p5) -- name: Perform
				return p4 - p5
			end
		},
		{
			["Name"] = "*",
			["Perform"] = nil,
			["Perform"] = function(p6, p7) -- name: Perform
				return p6 * p7
			end
		},
		{
			["Name"] = "/",
			["Perform"] = nil,
			["Perform"] = function(p8, p9) -- name: Perform
				return p8 / p9
			end
		},
		{
			["Name"] = "**",
			["Perform"] = nil,
			["Perform"] = function(p10, p11) -- name: Perform
				return p10 ^ p11
			end
		},
		{
			["Name"] = "%",
			["Perform"] = nil,
			["Perform"] = function(p12, p13) -- name: Perform
				return p12 % p13
			end
		}
	}))
end