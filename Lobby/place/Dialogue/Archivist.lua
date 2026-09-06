return {
    id = "Archivist",
    speaker = "ARCHIVIST",
    root = "root",
    interactRange = 9,
    leaveRange = 15,
    cancelAction = {kind = "goto", node = "farewell"},
    greetings = {
        "Welcome back, operative. Knowledge does not gather itself.",
        "You have returned. I trust it is with purpose.",
        "There is always another report to study.",
        "The archive remembers what people prefer to forget.",
        "Mind the order of the shelves. Disorder is how facts disappear.",
        "A prepared operative reads before they deploy.",
        "Rumor is cheap. Records are considerably more useful.",
        "Every recovered document makes the picture a little less incomplete.",
        "Take your time. The dead are patient teachers.",
        "What have you come to learn today, operative?",
    },
    nodes = {
        root = {
            lines = {"Welcome back, operative."},
            options = {
                {
                    text = "View Unlocked Documents",
                    action = {kind = "goto", node = "documents"},
                },
            },
        },
        documents = {
            lines = {"Educate yourself well, operative."},
            completionAction = {kind = "invoke", handler = "OpenDocuments"},
        },
        farewell = {
            lines = {"Good luck out there, operative."},
        },
    },
}