-- 🧠 بورك هافن هوب - HUB الأسطوري v4.0 (2026) - Naser Adm
-- 🔥 تحديث دخم: موسيقى FE محاولة أقوى (loop short sounds للكل), ميزات كثيرة (Inf Jump/Spin/Punch/Fly, Select Player > Fly to Sky), Splash Goku Tattoo Full Screen Neon
-- 📱 Delta/Arceus X | NO KEY | Discord Button داخل GUI مع Copy Invite
-- 🔗 https://discord.gg/DzVBbDKN | Goku Tattoo Image from X: https://x.com/i/status/1269264591256793091 (rbxassetid مشابه)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

getgenv().Config = {
    Noclip = false,
    Fly = false,
    InfJump = false,
    InfSpin = false,
    InfPunch = false,
    GodMode = false,
    CurrentMusicID = "146961487",
    TargetPlayer = nil
}

-- قائمة أغاني جاهزة
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

-- Splash Full Screen مع Goku Tattoo + Neon Colors + Animation
local SplashGui = Instance.new("ScreenGui")
SplashGui.Name = "GokuSplashNeon"
SplashGui.IgnoreGuiInset = true
SplashGui.ResetOnSpawn = false
SplashGui.Parent = game:GetService("CoreGui")

local SplashFrame = Instance.new("Frame")
SplashFrame.Size = UDim2.new(1, 0, 1, 0)
SplashFrame.Position = UDim2.new(0, 0, 0, 0)
SplashFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 50)  -- أزرق غامق neon base
SplashFrame.Parent = SplashGui

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),  -- أزرق فاتح
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)), -- بنفسجي
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))   -- أزرق فاتح
}
UIGradient.Rotation = 90
UIGradient.Parent = SplashFrame

local GokuImage = Instance.new("ImageLabel")
GokuImage.Size = UDim2.new(0.6, 0, 0.6, 0)
GokuImage.Position = UDim2.new(0.2, 0, 0.2, 0)
GokuImage.BackgroundTransparency = 1
GokuImage.Image = "rbxassetid://11141271480"  -- Goku decal مشابه (من بحث)
GokuImage.Parent = SplashFrame

-- أنميشن قوي: دوران + نبض + fade in/out
TweenService:Create(GokuImage, TweenInfo.new(1, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()
local TweenRotate = TweenService:Create(GokuImage, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
TweenRotate:Play()
local TweenPulse = TweenService:Create(GokuImage, TweenInfo.new(1.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0.7, 0, 0.7, 0)})
TweenPulse:Play()

wait(5)
TweenService:Create(SplashFrame, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
TweenService:Create(GokuImage, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {ImageTransparency = 1}):Play()
wait(1.2)
SplashGui:Destroy()

-- Rayfield GUI Neon Style
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧠 بورك هافن هوب - Neon V4",
    LoadingTitle = "جاري التحميل الدخم...",
    LoadingSubtitle = "Naser Adm",
    ConfigurationSaving = {Enabled = true, FolderName = "DukhmPorkHub"}
})

-- Discord Button داخل GUI
local SettingsTab = Window:CreateTab("⚙️ إعدادات", 4483362458)

SettingsTab:CreateButton({
    Name = "📌 انضم لديسكورد (Copy Invite)",
    Callback = function()
        setclipboard("https://discord.gg/DzVBbDKN")
        Rayfield:Notify({Title = "تم النسخ!", Content = "رابط: https://discord.gg/DzVBbDKN", Duration = 4})
    end
})

-- Tab الموسيقى (دخم: محاولة FE loop قصير + محلي looped)
local MusicTab = Window:CreateTab("🎵 موسيقى", 4483362458)

MusicTab:CreateDropdown({
    Name = "أغاني جاهزة",
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
    Name = "▶️ تشغيل محلي Looped (لك عالي الصوت)",
    Callback = function()
        local id = getgenv().Config.CurrentMusicID
        local sound = Instance.new("Sound", LocalPlayer.Character.Head)
        sound.SoundId = "rbxassetid://" .. id
        sound.Volume = 50  -- عالي جدًا
        sound.Looped = true
        sound:Play()
        Rayfield:Notify({Title = "محلي Looped!", Content = "تسمعها أنت فقط بصوت عالي", Duration = 4})
    end
})

MusicTab:CreateToggle({
    Name = "🔊 محاولة FE Loop (قصير للكل كل 5 ثواني)",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            spawn(function()
                while Value do
                    local id = getgenv().Config.CurrentMusicID
                    local sound = Instance.new("Sound", Workspace)
                    sound.SoundId = "rbxassetid://" .. id
                    sound.Volume = 10
                    sound:Play()
                    wait(5)  -- Loop every 5 secs for FE attempt
                end
            end)
            Rayfield:Notify({Title = "FE Loop ON!", Content = "محاولة تشغيل قصير للكل (قد يعمل)", Duration = 5})
        end
    end
})

MusicTab:CreateButton({
    Name = "⏹ إيقاف كل",
    Callback = function()
        for _, s in pairs(Workspace:GetDescendants()) do if s:IsA("Sound") then s:Destroy() end end
        for _, s in pairs(LocalPlayer.Character:GetDescendants()) do if s:IsA("Sound") then s:Destroy() end end
        Rayfield:Notify({Title = "تم الإيقاف", Duration = 2})
    end
})

-- Tab اللاعبين (قتل + Fly to Sky)
local PlayerTab = Window:CreateTab("👥 لاعبين", 4483362458)

local PlayerDropdown = PlayerTab:CreateDropdown({
    Name = "اختر لاعب",
    Options = {},
    Callback = function(Option)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Name == Option then getgenv().Config.TargetPlayer = plr break end
        end
    end
})

Players.PlayerAdded:Connect(function() PlayerDropdown:Refresh({plr.Name for _, plr in pairs(Players:GetPlayers())}, true) end)
Players.PlayerRemoving:Connect(function() PlayerDropdown:Refresh({plr.Name for _, plr in pairs(Players:GetPlayers())}, true) end)
PlayerDropdown:Refresh({plr.Name for _, plr in pairs(Players:GetPlayers())}, true)

PlayerTab:CreateButton({
    Name = "💀 قتل اللاعب",
    Callback = function()
        if getgenv().Config.TargetPlayer and getgenv().Config.TargetPlayer.Character then
            getgenv().Config.TargetPlayer.Character.Humanoid.Health = 0
            Rayfield:Notify({Title = "قتل!", Content = getgenv().Config.TargetPlayer.Name .. " مات!", Duration = 3})
        end
    end
})

PlayerTab:CreateButton({
    Name = "☁️ رفع للسماء (Noclip + Fly with him)",
    Callback = function()
        if getgenv().Config.TargetPlayer and getgenv().Config.TargetPlayer.Character and LocalPlayer.Character then
            local targetHRP = getgenv().Config.TargetPlayer.Character.HumanoidRootPart
            local myHRP = LocalPlayer.Character.HumanoidRootPart
            -- Noclip for target
            for _, part in pairs(getgenv().Config.TargetPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
            -- Tween to sky
            TweenService:Create(targetHRP, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = myHRP.CFrame * CFrame.new(0, 500, 0)}):Play()
            Rayfield:Notify({Title = "رفع!", Content = getgenv().Config.TargetPlayer.Name .. " طار للسماء معك!", Duration = 4})
        end
    end
})

-- Tab ميزات كثيرة (دخم)
local FeaturesTab = Window:CreateTab("⚡ ميزات", 4483362458)

FeaturesTab:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Noclip = Value
    end
})

FeaturesTab:CreateToggle({
    Name = "🏃 Inf Jump",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfJump = Value
    end
})

FeaturesTab:CreateToggle({
    Name = "🌀 Inf Spin",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfSpin = Value
    end
})

FeaturesTab:CreateToggle({
    Name = "👊 Inf Punch (Hit Infinite)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfPunch = Value
    end
})

FeaturesTab:CreateToggle({
    Name = "✈️ Fly",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Fly = Value
    end
})

FeaturesTab:CreateToggle({
    Name = "🛡️ God Mode",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.GodMode = Value
    end
})

-- Loops دخم
RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
    end
end)

RunService.Heartbeat:Connect(function()
    if getgenv().Config.InfSpin and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
    end
    if getgenv().Config.InfPunch and LocalPlayer.Character then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                plr.Character.Humanoid.Health = plr.Character.Humanoid.Health - 2
            end
        end
    end
    if getgenv().Config.GodMode and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.Health = 100
    end
    if getgenv().Config.Fly and LocalPlayer.Character then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if not hrp:FindFirstChild("FlyVel") then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "FlyVel"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        end
        local vel = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,50,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0,50,0) end
        hrp.FlyVel.Velocity = vel
    end
end)

UserInputService.JumpRequest:Connect(function()
    if getgenv().Config.InfJump then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Rayfield:Notify({
    Title = "V4 جاهز! 🔥",
    Content = "موسيقى FE loop محاولة + ميزات كثيرة + Splash Goku Tattoo Neon",
    Duration = 6
})
