local function v_u_5(p1, p2) -- name: AwaitCondition
	local v3 = os.clock()
	local v4 = p2 or 10
	while not p1() do
		if v4 < os.clock() - v3 then
			return false
		end
		task.wait()
	end
	return true
end
return function()
	-- upvalues: (copy) v_u_5
	local v_u_6 = require(script.Parent)
	local v_u_7 = nil
	beforeEach(function()
		-- upvalues: (ref) v_u_7, (copy) v_u_6
		v_u_7 = v_u_6.new()
	end)
	afterEach(function()
		-- upvalues: (ref) v_u_7
		v_u_7:Destroy()
	end)
	describe("Constructor", function()
		-- upvalues: (copy) v_u_6, (ref) v_u_7, (ref) v_u_5
		it("should create a new signal and fire it", function()
			-- upvalues: (ref) v_u_6, (ref) v_u_7
			expect(v_u_6.Is(v_u_7)).to.equal(true)
			task.defer(function()
				-- upvalues: (ref) v_u_7
				v_u_7:Fire(10, 20)
			end)
			local v8, v9 = v_u_7:Wait()
			expect(v8).to.equal(10)
			expect(v9).to.equal(20)
		end)
		it("should create a proxy signal and connect to it", function()
			-- upvalues: (ref) v_u_6, (ref) v_u_5
			local v10 = v_u_6.Wrap(game:GetService("RunService").Heartbeat)
			expect(v_u_6.Is(v10)).to.equal(true)
			local v_u_11 = false
			v10:Connect(function()
				-- upvalues: (ref) v_u_11
				v_u_11 = true
			end)
			expect(v_u_5(function()
				-- upvalues: (ref) v_u_11
				return v_u_11
			end, 2)).to.equal(true)
			v10:Destroy()
		end)
	end)
	describe("FireDeferred", function()
		-- upvalues: (ref) v_u_7, (ref) v_u_5
		it("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_5
			local v_u_12 = nil
			v_u_7:Connect(function(p13)
				-- upvalues: (ref) v_u_12
				v_u_12 = p13
			end)
			v_u_7:FireDeferred(10)
			expect(v_u_5(function()
				-- upvalues: (ref) v_u_12
				return v_u_12 == 10
			end, 1)).to.equal(true)
		end)
		it("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_5
			local v_u_14 = { 10, 20 }
			local v_u_15 = nil
			v_u_7:Connect(function(p16)
				-- upvalues: (ref) v_u_15
				v_u_15 = p16
			end)
			v_u_7:FireDeferred(v_u_14)
			expect(v_u_5(function()
				-- upvalues: (copy) v_u_14, (ref) v_u_15
				return v_u_14 == v_u_15
			end, 1)).to.equal(true)
		end)
	end)
	describe("Fire", function()
		-- upvalues: (ref) v_u_7
		it("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u_7
			local v_u_17 = nil
			v_u_7:Connect(function(p18)
				-- upvalues: (ref) v_u_17
				v_u_17 = p18
			end)
			v_u_7:Fire(10)
			expect(v_u_17).to.equal(10)
		end)
		it("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u_7
			local v19 = { 10, 20 }
			local v_u_20 = nil
			v_u_7:Connect(function(p21)
				-- upvalues: (ref) v_u_20
				v_u_20 = p21
			end)
			v_u_7:Fire(v19)
			expect(v_u_20).to.equal(v19)
		end)
	end)
	describe("ConnectOnce", function()
		-- upvalues: (ref) v_u_7
		it("should only capture first fire", function()
			-- upvalues: (ref) v_u_7
			local v_u_22 = nil
			local v24 = v_u_7:ConnectOnce(function(p23)
				-- upvalues: (ref) v_u_22
				v_u_22 = p23
			end)
			expect(v24.Connected).to.equal(true)
			v_u_7:Fire(10)
			expect(v24.Connected).to.equal(false)
			v_u_7:Fire(20)
			expect(v_u_22).to.equal(10)
		end)
	end)
	describe("Wait", function()
		-- upvalues: (ref) v_u_7
		it("should be able to wait for a signal to fire", function()
			-- upvalues: (ref) v_u_7
			task.defer(function()
				-- upvalues: (ref) v_u_7
				v_u_7:Fire(10, 20, 30)
			end)
			local v25, v26, v27 = v_u_7:Wait()
			expect(v25).to.equal(10)
			expect(v26).to.equal(20)
			expect(v27).to.equal(30)
		end)
	end)
	describe("DisconnectAll", function()
		-- upvalues: (ref) v_u_7
		it("should disconnect all connections", function()
			-- upvalues: (ref) v_u_7
			v_u_7:Connect(function() end)
			v_u_7:Connect(function() end)
			expect(#(nil or v_u_7):GetConnections()).to.equal(2)
			v_u_7:DisconnectAll()
			expect(#(nil or v_u_7):GetConnections()).to.equal(0)
		end)
	end)
	describe("Disconnect", function()
		-- upvalues: (ref) v_u_7, (ref) v_u_5
		it("should disconnect connection", function()
			-- upvalues: (ref) v_u_7
			local v28 = v_u_7:Connect(function() end)
			expect(#(nil or v_u_7):GetConnections()).to.equal(1)
			v28:Disconnect()
			expect(#(nil or v_u_7):GetConnections()).to.equal(0)
		end)
		it("should still work if connections disconnected while firing", function()
			-- upvalues: (ref) v_u_7
			local v_u_29 = 0
			local v_u_30 = nil
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_29
				v_u_29 = v_u_29 + 1
			end)
			v_u_30 = v_u_7:Connect(function()
				-- upvalues: (ref) v_u_30, (ref) v_u_29
				v_u_30:Disconnect()
				v_u_29 = v_u_29 + 1
			end)
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_29
				v_u_29 = v_u_29 + 1
			end)
			v_u_7:Fire()
			expect(v_u_29).to.equal(3)
		end)
		it("should still work if connections disconnected while firing deferred", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_5
			local v_u_31 = 0
			local v_u_32 = nil
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_31
				v_u_31 = v_u_31 + 1
			end)
			v_u_32 = v_u_7:Connect(function()
				-- upvalues: (ref) v_u_32, (ref) v_u_31
				v_u_32:Disconnect()
				v_u_31 = v_u_31 + 1
			end)
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_31
				v_u_31 = v_u_31 + 1
			end)
			v_u_7:FireDeferred()
			expect(v_u_5(function()
				-- upvalues: (ref) v_u_31
				return v_u_31 == 3
			end)).to.equal(true)
		end)
	end)
end