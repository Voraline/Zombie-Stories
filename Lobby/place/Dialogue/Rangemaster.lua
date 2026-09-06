local function formatTime(p1) -- Line: 1
    local v1 = math.max(0, p1)
    local v2 = math.floor(v1 / 60)
    local v3 = math.floor(v1 % 60)
    local v4 = math.floor((v1 - math.floor(v1)) * 100)
    return string.format("%02d:%02d.%02d", v2, v3, v4)
end
local function choices() -- Line: 17
    return {
        {
            text = "What is my fastest time record?",
            action = {kind = "goto", node = "fastestTime"},
        },
        {
            text = "View my player stats",
            action = {kind = "goto", node = "playerStats"},
        },
        {
            text = "How does the shooting range work?",
            action = {kind = "goto", node = "rangeExplanation"},
        },
    }
end
return {
    id = "Rangemaster",
    speaker = "AAPELI",
    root = "root",
    interactRange = 9,
    leaveRange = 15,
    cancelAction = {kind = "goto", node = "farewell"},
    greetings = {
        "I wonder how he has been all this time…",
        "The range is open. Have fun.",
        "As you know, the range is open at these times. Use it wisely.",
        "Welcome to the range. Get your gear and start practicing.",
        "Train as much as you can, you will never know if you are prepared enough.",
        "Quick, bold and lethal precision is key to survival, operative.",
        "I would work on faster aiming today if I were you.",
        "You should probably train for precision today.",
        "You have been missing your shots. Work on precision today, and you can remedy that.",
        "You are too slow. You should train on faster aiming.",
        "You have been improving. Why not train to make your aim fast and precise today?",
        "A shotgun wielded by a blind chicken is effective, but in the hands of a precise operative, the Ferryman’s boat will overflow.",
        "A lever action may not be up to date, but it certainly holds its own. Not to mention, the girls will swoon at the sight of an operative who knows how to handle one with style.",
        "Assault rifles are very versatile, and it is important to train with one for any situation.",
        "If you are carrying too much weight, why not switch to a SMG? Generally lighter and more compact if you are looking for that.",
        "Why not use a battle rifle? I say the extra punch is worth it if you can handle the kick.",
        "Have some fun today. Use an LMG today. Hold down the trigger, and say… “make it rain”, yes?",
        "Train with a bolt-action today, yeah? Your aim and patience will be rewarded.",
        "A DMR is excellent if you find the right one. A nice in-between of battle rifles and sniper rifles.",
        "I do not know if you have one, but if you have an AMR, train with it today. It may be big and heavy, but you obliterate anything with lethal precision.",
        "I have been seeing Hunter train with Aria recently. She is not half bad.",
    },
    nodes = {
        root = {
            lines = {"The range is open. Have fun."},
            options = choices(),
        },
        fastestTime = {
            lines = {
                "Gimme a sec…",
                function(p1) -- Line: 9 -- upvalues: formatTime (val)
                    local currentRangeBestTime = p1.values.currentRangeBestTime
                    if type(currentRangeBestTime) ~= "number" then
                        return "Here we go. You have not set a time for this setup yet."
                    end
                    return string.format("Here we go. Your fastest time was %s.", formatTime(currentRangeBestTime))
                end,
            },
            options = choices(),
        },
        playerStats = {
            lines = {"Gimme a sec…", "Here it is."},
            completionAction = {kind = "invoke", handler = "OpenSelfProfile"},
        },
        rangeExplanation = {
            lines = {"Select top targets, bottom targets, or both, then choose how many you want.", "Use the range prompt to begin. Clear every target as quickly and precisely as you can, operative.", "Each setup keeps its own record. Do not mistake an easier drill for mastery."},
            options = choices(),
        },
        farewell = {
            lines = {"Do not slack on training."},
        },
    },
}