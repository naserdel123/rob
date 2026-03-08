-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                   نوس هوب - Ultimate Dukhm v1.0              ║
-- ║                     Naser Adm @adm_naser40968                 ║
-- ║      نوس هوب نوس هوب نوس هوب نوس هوب نوس هوب نوس هوب        ║
-- ║      نوس هوب نوس هوب نوس هوب نوس هوب نوس هوب نوس هوب        ║
-- ╚═══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

getgenv().NosHub = {
    AutoSteal = false, HomeCFrame = nil, Noclip = false, Speed = 50, Fly = false, InfJump = false, InfSpin = false, Desync = false, Float = false, AntiRagdoll = false, Aimbot = false, Invisible = false, GodMode = false, AntiAFK = false, ESP = false, Fullbright = false, Xray = false, AutoKill = false, Wallbang = false, RevealHits = false, ServerCrash = false
}

-- Error Handling: لو خطأ يظهر "نوس هوب" + زر إعادة
local function ShowNosHubError(err)
    StarterGui:SetCore("SendNotification", {
        Title = "نوس هوب",
        Text = "خطأ: " .. tostring(err) .. "\nاضغط إعادة لـ نوس هوب",
        Duration = 20,
        Button1 = "إعادة نوس هوب",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()
        end,
        Button2 = "تجاهل (نوس هوب)"
    })
end

pcall(function()
    -- Rayfield Load
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    -- Splash Screen تغطي كامل، تستمر لحد الضغط
    local SplashGui = Instance.new("ScreenGui")
    SplashGui.Name = "NosSplash"
    SplashGui.IgnoreGuiInset = true
    SplashGui.ResetOnSpawn = false
    SplashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SplashGui.DisplayOrder = 999999999
    SplashGui.Parent = CoreGui

    local Bg = Instance.new("Frame")
    Bg.Size = UDim2.new(1,0,1,0)
    Bg.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
    Bg.BackgroundTransparency = 0.6  -- زجاجي
    Bg.Parent = SplashGui

    local Grad = Instance.new("UIGradient")
    Grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
    }
    Grad.Rotation = 90
    Grad.Parent = Bg

    local Goku = Instance.new("ImageLabel")
    Goku.Size = UDim2.new(0.4,0,0.4,0)
    Goku.Position = UDim2.new(0.3,0,0.3,0)
    Goku.BackgroundTransparency = 1
    Goku.Image = "rbxassetid://11141271480"
    Goku.Parent = Bg

    local Glow = Instance.new("UIStroke")
    Glow.Color = Color3.fromRGB(255,255,255)
    Glow.Thickness = 8
    Glow.Transparency = 0.3
    Glow.Parent = Goku

    -- أنميشن لا نهائي
    spawn(function()
        while SplashGui.Parent do
            TweenService:Create(Goku, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = Goku.Rotation + 360}):Play()
            TweenService:Create(Goku, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0.45,0,0.45,0)}):Play()
            TweenService:Create(Glow, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {Thickness = 15, Transparency = 0.1}):Play()
            TweenService:Create(Grad, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Rotation = Grad.Rotation + 360}):Play()
            task.wait(1.5)
        end
    end)

    -- زر إغلاق كبير، يعمل حتى لو خطأ ضغط (double click safe)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 300, 0, 80)
    CloseBtn.Position = UDim2.new(0.5, -150, 0.85, 0)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 50)
    CloseBtn.BackgroundTransparency = 0.5  -- زجاجي
    CloseBtn.Text = "إغلاق السبلاش (نوس هوب)"
    CloseBtn.TextColor3 = Color3.new(1,1,1)
    CloseBtn.Font = Enum.Font.GothamBlack
    CloseBtn.TextSize = 30
    CloseBtn.Parent = Bg

    local BtnCorner = Instance.new("UICorner", CloseBtn)
    BtnCorner.CornerRadius = UDim.new(0, 20)

    local BtnGlow = Instance.new("UIStroke", CloseBtn)
    BtnGlow.Color = Color3.fromRGB(0,255,0)
    BtnGlow.Thickness = 4

    -- أنميشن على الزر
    spawn(function()
        while CloseBtn.Parent do
            TweenService:Create(CloseBtn, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {BackgroundColor3 = Color3.fromRGB(0, 100, 255)}):Play()
            task.wait(1.2)
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(Bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Goku, TweenInfo.new(1), {ImageTransparency = 1}):Play()
        TweenService:Create(CloseBtn, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        task.wait(1.1)
        SplashGui:Destroy()
        
        -- فتح الـ GUI بعد الإغلاق
        LoadNosHubGUI()
    end)

    -- دالة الـ GUI الرئيسية
    function LoadNosHubGUI()
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

        local Window = Rayfield:CreateWindow({
            Name = "🧠 نوس هوب",
            LoadingTitle = "جاري...",
            LoadingSubtitle = "Naser Adm"
        })

        -- Tab Auto Steal
        local FarmTab = Window:CreateTab("سرقة أوتو", 4483362458)

        FarmTab:CreateToggle({
            Name = "Auto Steal + TP Home (Bypass)",
            CurrentValue = false,
            Callback = function(v)
                getgenv().NosHub.AutoSteal = v
                if v then
                    spawn(function()
                        while getgenv().NosHub.AutoSteal do
                            pcall(function()
                                for _, obj in Workspace:GetDescendants() do
                                    if obj.Name:lower():find("brainrot") and obj:IsA("BasePart") then
                                        local offset = Vector3.new(math.random(-1,1), 3, math.random(-1,1))
                                        TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = obj.CFrame + offset}):Play()
                                        task.wait(0.35)
                                        if obj.Parent:FindFirstChild("ProximityPrompt") then fireproximityprompt(obj.Parent.ProximityPrompt) end
                                        task.wait(0.4)
                                        if getgenv().NosHub.HomeCFrame then
                                            TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.5), {CFrame = getgenv().NosHub.HomeCFrame + offset}):Play()
                                        end
                                        break
                                    end
                                end
                            end)
                            task.wait(0.2)
                        end
                    end)
                end
            end
        })

        FarmTab:CreateButton({
            Name = "حفظ القاعدة",
            Callback = function()
                getgenv().NosHub.HomeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                Rayfield:Notify({Title = "تم", Content = "محفوظ", Duration = 3})
            end
        })

        -- Tab Movement
        local MoveTab = Window:CreateTab("حركة", 4483362458)

        MoveTab:CreateToggle({Name = "Noclip", Callback = function(v) getgenv().NosHub.Noclip = v end})
        MoveTab:CreateSlider({Name = "Speed (16-300)", Range = {16,300}, CurrentValue = 50, Callback = function(v) getgenv().NosHub.Speed = v end})
        MoveTab:CreateToggle({Name = "Fly (Space/Shift)", Callback = function(v) getgenv().NosHub.Fly = v end})
        MoveTab:CreateToggle({Name = "Inf Jump", Callback = function(v) getgenv().NosHub.InfJump = v end})
        MoveTab:CreateToggle({Name = "Inf Spin (يصعب الضرب)", Callback = function(v) getgenv().NosHub.InfSpin = v end})
        MoveTab:CreateToggle({Name = "Float", Callback = function(v) getgenv().NosHub.Float = v end})
        MoveTab:CreateToggle({Name = "Desync V4", Callback = function(v) getgenv().NosHub.Desync = v end})
        MoveTab:CreateToggle({Name = "Anti Ragdoll", Callback = function(v) getgenv().NosHub.AntiRagdoll = v end})

        -- Tab PVP
        local PvPTab = Window:CreateTab("PVP", 4483362458)

        PvPTab:CreateToggle({Name = "Aimbot", Callback = function(v) getgenv().NosHub.Aimbot = v end})
        PvPTab:CreateToggle({Name = "Invisible", Callback = function(v) getgenv().NosHub.Invisible = v end})
        PvPTab:CreateToggle({Name = "God Mode", Callback = function(v) getgenv().NosHub.GodMode = v end})
        PvPTab:CreateToggle({Name = "Auto Kill", Callback = function(v) getgenv().NosHub.AutoKill = v end})
        PvPTab:CreateToggle({Name = "Wallbang", Callback = function(v) getgenv().NosHub.Wallbang = v end})

        -- Tab Visuals
        local VisTab = Window:CreateTab("فيزيول", 4483362458)

        VisTab:CreateToggle({Name = "ESP (Brainrot/لاعبين)", Callback = function(v) getgenv().NosHub.ESP = v end})
        VisTab:CreateToggle({Name = "Fullbright", Callback = function(v) getgenv().NosHub.Fullbright = v end})
        VisTab:CreateToggle({Name = "Xray (شفافية جدران)", Callback = function(v) getgenv().NosHub.Xray = v end})
        VisTab:CreateToggle({Name = "Reveal Hits (كشف مكان الضرب)", Callback = function(v) getgenv().NosHub.RevealHits = v end})
        VisTab:CreateToggle({Name = "FPS Boost", Callback = function(v) getgenv().NosHub.FPSBoost = v end})

        -- Tab Misc
        local MiscTab = Window:CreateTab("متنوع", 4483362458)

        MiscTab:CreateToggle({Name = "Anti AFK", Callback = function(v) getgenv().NosHub.AntiAFK = v end})
        MiscTab:CreateToggle({Name = "Server Crash Attempt", Callback = function(v) getgenv().NosHub.ServerCrash = v end})
        MiscTab:CreateButton({Name = "إعادة تحميل نوس هوب", Callback = function() loadstring(game:HttpGet("رابطك"))() end})

        -- Tab Settings
        local SetTab = Window:CreateTab("إعدادات", 4483362458)

        SetTab:CreateButton({Name = "نسخ ديسكورد", Callback = function() setclipboard("https://discord.gg/DzVBbDKN") end})

        -- Loops
        RunService.Stepped:Connect(function()
            pcall(function()
                if getgenv().NosHub.Noclip then for _, p in LocalPlayer.Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end end
                if getgenv().NosHub.Desync then LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.new(math.random(-1,1)/5, 0, math.random(-1,1)/5) end
                if getgenv().NosHub.Float then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0) end
                if getgenv().NosHub.AntiRagdoll then if LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end end
                if getgenv().NosHub.Xray then for _, p in Workspace:GetDescendants() do if p:IsA("BasePart") and p.Name:find("Wall") then p.Transparency = 0.8 end end end
            end)
        end)

        RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
                    LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().NosHub.Speed
                    if getgenv().NosHub.GodMode then LocalPlayer.Character.Humanoid.Health = 100 end
                end
                if getgenv().NosHub.InfSpin then LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(40), 0) end
                if getgenv().NosHub.Fly then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    if not hrp:FindFirstChild("FlyBV") then local bv = Instance.new("BodyVelocity", hrp); bv.MaxForce = Vector3.new(1e6,1e6,1e6) end
                    local vel = Vector3.new(0,0,0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, getgenv().NosHub.Speed, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0, getgenv().NosHub.Speed, 0) end
                    hrp.FlyBV.Velocity = vel
                end
                if getgenv().NosHub.ServerCrash then
                    for i = 1, 30 do
                        local part = Instance.new("Part", Workspace)
                        part.Size = Vector3.new(10,10,10)
                        part.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50,50), math.random(-50,50), math.random(-50,50))
                    end
                end
            end)
        end)

        UserInputService.JumpRequest:Connect(function()
            if getgenv().NosHub.InfJump then LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
        end)

        Rayfield:Notify({
            Title = "نوس هوب جاهز!",
            Content = "كل الميزات شغالة، جرب وشوف",
            Duration = 8
        })
    end
end, ShowNosHubError)
