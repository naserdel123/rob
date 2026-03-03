--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║                    GOGO HUB - Ultimate Script                  ║
    ║                     Developed by: Naser Adm                    ║
    ╚═══════════════════════════════════════════════════════════════╝
    
    GitHub Loader Version - Optimized for All Executors
]]

-- Anti-error wrapper
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("[GOGO HUB Error]: " .. tostring(result))
    end
    return success, result
end

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Wait for character with timeout
local function WaitForCharacter(timeout)
    local start = tick()
    while not LocalPlayer.Character and tick() - start < timeout do
        task.wait(0.1)
    end
    return LocalPlayer.Character
end

WaitForCharacter(10)

--// SPLASH SCREEN //--
SafeCall(function()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GogoSplash"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui
    
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(1, 0, 1, 0)
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 35)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 0, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
    })
    Gradient.Rotation = 45
    Gradient.Parent = Main
    
    -- Animated background
    task.spawn(function()
        while Main and Main.Parent do
            for i = 0, 360, 2 do
                if not Gradient or not Gradient.Parent then break end
                Gradient.Rotation = i
                task.wait(0.03)
            end
        end
    end)
    
    -- Goku Image
    local Image = Instance.new("ImageLabel")
    Image.Size = UDim2.new(0, 300, 0, 300)
    Image.Position = UDim2.new(0.5, -150, 0.4, -150)
    Image.BackgroundTransparency = 1
    Image.Image = "rbxassetid://11141271480"
    Image.Parent = Main
    
    -- Glow
    local Glow = Instance.new("ImageLabel")
    Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://11141271480"
    Glow.ImageColor3 = Color3.fromRGB(0, 150, 255)
    Glow.ImageTransparency = 0.7
    Glow.Parent = Image
    
    -- Color cycle
    task.spawn(function()
        local colors = {
            Color3.fromRGB(0, 150, 255),
            Color3.fromRGB(150, 0, 255),
            Color3.fromRGB(255, 0, 150),
            Color3.fromRGB(0, 255, 150),
        }
        local i = 1
        while Main and Main.Parent do
            local c = colors[i]
            pcall(function()
                TweenService:Create(Glow, TweenInfo.new(1), {ImageColor3 = c}):Play()
            end)
            i = i % #colors + 1
            task.wait(1.5)
        end
    end)
    
    -- Rotate
    task.spawn(function()
        while Main and Main.Parent do
            pcall(function()
                TweenService:Create(Image, TweenInfo.new(8, Enum.EasingStyle.Linear), {Rotation = Image.Rotation + 360}):Play()
            end)
            task.wait(8)
        end
    end)
    
    -- Pulse
    task.spawn(function()
        while Main and Main.Parent do
            pcall(function()
                TweenService:Create(Image, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 320, 0, 320), Position = UDim2.new(0.5, -160, 0.4, -160)}):Play()
            end)
            task.wait(1)
            pcall(function()
                TweenService:Create(Image, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 300, 0, 300), Position = UDim2.new(0.5, -150, 0.4, -150)}):Play()
            end)
            task.wait(1)
        end
    end)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 400, 0, 50)
    Title.Position = UDim2.new(0.5, -200, 0.7, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "GOGO HUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextStrokeTransparency = 0
    Title.TextStrokeColor3 = Color3.fromRGB(0, 150, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 48
    Title.Parent = Main
    
    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(0, 400, 0, 30)
    Sub.Position = UDim2.new(0.5, -200, 0.78, 0)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Powered by Naser Adm"
    Sub.TextColor3 = Color3.fromRGB(200, 200, 200)
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 18
    Sub.Parent = Main
    
    -- Loading bar
    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(0, 300, 0, 6)
    BarBg.Position = UDim2.new(0.5, -150, 0.85, 0)
    BarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    BarBg.BorderSizePixel = 0
    BarBg.Parent = Main
    
    local Corner1 = Instance.new("UICorner")
    Corner1.CornerRadius = UDim.new(1, 0)
    Corner1.Parent = BarBg
    
    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBg
    
    local Corner2 = Instance.new("UICorner")
    Corner2.CornerRadius = UDim.new(1, 0)
    Corner2.Parent = BarFill
    
    pcall(function()
        TweenService:Create(BarFill, TweenInfo.new(5), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end)
    
    task.wait(6)
    
    -- Fade out
    pcall(function()
        TweenService:Create(Main, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    end)
    for _, v in pairs(Main:GetDescendants()) do
        if v:IsA("GuiObject") then
            pcall(function()
                TweenService:Create(v, TweenInfo.new(1), {Transparency = 1}):Play()
            end)
        end
    end
    
    task.wait(1.2)
    ScreenGui:Destroy()
end)

--// LOAD ORION LIBRARY //--
local OrionLib = nil

SafeCall(function()
    OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
end)

if not OrionLib then
    -- Fallback notification if Orion fails
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "GOGO HUB Error",
            Text = "Failed to load UI Library. Check your internet.",
            Duration = 5
        })
    end)
    return
end

--// MAIN WINDOW //--
local Window = OrionLib:MakeWindow({
    Name = "GOGO HUB - Naser Adm",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GogoHub",
    IntroEnabled = false
})

-- Variables
local States = {
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    InfJump = false,
    InfSpin = false,
    InfPunch = false,
    GodMode = false,
    Lag = false,
    Music = nil,
    MusicId = "",
    FE_Music = false,
    SelectedPlayer = nil
}

--// MUSIC TAB //--
local MusicTab = Window:MakeTab({
    Name = "🎵 Music",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MusicTab:AddTextbox({
    Name = "Audio ID",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        States.MusicId = Value
    end
})

MusicTab:AddButton({
    Name = "▶ Play Looped",
    Callback = function()
        SafeCall(function()
            if States.Music then
                States.Music:Destroy()
            end
            
            if States.MusicId == "" then
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Enter Audio ID first!",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                return
            end
            
            local s = Instance.new("Sound")
            s.SoundId = "rbxassetid://" .. tostring(States.MusicId)
            s.Looped = true
            s.Volume = 2
            s.Parent = SoundService
            s:Play()
            States.Music = s
            
            OrionLib:MakeNotification({
                Name = "Music",
                Content = "Playing: " .. States.MusicId,
                Time = 3
            })
        end)
    end
})

MusicTab:AddToggle({
    Name = "🔁 FE Loop (5s)",
    Default = false,
    Callback = function(Value)
        States.FE_Music = Value
        if Value then
            task.spawn(function()
                while States.FE_Music do
                    task.wait(5)
                    if States.Music then
                        SafeCall(function()
                            States.Music:Stop()
                            States.Music:Play()
                        end)
                    end
                end
            end)
        end
    end
})

MusicTab:AddButton({
    Name = "⏹ Stop Music",
    Callback = function()
        SafeCall(function()
            if States.Music then
                States.Music:Destroy()
                States.Music = nil
            end
        end)
    end
})

--// PLAYERS TAB //--
local PlayerTab = Window:MakeTab({
    Name = "👥 Players",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PlayerList = {}
SafeCall(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(PlayerList, p.Name)
        end
    end
end)

local PlayerDropdown = PlayerTab:AddDropdown({
    Name = "Select Player",
    Default = "",
    Options = PlayerList,
    Callback = function(Value)
        States.SelectedPlayer = Value
    end
})

-- Auto refresh
task.spawn(function()
    while task.wait(5) do
        SafeCall(function()
            local list = {}
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    table.insert(list, p.Name)
                end
            end
            PlayerDropdown:Refresh(list, true)
        end)
    end
end)

PlayerTab:AddButton({
    Name = "👁 Spy",
    Callback = function()
        SafeCall(function()
            local t = Players:FindFirstChild(States.SelectedPlayer)
            if t and t.Character then
                local h = t.Character:FindFirstChild("Humanoid")
                if h then
                    Camera.CameraSubject = h
                    OrionLib:MakeNotification({Name = "Spectating", Content = t.Name, Time = 2})
                end
            end
        end)
    end
})

PlayerTab:AddButton({
    Name = "👕 Copy Outfit",
    Callback = function()
        SafeCall(function()
            local t = Players:FindFirstChild(States.SelectedPlayer)
            if t and t.Character and LocalPlayer.Character then
                local d = t.Character.Humanoid:GetAppliedDescription()
                LocalPlayer.Character.Humanoid:ApplyDescription(d)
                OrionLib:MakeNotification({Name = "Success", Content = "Outfit copied!", Time = 2})
            end
        end)
    end
})

PlayerTab:AddButton({
    Name = "💀 Kill",
    Callback = function()
        SafeCall(function()
            local t = Players:FindFirstChild(States.SelectedPlayer)
            if t and t.Character then
                local h = t.Character:FindFirstChild("Humanoid")
                if h then h.Health = 0 end
            end
        end)
    end
})

PlayerTab:AddButton({
    Name = "☁️ Sky Platform",
    Callback = function()
        SafeCall(function()
            local t = Players:FindFirstChild(States.SelectedPlayer)
            if t and t.Character then
                local hrp = t.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local plat = Instance.new("Part")
                    plat.Size = Vector3.new(10, 1, 10)
                    plat.Position = hrp.Position + Vector3.new(0, 500, 0)
                    plat.Anchored = true
                    plat.Color = Color3.fromRGB(255, 0, 0)
                    plat.Parent = Workspace
                    hrp.CFrame = CFrame.new(plat.Position + Vector3.new(0, 5, 0))
                end
            end
        end)
    end
})

PlayerTab:AddButton({
    Name = "🎥 Reset Camera",
    Callback = function()
        SafeCall(function()
            if LocalPlayer.Character then
                Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
            end
        end)
    end
})

--// FEATURES TAB //--
local FeatTab = Window:MakeTab({
    Name = "⚡ Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Noclip
FeatTab:AddToggle({
    Name = "👻 Noclip",
    Default = false,
    Callback = function(Value)
        States.Noclip = Value
        if Value then
            task.spawn(function()
                while States.Noclip do
                    task.wait()
                    SafeCall(function()
                        if LocalPlayer.Character then
                            for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
                                if p:IsA("BasePart") then p.CanCollide = false end
                            end
                        end
                    end)
                end
                -- Restore
                SafeCall(function()
                    if LocalPlayer.Character then
                        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
                            if p:IsA("BasePart") then p.CanCollide = true end
                        end
                    end
                end)
            end)
        end
    end
})

-- Fly
local FlyCon = nil
FeatTab:AddToggle({
    Name = "🚀 Fly (Space/Shift)",
    Default = false,
    Callback = function(Value)
        States.Fly = Value
        if Value then
            SafeCall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:WaitForChild("HumanoidRootPart")
                
                local bg = Instance.new("BodyGyro")
                bg.P = 9e4
                bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.CFrame = hrp.CFrame
                bg.Parent = hrp
                
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.zero
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Parent = hrp
                
                FlyCon = RunService.RenderStepped:Connect(function()
                    if not States.Fly then return end
                    SafeCall(function()
                        local dir = Vector3.zero
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            dir = dir + Vector3.new(0, 1, 0)
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            dir = dir + Vector3.new(0, -1, 0)
                        end
                        bv.Velocity = dir * States.FlySpeed
                        bg.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
                    end)
                end)
            end)
        else
            SafeCall(function()
                if FlyCon then FlyCon:Disconnect() end
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, c in pairs(hrp:GetChildren()) do
                            if c:IsA("BodyGyro") or c:IsA("BodyVelocity") then c:Destroy() end
                        end
                    end
                end
            end)
        end
    end
})

FeatTab:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(0, 150, 255),
    Increment = 10,
    ValueName = "studs",
    Callback = function(Value)
        States.FlySpeed = Value
    end
})

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    SafeCall(function()
        if States.InfJump and LocalPlayer.Character then
            local h = LocalPlayer.Character:FindFirstChild("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)
end)

FeatTab:AddToggle({
    Name = "⬆️ Infinite Jump",
    Default = false,
    Callback = function(Value)
        States.InfJump = Value
    end
})

-- Infinite Spin
FeatTab:AddToggle({
    Name = "🌪 Infinite Spin",
    Default = false,
    Callback = function(Value)
        States.InfSpin = Value
        if Value then
            task.spawn(function()
                while States.InfSpin do
                    task.wait()
                    SafeCall(function()
                        if LocalPlayer.Character then
                            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(20), 0) end
                        end
                    end)
                end
            end)
        end
    end
})

-- Infinite Punch
FeatTab:AddToggle({
    Name = "👊 Infinite Punch",
    Default = false,
    Callback = function(Value)
        States.InfPunch = Value
        if Value then
            task.spawn(function()
                while States.InfPunch do
                    task.wait(0.5)
                    SafeCall(function()
                        if LocalPlayer.Character then
                            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                for _, p in pairs(Players:GetPlayers()) do
                                    if p ~= LocalPlayer and p.Character then
                                        local thrp = p.Character:FindFirstChild("HumanoidRootPart")
                                        local th = p.Character:FindFirstChild("Humanoid")
                                        if thrp and th and (hrp.Position - thrp.Position).Magnitude < 10 then
                                            th:TakeDamage(10)
                                            local snd = Instance.new("Sound")
                                            snd.SoundId = "rbxassetid://3932505916"
                                            snd.Volume = 0.5
                                            snd.Parent = hrp
                                            snd:Play()
                                            game:GetService("Debris"):AddItem(snd, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

-- God Mode
FeatTab:AddToggle({
    Name = "🛡 God Mode",
    Default = false,
    Callback = function(Value)
        States.GodMode = Value
        if Value then
            task.spawn(function()
                while States.GodMode do
                    task.wait(0.1)
                    SafeCall(function()
                        if LocalPlayer.Character then
                            local h = LocalPlayer.Character:
