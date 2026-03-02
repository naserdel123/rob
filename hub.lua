--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║   ██████╗  ██████╗ ██╗  ██╗███████╗███╗   ██╗██╗   ██╗██╗  ██╗            ║
    ║   ██╔══██╗██╔═══██╗██║ ██╔╝██╔════╝████╗  ██║██║   ██║╚██╗██╔╝            ║
    ║   ██████╔╝██║   ██║█████╔╝ █████╗  ██╔██╗ ██║██║   ██║ ╚███╔╝             ║
    ║   ██╔═══╝ ██║   ██║██╔═██╗ ██╔══╝  ██║╚██╗██║██║   ██║ ██╔██╗             ║
    ║   ██║     ╚██████╔╝██║  ██╗███████╗██║ ╚████║╚██████╔╝██╔╝ ██╗            ║
    ║   ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝            ║
    ║                                                                           ║
    ║                    PHOENIX ULTIMATE HUB v2.0                              ║
    ║                      By Naser Adm | 2026                                  ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
    
    ✨ Features:
    - Epic Animated Intro
    - Image URL Loader (Click Anywhere to Place)
    - Advanced Combat System
    - Ultra Smooth Animations
    - Mobile Optimized
]]

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

--// Variables
getgenv().LoadedImage = nil
getgenv().ImagePlacementMode = false
getgenv().ImageSize = 10
getgenv().ImageTransparency = 0
getgenv().ImageGlowEnabled = true
getgenv().SpinEnabled = false
getgenv().FloatEnabled = false

--// Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// EPIC INTRO ANIMATION
local function PlayEpicIntro()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PhoenixIntro"
    screenGui.Parent = CoreGui
    
    -- Black background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.new(0, 0, 0)
    bg.BorderSizePixel = 0
    bg.Parent = screenGui
    
    -- Phoenix Logo Text
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(0, 600, 0, 100)
    logo.Position = UDim2.new(0.5, -300, 0.5, -50)
    logo.BackgroundTransparency = 1
    logo.Text = "PHOENIX"
    logo.TextColor3 = Color3.fromRGB(255, 100, 0)
    logo.TextSize = 80
    logo.Font = Enum.Font.GothamBlack
    logo.TextTransparency = 1
    logo.Parent = screenGui
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(0, 400, 0, 40)
    subtitle.Position = UDim2.new(0.5, -200, 0.5, 40)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "ULTIMATE HUB"
    subtitle.TextColor3 = Color3.fromRGB(0, 150, 255)
    subtitle.TextSize = 40
    subtitle.Font = Enum.Font.GothamBold
    subtitle.TextTransparency = 1
    subtitle.Parent = screenGui
    
    -- Particle effects
    for i = 1, 50 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(math.random(200, 255), math.random(100, 150), 0)
        particle.BorderSizePixel = 0
        particle.BackgroundTransparency = 1
        particle.Parent = screenGui
        
        TweenService:Create(particle, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            Position = UDim2.new(particle.Position.X.Scale, math.random(-100, 100), particle.Position.Y.Scale - 0.5, 0),
            BackgroundTransparency = 0,
            Rotation = math.random(360)
        }):Play()
        
        task.delay(1.5, function()
            TweenService:Create(particle, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        end)
    end
    
    -- Animate logo
    TweenService:Create(logo, TweenInfo.new(1, Enum.EasingStyle.Back), {TextTransparency = 0}):Play()
    task.wait(0.3)
    TweenService:Create(subtitle, TweenInfo.new(1, Enum.EasingStyle.Back), {TextTransparency = 0}):Play()
    
    -- Glow effect
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(0, 800, 0, 800)
    glow.Position = UDim2.new(0.5, -400, 0.5, -400)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://1072804457"
    glow.ImageColor3 = Color3.fromRGB(255, 100, 0)
    glow.ImageTransparency = 1
    glow.Parent = screenGui
    
    TweenService:Create(glow, TweenInfo.new(1.5), {ImageTransparency = 0.7, Rotation = 360}):Play()
    
    task.wait(2.5)
    
    -- Fade out
    TweenService:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(logo, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    TweenService:Create(glow, TweenInfo.new(0.8), {ImageTransparency = 1}):Play()
    
    task.wait(1)
    screenGui:Destroy()
end

--// Play Intro
PlayEpicIntro()

--// Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "🔥 PHOENIX ULTIMATE HUB 🔥",
    LoadingTitle = "Loading Phoenix Systems...",
    LoadingSubtitle = "Initializing Ultimate Features",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhoenixHub",
        FileName = "Config"
    },
    KeySystem = false,
})

--// Notify Function
local function Notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 3,
        Image = "flame",
    })
end

--// IMAGE SYSTEM
local ImageTab = Window:CreateTab("🖼️ Image System", "image")

ImageTab:CreateSection("📸 Load Image from URL")

local ImageUrlInput = ImageTab:CreateInput({
    Name = "Image URL (Direct Link)",
    PlaceholderText = "https://i.imgur.com/xxxxxx.png",
    RemoveTextAfterFocusLost = false,
    Flag = "ImageUrl",
    Callback = function(text)
        -- Validate URL
        if text and text:match("^https?://") then
            getgenv().ImageUrl = text
            Notify("✅ URL Set", "Click 'Load Image' to apply", 2)
        end
    end,
})

ImageTab:CreateButton({
    Name = "🚀 Load Image",
    Callback = function()
        if not getgenv().ImageUrl then
            Notify("❌ Error", "Enter URL first!", 3)
            return
        end
        
        -- Create image part
        local success, result = pcall(function()
            local part = Instance.new("Part")
            part.Name = "LoadedImage_" .. tostring(tick())
            part.Size = Vector3.new(getgenv().ImageSize, 0.1, getgenv().ImageSize)
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 1
            part.Parent = Workspace
            
            -- Create decal
            local decal = Instance.new("Decal")
            decal.Texture = getgenv().ImageUrl
            decal.Face = Enum.NormalId.Top
            decal.Parent = part
            
            -- Also add to sides for visibility
            for _, face in ipairs({Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Left, Enum.NormalId.Right}) do
                local sideDecal = Instance.new("Decal")
                sideDecal.Texture = getgenv().ImageUrl
                sideDecal.Face = face
                sideDecal.Parent = part
            end
            
            getgenv().LoadedImage = part
            getgenv().ImagePlacementMode = true
            
            Notify("🖼️ Image Loaded!", "Click anywhere to place it", 4)
        end)
        
        if not success then
            Notify("❌ Failed", "Invalid URL or Load Error", 3)
        end
    end,
})

ImageTab:CreateToggle({
    Name = "✋ Click to Place Mode",
    CurrentValue = false,
    Flag = "PlacementMode",
    Callback = function(value)
        getgenv().ImagePlacementMode = value
        if value and getgenv().LoadedImage then
            Notify("📍 Placement Mode", "Click anywhere to place image", 3)
        end
    end,
})

ImageTab:CreateSlider({
    Name = "Image Size",
    Range = {1, 50},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 10,
    Flag = "ImageSize",
    Callback = function(value)
        getgenv().ImageSize = value
        if getgenv().LoadedImage then
            getgenv().LoadedImage.Size = Vector3.new(value, 0.1, value)
        end
    end,
})

ImageTab:CreateSlider({
    Name = "Image Height",
    Range = {0, 100},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 0,
    Flag = "ImageHeight",
    Callback = function(value)
        if getgenv().LoadedImage then
            local pos = getgenv().LoadedImage.Position
            getgenv().LoadedImage.Position = Vector3.new(pos.X, value, pos.Z)
        end
    end,
})

ImageTab:CreateToggle({
    Name = "🌟 Glow Effect",
    CurrentValue = true,
    Flag = "ImageGlow",
    Callback = function(value)
        getgenv().ImageGlowEnabled = value
        if getgenv().LoadedImage then
            if value then
                local pointLight = Instance.new("PointLight")
                pointLight.Color = Color3.fromRGB(255, 255, 255)
                pointLight.Range = 10
                pointLight.Brightness = 2
                pointLight.Parent = getgenv().LoadedImage
            else
                for _, child in ipairs(getgenv().LoadedImage:GetChildren()) do
                    if child:IsA("PointLight") then
                        child:Destroy()
                    end
                end
            end
        end
    end,
})

ImageTab:CreateToggle({
    Name = "🔄 Spin Animation",
    CurrentValue = false,
    Flag = "SpinImage",
    Callback = function(value)
        getgenv().SpinEnabled = value
    end,
})

ImageTab:CreateToggle({
    Name = "⬆️ Float Animation",
    CurrentValue = false,
    Flag = "FloatImage",
    Callback = function(value)
        getgenv().FloatEnabled = value
    end,
})

ImageTab:CreateButton({
    Name = "🗑️ Delete Image",
    Callback = function()
        if getgenv().LoadedImage then
            getgenv().LoadedImage:Destroy()
            getgenv().LoadedImage = nil
            Notify("🗑️ Deleted", "Image removed", 2)
        end
    end,
})

--// Click Placement System
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not getgenv().ImagePlacementMode then return end
    if not getgenv().LoadedImage then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePos = Mouse.Hit
        if mousePos then
            -- Smooth placement animation
            local targetPos = mousePos.Position + Vector3.new(0, 3, 0)
            
            TweenService:Create(getgenv().LoadedImage, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
                Position = targetPos,
                Transparency = 0
            }):Play()
            
            -- Add glow if enabled
            if getgenv().ImageGlowEnabled then
                local existing = getgenv().LoadedImage:FindFirstChildOfClass("PointLight")
                if not existing then
                    local pointLight = Instance.new("PointLight")
                    pointLight.Color = Color3.fromRGB(255, 255, 255)
                    pointLight.Range = 15
                    pointLight.Brightness = 3
                    pointLight.Parent = getgenv().LoadedImage
                end
            end
            
            Notify("✅ Placed!", "Image positioned at click location", 2)
            getgenv().ImagePlacementMode = false
        end
    end
end)

--// Animation Loop for Image
RunService.Heartbeat:Connect(function(dt)
    if getgenv().LoadedImage then
        -- Spin
        if getgenv().SpinEnabled then
            getgenv().LoadedImage.CFrame = getgenv().LoadedImage.CFrame * CFrame.Angles(0, math.rad(90 * dt), 0)
        end
        
        -- Float
        if getgenv().FloatEnabled then
            local time = tick()
            local basePos = getgenv().LoadedImage.Position
            getgenv().LoadedImage.Position = Vector3.new(
                basePos.X,
                basePos.Y + math.sin(time * 2) * 0.5 * dt,
                basePos.Z
            )
        end
    end
end)

--// COMBAT SYSTEM
local CombatTab = Window:CreateTab("👊 Combat", "sword")

CombatTab:CreateSection("⚔️ Ultimate Combat")

local SelectedTarget = nil

CombatTab:CreateDropdown({
    Name = "Select Target",
    Options = {},
    Flag = "CombatTarget",
    Callback = function(selected)
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Name == selected then
                SelectedTarget = player
                Notify("🎯 Target", "Selected: " .. player.Name, 2)
                break
            end
        end
    end,
})

-- Refresh targets button
CombatTab:CreateButton({
    Name = "🔄 Refresh Targets",
    Callback = function()
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                table.insert(names, p.Name)
            end
        end
        -- Update dropdown (Rayfield specific)
        Rayfield:Notify({Title = "Refreshed", Content = #names .. " players found", Duration = 2})
    end,
})

CombatTab:CreateButton({
    Name = "💥 Ultimate Punch",
    Callback = function()
        if not SelectedTarget then
            Notify("❌ Error", "Select target first!", 3)
            return
        end
        
        local targetChar = SelectedTarget.Character
        local localChar = LocalPlayer.Character
        
        if not targetChar or not localChar then return end
        
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        
        if targetRoot and localRoot then
            -- Tween to target
            local distance = (targetRoot.Position - localRoot.Position).Magnitude
            if distance > 5 then
                local tween = TweenService:Create(localRoot, TweenInfo.new(0.4), {
                    CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 0, 3), targetRoot.Position)
                })
                tween:Play()
                tween.Completed:Wait()
            end
            
            -- Punch animation
            local humanoid = localChar:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://204062532"
                local track = humanoid:LoadAnimation(anim)
                track:Play()
            end
            
            -- Effects
            local punch = Instance.new("Part")
            punch.Size = Vector3.new(2, 2, 2)
            punch.Shape = Enum.PartType.Ball
            punch.Color = Color3.fromRGB(255, 0, 0)
            punch.Material = Enum.Material.Neon
            punch.Anchored = true
            punch.CFrame = localRoot.CFrame * CFrame.new(0, 0, -3)
            punch.Parent = Workspace
            
            TweenService:Create(punch, TweenInfo.new(0.2), {
                Position = targetRoot.Position,
                Size = Vector3.new(0.5, 0.5, 0.5)
            }):Play()
            
            Debris:AddItem(punch, 0.3)
            
            -- Damage
            local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
            if targetHum then
                targetHum:TakeDamage(25)
                Notify("💥 HIT!", "Dealt 25 damage!", 2)
            end
        end
    end,
})

--// MOVEMENT SYSTEM
local MovementTab = Window:CreateTab("🏃 Movement", "zap")

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(value)
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = value end
        end
    end,
})

MovementTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(value)
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = value end
        end
    end,
})

MovementTab:CreateToggle({
    Name = "✈️ Fly Mode",
    CurrentValue = false,
    Flag = "FlyMode",
    Callback = function(value)
        local char = LocalPlayer.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        if value then
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.Name = "FlyVelocity"
            bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVel.Velocity = Vector3.zero
            bodyVel.Parent = root
            
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.Name = "FlyGyro"
            bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            bodyGyro.P = 100
            bodyGyro.Parent = root
            
            Notify("✈️ Fly Enabled", "Use WASD to fly, Space/Shift for up/down", 3)
        else
            for _, v in ipairs(root:GetChildren()) do
                if v.Name == "FlyVelocity" or v.Name == "FlyGyro" then
                    v:Destroy()
                end
            end
        end
    end,
})

-- Fly control
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local flyVel = root:FindFirstChild("FlyVelocity")
    local flyGyro = root:FindFirstChild("FlyGyro")
    
    if flyVel and flyGyro then
        local cam = Workspace.CurrentCamera
        local moveDir = Vector3.zero
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end
        
        flyVel.Velocity = moveDir * 50
        flyGyro.CFrame = cam.CFrame
    end
end)

--// VISUALS
local VisualsTab = Window:CreateTab("👁️ Visuals", "eye")

VisualsTab:CreateToggle({
    Name = "👤 Player ESP",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(value)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if value then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.Ou
