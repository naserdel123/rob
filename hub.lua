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
    ║                    PHOENIX ULTIMATE HUB v3.0 - FIXED                      ║
    ║                      By Naser Adm | 2026                                  ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Variables
getgenv().LoadedImage = nil
getgenv().ImagePlacementMode = false
getgenv().ImageSize = 10
getgenv().ImageHeight = 3
getgenv().SpinEnabled = false
getgenv().FloatEnabled = false
getgenv().FlyEnabled = false

--// Safe Load Rayfield
local Rayfield = nil
local loadSuccess, loadError = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not loadSuccess or not Rayfield then
    -- Fallback error
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Failed to load UI. Check internet connection.",
            Duration = 5
        })
    end)
    warn("Rayfield Load Error:", loadError)
    return
end

--// Simple Intro (More Stable)
local function SimpleIntro()
    local success = pcall(function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "PhoenixIntro"
        screenGui.Parent = CoreGui
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.new(0, 0, 0)
        bg.BorderSizePixel = 0
        bg.Parent = screenGui
        
        local logo = Instance.new("TextLabel")
        logo.Size = UDim2.new(0, 600, 0, 100)
        logo.Position = UDim2.new(0.5, -300, 0.5, -50)
        logo.BackgroundTransparency = 1
        logo.Text = "🔥 PHOENIX 🔥"
        logo.TextColor3 = Color3.fromRGB(255, 100, 0)
        logo.TextSize = 72
        logo.Font = Enum.Font.GothamBold
        logo.TextTransparency = 1
        logo.Parent = screenGui
        
        -- Fade in
        TweenService:Create(logo, TweenInfo.new(1), {TextTransparency = 0}):Play()
        task.wait(2)
        -- Fade out
        TweenService:Create(logo, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        task.wait(0.6)
        screenGui:Destroy()
    end)
    
    if not success then
        -- If intro fails, continue anyway
        warn("Intro failed, continuing...")
    end
end

SimpleIntro()

--// Create Window
local Window = Rayfield:CreateWindow({
    Name = "🔥 PHOENIX HUB 🔥",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "By Naser Adm",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhoenixHub",
        FileName = "Settings"
    },
    KeySystem = false,
})

--// Helper Functions
local function Notify(title, content)
    pcall(function()
        Rayfield:Notify({
            Title = tostring(title),
            Content = tostring(content),
            Duration = 3,
            Image = "info"
        })
    end)
end

local function GetCharacter(player)
    return player and player.Character
end

--// IMAGE SYSTEM TAB
local ImageTab = Window:CreateTab("🖼️ Image System", "image")

ImageTab:CreateSection("Load Image From URL")

local urlInput = ""
ImageTab:CreateInput({
    Name = "Direct Image URL",
    PlaceholderText = "https://example.com/image.png",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        urlInput = text
    end
})

ImageTab:CreateButton({
    Name = "📥 Load Image",
    Callback = function()
        if urlInput == "" or not urlInput:find("http") then
            Notify("Error", "Please enter valid URL!")
            return
        end
        
        pcall(function()
            -- Create the image part
            local part = Instance.new("Part")
            part.Name = "PhoenixImage"
            part.Size = Vector3.new(getgenv().ImageSize, 0.2, getgenv().ImageSize)
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0
            part.Position = LocalPlayer.Character and LocalPlayer.Character:GetPivot().Position + Vector3.new(0, 5, 0) or Vector3.new(0, 10, 0)
            part.Parent = Workspace
            
            -- Create surface gui for better image display
            local surfaceGui = Instance.new("SurfaceGui")
            surfaceGui.Face = Enum.NormalId.Top
            surfaceGui.CanvasSize = Vector2.new(100, 100)
            surfaceGui.Parent = part
            
            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(1, 0, 1, 0)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Image = urlInput
            imageLabel.Parent = surfaceGui
            
            -- Also add decal for visibility from sides
            for _, face in pairs({Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Left, Enum.NormalId.Right}) do
                local decal = Instance.new("Decal")
                decal.Texture = urlInput
                decal.Face = face
                decal.Parent = part
            end
            
            -- Store reference
            if getgenv().LoadedImage then
                getgenv().LoadedImage:Destroy()
            end
            getgenv().LoadedImage = part
            
            -- Enable placement mode
            getgenv().ImagePlacementMode = true
            
            Notify("✅ Success", "Image loaded! Click anywhere to place it.")
        end)
    end
})

ImageTab:CreateToggle({
    Name = "✋ Click To Place Mode",
    CurrentValue = false,
    Callback = function(value)
        getgenv().ImagePlacementMode = value
        if value then
            Notify("Placement Mode", "Click on ground to place image")
        end
    end
})

ImageTab:CreateSlider({
    Name = "Image Size",
    Min = 1,
    Max = 50,
    Default = 10,
    Increment = 1,
    ValueName = "Studs",
    Callback = function(value)
        getgenv().ImageSize = value
        if getgenv().LoadedImage then
            getgenv().LoadedImage.Size = Vector3.new(value, 0.2, value)
        end
    end
})

ImageTab:CreateSlider({
    Name = "Image Height",
    Min = 0,
    Max = 100,
    Default = 3,
    Increment = 1,
    ValueName = "Studs",
    Callback = function(value)
        getgenv().ImageHeight = value
        if getgenv().LoadedImage then
            local pos = getgenv().LoadedImage.Position
            getgenv().LoadedImage.Position = Vector3.new(pos.X, value, pos.Z)
        end
    end
})

ImageTab:CreateToggle({
    Name = "🔄 Spin Animation",
    CurrentValue = false,
    Callback = function(value)
        getgenv().SpinEnabled = value
    end
})

ImageTab:CreateToggle({
    Name = "⬆️ Float Animation",
    CurrentValue = false,
    Callback = function(value)
        getgenv().FloatEnabled = value
    end
})

ImageTab:CreateButton({
    Name = "🗑️ Delete Image",
    Callback = function()
        if getgenv().LoadedImage then
            getgenv().LoadedImage:Destroy()
            getgenv().LoadedImage = nil
            Notify("Deleted", "Image removed")
        end
    end
})

--// Click Placement Handler
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not getgenv().ImagePlacementMode then return end
    if not getgenv().LoadedImage then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = Mouse.Hit
        if mousePos then
            local targetPos = Vector3.new(mousePos.Position.X, getgenv().ImageHeight, mousePos.Position.Z)
            
            TweenService:Create(getgenv().LoadedImage, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Position = targetPos
            }):Play()
            
            getgenv().ImagePlacementMode = false
            Notify("Placed!", "Image positioned successfully")
        end
    end
end)

--// Animation Loop
RunService.Heartbeat:Connect(function()
    local img = getgenv().LoadedImage
    if img and img.Parent then
        if getgenv().SpinEnabled then
            img.CFrame = img.CFrame * CFrame.Angles(0, math.rad(2), 0)
        end
        
        if getgenv().FloatEnabled then
            local baseY = getgenv().ImageHeight
            img.Position = Vector3.new(
                img.Position.X,
                baseY + math.sin(tick() * 2) * 0.5,
                img.Position.Z
            )
        end
    end
end)

--// COMBAT TAB
local CombatTab = Window:CreateTab("👊 Combat", "sword")

CombatTab:CreateSection("Player Selector")

local targetList = {}
local selectedTarget = nil

local targetDropdown = CombatTab:CreateDropdown({
    Name = "Select Target",
    Options = {},
    CurrentOption = "None",
    Callback = function(option)
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Name == option then
                selectedTarget = player
                break
            end
        end
    end
})

-- Refresh function
local function RefreshTargets()
    targetList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(targetList, player.Name)
        end
    end
    
    -- Update dropdown (rebuild)
    pcall(function()
        -- Rayfield doesn't have direct update, so we notify
        targetDropdown:Refresh(targetList)
    end)
end

CombatTab:CreateButton({
    Name = "🔄 Refresh List",
    Callback = function()
        RefreshTargets()
        Notify("Refreshed", "Found " .. #targetList .. " players")
    end
})

-- Auto refresh
Players.PlayerAdded:Connect(RefreshTargets)
Players.PlayerRemoving:Connect(RefreshTargets)
task.spawn(function()
    while true do
        RefreshTargets()
        task.wait(5)
    end
end)

CombatTab:CreateSection("Combat Actions")

CombatTab:CreateButton({
    Name = "💥 Punch Target",
    Callback = function()
        if not selectedTarget then
            Notify("Error", "Select a target first!")
            return
        end
        
        local localChar = GetCharacter(LocalPlayer)
        local targetChar = GetCharacter(selectedTarget)
        
        if not localChar or not targetChar then
            Notify("Error", "Character not found!")
            return
        end
        
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        
        if localRoot and targetRoot then
            -- Tween to target
            local distance = (targetRoot.Position - localRoot.Position).Magnitude
            if distance > 5 then
                local tween = TweenService:Create(localRoot, TweenInfo.new(0.3), {
                    CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 0, 4), targetRoot.Position)
                })
                tween:Play()
                tween.Completed:Wait()
            end
            
            -- Animation
            local hum = localChar:FindFirstChildOfClass("Humanoid")
            if hum then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://204062532"
                local track = hum:LoadAnimation(anim)
                track:Play()
            end
            
            -- Effect
            local effect = Instance.new("Part")
            effect.Shape = Enum.PartType.Ball
            effect.Size = Vector3.new(1, 1, 1)
            effect.Color = Color3.fromRGB(255, 0, 0)
            effect.Material = Enum.Material.Neon
            effect.Anchored = true
            effect.Position = targetRoot.Position
            effect.Parent = Workspace
            
            TweenService:Create(effect, TweenInfo.new(0.2), {
                Size = Vector3.new(3, 3, 3),
                Transparency = 1
            }):Play()
            
            Debris:AddItem(effect, 0.3)
            
            -- Damage
            local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
            if targetHum then
                targetHum:TakeDamage(20)
                Notify("Hit!", "Dealt 20 damage to " .. selectedTarget.Name)
            end
        end
    end
})

--// MOVEMENT TAB
local MovementTab = Window:CreateTab("🏃 Movement", "zap")

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    ValueName = "Speed",
    Callback = function(value)
        local char = GetCharacter(LocalPlayer)
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = value end
        end
    end
})

MovementTab:CreateSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,
    Increment = 1,
    ValueName = "Power",
    Callback = function(value)
        local char = GetCharacter(LocalPlayer)
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = value end
        end
    end
})

MovementTab:CreateToggle({
    Name = "✈️ Fly Mode",
    CurrentValue = false,
    Callback = function(value)
        getgenv().FlyEnabled = value
        local char = GetCharacter(LocalPlayer)
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        if value then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlyVel"
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.zero
            bv.Parent = root
            
            local bg = Instance.new("BodyGyro")
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(4000, 4000, 4000)
            bg.P = 100
            bg.Parent = root
            
            Notify("Fly Enabled", "Use WASD + Space/Shift")
        else
            for _, v in ipairs(root:GetChildren()) do
                if v.Name == "FlyVel" or v.Name == "FlyGyro" then
                    v:Destroy()
                end
            end
        end
    end
})

-- Fly Control
RunService.RenderStepped:Connect(function()
    if not getgenv().FlyEnabled then return end
    
    local char = GetCharacter(LocalPlayer)
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local vel = root:FindFirstChild("FlyVel")
    local gyro = root:FindFirstChild("FlyGyro")
    
    if vel and gyro then
        local cam = Workspace.CurrentCamera
        local dir = Vector3.zero
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            dir = dir + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            dir = dir - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            dir = dir - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            dir = dir + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            dir = dir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            dir = dir - Vector3.new(0, 1, 0)
        end
        
        vel.Velocity = dir * 50
        gyro.CFrame = cam.CFrame
    end
end)

--// VISUALS TAB
local VisualsTab = Window:CreateTab("👁️ Visuals", "eye")

VisualsTab:CreateToggle({
    Name = "👤 Player ESP",
    CurrentValue = false,
    Callback = function(value)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = GetCharacter(player)
                if char then
                    if value then
                        if not char:FindFirstChild("ESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "ESP"
                            hl.FillColor = Color3.fromRGB(0, 255, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.Parent = char
                        end
                    else
                        local esp = char:FindFirstChild("ESP")
                        if esp then esp:Destroy() end
                    end
                end
            end
        end
    end
})

VisualsTab:CreateButton({
    Name = "🌈 Rainbow Body",
    Callback = function()
        local char = GetCharacter(LocalPlayer)
        if not char then return end
        
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                task.spawn(function()
                    while part and part.Parent do
                        part.Color = Color3.fromHSV((tick() % 5) / 5, 1, 1)
                        task.wait(0.1)
                    end
                end)
            end
        end
        Notify("Rainbow", "Applied rainbow effect!")
    end
})

--// Final Load
task.wait(0.5)
Notify("🔥 PHOENIX LOADED!", "Welcome " .. LocalPlayer.Name)
print("Phoenix Hub Loaded | By Naser Adm")
