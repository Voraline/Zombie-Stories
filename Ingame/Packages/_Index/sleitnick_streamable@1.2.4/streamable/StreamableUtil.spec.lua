return function()
	local v_u_1 = require(script.Parent.Streamable)
	local v_u_2 = require(script.Parent.StreamableUtil)
	local v_u_3 = nil
	beforeAll(function()
		-- upvalues: (ref) v_u_3
		v_u_3 = Instance.new("Folder")
		v_u_3.Name = "KnitTest"
		v_u_3.Archivable = false
		v_u_3.Parent = workspace
	end)
	afterEach(function()
		-- upvalues: (ref) v_u_3
		v_u_3:ClearAllChildren()
	end)
	afterAll(function()
		-- upvalues: (ref) v_u_3
		v_u_3:Destroy()
	end)
	describe("Compound", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_3, (copy) v_u_2
		it("should capture multiple streams", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_3, (ref) v_u_2
			local v4 = v_u_1.new(v_u_3, "ABC")
			local v5 = v_u_1.new(v_u_3, "XYZ")
			local v_u_6 = 0
			local v_u_7 = 0
			v_u_2.Compound({
				["S1"] = v4,
				["S2"] = v5
			}, function(_, p8)
				-- upvalues: (ref) v_u_6, (ref) v_u_7
				v_u_6 = v_u_6 + 1
				p8:Add(function()
					-- upvalues: (ref) v_u_7
					v_u_7 = v_u_7 + 1
				end)
			end)
			local v9 = Instance.new("Folder")
			v9.Name = "ABC"
			v9.Archivable = false
			v9.Parent = v_u_3
			local v10 = Instance.new("Folder")
			v10.Name = "XYZ"
			v10.Archivable = false
			v10.Parent = v_u_3
			task.wait()
			v9.Parent = nil
			task.wait()
			v9.Parent = v_u_3
			task.wait()
			v9.Parent = nil
			v10.Parent = nil
			task.wait()
			v10.Parent = v_u_3
			task.wait()
			expect(v_u_6).to.equal(2)
			expect(v_u_7).to.equal(2)
			v4:Destroy()
			v5:Destroy()
		end)
	end)
end