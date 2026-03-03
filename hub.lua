-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    GOGO HUB - Ultimate v6.1                   ║
-- ║                     Fixed by Grok for Naser Adm               ║
-- ╚═══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Wait character
LocalPlayer.CharacterAdded:Wait()

-- // SPLASH SCREEN FIXED (CoreGui + Clean) //
local function CreateSplash()
    local sg = Instance.new("ScreenGui")
    sg.Name = "GogoSplashFixed"
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 999999
    sg.Parent = CoreGui  -- مهم جدًا!

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(8, 0, 35)
    bg.Parent = sg

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,180,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180,0,255))
    }
    grad.Rotation = 135
    grad.Parent = bg

    local goku = Instance.new("ImageLabel")
    goku.Size = UDim2.new(0.35,0,0.35,0)
    goku.Position = UDim2.new(0.325,0,0.325,0)
    goku.BackgroundTransparency = 1
    goku.Image = "rbxassetid://11141271480"
    goku.Parent = bg

    local stroke = Instance.new("UIStroke", goku)
    stroke.Color = Color3.fromRGB(255,255,255)
    stroke.Thickness = 5
    stroke.Transparency = 0.4

    -- Animations
    TweenService:Create(goku, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):Play()
    TweenService:Create(goku, TweenInfo.new(1.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0.4,0,0.4,0)}):Play()
    TweenService:Create(stroke, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {Thickness = 12}):Play()

    task.wait(5.5)

    TweenService:Create(bg, TweenInfo.new(1.2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(goku, TweenInfo.new(1.2), {ImageTransparency = 1}):Play()
    TweenService:Create(stroke, TweenInfo.new(1.2), {Transparency = 1}):Play()

    task.wait(1.3)
    sg:Destroy()
end

CreateSplash()

-- // LOAD RAYFIELD SAFELY //
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("Rayfield فشل: " .. tostring(err))
    StarterGui:SetCore("SendNotification", {Title = "خطأ", Text = "فشل تحميل الواجهة! جرب VPN أو executor آخر", Duration = 10})
    return
end

-- Window
local Window = Rayfield:CreateWindow({
    Name = "GOGO HUB v6.1",
    LoadingTitle = "GOGO HUB",
    LoadingSubtitle = "Naser Adm @adm_naser40968",
    ConfigurationSaving = {Enabled = true, FolderName = "GogoHubV6", FileName = "Config"},
    Discord = {Enabled = true, Invite = "DzVBbDKN", RememberJoins = true},
    KeySystem = false
})

-- States
local States = {
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    InfJump = false,
    InfSpin = false,
    InfPunch = false,
    GodMode = false,
    MusicID = "146961487",
    MusicPlaying = nil,
    SelectedPlayer = nil
}

-- Tab Music
local MusicTab = Window:CreateTab("🎵 Music")
MusicTab:CreateInput({
    Name = "Audio ID",
    PlaceholderText = "مثال: 146961487",
    Callback = function(Text) States.MusicID = Text end
})

MusicTab:CreateButton({
    Name = "▶ Play Looped (Local High Volume)",
    Callback = function()
        if States.MusicPlaying then States.MusicPlaying:Destroy() end
        local snd = Instance.new("Sound")
        snd.SoundId = "rbxassetid://" .. States.MusicID
        snd.Volume = 10
        snd.Looped = true
        snd.Parent = LocalPlayer.Character.Head
        snd:Play()
        States.MusicPlaying = snd
        Rayfield:Notify({Title = "تشغيل", Content = "Looped عالي الصوت!", Duration = 4})
    end
})

MusicTab:CreateButton({
    Name = "⏹ Stop",
    Callback = function()
        if States.MusicPlaying then States.MusicPlaying:Destroy() States.MusicPlaying = nil end
    end
})

-- Players Tab
local PlayersTab = Window:CreateTab("👥 Players")

local PlayerDrop = PlayersTab:CreateDropdown({
    Name = "اختر لاعب (تلقائي)",
    Options = {},
    Callback = function(Opt) States.SelectedPlayer = Opt end
})

spawn(function()
    while task.wait(4) do
        local list = {}
        for _, p in Players:GetPlayers() do if p ~= LocalPlayer then table.insert(list, p.Name) end end
        pcall(function() PlayerDrop:Refresh(list, true) end)
    end
end)

PlayersTab:CreateButton({
    Name = "👁 راقب (Spy)",
    Callback = function()
        local tgt = Players[States.SelectedPlayer]
        if tgt and tgt.Character and tgt.Character:FindFirstChild("Humanoid") then
            Workspace.CurrentCamera.CameraSubject = tgt.Character.Humanoid
        end
    end
})

PlayersTab:CreateButton({
    Name = "👕 نسخ الملابس",
    Callback = function()
        local tgt = Players[States.SelectedPlayer]
        if tgt and tgt.Character and LocalPlayer.Character then
            LocalPlayer.Character.Humanoid:ApplyDescription(tgt.Character.Humanoid:GetAppliedDescription())
        end
    end
})

PlayersTab:CreateButton({
    Name = "💀 قتل",
    Callback = function()
        local tgt = Players[States.SelectedPlayer]
        if tgt and tgt.Character then tgt.Character.Humanoid.Health = 0 end
    end
})

PlayersTab:CreateButton({
    Name = "☁️ رفع للسماء",
    Callback = function()
        local tgt = Players[States.SelectedPlayer]
        if tgt and tgt.Character then
            local hrp = tgt.Character.HumanoidRootPart
            for _, p in tgt.Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end
            TweenService:Create(hrp, TweenInfo.new(2.5), {CFrame = hrp.CFrame + Vector3.new(0,800,0)}):Play()
        end
    end
})

-- Features Tab
local FeaturesTab = Window:CreateTab("⚡ ميزات")

FeaturesTab:CreateToggle({Name = "Noclip", Callback = function(v) States.Noclip = v end})
FeaturesTab:CreateToggle({Name = "Fly (Space/Shift)", Callback = function(v) States.Fly = v end})
FeaturesTab:CreateToggle({Name = "Inf Jump", Callback = function(v) States.InfJump = v end})
FeaturesTab:CreateToggle({Name = "Inf Spin", Callback = function(v) States.InfSpin = v end})
FeaturesTab:CreateToggle({Name = "Inf Punch", Callback = function(v) States.InfPunch = v end})
FeaturesTab:CreateToggle({Name = "God Mode", Callback = function(v) States.GodMode = v end})

-- Loops
RunService.Stepped:Connect(function()
    if States.Noclip and LocalPlayer.Character then
        for _, p in LocalPlayer.Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end
    end
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char then
        if States.GodMode then char.Humanoid.Health = 100 end
        if States.InfSpin then char.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(18), 0) end
        if States.InfPunch then
            for _, plr in Players:GetPlayers() do
                if plr ~= LocalPlayer and plr.Character then
                    local dist = (plr.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                    if dist < 12 then plr.Character.Humanoid.Health -= 1.5 end
                end
            end
        end
        if States.Fly then
            local hrp = char.HumanoidRootPart
            if not hrp:FindFirstChild("FlyBV") then
                local bv = Instance.new("BodyVelocity", hrp)
                bv.Name = "FlyBV"
                bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            end
            local vel = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,60,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0,60,0) end
            hrp.FlyBV.Velocity = vel
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if States.InfJump and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

Rayfield:Notify({
    Title = "GOGO HUB v6.1 شغال!",
    Content = "Splash محسن + كل الميزات تعمل + أنميشن أكثر",
    Duration = 8
})
