local u2 = require("../Shared/Util")
local u214 = u2.MakeFuzzyFinder({
    "White",
    "Grey",
    "Light yellow",
    "Brick yellow",
    "Light green (Mint)",
    "Light reddish violet",
    "Pastel Blue",
    "Light orange brown",
    "Nougat",
    "Bright red",
    "Med. reddish violet",
    "Bright blue",
    "Bright yellow",
    "Earth orange",
    "Black",
    "Dark grey",
    "Dark green",
    "Medium green",
    "Lig. Yellowich orange",
    "Bright green",
    "Dark orange",
    "Light bluish violet",
    "Transparent",
    "Tr. Red",
    "Tr. Lg blue",
    "Tr. Blue",
    "Tr. Yellow",
    "Light blue",
    "Tr. Flu. Reddish orange",
    "Tr. Green",
    "Tr. Flu. Green",
    "Phosph. White",
    "Light red",
    "Medium red",
    "Medium blue",
    "Light grey",
    "Bright violet",
    "Br. yellowish orange",
    "Bright orange",
    "Bright bluish green",
    "Earth yellow",
    "Bright bluish violet",
    "Tr. Brown",
    "Medium bluish violet",
    "Tr. Medi. reddish violet",
    "Med. yellowish green",
    "Med. bluish green",
    "Light bluish green",
    "Br. yellowish green",
    "Lig. yellowish green",
    "Med. yellowish orange",
    "Br. reddish orange",
    "Bright reddish violet",
    "Light orange",
    "Tr. Bright bluish violet",
    "Gold",
    "Dark nougat",
    "Silver",
    "Neon orange",
    "Neon green",
    "Sand blue",
    "Sand violet",
    "Medium orange",
    "Sand yellow",
    "Earth blue",
    "Earth green",
    "Tr. Flu. Blue",
    "Sand blue metallic",
    "Sand violet metallic",
    "Sand yellow metallic",
    "Dark grey metallic",
    "Black metallic",
    "Light grey metallic",
    "Sand green",
    "Sand red",
    "Dark red",
    "Tr. Flu. Yellow",
    "Tr. Flu. Red",
    "Gun metallic",
    "Red flip/flop",
    "Yellow flip/flop",
    "Silver flip/flop",
    "Curry",
    "Fire Yellow",
    "Flame yellowish orange",
    "Reddish brown",
    "Flame reddish orange",
    "Medium stone grey",
    "Royal blue",
    "Dark Royal blue",
    "Bright reddish lilac",
    "Dark stone grey",
    "Lemon metalic",
    "Light stone grey",
    "Dark Curry",
    "Faded green",
    "Turquoise",
    "Light Royal blue",
    "Medium Royal blue",
    "Rust",
    "Brown",
    "Reddish lilac",
    "Lilac",
    "Light lilac",
    "Bright purple",
    "Light purple",
    "Light pink",
    "Light brick yellow",
    "Warm yellowish orange",
    "Cool yellow",
    "Dove blue",
    "Medium lilac",
    "Slime green",
    "Smoky grey",
    "Dark blue",
    "Parsley green",
    "Steel blue",
    "Storm blue",
    "Lapis",
    "Dark indigo",
    "Sea green",
    "Shamrock",
    "Fossil",
    "Mulberry",
    "Forest green",
    "Cadet blue",
    "Electric blue",
    "Eggplant",
    "Moss",
    "Artichoke",
    "Sage green",
    "Ghost grey",
    "Lilac",
    "Plum",
    "Olivine",
    "Laurel green",
    "Quill grey",
    "Crimson",
    "Mint",
    "Baby blue",
    "Carnation pink",
    "Persimmon",
    "Maroon",
    "Gold",
    "Daisy orange",
    "Pearl",
    "Fog",
    "Salmon",
    "Terra Cotta",
    "Cocoa",
    "Wheat",
    "Buttermilk",
    "Mauve",
    "Sunrise",
    "Tawny",
    "Rust",
    "Cashmere",
    "Khaki",
    "Lily white",
    "Seashell",
    "Burgundy",
    "Cork",
    "Burlap",
    "Beige",
    "Oyster",
    "Pine Cone",
    "Fawn brown",
    "Hurricane grey",
    "Cloudy grey",
    "Linen",
    "Copper",
    "Dirt brown",
    "Bronze",
    "Flint",
    "Dark taupe",
    "Burnt Sienna",
    "Institutional white",
    "Mid gray",
    "Really black",
    "Really red",
    "Deep orange",
    "Alder",
    "Dusty Rose",
    "Olive",
    "New Yeller",
    "Really blue",
    "Navy blue",
    "Deep blue",
    "Cyan",
    "CGA brown",
    "Magenta",
    "Pink",
    "Deep orange",
    "Teal",
    "Toothpaste",
    "Lime green",
    "Camo",
    "Grime",
    "Lavender",
    "Pastel light blue",
    "Pastel orange",
    "Pastel violet",
    "Pastel blue-green",
    "Pastel green",
    "Pastel yellow",
    "Pastel brown",
    "Royal purple",
    "Hot pink",
})
local u215 = {Prefixes = "% teamColor"}

function u215.Transform(p1) -- Line: 40 -- upvalues: u214 (val)
    local v1 = {}
    for k, v in pairs(u214(p1)) do
        v1[k] = (BrickColor.new(v))
    end
    return v1
end

function u215.Validate(p1) -- Line: 48
    local v1 = 0 < #p1
    return v1, "No valid brick colors with that name could be found."
end

function u215.Autocomplete(p1) -- Line: 52 -- upvalues: u2 (val)
    return u2.GetNames(p1)
end

function u215.Parse(p1) -- Line: 56
    return p1[1]
end

local u220 = {}
u220.Transform = u215.Transform
u220.Validate = u215.Validate
u220.Autocomplete = u215.Autocomplete

function u220.Parse(p1) -- Line: 66
    return p1[1].Color
end

return function(p1) -- Line: 71 -- upvalues: u215 (val), u2 (val), u220 (val)
    local v1 = u215
    p1:RegisterType("brickColor", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u215
    v1 = MakeListableType(v2, {Prefixes = "% teamColors"})
    p1:RegisterType("brickColors", v1)
    v1 = u220
    p1:RegisterType("brickColor3", v1)
    v1 = u2
    local MakeListableType_2 = v1.MakeListableType
    v2 = u220
    v1 = MakeListableType_2(v2)
    p1:RegisterType("brickColor3s", v1)
end