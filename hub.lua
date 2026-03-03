-- ╔═══════════════════════════════════════════════════════════════╗
-- ║               GOGO HUB v6.3 - Splash مستمر إلى الأبد       ║
-- ║                     Naser Adm @adm_naser40968                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- انتظر الشخصية
if not LocalPlayer.Character then LocalPlayer.CharacterAdded:Wait() end

-- // SPLASH SCREEN مستمر حتى تضغط إغلاق //
local SplashGui = Instance.new("ScreenGui")
SplashGui.Name = "GogoSplashV6_3"
SplashGui.IgnoreGuiInset = true
SplashGui.ResetOnSpawn = false
SplashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SplashGui.DisplayOrder = 999999999  -- أعلى قيمة
SplashGui.Parent = CoreGui

local Bg = Instance.new("Frame")
Bg.Size = UDim2.new(1,0,1,0)
Bg.BackgroundColor3 = Color3.fromRGB(8, 0, 40)
Bg.Parent = SplashGui

local Grad = Instance.new("UIGradient")
Grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200))
}
Grad.Rotation = 90
Grad.Parent = Bg

local Goku = Instance.new("ImageLabel")
Goku.Size = UDim2.new(0.4,0,0.4,0)
Goku.Position = UDim2.new(0.3,0,0.3,0)
Goku.BackgroundTransparency = 1
Goku.Image = "rbxassetid://11141271480"  -- Goku Tattoo
Goku.Parent = Bg

local Glow = Instance.new("UIStroke")
Glow.Color = Color3.fromRGB(255,255,255)
Glow.Thickness = 8
Glow.Transparency = 0.3
Glow.Parent = Goku

-- أنميشن لا نهائي قوي
spawn(function()
    while SplashGui.Parent do
        -- دوران مستمر
        TweenService:Create(Goku, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = Goku.Rotation + 360}):Play()
        
        -- نبض كبير
        TweenService:Create(Goku, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Size = UDim2.new(0.45,0,0.45,0)
        }):Play()
        
        -- Glow يتنفس
        TweenService:Create(Glow, TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
            Thickness = 16, Transparency = 0.1
        }):Play()
        
        -- تغيير لون خفيف
        TweenService:Create(Grad, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = Grad.Rotation + 360
        }):Play()
        
        task.wait(1.5)
    end
end)

-- زر إغلاق كبير وواضح
local CloseSplash = Instance.new("TextButton")
CloseSplash.Size = UDim2.new(0, 280, 0, 80)
CloseSplash.Position = UDim2.new(0.5, -140, 0.85, 0)
CloseSplash.BackgroundColor3 = Color3.fromRGB(200, 0, 255)
CloseSplash.Text = "إغلاق السبلاش وفتح الـ HUB"
CloseSplash.TextColor3 = Color3.new(1,1,1)
CloseSplash.Font = Enum.Font.GothamBlack
CloseSplash.TextSize = 28
CloseSplash.Parent = Bg

local Corner = Instance.new("UICorner", CloseSplash)
Corner.CornerRadius = UDim.new(0, 20)

local BtnGlow = Instance.new("UIStroke", CloseSplash)
BtnGlow.Color = Color3.fromRGB(255,255,255)
BtnGlow.Thickness = 4

-- أنميشن على الزر
spawn(function()
    while CloseSplash.Parent do
        TweenService:Create(CloseSplash, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
            BackgroundColor3 = Color3.fromRGB(255, 0, 200)
        }):Play()
        task.wait(1.2)
    end
end)

CloseSplash.MouseButton1Click:Connect(function()
    TweenService:Create(Bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Goku, TweenInfo.new(1), {ImageTransparency = 1}):Play()
    TweenService:Create(CloseSplash, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    task.wait(1.1)
    SplashGui:Destroy()
    
    -- بعد الإغلاق → افتح الـ GUI
    LoadMainHub()
end)

-- // دالة تحميل الـ Main GUI بعد إغلاق السplash //
function LoadMainHub()
    local Rayfield
    local success, err = pcall(function()
        Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    
    if not success or not Rayfield then
        warn("Rayfield فشل: " .. tostring(err))
        StarterGui:SetCore("SendNotification", {Title = "خطأ", Text = "فشل الواجهة، جرب executor آخر", Duration = 10})
        return
    end
    
    local Window = Rayfield:CreateWindow({
        Name = "GOGO HUB - بعد السplash",
        LoadingTitle = "جاري الفتح...",
        LoadingSubtitle = "Naser Adm",
        ConfigurationSaving = {Enabled = true, FolderName = "GogoPersistent"}
    })
    
    -- تبويب اختبار سريع
    local TestTab = Window:CreateTab("اختبار")
    TestTab:CreateLabel("الحمد لله السplash اختفى والـ HUB فتح!")
    TestTab:CreateButton({
        Name = "إشعار نجاح",
        Callback = function()
            Rayfield:Notify({Title = "نجح!", Content = "كل شيء شغال دلوقتي", Duration = 5})
        end
    })
    
    local DiscordTab = Window:CreateTab("ديسكورد")
    DiscordTab:CreateButton({
        Name = "نسخ رابط الديسكورد",
        Callback = function()
            setclipboard("https://discord.gg/DzVBbDKN")
            Rayfield:Notify({Title = "تم!", Content = "الرابط في الحافظة", Duration = 4})
        end
    })
    
    Rayfield:Notify({
        Title = "GOGO HUB جاهز!",
        Content = "Splash استمر لحد ما ضغطت إغلاق، استخدم الـ GUI الآن",
        Duration = 10
    })
end

-- إشعار بداية
StarterGui:SetCore("SendNotification", {
    Title = "GOGO HUB v6.3",
    Text = "Splash مستمر لحد ما تضغط الزر الأزرق تحت، انتظر أو اضغط إغلاق",
    Duration = 15
})
