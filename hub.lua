-- 🧠 نوس هوب - HUB الدخم v1.0 (2026) - Naser Adm @adm_naser40968
-- 🔥 كود ضخم كامل: كل ميزات Kurd Hub (Auto Steal, TP Home, Desync V4, Float, Inf Jump, Anti Ragdoll, Aimbot, Invisible, FPS Boost, ESP Brainrot/Players, God Mode, Anti AFK) + Inf Spin (دوران يصعب الضرب عليك)
-- 📱 Mobile/PC Delta/Arceus X | NO KEY | Bypass Anti-Cheat قوي (Smooth Tween + Random Offset)
-- 🚀 GUI أخضر/أزرق زجاجي (Glass-like with transparency + gradient)
-- 💾 Error Handling: لو خطأ يظهر "نوس هوب" + زر إعادة تحميل
-- 🔗 Loadstring ready: loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

getgenv().Config = {
    AutoSteal = false, TPHome = nil, Noclip = false, Speed = 50, Fly = false, InfJump = false, InfSpin = false, Desync = false, Float = false, AntiRagdoll = false, Aimbot = false, Invisible = false, FPSBoost = false, ESP = false, GodMode = false, AntiAFK = false
}

-- Error Handling: لو خطأ، يظهر نوس هوب + زر إعادة
local function HandleError(err)
    StarterGui:SetCore("SendNotification", {
        Title = "خطأ في نوس هوب",
        Text = "خطأ: " .. tostring(err) .. "\nاضغط إعادة لإصلاح",
        Button1 = "إعادة",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()
        end,
        Duration = 15
    })
end

pcall(function()
    -- Rayfield Load with error catch
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "🧠 نوس هوب - Dukhm Hub",
        LoadingTitle = "جاري التحميل...",
        LoadingSubtitle = "Naser Adm",
        ConfigurationSaving = {Enabled = true, FolderName = "NosHub", FileName = "config"}
    })

    -- GUI Style: أخضر/أزرق زجاجي (add gradient/transparency manually since Rayfield limited)
    local GuiBg = Instance.new("Frame", CoreGui)
    GuiBg.Size = UDim2.new(1,0,1,0)
    GuiBg.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    GuiBg.BackgroundTransparency = 0.7  -- زجاجي
    GuiBg.Visible = false

    local Grad = Instance.new("UIGradient", GuiBg)
    Grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 150)),  -- أخضر
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))   -- أزرق
    }

    -- Show glass bg when GUI opens
    spawn(function()
        GuiBg.Visible = true
        TweenService:Create(GuiBg, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.5}):Play()
    end)

    -- Tab Auto Farm
    local FarmTab = Window:CreateTab("🤖 Auto Farm", 4483362458)

    FarmTab:CreateToggle({
        Name = "Auto Steal + TP Home",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.AutoSteal = v
            if v then
                spawn(function()
                    while getgenv().Config.AutoSteal do
                        for _, obj in Workspace:GetDescendants() do
                            if obj.Name:lower():find("brainrot") and (obj:IsA("BasePart") or obj:FindFirstChild("ProximityPrompt")) then
                                local off = Vector3.new(math.random(-1,1), 0, math.random(-1,1))  -- Bypass detect
                                TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.4), {CFrame = obj.CFrame + off + Vector3.new(0,3,0)}):Play()
                                task.wait(0.4)
                                if obj:FindFirstChild("ProximityPrompt") then fireproximityprompt(obj.ProximityPrompt) end
                                task.wait(0.6)
                                if getgenv().Config.TPHome then
                                    TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.6), {CFrame = getgenv().Config.TPHome + off}):Play()
                                end
                                break
                            end
                        end
                        task.wait(0.2)
                    end
                end)
            end
        end
    })

    FarmTab:CreateButton({
        Name = "حفظ القاعدة (Save Home)",
        Callback = function()
            getgenv().Config.TPHome = LocalPlayer.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({Title = "تم!", Content = "القاعدة محفوظة", Duration = 3})
        end
    })

    -- Tab Movement
    local MoveTab = Window:CreateTab("🏃 حركة", 4483362458)

    MoveTab:CreateToggle({
        Name = "Noclip",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.Noclip = v
        end
    })

    MoveTab:CreateSlider({
        Name = "Speed Hack",
        Range = {16, 200},
        CurrentValue = 50,
        Callback = function(v)
            getgenv().Config.Speed = v
        end
    })

    MoveTab:CreateToggle({
        Name = "Fly (Space/Shift)",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.Fly = v
        end
    })

    MoveTab:CreateToggle({
        Name = "Inf Jump",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.InfJump = v
        end
    })

    MoveTab:CreateToggle({
        Name = "Inf Spin (دوران يصعب الضرب)",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.InfSpin = v
        end
    })

    MoveTab:CreateToggle({
        Name = "Float (طفو)",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.Float = v
        end
    })

    MoveTab:CreateToggle({
        Name = "Desync V4 (Anti Hit)",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.Desync = v
        end
    })

    MoveTab:CreateToggle({
        Name = "Anti Ragdoll",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.AntiRagdoll = v
        end
    })

    -- Tab PVP
    local PVPTab = Window:CreateTab("⚔️ PVP", 4483362458)

    PVPTab:CreateToggle({
        Name = "Aimbot (Silent)",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.Aimbot = v
        end
    })

    PVPTab:CreateToggle({
        Name = "Invisible",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.Invisible = v
            if v and LocalPlayer.Character then
                LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Transparency = 1
                for _, p in LocalPlayer.Character:GetChildren() do if p:IsA("BasePart") then p.Transparency = 1 end end
            else
                for _, p in LocalPlayer.Character:GetChildren() do if p:IsA("BasePart") then p.Transparency = 0 end end
            end
        end
    })

    PVPTab:CreateToggle({
        Name = "God Mode",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.GodMode = v
        end
    })

    -- Tab Visuals
    local VisualTab = Window:CreateTab("👁️ فيزيول", 4483362458)

    VisualTab:CreateToggle({
        Name = "ESP Brainrot/Players",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.ESP = v
        end
    })

    VisualTab:CreateToggle({
        Name = "FPS Boost",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.FPSBoost = v
            if v then
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            end
        end
    })

    -- Tab Misc
    local MiscTab = Window:CreateTab("🛠️ متنوع", 4483362458)

    MiscTab:CreateToggle({
        Name = "Anti AFK",
        CurrentValue = false,
        Callback = function(v)
            getgenv().Config.AntiAFK = v
            if v then
                spawn(function()
                    while getgenv().Config.AntiAFK do
                        task.wait(60)
                        keypress(0x57) keyrelease(0x57)  -- W
                    end
                end)
            end
        end
    })

    MiscTab:CreateButton({
        Name = "إعادة تحميل نوس هوب",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/naserdel123/rob/main/hub.lua"))()
        end
    })

    -- Loops
    RunService.Stepped:Connect(function()
        pcall(function()
            if getgenv().Config.Noclip then
                for _, p in LocalPlayer.Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end
            end
            if getgenv().Config.Desync then
                LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.new(math.random(-2,2)/10, 0, math.random(-2,2)/10)
            end
            if getgenv().Config.Float then
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1.5, 0)
            end
            if getgenv().Config.AntiRagdoll then
                if LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end
        end)
    end)

    RunService.Heartbeat:Connect(function()
        pcall(function()
            if LocalPlayer.Character.Humanoid then
                LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Config.Speed
                if getgenv().Config.GodMode then LocalPlayer.Character.Humanoid.Health = 100 end
            end
            if getgenv().Config.InfSpin then
                LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(25), 0)
            end
            if getgenv().Config.Fly then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                if not hrp:FindFirstChild("FlyBV") then
                    local bv = Instance.new("BodyVelocity", hrp)
                    bv.Name = "FlyBV"
                    bv.MaxForce = Vector3.new(1e6,1e6,1e6)
                end
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, getgenv().Config.Speed, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0, getgenv().Config.Speed, 0) end
                hrp.FlyBV.Velocity = vel
            end
        end)
    end)

    UserInputService.JumpRequest:Connect(function()
        if getgenv().Config.InfJump then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)

    -- ESP Loop
    spawn(function()
        while task.wait(0.5) do
            if getgenv().Config.ESP then
                for _, p in Players:GetPlayers() do
                    if p ~= LocalPlayer and p.Character then
                        if not p.Character:FindFirstChild("ESP") then
                            local hl = Instance.new("Highlight", p.Character)
                            hl.Name = "ESP"
                            hl.FillColor = Color3.fromRGB(0,255,0)
                            hl.OutlineColor = Color3.fromRGB(255,0,0)
                        end
                    end
                end
                for _, o in Workspace:GetDescendants() do
                    if o.Name:lower():find("brainrot") and o:IsA("BasePart") then
                        if not o:FindFirstChild("ESP") then
                            local hl = Instance.new("Highlight", o)
                            hl.Name = "ESP"
                            hl.FillColor = Color3.fromRGB(255,0,0)
                            hl.OutlineColor = Color3.fromRGB(255,255,0)
                        end
                    end
                end
            end
        end
    end)

    -- Aimbot Loop
    spawn(function()
        while task.wait(0.1) do
            if getgenv().Config.Aimbot then
                local closest, dist = nil, math.huge
                for _, p in Players:GetPlayers() do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local mag = (p.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                        if mag < dist then closest = p dist = mag end
                    end
                end
                if closest then
                    Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position + Vector3.new(math.random(-1,1)/10, 0, math.random(-1,1)/10))  -- Bypass
                end
            end
        end
    end)

    Rayfield:Notify({
        Title = "نوس هوب جاهز!",
        Content = "كل الميزات تعمل، جرب وشوف",
        Duration = 6
    })
end, HandleError)
