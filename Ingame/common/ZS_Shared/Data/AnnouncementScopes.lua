local u0 = {
    Names = {"all", "lobby", "arcade", "story"},
}
local u6 = {lobby = "Lobby", arcade = "Arcade", story = "Story"}

function u0.GetPlaceType() -- Line: 11
    local Attribute = workspace:GetAttribute("PlaceType")
    if type(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    if workspace:GetAttribute("IsArcade") then
        return "Arcade"
    end
    local Values = workspace:FindFirstChild("Values")
    local IsLobby = Values
    if IsLobby then
        IsLobby = Values:FindFirstChild("IsLobby")
    end
    if IsLobby and IsLobby:IsA("BoolValue") and IsLobby.Value then
        return "Lobby"
    end
    return "Story"
end

function u0.Matches(p1) -- Line: 30 -- upvalues: u6 (val), u0 (val)
    if p1 ~= nil and p1 ~= "all" then
        local v1 = u6[p1]
        local v2 = false
        if v1 ~= nil then
            v2 = u0.GetPlaceType() == v1
        end
        return v2
    end
    return true
end

return u0