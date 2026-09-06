local u3 = Vector2.new(0.5, 0.5)
return {
    UpdateReticle = function(p1, p2, p3) -- Line: 5 -- upvalues: u3 (val)
        local CFrame = p1.CFrame
        local Position = p3.Position
        local Position_2 = (CFrame + CFrame.LookVector * 10000).Position
        local LookVector = CFrame.LookVector
        local v1 = LookVector:Dot(p1.Position - Position)
        v1 = CFrame:toObjectSpace(CFrame.new(Position + v1 / LookVector:Dot(Position_2 - Position) * (Position_2 - Position)))
        local v2 = Vector2.new(v1.X / p1.Size.X + 0.5, 0.5 - v1.Y / p1.Size.Y)
        if p2.LenseIsCircular then
            local v3 = (v2 - u3).Magnitude < 0.5
            p2.Reticle.Visible = v3
        end
        p2.Reticle.Position = UDim2.new(v2.X, 0, v2.Y, 0)
    end,
    UpdateShadow = function(p1, p2, p3) -- Line: 18
        local v1 = p1.CFrame * CFrame.new(-p1.Size.X * 0.5, 0, 0)
        local v2 = p1.CFrame * CFrame.new(p1.Size.X * 0.5, 0, 0)
        local Position = p3.Position
        local Position_2 = v2.Position
        local RightVector = p1.CFrame.RightVector
        local v3 = RightVector:Dot(v1.Position - Position)
        v3 = v1:toObjectSpace(CFrame.new(Position + v3 / RightVector:Dot(Position_2 - Position) * (Position_2 - Position)))
        local v4 = Vector2.new(-v3.Z / p1.Size.Z + 0.5, 0.5 + v3.Y / p1.Size.Y) * 1000
        local v5 = p2.ShadowRing.ImageRectSize.X * 0.5
        local v6 = math.clamp(v4.X - v5, -999, 999)
        local v7 = v4.Y - v5
        p2.ShadowRing.ImageRectOffset = Vector2.new(v6, (math.clamp(v7, -999, 999)))
    end,
}