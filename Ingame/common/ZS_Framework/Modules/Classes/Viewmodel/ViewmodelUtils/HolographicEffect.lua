local v_u_1 = Vector2.new(0.5, 0.5)
return {
	["UpdateReticle"] = function(p2, p3, p4) -- name: UpdateReticle
		-- upvalues: (copy) v_u_1
		local v5 = p2.CFrame
		local v6 = p4.Position
		local v7 = (v5 + v5.LookVector * 10000).Position
		local v8 = v5.LookVector
		local v9 = v8:Dot(p2.Position - v6) / v8:Dot(v7 - v6)
		local v10 = v5:toObjectSpace(CFrame.new(v6 + v9 * (v7 - v6)))
		local v11 = Vector2.new(v10.X / p2.Size.X + 0.5, 0.5 - v10.Y / p2.Size.Y)
		if p3.LenseIsCircular then
			p3.Reticle.Visible = (v11 - v_u_1).Magnitude < 0.5
		end
		p3.Reticle.Position = UDim2.new(v11.X, 0, v11.Y, 0)
	end,
	["UpdateShadow"] = function(p12, p13, p14) -- name: UpdateShadow
		local v15 = p12.CFrame * CFrame.new(-p12.Size.X * 0.5, 0, 0)
		local v16 = p12.CFrame * CFrame.new(p12.Size.X * 0.5, 0, 0)
		local v17 = p14.Position
		local v18 = v16.Position
		local v19 = p12.CFrame.RightVector
		local v20 = v19:Dot(v15.Position - v17) / v19:Dot(v18 - v17)
		local v21 = v15:toObjectSpace(CFrame.new(v17 + v20 * (v18 - v17)))
		local v22 = Vector2.new(-v21.Z / p12.Size.Z + 0.5, 0.5 + v21.Y / p12.Size.Y) * 1000
		local v23 = p13.ShadowRing.ImageRectSize.X * 0.5
		local v24 = p13.ShadowRing
		local v25 = Vector2.new
		local v26 = v22.X - v23
		local v27 = math.clamp(v26, -999, 999)
		local v28 = v22.Y - v23
		v24.ImageRectOffset = v25(v27, (math.clamp(v28, -999, 999)))
	end
}