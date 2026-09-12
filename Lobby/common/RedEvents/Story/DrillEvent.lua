local Red = require(game.ReplicatedStorage.Packages.Red)
local u6 = {Enable = true, UpdateState = true, Disable = true}
local u7 = {Broken = true, Fixed = true}
return Red.SharedEvent("Drill", function(p1) -- Line: 14 -- upvalues: u6 (val), u7 (val)
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if not u6[action] then
        return nil
    end
    if action == "Disable" then
        return {action = action}
    end
    local state = p1.state
    if typeof(state) == "string" and u7[state] then
        return {action = action, state = state}
    end
    return nil
end)