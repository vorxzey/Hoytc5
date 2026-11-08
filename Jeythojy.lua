local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("DMXCalculatorUI") then
    playerGui.DMXCalculatorUI:Destroy()
end

-- Data Fixture (Channel & Jumlah Unit)
local dmxData = {
    {name = "Beam", channels = 16, count = 16},
    {name = "Parled", channels = 6, count = 6},
    {name = "Strobo", channels = 8, count = 8},
    {name = "Wallwasher", channels = 8, count = 8},
    {name = "Blinder", channels = 8, count = 8},
    {name = "Kipas", channels = 8, count = 8},
    {name = "Flower", channels = 22, count = 2},
    {name = "Kipas Daun", channels = 27, count = 2}
}

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DMXCalculatorUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame Utama (Solid Matte Black)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 420)
mainFrame.Position = UDim2.new(0.5, -180, 0.4, -210)
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

-- Title Bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "DMX ADDRESS CALCULATOR"
title.TextColor3 = Color3.fromRGB(220, 220, 230)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Container Tombol Fixture (Kiri)
local btnContainer = Instance.new("ScrollingFrame")
btnContainer.Size = UDim2.new(0, 130, 1, -50)
btnContainer.Position = UDim2.new(0, 10, 0, 45)
btnContainer.BackgroundTransparency = 1
btnContainer.ScrollBarThickness = 2
btnContainer.Parent = mainFrame

local btnLayout = Instance.new("UIListLayout")
btnLayout.Padding = UDim.new(0, 6)
btnLayout.Parent = btnContainer

-- Container Output Address (Kanan)
local displayContainer = Instance.new("ScrollingFrame")
displayContainer.Size = UDim2.new(1, -160, 1, -50)
displayContainer.Position = UDim2.new(0, 150, 0, 45)
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

-- Fungsi Tampilkan Address
local function showAddresses(item)
    for _, child in pairs(displayContainer:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local currentAddress = 1
    for i = 1, item.count do
        local endAddress = currentAddress + item.channels - 1
        
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, -10, 0, 22)
        txt.BackgroundTransparency = 1
        txt.Text = string.format("%s %d: Addr %d", item.name, i, currentAddress)
        txt.TextColor3 = Color3.fromRGB(180, 190, 205)
        txt.TextSize = 11
        txt.Font = Enum.Font.GothamMedium
        txt.TextXAlignment = Enum.TextXAlignment.Left
        txt.Parent = displayContainer

        currentAddress = endAddress + 1
    end
    displayContainer.CanvasSize = UDim2.new(0, 0, 0, item.count * 26 + 10)
end

-- Render Tombol Fixture
for _, item in ipairs(dmxData) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    btn.BorderSizePixel = 0
    btn.Text = item.name
    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
    btn.TextSize = 11
    btn.Font = Enum.Font.Gotham
    btn.Parent = btnContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        showAddresses(item)
    end)
end

btnContainer.CanvasSize = UDim2.new(0, 0, 0, #dmxData * 38)
