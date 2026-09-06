local HttpService = game:GetService("HttpService")
return {
    classify = function(p1) -- Line: 42
        if not (p1:IsA("Model")) then
            if p1:IsA("ModuleScript") then
                if p1:GetAttribute("Skin") then
                    return {type = "diff", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
                end
                return {type = "stock", instance = p1}
            end
            if p1:IsA("Configuration") then
                return {type = "configuration", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
            end
            if p1:IsA("Model") then
                return {type = "derived_model", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
            end
            return {type = "stock", instance = p1}
        end
        if p1:GetAttribute("SkinSDKVersion") then
            return {type = "skinsdk_model", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
        end
        if p1:IsA("ModuleScript") then
            if p1:GetAttribute("Skin") then
                return {type = "diff", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
            end
            return {type = "stock", instance = p1}
        end
        if p1:IsA("Configuration") then
            return {type = "configuration", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
        end
        if p1:IsA("Model") then
            return {type = "derived_model", baseWeapon = p1:GetAttribute("BaseWeapon"), instance = p1}
        end
        return {type = "stock", instance = p1}
    end,
    getBaseWeapon = function(p1) -- Line: 100 -- upvalues: HttpService (val)
        local v1, v2, v3, v4
        local Attribute = p1:GetAttribute("BaseWeapon")
        if Attribute then
            return Attribute
        end
        if not (p1:IsA("ModuleScript")) or p1:GetAttribute("Skin") then
            return nil
        end
        v1, v2 = pcall(require, p1)
        if not v1 or type(v2) ~= "string" then
            return nil
        end
        v3, v4 = pcall(HttpService.JSONDecode, HttpService, v2)
        if not v3 or type(v4) ~= "table" then
            return nil
        end
        local Attributes = v4.Attributes
        if not Attributes then
            Attributes = v4.a
        end
        if Attributes then
            return Attributes.BaseWeapon
        end
        return nil
    end,
    stampAttributes = function(p1) end,
}