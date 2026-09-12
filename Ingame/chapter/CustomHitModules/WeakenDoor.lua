local u0 = {Done = false}

function u0.ValidWeapon(p1, p2) -- Line: 4
    local v1 = p2.WeaponName == "Hammer"
    return v1
end

function u0.CustomHit(p1, p2, p3, p4, p5, p6) -- Line: 8 -- upvalues: u0 (val)
    if u0.Done == false then
        local Door = game.ReplicatedStorage.common.Remotes:FindFirstChild("Door")
        if Door then
            if not workspace.Part_2:FindFirstChild("Gate1") then
                task.delay(10, function() -- Line: 19 -- upvalues: u0 (upval)
                    if not workspace.Part_2:FindFirstChild("Gate1") then
                        u0.Done = true
                    end
                end)
            elseif u0:ValidWeapon(p2) and Door then
                local Gate1 = workspace.Part_2.Gate1
                if p3:IsDescendantOf(Gate1) then
                    Door:FireServer()
                    return true
                end
            end
        end
    end
end

return u0