local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("DmxFixtureUI") then
    playerGui.DmxFixtureUI:Destroy()
end

-- Data Fixture Presets (Channel & Nama)
local fixturePresets = {
    {name = "Beam (16ch)", ch = 16},
    {name = "Parled (6ch)", ch = 6},
    {name = "Strobo (8ch)", ch = 8},
    {name = "Wallwasher (8ch)", ch = 8},
    {name = "Blinder (8ch)", ch = 8},
    {name = "Kipas (8ch)", ch = 8},
    {name = "Flower (22ch)", ch = 22},
    {name = "Kipas Daun (27ch)", ch = 27}
}

local selectedPresetIndex = 1
local addedFixtures = {}

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DmxFixtureUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame Utama (Dark Blue-Gray Matte)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 480)
mainFrame.Position = UDim2.new(0.5, -190, 0.4, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 29, 36)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(50, 60, 75)
stroke.Thickness = 1.5
stroke.Parent = mainFrame

-- Title Bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 36)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔵 Fixture"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Top Input Area (Selection Bar)
local inputBar = Instance.new("Frame")
inputBar.Size = UDim2.new(1, -24, 0, 42)
inputBar.Position = UDim2.new(0, 12, 0, 40)
inputBar.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
inputBar.BorderSizePixel = 0
inputBar.Parent = mainFrame

local inputBarCorner = Instance.new("UICorner")
inputBarCorner.CornerRadius = UDim.new(0, 8)
inputBarCorner.Parent = inputBar

local inputBarStroke = Instance.new("UIStroke")
inputBarStroke.Color = Color3.fromRGB(60, 75, 95)
inputBarStroke.Thickness = 1
inputBarStroke.Parent = inputBar

-- Button Dropdown Fixture
local btnDropdown = Instance.new("TextButton")
btnDropdown.Size = UDim2.new(0, 180, 0, 28)
btnDropdown.Position = UDim2.new(0, 8, 0, 7)
btnDropdown.BackgroundColor3 = Color3.fromRGB(28, 35, 45)
btnDropdown.Text = fixturePresets[1].name .. " 🗲"
btnDropdown.TextColor3 = Color3.fromRGB(220, 230, 245)
btnDropdown.TextSize = 11
btnDropdown.Font = Enum.Font.GothamMedium
btnDropdown.Parent = inputBar

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 6)
dropCorner.Parent = btnDropdown

-- TextBox Count (Jumlah Unit)
local boxCount = Instance.new("TextBox")
boxCount.Size = UDim2.new(0, 45, 0, 28)
boxCount.Position = UDim2.new(0, 194, 0, 7)
boxCount.BackgroundColor3 = Color3.fromRGB(12, 15, 20)
boxCount.Text = "1"
boxCount.TextColor3 = Color3.fromRGB(255, 255, 255)
boxCount.TextSize = 11
boxCount.Font = Enum.Font.GothamBold
boxCount.Parent = inputBar

local countCorner = Instance.new("UICorner")
countCorner.CornerRadius = UDim.new(0, 6)
countCorner.Parent = boxCount

-- Button Tambah (Cyan Accent)
local btnAdd = Instance.new("TextButton")
btnAdd.Size = UDim2.new(0, 100, 0, 28)
btnAdd.Position = UDim2.new(1, -108, 0, 7)
btnAdd.BackgroundColor3 = Color3.fromRGB(45, 145, 200)
btnAdd.Text = "Tambah"
btnAdd.TextColor3 = Color3.fromRGB(255, 255, 255)
btnAdd.TextSize = 11
btnAdd.Font = Enum.Font.GothamBold
btnAdd.Parent = inputBar

local addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0, 6)
addCorner.Parent = btnAdd

-- Subtitle / Instruction Text
local lblGuide = Instance.new("TextLabel")
lblGuide.Size = UDim2.new(1, -24, 0, 20)
lblGuide.Position = UDim2.new(0, 12, 0, 86)
lblGuide.BackgroundTransparency = 1
lblGuide.Text = "Pilih fixture, ketik jumlah, Enter. Panah atas/bawah ganti tipe."
lblGuide.TextColor3 = Color3.fromRGB(140, 155, 175)
lblGuide.TextSize = 9
lblGuide.Font = Enum.Font.Gotham
lblGuide.TextXAlignment = Enum.TextXAlignment.Left
lblGuide.Parent = mainFrame

-- Header Table (Count & Hapus Semua)
local lblCountHeader = Instance.new("TextLabel")
lblCountHeader.Size = UDim2.new(0, 150, 0, 20)
lblCountHeader.Position = UDim2.new(0, 12, 0, 112)
lblCountHeader.BackgroundTransparency = 1
lblCountHeader.Text = "Fixture (0)"
lblCountHeader.TextColor3 = Color3.fromRGB(230, 235, 245)
lblCountHeader.TextSize = 11
lblCountHeader.Font = Enum.Font.GothamBold
lblCountHeader.TextXAlignment = Enum.TextXAlignment.Left
lblCountHeader.Parent = mainFrame

local btnClearAll = Instance.new("TextButton")
btnClearAll.Size = UDim2.new(0, 90, 0, 20)
btnClearAll.Position = UDim2.new(1, -102, 0, 112)
btnClearAll.BackgroundTransparency = 1
btnClearAll.Text = "Hapus semua"
btnClearAll.TextColor3 = Color3.fromRGB(235, 90, 90)
btnClearAll.TextSize = 10
btnClearAll.Font = Enum.Font.GothamBold
btnClearAll.TextXAlignment = Enum.TextXAlignment.Right
btnClearAll.Parent = mainFrame

-- Table Container (Scrolling List)
local scrollList = Instance.new("ScrollingFrame")
scrollList.Size = UDim2.new(1, -24, 1, -145)
scrollList.Position = UDim2.new(0, 12, 0, 134)
scrollList.BackgroundTransparency = 1
scrollList.ScrollBarThickness = 3
scrollList.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = scrollList

-- Render ulang isi tabel DMX
local function refreshTable()
    for _, item in pairs(scrollList:GetChildren()) do
        if item:IsA("Frame") then item:Destroy() end
    end

    local currentAddr = 1
    for index, fix in ipairs(addedFixtures) do
        local endAddr = currentAddr + fix.ch - 1

        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -6, 0, 34)
        row.BackgroundColor3 = Color3.fromRGB(20, 24, 30)
        row.BorderSizePixel = 0
        row.Parent = scrollList

        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 6)
        rowCorner.Parent = row

        -- Accent Strip Kiri
        local strip = Instance.new("Frame")
        strip.Size = UDim2.new(0, 3, 0, 18)
        strip.Position = UDim2.new(0, 6, 0.5, -9)
        strip.BackgroundColor3 = Color3.fromRGB(60, 150, 230)
        strip.BorderSizePixel = 0
        strip.Parent = row

        -- Nomor Unit & Nama
        local lblTitle = Instance.new("TextLabel")
        lblTitle.Size = UDim2.new(0, 150, 1, 0)
        lblTitle.Position = UDim2.new(0, 16, 0, 0)
        lblTitle.BackgroundTransparency = 1
        lblTitle.Text = index .. "   " .. fix.name
        lblTitle.TextColor3 = Color3.fromRGB(210, 220, 235)
        lblTitle.TextSize = 10
        lblTitle.Font = Enum.Font.GothamMedium
        lblTitle.TextXAlignment = Enum.TextXAlignment.Left
        lblTitle.Parent = row

        -- Box Start Address
        local boxStart = Instance.new("TextLabel")
        boxStart.Size = UDim2.new(0, 48, 0, 22)
        boxStart.Position = UDim2.new(1, -150, 0.5, -11)
        boxStart.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
        boxStart.Text = tostring(currentAddr)
        boxStart.TextColor3 = Color3.fromRGB(255, 255, 255)
        boxStart.TextSize = 10
        boxStart.Font = Enum.Font.GothamBold
        boxStart.Parent = row

        local b1Corner = Instance.new("UICorner")
        b1Corner.CornerRadius = UDim.new(0, 4)
        b1Corner.Parent = boxStart

        -- Box End Address
        local boxEnd = Instance.new("TextLabel")
        boxEnd.Size = UDim2.new(0, 48, 0, 22)
        boxEnd.Position = UDim2.new(1, -96, 0.5, -11)
        boxEnd.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
        boxEnd.Text = "+" .. tostring(endAddr)
        boxEnd.TextColor3 = Color3.fromRGB(140, 155, 175)
        boxEnd.TextSize = 9
        boxEnd.Font = Enum.Font.Gotham
        boxEnd.Parent = row

        local b2Corner = Instance.new("UICorner")
        b2Corner.CornerRadius = UDim.new(0, 4)
        b2Corner.Parent = boxEnd

        -- Tombol Delete (x)
        local btnDel = Instance.new("TextButton")
        btnDel.Size = UDim2.new(0, 22, 0, 22)
        btnDel.Position = UDim2.new(1, -30, 0.5, -11)
        btnDel.BackgroundColor3 = Color3.fromRGB(30, 36, 46)
        btnDel.Text = "×"
        btnDel.TextColor3 = Color3.fromRGB(200, 100, 100)
        btnDel.TextSize = 12
        btnDel.Font = Enum.Font.GothamBold
        btnDel.Parent = row

        local delCorner = Instance.new("UICorner")
        delCorner.CornerRadius = UDim.new(0, 4)
        delCorner.Parent = btnDel

        btnDel.MouseButton1Click:Connect(function()
            table.remove(addedFixtures, index)
            refreshTable()
        end)

        currentAddr = endAddr + 1
    end

    lblCountHeader.Text = string.format("Fixture (%d)", #addedFixtures)
    scrollList.CanvasSize = UDim2.new(0, 0, 0, #addedFixtures * 40)
end

-- Toggle Dropdown Tipe Fixture
btnDropdown.MouseButton1Click:Connect(function()
    selectedPresetIndex = selectedPresetIndex + 1
    if selectedPresetIndex > #fixturePresets then selectedPresetIndex = 1 end
    btnDropdown.Text = fixturePresets[selectedPresetIndex].name .. " 🗲"
end)

-- Event Tombol Tambah
btnAdd.MouseButton1Click:Connect(function()
    local qty = tonumber(boxCount.Text) or 1
    local preset = fixturePresets[selectedPresetIndex]
    
    for i = 1, qty do
        table.insert(addedFixtures, {
            name = preset.name:gsub(" %(%d+ch%)", ""),
            ch = preset.ch
        })
    end
    refreshTable()
end)

-- Event Hapus Semua
btnClearAll.MouseButton1Click:Connect(function()
    addedFixtures = {}
    refreshTable()
end)
