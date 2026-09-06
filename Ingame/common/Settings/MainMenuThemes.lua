local v1 = require("@game/ReplicatedStorage/common/ZS_Framework/UI/MarauderLoading/Config")
local v2 = {Ambience = 16}
local v3 = {}
v3[16] = {Label = "AMBIENCE (DEFAULT)", Order = 0, SoundId = v1.MenuAmbienceSoundId}
v3[1] = {Label = "Arseniy Shkljaev - NIKKIT", SoundId = "rbxassetid://5950831255", Order = 1}
v3[2] = {
    Label = "BSlick - ORIGINAL (Variation 1)",
    SoundId = "rbxassetid://4119004062",
    Order = 2,
    Reverb = true,
    PlaybackSpeed = 0.95,
}
v3[3] = {Label = "BSlick - ORIGINAL (Variation 2)", SoundId = "rbxassetid://4119004062", Order = 3}
v3[4] = {Label = "Eva Weiss - CHRISTMAS", SoundId = "rbxassetid://6117713164", Order = 4}
v3[5] = {Label = "Eva Weiss - HALLOWEEN", SoundId = "rbxassetid://5900055652", Order = 5}
v3[6] = {Label = "BSlick - A51 GOOD ENDING", SoundId = "rbxassetid://1520745071", Order = 6}
v3[7] = {Label = "Airhead Music - COLLIDE", SoundId = "rbxassetid://1599645254", Order = 7}
v3[8] = {Label = "Unknown - OLD SHOP", SoundId = "rbxassetid://5158476619", Order = 8}
v3[9] = {Label = "Arseniy Shkljaev - NIKKIT 2020", SoundId = "rbxassetid://9377956614", Order = 9}
v3[10] = {Label = "Nightforce - ASSAULT", SoundId = "rbxassetid://1836873988", Order = 10}
v3[11] = {Label = "\"Expedite\"", SoundId = "rbxassetid://101688810445644", Order = 11}
v2.Options = v3
return v2