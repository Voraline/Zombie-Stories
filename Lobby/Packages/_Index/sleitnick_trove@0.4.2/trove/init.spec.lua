return function()
	local v_u_1 = require(script.Parent)
	describe("Trove", function()
		-- upvalues: (copy) v_u_1
		local v_u_2 = nil
		beforeEach(function()
			-- upvalues: (ref) v_u_2, (ref) v_u_1
			v_u_2 = v_u_1.new()
		end)
		afterEach(function()
			-- upvalues: (ref) v_u_2
			if v_u_2 then
				v_u_2:Destroy()
				v_u_2 = nil
			end
		end)
		it("should add and clean up roblox instance", function()
			-- upvalues: (ref) v_u_2
			local v3 = Instance.new("Part")
			v3.Parent = workspace
			v_u_2:Add(v3)
			v_u_2:Destroy()
			expect(v3.Parent).to.equal(nil)
		end)
		it("should add and clean up roblox connection", function()
			-- upvalues: (ref) v_u_2
			local v4 = workspace.Changed:Connect(function() end)
			v_u_2:Add(v4)
			v_u_2:Destroy()
			expect(v4.Connected).to.equal(false)
		end)
		it("should add and clean up a table with a destroy method", function()
			-- upvalues: (ref) v_u_2
			local v6 = {
				["Destroyed"] = false,
				["Destroy"] = function(p5) -- name: Destroy
					p5.Destroyed = true
				end
			}
			v_u_2:Add(v6)
			v_u_2:Destroy()
			expect(v6.Destroyed).to.equal(true)
		end)
		it("should add and clean up a table with a disconnect method", function()
			-- upvalues: (ref) v_u_2
			local v8 = {
				["Connected"] = true,
				["Disconnect"] = function(p7) -- name: Disconnect
					p7.Connected = false
				end
			}
			v_u_2:Add(v8)
			v_u_2:Destroy()
			expect(v8.Connected).to.equal(false)
		end)
		it("should add and clean up a function", function()
			-- upvalues: (ref) v_u_2
			local v_u_9 = false
			v_u_2:Add(function()
				-- upvalues: (ref) v_u_9
				v_u_9 = true
			end)
			v_u_2:Destroy()
			expect(v_u_9).to.equal(true)
		end)
		it("should allow a custom cleanup method", function()
			-- upvalues: (ref) v_u_2
			local v11 = {
				["Cleaned"] = false,
				["Cleanup"] = function(p10) -- name: Cleanup
					p10.Cleaned = true
				end
			}
			v_u_2:Add(v11, "Cleanup")
			v_u_2:Destroy()
			expect(v11.Cleaned).to.equal(true)
		end)
		it("should return the object passed to add", function()
			-- upvalues: (ref) v_u_2
			local v12 = Instance.new("Part")
			local v13 = v_u_2:Add(v12)
			expect(v12).to.equal(v13)
			v_u_2:Destroy()
		end)
		it("should fail to add object without proper cleanup method", function()
			-- upvalues: (ref) v_u_2
			local v_u_14 = {}
			expect(function()
				-- upvalues: (ref) v_u_2, (copy) v_u_14
				v_u_2:Add(v_u_14)
			end).to.throw()
		end)
		it("should construct an object and add it", function()
			-- upvalues: (ref) v_u_2
			local v_u_15 = {}
			v_u_15.__index = v_u_15
			function v_u_15.new(p16) -- name: new
				-- upvalues: (copy) v_u_15
				local v17 = v_u_15
				local v18 = setmetatable({}, v17)
				v18._msg = p16
				v18._destroyed = false
				return v18
			end
			function v_u_15.Destroy(p19) -- name: Destroy
				p19._destroyed = true
			end
			local v20 = v_u_2:Construct(v_u_15, "abc")
			expect((typeof(v20))).to.equal("table")
			expect((getmetatable(v20))).to.equal(v_u_15)
			expect(v20._msg).to.equal("abc")
			expect(v20._destroyed).to.equal(false)
			v_u_2:Destroy()
			expect(v20._destroyed).to.equal(true)
		end)
		it("should connect to a signal", function()
			-- upvalues: (ref) v_u_2
			local v21 = v_u_2:Connect(workspace.Changed, function() end)
			expect((typeof(v21))).to.equal("RBXScriptConnection")
			expect(v21.Connected).to.equal(true)
			v_u_2:Destroy()
			expect(v21.Connected).to.equal(false)
		end)
		it("should remove an object", function()
			-- upvalues: (ref) v_u_2
			local v22 = v_u_2:Connect(workspace.Changed, function() end)
			expect(v_u_2:Remove(v22)).to.equal(true)
			expect(v22.Connected).to.equal(false)
		end)
		it("should not remove an object not in the trove", function()
			-- upvalues: (ref) v_u_2
			local v23 = workspace.Changed:Connect(function() end)
			expect(v_u_2:Remove(v23)).to.equal(false)
			expect(v23.Connected).to.equal(true)
			v23:Disconnect()
		end)
		it("should attach to instance", function()
			-- upvalues: (ref) v_u_2
			local v24 = Instance.new("Part")
			v24.Parent = workspace
			local v25 = v_u_2:AttachToInstance(v24)
			expect(v25.Connected).to.equal(true)
			v24:Destroy()
			expect(v25.Connected).to.equal(false)
		end)
		it("should fail to attach to instance not in hierarchy", function()
			-- upvalues: (ref) v_u_2
			local v_u_26 = Instance.new("Part")
			expect(function()
				-- upvalues: (ref) v_u_2, (copy) v_u_26
				v_u_2:AttachToInstance(v_u_26)
			end).to.throw()
		end)
		it("should extend itself", function()
			-- upvalues: (ref) v_u_2, (ref) v_u_1
			local v27 = v_u_2:Extend()
			local v_u_28 = false
			v27:Add(function()
				-- upvalues: (ref) v_u_28
				v_u_28 = true
			end)
			expect(v27).to.be.a("table")
			expect((getmetatable(v27))).to.equal(v_u_1)
			v_u_2:Clean()
			expect(v_u_28).to.equal(true)
		end)
		it("should clone an instance", function()
			-- upvalues: (ref) v_u_2
			local v29 = v_u_2:Construct(Instance.new, "Part")
			v29.Name = "TroveCloneTest"
			local v30 = v_u_2:Clone(v29)
			expect((typeof(v30))).to.equal("Instance")
			expect(v30).to.never.equal(v29)
			expect(v30.Name).to.equal("TroveCloneTest")
			expect(v29.Name).to.equal(v30.Name)
		end)
		it("should clean up a thread", function()
			-- upvalues: (ref) v_u_2
			local v31 = coroutine.create(function() end)
			v_u_2:Add(v31)
			expect(coroutine.status(v31)).to.equal("suspended")
			v_u_2:Clean()
			expect(coroutine.status(v31)).to.equal("dead")
		end)
	end)
end