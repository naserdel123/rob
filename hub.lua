-- 🧠 غوغو هوب - HUB الأسطوري v1.0 (2026) - بواسطة Naser Adm
-- 🔥 سكريبت جديد كامل: سرقة Brainrot في ماب السرقة، TP Home bypass، ميزات إضافية (نط لا نهائي، دوران لا نهائي، ضرب لا نهائي، 1v1 ميزات)
-- 📱 يدعم الجوال/PC | Delta/Arceus X | NO KEY | متعدد اللغات (عربي أساسي)
-- 🚀 Splash Screen تغطي الشاشة مع صورة غوغو (Goku) متحركة
-- 💾 انسخ الكود > Edit hub.lua في ريبوك > Commit > Execute loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()
-- 🔗 Discord: https://discord.gg/DzVBbDKN

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

-- دعم اللغات (جدول ترجمات)
getgenv().Language = "Arabic"  -- الافتراضي عربي
local Translations = {
    Arabic = {
        WindowTitle = "🧠 غوغو هوب",
        LoadingTitle = "جاري التحميل...",
        SaveHome = "💾 حفظ القاعدة",
        TPHome = "🚀 نقل للقاعدة (Bypass)",
        InfJump = "نط لا نهائي",
        InfSpin = "دوران لا نهائي",
        InfPunch = "ضرب لا نهائي",
        Aimbot = "إيمبوت (1v1)",
        InfHealth = "صحة لا نهائية (1v1)",
        Discord = "انضم لديسكورد",
        ChangeLang = "تغيير اللغة",
        English = "إنجليزي",
        Arabic = "عربي",
        NotifySaved = "تم حفظ القاعدة!",
        NotifyTP = "تم النقل للقاعدة!",
        NotifyNoHome = "احفظ القاعدة أولاً!",
        NotifyLoaded = "غوغو هوب جاهز! سرق Brainrot ثم TP للقاعدة 🚀"
    },
    English = {
        WindowTitle = "🧠 Gogo Hub",
        LoadingTitle = "Loading...",
        SaveHome = "💾 Save Base",
        TPHome = "🚀 TP to Base (Bypass)",
        InfJump = "Infinite Jump",
        InfSpin = "Infinite Spin",
        InfPunch = "Infinite Punch",
        Aimbot = "Aimbot (1v1)",
        InfHealth = "Infinite Health (1v1)",
        Discord = "Join Discord",
        ChangeLang = "Change Language",
        English = "English",
        Arabic = "Arabic",
        NotifySaved = "Base Saved!",
        NotifyTP = "TP to Base Done!",
        NotifyNoHome = "Save Base First!",
        NotifyLoaded = "Gogo Hub Loaded! Steal Brainrot then TP to Base 🚀"
    }
}

-- متغيرات
getgenv().Config = {
    HomeCFrame = nil,
    InfJump = false,
    InfSpin = false,
    InfPunch = false,
    Aimbot = false,
    InfHealth = false
}

-- Splash Screen (تغطي الشاشة كاملة مع صورة غوغو متحركة)
local SplashGui = Instance.new("ScreenGui")
SplashGui.Name = "GogoSplash"
SplashGui.ResetOnSpawn = false
SplashGui.Parent = game:GetService("CoreGui")

local SplashFrame = Instance.new("Frame")
SplashFrame.Size = UDim2.new(1, 0, 1, 0)
SplashFrame.Position = UDim2.new(0, 0, 0, 0)
SplashFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SplashFrame.Parent = SplashGui

local GokuImage = Instance.new("ImageLabel")
GokuImage.Size = UDim2.new(0.5, 0, 0.5, 0)
GokuImage.Position = UDim2.new(0.25, 0, 0.25, 0)
GokuImage.BackgroundTransparency = 1
GokuImage.Image = "rbxassetid://7625033282"  -- ID صورة غوغو (Goku Ultra Instinct)
GokuImage.Parent = SplashFrame

-- أنميشن تحريك للصورة (دوران + scale)
local TweenRotate = TweenService:Create(GokuImage, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 360})
TweenRotate:Play()
local TweenScale = TweenService:Create(GokuImage, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, 0), {Size = UDim2.new(0.6, 0, 0.6, 0)})
TweenScale:Play()
TweenScale.Completed:Connect(function()
    TweenService:Create(GokuImage, TweenInfo.new(1, Enum.EasingStyle.Bounce), {Size = UDim2.new(0.5, 0, 0.5, 0)}):Play()
end)

wait(3)  -- عرض لـ 3 ثواني
SplashGui:Destroy()

-- Rayfield GUI (أسطورية)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = Translations[getgenv().Language].WindowTitle,
    LoadingTitle = Translations[getgenv().Language].LoadingTitle,
    LoadingSubtitle = "بواسطة Naser Adm",
    ConfigurationSaving = {Enabled = true, FolderName = "GogoHub", FileName = "naserdel123"}
})

-- Tab رئيسي: سرقة ونقل
local MainTab = Window:CreateTab("🧠 الرئيسي", 4483362458)

MainTab:CreateButton({
    Name = Translations[getgenv().Language].SaveHome,
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            getgenv().Config.HomeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({Title = "تم!", Content = Translations[getgenv().Language].NotifySaved, Duration = 3})
        end
    end
})

MainTab:CreateButton({
    Name = Translations[getgenv().Language].TPHome,
    Callback = function()
        if getgenv().Config.HomeCFrame then
            TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = getgenv().Config.HomeCFrame}):Play()
            Rayfield:Notify({Title = "تم!", Content = Translations[getgenv().Language].NotifyTP, Duration = 3})
        else
            Rayfield:Notify({Title = "خطأ", Content = Translations[getgenv().Language].NotifyNoHome, Duration = 3})
        end
    end
})

-- Tab ميزات إضافية
local ExtraTab = Window:CreateTab("⚡ ميزات إضافية", 4483362458)

ExtraTab:CreateToggle({
    Name = Translations[getgenv().Language].InfJump,
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfJump = Value
    end
})

ExtraTab:CreateToggle({
    Name = Translations[getgenv().Language].InfSpin,
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfSpin = Value
    end
})

ExtraTab:CreateToggle({
    Name = Translations[getgenv().Language].InfPunch,
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfPunch = Value
    end
})

-- Tab 1v1
local PvPTab = Window:CreateTab("⚔️ 1v1", 4483362458)

PvPTab:CreateToggle({
    Name = Translations[getgenv().Language].Aimbot,
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Aimbot = Value
    end
})

PvPTab:CreateToggle({
    Name = Translations[getgenv().Language].InfHealth,
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfHealth = Value
    end
})

-- Tab إعدادات (تغيير اللغة + ديسكورد)
local SettingsTab = Window:CreateTab("⚙️ إعدادات", 4483362458)

SettingsTab:CreateDropdown({
    Name = Translations[getgenv().Language].ChangeLang,
    Options = {Translations[getgenv().Language].Arabic, Translations[getgenv().Language].English},
    CurrentOption = Translations[getgenv().Language].Arabic,
    Callback = function(Option)
        if Option == Translations[getgenv().Language].English then getgenv().Language = "English" else getgenv().Language = "Arabic" end
        Rayfield:Destroy()  -- إعادة تحميل GUI لتغيير اللغة
        loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()  -- إعادة تنفيذ
    end
})

SettingsTab:CreateButton({
    Name = Translations[getgenv().Language].Discord,
    Callback = function()
        StarterGui:SetCore("PromptOverlay", {Text = "Discord: https://discord.gg/DzVBbDKN"})
        -- لا صورة، لأن Roblox لا يدعم روابط صور خارجية بسهولة
    end
})

-- Loops
UserInputService.JumpRequest:Connect(function()
    if getgenv().Config.InfJump then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RunService.Heartbeat:Connect(function()
    if getgenv().Config.InfSpin and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
    end
    if getgenv().Config.InfPunch and LocalPlayer.Character then
        -- افتراضي: ضرب أقرب لاعب (عدل حسب اللعبة)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                plr.Character.Humanoid.Health = plr.Character.Humanoid.Health - 1
            end
        end
    end
    if getgenv().Config.InfHealth and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.Health = 100
    end
    if getgenv().Config.Aimbot then
        local closest = nil
        local dist = math.huge
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local mag = (plr.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                if mag < dist then closest = plr dist = mag end
            end
        end
        if closest then
            Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
        end
    end
end)

Rayfield:Notify({
    Title = "تم التحميل!",
    Content = Translations[getgenv().Language].NotifyLoaded,
    Duration = 5
})
