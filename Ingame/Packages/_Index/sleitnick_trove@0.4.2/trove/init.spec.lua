return function() -- Line: 1
    local Parent = require(script.Parent)
    describe("Trove", function() -- Line: 4 -- upvalues: Parent (val)
        local u0 = nil
        beforeEach(function() -- Line: 7 -- upvalues: u0 (ref), Parent (upval)
            u0 = Parent.new()
        end)
        afterEach(function() -- Line: 11 -- upvalues: u0 (ref)
            if u0 then
                u0:Destroy()
                u0 = nil
            end
        end)
        it("should add and clean up roblox instance", function() -- Line: 18 -- upvalues: u0 (ref)
            local Part = Instance.new("Part")
            Part.Parent = workspace
            u0:Add(Part)
            u0:Destroy()
            expect(Part.Parent).to.equal(nil)
        end)
        it("should add and clean up roblox connection", function() -- Line: 26 -- upvalues: u0 (ref)
            local v1 = workspace.Changed:Connect(function() end)
            u0:Add(v1)
            u0:Destroy()
            expect(v1.Connected).to.equal(false)
        end)
        it("should add and clean up a table with a destroy method", function() -- Line: 33 -- upvalues: u0 (ref)
            local v1 = {
                Destroyed = false,
                Destroy = function(self) -- Line: 35
                    self.Destroyed = true
                end,
            }
            u0:Add(v1)
            u0:Destroy()
            expect(v1.Destroyed).to.equal(true)
        end)
        it("should add and clean up a table with a disconnect method", function() -- Line: 43 -- upvalues: u0 (ref)
            local v1 = {
                Connected = true,
                Disconnect = function(self) -- Line: 45
                    self.Connected = false
                end,
            }
            u0:Add(v1)
            u0:Destroy()
            expect(v1.Connected).to.equal(false)
        end)
        it("should add and clean up a function", function() -- Line: 53 -- upvalues: u0 (ref)
            local u0_2 = false
            local v1 = u0
            v1:Add(function() -- Line: 55 -- upvalues: u0_2 (ref)
                u0_2 = true
            end)
            u0:Destroy()
            expect(u0_2).to.equal(true)
        end)
        it("should allow a custom cleanup method", function() -- Line: 62 -- upvalues: u0 (ref)
            local v1 = {
                Cleaned = false,
                Cleanup = function(p1) -- Line: 64
                    p1.Cleaned = true
                end,
            }
            u0:Add(v1, "Cleanup")
            u0:Destroy()
            expect(v1.Cleaned).to.equal(true)
        end)
        it("should return the object passed to add", function() -- Line: 72 -- upvalues: u0 (ref)
            local Part = Instance.new("Part")
            local v1 = u0:Add(Part)
            expect(Part).to.equal(v1)
            u0:Destroy()
        end)
        it("should fail to add object without proper cleanup method", function() -- Line: 79 -- upvalues: u0 (ref)
            local u0_2 = {}
            expect(function() -- Line: 81 -- upvalues: u0 (upval), u0_2 (val)
                local v1 = u0
                local v2 = u0_2
                v1:Add(v2)
            end).to.throw()
        end)
        it("should construct an object and add it", function() -- Line: 86 -- upvalues: u0 (ref)
            local u0_2 = {}
            u0_2.__index = u0_2

            function u0_2.new(p1) -- Line: 89 -- upvalues: u0_2 (val)
                local v1 = u0_2
                local v2 = setmetatable({}, v1)
                v2._msg = p1
                v2._destroyed = false
                return v2
            end

            function u0_2:Destroy() -- Line: 95
                self._destroyed = true
            end

            local v1 = u0:Construct(u0_2, "abc")
            expect((typeof(v1))).to.equal("table")
            expect((getmetatable(v1))).to.equal(u0_2)
            expect(v1._msg).to.equal("abc")
            expect(v1._destroyed).to.equal(false)
            u0:Destroy()
            expect(v1._destroyed).to.equal(true)
        end)
        it("should connect to a signal", function() -- Line: 108 -- upvalues: u0 (ref)
            local v1 = u0
            local Changed = workspace.Changed
            v1 = v1:Connect(Changed, function() end)
            expect((typeof(v1))).to.equal("RBXScriptConnection")
            expect(v1.Connected).to.equal(true)
            u0:Destroy()
            expect(v1.Connected).to.equal(false)
        end)
        it("should remove an object", function() -- Line: 116 -- upvalues: u0 (ref)
            local v1 = u0
            local Changed = workspace.Changed
            v1 = v1:Connect(Changed, function() end)
            expect(u0:Remove(v1)).to.equal(true)
            expect(v1.Connected).to.equal(false)
        end)
        it("should not remove an object not in the trove", function() -- Line: 122 -- upvalues: u0 (ref)
            local v1 = workspace.Changed:Connect(function() end)
            expect(u0:Remove(v1)).to.equal(false)
            expect(v1.Connected).to.equal(true)
            v1:Disconnect()
        end)
        it("should attach to instance", function() -- Line: 129 -- upvalues: u0 (ref)
            local Part = Instance.new("Part")
            Part.Parent = workspace
            local v1 = u0:AttachToInstance(Part)
            expect(v1.Connected).to.equal(true)
            Part:Destroy()
            expect(v1.Connected).to.equal(false)
        end)
        it("should fail to attach to instance not in hierarchy", function() -- Line: 138 -- upvalues: u0 (ref)
            local Part = Instance.new("Part")
            expect(function() -- Line: 140 -- upvalues: u0 (upval), Part (val)
                local v1 = u0
                local v2 = Part
                v1:AttachToInstance(v2)
            end).to.throw()
        end)
        it("should extend itself", function() -- Line: 145 -- upvalues: u0 (ref), Parent (upval)
            local v1 = u0:Extend()
            local u4 = false
            v1:Add(function() -- Line: 148 -- upvalues: u4 (ref)
                u4 = true
            end)
            expect(v1).to.be.a("table")
            expect((getmetatable(v1))).to.equal(Parent)
            u0:Clean()
            expect(u4).to.equal(true)
        end)
        it("should clone an instance", function() -- Line: 157 -- upvalues: u0 (ref)
            local v1 = u0
            local new = Instance.new
            v1 = v1:Construct(new, "Part")
            v1.Name = "TroveCloneTest"
            local v2 = u0:Clone(v1)
            expect((typeof(v2))).to.equal("Instance")
            expect(v2).to.never.equal(v1)
            expect(v2.Name).to.equal("TroveCloneTest")
            expect(v1.Name).to.equal(v2.Name)
        end)
        it("should clean up a thread", function() -- Line: 168 -- upvalues: u0 (ref)
            local v1 = coroutine.create(function() end)
            u0:Add(v1)
            expect(coroutine.status(v1)).to.equal("suspended")
            u0:Clean()
            expect(coroutine.status(v1)).to.equal("dead")
        end)
    end)
end