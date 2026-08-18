local function v4(p1) -- name: createKillZombieQuest
	local v2 = {
		["Title"] = nil,
		["Description"] = nil,
		["Type"] = "KillZombie",
		["TitleFormatKeys"] = nil,
		["DescriptionFormatKeys"] = nil,
		["Props"] = nil,
		["Goal"] = nil,
		["Rewards"] = nil,
		["Title"] = p1.Title or "Kill %0d Zombies",
		["Description"] = p1.Description or "Shoot and kill zombies",
		["TitleFormatKeys"] = { "Goal" },
		["DescriptionFormatKeys"] = p1.DescriptionFormatKeys,
		["Props"] = p1.Props,
		["Goal"] = p1.Range
	}
	local v3 = {
		["ZBucks"] = {
			["Amount"] = 0.5 * (p1.RewardMultiplier or 1)
		}
	}
	v2.Rewards = v3
	return v2
end
local function v7(p5) -- name: createCompleteStoryQuest
	local v6 = p5.Props and p5.Props.Class == "RandomClass" and {
		["Type"] = "SelectedClass",
		["Amount"] = nil,
		["Amount"] = 500 * (p5.RewardMultiplier or 1)
	} or nil
	return {
		["Title"] = nil,
		["TitleFormatKeys"] = nil,
		["DescriptionFormatKeys"] = nil,
		["Description"] = nil,
		["Type"] = "CompleteStory",
		["Props"] = nil,
		["Goal"] = nil,
		["Rewards"] = nil,
		["Title"] = p5.Title or "Complete %0d Stories",
		["TitleFormatKeys"] = p5.TitleFormatKeys or { "Goal" },
		["DescriptionFormatKeys"] = p5.DescriptionFormatKeys,
		["Description"] = p5.Description or "Finish any story chapters on any difficulty",
		["Props"] = p5.Props,
		["Goal"] = p5.Range,
		["Rewards"] = {
			["ZBucks"] = {
				["Amount"] = 50 * (p5.RewardMultiplier or 1)
			},
			["ClassXP"] = v6
		}
	}
end
local v8 = {}
local v9 = {}
local v10 = {
	["Range"] = 1,
	["RewardMultiplier"] = 2.5,
	["Props"] = nil,
	["Title"] = "Complete a Story with the Selected Modifiers",
	["Description"] = "%s",
	["DescriptionFormatKeys"] = nil,
	["Props"] = {
		["Modifiers"] = {
			["Min"] = 1,
			["Max"] = 4
		}
	},
	["DescriptionFormatKeys"] = { "Modifiers" }
}
__set_list(v9, 1, {v4({
	["Range"] = nil,
	["RewardMultiplier"] = 1,
	["Range"] = {
		["Min"] = 250,
		["Max"] = 750
	}
}), v4({
	["Title"] = "Headshot %0d Zombies",
	["Description"] = "Kill zombies with headshots",
	["TitleFormatKeys"] = nil,
	["Range"] = nil,
	["RewardMultiplier"] = 1.25,
	["Props"] = nil,
	["TitleFormatKeys"] = { "Goal" },
	["Range"] = {
		["Min"] = 100,
		["Max"] = 200
	},
	["Props"] = {
		["Headshot"] = true
	}
}), v7({
	["Range"] = 1,
	["RewardMultiplier"] = 1.5,
	["Props"] = nil,
	["Description"] = "Complete any of the story chapters",
	["Title"] = "Complete Any of the %s Chapters",
	["TitleFormatKeys"] = nil,
	["Props"] = {
		["StoryName"] = "Random"
	},
	["TitleFormatKeys"] = { "StoryName" }
}), v7(v10), v7({
	["Range"] = nil,
	["RewardMultiplier"] = 1,
	["Range"] = {
		["Min"] = 1,
		["Max"] = 3
	}
}), (v7({
	["Range"] = nil,
	["RewardMultiplier"] = 2,
	["Props"] = nil,
	["Title"] = "Complete %0d Stories as %s Class",
	["TitleFormatKeys"] = nil,
	["Description"] = "Complete story chapters using a specific class",
	["Range"] = {
		["Min"] = 1,
		["Max"] = 2
	},
	["Props"] = {
		["Class"] = "RandomClass"
	},
	["TitleFormatKeys"] = { "Goal", "Class" }
}))})
v8.Daily = v9
local v11 = {}
local v12 = {
	["Range"] = 1,
	["RewardMultiplier"] = 2.5,
	["Props"] = nil,
	["Title"] = "Complete a Story with the Selected Modifiers",
	["Description"] = "%s",
	["DescriptionFormatKeys"] = nil,
	["Props"] = {
		["Modifiers"] = {
			["Min"] = 3,
			["Max"] = 5
		}
	},
	["DescriptionFormatKeys"] = { "Modifiers" }
}
__set_list(v11, 1, {v7({
	["Range"] = nil,
	["RewardMultiplier"] = 2,
	["Props"] = nil,
	["Title"] = "Complete %0d Stories as %s Class",
	["TitleFormatKeys"] = nil,
	["Description"] = "Complete story chapters using a specific class",
	["Range"] = {
		["Min"] = 4,
		["Max"] = 6
	},
	["Props"] = {
		["Class"] = "RandomClass"
	},
	["TitleFormatKeys"] = { "Goal", "Class" }
}), v7({
	["Range"] = nil,
	["RewardMultiplier"] = 1,
	["Range"] = {
		["Min"] = 5,
		["Max"] = 10
	}
}), v4({
	["Range"] = nil,
	["RewardMultiplier"] = 0.8,
	["Range"] = {
		["Min"] = 2000,
		["Max"] = 5000
	}
}), v4({
	["Title"] = "Headshot %0d Zombies",
	["Description"] = "Kill zombies with headshots",
	["TitleFormatKeys"] = nil,
	["Range"] = nil,
	["RewardMultiplier"] = 1.05,
	["Props"] = nil,
	["TitleFormatKeys"] = { "Goal" },
	["Range"] = {
		["Min"] = 500,
		["Max"] = 1000
	},
	["Props"] = {
		["Headshot"] = true
	}
}), (v7(v12))})
v8.Weekly = v11
local v13 = {}
local v14 = {
	["Title"] = "Complete %0d Stories with %0d Modifiers",
	["Description"] = "Complete story chapters with the required number of modifiers",
	["TitleFormatKeys"] = nil,
	["Props"] = nil,
	["RewardMultiplier"] = 1.25,
	["Range"] = nil,
	["TitleFormatKeys"] = { "Goal", "ModifierCount" },
	["Props"] = {
		["ModifierCount"] = {
			["Min"] = 1,
			["Max"] = 4
		}
	},
	["Range"] = {
		["Min"] = 2,
		["Max"] = 4
	}
}
__set_list(v13, 1, {v7({
	["Range"] = {
		["Min"] = 20,
		["Max"] = 40
	}
}), v7({
	["Range"] = nil,
	["RewardMultiplier"] = 2,
	["Props"] = nil,
	["Title"] = "Complete %0d Stories as %s Class",
	["TitleFormatKeys"] = nil,
	["Description"] = "Complete story chapters using a specific class",
	["Range"] = {
		["Min"] = 2,
		["Max"] = 4
	},
	["Props"] = {
		["Class"] = "Assault"
	},
	["TitleFormatKeys"] = { "Goal", "Class" }
}), v7({
	["Range"] = nil,
	["RewardMultiplier"] = 2,
	["Props"] = nil,
	["Title"] = "Complete %0d Stories as %s Class",
	["TitleFormatKeys"] = nil,
	["Description"] = "Complete story chapters using a specific class",
	["Range"] = {
		["Min"] = 2,
		["Max"] = 4
	},
	["Props"] = {
		["Class"] = "Sniper"
	},
	["TitleFormatKeys"] = { "Goal", "Class" }
}), v7({
	["Range"] = nil,
	["RewardMultiplier"] = 2,
	["Props"] = nil,
	["Title"] = "Complete %0d Stories as %s Class",
	["TitleFormatKeys"] = nil,
	["Description"] = "Complete story chapters using a specific class",
	["Range"] = {
		["Min"] = 2,
		["Max"] = 4
	},
	["Props"] = {
		["Class"] = "Medic"
	},
	["TitleFormatKeys"] = { "Goal", "Class" }
}), v7({
	["Range"] = nil,
	["RewardMultiplier"] = 2,
	["Props"] = nil,
	["Title"] = "Complete %0d Stories as %s Class",
	["TitleFormatKeys"] = nil,
	["Description"] = "Complete story chapters using a specific class",
	["Range"] = {
		["Min"] = 2,
		["Max"] = 4
	},
	["Props"] = {
		["Class"] = "Support"
	},
	["TitleFormatKeys"] = { "Goal", "Class" }
}), v4({
	["Range"] = nil,
	["RewardMultiplier"] = 0.6,
	["Range"] = {
		["Min"] = 10000,
		["Max"] = 20000
	}
}), v4({
	["Title"] = "Headshot %0d Zombies",
	["Description"] = "Kill zombies with headshots",
	["TitleFormatKeys"] = nil,
	["Range"] = nil,
	["RewardMultiplier"] = 0.85,
	["Props"] = nil,
	["TitleFormatKeys"] = { "Goal" },
	["Range"] = {
		["Min"] = 2500,
		["Max"] = 5000
	},
	["Props"] = {
		["Headshot"] = true
	}
}), (v7(v14))})
v8.Monthly = v13
return v8