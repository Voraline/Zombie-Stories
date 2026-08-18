local v1 = game.GameId == 1970013852
local v2 = {
	["ZB:O"] = {
		["Name"] = "Zombie Blitz: Origins",
		["Thumb"] = "rbxassetid://5134945995",
		["Chapters"] = nil,
		["Descripton"] = "Terror strikes as an alien species invades Earth, introducing a zombie-like virus, transforming those infected to aliens...",
		["Position"] = 1,
		["Chapters"] = {
			{
				["Name"] = "2 Days Later",
				["AssetId"] = nil,
				["UsesFuture"] = false,
				["Difficulties"] = nil,
				["Descripton"] = "A myserious space craft crashes into a forest. As the researchers at Blitz Research Inc. uncover its mysterious, they\'ll soon realize horror it entails...",
				["AssetId"] = v1 and 9633210318 or 6995659334,
				["Difficulties"] = {
					["Easy"] = true,
					["Medium"] = true,
					["Hard"] = true,
					["Nightmare"] = true
				}
			},
			{
				["Name"] = "Underground",
				["AssetId"] = nil,
				["UsesFuture"] = false,
				["Difficulties"] = nil,
				["Descripton"] = "A near death accident causes the survivors to find another way out of the facility.",
				["Thumb"] = "rbxassetid://13491339859",
				["AssetId"] = v1 and 9633225283 or 7013106563,
				["Difficulties"] = {
					["Easy"] = true,
					["Medium"] = true,
					["Hard"] = true
				}
			}
		}
	}
}
local v3 = {
	["Name"] = "Extraction",
	["Thumb"] = "rbxassetid://18556394595",
	["Chapters"] = nil,
	["Descripton"] = "Extract unknown Subject OPV MRM from classified Base Hawk and uncover the mysterious of your boss...",
	["Position"] = 2,
	["Chapters"] = {
		{
			["Name"] = "Base Hawk",
			["AssetId"] = nil,
			["UsesFuture"] = true,
			["Difficulties"] = nil,
			["Descripton"] = "Meet up with Nick\'s squad and locate Base Hawk.",
			["AssetId"] = v1 and 9633256558 or 7004292095,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Findings",
			["AssetId"] = nil,
			["UsesFuture"] = true,
			["Difficulties"] = nil,
			["Descripton"] = "Dive into the hidden secrets of Base Hawk. Discover the reality.",
			["Thumb"] = "rbxassetid://13491336479",
			["AssetId"] = v1 and 9633263781 or 7013298441,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "No More",
			["AssetId"] = nil,
			["UsesFuture"] = true,
			["Difficulties"] = nil,
			["Descripton"] = "In Base Hawk\'s prison, Boss has captured you and reveals his plan involving OPV MRM. You gain insight into Boss\'s motives and operations.",
			["Thumb"] = "rbxassetid://13297064904",
			["AssetId"] = v1 and 12845024657 or 13557808501,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Verboten Grounds",
			["AssetId"] = nil,
			["UsesFuture"] = true,
			["Difficulties"] = nil,
			["Descripton"] = "Your last face-off with Boss takes place in the heavily fortified Verboten Grounds surrounding Base Hawk. Navigate through intense security measures and hostile forces to confront Boss one final time and put an end to his nefarious plans.",
			["Thumb"] = "rbxassetid://71420230245201",
			["AssetId"] = v1 and 102198025184405 or 117577555981416,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		}
	}
}
v2.EXT = v3
v2.LGCY = {
	["Name"] = "Legacy Stories",
	["Thumb"] = "rbxassetid://5173103216",
	["Chapters"] = nil,
	["Descripton"] = "Play three (CH1 & CH2 temporarily removed) old missions that were previously available from the alpha builds!",
	["Position"] = 3,
	["Disabled"] = false,
	["Chapters"] = {
		{
			["Name"] = "Contamination",
			["AssetId"] = nil,
			["UsesFuture"] = false,
			["Difficulties"] = nil,
			["Descripton"] = "Inside the Genetical Research Insitution, the water supply becomes contaminated, infecting those who drink it.\nMade by CoderQwerty",
			["Thumb"] = "rbxassetid://3578594348",
			["Disabled"] = false,
			["AssetId"] = v1 and 9633272299 or 6564341943,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Lab Breach",
			["AssetId"] = nil,
			["UsesFuture"] = false,
			["Difficulties"] = nil,
			["Descripton"] = "A classified facility becomes a target of an alien species.",
			["Thumb"] = "rbxassetid://5806250961",
			["Disabled"] = true,
			["AssetId"] = v1 and 9633301117 or 6986689616,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Area 51",
			["AssetId"] = nil,
			["UsesFuture"] = false,
			["Difficulties"] = nil,
			["Descripton"] = "A task force must secure Area 51 after being raided by a noob and his clones.",
			["Thumb"] = "rbxassetid://3564785088",
			["Disabled"] = false,
			["AssetId"] = v1 and 9633306974 or 6995409138,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		}
	}
}
local v4 = {
	["Name"] = "Dead Ahead",
	["Thumb"] = "rbxassetid://9718183987",
	["Chapters"] = nil,
	["Descripton"] = "Go dead ahead!",
	["Position"] = 2,
	["Chapters"] = {
		{
			["Name"] = "Pimila Laboratories",
			["AssetId"] = nil,
			["UsesFuture"] = false,
			["Difficulties"] = nil,
			["Descripton"] = "Unaware of what happened in the Pimila Laboratories, you went on to rescue survivors, and find out what happened.",
			["AssetId"] = v1 and 9377579903 or 9809970281,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		}
	}
}
v2.DEAH = v4
v2.OBLVN = {
	["Name"] = "Oblivion",
	["Thumb"] = "rbxassetid://86088304238668",
	["Chapters"] = nil,
	["Descripton"] = "Explore a unique chapter with a randomly generated map on each playthrough.",
	["Position"] = 7,
	["Chapters"] = {
		{
			["Name"] = "Sublevel Corridors",
			["AssetId"] = nil,
			["UsesFuture"] = true,
			["Difficulties"] = nil,
			["Descripton"] = "A covert experiment that spiraled out of control. Sealed off decades ago, rumored to be ground zero of the infection",
			["AssetId"] = v1 and 133243921096706 or 93216590442021,
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		}
	}
}
local v5 = {
	["Name"] = "Misc Stories",
	["Thumb"] = "rbxassetid://124141218516206",
	["Chapters"] = nil,
	["Descripton"] = "Misc stories for various events.",
	["Position"] = 4
}
local v6 = {}
local v7 = {
	["Name"] = "20 Floors",
	["AssetId"] = nil,
	["UsesFuture"] = false,
	["Difficulties"] = nil,
	["Descripton"] = "Reach the top of the tower.\nMade by Nooooooo",
	["Thumb"] = "rbxassetid://5899895057",
	["AssetId"] = v1 and 9633314511 or 7037790867,
	["Difficulties"] = {
		["Easy"] = true,
		["Medium"] = true,
		["Hard"] = true
	}
}
local v8 = {
	["Name"] = "Wild Holiday",
	["AssetId"] = nil,
	["UsesFuture"] = true,
	["Difficulties"] = nil,
	["Descripton"] = "After evacuating from the SS BUILD, the survivors find themselves in a mysterious village.",
	["Thumb"] = "rbxassetid://8357828922",
	["AssetId"] = v1 and 9633322069 or 8145465526,
	["Difficulties"] = {
		["Easy"] = true,
		["Medium"] = true,
		["Hard"] = true
	}
}
local v9 = {
	["Name"] = "Changed",
	["AssetId"] = nil,
	["UsesFuture"] = false,
	["Difficulties"] = nil,
	["Descripton"] = "You return back to Area 51 years after it has been long abandoned, but something seems to have been... changed",
	["Thumb"] = "rbxassetid://12388579735",
	["Disabled"] = true
}
local v10 = 12246520050
v9.AssetId = v10
v9.Difficulties = {
	["Easy"] = true,
	["Medium"] = true,
	["Hard"] = true
}
__set_list(v6, 1, {v7, v8, v9, {
	["Name"] = "No Mercy",
	["AssetId"] = nil,
	["UsesFuture"] = true,
	["Difficulties"] = nil,
	["Descripton"] = "Survive waves of zombies in your last chance to escape Mercy Hospital.",
	["Thumb"] = "rbxassetid://124141218516206",
	["Disabled"] = false,
	["AssetId"] = v1 and 126226618771714 or 128314396968815,
	["Difficulties"] = {
		["Easy"] = true,
		["Medium"] = true,
		["Hard"] = true
	}
}})
v5.Chapters = v6
v2.ZTWR = v5
v2.SCN = {
	["Name"] = "Scenarios",
	["Thumb"] = "",
	["Chapters"] = nil,
	["Descripton"] = "Speed through contamination in a special filled map!",
	["Position"] = 6,
	["Chapters"] = {
		{
			["Name"] = "Special Rush",
			["SoloOnly"] = true,
			["AssetId"] = 7080595667,
			["Difficulties"] = nil,
			["Descripton"] = "Speed through contamination in a special filled map! Solo only. Playing non-solo will result in no rewards.",
			["Thumb"] = "rbxassetid://7251362519",
			["Difficulties"] = {
				["Easy"] = false,
				["Medium"] = false,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Live Event",
			["AssetId"] = 7107528696,
			["Difficulties"] = nil,
			["Descripton"] = "Replay the live event that occured from in 2020, with an extended story. Includes a filler driving section.",
			["Thumb"] = "rbxassetid://7250513557",
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Boat House",
			["AssetId"] = 7131611495,
			["Difficulties"] = nil,
			["Descripton"] = "A classic horde survival mode.",
			["Thumb"] = "rbxassetid://7250514157",
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Last Juggernaut",
			["AssetId"] = 7146614074,
			["Difficulties"] = nil,
			["Descripton"] = "Climb Zombie Tower. A single player player in the team must carry the everyone to victory.",
			["Thumb"] = "rbxassetid://7250537979",
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Base Hawk Samurai",
			["UsesFuture"] = true,
			["AssetId"] = 7146880955,
			["Difficulties"] = nil,
			["Descripton"] = "Play PART 1 of this \'What if?\' scenario. This story follows samurais and their journey to Base Hawk.",
			["Thumb"] = "rbxassetid://7251159829",
			["Difficulties"] = {
				["Easy"] = false,
				["Medium"] = false,
				["Hard"] = true
			}
		},
		{
			["Name"] = "Scalpel Slaughter",
			["AssetId"] = 7156222122,
			["Difficulties"] = nil,
			["Descripton"] = "What if the armory of ZB:O had been ransacked? Find out in this melee only scenario.",
			["Thumb"] = "rbxassetid://7257213792",
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		},
		{
			["Name"] = "ODST Mission",
			["AssetId"] = 7157000359,
			["Difficulties"] = nil,
			["Descripton"] = "Play as Orbital Drop Shock Troopers from the Halo ODST series on their mission to take back Area 51.",
			["Thumb"] = "rbxassetid://7250513426",
			["Difficulties"] = {
				["Easy"] = true,
				["Medium"] = true,
				["Hard"] = true
			}
		}
	}
}
return v2