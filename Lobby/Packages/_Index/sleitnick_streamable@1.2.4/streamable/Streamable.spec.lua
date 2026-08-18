return function()
	local v_u_1 = require(script.Parent.Streamable)
	local v_u_2 = nil
	local v_u_3 = nil
	beforeAll(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_3
		v_u_2 = Instance.new("Folder")
		v_u_2.Name = "KnitTestFolder"
		v_u_2.Archivable = false
		v_u_2.Parent = workspace
		v_u_3 = Instance.new("Model")
		v_u_3.Name = "KnitTestModel"
		v_u_3.Archivable = false
		v_u_3.Parent = workspace
	end)
	afterEach(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_3
		v_u_2:ClearAllChildren()
		v_u_3:ClearAllChildren()
	end)
	afterAll(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_3
		v_u_2:Destroy()
		v_u_3:Destroy()
	end)
	describe("Streamable", function()
		-- upvalues: (ref) v_u_2, (copy) v_u_1, (ref) v_u_3
		it("should detect instance that is immediately available", function()
			-- upvalues: (ref) v_u_2, (ref) v_u_1
			local v4 = Instance.new("Folder")
			v4.Name = "TestImmediate"
			v4.Archivable = false
			v4.Parent = v_u_2
			local v5 = v_u_1.new(v_u_2, "TestImmediate")
			local v_u_6 = 0
			local v_u_7 = 0
			v5:Observe(function(_, p8)
				-- upvalues: (ref) v_u_6, (ref) v_u_7
				v_u_6 = v_u_6 + 1
				p8:Add(function()
					-- upvalues: (ref) v_u_7
					v_u_7 = v_u_7 + 1
				end)
			end)
			task.wait()
			v4.Parent = nil
			task.wait()
			v4.Parent = v_u_2
			task.wait()
			v5:Destroy()
			task.wait()
			expect(v_u_6).to.equal(2)
			expect(v_u_7).to.equal(2)
		end)
		it("should detect instance that is not immediately available", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_2
			local v9 = v_u_1.new(v_u_2, "TestImmediate")
			local v_u_10 = 0
			local v_u_11 = 0
			v9:Observe(function(_, p12)
				-- upvalues: (ref) v_u_10, (ref) v_u_11
				v_u_10 = v_u_10 + 1
				p12:Add(function()
					-- upvalues: (ref) v_u_11
					v_u_11 = v_u_11 + 1
				end)
			end)
			task.wait(0.1)
			local v13 = Instance.new("Folder")
			v13.Name = "TestImmediate"
			v13.Archivable = false
			v13.Parent = v_u_2
			task.wait()
			v13.Parent = nil
			task.wait()
			v13.Parent = v_u_2
			task.wait()
			v9:Destroy()
			task.wait()
			expect(v_u_10).to.equal(2)
			expect(v_u_11).to.equal(2)
		end)
		it("should detect primary part that is immediately available", function()
			-- upvalues: (ref) v_u_3, (ref) v_u_1
			local v14 = Instance.new("Part")
			v14.Anchored = true
			v14.Parent = v_u_3
			v_u_3.PrimaryPart = v14
			local v15 = v_u_1.primary(v_u_3)
			local v_u_16 = 0
			local v_u_17 = 0
			v15:Observe(function(_, p18)
				-- upvalues: (ref) v_u_16, (ref) v_u_17
				v_u_16 = v_u_16 + 1
				p18:Add(function()
					-- upvalues: (ref) v_u_17
					v_u_17 = v_u_17 + 1
				end)
			end)
			task.wait()
			v14.Parent = nil
			task.wait()
			v14.Parent = v_u_3
			v_u_3.PrimaryPart = v14
			task.wait()
			v15:Destroy()
			task.wait()
			expect(v_u_16).to.equal(2)
			expect(v_u_17).to.equal(2)
		end)
		it("should detect primary part that is not immediately available", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_3
			local v19 = v_u_1.primary(v_u_3)
			local v_u_20 = 0
			local v_u_21 = 0
			v19:Observe(function(_, p22)
				-- upvalues: (ref) v_u_20, (ref) v_u_21
				v_u_20 = v_u_20 + 1
				p22:Add(function()
					-- upvalues: (ref) v_u_21
					v_u_21 = v_u_21 + 1
				end)
			end)
			task.wait(0.1)
			local v23 = Instance.new("Part")
			v23.Anchored = true
			v23.Parent = v_u_3
			v_u_3.PrimaryPart = v23
			task.wait()
			v23.Parent = nil
			task.wait()
			v23.Parent = v_u_3
			v_u_3.PrimaryPart = v23
			task.wait()
			v19:Destroy()
			task.wait()
			expect(v_u_20).to.equal(2)
			expect(v_u_21).to.equal(2)
		end)
	end)
end