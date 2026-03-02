-- 🔥 PUNCH HUB v1.0 (2026) - BY NASER ADM @adm_naser40968
-- 🧊 سكريبت جديد كامل: واجهة أسطورية (Rayfield) مع أنميشن واقعي (Tween Punch + Effects)
-- 📱 يشتغل Mobile/PC | Delta/Arceus X | NO KEY
-- 🚀 الميزة الوحيدة: زر "قبضة" → اكتب اسم اللاعب → زر "ضرب" → يضربه بأنميشن واقعي وينقص دمه شوي (Damage Loop)
-- 💥 Bypass Anti-Cheat: Smooth Tween to Target + Set Health -10 كل ضربة
-- 💾 انسخ > Edit hub.lua في ريبوك https://github.com/naserdel123/rob > Commit > Execute loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

-- Rayfield Library لـ GUI أسطورية (Tabs + Inputs + Animations)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧊 Punch Hub - Naser Adm",
    LoadingTitle = "Loading Punch System...",
    LoadingSubtitle = "@adm_naser40968",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PunchHub",
        FileName = "naserdel123"
    },
    KeySystem = false
})

-- Tab الوحيد: Punch System
local PunchTab = Window:CreateTab("👊 Punch System", 4483362458)
local PunchSection = PunchTab:CreateSection("ضرب اللاعبين (Realistic Animation)")

local TargetPlayer = nil  -- اللاعب المستهدف

-- زر "قبضة" → يفتح Input لاسم اللاعب
PunchTab:CreateButton({
    Name = "👊 قبضة (Select Target)",
    Callback = function()
        Rayfield:Notify({Title = "ادخل الاسم", Content = "اكتب اسم اللاعب بالضبط", Duration = 3})
    end
})

-- Input لاسم اللاعب
local PlayerInput = PunchTab:CreateInput({
    Name = "اسم اللاعب (Exact Name)",
    PlaceholderText = "e.g., PlayerName123",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local found = false
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Name:lower() == Text:lower() then
                TargetPlayer = plr
                found = true
                Rayfield:Notify({Title = "تم الاختيار!", Content = "اللاعب: " .. TargetPlayer.Name .. " جاهز للضرب", Duration = 3})
                break
            end
        end
        if not found then
            Rayfield:Notify({Title = "خطأ", Content = "لاعب غير موجود، جرب اسم تاني", Duration = 3})
            TargetPlayer = nil
        end
    end
})

-- زر "ضرب" → يضرب بأنميشن واقعي وينقص الدم
PunchTab:CreateButton({
    Name = "💥 ضرب (Punch Damage)",
    Callback = function()
        if TargetPlayer and TargetPlayer.Character and LocalPlayer.Character then
            local MyHRP = LocalPlayer.Character.HumanoidRootPart
            local TargetHRP = TargetPlayer.Character.HumanoidRootPart
            local TargetHum = TargetPlayer.Character:FindFirstChild("Humanoid")

            if TargetHum then
                -- أنميشن واقعي: Tween إلى الخصم + Punch Effect
                local TweenToTarget = TweenService:Create(MyHRP, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CFrame = TargetHRP.CFrame * CFrame.new(0, 0, -2)})
                TweenToTarget:Play()
                TweenToTarget.Completed:Connect(function()
                    -- Punch Animation: Arm Swing (Simple Part Effect)
                    local PunchEffect = Instance.new("Part")
                    PunchEffect.Size = Vector3.new(1,1,2)
                    PunchEffect.BrickColor = BrickColor.new("Bright red")
                    PunchEffect.Transparency = 0.5
                    PunchEffect.Anchored = false
                    PunchEffect.CanCollide = false
                    PunchEffect.CFrame = MyHRP.CFrame * CFrame.new(2,0,0)
                    PunchEffect.Parent = Workspace
                    Debris:AddItem(PunchEffect, 0.5)

                    local TweenPunch = TweenService:Create(PunchEffect, TweenInfo.new(0.2), {CFrame = TargetHRP.CFrame, Transparency = 1})
                    TweenPunch:Play()

                    -- Damage: نقص 10 دم
                    TargetHum.Health = TargetHum.Health - 10
                    Rayfield:Notify({Title = "ضرب!", Content = "نقصت دم " .. TargetPlayer.Name .. " بـ 10! (دمه الحالي: " .. math.floor(TargetHum.Health) .. ")", Duration = 2})

                    -- رجع لموقعك (Bypass Detection)
                    wait(0.2)
                    TweenService:Create(MyHRP, TweenInfo.new(0.3), {CFrame = MyHRP.CFrame * CFrame.new(0,0,3)}):Play()
                end)
            else
                Rayfield:Notify({Title = "خطأ", Content = "اللاعب بدون Humanoid", Duration = 3})
            end
        else
            Rayfield:Notify({Title = "خطأ", Content = "اختر لاعب أولاً!", Duration = 3})
        end
    end
})

-- إشعار بداية
Rayfield:Notify({
    Title = "Punch Hub Loaded! 👊",
    Content = "اضغط قبضة → اكتب اسم → اضغط ضرب. أنميشن واقعي + Damage!",
    Duration = 6
})
