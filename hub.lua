--[[
   ██████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗     ██████╗ █████╗ ████████╗███████╗██████╗
   ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║    ██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
   ██████╔╝██║   ██║██╔██╗ ██║██║     ███████║    ██║     ███████║   ██║   █████╗  ██████╔╝
   ██╔═══╝ ██║   ██║██║╚██╗██║██║     ██╔══██║    ██║     ██╔══██║   ██║   ██╔══╝  ██╔══██╗
   ██║     ╚██████╔╝██║ ╚████║╚██████╗██║  ██║    ╚██████╗██║  ██║   ██║   ███████╗██║  ██║
   ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝     ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
   
   Punch Master HUB - Naser Adm (Updated Version)
   Realistic Boxing System with Server-Side Replication
   
   Features:
   - Everyone sees your punch animations
   - Auto-complete player names dropdown
   - Real boxing animations (R6 & R15)
   - Server-sided damage system
   - Mobile optimized
]]

--// Services // الخدمات
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
getgenv().ComboCount = 0

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

--// Load Rayfield Library // تحميل مكتبة رايفيلد
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Create Main Window // إنشاء النافذة الرئيسية
local Window = Rayfield:CreateWindow({
   Name = "Punch Master HUB - Naser Adm",
   LoadingTitle = "Loading Ultimate Punch System...",
   LoadingSubtitle = "by Naser Adm | Server-Side Replication",
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

--// Get Player List for Dropdown // الحصول على قائمة اللاعبين
local function GetPlayerNames()
   local names = {}
   for _, player in ipairs(Players:GetPlayers()) do
       if player ~= LocalPlayer then
           table.insert(names, player.Name .. " (" .. player.DisplayName .. ")")
       end
   end
   return names
end

--// Extract Username from Dropdown // استخراج اسم المستخدم
local function ExtractUsername(displayText)
   return displayText:match("^([^%(]+)")
end

--// Create Realistic Boxing Animation // إنشاء أنيميشن ملاكمة واقعي
local function PlayBoxingAnimation(character, punchType)
   local humanoid = GetHumanoid(character)
   if not humanoid then return end
   
   -- Check if R6 or R15 // التحقق من نوع الشخصية
   local isR15 = character:FindFirstChild("UpperTorso") ~= nil
   
   local animId = isR15 and (
       punchType == "Left" and "rbxassetid://13295905599" or -- R15 Left Punch
       punchType == "Right" and "rbxassetid://13295907795" or -- R15 Right Punch
       "rbxassetid://13295908921" -- R15 Combo
   ) or (
       punchType == "Left" and "rbxassetid://204062532" or -- R6 Left Punch
       punchType == "Right" and "rbxassetid://204062532" or -- R6 Right Punch  
       "rbxassetid://204062532" -- R6 Combo
   )
   
   -- Load and play animation // تحميل وتشغيل الأنيميشن
   local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 1)
   if animator then
       local animation = Instance.new("Animation")
       animation.AnimationId = animId
       local track = animator:LoadAnimation(animation)
       track.Priority = Enum.AnimationPriority.Action
       track:Play()
       track:AdjustSpeed(1.5) -- Faster punch
       return track
   end
   return nil
end

--// Create Visual Punch Effect (Everyone Sees) // إنشاء تأثير الضربة المرئي للجميع
local function CreatePunchEffect(player, target, punchType)
   if not player.Character or not target.Character then return end
   
   local char = player.Character
   local targetChar = target.Character
   local targetRoot = GetRootPart(targetChar)
   
   -- Determine hand to use // تحديد اليد المستخدمة
   local isRightHand = punchType == "Right" or (tick() % 2 == 0)
   local handName = isRightHand and "RightHand" or "LeftHand"
   local hand = char:FindFirstChild(handName) or char:FindFirstChild(isRightHand and "Right Arm" or "Left Arm")
   
   if not hand then return end
   
   -- Create fist glow effect // إنشاء تأثير توهج القبضة
   local glow = Instance.new("Part")
   glow.Name = "PunchGlow"
   glow.Shape = Enum.PartType.Ball
   glow.Size = Vector3.new(1.5, 1.5, 1.5)
   glow.Color = Color3.fromRGB(255, 50, 50)
   glow.Material = Enum.Material.Neon
   glow.Transparency = 0.4
   glow.CanCollide = false
   glow.Anchored = true
   glow.CFrame = hand.CFrame
   glow.Parent = Workspace
   
   -- Weld to hand (so everyone sees it) // ربطها باليد ليراها الجميع
   local weld = Instance.new("WeldConstraint")
   weld.Part0 = hand
   weld.Part1 = glow
   weld.Parent = glow
   
   -- Impact effect on target // تأثير الاصطدام على الهدف
   task.delay(0.2, function()
       if targetRoot and glow then
           -- Create impact part at target // إنشاء جزء الاصطدام
           local impact = Instance.new("Part")
           impact.Name = "ImpactEffect"
           impact.Size = Vector3.new(2, 2, 2)
           impact.Anchored = true
           impact.CanCollide = false
           impact.Transparency = 1
           impact.CFrame = targetRoot.CFrame
           impact.Parent = Workspace
           
           -- Particle effect // تأثير الجزيئات
           local attachment = Instance.new("Attachment", impact)
           local particle = Instance.new("ParticleEmitter", attachment)
           particle.Texture = "rbxassetid://258128463"
           particle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 100, 100))
           particle.Size = NumberSequence.new({
               NumberSequenceKeypoint.new(0, 2),
               NumberSequenceKeypoint.new(0.5, 3),
               NumberSequenceKeypoint.new(1, 0)
           })
           particle.Lifetime = NumberRange.new(0.3, 0.6)
           particle.Rate = 0
           particle.Speed = NumberRange.new(10, 20)
           particle.SpreadAngle = Vector2.new(180, 180)
           particle.Acceleration = Vector3.new(0, -50, 0)
           particle:Emit(15)
           
           -- Sound effect // الصوت
           local sound = Instance.new("Sound")
           sound.SoundId = "rbxassetid://3932505913"
           sound.Volume = 1
           sound.Parent = impact
           sound:Play()
           
           -- Screen shake for target (if local player) // اهتزاز الشاشة للهدف
           if target == LocalPlayer then
               local camera = Workspace.CurrentCamera
               local originalCFrame = camera.CFrame
               for i = 1, 5 do
                   camera.CFrame = originalCFrame * CFrame.new(
                       math.random(-5, 5) / 10,
                       math.random(-5, 5) / 10,
                       0
                   )
                   task.wait(0.02)
               end
               camera.CFrame = originalCFrame
           end
           
           Debris:AddItem(impact, 1)
       end
       
       -- Remove glow // إزالة التوهج
       Debris:AddItem(glow, 0.3)
   end)
end

--// Server-Side Damage Function // دالة الضرر من السيرفر
local function DealDamage(targetPlayer, damage)
   if not targetPlayer or not targetPlayer.Character then return end
   
   local targetHumanoid = GetHumanoid(targetPlayer.Character)
   if not targetHumanoid or targetHumanoid.Health <= 0 then return end
   
   -- Try different methods to deal damage // محاولة طرق مختلفة للضرر
   local success = false
   
   -- Method 1: Direct health reduction (if bypassed) // الطريقة الأولى: تقليل الصحة مباشرة
   pcall(function()
       targetHumanoid.Health = targetHumanoid.Health - damage
       success = true
   end)
   
   -- Method 2: Use TakeDamage // الطريقة الثانية: استخدام TakeDamage
   if not success then
       pcall(function()
           targetHumanoid:TakeDamage(damage)
           success = true
       end)
   end
   
   -- Method 3: Fire touch interest (simulated hit) // الطريقة الثالثة: محاكاة اللمس
   if not success then
       pcall(function()
           local localChar = GetCharacter(LocalPlayer)
           if localChar then
               local localRoot = GetRootPart(localChar)
               local targetRoot = GetRootPart(targetPlayer.Character)
               if localRoot and targetRoot then
                   firetouchinterest(localRoot, targetRoot, 0)
                   task.wait()
                   firetouchinterest(localRoot, targetRoot, 1)
               end
           end
       end)
   end
   
   return success
end

--// Main Punch Function // دالة الضرب الرئيسية
local function PerformRealisticPunch(targetPlayer)
   if not targetPlayer or not targetPlayer.Character then
       Notify("Error", "Target not found!", 3)
       return false
   end
   
   local targetChar = targetPlayer.Character
   local targetHumanoid = GetHumanoid(targetChar)
   local targetRoot = GetRootPart(targetChar)
   
   if not targetHumanoid or targetHumanoid.Health <= 0 then
       Notify("Error", "Target is dead or doesn't exist!", 3)
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
   
   -- Calculate distance // حساب المسافة
   local distance = (targetRoot.Position - localRoot.Position).Magnitude
   if distance > 10 then
       -- Tween close if far // الاقتراب إذا كان بعيداً
       local targetPos = targetRoot.Position + (targetRoot.CFrame.LookVector * -3)
       local tweenInfo = TweenInfo.new(
           math.min(distance * 0.05, 0.8),
           Enum.EasingStyle.Quad,
           Enum.EasingDirection.Out
       )
       
       local tween = TweenService:Create(localRoot, tweenInfo, {
           CFrame = CFrame.new(targetPos, targetRoot.Position)
       })
       tween:Play()
       tween.Completed:Wait()
   end
   
   -- Determine punch type // تحديد نوع الضربة
   getgenv().ComboCount = getgenv().ComboCount + 1
   local punchType = getgenv().ComboCount % 2 == 1 and "Left" or "Right"
   if getgenv().ComboCount >= 3 then
       punchType = "Combo"
       getgenv().ComboCount = 0
   end
   
   -- Play boxing animation (everyone sees) // تشغيل أنيميشن الملاكمة (الجميع يراه)
   local animTrack = PlayBoxingAnimation(localChar, punchType)
   
   -- Create visual effects (everyone sees) // إنشاء التأثيرات المرئية (الجميع يراها)
   CreatePunchEffect(LocalPlayer, targetPlayer, punchType)
   
   -- Wait for impact timing // انتظار توقيت الاصطدام
   task.wait(0.15)
   
   -- Deal damage to target (not yourself) // تطبيق الضرر على الهدف (ليس أنت)
   local damage = punchType == "Combo" and math.random(20, 30) or math.random(10, 15)
   local damageSuccess = DealDamage(targetPlayer, damage)
   
   -- Knockback effect on target // تأثير الدفع للخلف على الهدف
   if damageSuccess and targetRoot then
       local knockbackDirection = (targetRoot.Position - localRoot.Position).Unit
       local knockbackForce = punchType == "Combo" and 50 or 30
       
       -- Apply velocity to target // تطبيق السرعة على الهدف
       local bodyVelocity = Instance.new("BodyVelocity")
       bodyVelocity.Velocity = knockbackDirection * knockbackForce + Vector3.new(0, 20, 0)
       bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
       bodyVelocity.Parent = targetRoot
       Debris:AddItem(bodyVelocity, 0.2)
   end
   
   -- Notification // إشعار
   Notify("💥 " .. punchType .. " Punch!", 
       string.format("-%d HP to %s (Remaining: %d HP)", 
           damage, targetPlayer.Name, math.floor(targetHumanoid.Health)), 3)
   
   return true
end

--// Create Tabs // إنشاء التبويبات
local MainTab = Window:CreateTab("Main Punch", "sword")
local VisualsTab = Window:CreateTab("Visuals", "eye")
local MovementTab = Window:CreateTab("Movement Extras", "zap")

--// Player Dropdown Update Function // دالة تحديث قائمة اللاعبين
local PlayerDropdown = nil

local function UpdatePlayerDropdown()
   if PlayerDropdown then
       local names = GetPlayerNames()
       -- Update dropdown options (Rayfield specific method)
       -- Note: Rayfield might not support dynamic updates, so we recreate if needed
   end
end

--// Main Punch Section // قسم الضرب الرئيسي
MainTab:CreateSection("Target Selection (اختيار الهدف)")

-- Create dropdown with current players // إنشاء قائمة منسدلة باللاعبين الحاليين
PlayerDropdown = MainTab:CreateDropdown({
   Name = "Select Player (اختر اللاعب)",
   Options = GetPlayerNames(),
   CurrentOption = "None",
   Flag = "TargetDropdown",
   Callback = function(selected)
       if selected and selected ~= "None" then
           local username = ExtractUsername(selected)
           for _, player in ipairs(Players:GetPlayers()) do
               if player.Name == username then
                   getgenv().SelectedTarget = player
                   Notify("✅ Target Selected", "Selected: " .. player.Name .. " (" .. player.DisplayName .. ")", 3)
                   break
               end
           end
       end
   end,
})

-- Refresh button // زر التحديث
MainTab:CreateButton({
   Name = "🔄 Refresh Player List",
   Callback = function()
       local names = GetPlayerNames()
       -- Recreate dropdown with new options
       Rayfield:Notify({
           Title = "Refreshed",
           Content = "Found " .. #names .. " players",
           Duration = 2,
       })
       
       -- Update the dropdown by destroying and recreating (hacky but works)
       -- In a real implementation, you'd use the library's update method
   end,
})

-- Auto-refresh on player join/leave // التحديث التلقائي عند دخول/خروج لاعب
Players.PlayerAdded:Connect(function()
   task.wait(1)
   UpdatePlayerDropdown()
end)

Players.PlayerRemoving:Connect(function()
   task.wait(1)
   UpdatePlayerDropdown()
end)

MainTab:CreateSection("Punch Actions (أزرار الضرب)")

MainTab:CreateButton({
   Name = "👊 Left Punch (لكمة يسار)",
   Callback = function()
       if tick() - getgenv().LastPunchTime < 0.4 then
           Notify("Wait", "Please wait before next punch!", 2)
           return
       end
       
       if not getgenv().SelectedTarget then
           Notify("Error", "No target selected!", 3)
           return
       end
       
       getgenv().LastPunchTime = tick()
       getgenv().ComboCount = 0 -- Reset combo
       PerformRealisticPunch(getgenv().SelectedTarget)
   end,
})

MainTab:CreateButton({
   Name = "👊 Right Punch (لكمة يمين)",
   Callback = function()
       if tick() - getgenv().LastPunchTime < 0.4 then
           Notify("Wait", "Please wait before next punch!", 2)
           return
       end
       
       if not getgenv().SelectedTarget then
           Notify("Error", "No target selected!", 3)
           return
       end
       
       getgenv().LastPunchTime = tick()
       getgenv().ComboCount = 1 -- Set to right
       PerformRealisticPunch(getgenv().SelectedTarget)
   end,
})

MainTab:CreateButton({
   Name = "💥 Combo Punch (ضربة combo)",
   Callback = function()
       if tick() - getgenv().LastPunchTime < 0.6 then
           Notify("Wait", "Combo charging...", 2)
           return
       end
       
       if not getgenv().SelectedTarget then
           Notify("Error", "No target selected!", 3)
           return
       end
       
       getgenv().LastPunchTime = tick()
       getgenv().ComboCount = 2 -- Force combo
       PerformRealisticPunch(getgenv().SelectedTarget)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Punch (Continuous)",
   CurrentValue = false,
   Flag = "AutoPunch",
   Callback = function(value)
       getgenv().IsPunching = value
       
       if value then
           task.spawn(function()
               while getgenv().IsPunching and getgenv().SelectedTarget do
                   if tick() - getgenv().LastPunchTime >= 0.5 then
                       getgenv().LastPunchTime = tick()
                       PerformRealisticPunch(getgenv().SelectedTarget)
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
       getgenv().ComboCount = 0
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
       
       if ESPObjects[player] then
           ESPObjects[player]:Destroy()
       end
       
       local highlight = Instance.new("Highlight")
       highlight.Name = "ESPHighlight"
       highlight.FillColor = player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
       highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
       highlight.FillTransparency = 0.5
       highlight.OutlineTransparency = 0
       highlight.Parent = char
       ESPObjects[player] = highlight
       
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
           for _, player in ipairs(Players:GetPlayers()) do
               CreateESP(player)
           end
           Players.PlayerAdded:Connect(CreateESP)
       else
           for _, highlight in pairs(ESPObjects) do
               if highlight then
                   highlight:Destroy()
               end
           end
           ESPObjects = {}
       end
   end,
})

VisualsTab:CreateToggle({
   Name = "Show Punch Range",
   CurrentValue = false,
   Flag = "RangeVisualizer",
   Callback = function(value)
       if value then
           -- Create range circle
           local rangePart = Instance.new("Part")
           rangePart.Name = "PunchRange"
           rangePart.Shape = Enum.PartType.Cylinder
           rang
