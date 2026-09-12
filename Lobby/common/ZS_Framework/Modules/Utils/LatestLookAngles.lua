return {
    new = function(p1) -- Line: 4
        local u1 = {}
        return {
            Push = function(p1_2) -- Line: 7 -- upvalues: p1 (val), u1 (val)
                local Player = p1_2.Player
                if Player and p1(Player) then
                    local v1 = u1[Player]
                    if not v1 then
                        u1[Player] = p1_2
                    else
                        local ClientTick = p1_2.ClientTick
                        if v1.ClientTick <= ClientTick then
                            u1[Player] = p1_2
                        end
                    end
                    return
                end
            end,
            Take = function(p1) -- Line: 17 -- upvalues: u1 (val)
                local v1 = u1[p1]
                u1[p1] = nil
                return v1
            end,
            Remove = function(p1) -- Line: 22 -- upvalues: u1 (val)
                u1[p1] = nil
            end,
        }
    end,
}