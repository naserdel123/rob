--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║                    GOGO HUB - Ultimate Script                  ║
    ║                     Developed by: Naser Adm                    ║
    ╚═══════════════════════════════════════════════════════════════╝
    
    Features:
    - Custom Splash Screen with Animations
    - Rayfield GUI Library
    - Music Player (Local + FE Attempt)
    - Player Tools (Spy, Copy Outfit, Kill, Sky Platform)
    - Utilities (Noclip, Fly, Infinite Jump, etc.)
    - Server Lag (Educational)
    - Theme Customization
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

--// SPLASH SCREEN SYSTEM //--
local function CreateSplashScreen()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GogoSplash"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Gradient Background
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 35)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 0, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
    })
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame
    
    -- Animated Gradient
    spawn(function()
        while ScreenGui.Parent do
            for i = 0, 360, 2 do
                if not UIGradient.Parent then break end
                UIGradient.Rotation = i
                wait(0.03)
            end
        end
    end)
    
    -- Goku Image
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "GokuImage"
    ImageLabel.Size = UDim2.new(0, 300, 0, 300)
    ImageLabel.Position = UDim2.new(0.5, -150, 0.4, -150)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://11141271480" -- Goku Ultra Instinct
    ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.Parent = MainFrame
    
    -- Glow Effect
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://11141271480"
    Glow.ImageColor3 = Color3.fromRGB(0, 150, 255)
    Glow.ImageTransparency = 0.7
    Glow.Parent = ImageLabel
    
    -- Neon Color Cycling
    spawn(function()
        local colors = {
            Color3.fromRGB(0, 150, 255),   -- Blue
            Color3.fromRGB(150, 0, 255),   -- Purple
            Color3.fromRGB(255, 0, 150),   -- Pink
            Color3.fromRGB(0, 255, 150),   -- Cyan
        }
        local index = 1
        
        while ScreenGui.Parent do
            local color = colors[index]
            TweenService:Create(Glow, TweenInfo.new(1, Enum.EasingStyle.Quad), {
                ImageColor3 = color
            }):Play()
            
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quad), {
                ImageColor3 = Color3.new(1, 1, 1):Lerp(color, 0.2)
            }):Play()
            
            index = index % #colors + 1
            wait(1.5)
        end
    end)
    
    -- Rotation Animation
    spawn(function()
        while ScreenGui.Parent do
            TweenService:Create(ImageLabel, TweenInfo.new(8, Enum.EasingStyle.Linear), {
                Rotation = ImageLabel.Rotation + 360
            }):Play()
            wait(8)
        end
    end)
    
    -- Pulse Animation
    spawn(function()
        while ScreenGui.Parent do
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 320, 0, 320),
                Position = UDim2.new(0.5, -160, 0.4, -160)
            }):Play()
            wait(1)
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 300, 0, 300),
                Position = UDim2.new(0.5, -150, 0.4, -150)
            }):Play()
            wait(1)
        end
    end)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 400, 0, 50)
    Title.Position = UDim2.new(0.5, -200, 0.7, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "GOGO HUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextStrokeTransparency = 0
    Title.TextStrokeColor3 = Color3.fromRGB(0, 150, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 48
    Title.Parent = MainFrame
    
    -- Subtitle
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(0, 400, 0, 30)
    Subtitle.Position = UDim2.new(0.5, -200, 0.78, 0)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Powered by Naser Adm"
    Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextSize = 18
    Subtitle.Parent = MainFrame
    
    -- Loading Bar Background
    local BarBg = Instance.new("Frame")
    BarBg.Name = "BarBg"
    BarBg.Size = UDim2.new(0, 300, 0, 6)
    BarBg.Position = UDim2.new(0.5, -150, 0.85, 0)
    BarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    BarBg.BorderSizePixel = 0
    BarBg.Parent = MainFrame
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = BarBg
    
    -- Loading Bar Fill
    local BarFill = Instance.new("Frame")
    BarFill.Name = "BarFill"
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBg
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = BarFill
    
    -- Loading Animation
    TweenService:Create(BarFill, TweenInfo.new(5, Enum.EasingStyle.Quad), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()
    
    -- Color cycling for loading bar
    spawn(function()
        while ScreenGui.Parent and wait(0.5) do
            TweenService:Create(BarFill, TweenInfo.new(0.5), {
                BackgroundColor3 = Color3.fromRGB(math.random(100, 255), math.random(100, 255), 255)
            }):Play()
        end
    end)
    
    -- Wait and Destroy
    wait(6)
    
    -- Fade Out
    TweenService:Create(MainFrame, TweenInfo.new(1), {
        BackgroundTransparency = 1
    }):Play()
    
    for _, child in pairs(MainFrame:GetDescendants()) do
        if child:IsA("GuiObject") then
            TweenService:Create(child, TweenInfo.new(1), {
                Transparency = 1
            }):Play()
        end
    end
    
    wait(1)
    ScreenGui:Destroy()
end

-- Show Splash Screen
CreateSplashScreen()

--// LOAD RAYFIELD LIBRARY //--
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// WINDOW SETUP //--
local Window = Rayfield:CreateWindow({
    Name = "GOGO HUB",
    LoadingTitle = "GOGO HUB",
    LoadingSubtitle = "by Naser Adm",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GogoHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = true,
        Invite = "DzVBbDKN",
        RememberJoins = true
    },
    KeySystem = false,
})

--// VARIABLES //--
local CurrentTheme = "Neon Blue"
local Themes = {
    ["Neon Blue"] = Color3.fromRGB(0, 150, 255),
    ["Neon Green"] = Color3.fromRGB(0, 255, 100),
    ["Neon Red"] = Color3.fromRGB(255, 50, 50),
    ["Purple"] = Color3.fromRGB(150, 0, 255),
    ["Pink"] = Color3.fromRGB(255, 0, 150),
    ["Gold"] = Color3.fromRGB(255, 200, 0)
}

-- State Variables
local States = {
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    InfiniteJump = false,
    InfiniteSpin = false,
    InfinitePunch = false,
    GodMode = false,
    ServerLag = false,
    CurrentMusic = nil,
    FE_Music = false
}

--// MUSIC SYSTEM //--
local MusicTab = Window:CreateTab("🎵 Music", nil)

local MusicIdInput = MusicTab:CreateInput({
    Name = "Audio ID",
    PlaceholderText = "Enter Roblox Audio ID...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        States.MusicId = Text
    end,
})

MusicTab:CreateButton({
    Name = "▶ Play Looped (Local)",
    Callback = function()
        if States.CurrentMusic then
            States.CurrentMusic:Destroy()
        end
        
        if not States.MusicId then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter an Audio ID first!",
                Duration = 3,
                Image = nil,
            })
            return
        end
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. States.MusicId
        sound.Looped = true
        sound.Volume = 2
        sound.Parent = SoundService
        sound:Play()
        
        States.CurrentMusic = sound
        
        Rayfield:Notify({
            Title = "Music Started",
            Content = "Playing Audio ID: " .. States.MusicId,
            Duration = 3,
            Image = nil,
        })
    end,
})

MusicTab:CreateToggle({
    Name = "🔁 FE Loop Attempt (Replays every 5s)",
    CurrentValue = false,
    Flag = "FEMusic",
    Callback = function(Value)
        States.FE_Music = Value
        
        if Value then
            spawn(function()
                while States.FE_Music and wait(5) do
                    if States.CurrentMusic then
                        States.CurrentMusic:Stop()
                        States.CurrentMusic:Play()
                    end
                end
            end)
        end
    end,
})

MusicTab:CreateButton({
    Name = "⏹ Stop Music",
    Callback = function()
        if States.CurrentMusic then
            States.CurrentMusic:Destroy()
            States.CurrentMusic = nil
        end
        Rayfield:Notify({
            Title = "Music Stopped",
            Content = "Audio playback stopped",
            Duration = 2,
        })
    end,
})

--// PLAYERS TAB //--
local PlayersTab = Window:CreateTab("👥 Players", nil)

local PlayerDropdown = PlayersTab:CreateDropdown({
    Name = "Select Player",
    Options = {},
    CurrentOption = "",
    Flag = "SelectedPlayer",
    Callback = function(Option)
        States.SelectedPlayer = Option
    end,
})

-- Auto-update player list
spawn(function()
    while wait(5) do
        local playerNames = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        PlayerDropdown:Refresh(playerNames, true)
    end
end)

PlayersTab:CreateButton({
    Name = "👁 Spy (Spectate)",
    Callback = function()
        local targetName = States.SelectedPlayer or PlayerDropdown.CurrentOption
        local target = Players:FindFirstChild(targetName)
        
        if target and target.Character then
            local humanoid = target.Character:FindFirstChild("Humanoid")
            if humanoid then
                Camera.CameraSubject = humanoid
                Rayfield:Notify({
                    Title = "Spectating",
                    Content = "Now watching: " .. target.Name,
                    Duration = 3,
                })
            end
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Player not found!",
                Duration = 2,
            })
        end
    end,
})

PlayersTab:CreateButton({
    Name = "👕 Copy Outfit",
    Callback = function()
        local targetName = States.SelectedPlayer or PlayerDropdown.CurrentOption
        local target = Players:FindFirstChild(targetName)
        
        if target and target.Character then
            local success, err = pcall(function()
                local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
                local description = target.Character:WaitForChild("Humanoid"):GetAppliedDescription()
                humanoid:ApplyDescription(description)
            end)
            
            if success then
                Rayfield:Notify({
                    Title = "Success",
                    Content = "Copied outfit from " .. target.Name,
                    Duration = 3,
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Failed to copy outfit",
                    Duration = 2,
                })
            end
        end
    end,
})

PlayersTab:CreateButton({
    Name = "💀 Kill",
    Callback = function()
        local targetName = States.SelectedPlayer or PlayerDropdown.CurrentOption
        local target = Players:FindFirstChild(targetName)
        
        if target and target.Character then
            local humanoid = target.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
                Rayfield:Notify({
                    Title = "Killed",
                    Content = target.Name .. " has been eliminated",
                    Duration = 2,
                })
            end
        end
    end,
})

PlayersTab:CreateButton({
    Name = "☁️ Sky Platform + Noclip",
    Callback = function()
        local targetName = States.SelectedPlayer or PlayerDropdown.CurrentOption
        local target = Players:FindFirstChild(targetName)
        
        if target and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Create platform
                local platform = Instance.new("Part")
                platform.Size = Vector3.new(10, 1, 10)
                platform.Position = hrp.Position + Vector3.new(0, 500, 0)
                platform.Anchored = true
                platform.Color = Color3.fromRGB(255, 0, 0)
                platform.Name = "SkyPlatform_" .. target.Name
                platform.Parent = Workspace
                
                -- Teleport player
                hrp.CFrame = CFrame.new(platform.Position + Vector3.new(0, 5, 0))
                
                -- Enable noclip for them (local simulation)
                Rayfield:Notify({
                    Title = "Sky Platform",
                    Content = "Sent " .. target.Name .. " to sky with platform",
                    Duration = 3,
                })
            end
        end
    end,
})

PlayersTab:CreateButton({
    Name = "🎥 Reset Camera",
    Callback = function()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                Camera.CameraSubject = humanoid
            end
        end
    end,
})

--// FEATURES TAB //--
local FeaturesTab = Window:CreateTab("⚡ Features", nil)

-- Noclip
FeaturesTab:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        States.Noclip = Value
        
        if Value then
            spawn(function()
                while States.Noclip and wait() do
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        else
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end,
})

-- Fly System
local FlyConnection
FeaturesTab:CreateToggle({
    Name = "🚀 Fly (Space ↑ | Shift ↓)",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        States.Fly = Value
        
        if Value then
            local character = LocalPlayer.Character
            if not character then return end
            
            local hrp = character:WaitForChild("HumanoidRootPart")
            local humanoid = character:WaitForChild("Humanoid")
            
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.P = 9e4
            bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.CFrame = hrp.CFrame
            bodyGyro.Parent = hrp
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVelocity.Parent = hrp
            
            FlyConnection = RunService.RenderStepped:Connect(function()
                if not States.Fly then return end
                
                local direction = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    direction = direction + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    direction = direction + Vector3.new(0, -1, 0)
                end
                
                bodyVelocity.Velocity = direction * States.FlySpeed
                bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
            end)
        else
            if FlyConnection then
                FlyConnection:Disconnect()
                FlyConnection = nil
            end
            
            local character = LocalPlayer.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, child in pairs(hrp:GetChildren()) do
                        if child:IsA("BodyGyro") or child:IsA("BodyVelocity") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end,
})

FeaturesTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 10,
    Suffix = " studs/s",
    CurrentValue = 50,
    Flag = "FlySpeed",
    Callback = function(Value)
        States.FlySpeed = Value
    end,
})

-- Infinite Jump
local UserInputService = game:GetService("UserInputService")
UserInputService.JumpRequest:Connect(function()
    if States.InfiniteJump and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

FeaturesTab:CreateToggle({
    Name = "⬆️ Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        States.InfiniteJump = Value
    end,
})

-- Infinite Spin
FeaturesTab:CreateToggle({
    Name = "🌪 Infinite Spin",
    CurrentValue = false,
    Flag = 
