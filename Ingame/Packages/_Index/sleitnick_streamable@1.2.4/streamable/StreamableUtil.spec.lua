return function() -- Line: 1
    local Streamable = require(script.Parent.Streamable)
    local StreamableUtil = require(script.Parent.StreamableUtil)
    local u10 = nil

    local function CreateInstance(p1) -- Line: 7 -- upvalues: u10 (ref)
        local Folder = Instance.new("Folder")
        Folder.Name = p1
        Folder.Archivable = false
        Folder.Parent = u10
        return Folder
    end

    beforeAll(function() -- Line: 15 -- upvalues: u10 (ref)
        u10 = Instance.new("Folder")
        u10.Name = "KnitTest"
        u10.Archivable = false
        u10.Parent = workspace
    end)
    afterEach(function() -- Line: 22 -- upvalues: u10 (ref)
        u10:ClearAllChildren()
    end)
    afterAll(function() -- Line: 26 -- upvalues: u10 (ref)
        u10:Destroy()
    end)
    describe("Compound", function() -- Line: 30 -- upvalues: Streamable (val), u10 (ref), StreamableUtil (val)
        it("should capture multiple streams", function() -- Line: 31 -- upvalues: Streamable (upval), u10 (upval), StreamableUtil (upval)
            local v1 = Streamable.new(u10, "ABC")
            local v2 = Streamable.new(u10, "XYZ")
            local u10_2 = 0
            local u11 = 0
            local v3 = StreamableUtil
            v3.Compound({S1 = v1, S2 = v2}, function(p1, p2) -- Line: 36 -- upvalues: u10_2 (ref), u11 (ref)
                u10_2 = u10_2 + 1
                p2:Add(function() -- Line: 38 -- upvalues: u11 (upval)
                    u11 = u11 + 1
                end)
            end)
            local Folder = Instance.new("Folder")
            Folder.Name = "ABC"
            Folder.Archivable = false
            Folder.Parent = u10
            v3 = Folder
            local Folder_2 = Instance.new("Folder")
            Folder_2.Name = "XYZ"
            Folder_2.Archivable = false
            Folder_2.Parent = u10
            local v4 = Folder_2
            task.wait()
            v3.Parent = nil
            task.wait()
            v3.Parent = u10
            task.wait()
            v3.Parent = nil
            v4.Parent = nil
            task.wait()
            v4.Parent = u10
            task.wait()
            expect(u10_2).to.equal(2)
            expect(u11).to.equal(2)
            v1:Destroy()
            v2:Destroy()
        end)
    end)
end