local u2 = require("../Shared/Util")
return function(p1) -- Line: 3 -- upvalues: u2 (val)
    p1:RegisterType("heatmapMetric", u2.MakeEnumType("HeatmapMetric", {"samples", "visitors", "dwell"}))
    p1:RegisterType("heatmapLayer", u2.MakeEnumType("HeatmapLayer", {"move", "seat", "both"}))
    p1:RegisterType("heatmapPathColor", u2.MakeEnumType("HeatmapPathColor", {"route", "flat", "density"}))
end