-- 🧠 بورك هافن هوب - HUB الأسطوري v2.0 (2026) - بواسطة Naser Adm
-- 🔥 سكريبت جديد لـ Brookhaven RP (بورك هافن): مشغل موسيقى FE لكل السيرفر، Noclip، قتل لاعب، قائمة أغاني جاهزة
-- 📱 يدعم الجوال/PC | Delta/Arceus X | NO KEY | Splash Screen غوغو + Discord Profile Top Right (Copy Invite)
-- 🚀 ميزات: أدخل ID أغنية > Play للكل | Dropdown أغاني شهيرة 2026 | اختر لاعب > Kill | Noclip
-- 💾 انسخ > Edit hub.lua في https://github.com/naserdel123/rob > Commit > Execute loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()
-- 🔗 Discord Invite: https://discord.gg/DzVBbDKN

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- متغيرات
getgenv().Config = {
    Noclip = false,
    CurrentMusic = nil,
    TargetPlayer = nil
}

-- قائمة أغاني جاهزة 2026 (محدثة من Roblox Catalog)
local ReadySongs = {
    "AC/DC - Thunderstruck (146961487)",
    "Doja Cat - Say So (521116871)",
    "Dua Lipa - Levitating (6606223785)",
    "Beethoven - Fur Elise (450051032)",
    "Ariana Grande - God Is a Woman (2078627614)",
    "Green Day - Basket Case (3449839683)",
    "Marshmello - Happier (3033500772)",
    "Chill Jazz (1845341094)",
    "Clair de Lune (1846315693)",
    "Uptown (1845554017)"
}

-- Splash Screen تغطي الشاشة مع غوغو متحرك
local SplashGui = Instance.new("ScreenGui")
SplashGui.Name = "PorkHavenSplash"
SplashGui.ResetOnSpawn = false
SplashGui.Parent = game:GetService("CoreGui")

local SplashFrame = Instance.new("Frame")
SplashFrame.Size = UDim2.new(1, 0, 1, 0)
SplashFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 20)
SplashFrame.Parent = SplashGui

local GokuImage = Instance.new("ImageLabel")
GokuImage.Size = UDim2.new(0.4, 0, 0.4, 0)
GokuImage.Position = UDim2.new(0.3, 0, 0.3, 0)
GokuImage.BackgroundTransparency = 1
GokuImage.Image = "rbxassetid://7625033282"  -- Goku Ultra Instinct
GokuImage.Parent = SplashFrame

-- أنميشن غوغو (دوران + نبض)
spawn(function()
    while SplashGui.Parent do
        TweenService:Create(GokuImage, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = 360}):Play()
        TweenService:Create(GokuImage, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        wait(0.5)
        TweenService:Create(GokuImage, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0.4, 0, 0.4, 0), Rotation = 0}):Play()
        wait(2)
    end
end)

wait(4)
SplashGui:Destroy()

-- Rayfield GUI أسطورية
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧠 بورك هافن هوب",
    LoadingTitle = "جاري تحميل بورك هافن...",
    LoadingSubtitle = "Naser Adm",
    ConfigurationSaving = {Enabled = true, FolderName = "PorkHavenHub", FileName = "naserdel123"}
})

-- Discord Profile Picture Top Right (صورة ملف شخصي + نسخ رابط)
local DiscordGui = Instance.new("ScreenGui")
DiscordGui.Name = "DiscordButton"
DiscordGui.Parent = game:GetService("CoreGui")

local DiscordFrame = Instance.new("Frame")
DiscordFrame.Size = UDim2.new(0, 60, 0, 60)
DiscordFrame.Position = UDim2.new(1, -70, 0, 10)
DiscordFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
DiscordFrame.Parent = DiscordGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = DiscordFrame

local DiscordImg = Instance.new("ImageLabel")
DiscordImg.Size = UDim2.new(0.8, 0, 0.8, 0)
DiscordImg.Position = UDim2.new(0.1, 0, 0.1, 0)
DiscordImg.BackgroundTransparency = 1
DiscordImg.Image = "rbxassetid://6031075938"  -- Discord Logo
DiscordImg.Parent = DiscordFrame

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(1, 0, 1, 0)
CopyButton.BackgroundTransparency = 1
CopyButton.Text = ""
CopyButton.Parent = DiscordFrame

CopyButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/DzVBbDKN")
    Rayfield:Notify({Title = "تم النسخ!", Content = "رابط Discord في الحافظة 🚀", Duration = 3})
end)

-- Tab الموسيقى
local MusicTab = Window:CreateTab("🎵 الموسيقى", 4483362458)

MusicTab:CreateDropdown({
    Name = "أغاني جاهزة 2026",
    Options = ReadySongs,
    CurrentOption = "AC/DC - Thunderstruck (146961487)",
    Flag = "ReadySong",
    Callback = function(Option)
        local id = Option:match("%((%d+%)%)")
        Rayfield:Notify({Title = "تم الاختيار", Content = Option, Duration = 2})
    end
})

local MusicInput = MusicTab:CreateInput({
    Name = "ID الأغنية (من Roblox Studio)",
    PlaceholderText = "مثال: 521116871",
    Callback = function(Text)
        getgenv().Config.CurrentMusic = Text
    end
})

MusicTab:CreateButton({
    Name = "▶️ تشغيل لكل السيرفر (FE)",
    Callback = function()
        local id = getgenv().Config.CurrentMusic or "146961487"  -- Default
        local Sound = Instance.new("Sound")
        Sound.Name = "PorkHavenMusic"
        Sound.SoundId = "rbxassetid://" .. id
        Sound.Volume = 10  -- عالي للكل
        Sound.Looped = true
        Sound.Parent = Workspace
        Sound:Play()
        Rayfield:Notify({Title = "تشغيل!", Content = "الأغنية: " .. id .. " لكل السيرفر!", Duration = 4})
        -- Kill old sounds
        for _, s in pairs(Workspace:GetChildren()) do
            if s:IsA("Sound") and s.Name == "PorkHavenMusic" then s:Destroy() end
        end
        Sound.Parent = Workspace
    end
})

MusicTab:CreateButton({
    Name = "⏹ إيقاف",
    Callback = function()
        for _, s in pairs(Workspace:GetChildren()) do
            if s:IsA("Sound") and s.Name == "PorkHavenMusic" then s:Stop() s:Destroy() end
        end
        Rayfield:Notify({Title = "تم الإيقاف", Duration = 2})
    end
})

-- Tab اللاعبين
local PlayerTab = Window:CreateTab("👥 اللاعبين", 4483362458)

local PlayerDropdown = PlayerTab:CreateDropdown({
    Name = "اختر لاعب للقتل",
    Options = {},
    Callback = function(Option)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Name == Option then getgenv().Config.TargetPlayer = plr break end
        end
    end
})

-- Update dropdown
Players.PlayerAdded:Connect(function() PlayerDropdown:Refresh(Players:GetPlayers(), true) end)
Players.PlayerRemoving:Connect(function() PlayerDropdown:Refresh(Players:GetPlayers(), true) end)
PlayerDropdown:Refresh(Players:GetPlayers(), true)

PlayerTab:CreateButton({
    Name = "💀 قتل اللاعب",
    Callback = function()
        if getgenv().Config.TargetPlayer and getgenv().Config.TargetPlayer.Character then
            getgenv().Config.TargetPlayer.Character.Humanoid.Health = 0
            Rayfield:Notify({Title = "تم القتل!", Content = getgenv().Config.TargetPlayer.Name .. " مات!", Duration = 3})
        else
            Rayfield:Notify({Title = "خطأ", Content = "اختر لاعب!", Duration = 3})
        end
    end
})

-- Tab الحركة
local MoveTab = Window:CreateTab("🏃 الحركة", 4483362458)

MoveTab:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Noclip = Value
    end
})

-- Noclip Loop
RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- إشعار نهاية
Rayfield:Notify({
    Title = "بورك هافن هوب جاهز! 🎉",
    Content = "شغل موسيقى، اقتل لاعبين، Noclip! Discord في أعلى اليمين",
    Duration = 6
})

print("🧠 PorkHaven Hub Loaded - https://discord.gg/DzVBbDKN")
