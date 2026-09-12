local u3 = Vector2.new(0.5, 0.5)
return {
    UpdateReticle = function(p1, p2, p3) -- Line: 5 -- upvalues: u3 (val)
        local CFrame_2 = p1.CFrame
        local Position = p3.Position
        local Position_2 = (CFrame_2 + CFrame_2.LookVector * 10000).Position
        local LookVector = CFrame_2.LookVector
        local v1 = p1.Position - Position
        local v2 = LookVector:Dot(v1)
        local v3 = Position_2 - Position
        local v4 = v2 / (LookVector:Dot(v3))
        local new = CFrame.new
        v3 = Position + v4 * (Position_2 - Position)
        v1 = new(v3)
        v2 = CFrame_2:toObjectSpace(v1)
        local v5 = Vector2.new(v2.X / p1.Size.X + 0.5, 0.5 - v2.Y / p1.Size.Y)
        if p2.LenseIsCircular then
            local Reticle = p2.Reticle
            v3 = (v5 - u3).Magnitude < 0.5
            Reticle.Visible = v3
        end
        p2.Reticle.Position = UDim2.new(v5.X, 0, v5.Y, 0)
    end,
    UpdateShadow = function(p1, p2, p3) -- Line: 18
        local v1 = p1.CFrame * CFrame.new(-p1.Size.X * 0.5, 0, 0)
        local v2 = p1.CFrame * CFrame.new(p1.Size.X * 0.5, 0, 0)
        local Position = p3.Position
        local Position_2 = v2.Position
        local RightVector = p1.CFrame.RightVector
        local v3 = v1.Position - Position
        local v4 = RightVector:Dot(v3)
        local v5 = Position_2 - Position
        local v6 = v4 / (RightVector:Dot(v5))
        v3 = CFrame.new(Position + v6 * (Position_2 - Position))
        v4 = v1:toObjectSpace(v3)
        local v7 = Vector2.new(-v4.Z / p1.Size.Z + 0.5, 0.5 + v4.Y / p1.Size.Y) * 1000
        v5 = p2.ShadowRing.ImageRectSize.X * 0.5
        local ShadowRing = p2.ShadowRing
        local new_5 = Vector2.new
        local v8 = v7.X - v5
        local v9 = math.clamp(v8, -999, 999)
        local v10 = v7.Y - v5
        ShadowRing.ImageRectOffset = new_5(v9, (math.clamp(v10, -999, 999)))
    end,
}