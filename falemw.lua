local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Evade - Desert Bus Script",
    LoadingTitle = "Evade Script",
    LoadingSubtitle = "by snmsmnz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "EvadeDesertBus",
        FileName = "CactusConfig"
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local CactusTab = Window:CreateTab("Cactus Hitbox", 4483362458)

-- Variables
local cactusHitboxSize = 5
local cactusConnection = nil

-- Función principal para aumentar hitbox de cactus
local function ExpandCactusHitbox(size)
    if cactusConnection then cactusConnection:Disconnect() end
    
    cactusConnection = game:GetService("RunService").Heartbeat:Connect(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("cactus") or obj.TextureID and obj.TextureID:find("cactus")) then
                if obj.Size.Magnitude < 50 then  -- filtro para no tocar todo el mapa
                    obj.Size = Vector3.new(size, size, size)
                    -- obj.Transparency = 0.7  -- opcional: hacerlos semi-transparentes
                end
            end
        end
    end)
end

-- Toggle para activar/desactivar
CactusTab:CreateToggle({
    Name = "Expand Cactus Hitbox",
    CurrentValue = false,
    Flag = "CactusHitbox",
    Callback = function(Value)
        if Value then
            ExpandCactusHitbox(cactusHitboxSize)
            Rayfield:Notify("Cactus Hitbox", "Activado - Tamaño: " .. cactusHitboxSize, 3)
        else
            if cactusConnection then 
                cactusConnection:Disconnect() 
                cactusConnection = nil 
            end
            Rayfield:Notify("Cactus Hitbox", "Desactivado", 3)
        end
    end,
})

-- Slider para cambiar el tamaño del hitbox
CactusTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 20},
    Increment = 0.5,
    CurrentValue = 5,
    Flag = "CactusSize",
    Callback = function(Value)
        cactusHitboxSize = Value
        -- Si está activado, actualiza en tiempo real
        if cactusConnection then
            ExpandCactusHitbox(Value)
        end
    end,
})

Rayfield:Notify("Script Cargado", "Desert Bus Cactus Hitbox listo", 5)
