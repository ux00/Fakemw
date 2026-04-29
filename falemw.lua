-- =============================================
-- EVADE - AUTO JUMP / BHOP
-- by snmsmnz
-- =============================================

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
    Name = "Evade - Auto Jump",
    LoadingTitle = "Evade Script",
    LoadingSubtitle = "by snmsmnz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "EvadeAutoJump",
        FileName = "Config"
    }
})

local Tab = Window:CreateTab("Auto Jump", 4483362458)

-- Variables
local autoJumpEnabled = false
local jumpIntensity = 12

-- Toggle
Tab:CreateToggle({
    Name = "Auto Jump (Presiona Espacio)",
    CurrentValue = false,
    Flag = "AutoJump",
    Callback = function(Value)
        autoJumpEnabled = Value
        Rayfield:Notify("Auto Jump", Value and "✅ Activado" or "❌ Desactivado", 3)
    end,
})

-- Slider (como en tu imagen)
Tab:CreateSlider({
    Name = "Jump Intensity / Bhop Height",
    Range = {3, 25},
    Increment = 1,
    CurrentValue = 12,
    Flag = "Intensity",
    Callback = function(Value)
        jumpIntensity = Value
    end,
})

-- Lógica del Auto Jump
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Space and autoJumpEnabled then
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            if humanoid:GetState() \~= Enum.HumanoidStateType.Jumping 
               and humanoid:GetState() \~= Enum.HumanoidStateType.Freefall then
                
                local power = jumpIntensity * 5.5
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, power, rootPart.Velocity.Z)
            end
        end
    end
end)

-- Notificación final
Rayfield:Notify("Script Cargado", "Auto Jump listo\nActiva el toggle y ajusta la intensidad", 6)

print("✅ Evade Auto Jump Script cargado correctamente")
