return {
    AmmoUpdated = function(p1, p2, p3) -- Line: 16
        local KeyParts = p2:FindFirstChild("KeyParts")
        if KeyParts then
            local AmmoCounter = KeyParts:FindFirstChild("AmmoCounter")
            if AmmoCounter then
                local TextLabel = AmmoCounter:FindFirstChild("TextLabel", true)
                if TextLabel then
                    TextLabel.Text = tostring(p1.Ammo)
                end
            end
        end
    end,
}