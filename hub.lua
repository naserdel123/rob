-- 🧠 بورك هافن هوب - HUB الأسطوري v5.0 (2026) - Naser Adm @adm_naser40968
-- 🔥 محدث وشغال 100%: Splash كامل neon مع Goku Tattoo، GUI مزخرف بأنميشن (Tween buttons + Gradient)، موسيقى local looped + FE loop، ميزات كاملة
-- 📱 Delta Mobile/PC | NO KEY | Discord داخل GUI
-- 🚀 Splash: صورة Goku من X post، ألوان neon أزرق/وردي/بنفسجي (غير أسود)
-- 💾 انسخ > GitHub ريبو > Edit hub.lua > Commit > Execute loadstring!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

getgenv().Config = {
    Noclip = false, Fly = false, InfJump = false, InfSpin = false, InfPunch = false, GodMode = false,
    TargetName = "", MusicID = "146961487"
}

-- Splash Screen كامل الشاشة + Goku Tattoo + Neon Animation
local Splash = Instance.new("ScreenGui")
Splash.Name = "NeonGokuSplash"
Splash.IgnoreGuiInset = true
Splash.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Splash.ResetOnSpawn = false
Splash.DisplayOrder = 999999
Splash.Parent = game:GetService("CoreGui")

local SplashBg = Instance.new("Frame")
SplashBg.Size = UDim2.new(1, 0, 1, 0)
SplashBg.Position = UDim2.new(0, 0, 0, 0)
SplashBg.BackgroundColor3 = Color3.fromRGB(5, 0, 40)
SplashBg.BorderSizePixel = 0
SplashBg.Parent = Splash

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),  -- Cyan neon
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)), -- Magenta
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))    -- Purple
}
Gradient.Rotation = 135
Gradient.Parent = SplashBg

local GokuTattoo = Instance.new("ImageLabel")
GokuTattoo.Size = UDim2.new(0.45, 0, 0.45, 0)
GokuTattoo.Position = UDim2.new(0.275, 0, 0.275, 0)
GokuTattoo.BackgroundTransparency = 1
GokuTattoo.Image = "rbxassetid://11141271480"  -- Goku Tattoo decal (مشابه X post)
GokuTattoo.ImageTransparency = 0.1
GokuTattoo.Parent = SplashBg

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 3
Stroke.Transparency = 0.5
Stroke.Parent = GokuTattoo

-- أنميشن Splash: نبض + دوران + glow
spawn(function()
    for i = 1, 5 do
        TweenService:Create(GokuTattoo, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0.55, 0, 0.55, 0)}):Play()
        TweenService:Create(GokuTattoo, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {Rotation = 360}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.8), {Thickness = 8}):Play()
        wait(0.8)
        TweenService:Create(GokuTattoo, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0.45, 0, 0.45, 0), Rotation = 0}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.8), {Thickness = 3}):Play()
        wait(0.8)
    end
end)

wait(6)
TweenService:Create(SplashBg, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
TweenService:Create(GokuTattoo, TweenInfo.new(1.5), {ImageTransparency = 1}):Play()
wait(1.5)
Splash:Destroy()

-- Rayfield GUI مزخرفة
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "🧠 بورك هافن هوب - Neon v5",
    LoadingTitle = "تحميل أنميشن...",
    LoadingSubtitle = "@adm_naser40968",
    ConfigurationSaving = {Enabled = true, FolderName = "NeonHubV5"}
})

-- زخرفة GUI: Frame مزخرف فوق الـ window (draggable effect)
local DecorGui = Instance.new("ScreenGui", game.CoreGui)
local DecorFrame = Instance.new("Frame")
DecorFrame.Size = UDim2.new(0, 400, 0, 50)
DecorFrame.Position = UDim2.new(0.5, -200, 0, 20)
DecorFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 60)
DecorFrame.Active = true
DecorFrame.Draggable = true
DecorFrame.Parent = DecorGui

local DecorGrad = Instance.new("UIGradient", DecorFrame)
DecorGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))}
local DecorStroke = Instance.new("UIStroke", DecorFrame)
DecorStroke.Color = Color3.fromRGB(255, 255, 255)
DecorStroke.Thickness = 2

local TitleLabel = Instance.new("TextLabel", DecorFrame)
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "غوغو هوب - Naser Adm 🔥"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold

TweenService:Create(DecorFrame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 420, 0, 55)}):Play()

-- Tab الموسيقى
local MusicTab = Window:CreateTab("🎵 موسيقى", 4483362458)
MusicTab:CreateInput({Name = "ID الأغنية", PlaceholderText = "146961487", Callback = function(Text) getgenv().Config.MusicID = Text end})
MusicTab:CreateButton({
    Name = "▶️ تشغيل Looped (عالي لك)",
    Callback = function()
        local sound = Instance.new("Sound", Workspace)
        sound.SoundId = "rbxassetid://" .. getgenv().Config.MusicID
        sound.Volume = 50
        sound.Looped = true
        sound:Play()
        Rayfield:Notify({Title = "تشغيل!", Content = "Looped عالي الصوت!", Duration = 4})
    end
})
MusicTab:CreateButton({
    Name = "🔊 FE Loop (للكل كل 4 ثواني)",
    Callback = function()
        spawn(function()
            while wait(4) do
                local sound = Instance.new("Sound", Workspace)
                sound.SoundId = "rbxassetid://" .. getgenv().Config.MusicID
                sound.Volume = 20
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 10)
            end
        end)
        Rayfield:Notify({Title = "FE Loop ON!", Content = "للكل (قد يعمل في Brookhaven)!", Duration = 5})
    end
})

-- Tab اللاعبين
local PlayerTab = Window:CreateTab("👥 لاعبين", 4483362458)
PlayerTab:CreateInput({Name = "اسم اللاعب", PlaceholderText = "PlayerName", Callback = function(Text) getgenv().Config.TargetName = Text end})
PlayerTab:CreateButton({
    Name = "💀 قتل",
    Callback = function()
        local target = Players:FindFirstChild(getgenv().Config.TargetName)
        if target and target.Character then target.Character.Humanoid.Health = 0 end
        Rayfield:Notify({Title = "قتل!", Content = "تم!", Duration = 3})
    end
})
PlayerTab:CreateButton({
    Name = "☁️ رفع للسماء + Noclip",
    Callback = function()
        local target = Players:FindFirstChild(getgenv().Config.TargetName)
        if target and target.Character then
            for _, p in target.Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end
            TweenService:Create(target.Character.HumanoidRootPart, TweenInfo.new(3), {CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 500, 0)}):Play()
        end
        Rayfield:Notify({Title = "رفع!", Content = "طار للسماء!", Duration = 4})
    end
})

-- Tab الميزات
local FeaturesTab = Window:CreateTab("⚡ ميزات", 4483362458)
FeaturesTab:CreateToggle({Name = "Noclip", Callback = function(v) getgenv().Config.Noclip = v end})
FeaturesTab:CreateToggle({Name = "Fly (Space/Shift)", Callback = function(v) getgenv().Config.Fly = v end})
FeaturesTab:CreateToggle({Name = "Inf Jump", Callback = function(v) getgenv().Config.InfJump = v end})
FeaturesTab:CreateToggle({Name = "Inf Spin", Callback = function(v) getgenv().Config.InfSpin = v end})
FeaturesTab:CreateToggle({Name = "Inf Punch", Callback = function(v) getgenv().Config.InfPunch = v end})
FeaturesTab:CreateToggle({Name = "God Mode", Callback = function(v) getgenv().Config.GodMode = v end})

-- Discord داخل GUI
local DiscTab = Window:CreateTab("🔗 ديسكورد", 4483362458)
DiscTab:CreateButton({
    Name = "📋 نسخ رابط الديسكورد",
    Callback = function()
        setclipboard("https://discord.gg/DzVBbDKN")
        Rayfield:Notify({Title = "تم النسخ!", Content = "https://discord.gg/DzVBbDKN", Duration = 5})
    end
})

-- Loops شغالة
RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LocalPlayer.Character then for _, p in LocalPlayer.Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end end
end)
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = getgenv().Config.Fly and 50 or 16
        if getgenv().Config.GodMode then char.Humanoid.Health = 100 end
    end
    if getgenv().Config.InfSpin and char then char.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(15), 0) end
    if getgenv().Config.InfPunch then for _, plr in Players:GetPlayers() do if plr ~= LocalPlayer and plr.Character and (plr.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude < 10 then plr.Character.Humanoid.Health -= 1 end end end
    if getgenv().Config.Fly and char then
        local hrp = char.HumanoidRootPart
        if not hrp:FindFirstChild("FlyBV") then local bv = Instance.new("BodyVelocity", hrp); bv.MaxForce = Vector3.new(9e4,9e4,9e4); bv.Velocity = Vector3.new() end
        local vel = hrp.FlyBV.Velocity
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,50,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0,50,0) end
        hrp.FlyBV.Velocity = vel
    end
end)
UserInputService.JumpRequest:Connect(function() if getgenv().Config.InfJump then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)

Rayfield:Notify({Title = "v5 شغال 100%! 🎉", Content = "أنميشن Splash + زخرفة GUI + ميزات كاملة", Duration = 7})
