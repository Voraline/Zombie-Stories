return function(p1) -- Line: 1
    local SeatPart
    if not p1 then
        return false
    end
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        return false
    end
    if Humanoid.Sit then
        SeatPart = Humanoid.SeatPart
        local RootPart = Humanoid.RootPart
        if not RootPart then
            RootPart = p1:FindFirstChild("HumanoidRootPart")
        end
        Humanoid.Sit = false
        if SeatPart and SeatPart.Parent and RootPart then
            local SeatWeld = SeatPart:FindFirstChild("SeatWeld")
            if SeatWeld and SeatWeld:IsA("Weld") then
                if SeatWeld.Part0 == RootPart then
                    SeatWeld:Destroy()
                elseif SeatWeld.Part1 == RootPart then
                    SeatWeld:Destroy()
                end
            end
        end
        return true
    elseif Humanoid.SeatPart == nil then
        return false
    end
end