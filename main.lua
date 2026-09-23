-- Cargar librería de Interfaz Gráfica (Rayfield UI)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "HRX-PRIV | Hey, HIX_RENACIMIENTOking!",
   LoadingTitle = "XEO Script Suite",
   LoadingSubtitle = "by HRX_RENACIMIENTOKING",
   ConfigurationSaving = {
      Enabled = false
   }
})

-- Variables de Estado (Toggles)
local AutoLift = false
local AutoSquat = false
local FastRebirth = false
local HidePets = false
local HidePopups = false
local AntiLag = false
local AutoEatEggs = false
local AutoSpinWheel = false

-- Serviciales del Juego
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- Anti-AFK para evitar desconexiones
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

----------------------------------------------------------------
-- TAB 1: STRENGTH (MAIN)
----------------------------------------------------------------
local MainTab = Window:CreateTab("Strength (Main)", 4483362458)

MainTab:CreateLabel("Status: Active")
MainTab:CreateLabel("Runtime: 00d 00h 00m")

MainTab:CreateToggle({
   Name = "Controlled Speed",
   CurrentValue = true,
   Callback = function(Value)
      -- Ajustar velocidad de ejecución de acciones
   end,
})

MainTab:CreateToggle({
   Name = "Fast Step",
   CurrentValue = true,
   Callback = function(Value)
      -- Optimización de frames/intervalo
   end,
})

----------------------------------------------------------------
-- TAB 2: REBIRTHS
----------------------------------------------------------------
local RebirthTab = Window:CreateTab("Rebirths", 4483362458)

RebirthTab:CreateToggle({
   Name = "Fast Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      FastRebirth = Value
      task.spawn(function()
          while FastRebirth do
              -- Evento remoto para ejecutar el Renacimiento/Rebirth
              pcall(function()
                  game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Rebirth"):FireServer()
              end)
              task.wait(0.1)
          end
      end)
   end,
})

----------------------------------------------------------------
-- TAB 3: OTHER (FARM & CONFIG)
----------------------------------------------------------------
local OtherTab = Window:CreateTab("Other", 4483362458)

OtherTab:CreateToggle({
   Name = "Industrial Lift",
   CurrentValue = false,
   Callback = function(Value)
      AutoLift = Value
      task.spawn(function()
          while AutoLift do
              -- Evento o simulación para entrenamiento con pesas
              pcall(function()
                  game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Train"):FireServer("Lift")
              end)
              task.wait(0.05)
          end
      end)
   end,
})

OtherTab:CreateToggle({
   Name = "Industrial Squat",
   CurrentValue = false,
   Callback = function(Value)
      AutoSquat = Value
      task.spawn(function()
          while AutoSquat do
              -- Evento o simulación para sentadillas
              pcall(function()
                  game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Train"):FireServer("Squat")
              end)
              task.wait(0.05)
          end
      end)
   end,
})

OtherTab:CreateToggle({
   Name = "Hide Pets",
   CurrentValue = false,
   Callback = function(Value)
      HidePets = Value
      -- Ocultar o mostrar modelos de mascotas en workspace
      for _, v in pairs(workspace:GetChildren()) do
          if v.Name:lower():find("pet") then
              v.Transparent = HidePets and 1 or 0
          end
      end
   end,
})

OtherTab:CreateToggle({
   Name = "Hide Popups",
   CurrentValue = false,
   Callback = function(Value)
      HidePopups = Value
      local gui = LocalPlayer:WaitForChild("PlayerGui")
      for _, v in pairs(gui:GetChildren()) do
          if v:IsA("ScreenGui") and v.Name:lower():find("popup") then
              v.Enabled = not HidePopups
          end
      end
   end,
})

OtherTab:CreateToggle({
   Name = "Anti Lag (for bad devices)",
   CurrentValue = false,
   Callback = function(Value)
      AntiLag = Value
      if AntiLag then
          game:GetService("Lighting").GlobalShadows = false
          for _, v in pairs(game:GetDescendants()) do
              if v:IsA("BasePart") then
                  v.Material = Enum.Material.SmoothPlastic
              end
          end
      end
   end,
})

OtherTab:CreateButton({
   Name = "Equip Rep Pets",
   Callback = function()
      pcall(function()
          game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EquipBestPets"):FireServer()
      end)
   end,
})

OtherTab:CreateToggle({
   Name = "Eat Eggs",
   CurrentValue = false,
   Callback = function(Value)
      AutoEatEggs = Value
   end,
})

OtherTab:CreateToggle({
   Name = "Spin Fortune Wheel",
   CurrentValue = false,
   Callback = function(Value)
      AutoSpinWheel = Value
   end,
})

----------------------------------------------------------------
-- TAB 4: INFO
----------------------------------------------------------------
local InfoTab = Window:CreateTab("Info", 4483362458)
InfoTab:CreateLabel("Script: XEO-Public")
InfoTab:CreateLabel("Developer: xXThe_PainsaacXx")
InfoTab:CreateLabel("Tip: For me, 20-40 works the best. Try around!")
