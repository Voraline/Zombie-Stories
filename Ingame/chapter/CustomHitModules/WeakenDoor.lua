local u0 = {
    Done = false,
    ValidWeapon = function(p1, p2) -- Line: 4
        local v1 = p2.WeaponName == "Hammer"
        return v1
    end,
}
function u0.CustomHit(p1, p2, p3, p4, p5, p6) -- Line: 8 -- upvalues: u0 (val)
    if u0.Done ~= false then
        return
    end
    local Door = game.ReplicatedStorage.common.Remotes:FindFirstChild("Door")
    if not Door then
        return
    end
    if not (workspace.Part_2:FindFirstChild("Gate1")) then
        task.delay(10, function() -- Line: 19 -- upvalues: u0 (upval)
            if not (workspace.Part_2:FindFirstChild("Gate1")) then
                u0.Done = true
            end
        end)
        return
    end
    if not (u0:ValidWeapon(p2)) or not Door or not (p3:IsDescendantOf(workspace.Part_2.Gate1)) then
        return
    end
    Door:FireServer()
    return true
end
return u0