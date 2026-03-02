--[[
    ██████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗     ██████╗ █████╗ ████████╗███████╗██████╗
    ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║    ██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
    ██████╔╝██║   ██║██╔██╗ ██║██║     ███████║    ██║     ███████║   ██║   █████╗  ██████╔╝
    ██╔═══╝ ██║   ██║██║╚██╗██║██║     ██╔══██║    ██║     ██╔══██║   ██║   ██╔══╝  ██╔══██╗
    ██║     ╚██████╔╝██║ ╚████║╚██████╗██║  ██║    ╚██████╗██║  ██║   ██║   ███████╗██║  ██║
    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝     ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
    
    Punch Master HUB - Naser Adm
    Ultimate Roblox Exploit Script for Mobile & PC
    Compatible with: Delta Executor, Arceus X, Fluxus, Hydrogen, Codex
    
    Features:
    - Realistic Punch System with Tween Animations
    - ESP, Noclip, Infinite Jump, Speed Control
    - Anti-AFK Protection
    - Mobile Optimized UI using Rayfield Library
    
    Created: 2026
    Author: Naser Adm
]]

--// Services // الخدمات
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

--// Variables // المتغيرات
getgenv().SelectedTarget = nil
getgenv().IsPunching = false
getgenv().InfiniteJumpEnabled = false
getgenv().NoclipEnabled = false
getgenv().ESPEnabled = false
getgenv().AntiAFKEnabled = false
getgenv().WalkSpeedValue = 16
getgenv().LastPunchTime = 0

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

--// Load Rayfield Library // تحميل مكتبة رايفيلد
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Create Main Window // إنشاء النافذة الرئيسية
local Window = Rayfield:CreateWindow({
    Name = "Punch Master HUB - Naser Adm",
    LoadingTitle = "Loading Ultimate Punch System...",
    LoadingSubtitle = "by Naser Adm",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PunchMasterHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false,
})

--// Notification Function // دالة الإشعارات
local function Notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 3,
        Image = "info",
    })
end

--// Get Character Function // دالة الحصول على الشخصية
local function GetCharacter(player)
    return player and player.Character
end

--// Get Humanoid Function // دالة الحصول على الهيومانويد
local function GetHumanoid(character)
    return character and character:FindFirstChildOfClass("Humanoid")
end

--// Get RootPart Function // دالة الحصول على الجزء الرئيسي
local function GetRootPart(character)
    return character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso"))
end

--// Create Fist Part for Punch Effect // إنشاء جزء القبضة للتأثير
local function CreateFistEffect()
    local fist = Instance.new("Part")
    fist.Name = "PunchFist"
    fist.Shape = Enum.PartType.Ball
    fist.Size = Vector3.new(2, 2, 2)
    fist.Color = Color3.fromRGB(255, 0, 0)
    fist.Material = Enum.Material.Neon
    fist.Transparency = 0.3
    fist.CanCollide = false
    fist.Anchored = true
    
    -- Add particle effect // إضافة تأثير الجزيئات
    local attachment = Instance.new("Attachment", fist)
    local particle = Instance.new("ParticleEmitter", attachment)
    particle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 100, 100))
    particle.Size = NumberSequence.new(0.5, 1.5)
    particle.Lifetime = NumberRange.new(0.2, 0.5)
    particle.Rate = 50
    particle.Speed = NumberRange.new(5, 10)
    particle.SpreadAngle = Vector2.new(180, 180)
    
    return fist
end

--// Play Punch Sound // تشغيل صوت اللكمة
local function PlayPunchSound(position)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3932505913" -- Punch sound
    sound.Volume = 0.8
    sound.Parent = SoundService
    sound:Play()
    Debris:AddItem(sound, 2)
end

--// Punch Animation // أنيميشن الضربة
local function PerformPunch(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        Notify("Error", "Target not found!", 3)
        return false
    end
    
    local targetChar = targetPlayer.Character
    local targetHumanoid = GetHumanoid(targetChar)
    local targetRoot = GetRootPart(targetChar)
    
    if not targetHumanoid or targetHumanoid.Health <= 0 then
        Notify("Error", "Target is dead!", 3)
        return false
    end
    
    local localChar = GetCharacter(LocalPlayer)
    if not localChar then
        Notify("Error", "Your character not found!", 3)
        return false
    end
    
    local localRoot = GetRootPart(localChar)
    local localHumanoid = GetHumanoid(localChar)
    
    if not localRoot or not localHumanoid then return false end
    
    -- Calculate positions // حساب المواقع
    local targetPos = targetRoot.Position
    local punchPos = targetPos + (targetRoot.CFrame.LookVector * -2.5) -- 2.5 studs in front
    
    -- Tween to target // التحريك نحو الهدف
    local tweenInfo = TweenInfo.new(
        IsMobile and 0.5 or 0.4, -- Slower on mobile
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local tweenTo = TweenService:Create(localRoot, tweenInfo, {
        CFrame = CFrame.new(punchPos, targetPos)
    })
    
    tweenTo:Play()
    tweenTo.Completed:Wait()
    
    -- Create fist effect // إنشاء تأثير القبضة
    local fist = CreateFistEffect()
    fist.Position = localRoot.Position + Vector3.new(0, 0, -2)
    fist.Parent = Workspace
    
    -- Animate fist to target // تحريك القبضة نحو الهدف
    local fistTween = TweenService:Create(fist, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
        Position = targetRoot.Position
    })
    fistTween:Play()
    fistTween.Completed:Wait()
    
    -- Impact effect // تأثير الاصطدام
    local impactParticle = Instance.new("ParticleEmitter", targetRoot)
    impactParticle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    impactParticle.Size = NumberSequence.new(2, 0)
    impactParticle.Lifetime = NumberRange.new(0.3)
    impactParticle.Rate = 100
    impactParticle.Speed = NumberRange.new(10, 20)
    Debris:AddItem(impactParticle, 0.5)
    
    -- Play sound // تشغيل الصوت
    pcall(function() PlayPunchSound(targetRoot.Position) end)
    
    -- Deal damage // تطبيق الضرر
    local damage = math.random(10, 15)
    targetHumanoid.Health = math.max(0, targetHumanoid.Health - damage)
    
    -- Clean up fist // تنظيف القبضة
    Debris:AddItem(fist, 0.5)
    
    -- Tween back slightly // الرجوع للخلف قليلاً
    local backPos = punchPos + (targetRoot.CFrame.LookVector * -1)
    local tweenBack = TweenService:Create(localRoot, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        CFrame = CFrame.new(backPos, targetPos)
    })
    tweenBack:Play()
    
    -- Notify // إشعار
    Notify("💥 Hit!", string.format("-%d HP to %s (Remaining: %d HP)", 
        damage, targetPlayer.Name, math.floor(targetHumanoid.Health)), 3)
    
    return true
end

--// Create Tabs // إنشاء التبويبات
local MainTab = Window:CreateTab("Main Punch", "sword")
local VisualsTab = Window:CreateTab("Visuals", "eye")
local MovementTab = Window:CreateTab("Movement Extras", "zap")

--// Main Punch Section // قسم الضرب الرئيسي
MainTab:CreateSection("Target Selection (اختيار الهدف)")

MainTab:CreateInput({
    Name = "Enter Player Name (exact)",
    PlaceholderText = "Type exact username...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        if text and text ~= "" then
            local found = false
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Name:lower() == text:lower() or player.DisplayName:lower() == text:lower() then
                    getgenv().SelectedTarget = player
                    found = true
                    Notify("✅ Target Found", "Selected: " .. player.Name .. " (" .. player.DisplayName .. ")", 3)
                    break
                end
            end
            if not found then
                getgenv().SelectedTarget = nil
                Notify("❌ Error", "Player not found: " .. text, 3)
            end
        end
    end,
})

MainTab:CreateButton({
    Name = "Select Target (قبضة)",
    Callback = function()
        -- Alternative selection method using input
        Rayfield:Notify({
            Title = "Target Selection",
            Content = "Use the input field above to type the exact player name",
            Duration = 4,
            Image = "info",
        })
    end,
})

MainTab:CreateSection("Punch Actions (أزرار الضرب)")

MainTab:CreateButton({
    Name = "Punch (ضرب) - Single Hit",
    Callback = function()
        if tick() - getgenv().LastPunchTime < 0.5 then
            Notify("Wait", "Please wait before next punch!", 2)
            return
        end
        
        if not getgenv().SelectedTarget then
            Notify("Error", "No target selected! Enter a name first.", 3)
            return
        end
        
        getgenv().LastPunchTime = tick()
        PerformPunch(getgenv().SelectedTarget)
    end,
})

MainTab:CreateToggle({
    Name = "Auto Punch (Hold to Spam)",
    CurrentValue = false,
    Flag = "AutoPunch",
    Callback = function(value)
        getgenv().IsPunching = value
        
        if value then
            task.spawn(function()
                while getgenv().IsPunching and getgenv().SelectedTarget do
                    if tick() - getgenv().LastPunchTime >= 0.6 then
                        getgenv().LastPunchTime = tick()
                        PerformPunch(getgenv().SelectedTarget)
                    end
                    task.wait(0.1)
                end
            end)
        end
    end,
})

MainTab:CreateButton({
    Name = "Clear Target",
    Callback = function()
        getgenv().SelectedTarget = nil
        Notify("Cleared", "Target has been reset", 2)
    end,
})

--// Visuals Section // قسم المرئيات
VisualsTab:CreateSection("ESP Settings")

local ESPObjects = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local function onCharacterAdded(char)
        if not getgenv().ESPEnabled then return end
        
        -- Remove old ESP
        if ESPObjects[player] then
            ESPObjects[player]:Destroy()
        end
        
        -- Create Highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = char
        ESPObjects[player] = highlight
        
        -- Update color on team change
        local connection
        connection = player:GetPropertyChangedSignal("Team"):Connect(function()
            if highlight and highlight.Parent then
                highlight.FillColor = player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            else
                connection:Disconnect()
            end
        end)
    end
    
    if player.Character then
        onCharacterAdded(player.Character)
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
end

VisualsTab:CreateToggle({
    Name = "Player ESP (Green/Red)",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(value)
        getgenv().ESPEnabled = value
        
        if value then
            -- Create ESP for existing players
            for _, player in ipairs(Players:GetPlayers()) do
                CreateESP(player)
            end
            
            -- Connect for new players
            Players.PlayerAdded:Connect(CreateESP)
        else
            -- Remove all ESP
            for _, highlight in pairs(ESPObjects) do
                if highlight then
                    highlight:Destroy()
                end
            end
            ESPObjects = {}
        end
    end,
})

--// Movement Section // قسم الحركة
MovementTab:CreateSection("Movement Modifiers")

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 150},
    Increment = 1,
    Suffix = "Studs/sec",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(value)
        getgenv().WalkSpeedValue = value
        local char = GetCharacter(LocalPlayer)
        if char then
            local humanoid = GetHumanoid(char)
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end,
})

-- WalkSpeed loop
task.spawn(function()
    while true do
        if getgenv().WalkSpeedValue ~= 16 then
            local char = GetCharacter(LocalPlayer)
            if char then
                local humanoid = GetHumanoid(char)
                if humanoid and humanoid.WalkSpeed ~= getgenv().WalkSpeedValue then
                    humanoid.WalkSpeed = getgenv().WalkSpeedValue
                end
            end
        end
        task.wait(0.5)
    end
end)

MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(value)
        getgenv().InfiniteJumpEnabled = value
    end,
})

-- Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfiniteJumpEnabled then
        local char = GetCharacter(LocalPlayer)
        if char then
            local humanoid = GetHumanoid(char)
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(value)
        getgenv().NoclipEnabled = value
    end,
})

-- Noclip Loop
RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled then
        local char = GetCharacter(LocalPlayer)
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

MovementTab:CreateToggle({
    Name = "Anti-AFK (60s interval)",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(value)
        getgenv().AntiAFKEnabled = value
    end,
})

-- Anti-AFK Logic
task.spawn(function()
    while true do
        if getgenv().AntiAFKEnabled then
            -- Simulate camera movement or input
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseMoveEvent(0, 0, game)
            
            -- Alternative: Move camera slightly
            local cam = Workspace.CurrentCamera
            if cam then
                local originalCFrame = cam.CFrame
                cam.CFrame = originalCFrame * CFrame.Angles(0, math.rad(0.1), 0)
                task.wait(0.1)
                cam.CFrame = originalCFrame
            end
        end
        task.wait(60) -- Every 60 seconds
    end
end)

--// Character Added Handler // معالج إضافة الشخصية
LocalPlayer.CharacterAdded:Connect(function(char)
    -- Apply walkspeed on respawn
    task.wait(0.5)
    if getgenv().WalkSpeedValue ~= 16 then
        local humanoid = GetHumanoid(char)
        if humanoid then
            humanoid.WalkSpeed = getgenv().WalkSpeedValue
        end
    end
end)

--// Final Notification // الإشعار النهائي
task.wait(1)
Notify("✅ Loaded Successfully!", "Punch Master HUB is ready! Target: " .. (IsMobile and "Mobile" or "PC"), 5)
print("[Punch Master HUB] Script loaded successfully!")
print("[Punch Master HUB] Created by Naser Adm")
print("[Punch Master HUB] Target Platform: " .. (IsMobile and "Mobile" or "PC"))
