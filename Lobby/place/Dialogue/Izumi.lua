return {
    id = "Izumi",
    speaker = "IZUMI",
    root = "root",
    interactRange = 9,
    leaveRange = 15,
    cancelAction = {kind = "goto", node = "farewell"},
    greetings = {
        "Looking for a challenge?",
        "A single challenge can’t be impossible to do, right?",
        "Heh, I knew it was you. So whaddya need?",
        "I was expecting you. Will it be a challenge today?",
        "I think you’re way better than you think you are. You should give a challenge a shot!",
        "C’mon, do a challenge! You’re way stronger than you think!",
        function(p1) -- Line: 1
            return string.format("Hiya, %s!", p1.player.DisplayName)
        end,
    },
    nodes = {
        root = {
            lines = {"Looking for a challenge?"},
            options = {
                {
                    text = "View Quests",
                    action = {kind = "goto", node = "quests"},
                },
            },
        },
        quests = {
            lines = {"Heh, I’ve got a good feeling about this…"},
            completionAction = {kind = "invoke", handler = "OpenQuests"},
        },
        farewell = {
            lines = {"May all the odds be stacked with you!"},
        },
    },
}