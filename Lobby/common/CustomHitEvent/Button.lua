return {
    onActivate = nil,
    OnHit = function(p1, p2, p3, p4, p5) -- Line: 4
        if p1.onActivate then
            p1.onActivate(p2)
        end
    end,
}