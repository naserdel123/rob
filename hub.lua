local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ==========================================
-- 1. إعداد شاشة البداية (Splash Screen)
-- ==========================================
local splashGui = Instance.new("ScreenGui")
splashGui.Name = "NosHubSplash"
-- تجنب تداخل واجهة Roblox العلوية
splashGui.IgnoreGuiInset = true 

-- استخدام CoreGui أو PlayerGui بناءً على بيئة الاختبار
if RunService:IsStudio() then
    splashGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
else
    -- في حالة استخدام بيئات أخرى تدعم CoreGui
    local success, err = pcall(function() splashGui.Parent = CoreGui end)
    if not success then splashGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end
end

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
background.BackgroundTransparency = 0.2
background.Parent = splashGui

-- إنشاء تأثير زجاجي متدرج (أخضر إلى أزرق)
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
}
gradient.Rotation = 45
gradient.Parent = background

local gokuImage = Instance.new("ImageLabel")
gokuImage.Size = UDim2.new(0, 300, 0, 300)
gokuImage.Position = UDim2.new(0.5, -150, 0.5, -180)
gokuImage.BackgroundTransparency = 1
gokuImage.Image = "rbxassetid://11141271480" -- صورة Goku المطلوبة
gokuImage.Parent = background

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 250, 0, 60)
closeButton.Position = UDim2.new(0.5, -125, 0.8, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(15, 35, 35)
closeButton.BackgroundTransparency = 0.4
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 22
closeButton.Text = "إغلاق السبلاش وفتح الهب"
closeButton.Parent = background

-- إضافة تأثيرات (Animations)
-- 1. تأثير النبض للصورة (Glow / Breathing)
local pulseInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local pulseTween = TweenService:Create(gokuImage, pulseInfo, {
    Size = UDim2.new(0, 340, 0, 340),
    Position = UDim2.new(0.5, -170, 0.5, -200)
})
pulseTween:Play()

-- 2. تأثير الدوران المستمر للصورة
local rotationConnection = RunService.RenderStepped:Connect(function()
    gokuImage.Rotation = gokuImage.Rotation + 0.3
end)

-- 3. تأثير الـ Hover للزر
closeButton.MouseEnter:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 150)}):Play()
end)
closeButton.MouseLeave:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 35, 35)}):Play()
end)

-- ==========================================
-- 2. إعداد واجهة Rayfield الرئيسية
-- ==========================================
closeButton.MouseButton1Click:Connect(function()
    -- إيقاف الأنميشن وإزالة السبلاش سكرين
    rotationConnection:Disconnect()
    pulseTween:Cancel()
    splashGui:Destroy()

    -- تحميل مكتبة Rayfield
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Nos Hub | نوس هوب",
        LoadingTitle = "جاري تحميل واجهة Nos Hub...",
        LoadingSubtitle = "by Naser Adm",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "NosHub",
            FileName = "NosHubConfig"
        },
        Discord = {
            Enabled = true,
            Invite = "DzVBbDKN", -- رابط الديسكورد المطلوب
            RememberJoins = true 
        },
        KeySystem = false -- بدون نظام مفاتيح كما طلبت
    })

    -- إنشاء التبويبات (Tabs)
    local Tab1 = Window:CreateTab("سرقة أوتو", 4483362458)
    local Tab2 = Window:CreateTab("حركة", 4483362458)
    local Tab3 = Window:CreateTab("PVP", 4483362458)
    local Tab4 = Window:CreateTab("فيزيول", 4483362458)
    local Tab5 = Window:CreateTab("متنوع", 4483362458)
    local Tab6 = Window:CreateTab("إعدادات", 4483362458)

    -- أمثلة على عناصر الواجهة لتوضيح الهيكل:
    Tab2:CreateSlider({
        Name = "Speed Slider (UI Only)",
        Range = {16, 300},
        Increment = 1,
        Suffix = "WalkSpeed",
        CurrentValue = 16,
        Flag = "SpeedSlider",
        Callback = function(Value)
            -- سيتم تنفيذ الكود هنا عند تغيير السلايدر
            print("تم تغيير السرعة في الواجهة إلى: ", Value)
        end,
    })

    Tab5:CreateButton({
        Name = "إعادة تحميل نوس هوب",
        Callback = function()
            Rayfield:Destroy()
            print("تم إغلاق الواجهة.")
        end,
    })

    Tab6:CreateButton({
        Name = "نسخ رابط ديسكورد",
        Callback = function()
            if setclipboard then
                setclipboard("https://discord.gg/DzVBbDKN")
                Rayfield:Notify({
                    Title = "تم النسخ",
                    Content = "تم نسخ رابط الديسكورد إلى الحافظة!",
                    Duration = 3,
                    Image = 4483362458,
                })
            else
                print("رابط الديسكورد: https://discord.gg/DzVBbDKN")
            end
        end,
    })

    -- الإشعار النهائي عند اكتمال التحميل
    Rayfield:Notify({
        Title = "نجاح",
        Content = "نوس هوب جاهز! - Naser Adm",
        Duration = 5,
        Image = 4483362458,
    })
end)
