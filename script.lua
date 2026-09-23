-- ========================================================
-- SISTEMA DE WHITELIST POR NOMBRE DE USUARIO
-- ========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Agrega aquí los nombres de usuario (Username) de las personas autorizadas
local Whitelist = {
    [LocalPlayer.Name] = true, -- Tu usuario se incluye automáticamente
    -- ["ianjajajjajajapolo1"] = true, -- Ejemplo: agrega el nombre exacto de tu amigo
    -- ["NombreDeTuAmigo2"] = true,
       "ianjajajjajajapolo1".
}

if not Whitelist[LocalPlayer.Name] then
    warn("HRX PRIVADO: No estás en la Whitelist para usar este script.")
    return
end

-- ========================================================
-- INTERFAZ GRÁFICA (GUI) - HRX PRIVADO
-- ========================================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Elimina GUI anterior si ya existe
if CoreGui:FindFirstChild("HRX_PRIVADO_GUI") then
    CoreGui.HRX_PRIVADO_GUI:Destroy()
end

-- Paleta de Colores (Estilo Celeste)
local PRIMARY_COLOR = Color3.fromRGB(0, 170, 255)   -- Celeste
local BG_COLOR      = Color3.fromRGB(18, 18, 22)     -- Fondo Oscuro
local CARD_COLOR    = Color3.fromRGB(28, 28, 35)     -- Contenedores
local TEXT_COLOR    = Color3.fromRGB(255, 255, 255) -- Blanco
local MUTED_TEXT    = Color3.fromRGB(180, 180, 180) -- Gris claro

-- ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HRX_PRIVADO_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Ventana Principal
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

-- Barra Superior (Header Celeste)
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

-- Contenedor de Pestañas
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

-- Área de Contenido
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -20, 1, -80)
ContentArea.Position = UDim2.new(0, 10, 0, 75)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Tablas para Pestañas
local Tabs = {}
local TabPages = {}

local function CreateTab(tabName, layoutOrder)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "Tab"
    TabButton.Size = UDim2.new(0, 115, 1, 0)
    TabButton.BackgroundColor3 = CARD_COLOR
    TabButton.BorderSizePixel = 0
    TabButton.Text = tabName
    TabButton.TextColor3 = MUTED_TEXT
    TabButton.Font = Enum.Font.SourceSans
    TabButton.TextSize = 14
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

-- Creación de las Pestañas
local RebirthsPage         = CreateTab("Rebirths", 1)[cite: 1]
local StrengthMainPage     = CreateTab("Strength (Main)", 2)[cite: 2]
local StrengthLagPage      = CreateTab("Strength (If Main lags)", 3)[cite: 3]
local OtherPage            = CreateTab("Other", 4)[cite: 4]
local InfoPage             = CreateTab("Info", 5)[cite: 1]

-- Seleccionar primera pestaña por defecto
Tabs[1].BackgroundColor3 = PRIMARY_COLOR
Tabs[1].TextColor3 = TEXT_COLOR
TabPages[1].Visible = true

-- ========================================================
-- FUNCIONES DE COMPONENTES REUTILIZABLES
-- ========================================================

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

local function AddToggle(parent, text, defaultState, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 24)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent

    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 18, 0, 18)
    Box.Position = UDim2.new(0, 0, 0.5, -9)
    Box.BackgroundColor3 = defaultState and PRIMARY_COLOR or CARD_COLOR
    Box.BorderSizePixel = 0
    Box.Text = defaultState and "✓" or ""
    Box.TextColor3 = TEXT_COLOR
    Box.TextSize = 12
    Box.Font = Enum.Font.SourceSansBold
    Box.Parent = ToggleFrame

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 3)
    BoxCorner.Parent = Box

    local TextBtn = Instance.new("TextButton")
    TextBtn.Size = UDim2.new(1, -28, 1, 0)
    TextBtn.Position = UDim2.new(0, 26, 0, 0)
    TextBtn.BackgroundTransparency = 1
    TextBtn.Text = text
    TextBtn.TextColor3 = TEXT_COLOR
    TextBtn.TextSize = 14
    TextBtn.Font = Enum.Font.SourceSans
    TextBtn.TextXAlignment = Enum.TextXAlignment.Left
    TextBtn.Parent = ToggleFrame

    local state = defaultState
    local function Toggle()
        state = not state
        Box.BackgroundColor3 = state and PRIMARY_COLOR or CARD_COLOR
        Box.Text = state and "✓" or ""
        if callback then callback(state) end
    end

    Box.MouseButton1Click:Connect(Toggle)
    TextBtn.MouseButton1Click:Connect(Toggle)
end

local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 160, 0, 26)
    Btn.BackgroundColor3 = PRIMARY_COLOR
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = TEXT_COLOR
    Btn.TextSize = 13
    Btn.Font = Enum.Font.SourceSansBold
    Btn.Parent = parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = Btn

    if callback then Btn.MouseButton1Click:Connect(callback) end
end

-- ========================================================
-- CONTENIDO DE CADA PESTAÑA
-- ========================================================

-- --- Pestaña: Rebirths ---
AddLabel(RebirthsPage, "Status: Inactive", PRIMARY_COLOR)[cite: 1]
AddLabel(RebirthsPage, "Runtime: 0d 0h 0m 0s", TEXT_COLOR)[cite: 1]
AddLabel(RebirthsPage, "Rebirths: 10.88M | Gained: 0", TEXT_COLOR)[cite: 1]
AddLabel(RebirthsPage, "Pace: -- / Hour | -- / Day | -- / Week", TEXT_COLOR)[cite: 1]
AddLabel(RebirthsPage, "Average: -- / Hour | -- / Day | -- / Week", TEXT_COLOR)[cite: 1]
AddToggle(RebirthsPage, "Fast Rebirth", false, function(active) print("Fast Rebirth:", active) end)[cite: 1]

-- --- Pestaña: Strength (Main) ---
AddLabel(StrengthMainPage, "Status: Inactive", PRIMARY_COLOR)[cite: 2]
AddLabel(StrengthMainPage, "Runtime: 0d 0h 0m 0s", TEXT_COLOR)[cite: 2]
AddLabel(StrengthMainPage, "Strength: 40.42B | Gained: 0", TEXT_COLOR)[cite: 2]
AddLabel(StrengthMainPage, "Durability: 0 | Gained: 0", TEXT_COLOR)[cite: 2]
AddLabel(StrengthMainPage, "Strength Pace: -- / Hour | -- / Day", TEXT_COLOR)[cite: 2]
AddLabel(StrengthMainPage, "Durability Pace: -- / Hour | -- / Day", TEXT_COLOR)[cite: 2]
AddToggle(StrengthMainPage, "Fast Rep", false, function(active) print("Fast Rep:", active) end)[cite: 2]

-- --- Pestaña: Strength (If Main lags) ---
AddLabel(StrengthLagPage, "Status: Inactive", PRIMARY_COLOR)[cite: 3]
AddLabel(StrengthLagPage, "Runtime: 0d 0h 0m 0s", TEXT_COLOR)[cite: 3]
AddLabel(StrengthLagPage, "Strength: 40.42B | Gained: 0", TEXT_COLOR)[cite: 3]
AddLabel(StrengthLagPage, "Durability: 0 | Gained: 0", TEXT_COLOR)[cite: 3]
AddToggle(StrengthLagPage, "Controlled Speed", true, function(active) print("Controlled Speed:", active) end)[cite: 3]
AddToggle(StrengthLagPage, "Fast Rep", false, function(active) print("Fast Rep:", active) end)[cite: 3]

-- --- Pestaña: Other ---
AddLabel(OtherPage, "Protein Eggs: 623", TEXT_COLOR)[cite: 4]
AddLabel(OtherPage, "x2 Strength: 2d 18h 41m 8s", TEXT_COLOR)[cite: 4]
AddToggle(OtherPage, "Eat Eggs", false, function(a) print("Eat Eggs:", a) end)[cite: 4]
AddToggle(OtherPage, "Auto Shake (just to eat them)", false, function(a) print("Auto Shake:", a) end)[cite: 4]
AddToggle(OtherPage, "Spin Fortune Wheel", false, function(a) print("Spin Wheel:", a) end)[cite: 4]
AddToggle(OtherPage, "Eat All Boosts (Expect Lag)", false, function(a) print("Eat Boosts:", a) end)[cite: 4]
AddToggle(OtherPage, "Hide Pets", true, function(a) print("Hide Pets:", a) end)[cite: 4]
AddToggle(OtherPage, "Hide Popups", true, function(a) print("Hide Popups:", a) end)[cite: 4]

AddButton(OtherPage, "Industrial Lift", function() print("Industrial Lift clic") end)[cite: 4]
AddButton(OtherPage, "Industrial Squat", function() print("Industrial Squat clic") end)[cite: 4]
AddButton(OtherPage, "Anti Lag (for bad devices)", function() print("Anti Lag clic") end)[cite: 4]
AddButton(OtherPage, "Equip Rep Pets", function() print("Equip Rep Pets clic") end)[cite: 4]

-- --- Pestaña: Info ---
AddLabel(InfoPage, "Script creado exclusivamente para: HRX PRIVADO", PRIMARY_COLOR)
AddLabel(InfoPage, "Usuario Autorizado: " .. LocalPlayer.Name, TEXT_COLOR)
