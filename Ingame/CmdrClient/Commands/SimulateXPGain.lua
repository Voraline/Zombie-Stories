return {
    Name = "simulatexpgain",
    Description = "Simulates an XP gain to test the skill XP popup",
    Group = "Debug",
    Aliases = {"simxp"},
    Args = {
        {Type = "integer", Name = "amount", Description = "Amount of SP XP to simulate (default: 10)", Optional = true},
    },
}