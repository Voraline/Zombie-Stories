require("@self/PubTypes")
local v1 = {
    version = {major = 0, minor = 2, isRelease = true},
    New = require("@self/Instances/New"),
    Hydrate = require("@self/Instances/Hydrate"),
    Ref = require("@self/Instances/Ref"),
    Out = require("@self/Instances/Out"),
    Cleanup = require("@self/Instances/Cleanup"),
    Children = require("@self/Instances/Children"),
    OnEvent = require("@self/Instances/OnEvent"),
    OnChange = require("@self/Instances/OnChange"),
    Value = require("@self/State/Value"),
    Computed = require("@self/State/Computed"),
    ForPairs = require("@self/State/ForPairs"),
    ForKeys = require("@self/State/ForKeys"),
    ForValues = require("@self/State/ForValues"),
    Observer = require("@self/State/Observer"),
    Tween = require("@self/Animation/Tween"),
    Spring = require("@self/Animation/Spring"),
    cleanup = require("@self/Utility/cleanup"),
    doNothing = require("@self/Utility/doNothing"),
}
return (require("@self/Utility/restrictRead")("Fusion", v1))