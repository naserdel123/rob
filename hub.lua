--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║                    GOGO HUB - Ultimate Script                  ║
    ║                     Developed by: Naser Adm                    ║
    ╚═══════════════════════════════════════════════════════════════╝
    
    Fixed & Optimized Version
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Wait for character
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

--// SPLASH SCREEN SYSTEM //--
local function CreateSplashScreen()
    local success, err = pcall(function()
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
        task.spawn(function()
            while ScreenGui and ScreenGui.Parent do
                for i = 0, 360, 2 do
                    if not UIGradient or not UIGradient.Parent then break end
                    UIGradient.Rotation = i
                    task.wait(0.03)
                end
            end
        end)
        
        -- Goku Image
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "GokuImage"
        ImageLabel.Size = UDim2.new(0, 300, 0, 300)
        ImageLabel.Position = UDim2.new(0.5, -150, 0.4, -150)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://11141271480"
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
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 150, 255),
                Color3.fromRGB(150, 0, 255),
                Color3.fromRGB(255, 0, 150),
                Color3.fromRGB(0, 255, 150),
            }
            local index = 1
            
            while ScreenGui and ScreenGui.Parent do
                local color = colors[index]
                pcall(function()
                    TweenService:Create(Glow, TweenInfo.new(1, Enum.EasingStyle.Quad), {
                        ImageColor3 = color
                    }):Play()
                end)
                
                index = index % #colors + 1
                task.wait(1.5)
            end
        end)
        
        -- Rotation Animation
        task.spawn(function()
            while ScreenGui and ScreenGui.Parent do
                pcall(function()
                    TweenService:Create(ImageLabel, TweenInfo.new(8, Enum.EasingStyle.Linear), {
                        Rotation = ImageLabel.Rotation + 360
                    }):Play()
                end)
                task.wait(8)
            end
        end)
        
        -- Pulse Animation
        task.spawn(function()
            while ScreenGui and ScreenGui.Parent do
                pcall(function()
                    TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Size = UDim2.new(0, 320, 0, 320),
                        Position = UDim2.new(0.5, -160, 0.4, -160)
                    }):Play()
                end)
                task.wait(1)
                pcall(function()
                    TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Size = UDim2.new(0, 300, 0, 300),
                        Position = UDim2.new(0.5, -150, 0.4, -150)
                    }):Play()
                end)
                task.wait(1)
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
        pcall(function()
            TweenService:Create(BarFill, TweenInfo.new(5, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 1, 0)
            }):Play()
        end)
        
        -- Wait and Destroy
        task.wait(6)
        
        -- Fade Out
        pcall(function()
            TweenService:Create(MainFrame, TweenInfo.new(1), {
                BackgroundTransparency = 1
            }):Play()
        end)
        
        for _, child in pairs(MainFrame:GetDescendants()) do
            if child:IsA("GuiObject") then
                pcall(function()
                    TweenService:Create(child, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play()
                end)
            end
        end
        
        task.wait(1)
        ScreenGui:Destroy()
    end)
    
    if not success then
        warn("Splash Screen Error: " .. tostring(err))
    end
end

-- Show Splash Screen
CreateSplashScreen()

--// LOAD RAYFIELD LIBRARY //--
local Rayfield = nil
local loadSuccess, loadErr = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not loadSuccess or not Rayfield then
    warn("Failed to load Rayfield: " .. tostring(loadErr))
    -- Fallback notification
    StarterGui:SetCore("SendNotification", {
        Title = "GOGO HUB",
        Text = "Failed to load UI Library!",
        Duration = 5
    })
    return
end

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
    FE_Music = false,
    MusicId = "",
    SelectedPlayer = nil
}

--// MUSIC TAB //--
local MusicTab = Window:CreateTab("🎵 Music")

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
            States.CurrentMusic = nil
        end
        
        if not States.MusicId or States.MusicId == "" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter an Audio ID first!",
                Duration = 3,
            })
            return
        end
        
        local success = pcall(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. tostring(States.MusicId)
            sound.Looped = true
            sound.Volume = 2
            sound.Parent = SoundService
            sound:Play()
            States.CurrentMusic = sound
        end)
        
        if success then
            Rayfield:Notify({
                Title = "Music Started",
                Content = "Playing Audio ID: " .. States.MusicId,
                Duration = 3,
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to play audio!",
                Duration = 3,
            })
        end
    end,
})

MusicTab:CreateToggle({
    Name = "🔁 FE Loop Attempt (5s)",
    CurrentValue = false,
    Flag = "FEMusic",
    Callback = function(Value)
        States.FE_Music = Value
        
        if Value then
            task.spawn(function()
                while States.FE_Music do
                    task.wait(5)
                    if States.CurrentMusic then
                        pcall(function()
                            States.CurrentMusic:Stop()
                            States.CurrentMusic:Play()
                        end)
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
local PlayersTab = Window:CreateTab("👥 Players")

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
task.spawn(function()
    while task.wait(5) do
        local playerNames = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        pcall(function()
            PlayerDropdown:Refresh(playerNames, true)
        end)
    end
end)

PlayersTab:CreateButton({
    Name = "👁 Spy (Spectate)",
    Callback = function()
        local targetName = States.SelectedPlayer
        if not targetName or targetName == "" then
            Rayfield:Notify({Title = "Error", Content = "Select a player first!", Duration = 2})
            return
        end
        
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
            Rayfield:Notify({Title = "Error", Content = "Player not found!", Duration = 2})
        end
    end,
})

PlayersTab:CreateButton({
    Name = "👕 Copy Outfit",
    Callback = function()
        local targetName = States.SelectedPlayer
        if not targetName or targetName == "" then
            Rayfield:Notify({Title = "Error", Content = "Select a player first!", Duration = 2})
            return
        end
        
        local target = Players:FindFirstChild(targetName)
        if target and target.Character and LocalPlayer.Character then
            local success, err = pcall(function()
                local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
                local targetHumanoid = target.Character:WaitForChild("Humanoid")
                local description = targetHumanoid:GetAppliedDescription()
                humanoid:ApplyDescription(description)
            end)
            
            if success then
                Rayfield:Notify({
                    Title = "Success",
                    Content = "Copied outfit from " .. target.Name,
                    Duration = 3,
                })
            else
                Rayfield:Notify({Title = "Error", Content = "Failed: " .. tostring(err), Duration = 3})
            end
        end
    end,
})

PlayersTab:CreateButton({
    Name = "💀 Kill",
    Callback = function()
        local targetName = States.SelectedPlayer
        if not targetName or targetName == "" then
            Rayfield:Notify({Title = "Error", Content = "Select a player first!", Duration = 2})
            return
        end
        
        local target = Players:FindFirstChild(targetName)
        if target and target.Character then
            local humanoid = target.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
                Rayfield:Notify({
                    Title = "Killed",
                    Content = target.Name .. " eliminated",
                    Duration = 2,
                })
            end
        end
    end,
})

PlayersTab:CreateButton({
    Name = "☁️ Sky Platform",
    Callback = function()
        local targetName = States.SelectedPlayer
        if not targetName or targetName == "" then
            Rayfield:Notify({Title = "Error", Content = "Select a player first!", Duration = 2})
            return
        end
        
        local target = Players:FindFirstChild(targetName)
        if target and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local platform = Instance.new("Part")
                platform.Size = Vector3.new(10, 1, 10)
                platform.Position = hrp.Position + Vector3.new(0, 500, 0)
                platform.Anchored = true
                platform.Color = Color3.fromRGB(255, 0, 0)
                platform.Name = "SkyPlatform"
                platform.Parent = Workspace
                
                hrp.CFrame = CFrame.new(platform.Position + Vector3.new(0, 5, 0))
                
                Rayfield:Notify({
                    Title = "Sky Platform",
                    Content = "Sent " .. target.Name .. " to sky",
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
local FeaturesTab = Window:CreateTab("⚡ Features")

-- Noclip
FeaturesTab:CreateToggle({
    Name = "👻 Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        States.Noclip = Value
        
        if Value then
            task.spawn(function()
                while States.Noclip do
                    task.wait()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
                
                -- Restore collision
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end)
        end
    end,
})

-- Fly System
local FlyConnection = nil

FeaturesTab:CreateToggle({
    Name = "🚀 Fly (Space/Shift)",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        States.Fly = Value
        
        if Value then
            local character = LocalPlayer.Character
            if not character then return end
            
            local hrp = character:WaitForChild("HumanoidRootPart")
            
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
                if UserInputSe
