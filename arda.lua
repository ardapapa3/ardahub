local placeID = game.PlaceId
if placeID ~= 10449761463 then return end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- ATTRIBUTES
if workspace:GetAttribute("NoDashCooldown") == nil then
    workspace:SetAttribute("NoDashCooldown", false)
end
if workspace:GetAttribute("NoFatigue") == nil then
    workspace:SetAttribute("NoFatigue", false)
end
if LocalPlayer:GetAttribute("ExtraSlots") == nil then
    LocalPlayer:SetAttribute("ExtraSlots", false)
end
if LocalPlayer:GetAttribute("EmoteSearchBar") == nil then
    LocalPlayer:SetAttribute("EmoteSearchBar", false)
end

-- RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Gokce Script",
    Icon = "user",
    LoadingTitle = "Rayfield",
    LoadingSubtitle = "Made by Arda",
    Theme = "Default",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "Gokce-Script"
    },
    KeySystem = false
})

-- TABS
local MainTab = Window:CreateTab("Main", "user")
local MovementTab = Window:CreateTab("Movement", "run")
local TeleportTab = Window:CreateTab("Teleport", "map")

-- ======================
-- MAIN (CAMERA & GAME)
-- ======================
MainTab:CreateSlider({
    Name = "Gravity",
    Range = {0,192.6},
    Increment = 0.1,
    CurrentValue = 192.6,
    Callback = function(v)
        workspace.Gravity = v
    end
})

MainTab:CreateSlider({
    Name = "FOV",
    Range = {0,120},
    Increment = 0.1,
    CurrentValue = 70,
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end
})

MainTab:CreateToggle({
    Name = "No Dash Cooldown",
    Callback = function(v)
        workspace:SetAttribute("NoDashCooldown", v)
    end
})

MainTab:CreateToggle({
    Name = "No Fatigue",
    Callback = function(v)
        workspace:SetAttribute("NoFatigue", v)
    end
})

MainTab:CreateToggle({
    Name = "Emotes Extra Slots",
    Callback = function(v)
        LocalPlayer:SetAttribute("ExtraSlots", v)
    end
})

MainTab:CreateToggle({
    Name = "Emotes Search Bar",
    Callback = function(v)
        LocalPlayer:SetAttribute("EmoteSearchBar", v)
    end
})

-- ======================
-- MOVEMENT
-- ======================
local tpwalking = false
local tspeed = 0.1
local noStun = false

MovementTab:CreateToggle({
    Name = "Speed Boost",
    Callback = function(v)
        tpwalking = v
    end
})

MovementTab:CreateSlider({
    Name = "Speed",
    Range = {0,5},
    Increment = 0.1,
    CurrentValue = 0.1,
    Callback = function(v)
        tspeed = v
    end
})

MovementTab:CreateToggle({
    Name = "Jump Boost",
    Callback = function(v)
        Humanoid.UseJumpPower = not v
    end
})

MovementTab:CreateSlider({
    Name = "Jump",
    Range = {7.2,500},
    Increment = 0.1,
    CurrentValue = 7.2,
    Callback = function(v)
        Humanoid.JumpHeight = v
    end
})

-- 🔥 NO STUN
MovementTab:CreateToggle({
    Name = "No Stun",
    Callback = function(v)
        noStun = v
        if v then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        else
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, true)
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        end
    end
})

RunService.Heartbeat:Connect(function()
    if tpwalking and Humanoid and HRP then
        if Humanoid.MoveDirection.Magnitude > 0 then
            HRP.CFrame += Humanoid.MoveDirection * tspeed
        end
    end

    if noStun and Humanoid then
        Humanoid.PlatformStand = false
        if Humanoid:GetState() == Enum.HumanoidStateType.Stunned then
            Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
end)

-- ======================
-- TELEPORTS
-- ======================
TeleportTab:CreateButton({
    Name = "Middle",
    Callback = function()
        HRP.CFrame = CFrame.new(148,441,27)
    end
})

TeleportTab:CreateButton({
    Name = "Atomic Room",
    Callback = function()
        HRP.CFrame = CFrame.new(1079,155,23003)
    end
})

TeleportTab:CreateButton({
    Name = "Death Counter Room",
    Callback = function()
        HRP.CFrame = CFrame.new(-92,29,20347)
    end
})

TeleportTab:CreateButton({
    Name = "Baseplate",
    Callback = function()
        HRP.CFrame = CFrame.new(968,20,23088)
    end
})

TeleportTab:CreateButton({
    Name = "Mountain 1",
    Callback = function()
        HRP.CFrame = CFrame.new(266,699,458)
    end
})

TeleportTab:CreateButton({
    Name = "Mountain 2",
    Callback = function()
        HRP.CFrame = CFrame.new(551,630,-265)
    end
})

TeleportTab:CreateButton({
    Name = "Mountain 3",
    Callback = function()
        HRP.CFrame = CFrame.new(-107,642,-328)
    end
})

-- ======================
-- FLOATING LOGO BUTTON
-- ======================
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local btn = Instance.new("ImageButton", gui)
btn.Size = UDim2.fromOffset(60,60)
btn.Position = UDim2.new(1,-80,0.5,-30)
btn.BackgroundTransparency = 1
btn.Image = "https://raw.githubusercontent.com/ardapapa3/resim/refs/heads/main/png.jpg"
btn.Visible = false

local corner = Instance.new("UICorner", btn)
corner.CornerRadius = UDim.new(1,0)

local menuOpen = true

btn.MouseButton1Click:Connect(function()
    Rayfield:Toggle()
    menuOpen = true
    btn.Visible = false
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.K then
        menuOpen = not menuOpen
        btn.Visible = not menuOpen
    end
end)

local dragging = false
local dragStart, startPos

btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = btn.Position
    end
end)

btn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        btn.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
