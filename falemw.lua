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

local CactusTab = Window:CreateTab("Cactus Hitbox", 4483362458)

-- Variables Cactus
local cactusHitboxSize = 5
local cactusConnection = nil

local function ExpandCactusHitbox(size)
    if cactusConnection then cactusConnection:Disconnect() end
    cactusConnection = game:GetService("RunService").Heartbeat:Connect(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("cactus") or (obj.TextureID and obj.TextureID:find("cactus"))) then
                if obj.Size.Magnitude < 50 then
                    obj.Size = Vector3.new(size, size, size)
                end
            end
        end
    end)
end

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

CactusTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 20},
    Increment = 0.5,
    CurrentValue = 5,
    Flag = "CactusSize",
    Callback = function(Value)
        cactusHitboxSize = Value
        if cactusConnection then
            ExpandCactusHitbox(Value)
        end
    end,
})

-- ==================== AUTO JUMP ====================

local JumpTab = Window:CreateTab("Auto Jump", 4483362458)

local autoJumpEnabled = false
local jumpIntensity = 10

JumpTab:CreateToggle({
    Name = "Auto Jump (Presiona Espacio)",
    CurrentValue = false,
    Flag = "AutoJumpToggle",
    Callback = function(Value)
        autoJumpEnabled = Value
        Rayfield:Notify("Auto Jump", Value and "Activado ✓" or "Desactivado ✕", 3)
    end,
})

JumpTab:CreateSlider({
    Name = "Jump Intensity (3-20)",
    Range = {3, 20},
    Increment = 1,
    CurrentValue = 10,
    Flag = "JumpIntensity",
    Callback = function(Value)
        jumpIntensity = Value
    end,
})

-- Lógica del Auto Jump
local UserInputService = game:GetService("UserInputService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Space and autoJumpEnabled then
        if humanoid:GetState() \~= Enum.HumanoidStateType.Jumping and humanoid:GetState() \~= Enum.HumanoidStateType.Freefall then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local power = jumpIntensity * 5
                root.Velocity = Vector3.new(root.Velocity.X, power, root.Velocity.Z)
            end
        end
    end
end)

Rayfield:Notify("Script Cargado", "Cactus Hitbox + Auto Jump listo\nUsa la pestaña Auto Jump", 5)
