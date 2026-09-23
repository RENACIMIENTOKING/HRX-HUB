-- ========================================================
-- ANTI-KICK & BYPASS INTERNO
-- ========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Modificación de metamétodo para bloquear la expulsión (Kick)
pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if tostring(method):lower() == "kick" then
                return nil
            end
            return old(self, ...)
        end)
    end
end)

-- ========================================================
-- SISTEMA DE WHITELIST
-- ========================================================
local Whitelist = {
    ["ianjajajjajajapolo1"] = true,
    ["renacimientoking"] = true,
}

local playerUsername = string.lower(LocalPlayer.Name)

if not Whitelist[playerUsername] then
    warn("HRX PRIVADO: No estás en la Whitelist para usar este script.")
    return
end

-- ========================================================
-- LIBRERÍA DE INTERFAZ GRÁFICA (RAYFIELD UI)
-- ========================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "HRX PRIVADO | Fast Farming",
   LoadingTitle = "Cargando HRX Suite...",
   LoadingSubtitle = "by RENACIMIENTOKING",
   ConfigurationSaving = { Enabled = false }
})

-- Variables de Estado
local AutoLift = false
local AutoSquat = false
local FastRebirth = false
local HidePets = false
local HidePopups = false
local AntiLag = false

----------------------------------------------------------------
-- PESTAÑA 1: STRENGTH (MAIN)
----------------------------------------------------------------
local MainTab = Window:CreateTab("Strength (Main)", 4483362458)

MainTab:CreateLabel("Status: Activo")
MainTab:CreateLabel("Usuario: " .. LocalPlayer.Name)

----------------------------------------------------------------
-- PESTAÑA 2: REBIRTHS
----------------------------------------------------------------
local RebirthTab = Window:CreateTab("Rebirths", 4483362458)

RebirthTab:CreateToggle({
   Name = "Fast Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      FastRebirth = Value
      task.spawn(function()
          while FastRebirth do
              pcall(function()
                  local rebEvent = game:GetService("ReplicatedStorage"):FindFirstChild("rebirthEvent") or 
                                   game:GetService("ReplicatedStorage"):FindFirstChild("rEvents") and 
                                   game:GetService("ReplicatedStorage").rEvents:FindFirstChild("rebirthEvent")
                  if rebEvent then
                      rebEvent:FireServer("rebirthRequest")
                  end
              end)
              task.wait(0.5) -- Delay de seguridad para evitar Kicks
          end
      end)
   end,
})

----------------------------------------------------------------
-- PESTAÑA 3: OTHER
----------------------------------------------------------------
local OtherTab = Window:CreateTab("Other", 4483362458)

OtherTab:CreateToggle({
   Name = "Industrial Lift",
   CurrentValue = false,
   Callback = function(Value)
      AutoLift = Value
      task.spawn(function()
          while AutoLift do
              pcall(function()
                  local muscleEvent = game:GetService("ReplicatedStorage"):FindFirstChild("muscleEvent") or 
                                      game:GetService("ReplicatedStorage"):FindFirstChild("rEvents") and 
                                      game:GetService("ReplicatedStorage").rEvents:FindFirstChild("muscleEvent")
                  if muscleEvent then
                      muscleEvent:FireServer("punch", "RightHand")
                  end
              end)
              task.wait(0.15) -- Delay seguro
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
              pcall(function()
                  local muscleEvent = game:GetService("ReplicatedStorage"):FindFirstChild("muscleEvent") or 
                                      game:GetService("ReplicatedStorage"):FindFirstChild("rEvents") and 
                                      game:GetService("ReplicatedStorage").rEvents:FindFirstChild("muscleEvent")
                  if muscleEvent then
                      muscleEvent:FireServer("punch", "LeftHand")
                  end
              end)
              task.wait(0.15) -- Delay seguro
          end
      end)
   end,
})

OtherTab:CreateToggle({
   Name = "Hide Pets",
   CurrentValue = false,
   Callback = function(Value)
      HidePets = Value
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
          for _, v in pairs(game:GetDesc
