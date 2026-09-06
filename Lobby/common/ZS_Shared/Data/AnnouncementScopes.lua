local u0 = {}
local v1 = {"all", "lobby", "arcade", "story"}
u0.Names = v1
local u6 = {lobby = "Lobby", arcade = "Arcade", story = "Story"}
function u0.GetPlaceType() -- Line: 11
    local Attribute = workspace:GetAttribute("PlaceType")
    if type(Attribute) ~= "string" then
        if workspace:GetAttribute("IsArcade") then
            return "Arcade"
        end
        local Values = workspace:FindFirstChild("Values")
        local IsLobby = Values
        if IsLobby then
            IsLobby = Values:FindFirstChild("IsLobby")
        end
        if not IsLobby or not (IsLobby:IsA("BoolValue")) then
            return "Story"
        end
        if IsLobby.Value then
            return "Lobby"
        end
        return "Story"
    elseif Attribute ~= "" then
        return Attribute
    end
end
function u0.Matches(p1) -- Line: 30 -- upvalues: u6 (val), u0 (val)
    if p1 == nil or p1 == "all" then
        return true
    end
    local v1 = u6[p1]
    local v2 = if v1 ~= nil then u0.GetPlaceType() == v1 else false
    return v2
end
return u0