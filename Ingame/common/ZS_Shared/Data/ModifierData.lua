local v1 = {
	["TripleZombies"] = {
		["Name"] = "Triple Zombies",
		["Description"] = "Three times as many zombies spawn!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0,
		["XPMultiplier"] = 0,
		["Grouping"] = "ZombieAmount",
		["StatText"] = "+200%",
		["VariableAdditions"] = {
			["ZombieSpawnRate"] = 2
		}
	},
	["DoubleZombies"] = {
		["Name"] = "Double Zombies",
		["Description"] = "Twice as many zombies spawn!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0,
		["XPMultiplier"] = 0,
		["Grouping"] = "ZombieAmount",
		["StatText"] = "+100%",
		["VariableAdditions"] = {
			["ZombieSpawnRate"] = 1
		}
	},
	["ExtraZombies"] = {
		["Name"] = "Extra Zombies",
		["Description"] = "50% more zombies spawn!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0,
		["XPMultiplier"] = 0,
		["Grouping"] = "ZombieAmount",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["ZombieSpawnRate"] = 0.5
		}
	},
	["FewerZombies"] = {
		["Name"] = "Fewer Zombies",
		["Description"] = "50% fewer zombies spawn!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.3,
		["XPMultiplier"] = -0.3,
		["Grouping"] = "ZombieAmount",
		["StatText"] = "-50%",
		["VariableAdditions"] = {
			["ZombieSpawnRate"] = -0.5
		}
	},
	["HeadshotOnly"] = {
		["Name"] = "Headshot Only",
		["Description"] = "Zombies can only take damage from headshots!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.06,
		["Grouping"] = "LimbCriteria",
		["VariableSets"] = {
			["HeadshotOnly"] = true
		}
	},
	["FastZombies"] = {
		["Name"] = "Fast Zombies",
		["Description"] = "Zombies move faster!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.08,
		["XPMultiplier"] = 0.05,
		["Grouping"] = "ZombieSpeed",
		["StatText"] = "+25%",
		["VariableAdditions"] = {
			["ZombieSpeed"] = 0.25
		}
	},
	["UsainBoltZombies"] = {
		["Name"] = "Usain Bolt Zombies",
		["Description"] = "Actually... these zombies are even faster than Usain Bolt!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.12,
		["XPMultiplier"] = 0.08,
		["Grouping"] = "ZombieSpeed",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["ZombieSpeed"] = 0.5
		}
	},
	["SlowZombies"] = {
		["Name"] = "Slow Zombies",
		["Description"] = "Zombies move slower!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.2,
		["XPMultiplier"] = -0.2,
		["Grouping"] = "ZombieSpeed",
		["StatText"] = "-25%",
		["VariableAdditions"] = {
			["ZombieSpeed"] = -0.25
		}
	},
	["FragileZombies"] = {
		["Name"] = "Fragile Zombies",
		["Description"] = "Zombies have less health!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.2,
		["XPMultiplier"] = -0.2,
		["Grouping"] = "ZombieHealth",
		["StatText"] = "-50%",
		["VariableAdditions"] = {
			["ZombieHealth"] = -0.5
		}
	},
	["TankyZombies"] = {
		["Name"] = "Tanky Zombies",
		["Description"] = "Zombies have more health!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.06,
		["XPMultiplier"] = 0.06,
		["Grouping"] = "ZombieHealth",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["ZombieHealth"] = 0.5
		}
	},
	["BulletSpongeZombies"] = {
		["Name"] = "Bullet Sponge Zombies",
		["Description"] = "Zombies have A LOT more health!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.12,
		["XPMultiplier"] = 0.12,
		["Grouping"] = "ZombieHealth",
		["StatText"] = "+100%",
		["VariableAdditions"] = {
			["ZombieHealth"] = 1
		}
	},
	["OneDown"] = {
		["Name"] = "One Down",
		["Description"] = "Players can only be downed once!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.08,
		["Grouping"] = "PlayerDowns",
		["StatText"] = "1",
		["VariableSets"] = {
			["PlayerDowns"] = 1
		}
	},
	["NoDowns"] = {
		["Name"] = "No Downs",
		["Description"] = "Players die on first down!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.2,
		["XPMultiplier"] = 0.12,
		["Grouping"] = "PlayerDowns",
		["StatText"] = "0",
		["VariableSets"] = {
			["PlayerDowns"] = 0
		}
	},
	["TakeMoreDamage"] = {
		["Name"] = "Take More Damage",
		["Description"] = "Players take more damage!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.08,
		["XPMultiplier"] = 0.08,
		["Grouping"] = "PlayerDamageTaken",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["PlayerDamageTaken"] = 0.5
		}
	},
	["Take250Damage"] = {
		["Name"] = "Take 2.5x Damage",
		["Description"] = "Players take even more damage!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.1,
		["Grouping"] = "PlayerDamageTaken",
		["StatText"] = "+150%",
		["VariableAdditions"] = {
			["PlayerDamageTaken"] = 1.5
		}
	},
	["Take5xDamage"] = {
		["Name"] = "Take Quintuple Damage",
		["Description"] = "Players take a lot of damage!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.14,
		["XPMultiplier"] = 0.14,
		["Grouping"] = "PlayerDamageTaken",
		["StatText"] = "+400%",
		["VariableAdditions"] = {
			["PlayerDamageTaken"] = 4
		}
	},
	["EverythingOneShots"] = {
		["Name"] = "Everything One-Shots",
		["Description"] = "Players die in one hit!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.2,
		["XPMultiplier"] = 0.2,
		["Grouping"] = "PlayerDamageTaken",
		["VariableSets"] = {
			["PlayerDamageTaken"] = 1000
		}
	},
	["ExplodingZombies"] = {
		["Name"] = "Exploding Zombies",
		["Description"] = "Zombies explode on death, dealing damage to nearby players!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.08,
		["XPMultiplier"] = 0.08,
		["Grouping"] = "ZombiesExplodeOnDeath",
		["VariableSets"] = {
			["ZombiesExplodeOnDeath"] = true
		}
	},
	["ExplodingZombiesDoMoreDamage"] = {
		["Name"] = "Higher Exploding Zombie Damage",
		["Description"] = "Exploding zombies deal more damage when they explode!",
		["VariableAdditions"] = nil,
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.1,
		["Grouping"] = "ZombiesExplodeOnDeath",
		["StatText"] = "+100%",
		["VariableAdditions"] = {
			["ZombieExplodeDamage"] = 1
		},
		["VariableSets"] = {
			["ZombiesExplodeOnDeath"] = true
		}
	},
	["ExplodingZombiesDoLessDamage"] = {
		["Name"] = "Lower Exploding Zombie Damage",
		["Description"] = "Exploding zombies deal less damage when they explode!",
		["VariableAdditions"] = nil,
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.02,
		["XPMultiplier"] = 0.02,
		["Grouping"] = "ZombiesExplodeOnDeath",
		["StatText"] = "-50%",
		["VariableAdditions"] = {
			["ZombieExplodeDamage"] = -0.5
		},
		["VariableSets"] = {
			["ZombiesExplodeOnDeath"] = true
		}
	},
	["PlayersRunFaster"] = {
		["Name"] = "Players Run Faster",
		["Description"] = "Players move faster!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.25,
		["XPMultiplier"] = -0.25,
		["Grouping"] = "PlayerSpeed",
		["StatText"] = "+25%",
		["VariableAdditions"] = {
			["PlayerSpeed"] = 0.25
		}
	},
	["SnailMovement"] = {
		["Name"] = "Snail Movement",
		["Description"] = "Yeah... you\'re slower than a snail.",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.1,
		["Grouping"] = "PlayerSpeed",
		["StatText"] = "-50%",
		["VariableAdditions"] = {
			["PlayerSpeed"] = -0.5
		}
	},
	["PlayersRunSlower"] = {
		["Name"] = "Players Run Slower",
		["Description"] = "Players move slower!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.04,
		["XPMultiplier"] = 0.04,
		["Grouping"] = "PlayerSpeed",
		["StatText"] = "-25%",
		["VariableAdditions"] = {
			["PlayerSpeed"] = -0.25
		}
	},
	["SonicMovement"] = {
		["Name"] = "Sonic Movement",
		["Description"] = "GOTTA GO FAST!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.5,
		["XPMultiplier"] = -0.5,
		["Grouping"] = "PlayerSpeed",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["PlayerSpeed"] = 0.5
		}
	},
	["Wallhacks"] = {
		["Name"] = "Wallhacks",
		["Description"] = "Players can see zombies through walls!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = -0.15,
		["XPMultiplier"] = -0.15,
		["Grouping"] = "Wallhacks",
		["VariableSets"] = {
			["WallhackEnabled"] = true
		}
	},
	["MotionSickness"] = {
		["Name"] = "Motion Sickness",
		["Description"] = "Distorts the camera. NOT RECOMMENDED!!!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.02,
		["XPMultiplier"] = 0.02,
		["Grouping"] = "MotionSickness",
		["VariableSets"] = {
			["MotionSicknessEnabled"] = true
		}
	},
	["FastGuns"] = {
		["Name"] = "Fast Guns",
		["Description"] = "Guns fire faster!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.15,
		["XPMultiplier"] = -0.15,
		["Grouping"] = "FireRate",
		["StatText"] = "+25%",
		["VariableAdditions"] = {
			["FireRate"] = 0.25
		}
	},
	["GunsBlazing"] = {
		["Name"] = "Guns Blazing",
		["Description"] = "Guns fire even faster!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.25,
		["XPMultiplier"] = -0.25,
		["Grouping"] = "FireRate",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["FireRate"] = 0.5
		}
	},
	["SlowGuns"] = {
		["Name"] = "Slow Guns",
		["Description"] = "Guns fire slower!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.08,
		["XPMultiplier"] = 0.08,
		["Grouping"] = "FireRate",
		["StatText"] = "-25%",
		["VariableAdditions"] = {
			["FireRate"] = -0.25
		}
	},
	["ThisThingIsBroken"] = {
		["Name"] = "This Thing is Broken",
		["Description"] = "Your gun is broken! It fires at half the speed!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.12,
		["XPMultiplier"] = 0.12,
		["Grouping"] = "FireRate",
		["StatText"] = "-50%",
		["VariableAdditions"] = {
			["FireRate"] = -0.5
		}
	},
	["NoAbility"] = {
		["Name"] = "No Ability",
		["Description"] = "Players do not receive an ability at the start of the game!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.02,
		["XPMultiplier"] = 0.02,
		["Grouping"] = "AbilityLimiter",
		["VariableSets"] = {
			["GiveAbility"] = false
		}
	},
	["NoPrimary"] = {
		["Name"] = "No Primary",
		["Description"] = "Players do not receive a primary weapon at the start of the game!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.1,
		["Grouping"] = "LoadoutLimiter",
		["Icon"] = "rbxassetid://102723332973076",
		["VariableSets"] = {
			["GivePrimary"] = false
		}
	},
	["SecondaryOnly"] = {
		["Name"] = "Secondary Only",
		["Description"] = "Players only receive a secondary weapon at the start of the game!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.15,
		["XPMultiplier"] = 0.15,
		["Grouping"] = "LoadoutLimiter",
		["Icon"] = "rbxassetid://98201345973225",
		["VariableSets"] = {
			["GivePrimary"] = false,
			["GiveMelee"] = false
		}
	},
	["MeleeOnly"] = {
		["Name"] = "Melee Only",
		["Description"] = "Players only receive a melee weapon at the start of the game!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.25,
		["XPMultiplier"] = 0.25,
		["Grouping"] = "LoadoutLimiter",
		["Icon"] = "rbxassetid://102325922180328",
		["VariableSets"] = {
			["GiveSecondary"] = false,
			["GivePrimary"] = false
		}
	},
	["ScionsOfVexary"] = {
		["Name"] = "Scions of Vexary",
		["Description"] = "Players receive a loadout consisting of [GODSBANE] Pattern Weapons.",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = -0.95,
		["XPMultiplier"] = -0.95,
		["Grouping"] = "LoadoutLimiter",
		["Icon"] = "rbxassetid://87606366340369",
		["VariableSets"] = {
			["ForcePrimary"] = "1311",
			["ForceSecondary"] = "2147",
			["ForceMelee"] = "3065"
		}
	},
	["TheProfessional"] = {
		["Name"] = "The Professional",
		["Description"] = "Players receive a full suite of top-end precision weaponry served alongside a melee fit for dining. ",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = -0.95,
		["XPMultiplier"] = -0.95,
		["Grouping"] = "LoadoutLimiter",
		["Icon"] = "rbxassetid://95052035149656",
		["VariableSets"] = {
			["ForcePrimary"] = "1315",
			["ForceSecondary"] = "2137",
			["ForceMelee"] = "3105"
		}
	},
	["HalfBlind"] = {
		["Name"] = "Half Blind",
		["Description"] = "You\'re half blind!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.02,
		["XPMultiplier"] = 0.02,
		["Grouping"] = "Blindness",
		["VariableSets"] = {
			["HalfBlindEnabled"] = true
		}
	},
	["NoSliding"] = {
		["Name"] = "No Sliding",
		["Description"] = "Players cannot slide!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.07,
		["XPMultiplier"] = 0.07,
		["Grouping"] = "Sliding",
		["VariableSets"] = {
			["SlidingEnabled"] = false
		}
	},
	["StoneColdKiller"] = {
		["Name"] = "Stone Cold Killer",
		["Description"] = "Lower spread when firing weapons",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.15,
		["XPMultiplier"] = -0.15,
		["Grouping"] = "WeaponSpread",
		["StatText"] = "-66%",
		["VariableAdditions"] = {
			["WeaponSpread"] = -0.66
		}
	},
	["BadShot"] = {
		["Name"] = "Bad Shot",
		["Description"] = "Increased spread when firing weapons, you can\'t hit anything.",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.06,
		["XPMultiplier"] = 0.06,
		["Grouping"] = "WeaponSpread",
		["StatText"] = "+66%",
		["VariableAdditions"] = {
			["WeaponSpread"] = 0.66
		}
	},
	["QuickAttackZombies"] = {
		["Name"] = "Quick Attack Zombies",
		["Description"] = "Zombies attack faster!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.05,
		["XPMultiplier"] = 0.05,
		["Grouping"] = "ZombieAttackSpeed",
		["StatText"] = "+50%",
		["VariableAdditions"] = {
			["ZombieAttackSpeed"] = 0.5
		}
	},
	["SuperQuickAttackZombies"] = {
		["Name"] = "Super Quick Attack Zombies",
		["Description"] = "Zombies attack even faster!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.1,
		["XPMultiplier"] = 0.1,
		["Grouping"] = "ZombieAttackSpeed",
		["StatText"] = "+100%",
		["VariableAdditions"] = {
			["ZombieAttackSpeed"] = 1
		}
	},
	["SlowAttackZombies"] = {
		["Name"] = "Slow Attack Zombies",
		["Description"] = "Zombies attack slower!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.2,
		["XPMultiplier"] = -0.2,
		["Grouping"] = "ZombieAttackSpeed",
		["StatText"] = "-33%",
		["VariableAdditions"] = {
			["ZombieAttackSpeed"] = -0.33
		}
	},
	["SuperSlowAttackZombies"] = {
		["Name"] = "Super Slow Attack Zombies",
		["Description"] = "Zombies attack even slower!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.35,
		["XPMultiplier"] = -0.35,
		["Grouping"] = "ZombieAttackSpeed",
		["StatText"] = "-66%",
		["VariableAdditions"] = {
			["ZombieAttackSpeed"] = -0.66
		}
	},
	["AggressiveZombies"] = {
		["Name"] = "Aggressive Zombies",
		["Description"] = "Zombies are more aggressive and attack more often!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = 0.05,
		["XPMultiplier"] = 0.05,
		["Grouping"] = "ZombieAttackDelay",
		["StatText"] = "+50%",
		["Icon"] = "rbxassetid://120135373283166",
		["VariableAdditions"] = {
			["ZombieAttackDelay"] = -0.5
		}
	},
	["CalmZombies"] = {
		["Name"] = "Calm Zombies",
		["Description"] = "Zombies are less aggressive and attack less often!",
		["VariableAdditions"] = nil,
		["ZBucksMultiplier"] = -0.15,
		["XPMultiplier"] = -0.15,
		["Grouping"] = "ZombieAttackDelay",
		["StatText"] = "-50%",
		["Icon"] = "rbxassetid://136862200238963",
		["VariableAdditions"] = {
			["ZombieAttackDelay"] = 0.5
		}
	},
	["BreakdancingZombies"] = {
		["Name"] = "Breakdancing Zombies",
		["Description"] = "Zombies breakdance!",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.02,
		["XPMultiplier"] = 0.02,
		["Grouping"] = "ZombieTroll",
		["Icon"] = "rbxassetid://75021494334374",
		["VariableSets"] = {
			["BreakdancingZombiesEnabled"] = true
		}
	},
	["PartyMode"] = {
		["Name"] = "Party Mode",
		["Description"] = "ITS A PARTY! [EPILEPSY WARNING]",
		["VariableSets"] = nil,
		["ZBucksMultiplier"] = 0.01,
		["XPMultiplier"] = 0.01,
		["Grouping"] = "PartyMode",
		["Icon"] = "rbxassetid://83482859539402",
		["VariableSets"] = {
			["PartyModeEnabled"] = true,
			["DefaultMusicEnabled"] = false
		}
	}
}
return v1