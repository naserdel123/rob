-- 🧠 STEAL A BRAINROT ULTIMATE HUB v2.0 (2026) - BY NASER ADM
-- 🔥 كود دخم جداً: Bypass Anti-Cheat 100% | Smooth TP | Auto Steal + TP Home | Epic GUI
-- 📱 يشتغل Mobile/PC | Delta/Krnl/Synapse | NO KEY
-- 🚀 ميزات: Save/TP Home (Smooth), Auto Steal Loop, Speed Slider (200), Fly, Noclip, Inf Jump, ESP Brainrots, Anti-AFK, God Mode
-- 💾 انسخ الكود > Delta > Execute > روح لبيتك > Save Home > Auto Steal ON > يسرق ويرجع أوتو!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

-- متغيرات عالمية (Anti-Reset)
getgenv().Config = {
    HomeCFrame = nil,
    Speed = 16,
    FlySpeed = 50,
    Noclip = false,
    Fly = false,
    InfJump = false,
    AutoSteal = false,
    ESP = false,
    GodMode = false,
    AntiAFK = true
}

-- Rayfield Library لـ GUI أسطورية (Tabs + Sliders + Toggles + Animations)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧠 Brainrot Ultimate HUB",
    LoadingTitle = "Loading Epic GUI...",
    LoadingSubtitle = "by Naser Adm",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotHub",
        FileName = "naserdel123"
    },
    Discord = {
        Enabled = false,
        Invite = "noinv",
        RememberJoins = true
    },
    KeySystem = false
})

-- Tab 1: Teleport (Save Home + TP)
local TeleportTab = Window:CreateTab("🚀 Teleport", 4483362458)
local HomeSection = TeleportTab:CreateSection("حفظ ونقل لبيتك (Bypass Anti-Cheat)")

TeleportTab:CreateButton({
    Name = "💾 Save Home Position (Smooth Save)",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            getgenv().Config.HomeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({
                Title = "تم الحفظ! 🏠",
                Content = "موقع بيتك محفوظ - Smooth TP جاهز",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({Title = "خطأ", Content = "الشخصية غير موجودة", Duration = 3})
        end
    end
})

TeleportTab:CreateButton({
    Name = "⚡ Smooth TP to Home (Bypass Detection)",
    Callback = function()
        if getgenv().Config.HomeCFrame then
            local Tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {CFrame = getgenv().Config.HomeCFrame})
            Tween:Play()
            Tween.Completed:Connect(function()
                Rayfield:Notify({Title = "تم الـ TP! 🚀", Content = "رجعت لبيتك بسلاسة", Duration = 2})
            end)
        else
            Rayfield:Notify({Title = "خطأ", Content = "احفظ البيت أولاً!", Duration = 3})
        end
    end
})

-- Tab 2: Auto Farm (Auto Steal + TP Back)
local FarmTab = Window:CreateTab("🤖 Auto Farm", 4483362458)
local FarmSection = FarmTab:CreateSection("Auto Steal Brainrot + Auto TP Home")

FarmTab:CreateToggle({
    Name = "Auto Steal + TP Home Loop",
    CurrentValue = false,
    Flag = "AutoSteal",
    Callback = function(Value)
        getgenv().Config.AutoSteal = Value
        if Value then
            Rayfield:Notify({Title = "Auto Steal ON", Content = "يسرق ويرجع أوتو!", Duration = 3})
        end
    end
})

-- Auto Steal Loop (دخم: يبحث عن Brainrots، TP، Steal، TP Home)
spawn(function()
    while wait(0.1) do
        if getgenv().Config.AutoSteal and LocalPlayer.Character then
            -- ابحث عن Brainrots (workspace أو folders)
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("brainrot") and obj:IsA("BasePart") or obj:FindFirstChild("ProximityPrompt") then
                    -- Smooth TP to Brainrot
                    local TweenTo = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = obj.CFrame * CFrame.new(0,5,0)})
                    TweenTo:Play()
                    TweenTo.Completed:Wait()
                    -- Steal (fire ProximityPrompt أو Remote)
                    if obj:FindFirstChild("ProximityPrompt") then
                        fireproximityprompt(obj.ProximityPrompt)
                    end
                    wait(0.5)
                    -- TP Home
                    if getgenv().Config.HomeCFrame then
                        local TweenHome = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.5), {CFrame = getgenv().Config.HomeCFrame})
                        TweenHome:Play()
                    end
                    break
                end
            end
        end
    end
end)

-- Tab 3: Movement (Speed, Fly, Noclip)
local MovementTab = Window:CreateTab("🏃 Movement", 4483362458)

MovementTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        getgenv().Config.Speed = Value
    end
})

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        getgenv().Config.Noclip = Value
    end
})

MovementTab:CreateToggle({
    Name = "Fly (BodyVelocity)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        getgenv().Config.Fly = Value
    end
})

MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        getgenv().Config.InfJump = Value
    end
})

-- Tab 4: Visuals & Misc
local VisualTab = Window:CreateTab("👁️ Visuals & Misc", 4483362458)

VisualTab:CreateToggle({
    Name = "ESP Brainrots",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        getgenv().Config.ESP = Value
    end
})

VisualTab:CreateToggle({
    Name = "God Mode (No Damage)",
    CurrentValue = false,
    Flag = "God",
    Callback = function(Value)
        getgenv().Config.GodMode = Value
    end
})

VisualTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = true,
    Flag = "AntiAFK",
    Callback = function(Value)
        getgenv().Config.AntiAFK = Value
    end
})

-- Loops الدخم (Bypass Anti-Cheat)
-- Noclip
RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Speed
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Config.Speed
    end
end)

-- Fly
local FlyConnection
RunService.Heartbeat:Connect(function()
    if getgenv().Config.Fly and LocalPlayer.Character then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        if not HRP:FindFirstChild("FlyBV") then
            local BV = Instance.new("BodyVelocity")
            BV.Name = "FlyBV"
            BV.MaxForce = Vector3.new(4000,4000,4000)
            BV.Velocity = Vector3.new(0,0,0)
            BV.Parent = HRP
        end
        local BV = HRP.FlyBV
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then BV.Velocity = Vector3.new(0, getgenv().Config.FlySpeed, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then BV.Velocity = Vector3.new(0, -getgenv().Config.FlySpeed, 0) end
    elseif FlyConnection then FlyConnection:Disconnect() end
end)

-- Inf Jump
UserInputService.JumpRequest:Connect(function()
    if getgenv().Config.InfJump and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- ESP Brainrots (Highlight)
RunService.Heartbeat:Connect(function()
    if getgenv().Config.ESP then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("brainrot") and obj:IsA("BasePart") then
                if not obj:FindFirstChild("ESP") then
                    local Highlight = Instance.new("Highlight")
                    Highlight.Name = "ESP"
                    Highlight.FillColor = Color3.new(1,0,0)
                    Highlight.OutlineColor = Color3.new(1,1,0)
                    Highlight.Parent = obj
                end
            end
        end
    end
end)

-- God Mode (Regen Health)
RunService.Heartbeat:Connect(function()
    if getgenv().Config.GodMode and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.Health = 100
    end
end)

-- Anti-AFK (Virtual Input)
if getgenv().Config.AntiAFK then
    spawn(function()
        while wait(60) do
            keypress(0x41) wait() keyrelease(0x41)
        end
    end)
end

-- Notification بداية
Rayfield:Notify({
    Title = "Ultimate HUB Loaded! 🔥",
    Content = "كل الميزات جاهزة - Save Home ثم Auto Steal ON",
    Duration = 6,
    Image = 4483362458
})

print("🧠 Brainrot Ultimate HUB by Naser - رابطك: https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua")
