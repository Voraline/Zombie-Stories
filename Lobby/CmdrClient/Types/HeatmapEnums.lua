local u2 = require("../Shared/Util")
return function(p1) -- Line: 3 -- upvalues: u2 (val)
    local v1 = u2
    v1 = v1.MakeEnumType("HeatmapMetric", {"samples", "visitors", "dwell"})
    p1:RegisterType("heatmapMetric", v1)
    v1 = u2
    v1 = v1.MakeEnumType("HeatmapLayer", {"move", "seat", "both"})
    p1:RegisterType("heatmapLayer", v1)
    v1 = u2
    v1 = v1.MakeEnumType("HeatmapPathColor", {"route", "flat", "density"})
    p1:RegisterType("heatmapPathColor", v1)
end