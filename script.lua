-- ========================================================
-- SISTEMA DE WHITELIST (HRX PRIVADO)
-- ========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Lista de usuarios autorizados (se convierte a minúsculas automáticamente)
local allowedUsernames = {
    ["ianjajajjajajapolo1"] = true,
    ["renacimientoking"] = true,
    -- Agrega más usuarios aquí abajo en minúsculas si lo necesitas en el futuro:
    -- ["nombredeusuario"] = true,
}

local playerUsername = string.lower(LocalPlayer.Name)

if not allowedUsernames[playerUsername] then
    warn("HRX PRIVADO: No estás en la Whitelist para usar este script.")
    return
end

-- ========================================================
-- INTERFAZ GRÁFICA (GUI) - HRX PRIVADO
-- ========================================================
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("HRX_PRIVADO_GUI") then
    CoreGui.HRX_PRIVADO_GUI:Destroy()
end

local PRIMARY_COLOR = Color3.fromRGB(0, 170, 255)   -- Celeste
local BG_COLOR      = Color3.fromRGB(18, 18, 22)     -- Fondo Oscuro
local CARD_COLOR    = Color3.fromRGB(28, 28, 35)     -- Contenedores
local TEXT_COLOR    = Color3.fromRGB(255, 255, 255) -- Blanco
local MUTED_TEXT    = Color3.fromRGB(180, 180, 180) -- Gris claro

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HRX_PRIVADO_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = PRIMARY_COLOR
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "HRX PRIVADO | Fast Farming - Hey, " .. LocalPlayer.Name .. "!"[cite: 1, 2, 3, 4]
Title.TextColor3 = TEXT_COLOR
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -20, 0, 30)
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabContainer

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -20, 1, -80)
ContentArea.Position = UDim2.new(0, 10, 0, 75)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local Tabs = {}
local TabPages = {}

local function CreateTab(tabName, layoutOrder)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "Tab"
    TabButton.Size = UDim2.new(0, 98, 1, 0)
    TabButton.BackgroundColor3 = CARD_COLOR
    TabButton.BorderSizePixel = 0
    TabButton.Text = tabName
    TabButton.TextColor3 = MUTED_TEXT
    TabButton.Font = Enum.Font.SourceSans
    TabButton.TextSize = 13
    TabButton.LayoutOrder = layoutOrder
    TabButton.Parent = TabContainer

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Parent = TabButton

    local Page = Instance.new("ScrollingFrame")
    Page.Name = tabName .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.Visible = false
    Page.Parent = ContentArea

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.Parent = Page

    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(TabPages) do p.Visible = false end
        for _, b in pairs(Tabs) do 
            b.BackgroundColor3 = CARD_COLOR 
            b.TextColor3 = MUTED_TEXT
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = PRIMARY_COLOR
        TabButton.TextColor3 = TEXT_COLOR
    end)

    table.insert(Tabs, TabButton)
    table.insert(TabPages, Page)
    return Page
end

local RebirthsPage     = CreateTab("Rebirths", 1)[cite: 1]
local StrengthMainPage = CreateTab("Strength Main", 2)[cite: 2]
local StrengthLagPage  = CreateTab("Strength Lag", 3)[cite: 3]
local OtherPage        = CreateTab("Other", 4)[cite: 4]
local InfoPage         = CreateTab("Info", 5)[cite: 1]

Tabs[1].BackgroundColor3 = PRIMARY_COLOR
Tabs[1].TextColor3 = TEXT_COLOR
TabPages[1].Visible = true

local function AddLabel(parent, text, color)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = color or TEXT_COLOR
    Label.TextSize = 14
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
    return Label
end

-- Pestaña Rebirths
AddLabel(RebirthsPage, "Status: Inactive", PRIMARY_COLOR)[cite: 1]
AddLabel(RebirthsPage, "Runtime: 0d 0h 0m 0s", TEXT_COLOR)[cite: 1]

-- Pestaña Strength Main
AddLabel(StrengthMainPage, "Status: Inactive", PRIMARY_COLOR)[cite: 2]

-- Pestaña Info
AddLabel(InfoPage, "Script: HRX PRIVADO", PRIMARY_COLOR)
AddLabel(InfoPage, "Usuario: " .. LocalPlayer.Name, TEXT_COLOR)
