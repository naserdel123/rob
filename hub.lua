-- NOS HUB ULTIMATE - Naser Adm
-- Silent Execution | Undetectable | Feature Packed
-- Optimized for Steal & Brinrod | Server-Side Bypass V4

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local Stats = game:GetService("Stats")
local NetworkClient = game:GetService("NetworkClient")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

--// Anti Detection System
local NosHub = {
   Active = true,
   Hidden = true,
   ServerBypass = true,
   
   -- Steal Features
   AutoSteal = false,
   SilentSteal = false,
   AutoDrop = false,
   StealRange = 20,
   TPBase = nil,
   SafeMode = false,
   
   -- Movement
   Noclip = false,
   Speed = 16,
   Fly = false,
   FlySpeed = 60,
   InfJump = false,
   InfSpin = false,
   SpinSpeed = 150,
   Float = false,
   Desync = false,
   AntiRagdoll = false,
   Jesus = false,
   AutoStrafe = false,
   
   -- Combat
   Aimbot = false,
   SilentAim = false,
   AutoKill = false,
   Reach = false,
   ReachRange = 20,
   Invisible = false,
   GodMode = false,
   AntiAim = false,
   KillAura = false,
   OneShot = false,
   
   -- Visuals
   ESP = false,
   Chams = false,
   Tracers = false,
   Boxes = false,
   Skeleton = false,
   ItemESP = false,
   Fullbright = false,
   NoFog = false,
   XRay = false,
   
   -- Utilities
   AntiAFK = false,
   FPSBoost = false,
   AutoFarm = false,
   ServerHop = false,
   Rejoin = false,
   
   -- Steal Specific
   AutoRob = false,
   SafeESP = false,
   DrillingESP = false,
   PoliceESP = false,
   AutoEscape = false,
   InfiniteAmmo = false,
   NoRecoil = false,
   RapidFire = false
}

--// Stealth Loader
local function StealthLoad()
   local success, Rayfield = pcall(function()
       return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
   end)
   
   if not success then
       warn("Rayfield Load Failed - Using Backup")
       Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
   end
   
   return Rayfield
end

local Rayfield = StealthLoad()

--// Anti-Detection Variables
local OldNameCall = nil
local OldIndex = nil
local NetworkStats = {}
local LastCFrame = HumanoidRootPart.CFrame
local FakeCFrame = HumanoidRootPart.CFrame

--// Silent Execution GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoreGui_" .. tostring(math.random(1000,9999))
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Epic Intro Frame
local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "Intro"
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

-- Animated Background
local BGGradient = Instance.new("UIGradient")
BGGradient.Color = ColorSequence.new({
   ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
   ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 200, 100)),
   ColorSequenceKeypoint.new(0.6, Color3.fromRGB(50, 255, 150)),
   ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 200))
})
BGGradient.Rotation = 0
BGGradient.Parent = IntroFrame

-- Matrix Rain Effect
local MatrixFrame = Instance.new("Frame")
MatrixFrame.Size = UDim2.new(1, 0, 1, 0)
MatrixFrame.BackgroundTransparency = 1
MatrixFrame.Parent = IntroFrame

spawn(function()
   local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789نوسهوبمطرودصاعقة"
   while IntroFrame.Parent do
       local label = Instance.new("TextLabel")
       label.Text = chars:sub(math.random(1, #chars), math.random(1, #chars))
       label.Size = UDim2.new(0, 20, 0, 20)
       label.Position = UDim2.new(math.random(), 0, -0.1, 0)
       label.TextColor3 = Color3.fromRGB(0, 255, 100)
       label.BackgroundTransparency = 1
       label.Font = Enum.Font.Code
       label.TextSize = 14
       label.Parent = MatrixFrame
       
       TweenService:Create(label, TweenInfo.new(math.random(2, 4)), {
           Position = UDim2.new(label.Position.X.Scale, 0, 1.1, 0),
           TextTransparency = 1
       }):Play()
       
       game:GetService("Debris"):AddItem(label, 4)
       task.wait(0.05)
   end
end)

-- Central Logo
local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 400, 0, 400)
LogoContainer.Position = UDim2.new(0.5, -200, 0.4, -200)
LogoContainer.BackgroundTransparency = 1
LogoContainer.Parent = IntroFrame

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(1, 0, 1, 0)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = "rbxassetid://11141271480"
LogoImage.ImageColor3 = Color3.fromRGB(0, 255, 150)
LogoImage.Parent = LogoContainer

-- Neon Glow Rings
for i = 1, 3 do
   local ring = Instance.new("ImageLabel")
   ring.Size = UDim2.new(1 + (i*0.3), 0, 1 + (i*0.3), 0)
   ring.Position = UDim2.new(-0.15 - (i*0.15), 0, -0.15 - (i*0.15), 0)
   ring.BackgroundTransparency = 1
   ring.Image = "rbxassetid://1082804798"
   ring.ImageColor3 = Color3.fromRGB(0, 255, 100)
   ring.ImageTransparency = 0.7 + (i*0.1)
   ring.Parent = LogoContainer
   
   spawn(function()
       while ring.Parent do
           TweenService:Create(ring, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
               Rotation = ring.Rotation + 180,
               ImageTransparency = 0.5 + (i*0.1)
           }):Play()
           task.wait(2)
       end
   end)
end

-- Title with Glitch Effect
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 600, 0, 100)
TitleLabel.Position = UDim2.new(0.5, -300, 0.7, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.Text = "نوس هوب"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
TitleLabel.TextSize = 96
TitleLabel.TextStrokeTransparency = 0
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 50)
TitleLabel.Parent = IntroFrame

-- Glitch Animation
spawn(function()
   local glitchTexts = {"نوس هوب", "NOS HUB", "نـوس هـوب", "N@S HUB", "نوس_هوب"}
   while TitleLabel.Parent do
       TitleLabel.Text = glitchTexts[math.random(1, #glitchTexts)]
       TitleLabel.TextColor3 = Color3.fromRGB(math.random(0, 100), 255, math.random(100, 200))
       task.wait(0.1)
       TitleLabel.Text = "نوس هوب"
       TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
       task.wait(math.random(1, 3))
   end
end)

-- Subtitle
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 500, 0, 40)
SubTitle.Position = UDim2.new(0.5, -250, 0.82, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Font = Enum.Font.GothamBold
SubTitle.Text = "ULTIMATE EDITION | NASER ADM"
SubTitle.TextColor3 = Color3.fromRGB(150, 255, 150)
SubTitle.TextSize = 24
SubTitle.Parent = IntroFrame

-- Loading Bar
local LoadingBarBg = Instance.new("Frame")
LoadingBarBg.Size = UDim2.new(0, 400, 0, 6)
LoadingBarBg.Position = UDim2.new(0.5, -200, 0.9, 0)
LoadingBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LoadingBarBg.BorderSizePixel = 0
LoadingBarBg.Parent = IntroFrame

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(0, 3)
LoadingBarCorner.Parent = LoadingBarBg

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = LoadingBarBg

local LoadingBarCorner2 = Instance.new("UICorner")
LoadingBarCorner2.CornerRadius = UDim.new(0, 3)
LoadingBarCorner2.Parent = LoadingBar

-- Loading Animation
spawn(function()
   TweenService:Create(LoadingBar, TweenInfo.new(3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 1, 0)}):Play()
   
   for i = 1, 10 do
       SubTitle.Text = "Loading Modules... [" .. (i*10) .. "%]"
       task.wait(0.3)
   end
   
   task.wait(0.5)
   
   -- Fade Out
   TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
   for _, child in pairs(IntroFrame:GetDescendants()) do
       if child:IsA("GuiObject") then
           TweenService:Create(child, TweenInfo.new(0.8), {TextTransparency = 1, ImageTransparency = 1}):Play()
       end
   end
   
   task.wait(1)
   IntroFrame:Destroy()
   InitializeUltimateGUI()
end)

--// Anti-Detection Metamethod Hooks
local mt = getrawmetatable(game)
setreadonly(mt, false)
OldNameCall = hookfunction(mt.__namecall, newcclosure(function(self, ...)
   local method = getnamecallmethod()
   local args = {...}
   
   if NosHub.ServerBypass and (method == "FireServer" or method == "InvokeServer") then
       if tostring(self):lower():find("kick") or tostring(self):lower():find("ban") then
           return nil
       end
       if tostring(self):lower():find("cheat") or tostring(self):lower():find("hack") then
           return nil
       end
       if tostring(self):lower():find("report") then
           return nil
       end
   end
   
   return OldNameCall(self, unpack(args))
end))

OldIndex = hookfunction(mt.__index, newcclosure(function(self, key)
   if NosHub.Hidden and key == "CFrame" and self == HumanoidRootPart then
       return FakeCFrame
   end
   return OldIndex(self, key)
end))

--// Server Bypass System
spawn(function()
   while true do
       if NosHub.ServerBypass then
           -- Spoof Network
           local success, err = pcall(function()
               if HumanoidRootPart then
                   LastCFrame = HumanoidRootPart.CFrame
                   FakeCFrame = LastCFrame * CFrame.new(math.random(-0.1, 0.1), 0, math.random(-0.1, 0.1))
               end
           end)
           
           -- Anti-Idle
           VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame)
           task.wait(0.1)
           VirtualUser:Button2Up(Vector2.new(0,0), Camera.CFrame)
       end
       task.wait(math.random(5, 15))
   end
end)

--// Main GUI
function InitializeUltimateGUI()
   local Window = Rayfield:CreateWindow({
       Name = "نوس هوب التيميت | Nos Hub Ultimate",
       LoadingTitle = "جاري التحميل...",
       LoadingSubtitle = "by Naser Adm",
       Theme = "Green",
       ConfigurationSaving = {
           Enabled = false
       },
       Discord = {
           Enabled = true,
           Invite = "DzVBbDKN",
           RememberJoins = true
       },
       KeySystem = false
   })

   --// TAB: سرقة أوتو (Auto Steal)
   local StealTab = Window:CreateTab("سرقة أوتو", "rbxassetid://10747372939")
   
   StealTab:CreateSection("نظام السرقة المتقدم")
   
   StealTab:CreateToggle({
       Name = "Silent Auto Steal (غير مرئي)",
       CurrentValue = false,
       Flag = "SilentSteal",
       Callback = function(Value)
           NosHub.SilentSteal = Value
           if Value then
               spawn(function()
                   while NosHub.SilentSteal do
                       for _, player in pairs(Players:GetPlayers()) do
                           if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                               local targetPos = player.Character.HumanoidRootPart.Position
                               local myPos = HumanoidRootPart.Position
                               local distance = (targetPos - myPos).Magnitude
                               
                               if distance <= NosHub.StealRange then
                                   -- Silent teleport with jitter
                                   local jitter = Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))
                                   local oldPos = HumanoidRootPart.CFrame
                                   
                                   -- Instant grab
                                   HumanoidRootPart.CFrame = CFrame.new(targetPos + jitter)
                                   task.wait(0.03)
                                   HumanoidRootPart.CFrame = oldPos
                                   
                                   -- Random delay to avoid pattern detection
                                   task.wait(math.random(0.1, 0.3))
                               end
                           end
                       end
                       task.wait(0.05)
                   end
               end)
           end
       end
   })

   StealTab:CreateSlider({
       Name = "مدى السرقة",
       Range = {5, 50},
       Increment = 1,
       Suffix = "Studs",
       CurrentValue = 20,
       Flag = "StealRange",
       Callback = function(Value)
           NosHub.StealRange = Value
       end
   })

   StealTab:CreateToggle({
       Name = "Auto Drop (إسقاط تلقائي)",
       CurrentValue = false,
       Flag = "AutoDrop",
       Callback = function(Value)
           NosHub.AutoDrop = Value
           if Value then
               spawn(function()
                   while NosHub.AutoDrop do
                       -- Auto drop logic for Steal & Brinrod
                       local backpack = LocalPlayer:FindFirstChild("Backpack")
                       if backpack then
                           for _, item in pairs(backpack:GetChildren()) do
                               if item:IsA("Tool") then
                                   -- Equip and drop
                                   Humanoid:EquipTool(item)
                                   task.wait(0.1)
                                   -- Drop command
                                   local dropEvent = ReplicatedStorage:FindFirstChild("DropTool") or ReplicatedStorage:FindFirstChild("Drop")
                                   if dropEvent then
                                       dropEvent:FireServer()
                                   end
                               end
                           end
                       end
                       task.wait(0.5)
                   end
               end)
           end
       end
   })

   StealTab:CreateToggle({
       Name = "Safe Mode (وضع الأمان)",
       CurrentValue = false,
       Flag = "SafeMode",
       Callback = function(Value)
           NosHub.SafeMode = Value
       end
   })

   StealTab:CreateButton({
       Name = "TP to Base (سريع + آمن)",
       Callback = function()
           if NosHub.TPBase then
               -- Break velocity
               if HumanoidRootPart:FindFirstChild("BodyVelocity") then
                   HumanoidRootPart.BodyVelocity:Destroy()
               end
               
               -- Instant TP with cover
               local oldCFrame = HumanoidRootPart.CFrame
               HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
               HumanoidRootPart.CFrame = NosHub.TPBase
               
               Rayfield:Notify({
                   Title = "نوس هوب",
                   Content = "تم الانتقال للقاعدة!",
                   Duration = 2
               })
           end
       end
   })

   StealTab:CreateButton({
       Name = "حفظ موقع القاعدة",
       Callback = function()
           NosHub.TPBase = HumanoidRootPart.CFrame
           Rayfield:Notify({
               Title = "نوس هوب",
               Content = "تم حفظ القاعدة!",
               Duration = 2
           })
       end
   })

   --// TAB: حركة (Movement)
   local MoveTab = Window:CreateTab("حركة", "rbxassetid://10747383810")
   
   MoveTab:CreateSection("الحركة المتقدمة")
   
   MoveTab:CreateToggle({
       Name = "Desync V4 (صعب الضرب)",
       CurrentValue = false,
       Flag = "DesyncV4",
       Callback = function(Value)
           NosHub.Desync = Value
           if Value then
               spawn(function()
                   while NosHub.Desync do
                       local realPos = HumanoidRootPart.CFrame
                       -- Fake position for server
                       HumanoidRootPart.CFrame = realPos * CFrame.new(math.random(-15, 15), 0, math.random(-15, 15))
                       task.wait(0.05)
                       HumanoidRootPart.CFrame = realPos
                       task.wait(math.random(0.1, 0.2))
                   end
               end)
           end
       end
   })

   MoveTab:CreateToggle({
       Name = "Noclip (تجاوز الجدران)",
       CurrentValue = false,
       Flag = "Noclip",
       Callback = function(Value)
           NosHub.Noclip = Value
           spawn(function()
               while NosHub.Noclip do
                   for _, part in pairs(Character:GetDescendants()) do
                       if part:IsA("BasePart") then
                           part.CanCollide = false
                       end
                   end
                   task.wait()
               end
               for _, part in pairs(Character:GetDescendants()) do
                   if part:IsA("BasePart") then
                       part.CanCollide = true
                   end
               end
           end)
       end
   })

   MoveTab:CreateSlider({
       Name = "سرعة الحركة",
       Range = {16, 500},
       Increment = 1,
       Suffix = "Speed",
       CurrentValue = 16,
       Flag = "Speed",
       Callback = function(Value)
           NosHub.Speed = Value
           Humanoid.WalkSpeed = Value
       end
   })

   MoveTab:CreateToggle({
       Name = "Fly V3 (طيران متقدم)",
       CurrentValue = false,
       Flag = "FlyV3",
       Callback = function(Value)
           NosHub.Fly = Value
           if Value then
               local BV = Instance.new("BodyVelocity")
               local BG = Instance.new("BodyGyro")
               BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
               BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
               BG.P = 10000
               BV.Parent = HumanoidRootPart
               BG.Parent = HumanoidRootPart
               
               spawn(function()
                   while NosHub.Fly do
                       local dir = Vector3.new(0, 0, 0)
                       if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                       if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir + Vector3.new(0, -1, 0) end
                       if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                       if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                       if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                       if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                       
                       BV.Velocity = dir * NosHub.FlySpeed
                       BG.CFrame = Camera.CFrame
                       task.wait()
                   end
                   BV:Destroy()
                   BG:Destroy()
               end)
           end
       end
   })

   MoveTab:CreateToggle({
       Name = "Infinite Jump",
       CurrentValue = false,
       Flag = "InfJump",
       Callback = function(Value)
           NosHub.InfJump = Value
       end
   })

   UserInputService.InputBegan:Connect(function(input, gpe)
       if NosHub.InfJump and input.KeyCode == Enum.KeyCode.Space and not gpe then
           Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
       end
   end)

   MoveTab:CreateToggle({
       Name = "Infinite Spin (دوران سريع)",
       CurrentValue = false,
       Flag = "InfSpin",
       Callback = function(Value)
           NosHub.InfSpin = Value
           spawn(function()
               while NosHub.Inf
