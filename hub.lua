-- ========================================
-- سكريبتك الخاص: Brainrot TP Home Maker
-- روح لبيتك > Save > سرق > TP Home
-- ========================================

-- 1. جيب الخدمات الأساسية (خليها في الأول دايمًا)
local Players = game:GetService("Players")  -- للاعبين
local LocalPlayer = Players.LocalPlayer     -- لعيبك أنت
local RunService = game:GetService("RunService")  -- للـ loops السريعة
local TweenService = game:GetService("TweenService")  -- للتأثيرات الجميلة
local StarterGui = game:GetService("StarterGui")     -- للإشعارات

-- 2. المتغيرات العالمية (getgenv() تحفظها إلى الأبد)
getgenv().HomeCFrame = nil  -- هنا نحفظ موقع البيت
getgenv().NoclipOn = false  -- Noclip مفعل/لا
getgenv().SpeedOn = false   -- Speed مفعل/لا

-- 3. إنشاء الـ GUI (الشاشة الرئيسية)
local ScreenGui = Instance.new("ScreenGui")  -- شاشة جديدة
ScreenGui.Name = "MyBrainrotHub"             -- اسمها
ScreenGui.ResetOnSpawn = false               -- ما تمسحش لما تموت
ScreenGui.Parent = game:GetService("CoreGui") -- ضعها في CoreGui (خفية من اللعبة)

-- الإطار الرئيسي (الصندوق الأسود)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 300)   -- حجم: عرض 350، ارتفاع 300
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)  -- في وسط الشاشة
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)  -- لون أسود غامق
MainFrame.Active = true                      -- يتقدر تسحبه
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- اجعل الزوايا مدورة (جمالي)
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

-- العنوان
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
Title.Text = "🧠 My TP Home HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- 4. دالة لصنع زر (استخدمها كتير عشان توفر وقت)
local function MakeButton(Text, Callback)     -- Text: نص الزر، Callback: إيش يصير لما تضغط
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 50)
    Button.Position = UDim2.new(0.05, 0, 0, 60 + (#MainFrame:GetChildren() * 55))  -- يترتب أسفل بعض
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Button.Text = Text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.Gotham
    Button.Parent = MainFrame
    
    -- زوايا مدورة للزر
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    -- تأثير الضغط (يضيء)
    Button.MouseButton1Click:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(100, 100, 120)  -- يضيء
        wait(0.1)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)     -- يرجع
        Callback()  -- نفذ الدالة
    end)
end

-- 5. الزر الأول: حفظ البيت
MakeButton("💾 Save Home Position", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        getgenv().HomeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame  -- احفظ الموقع
        StarterGui:SetCore("SendNotification", {  -- إشعار
            Title = "تم الحفظ!"; Text = "موقع بيتك محفوظ 🚀"; Duration = 3
        })
    else
        StarterGui:SetCore("SendNotification", {Title = "خطأ"; Text = "روح لبيتك أول!"; Duration = 3})
    end
end)

-- 6. الزر الثاني: نقل فوري
MakeButton("🚀 TP to Home", function()
    if getgenv().HomeCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().HomeCFrame  -- انقل!
        StarterGui:SetCore("SendNotification", {Title = "تم!"; Text = "رجعت لبيتك!"; Duration = 2})
    else
        StarterGui:SetCore("SendNotification", {Title = "خطأ"; Text = "احفظ أول!"; Duration = 3})
    end
end)

-- 7. Noclip (مر من الجدران)
MakeButton("👻 Toggle Noclip", function()
    getgenv().NoclipOn = not getgenv().NoclipOn
    local Status = getgenv().NoclipOn and "مفعل" or "معطل"
    StarterGui:SetCore("SendNotification", {Title = "Noclip"; Text = Status; Duration = 2})
end)

-- 8. Speed (سرعة 50)
MakeButton("🏃 Toggle Speed 50", function()
    getgenv().SpeedOn = not getgenv().SpeedOn
    local Status = getgenv().SpeedOn and "مفعل" or "معطل"
    StarterGui:SetCore("SendNotification", {Title = "Speed"; Text = Status; Duration = 2})
end)

-- زر إغلاق
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- 9. الـ Loops (تشتغل كل ثانية تلقائي)
-- Noclip Loop
RunService.Stepped:Connect(function()  -- كل frame
    if getgenv().NoclipOn and LocalPlayer.Character then
        for _, Part in pairs(LocalPlayer.Character:GetDescendants()) do
            if Part:IsA("BasePart") and Part ~= LocalPlayer.Character.HumanoidRootPart then
                Part.CanCollide = false  -- ما يصطدمش
            end
        end
    end
end)

-- Speed Loop
RunService.Heartbeat:Connect(function()
    if getgenv().SpeedOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50  -- سرعة 50
    end
end)

-- 10. إشعار نهاية
StarterGui:SetCore("SendNotification", {
    Title = "سكريبتك جاهز! 🧠";
    Text = "روح لبيتك > Save > سرق > TP!";
    Duration = 5
})
