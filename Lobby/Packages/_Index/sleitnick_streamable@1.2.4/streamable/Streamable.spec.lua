return function() -- Line: 1
    local Streamable = require(script.Parent.Streamable)
    local u5 = nil
    local u6 = nil

    local function CreateInstance(p1) -- Line: 7 -- upvalues: u5 (ref)
        local Folder = Instance.new("Folder")
        Folder.Name = p1
        Folder.Archivable = false
        Folder.Parent = u5
        return Folder
    end

    local function CreatePrimary() -- Line: 15 -- upvalues: u6 (ref)
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.Parent = u6
        u6.PrimaryPart = Part
        return Part
    end

    beforeAll(function() -- Line: 23 -- upvalues: u5 (ref), u6 (ref)
        u5 = Instance.new("Folder")
        u5.Name = "KnitTestFolder"
        u5.Archivable = false
        u5.Parent = workspace
        u6 = Instance.new("Model")
        u6.Name = "KnitTestModel"
        u6.Archivable = false
        u6.Parent = workspace
    end)
    afterEach(function() -- Line: 34 -- upvalues: u5 (ref), u6 (ref)
        u5:ClearAllChildren()
        u6:ClearAllChildren()
    end)
    afterAll(function() -- Line: 39 -- upvalues: u5 (ref), u6 (ref)
        u5:Destroy()
        u6:Destroy()
    end)
    describe("Streamable", function() -- Line: 44 -- upvalues: u5 (ref), Streamable (val), u6 (ref)
        it("should detect instance that is immediately available", function() -- Line: 45 -- upvalues: u5 (upval), Streamable (upval)
            local Folder = Instance.new("Folder")
            Folder.Name = "TestImmediate"
            Folder.Archivable = false
            Folder.Parent = u5
            local v1 = Folder
            local v2 = Streamable.new(u5, "TestImmediate")
            local u12 = 0
            local u13 = 0
            v2:Observe(function(p1, p2) -- Line: 50 -- upvalues: u12 (ref), u13 (ref)
                u12 = u12 + 1
                p2:Add(function() -- Line: 52 -- upvalues: u13 (upval)
                    u13 = u13 + 1
                end)
            end)
            task.wait()
            v1.Parent = nil
            task.wait()
            v1.Parent = u5
            task.wait()
            v2:Destroy()
            task.wait()
            expect(u12).to.equal(2)
            expect(u13).to.equal(2)
        end)
        it("should detect instance that is not immediately available", function() -- Line: 67 -- upvalues: Streamable (upval), u5 (upval)
            local v1 = Streamable.new(u5, "TestImmediate")
            local u5_2 = 0
            local u6 = 0
            v1:Observe(function(p1, p2) -- Line: 71 -- upvalues: u5_2 (ref), u6 (ref)
                u5_2 = u5_2 + 1
                p2:Add(function() -- Line: 73 -- upvalues: u6 (upval)
                    u6 = u6 + 1
                end)
            end)
            task.wait(0.1)
            local Folder = Instance.new("Folder")
            Folder.Name = "TestImmediate"
            Folder.Archivable = false
            Folder.Parent = u5
            local v2 = Folder
            task.wait()
            v2.Parent = nil
            task.wait()
            v2.Parent = u5
            task.wait()
            v1:Destroy()
            task.wait()
            expect(u5_2).to.equal(2)
            expect(u6).to.equal(2)
        end)
        it("should detect primary part that is immediately available", function() -- Line: 90 -- upvalues: u6 (upval), Streamable (upval)
            local Part = Instance.new("Part")
            Part.Anchored = true
            Part.Parent = u6
            u6.PrimaryPart = Part
            local v1 = Part
            local v2 = Streamable.primary(u6)
            local u11 = 0
            local u12 = 0
            v2:Observe(function(p1, p2) -- Line: 95 -- upvalues: u11 (ref), u12 (ref)
                u11 = u11 + 1
                p2:Add(function() -- Line: 97 -- upvalues: u12 (upval)
                    u12 = u12 + 1
                end)
            end)
            task.wait()
            v1.Parent = nil
            task.wait()
            v1.Parent = u6
            u6.PrimaryPart = v1
            task.wait()
            v2:Destroy()
            task.wait()
            expect(u11).to.equal(2)
            expect(u12).to.equal(2)
        end)
        it("should detect primary part that is not immediately available", function() -- Line: 113 -- upvalues: Streamable (upval), u6 (upval)
            local v1 = Streamable.primary(u6)
            local u4 = 0
            local u5 = 0
            v1:Observe(function(p1, p2) -- Line: 117 -- upvalues: u4 (ref), u5 (ref)
                u4 = u4 + 1
                p2:Add(function() -- Line: 119 -- upvalues: u5 (upval)
                    u5 = u5 + 1
                end)
            end)
            task.wait(0.1)
            local Part = Instance.new("Part")
            Part.Anchored = true
            Part.Parent = u6
            u6.PrimaryPart = Part
            local v2 = Part
            task.wait()
            v2.Parent = nil
            task.wait()
            v2.Parent = u6
            u6.PrimaryPart = v2
            task.wait()
            v1:Destroy()
            task.wait()
            expect(u4).to.equal(2)
            expect(u5).to.equal(2)
        end)
    end)
end