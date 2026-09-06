return {
    GetDisplayName = function(p1, p2) -- Line: 11
        if not p2 then
            return p1
        end
        if p2.CustomName then
            return p2.CustomName
        end
        local v1 = p1
        if p2.Prefix then
            v1 = p2.Prefix .. v1
        end
        if p2.Suffix then
            v1 = v1 .. p2.Suffix
        end
        return v1
    end,
}