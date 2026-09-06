local u0 = 0
return {
    GetUID = function(p1) -- Line: 7 -- upvalues: u0 (ref)
        u0 = u0 % 65536 + 1
        return u0
    end,
}