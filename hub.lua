-- 🧠 STEAL A BRAINROT KURD HUB COPY v3.0 (MOBILE OPTIMIZED 2026) - BY NASER ADM
-- 🔥 نسخة كاملة من Kurd Hub: Auto Steal, Desync/Anti Hit, Float, Player/Brainrot ESP, Inf Jump, Anti Ragdoll, Run Speed, Aimbot, Smooth TP Home, Fly, Noclip, God Mode, Anti-AFK
-- 📱 Mobile Friendly: GUI أصغر, Loops أقل, No Lag (تجنب animations كثيرة, ESP optimized), يشتغل Delta Mobile/Arceus X
-- 🚀 ميزات Kurd Hub: Desync V4, PVP Aimbot, Auto Grab, Anti Hit, Invisible, Path Walk (Tween), 120 FPS Boost (reduce graphics)
-- 💾 انسخ > Edit hub.lua في ريبوك > Commit > Execute loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local isMobile = UserInputService.TouchEnabled  -- Detect Mobile for optimization

-- متغيرات (Mobile: أقل loops frequency)
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
    AntiAFK = true,
    Desync = false,  -- Kurd: Desync/Anti Hit
    Float = false,   -- Kurd: Float
    AntiRagdoll = false,  -- Kurd: Anti Ragdoll
    Aimbot = false,  -- Kurd: Aimbot PVP
    Invisible = false,  -- Kurd: Invisible
    FPSBoost = false,  -- Kurd: 120 FPS (reduce graphics)
    LoopDelay = isMobile and 0.2 or 0.05  -- Slower loops on mobile to reduce lag
}

-- Rayfield GUI (Mobile: Smaller window, less tabs)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧠 Kurd Hub Copy - Mobile No Lag",
    LoadingTitle = "Loading No Lag Version...",
    LoadingSubtitle = "by Naser Adm @adm_naser40968",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KurdHubMobile",
        FileName = "naserdel123"
    }
})

-- Tab 1: Teleport & Home (Kurd TP)
local TeleportTab = Window:CreateTab("🚀 TP & Home", 4483362458)

TeleportTab:CreateButton({
    Name = "💾 Save Home (No Lag)",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            getgenv().Config.HomeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({Title = "Saved! 🏠", Content = "Home position saved", Duration = 2})
        end
    end
})

TeleportTab:CreateButton({
    Name = "⚡ TP to Home (Smooth Path Walk)",
    Callback = function()
        if getgenv().Config.HomeCFrame then
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)  -- Smooth no lag
            TweenService:Create(LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = getgenv().Config.HomeCFrame}):Play()
            Rayfield:Notify({Title = "TP Done! 🚀", Content = "Back home", Duration = 2})
        end
    end
})

-- Tab 2: Auto Farm (Kurd Auto Steal/Grab)
local FarmTab = Window:CreateTab("🤖 Auto Farm", 4483362458)

FarmTab:CreateToggle({
    Name = "Auto Steal + TP Home (Anti Hit)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.AutoSteal = Value
        if Value then Rayfield:Notify({Title = "Auto ON", Content = "Stealing & TP auto", Duration = 2}) end
    end
})

spawn(function()
    while true do
        wait(getgenv().Config.LoopDelay)  -- Mobile optimized delay
        if getgenv().Config.AutoSteal and LocalPlayer.Character then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("brainrot") and (obj:IsA("BasePart") or obj:FindFirstChild("ProximityPrompt")) then
                    -- Smooth TP to obj (Path Walk)
                    TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = obj.CFrame + Vector3.new(0,3,0)}):Play()
                    wait(0.3)
                    if obj:FindFirstChild("ProximityPrompt") then fireproximityprompt(obj.ProximityPrompt) end
                    wait(0.5)
                    -- TP Home
                    if getgenv().Config.HomeCFrame then
                        TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.5), {CFrame = getgenv().Config.HomeCFrame}):Play()
                    end
                    break
                end
            end
        end
    end
end)

-- Tab 3: Movement (Kurd Speed, Float, Inf Jump, Noclip, Fly)
local MovementTab = Window:CreateTab("🏃 Movement", 4483362458)

MovementTab:CreateSlider({
    Name = "Run Speed (Kurd 120+)",
    Range = {16, 200},
    CurrentValue = 16,
    Callback = function(Value)
        getgenv().Config.Speed = Value
    end
})

MovementTab:CreateToggle({
    Name = "Float (Kurd Hover)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Float = Value
    end
})

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Noclip = Value
    end
})

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Fly = Value
    end
})

MovementTab:CreateToggle({
    Name = "Inf Jump",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.InfJump = Value
    end
})

MovementTab:CreateToggle({
    Name = "Anti Ragdoll",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.AntiRagdoll = Value
    end
})

-- Tab 4: PVP & Desync (Kurd Desync V4, Aimbot, Anti Hit)
local PVPTab = Window:CreateTab("⚔️ PVP", 4483362458)

PVPTab:CreateToggle({
    Name = "Desync/Anti Hit V4",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Desync = Value
    end
})

PVPTab:CreateToggle({
    Name = "Aimbot (Silent Aim)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Aimbot = Value
    end
})

PVPTab:CreateToggle({
    Name = "Invisible",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.Invisible = Value
        if Value and LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Transparency = 1  -- Simple invisible
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = 1 end end
        else
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = 0 end end
        end
    end
})

-- Tab 5: Visuals & Misc (Kurd ESP, God, FPS Boost, Anti AFK)
local MiscTab = Window:CreateTab("👁️ Misc", 4483362458)

MiscTab:CreateToggle({
    Name = "Player/Brainrot ESP",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.ESP = Value
    end
})

MiscTab:CreateToggle({
    Name = "God Mode (No Damage)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.GodMode = Value
    end
})

MiscTab:CreateToggle({
    Name = "FPS Boost (120+ Reduce Graphics)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().Config.FPSBoost = Value
        if Value then
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            game:GetService("RunService"):Set3dRenderingEnabled(not isMobile)  -- Less 3D on mobile
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
    end
})

MiscTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = true,
    Callback = function(Value)
        getgenv().Config.AntiAFK = Value
    end
})

-- Optimized Loops (Mobile: Slower, less operations)
RunService.Stepped:Connect(function()
    if getgenv().Config.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    if getgenv().Config.Desync and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-1,1), 0, math.random(-1,1))  -- Simple Desync
    end
    if getgenv().Config.Float and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1, 0)  -- Hover float
    end
    if getgenv().Config.AntiRagdoll and LocalPlayer.Character then
        if LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Config.Speed
        if getgenv().Config.GodMode then LocalPlayer.Character.Humanoid.Health = 100 end
    end
    if getgenv().Config.Fly and LocalPlayer.Character then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        if not HRP:FindFirstChild("FlyBV") then
            local BV = Instance.new("BodyVelocity", HRP)
            BV.Name = "FlyBV"
            BV.MaxForce = Vector3.new(1e4, 1e4, 1e4)
        end
        local dir = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, getgenv().Config.FlySpeed, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir + Vector3.new(0, -getgenv().Config.FlySpeed, 0) end
        HRP.FlyBV.Velocity = dir
    end
end)

-- Inf Jump
UserInputService.JumpRequest:Connect(function()
    if getgenv().Config.InfJump then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- ESP Optimized (Only update every delay)
spawn(function()
    while true do
        wait(getgenv().Config.LoopDelay)
        if getgenv().Config.ESP then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    if not plr.Character:FindFirstChild("ESP") then
                        local hl = Instance.new("Highlight", plr.Character)
                        hl.Name = "ESP"
                        hl.FillColor = Color3.new(0,1,0)
                        hl.OutlineColor = Color3.new(1,0,0)
                    end
                end
            end
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("brainrot") and obj:IsA("BasePart") then
                    if not obj:FindFirstChild("ESP") then
                        local hl = Instance.new("Highlight", obj)
                        hl.Name = "ESP"
                        hl.FillColor = Color3.new(1,0,0)
                        hl.OutlineColor = Color3.new(1,1,0)
                    end
                end
            end
        end
    end
end)

-- Aimbot (Simple Silent Aim for PVP)
spawn(function()
    while true do
        wait(0.1)
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
                -- Aim at head (adjust camera or tool)
                workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
            end
        end
    end
end)

-- Anti-AFK
if getgenv().Config.AntiAFK then
    spawn(function()
        while wait(30) do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

Rayfield:Notify({
    Title = "Kurd Hub Mobile Loaded! 🔥",
    Content = "نسخة Kurd Hub للجوال بدون لاغ - Save Home ثم Auto Steal ON",
    Duration = 5
})
