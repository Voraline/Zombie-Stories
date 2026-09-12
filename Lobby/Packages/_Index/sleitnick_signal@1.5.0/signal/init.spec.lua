local function AwaitCondition(p1, p2) -- Line: 1
    local v1 = os.clock()
    while not p1() do
        if (p2 or 10) < os.clock() - v1 then
            return false
        end
        task.wait()
    end
    return true
end

return function() -- Line: 15 -- upvalues: AwaitCondition (val)
    local Parent = require(script.Parent)
    local u4 = nil

    local function NumConns(p1) -- Line: 20 -- upvalues: u4 (ref)
        local v1 = p1
        if not v1 then
            v1 = u4
        end
        return #v1:GetConnections()
    end

    beforeEach(function() -- Line: 25 -- upvalues: u4 (ref), Parent (val)
        u4 = Parent.new()
    end)
    afterEach(function() -- Line: 29 -- upvalues: u4 (ref)
        u4:Destroy()
    end)
    describe("Constructor", function() -- Line: 33 -- upvalues: Parent (val), u4 (ref), AwaitCondition (upval)
        it("should create a new signal and fire it", function() -- Line: 34 -- upvalues: Parent (upval), u4 (upval)
            expect(Parent.Is(u4)).to.equal(true)
            task.defer(function() -- Line: 36 -- upvalues: u4 (upval)
                u4:Fire(10, 20)
            end)
            local v1, v2 = u4:Wait()
            expect(v1).to.equal(10)
            expect(v2).to.equal(20)
        end)
        it("should create a proxy signal and connect to it", function() -- Line: 44 -- upvalues: Parent (upval), AwaitCondition (upval)
            local v1 = Parent.Wrap(game:GetService("RunService").Heartbeat)
            expect(Parent.Is(v1)).to.equal(true)
            local u19 = false
            v1:Connect(function() -- Line: 48 -- upvalues: u19 (ref)
                u19 = true
            end)
            local v2 = expect
            local v3 = AwaitCondition
            v2(v3(function() -- Line: 51 -- upvalues: u19 (ref)
                return u19
            end, 2)).to.equal(true)
            v1:Destroy()
        end)
    end)
    describe("FireDeferred", function() -- Line: 58 -- upvalues: u4 (ref), AwaitCondition (upval)
        it("should be able to fire primitive argument", function() -- Line: 59 -- upvalues: u4 (upval), AwaitCondition (upval)
            local u0 = nil
            local v1 = u4
            v1:Connect(function(p1) -- Line: 62 -- upvalues: u0 (ref)
                u0 = p1
            end)
            u4:FireDeferred(10)
            v1 = expect
            local v2 = AwaitCondition
            v1(v2(function() -- Line: 66 -- upvalues: u0 (ref)
                local v1 = u0 == 10
                return v1
            end, 1)).to.equal(true)
        end)
        it("should be able to fire a reference based argument", function() -- Line: 71 -- upvalues: u4 (upval), AwaitCondition (upval)
            local u0 = {10, 20}
            local u3 = nil
            local v1 = u4
            v1:Connect(function(p1) -- Line: 74 -- upvalues: u3 (ref)
                u3 = p1
            end)
            u4:FireDeferred(u0)
            v1 = expect
            local v2 = AwaitCondition
            v1(v2(function() -- Line: 78 -- upvalues: u0 (val), u3 (ref)
                local v1 = u0 == u3
                return v1
            end, 1)).to.equal(true)
        end)
    end)
    describe("Fire", function() -- Line: 84 -- upvalues: u4 (ref)
        it("should be able to fire primitive argument", function() -- Line: 85 -- upvalues: u4 (upval)
            local u0 = nil
            local v1 = u4
            v1:Connect(function(p1) -- Line: 88 -- upvalues: u0 (ref)
                u0 = p1
            end)
            u4:Fire(10)
            expect(u0).to.equal(10)
        end)
        it("should be able to fire a reference based argument", function() -- Line: 95 -- upvalues: u4 (upval)
            local v1 = {10, 20}
            local u3 = nil
            local v2 = u4
            v2:Connect(function(p1) -- Line: 98 -- upvalues: u3 (ref)
                u3 = p1
            end)
            u4:Fire(v1)
            expect(u3).to.equal(v1)
        end)
    end)
    describe("ConnectOnce", function() -- Line: 106 -- upvalues: u4 (ref)
        it("should only capture first fire", function() -- Line: 107 -- upvalues: u4 (upval)
            local u0 = nil
            local v1 = u4
            v1 = v1:ConnectOnce(function(p1) -- Line: 109 -- upvalues: u0 (ref)
                u0 = p1
            end)
            expect(v1.Connected).to.equal(true)
            u4:Fire(10)
            expect(v1.Connected).to.equal(false)
            u4:Fire(20)
            expect(u0).to.equal(10)
        end)
    end)
    describe("Wait", function() -- Line: 120 -- upvalues: u4 (ref)
        it("should be able to wait for a signal to fire", function() -- Line: 121 -- upvalues: u4 (upval)
            task.defer(function() -- Line: 122 -- upvalues: u4 (upval)
                u4:Fire(10, 20, 30)
            end)
            local v1, v2, v3 = u4:Wait()
            expect(v1).to.equal(10)
            expect(v2).to.equal(20)
            expect(v3).to.equal(30)
        end)
    end)
    describe("DisconnectAll", function() -- Line: 132 -- upvalues: u4 (ref)
        it("should disconnect all connections", function() -- Line: 133 -- upvalues: u4 (upval)
            u4:Connect(function() end)
            u4:Connect(function() end)
            local v1 = expect
            local v2 = nil
            if not v2 then
                v2 = u4
            end
            v1(#v2:GetConnections()).to.equal(2)
            u4:DisconnectAll()
            v1 = expect
            v2 = nil
            if not v2 then
                v2 = u4
            end
            v1(#v2:GetConnections()).to.equal(0)
        end)
    end)
    describe("Disconnect", function() -- Line: 142 -- upvalues: u4 (ref), AwaitCondition (upval)
        it("should disconnect connection", function() -- Line: 143 -- upvalues: u4 (upval)
            local v1 = u4:Connect(function() end)
            local v2 = expect
            local v3 = nil
            if not v3 then
                v3 = u4
            end
            v2(#v3:GetConnections()).to.equal(1)
            v1:Disconnect()
            v2 = expect
            v3 = nil
            if not v3 then
                v3 = u4
            end
            v2(#v3:GetConnections()).to.equal(0)
        end)
        it("should still work if connections disconnected while firing", function() -- Line: 150 -- upvalues: u4 (upval)
            local u0 = 0
            local u1 = nil
            local v1 = u4
            v1:Connect(function() -- Line: 153 -- upvalues: u0 (ref)
                u0 = u0 + 1
            end)
            v1 = u4
            v1 = v1:Connect(function() -- Line: 156 -- upvalues: u1 (ref), u0 (ref)
                u1:Disconnect()
                u0 = u0 + 1
            end)
            v1 = u4
            v1:Connect(function() -- Line: 160 -- upvalues: u0 (ref)
                u0 = u0 + 1
            end)
            u4:Fire()
            expect(u0).to.equal(3)
        end)
        it("should still work if connections disconnected while firing deferred", function() -- Line: 167 -- upvalues: u4 (upval), AwaitCondition (upval)
            local u0 = 0
            local u1 = nil
            local v1 = u4
            v1:Connect(function() -- Line: 170 -- upvalues: u0 (ref)
                u0 = u0 + 1
            end)
            v1 = u4
            v1 = v1:Connect(function() -- Line: 173 -- upvalues: u1 (ref), u0 (ref)
                u1:Disconnect()
                u0 = u0 + 1
            end)
            v1 = u4
            v1:Connect(function() -- Line: 177 -- upvalues: u0 (ref)
                u0 = u0 + 1
            end)
            u4:FireDeferred()
            v1 = expect
            local v2 = AwaitCondition
            v1(v2(function() -- Line: 181 -- upvalues: u0 (ref)
                local v1 = u0 == 3
                return v1
            end)).to.equal(true)
        end)
    end)
end