-- NOS HUB - Naser Adm
-- LocalScript for Delta/Arceus X/Hydrogen Executors
-- Complete GUI with Splash Screen & Rayfield Library

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

--// Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Variables
local NosHub = {
   Active = true,
   AutoSteal = false,
   TPBase = nil,
   Noclip = false,
   Fly = false,
   FlySpeed = 50,
   InfJump = false,
   InfSpin = false,
   Float = false,
   Desync = false,
   AntiRagdoll = false,
   Aimbot = false,
   Invisible = false,
   GodMode = false,
   ESP = false,
   AntiAFK = false,
   Speed = 16,
   SpinSpeed = 100
}

--// Create Splash Screen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NosHubSplash"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local SplashFrame = Instance.new("Frame")
SplashFrame.Name = "SplashFrame"
SplashFrame.Size = UDim2.new(1, 0, 1, 0)
SplashFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SplashFrame.BorderSizePixel = 0
SplashFrame.Parent = ScreenGui

-- Gradient Background
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
   ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 150)),
   ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 150, 255)),
   ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 200))
})
UIGradient.Rotation = 45
UIGradient.Parent = SplashFrame

-- Animated color loop
spawn(function()
   while SplashFrame.Parent do
       for i = 0, 360, 2 do
           if not SplashFrame.Parent then break end
           UIGradient.Rotation = i
           UIGradient.Color = ColorSequence.new({
               ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100 + math.sin(i/30)*50)),
               ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 100 + math.cos(i/30)*100, 255)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(50 + math.sin(i/20)*50, 255, 150))
           })
           task.wait(0.05)
       end
   end
end)

-- Glassmorphism overlay
local GlassOverlay = Instance.new("Frame")
GlassOverlay.Name = "GlassOverlay"
GlassOverlay.Size = UDim2.new(1, 0, 1, 0)
GlassOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlassOverlay.BackgroundTransparency = 0.85
GlassOverlay.BorderSizePixel = 0
GlassOverlay.Parent = SplashFrame

-- Goku Image
local GokuImage = Instance.new("ImageLabel")
GokuImage.Name = "GokuImage"
GokuImage.Size = UDim2.new(0, 400, 0, 400)
GokuImage.Position = UDim2.new(0.5, -200, 0.4, -200)
GokuImage.BackgroundTransparency = 1
GokuImage.Image = "rbxassetid://11141271480"
GokuImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
GokuImage.Parent = SplashFrame

-- Glow effect
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://1082804798"
Glow.ImageColor3 = Color3.fromRGB(0, 255, 150)
Glow.ImageTransparency = 0.6
Glow.Parent = GokuImage

-- Continuous rotation animation
spawn(function()
   while GokuImage.Parent do
       local tween = TweenService:Create(GokuImage, TweenInfo.new(20, Enum.EasingStyle.Linear), {Rotation = GokuImage.Rotation + 360})
       tween:Play()
       tween.Completed:Wait()
   end
end)

-- Pulse animation
spawn(function()
   while Glow.Parent do
       local pulse1 = TweenService:Create(Glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.3, Size = UDim2.new(1.8, 0, 1.8, 0)})
       local pulse2 = TweenService:Create(Glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.7, Size = UDim2.new(1.5, 0, 1.5, 0)})
       pulse1:Play()
       pulse1.Completed:Wait()
       pulse2:Play()
       pulse2.Completed:Wait()
   end
end)

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(0, 600, 0, 80)
TitleLabel.Position = UDim2.new(0.5, -300, 0.7, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "نوس هوب"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextStrokeTransparency = 0
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 150)
TitleLabel.TextSize = 72
TitleLabel.Parent = SplashFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(0, 400, 0, 40)
SubTitle.Position = UDim2.new(0.5, -200, 0.78, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "NOS HUB - Naser Adm"
SubTitle.TextColor3 = Color3.fromRGB(200, 255, 200)
SubTitle.TextSize = 28
SubTitle.Parent = SplashFrame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseSplash"
CloseButton.Size = UDim2.new(0, 300, 0, 60)
CloseButton.Position = UDim2.new(0.5, -150, 0.88, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
CloseButton.BackgroundTransparency = 0.2
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "إغلاق السبلاش | ENTER"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.AutoButtonColor = false
CloseButton.Parent = SplashFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 12)
ButtonCorner.Parent = CloseButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(0, 255, 150)
ButtonStroke.Thickness = 3
ButtonStroke.Parent = CloseButton

-- Button animations
CloseButton.MouseEnter:Connect(function()
   TweenService:Create(CloseButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 150), Size = UDim2.new(0, 320, 0, 65)}):Play()
end)

CloseButton.MouseLeave:Connect(function()
   TweenService:Create(CloseButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 100), Size = UDim2.new(0, 300, 0, 60)}):Play()
end)

CloseButton.MouseButton1Down:Connect(function()
   TweenService:Create(CloseButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 280, 0, 55)}):Play()
end)

-- Close function
local function CloseSplash()
   local fadeOut = TweenService:Create(SplashFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
   fadeOut:Play()
   
   for _, child in pairs(SplashFrame:GetDescendants()) do
       if child:IsA("GuiObject") then
           TweenService:Create(child, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1, ImageTransparency = 1}):Play()
       end
   end
   
   fadeOut.Completed:Wait()
   ScreenGui:Destroy()
   InitializeMainGUI()
end

CloseButton.MouseButton1Click:Connect(CloseSplash)
UserInputService.InputBegan:Connect(function(input)
   if input.KeyCode == Enum.KeyCode.Return then
       CloseSplash()
   end
end)

--// Main GUI Function
function InitializeMainGUI()
   local Window = Rayfield:CreateWindow({
       Name = "نوس هوب | Nos Hub",
       LoadingTitle = "جاري تحميل نوس هوب...",
       LoadingSubtitle = "by Naser Adm",
       ConfigurationSaving = {
           Enabled = false,
           FolderName = nil,
           FileName = nil
       },
       Discord = {
           Enabled = true,
           Invite = "DzVBbDKN",
           RememberJoins = true
       },
       KeySystem = false
   })

   --// Tab 1: Auto Steal
   local AutoStealTab = Window:CreateTab("سرقة أوتو", "rbxassetid://10747372939")
   
   AutoStealTab:CreateToggle({
       Name = "Auto Steal",
       CurrentValue = false,
       Flag = "AutoSteal",
       Callback = function(Value)
           NosHub.AutoSteal = Value
           if Value then
               spawn(function()
                   while NosHub.AutoSteal do
                       -- Auto steal logic
                       for _, player in pairs(Players:GetPlayers()) do
                           if player ~= LocalPlayer and player.Character then
                               local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
                               if targetHRP and (LocalPlayer.Character.HumanoidRootPart.Position - targetHRP.Position).Magnitude < 20 then
                                   -- Steal mechanism with bypass
                                   local offset = Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
                                   local tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, 
                                       TweenInfo.new(0.1, Enum.EasingStyle.Linear), 
                                       {CFrame = targetHRP.CFrame * CFrame.new(offset)})
                                   tween:Play()
                               end
                           end
                       end
                       task.wait(0.1)
                   end
               end)
           end
       end
   })

   AutoStealTab:CreateButton({
       Name = "TP Home (Smooth)",
       Callback = function()
           if NosHub.TPBase then
               local offset = Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
               local tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart,
                   TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                   {CFrame = NosHub.TPBase * CFrame.new(offset)})
               tween:Play()
           else
               Rayfield:Notify({
                   Title = "نوس هوب",
                   Content = "لم يتم حفظ القاعدة بعد!",
                   Duration = 3,
                   Image = "rbxassetid://10747372939"
               })
           end
       end
   })

   AutoStealTab:CreateButton({
       Name = "حفظ موقع القاعدة",
       Callback = function()
           NosHub.TPBase = LocalPlayer.Character.HumanoidRootPart.CFrame
           Rayfield:Notify({
               Title = "نوس هوب",
               Content = "تم حفظ القاعدة!",
               Duration = 3,
               Image = "rbxassetid://10747372939"
           })
       end
   })

   --// Tab 2: Movement
   local MovementTab = Window:CreateTab("حركة", "rbxassetid://10747383810")

   MovementTab:CreateToggle({
       Name = "Noclip",
       CurrentValue = false,
       Flag = "Noclip",
       Callback = function(Value)
           NosHub.Noclip = Value
           if Value then
               spawn(function()
                   while NosHub.Noclip and RunService.Stepped:Wait() do
                       for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                           if part:IsA("BasePart") then
                               part.CanCollide = false
                           end
                       end
                   end
               end)
           else
               for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                   if part:IsA("BasePart") then
                       part.CanCollide = true
                   end
               end
           end
       end
   })

   MovementTab:CreateSlider({
       Name = "Speed",
       Range = {16, 300},
       Increment = 1,
       Suffix = "Speed",
       CurrentValue = 16,
       Flag = "SpeedSlider",
       Callback = function(Value)
           NosHub.Speed = Value
           if Humanoid then
               Humanoid.WalkSpeed = Value
           end
       end
   })

   MovementTab:CreateToggle({
       Name = "Fly (Space ↑ | Shift ↓)",
       CurrentValue = false,
       Flag = "Fly",
       Callback = function(Value)
           NosHub.Fly = Value
           if Value then
               local BodyGyro = Instance.new("BodyGyro")
               local BodyVelocity = Instance.new("BodyVelocity")
               BodyGyro.P = 9e4
               BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
               BodyGyro.CFrame = Camera.CFrame
               BodyVelocity.Velocity = Vector3.new(0, 0, 0)
               BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
               BodyGyro.Parent = HumanoidRootPart
               BodyVelocity.Parent = HumanoidRootPart
               
               spawn(function()
                   while NosHub.Fly and BodyVelocity.Parent do
                       local speed = NosHub.FlySpeed
                       local direction = Vector3.new(0, 0, 0)
                       
                       if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                           direction = direction + Vector3.new(0, 1, 0)
                       end
                       if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                           direction = direction + Vector3.new(0, -1, 0)
                       end
                       
                       BodyVelocity.Velocity = direction * speed
                       BodyGyro.CFrame = Camera.CFrame
                       task.wait()
                   end
                   BodyGyro:Destroy()
                   BodyVelocity:Destroy()
               end)
           end
       end
   })

   MovementTab:CreateSlider({
       Name = "Fly Speed",
       Range = {10, 200},
       Increment = 5,
       Suffix = "Fly Speed",
       CurrentValue = 50,
       Flag = "FlySpeed",
       Callback = function(Value)
           NosHub.FlySpeed = Value
       end
   })

   MovementTab:CreateToggle({
       Name = "Infinite Jump",
       CurrentValue = false,
       Flag = "InfJump",
       Callback = function(Value)
           NosHub.InfJump = Value
       end
   })

   UserInputService.InputBegan:Connect(function(input, gameProcessed)
       if NosHub.InfJump and input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
           Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
       end
   end)

   MovementTab:CreateToggle({
       Name = "Infinite Spin",
       CurrentValue = false,
       Flag = "InfSpin",
       Callback = function(Value)
           NosHub.InfSpin = Value
           if Value then
               spawn(function()
                   while NosHub.InfSpin do
                       LocalPlayer.Character:PivotTo(LocalPlayer.Character:GetPivot() * CFrame.Angles(0, math.rad(NosHub.SpinSpeed/10), 0))
                       task.wait()
                   end
               end)
           end
       end
   })

   MovementTab:CreateSlider({
       Name = "Spin Speed",
       Range = {50, 500},
       Increment = 10,
       Suffix = "Spin Speed",
       CurrentValue = 100,
       Flag = "SpinSpeed",
       Callback = function(Value)
           NosHub.SpinSpeed = Value
       end
   })

   MovementTab:CreateToggle({
       Name = "Float",
       CurrentValue = false,
       Flag = "Float",
       Callback = function(Value)
           NosHub.Float = Value
           if Value then
               local FloatPart = Instance.new("Part")
               FloatPart.Name = "FloatPart"
               FloatPart.Anchored = true
               FloatPart.CanCollide = true
               FloatPart.Transparency = 1
               FloatPart.Size = Vector3.new(6, 1, 6)
               FloatPart.Parent = Workspace
               
               spawn(function()
                   while NosHub.Float and FloatPart.Parent do
                       FloatPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                       task.wait()
                   end
                   FloatPart:Destroy()
               end)
           end
       end
   })

   MovementTab:CreateToggle({
       Name = "Desync V4",
       CurrentValue = false,
       Flag = "Desync",
       Callback = function(Value)
           NosHub.Desync = Value
           if Value then
               spawn(function()
                   while NosHub.Desync do
                       local oldCFrame = HumanoidRootPart.CFrame
                       HumanoidRootPart.CFrame = oldCFrame * CFrame.new(math.random(-10, 10), 0, math.random(-10, 10))
                       task.wait(0.05)
                       HumanoidRootPart.CFrame = oldCFrame
                       task.wait(math.random(0.1, 0.3))
                   end
               end)
           end
       end
   })

   MovementTab:CreateToggle({
       Name = "Anti Ragdoll",
       CurrentValue = false,
       Flag = "AntiRagdoll",
       Callback = function(Value)
           NosHub.AntiRagdoll = Value
           if Value then
               spawn(function()
                   while NosHub.AntiRagdoll do
                       if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
                           Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                       end
                       for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                           if part:IsA("BallSocketConstraint") or part.Name:lower():find("ragdoll") then
                               part:Destroy()
                           end
                       end
                       task.wait(0.1)
                   end
               end)
           end
       end
   })

   --// Tab 3: PVP
   local PVPTab = Window:CreateTab("PVP", "rbxassetid://10747384394")

   PVPTab:CreateToggle({
       Name = "Aimbot",
       CurrentValue = false,
       Flag = "Aimbot",
       Callback = function(Value)
           NosHub.Aimbot = Value
           if Value then
               spawn(function()
                   while NosHub.Aimbot do
                       local closestPlayer = nil
                       local closestDistance = math.huge
                       
                       for _, player in pairs(Players:GetPlayers()) do
                           if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                               local distance = (player.Character.Head.Position - Camera.CFrame.Position).Magnitude
                               if distance < closestDistance and distance < 1000 then
                                   closestDistance = distance
                                   closestPlayer = player
                               end
                           end
                       end
                       
                       if closestPlayer then
                           Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
                       end
                       task.wait()
                   end
               end)
           end
       end
   })

   PVPTab:CreateToggle({
       Name = "Invisible",
       CurrentValue = false,
       Flag = "Invisible",
       Callback = function(Value)
           NosHub.Invisible = Value
           for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
               if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                   part.Transparency = Value and 0.5 or 0
               end
               if part:IsA("Decal") or part:IsA("Texture") then
                   part.Transparency = Value and 0.5 or 0
               end
           end
       end
   })

   PVPTab:CreateToggle({
       Name = "God Mode",
       CurrentValue = false,
       Flag = "GodMode",
       Callback = function(Value)
           NosHub.GodMode = Value
           if Value then
               local oldHealth = Humanoid.MaxHealth
               Humanoid.MaxHealth = math.huge
               Humano
