--// ================================
--//  FAKE HACK PANEL (CLIENT ONLY)
--//  PC + MOBILE COMPATIBLE
--//  Works everywhere (no PlaceId lock)
--// ================================

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local cam = workspace.CurrentCamera

-- CREATE GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.IgnoreGuiInset = true
gui.Name = "FakeHackMenu"

-- PANEL
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 260, 0, 330)
panel.Position = UDim2.new(0.7, 0, 0.2, 0)
panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
panel.Active = true
panel.Draggable = true

-- TITLE
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "⚡ Fake Hack Menu"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundColor3 = Color3.fromRGB(255, 40, 40)

-- STATE TABLE
local hacks = {
    SilentAim = false,
    Aimbot = false,
    ESP = false,
    Rage = false,
    NoRecoil = false,
    InfiniteDamage = false,
    SpeedHack = false,
    Fly = false
}

-- BUTTON CREATOR
local function createButton(text, posY, toggleKey)
    local btn = Instance.new("TextButton", panel)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 18
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text .. ": OFF"

    btn.MouseButton1Click:Connect(function()
        hacks[toggleKey] = not hacks[toggleKey]
        btn.Text = text .. ": " .. (hacks[toggleKey] and "ON" or "OFF")
    end)
end

-- BUTTON LIST
local y = 45
local gap = 35

createButton("Silent Aim", y, "SilentAim");             y += gap
createButton("Aimbot", y, "Aimbot");                   y += gap
createButton("ESP", y, "ESP");                         y += gap
createButton("Rage", y, "Rage");                       y += gap
createButton("Infinite Damage", y, "InfiniteDamage");  y += gap
createButton("No Recoil", y, "NoRecoil");              y += gap
createButton("Speed Hack", y, "SpeedHack");            y += gap
createButton("Fly", y, "Fly");                         y += gap

-- MOBILE MENU BUTTON
local mobileBtn = Instance.new("TextButton", gui)
mobileBtn.Size = UDim2.new(0, 55, 0, 55)
mobileBtn.Position = UDim2.new(0.88, 0, 0.82, 0)
mobileBtn.Text = "MENU"
mobileBtn.Font = Enum.Font.SourceSansBold
mobileBtn.TextSize = 16
mobileBtn.BackgroundColor3 = Color3.fromRGB(255,40,40)
mobileBtn.TextColor3 = Color3.fromRGB(255,255,255)

mobileBtn.MouseButton1Click:Connect(function()
	panel.Visible = not panel.Visible
end)

if UIS.TouchEnabled then
	panel.Visible = false
end

-- VISUAL EFFECTS LOOP (FAKE ONLY)
RS.RenderStepped:Connect(function()
    local char = player.Character
    if not char then return end

    -- Fake Rage aura
    if hacks.Rage then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local glow = Instance.new("PointLight")
            glow.Color = Color3.fromRGB(255,0,0)
            glow.Range = 8
            glow.Brightness = 2
            glow.Parent = hrp
            game.Debris:AddItem(glow, 0.1)
        end
    end

    -- Fake Fly
    if hacks.Fly then
        cam.CFrame *= CFrame.new(0, 0.04, 0)
    end

    -- Fake No Recoil = tiny camera shake
    if hacks.NoRecoil then
        cam.CFrame *= CFrame.Angles(
            math.rad(math.random(-1,1)),
            math.rad(math.random(-1,1)),
            0
        )
    end
end)
