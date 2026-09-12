local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u21, u22 = require(ReplicatedStorage.Packages.Bin)()

function lerp(p1, p2, p3) -- Line: 11
    return p1 + (p2 - p1) * p3
end

local function toggleMotionSickness() -- Line: 15 -- upvalues: GameState (val), u22 (val), u21 (val), RunService (val)
    local v1 = GameState
    local MotionSicknessEnabled = v1.Data.Variables.MotionSicknessEnabled
    u22()
    if MotionSicknessEnabled then
        local u6 = 0
        local u7 = 0
        local u8 = 0
        local u9 = 1
        local u10 = 0
        local u11 = 0
        local u12 = 0
        local u13 = 1
        local u14 = 0
        local u15 = 0
        local u16 = 0
        local u17 = 1
        local u18 = 0
        local u19 = 0
        local u20 = 0
        local u21_2 = 1
        local u22_2 = 0
        local u23 = 0
        local u24 = 0
        local u25 = 1
        local u26 = 0
        local u27 = 0
        local u28 = 0
        local u29 = 1

        local function updateFormula() -- Line: 52
            -- upvalues: u18 (ref), u19 (ref), u20 (ref), u21_2 (ref), u22_2 (ref), u23 (ref), u24 (ref), u25 (ref)
            -- upvalues: u26 (ref), u27 (ref), u28 (ref), u29 (ref)
            return CFrame.new(u18, u19, u20, u21_2, u22_2, u23, u24, u25, u26, u27, u28, u29)
        end

        local u31 = 0
        local u32 = 0
        local u33 = u18
        local u34 = u19
        local u35 = u20
        local u36 = u21_2
        local u37 = u22_2
        local u38 = u23
        local u39 = u24
        local u40 = u25
        local u41 = u26
        local u42 = u27
        local u43 = u28
        local u44 = u29
        local v2 = u21
        local v3 = RunService
        v2(v3.RenderStepped:Connect(function(p1) -- Line: 67
            -- upvalues: u32 (ref), u31 (ref), u33 (ref), u34 (ref), u35 (ref), u18 (ref), u19 (ref), u20 (ref)
            -- upvalues: u36 (ref), u37 (ref), u38 (ref), u21_2 (ref), u22_2 (ref), u23 (ref), u39 (ref), u40 (ref)
            -- upvalues: u41 (ref), u24 (ref), u25 (ref), u26 (ref), u42 (ref), u43 (ref), u44 (ref), u27 (ref)
            -- upvalues: u28 (ref), u29 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref)
            -- upvalues: u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref)
            local v1
            u32 = u32 + p1
            local v2 = u32
            if u31 <= v2 then
                u32 = 0
                v2 = u18
                v1 = u19
                local v3 = u20
                u33 = v2
                u34 = v1
                u35 = v3
                v2 = u21_2
                v1 = u22_2
                v3 = u23
                u36 = v2
                u37 = v1
                u38 = v3
                v2 = u24
                v1 = u25
                v3 = u26
                u39 = v2
                u40 = v1
                u41 = v3
                v2 = u27
                v1 = u28
                v3 = u29
                u42 = v2
                u43 = v1
                u44 = v3
                u6 = math.random(-25, 25) * 0.01
                u7 = math.random(-25, 25) * 0.01
                u8 = math.random(-25, 25) * 0.01
                u9 = 1 + math.random(-25, 0) * 0.01
                u10 = math.random(-50, 50) * 0.01
                u11 = 0
                u12 = math.random(-50, 50) * 0.01
                u13 = 1 + math.random(-25, 0) * 0.01
                u14 = 0
                u15 = math.random(-50, 50) * 0.01
                u16 = math.random(-50, 50) * 0.01
                u17 = 1 + math.random(-25, 0) * 0.01
                u31 = math.random(25, 5000) / 1000
            end
            v1 = u32 / u31
            v2 = math.clamp(v1, 0, 1)
            u18 = lerp(u33, u6, v2)
            u19 = lerp(u34, u7, v2)
            u20 = lerp(u35, u8, v2)
            u21_2 = lerp(u36, u9, v2)
            u22_2 = lerp(u37, u10, v2)
            u23 = lerp(u38, u11, v2)
            u24 = lerp(u39, u12, v2)
            u25 = lerp(u40, u13, v2)
            u26 = lerp(u41, u14, v2)
            u27 = lerp(u42, u15, v2)
            u28 = lerp(u43, u16, v2)
            u29 = lerp(u44, u17, v2)
            v1 = CFrame.new(u18, u19, u20, u21_2, u22_2, u23, u24, u25, u26, u27, u28, u29)
            local CurrentCamera = workspace.CurrentCamera
            CurrentCamera.CFrame = CurrentCamera.CFrame * v1
        end))
    end
end

toggleMotionSickness()
GameState.Signals.Variables.MotionSicknessEnabled:Connect(toggleMotionSickness)
return {}