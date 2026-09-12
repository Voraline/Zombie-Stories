return {
    id = "ArchivistIntro",
    speaker = "???",
    root = "root",
    interactRange = 9,
    leaveRange = 15,
    nodes = {
        root = {
            speaker = "???",
            lines = {
                "Another operative wandering where they were not directed.",
                "No matter. Curiosity is useful, when it is tempered with discretion.",
                "The reports kept here are not decorations. Each one was paid for in blood, time, or both.",
                "If you intend to survive, you would do well to learn from them.",
            },
            completionAction = {kind = "goto", node = "introduction"},
        },
        introduction = {
            speaker = "ARCHIVIST",
            lines = {
                "Anyways, it's a good thing you're here…",
                "I am Osiris. Most aboard the ship simply call me the Archivist.",
                "I preserve what our operatives discover, and I make it available when they have earned the right to see it.",
            },
            completionAction = {kind = "goto", node = "offer"},
        },
        offer = {
            speaker = "ARCHIVIST",
            noCancel = true,
            lines = {"Would you like to view the documents you have unlocked?"},
            options = {
                {
                    text = "Yes.",
                    style = "positive",
                    action = {kind = "goto", node = "viewNow"},
                },
                {
                    text = "No.",
                    style = "cancel",
                    action = {kind = "goto", node = "farewellFirst"},
                },
            },
        },
        viewNow = {
            speaker = "ARCHIVIST",
            lines = {"Very well, then."},
            completionAction = {kind = "invoke", handler = "OpenDocuments"},
        },
        farewellFirst = {
            speaker = "ARCHIVIST",
            lines = {"If that's all, then I will see you another time. Welcome to the Odysseus."},
        },
    },
}