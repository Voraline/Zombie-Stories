local v1 = {
    {
        text = "View Store",
        action = {kind = "goto", node = "store"},
    },
    {
        text = "View Market",
        action = {kind = "goto", node = "market"},
    },
}
return {
    id = "Quartermaster",
    speaker = "QUARTERMASTER",
    root = "root",
    resumeNode = "welcomeBack",
    interactRange = 9,
    leaveRange = 15,
    cancelAction = {kind = "goto", node = "farewell"},
    greetings = {
        "Welcome to my office.",
        "Welcome back.",
        "Heya. Looking for weapons?",
        "Whaddya need?",
        "The artist never blames their tools. Most of the time.",
        "Interested in buying?",
        "Today’s shipments are good. Get a crate and see for yourself.",
        "Check out the market. Good stuff here today.",
        "Why not browse the market today? Could be something there ya like.",
        "Weapons here, weapons there, weapons everywhere…",
        "My assistant’s impressed with your performance. Keep it up.",
        "We’ve got too much stock in the house. Buy some, it frees up room for better stuff.",
        "If you see the Rangemaster around, tell him about a shipment today.",
        "Five-second rule? Ridiculous…",
        "Most weapons will be effective if you know how to use them properly, so don’t discard something you don’t like. Try it out, learn something new.",
        "Pay attention to your gear. It’s just as important as your weapons.",
        "Keep Izumi away from the market.",
        "I wonder what Moore is up to…",
        "You know anyone good at IT? My assistant would appreciate it, considering she and I wasted 2 days on a software problem on the work PC.",
        "You should exercise with me and Aria sometime. She’s been improving a lot recently.",
        "I’m surprised Aria can keep up with me with my plate carrier on. She’s got more endurance than I thought.",
        "Why does Izumi even bother with the market..? Her inventory’s fine…",
        "Have you seen the Archivist outside his office? I’ve only seen him leave once or twice.",
        "Hmm, should I wear a different gas mask..? Maybe a shark instead…",
        "This morning, my NVGs nearly broke and I almost had a heart attack. That would’ve been over 40 grand down the drain.",
        "X equals negative B plus or minus the square root of B squared minus four times A times C, all of which is divided by 2 times A.",
        "Some operator here keeps complaining about your skins. If you see ‘em, don’t mind them.",
    },
    nodes = {
        root = {
            lines = {"Welcome to my office."},
            options = v1,
        },
        welcomeBack = {
            lines = {"Anything else?"},
            options = v1,
        },
        store = {
            lines = {"Take a look."},
            completionAction = {kind = "invoke", handler = "OpenShop"},
        },
        market = {
            lines = {"Alrighty."},
            completionAction = {kind = "invoke", handler = "OpenMarket"},
        },
        farewell = {
            lines = {"Happy hunting."},
        },
    },
}