--[[
   ██████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗     ██████╗ █████╗ ████████╗███████╗██████╗
   ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║    ██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
   ██████╔╝██║   ██║██╔██╗ ██║██║     ███████║    ██║     ███████║   ██║   █████╗  ██████╔╝
   ██╔═══╝ ██║   ██║██║╚██╗██║██║     ██╔══██║    ██║     ██╔══██║   ██║   ██╔══╝  ██╔══██╗
   ██║     ╚██████╔╝██║ ╚████║╚██████╗██║  ██║    ╚██████╗██║  ██║   ██║   ███████╗██║  ██║
   ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝     ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
   
   Punch Master HUB - Naser Adm (Fixed Version)
   Working Roblox Boxing System for Delta/Arceus X/Mobile
]]

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

--// Variables
getgenv().SelectedTarget = nil
getgenv().IsPunching = false
getgenv().InfiniteJumpEnabled = false
getgenv().NoclipEnabled = false
getgenv().ESPEnabled = false
getgenv().AntiAFKEnabled = false
getgenv().WalkSpeedValue = 16
getgenv().LastPunchTime = 0
getgenv().ComboCount = 0
getgenv().PlayerList = {}

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled

--// Anti-AFK Bypass
pcall(function()
   LocalPlayer.Idled:Connect(function()
       if getgenv().AntiAFKEnabled then
           local VirtualUser = game:GetService("VirtualUser")
           VirtualUser:CaptureController()
           VirtualUser:ClickButton2(Vector2.new())
       end
   end)
end)

--// Load Rayfield with Error Handling
local success, Rayfield = pcall(function()
   return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
   -- Fallback notification if Rayfield fails
   pcall(function()
       StarterGui:SetCore("SendNotification", {
           Title = "Error",
           Text = "Failed to load Rayfield UI. Check your internet.",
           Duration = 5
       })
   end)
   warn("Failed to load Rayfield")
   return
end

--// Create Window
local Window = Rayfield:CreateWindow({
   Name = "Punch Master HUB - Naser Adm",
   LoadingTitle = "Loading Ultimate Punch System...",
   LoadingSubtitle = "by Naser Adm | Fixed Edition",
   ConfigurationSaving = {
       Enabled = true,
       FolderName = "PunchMasterHub",
       FileName = "Config"
   },
   KeySystem = false,
})

--// Helper Functions
local function Notify(title, content, duration)
   pcall(function()
       Rayfield:Notify({
           Title = tostring(title),
           Content = tostring(content),
           Duration = tonumber(duration) or 3,
           Image = "info",
       })
   end)
end

local function GetCharacter(player)
   return player and player.Character
end

local function GetHumanoid(character)
   if not character then return nil end
   return character:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart(character)
   if not character then return nil end
   return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
end

local function GetPlayerList()
   local list = {}
   for _, player in ipairs(Players:GetPlayers()) do
       if player ~= LocalPlayer then
           table.insert(list, player.Name)
       end
   end
   return list
end

--// Animation System - Using default Roblox animations
local function PlayPunchAnimation(character, punchType)
   local humanoid = GetHumanoid(character)
   if not humanoid then return nil end
   
   -- Get animator or create one
   local animator = humanoid:FindFirstChildOfClass("Animator")
   if not animator then
       animator = Instance.new("Animator")
       animator.Parent = humanoid
   end
   
   -- Use built-in punch animations
   local animId = "rbxassetid://204062532" -- Default punch
   
   -- Try to load animation
   local success, animationTrack = pcall(function()
       local animation = Instance.new("Animation")
       animation.AnimationId = animId
       local track = animator:LoadAnimation(animation)
       track.Priority = Enum.AnimationPriority.Action4
       track.Looped = false
       return track
   end)
   
   if success and animationTrack then
       animationTrack:Play()
       animationTrack:AdjustSpeed(1.5)
       return animationTrack
   end
   
   return nil
end

--// Visual Effects System
local function CreatePunchVisuals(attackerChar, targetChar)
   if not attackerChar or not targetChar then return end
   
   -- Get hands
   local rightHand = attackerChar:FindFirstChild("RightHand") or attackerChar:FindFirstChild("Right Arm")
   local leftHand = attackerChar:FindFirstChild("LeftHand") or attackerChar:FindFirstChild("Left Arm")
   local targetRoot = GetRootPart(targetChar)
   
   if not rightHand or not targetRoot then return end
   
   -- Create trail effect
   local function createTrail(parent)
       local attachment0 = Instance.new("Attachment", parent)
       attachment0.Position = Vector3.new(0, -0.5, 0)
       
       local attachment1 = Instance.new("Attachment", parent)
       attachment1.Position = Vector3.new(0, 0.5, 0)
       
       local trail = Instance.new("Trail", parent)
       trail.Attachment0 = attachment0
       trail.Attachment1 = attachment1
       trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 100, 100))
       trail.Lifetime = 0.3
       trail.WidthScale = NumberSequence.new(0.5, 0)
       
       Debris:AddItem(attachment0, 0.5)
       Debris:AddItem(attachment1, 0.5)
       Debris:AddItem(trail, 0.5)
       
       return trail
   end
   
   -- Create trails on both hands
   pcall(function() createTrail(rightHand) end)
   pcall(function() createTrail(leftHand) end)
   
   -- Impact effect at target
   task.delay(0.15, function()
       if targetRoot and targetRoot.Parent then
           local impact = Instance.new("Part")
           impact.Name = "PunchImpact"
           impact.Anchored = true
           impact.CanCollide = false
           impact.Size = Vector3.new(1, 1, 1)
           impact.Transparency = 1
           impact.CFrame = targetRoot.CFrame
           impact.Parent = Workspace
           
           local attachment = Instance.new("Attachment", impact)
           
           -- Spark particles
           local spark = Instance.new("ParticleEmitter", attachment)
           spark.Texture = "rbxassetid://258128463"
           spark.Color = ColorSequence.new(Color3.fromRGB(255, 50, 50))
           spark.Size = NumberSequence.new(1, 0)
           spark.Lifetime = NumberRange.new(0.2, 0.4)
           spark.Speed = NumberRange.new(15, 25)
           spark.Rate = 0
           spark:Emit(10)
           
           -- Sound
           local sound = Instance.new("Sound", impact)
           sound.SoundId = "rbxassetid://3932505913"
           sound.Volume = 0.8
           sound:Play()
           
           Debris:AddItem(impact, 1)
           
           -- Screen shake for target if it's local player
           if targetChar == GetCharacter(LocalPlayer) then
               pcall(function()
                   local cam = Workspace.CurrentCamera
                   local originalPos = cam.CFrame
                   for i = 1, 3 do
                       cam.CFrame = originalPos * CFrame.new(math.random(-2, 2)/10, math.random(-2, 2)/10, 0)
                       task.wait(0.03)
                   end
                   cam.CFrame = originalPos
               end)
           end
       end
   end)
end

--// Main Punch Function
local function ExecutePunch(targetPlayer)
   if not targetPlayer then
       Notify("Error", "No target selected!", 3)
       return false
   end
   
   local targetChar = GetCharacter(targetPlayer)
   if not targetChar then
       Notify("Error", "Target character not found!", 3)
       return false
   end
   
   local targetHumanoid = GetHumanoid(targetChar)
   if not targetHumanoid or targetHumanoid.Health <= 0 then
       Notify("Error", "Target is dead!", 3)
       return false
   end
   
   local localChar = GetCharacter(LocalPlayer)
   if not localChar then
       Notify("Error", "Your character not found!", 3)
       return false
   end
   
   local localHumanoid = GetHumanoid(localChar)
   local localRoot = GetRootPart(localChar)
   local targetRoot = GetRootPart(targetChar)
   
   if not localHumanoid or not localRoot or not targetRoot then
       Notify("Error", "Missing character parts!", 3)
       return false
   end
   
   -- Check distance and tween if needed
   local distance = (targetRoot.Position - localRoot.Position).Magnitude
   
   if distance > 6 then
       -- Tween to target
       local targetPos = targetRoot.Position + (targetRoot.CFrame.LookVector * -2.5)
       local tweenInfo = TweenInfo.new(
           math.min(distance * 0.1, 1),
           Enum.EasingStyle.Quad,
           Enum.EasingDirection.Out
       )
       
       local tween = TweenService:Create(localRoot, tweenInfo, {
           CFrame = CFrame.new(targetPos, targetRoot.Position)
       })
       
       tween:Play()
       tween.Completed:Wait()
   end
   
   -- Determine punch type
   getgenv().ComboCount = getgenv().ComboCount + 1
   local isRight = getgenv().ComboCount % 2 == 1
   local punchName = isRight and "Right" or "Left"
   
   -- Play animation
   local animTrack = PlayPunchAnimation(localChar, punchName)
   
   -- Create visuals (everyone sees)
   CreatePunchVisuals(localChar, targetChar)
   
   -- Wait for hit timing
   task.wait(0.12)
   
   -- Apply damage
   local damage = math.random(12, 18)
   local currentHealth = targetHumanoid.Health
   
   -- Try multiple damage methods
   local damageApplied = false
   
   -- Method 1: Direct
   pcall(function()
       targetHumanoid.Health = currentHealth - damage
       damageApplied = true
   end)
   
   -- Method 2: TakeDamage
   if not damageApplied then
       pcall(function()
           targetHumanoid:TakeDamage(damage)
           damageApplied = true
       end)
   end
   
   -- Knockback
   pcall(function()
       if targetRoot then
           local knockback = Instance.new("BodyVelocity", targetRoot)
           knockback.Velocity = (targetRoot.Position - localRoot.Position).Unit * 30 + Vector3.new(0, 15, 0)
           knockback.MaxForce = Vector3.new(5000, 5000, 5000)
           Debris:AddItem(knockback, 0.15)
       end
   end)
   
   -- Notification
   local newHealth = math.max(0, targetHumanoid.Health)
   Notify("💥 " .. punchName .. " Punch!", 
       string.format("-%d HP to %s (Remaining: %d)", damage, targetPlayer.Name, math.floor(newHealth)), 3)
   
   -- Return to position
   task.delay(0.3, function()
       pcall(function()
           if localRoot and targetRoot then
               local backPos = localRoot.Position + (localRoot.CFrame.LookVector * -1)
               local backTween = TweenService:Create(localRoot, TweenInfo.new(0.3), {
                   CFrame = CFrame.new(backPos, targetRoot.Position)
               })
               backTween:Play()
           end
       end)
   end)
   
   return true
end

--// Create Tabs
local MainTab = Window:CreateTab("Main Punch", "sword")
local VisualsTab = Window:CreateTab("Visuals", "eye")
local MovementTab = Window:CreateTab("Movement", "zap")

--// Target Selection Section
MainTab:CreateSection("Select Target (اختيار الهدف)")

-- Player Dropdown
local PlayerDropdown = MainTab:CreateDropdown({
   Name = "Select Player",
   Options = GetPlayerList(),
   CurrentOption = nil,
   Flag = "PlayerDropdown",
   Callback = function(selected)
       if selected and selected ~= "" then
           for _, player in ipairs(Players:GetPlayers()) do
               if player.Name == selected then
                   getgenv().SelectedTarget = player
                   Notify("Target Selected", "Selected: " .. player.Name, 3)
                   return
               end
           end
       end
   end,
})

-- Refresh Button
MainTab:CreateButton({
   Name = "🔄 Refresh List",
   Callback = function()
       local list = GetPlayerList()
       -- Update dropdown (Rayfield should handle this)
       Notify("Refreshed", "Found " .. #list .. " players", 2)
       
       -- Force update by recreating (workaround)
       pcall(function()
           if PlayerDropdown and PlayerDropdown.Set then
               PlayerDropdown:Set(list)
           end
       end)
   end,
})

-- Update list when players join/leave
Players.PlayerAdded:Connect(function()
   task.wait(0.5)
   local list = GetPlayerList()
   pcall(function()
       if PlayerDropdown and PlayerDropdown.Set then
           PlayerDropdown:Set(list)
       end
   end)
end)

Players.PlayerRemoving:Connect(function()
   task.wait(0.5)
   local list = GetPlayerList()
   pcall(function()
       if PlayerDropdown and PlayerDropdown.Set then
           PlayerDropdown:Set(list)
       end
   end)
   -- Clear if target left
   if getgenv().SelectedTarget and not Players:FindFirstChild(getgenv().SelectedTarget.Name) then
       getgenv().SelectedTarget = nil
       Notify("Target Left", "Target disconnected", 2)
   end
end)

--// Punch Actions Section
MainTab:CreateSection("Punch Actions (أزرار الضرب)")

MainTab:CreateButton({
   Name = "👊 Punch (ضربة)",
   Callback = function()
       if tick() - getgenv().LastPunchTime < 0.5 then
           Notify("Wait", "Cooldown active!", 2)
           return
       end
       
       if not getgenv().SelectedTarget then
           Notify("Error", "Select a target first!", 3)
           return
       end
       
       getgenv().LastPunchTime = tick()
       ExecutePunch(getgenv().SelectedTarget)
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
               while getgenv().IsPunching do
                   if tick() - getgenv().LastPunchTime >= 0.6 then
                       if getgenv().SelectedTarget then
                           getgenv().LastPunchTime = tick()
                           ExecutePunch(getgenv().SelectedTarget)
                       else
                           getgenv().IsPunching = false
                           Notify("Stopped", "No target selected", 2)
                           break
                       end
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
       Notify("Cleared", "Target reset", 2)
   end,
})

--// Visuals Tab
VisualsTab:CreateSection("ESP Settings")

local ESPObjects = {}

VisualsTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(value)
       getgenv().ESPEnabled = value
       
       if value then
           -- Create ESP for existing
           for _, player in ipairs(Players:GetPlayers()) do
               if player ~= LocalPlayer then
                   local char = GetCharacter(player)
                   if char then
                       local highlight = Instance.new("Highlight")
                       highlight.Name = "ESP"
                       highlight.FillColor = player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                       highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                       highlight.FillTransparency = 0.6
                       highlight.Parent = char
                       ESPObjects[player] = highlight
                   end
               end
           end
           
           -- Connect for new players
           Players.PlayerAdded:Connect(function(player)
               if not getgenv().ESPEnabled then return end
               player.CharacterAdded:Connect(function(char)
                   if not getgenv().ESPEnabled then return end
                   task.wait(0.5)
                   if ESPObjects[player] then ESPObjects[player]:Destroy() end
                   local highlight = Instance.new("Highlight")
                   highlight.Name = "ESP"
                   highlight.FillColor = player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                   highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                   highlight.FillTransparency = 0.6
                   highlight.Parent = char
                   ESPObjects[player] = highlight
               end)
           end)
       else
           -- Remove all ESP
           for _, obj in pairs(ESPObjects) do
               if obj then obj:Destroy() end
           end
           ESPObjects = {}
       end
   end,
})

--// Movement Tab
MovementTab:CreateSection("Movement Modifiers")

MovementTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 150},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(value)
       getgenv().WalkSpeedValue = value
       local char = GetCharacter(LocalPlayer)
       if char then
           local hum = GetHumanoid(char)
           if hum then hum.WalkSpeed = value end
       end
   end,
})

-- Speed loop
task.spawn(function()
   while true do
       task.wait(0.3)
       if getgenv().WalkSpeedValue ~= 16 then
           local char = GetCharacter(LocalPlayer)
           if char then
               local hum = GetHumanoid(char)
               if hum and hum.WalkSpeed ~= getgenv().WalkSpeedValue then
                   hum.WalkSpeed = getgenv().WalkSpeedValue
               end
           end
       end
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

UserInputService.JumpRequest:Connect(function()
   if getgenv().InfiniteJumpEnabled then
       local char = GetCharacter(LocalPlayer)
       if char then
           local hum = GetHumanoid(char)
           if hum then
               hum:ChangeState(Enum.HumanoidStateType.Jumping)
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
   Name = "Anti-AFK",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(value)
       getgenv().AntiAFKEnabled = value
   end,
})

--// Character Reset Handler
LocalPlayer.CharacterAdded:Connect(function(char)
   task.wait(0.5)
   if getgenv().WalkSpeedValue ~= 16 then
       local hum = GetHumanoid(char)
       if hum then hum.WalkSpeed = getgenv().WalkSpeedValue end
   end
end)

--// Success Notification
task.wait(1)
Notify("✅ System Ready!", "Punch Master HUB Loaded Successfully", 5)
print("Punch Master HUB | Loaded | By Naser Adm")
