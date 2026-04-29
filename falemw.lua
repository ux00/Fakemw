-- =============================================
-- EVADE - AUTO JUMP / BHOP con Rayfield
-- by snmsmnz
-- =============================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Evade | Auto Jump",
    LoadingTitle = "Evade Script",
    LoadingSubtitle = "by snmsmnz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "EvadeScripts",
        FileName = "AutoJumpConfig"
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Variables
local autoJumpEnabled = false
local jumpIntensity = 12

-- ==================== AUTO JUMP SECTION ====================

MainTab:CreateToggle({
    Name = "Auto Jump / Bhop",
    CurrentValue = false,
    Flag = "AutoJumpToggle",
    Callback = function(Value)
        autoJumpEnabled = Value
        Rayfield:Notify("Auto Jump", Value and "Activado ✅" or "Desactivado ❌", 3)
    end,
})

MainTab:CreateSlider({
    Name = "Jump Intensity (Bhob Height)",
    Range = {3, 25},
    Increment = 1,
    CurrentValue = 12,
    Flag = "JumpIntensity",
    Callback = function(Value)
        jumpIntensity = Value
    end,
})

-- ==================== LÓGICA DEL AUTO JUMP ====================

local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

local function doJump()
    if not autoJumpEnabled then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        -- Solo salta si no está en el aire
        if humanoid:GetState() \~= Enum.HumanoidStateType.Jumping 
           and humanoid:GetState() \~= Enum.HumanoidStateType.Freefall then
            
            local power = jumpIntensity * 5.2   -- Multiplicador optimizado para Evade
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, power, rootPart.Velocity.Z)
        end
    end
end

-- Detectar cuando se presiona Espacio
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space then
        doJump()
    end
end)

-- Notificación final
Rayfield:Notify("Script Cargado", "Auto Jump listo\nUsa el toggle y el slider", 5)

print("Evade Auto Jump Script cargado correctamente")
