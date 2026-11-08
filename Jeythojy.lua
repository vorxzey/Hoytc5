local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("DMXGeneratorUI") then
    playerGui.DMXGeneratorUI:Destroy()
end

-- Preset Channel per Fixture
local fixturePresets = {
    ["Beam"] = 16,
    ["Parled"] = 6,
    ["Strobo"] = 8,
    ["Wallwasher"] = 8,
    ["Blinder"] = 8,
    ["Kipas"] = 8,
    ["Flower"] = 22,
    ["Kipas Daun"] = 27
}

local selectedChannels = 16

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DMXGeneratorUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Container (Solid Black Matte)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 460)
mainFrame.Position = UDim2.new(0.5, -190, 0.4, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(45, 45, 55)
stroke.Thickness = 1
stroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "DMX ADDRESS GENERATOR"
title.TextColor3 = Color3.fromRGB(220, 220, 230)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Left Control Panel (Input & Pilihan Presets)
local controlPanel = Instance.new("Frame")
controlPanel.Size = UDim2.new(0, 150, 1, -45)
controlPanel.Position = UDim2.new(0, 10, 0, 38)
controlPanel.BackgroundTransparency = 1
controlPanel.Parent = mainFrame

local controlLayout = Instance.new("UIListLayout")
controlLayout.Padding = UDim.new(0, 6)
controlLayout.Parent = controlPanel

-- Label Input Start Address
local lblStart = Instance.new("TextLabel")
lblStart.Size = UDim2.new(1, 0, 0, 14)
lblStart.BackgroundTransparency = 1
lblStart.Text = "Start Address:"
lblStart.TextColor3 = Color3.fromRGB(150, 150, 160)
lblStart.TextSize = 10
lblStart.Font = Enum.Font.GothamMedium
lblStart.TextXAlignment = Enum.TextXAlignment.Left
lblStart.Parent = controlPanel

local inputStart = Instance.new("TextBox")
inputStart.Size = UDim2.new(1, 0, 0, 28)
inputStart.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
inputStart.Text = "1"
inputStart.TextColor3 = Color3.fromRGB(255, 255, 255)
inputStart.TextSize = 11
inputStart.Font = Enum.Font.GothamBold
inputStart.Parent = controlPanel

local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0, 5)
startCorner.Parent = inputStart

-- Label Input Jumlah Unit
local lblUnits = Instance.new("TextLabel")
lblUnits.Size = UDim2.new(1, 0, 0, 14)
lblUnits.BackgroundTransparency = 1
lblUnits.Text = "Jumlah Unit:"
lblUnits.TextColor3 = Color3.fromRGB(150, 150, 160)
lblUnits.TextSize = 10
lblUnits.Font = Enum.Font.GothamMedium
lblUnits.TextXAlignment = Enum.TextXAlignment.Left
lblUnits.Parent = controlPanel

local inputUnits = Instance.new("TextBox")
inputUnits.Size = UDim2.new(1, 0, 0, 28)
inputUnits.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
inputUnits.Text = "8"
inputUnits.TextColor3 = Color3.fromRGB(255, 255, 255)
inputUnits.TextSize = 11
inputUnits.Font = Enum.Font.GothamBold
inputUnits.Parent = controlPanel

local unitsCorner = Instance.new("UICorner")
unitsCorner.CornerRadius = UDim.new(0, 5)
unitsCorner.Parent = inputUnits

-- Label Input Channel / Custom Presets
local lblCh = Instance.new("TextLabel")
lblCh.Size = UDim2.new(1, 0, 0, 14)
lblCh.BackgroundTransparency = 1
lblCh.Text = "Channel / Fixture:"
lblCh.TextColor3 = Color3.fromRGB(150, 150, 160)
lblCh.TextSize = 10
lblCh.Font = Enum.Font.GothamMedium
lblCh.TextXAlignment = Enum.TextXAlignment.Left
lblCh.Parent = controlPanel

local inputCh = Instance.new("TextBox")
inputCh.Size = UDim2.new(1, 0, 0, 28)
inputCh.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
inputCh.Text = "16"
inputCh.TextColor3 = Color3.fromRGB(255, 255, 255)
inputCh.TextSize = 11
inputCh.Font = Enum.Font.GothamBold
inputCh.Parent = controlPanel

local chCorner = Instance.new("UICorner")
chCorner.CornerRadius = UDim.new(0, 5)
chCorner.Parent = inputCh

-- Container Presets Tombol Cepat
local presetScroll = Instance.new("ScrollingFrame")
presetScroll.Size = UDim2.new(1, 0, 0, 150)
presetScroll.BackgroundTransparency = 1
presetScroll.ScrollBarThickness = 2
presetScroll.Parent = controlPanel

local presetLayout = Instance.new("UIListLayout")
presetLayout.Padding = UDim.new(0, 4)
presetLayout.Parent = presetScroll

-- Tombol Generate
local btnGenerate = Instance.new("TextButton")
btnGenerate.Size = UDim2.new(1, 0, 0, 32)
btnGenerate.BackgroundColor3 = Color3.fromRGB(40, 120, 220)
btnGenerate.Text = "GENERATE"
btnGenerate.TextColor3 = Color3.fromRGB(255, 255, 255)
btnGenerate.TextSize = 11
btnGenerate.Font = Enum.Font.GothamBold
btnGenerate.Parent = controlPanel

local genCorner = Instance.new("UICorner")
genCorner.CornerRadius = UDim.new(0, 6)
genCorner.Parent = btnGenerate

-- Display Panel Output (Kanan)
local displayContainer = Instance.new("ScrollingFrame")
displayContainer.Size = UDim2.new(1, -180, 1, -50)
displayContainer.Position = UDim2.new(0, 170, 0, 38)
displayContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
displayContainer.BorderSizePixel = 0
displayContainer.ScrollBarThickness = 3
displayContainer.Parent = mainFrame

local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 8)
displayCorner.Parent = displayContainer

local displayLayout = Instance.new("UIListLayout")
displayLayout.Padding = UDim.new(0, 4)
displayLayout.Parent = displayContainer

local displayPadding = Instance.new("UIPadding")
displayPadding.PaddingTop = UDim.new(0, 8)
displayPadding.PaddingLeft = UDim.new(0, 8)
displayPadding.Parent = displayContainer

-- Logika Generator Hitung Kelipatan Address
local function generateDMX()
    for _, child in pairs(displayContainer:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local startAddr = tonumber(inputStart.Text) or 1
    local totalUnits = tonumber(inputUnits.Text) or 1
    local chPerUnit = tonumber(inputCh.Text) or 16

    local currentAddr = startAddr
    for i = 1, totalUnits do
        local endAddr = currentAddr + chPerUnit - 1
        
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, -10, 0, 22)
        txt.BackgroundTransparency = 1
        txt.Text = string.format("Unit %d: %d - %d (Start %d)", i, currentAddr, endAddr, currentAddr)
        txt.TextColor3 = Color3.fromRGB(190, 205, 225)
        txt.TextSize = 10
        txt.Font = Enum.Font.GothamMedium
        txt.TextXAlignment = Enum.TextXAlignment.Left
        txt.Parent = displayContainer

        currentAddr = endAddr + 1
    end
    displayContainer.CanvasSize = UDim2.new(0, 0, 0, totalUnits * 26 + 10)
end

-- Render Preset Quick Buttons
for name, ch in pairs(fixturePresets) do
    local pBtn = Instance.new("TextButton")
    pBtn.Size = UDim2.new(1, -4, 0, 24)
    pBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    pBtn.Text = name .. " (" .. ch .. "Ch)"
    pBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
    pBtn.TextSize = 10
    pBtn.Font = Enum.Font.Gotham
    pBtn.Parent = presetScroll

    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(0, 4)
    pCorner.Parent = pBtn

    pBtn.MouseButton1Click:Connect(function()
        inputCh.Text = tostring(ch)
        generateDMX()
    end)
end
presetScroll.CanvasSize = UDim2.new(0, 0, 0, 8 * 28)

btnGenerate.MouseButton1Click:Connect(generateDMX)
generateDMX()
