-- 🧠 بورك هافن هوب - HUB الأسطوري v3.0 (2026) - Naser Adm
-- 🔥 تحديث: Splash كامل الشاشة + ألوان neon (أزرق-بنفسجي) + موسيقى محلية looped + FE attempt قصير
-- 📱 Delta/Arceus X | NO KEY | Discord Top Right Copy
-- 🔗 https://discord.gg/DzVBbDKN

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

getgenv().Config = {
    Noclip = false,
    CurrentMusicID = "146961487",  -- Default Thunderstruck
    TargetPlayer = nil
}

-- قائمة أغاني جاهزة (IDs شهيرة في Brookhaven 2026)
local ReadySongs = {
    "AC/DC - Thunderstruck (146961487)",
    "Doja Cat - Say So (521116871)",
    "Dua Lipa - Levitating (6606223785)",
    "BTS - Fire (591276362)",
    "Marshmello - Happier (3033500772)",
    "Chill Jazz (1845341094)",
    "Clair de Lune (1846315693)",
    "Uptown Funk (1845554017)"
}

-- Splash Screen كامل الشاشة + ألوان neon + غوغو متحرك
local SplashGui = Instance.new("ScreenGui")
SplashGui.Name = "NeonSplash"
SplashGui.IgnoreGuiInset = true  -- مهم: يغطي الشاشة كامل حتى الـ topbar
SplashGui.ResetOnSpawn = false
SplashGui.Parent = game:GetService("CoreGui")

local SplashFrame = Instance.new("Frame")
SplashFrame.Size = UDim2.new(1, 0, 1, 0)
SplashFrame.Position = UDim2.new(0, 0, 0, 0)
SplashFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 30)  -- أسود غامق
SplashFrame.BorderSizePixel = 0
SplashFrame.Parent = SplashGui

-- تدرج neon (gradient)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),  -- أزرق neon
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 255)), -- بنفسجي
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200))   -- وردي
}
UIGradient.Rotation = 45
UIGradient.Parent = SplashFrame

local GokuImage = Instance.new("ImageLabel")
GokuImage.Size = UDim2.new(0.35, 0, 0.35, 0)
GokuImage.Position = UDim2.new(0.325, 0, 0.325, 0)
GokuImage.BackgroundTransparency = 1
GokuImage.Image = "rbxassetid://7625033282"  -- Goku Ultra Instinct
GokuImage.Parent = SplashFrame

-- أنميشن غوغو (دوران + نبض + glow)
local TweenRotate = TweenService:Create(GokuImage, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
TweenRotate:Play()

local TweenPulse = TweenService:Create(GokuImage, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0.4, 0, 0.4, 0)})
TweenPulse:Play()

wait(4.5)
TweenService:Create(SplashFrame, TweenInfo.new(1, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
wait(1)
SplashGui:Destroy()

-- Rayfield GUI (ألوان neon)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧠 بورك هافن هوب - Neon Edition",
    LoadingTitle = "جاري التحميل Neon...",
    LoadingSubtitle = "Naser Adm",
    ConfigurationSaving = {Enabled = true, FolderName = "NeonPorkHub"}
})

-- Discord Button Top Right (نسخ الرابط)
local DiscordGui = Instance.new("ScreenGui", game.CoreGui)
local DiscordBtn = Instance.new("ImageButton")
DiscordBtn.Size = UDim2.new(0, 50, 0, 50)
DiscordBtn.Position = UDim2.new(1, -60, 0, 10)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)  -- Discord blue
DiscordBtn.Image = "rbxassetid://6031075938"  -- Discord icon
local corner = Instance.new("UICorner", DiscordBtn); corner.CornerRadius = UDim.new(1,0)
DiscordBtn.Parent = DiscordGui

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/DzVBbDKN")
    Rayfield:Notify({Title = "تم النسخ!", Content = "رابط الديسكورد في الحافظة! 🚀", Duration = 3})
end)

-- Tab الموسيقى (محسنة)
local MusicTab = Window:CreateTab("🎵 موسيقى", 4483362458)

MusicTab:CreateDropdown({
    Name = "أغاني جاهزة (ID)",
    Options = ReadySongs,
    CurrentOption = ReadySongs[1],
    Callback = function(Option)
        local id = Option:match("%((%d+)%)") or "146961487"
        getgenv().Config.CurrentMusicID = id
    end
})

MusicTab:CreateInput({
    Name = "ID أغنية مخصصة",
    PlaceholderText = "مثال: 6606223785",
    Callback = function(Text)
        getgenv().Config.CurrentMusicID = Text
    end
})

MusicTab:CreateButton({
    Name = "▶️ تشغيل محلي (لك أنت + Looped)",
    Callback = function()
        local id = getgenv().Config.CurrentMusicID
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. id
        sound.Volume = 10
        sound.Looped = true
        sound.Parent = LocalPlayer:WaitForChild("PlayerGui")  -- أو Character.Head
        sound:Play()
        Rayfield:Notify({Title = "تشغيل محلي!", Content = "الأغنية لك أنت فقط (Looped)", Duration = 4})
    end
})

MusicTab:CreateButton({
    Name = "🔊 محاولة FE (قصيرة للكل - 3-5 ثواني)",
    Callback = function()
        local id = getgenv().Config.CurrentMusicID
        pcall(function()
            -- محاولة استخدام Remote موجود في Brookhaven (غالبا gun sound)
            local remote = ReplicatedStorage:FindFirstChild("RE") or ReplicatedStorage:FindFirstChildWhichIsA("RemoteEvent")
            if remote then
                remote:FireServer(Workspace, id, 1)  -- args حسب اللعبة
            end
            Rayfield:Notify({Title = "محاولة FE!", Content = "قد تشتغل 3-5 ثواني للكل", Duration = 5})
        end)
    end
})

MusicTab:CreateButton({
    Name = "⏹ إيقاف كل الأصوات",
    Callback = function()
        for _, s in pairs(Workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end
        for _, s in pairs(LocalPlayer.PlayerGui:GetDescendants()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end
        Rayfield:Notify({Title = "تم الإيقاف", Duration = 2})
    end
})

-- باقي التبويبات (Noclip + Kill) نفس السابق
local PlayerTab = Window:CreateTab("👥 لاعبين", 4483362458)
-- ... (انسخ باقي كود اللاعبين والـ Noclip من النسخة السابقة إذا تبي)

Rayfield:Notify({
    Title = "Neon Hub جاهز!",
    Content = "Splash كامل + ألوان neon + موسيقى محلية looped + FE attempt",
    Duration = 6
})
