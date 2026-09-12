local HttpService = game:GetService("HttpService")
return {
    classify = function(p1) -- Line: 42
        if p1:IsA("Model") and p1:GetAttribute("SkinSDKVersion") then
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
        local Attribute = p1:GetAttribute("BaseWeapon")
        if Attribute then
            return Attribute
        end
        if p1:IsA("ModuleScript") and not p1:GetAttribute("Skin") then
            local success, result = pcall(require, p1)
            if success and type(result) == "string" then
                local success_2, result_2 = pcall(HttpService.JSONDecode, HttpService, result)
                if success_2 and type(result_2) == "table" then
                    local Attributes = result_2.Attributes
                    if not Attributes then
                        Attributes = result_2.a
                    end
                    if Attributes then
                        return Attributes.BaseWeapon
                    end
                end
            end
        end
        return nil
    end,
    stampAttributes = function(p1) end,
}