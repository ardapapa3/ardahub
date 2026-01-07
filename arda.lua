-- Gokce Script | Made by Arda
-- Game: The Strongest Battlegrounds

-- GAME CHECK
if game.PlaceId ~= 10449761463 then
    warn("Wrong game")
    return
end

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- CHARACTER
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- VARIABLES
local SpeedEnabled = false
local SpeedValue = 0.2

-- RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Gokce Script",
    LoadingTitle = "Gokce Script",
    LoadingSubtitle = "Made by Arda",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "GokceScript"
    },
    KeySystem = false
})

-- TABS
local MainTab = Window:CreateTab("Main", "user")
local MovementTab = Window:CreateTab("Movement", "activity")
local TeleportTab = Window:CreateTab("Teleport", "map")

-------------------------------------------------
-- MAIN TAB
-------------------------------------------------

MainTab:CreateSection("Player")

MainTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = false,
    Callback = function(v)
        SpeedEnabled = v
    end
})

MainTab:CreateSlider({
    Name = "Speed Value",
    Range = {0, 5},
    Increment = 0.1,
    CurrentValue = 0.2,
    Callback = function(v)
        SpeedValue = v
    end
})

RunService.Heartbeat:Connect(function()
    if SpeedEnabled and HRP and Humanoid.MoveDirection.Magnitude > 0 then
        HRP.CFrame += Humanoid.MoveDirection * SpeedValue
    end
end)

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = v
    end
})

MainTab:CreateSlider({
    Name = "Gravity",
    Range = {0, 196.2},
    Increment = 1,
    CurrentValue = workspace.Gravity,
    Callback = function(v)
        workspace.Gravity = v
    end
})

MainTab:CreateSlider({
    Name = "FOV",
    Range = {50, 120},
    Increment = 1,
    CurrentValue = workspace.CurrentCamera.FieldOfView,
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end
})

-------------------------------------------------
-- MOVEMENT TAB
-------------------------------------------------

MovementTab:CreateSection("Combat Exploits")

MovementTab:CreateToggle({
    Name = "No Dash Cooldown",
    CurrentValue = false,
    Callback = function(v)
        workspace:SetAttribute("NoDashCooldown", v)
    end
})

MovementTab:CreateToggle({
    Name = "No Fatigue",
    CurrentValue = false,
    Callback = function(v)
        workspace:SetAttribute("NoFatigue", v)
    end
})

MovementTab:CreateToggle({
    Name = "No Stun",
    CurrentValue = false,
    Callback = function(v)
        if v then
            if Humanoid:FindFirstChild("Stun") then
                Humanoid.Stun:Destroy()
            end
        end
    end
})

-------------------------------------------------
-- TELEPORT TAB
-------------------------------------------------

TeleportTab:CreateSection("Locations")

TeleportTab:CreateButton({
    Name = "Middle",
    Callback = function()
        HRP.CFrame = CFrame.new(148, 441, 27)
    end
})

TeleportTab:CreateButton({
    Name = "Atomic Room",
    Callback = function()
        HRP.CFrame = CFrame.new(1079, 155, 23003)
    end
})

TeleportTab:CreateButton({
    Name = "Death Counter",
    Callback = function()
        HRP.CFrame = CFrame.new(-92, 29, 20347)
    end
})

TeleportTab:CreateButton({
    Name = "Baseplate",
    Callback = function()
        HRP.CFrame = CFrame.new(968, 20, 23088)
    end
})

TeleportTab:CreateButton({
    Name = "Mountain 1",
    Callback = function()
        HRP.CFrame = CFrame.new(266, 699, 458)
    end
})

TeleportTab:CreateButton({
    Name = "Mountain 2",
    Callback = function()
        HRP.CFrame = CFrame.new(551, 630, -265)
    end
})

TeleportTab:CreateButton({
    Name = "Mountain 3",
    Callback = function()
        HRP.CFrame = CFrame.new(-107, 642, -328)
    end
})
