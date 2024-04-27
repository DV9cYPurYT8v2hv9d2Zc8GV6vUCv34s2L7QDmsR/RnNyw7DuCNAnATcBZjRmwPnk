local function unfun()
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack
    for _, item in pairs(backpack:GetChildren()) do
        if item.Name == "Remington 870" then
            print('okay theres a gun')
            return false
        end
    end
    return true
end
local function dothat()
    local player = game.Players.LocalPlayer
    local remington870Part = workspace.Prison_ITEMS.giver["Remington 870"]
    
    if remington870Part then
        local positionReferencePart = nil
        for _, part in ipairs(remington870Part:GetChildren()) do
            if part:IsA("BasePart") then
                positionReferencePart = part
                break
            end
        end
    
        if positionReferencePart then
            local partPosition = positionReferencePart.Position
            player.Character:MoveTo(partPosition)
        else
            warn("No suitable part found in the Remington 870 model.")
        end
    else
        warn("Remington 870 part not found!")
    end
    local args = {
        [1] = workspace.Prison_ITEMS.giver:FindFirstChild("Remington 870").ITEMPICKUP
    }
    workspace.Remote.ItemHandler:InvokeServer(unpack(args))
end
local function fun()
    print('wtf player died or new game')
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    while unfun() do
        dothat()
        wait()
    end
    
    player.Character:MoveTo(Vector3.new(645456.7, 10000000.5, -32334.7))
    wait()
    player.Character:WaitForChild("Humanoid").RootPart.Anchored = true
    
    local Gun = "Remington 870"
    local Player = game.Players.LocalPlayer.Name
    
    game.Workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver[Gun].ITEMPICKUP)
    
    for i,v in pairs(game.Players[Player].Backpack:GetChildren()) do
        if v.name == (Gun) then
            v.Parent = game.Players.LocalPlayer.Character
        end
    end
    
    Gun = game.Players[Player].Character[Gun]
    
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
    
    local function FireGun(target)
        while true do
        coroutine.resume(coroutine.create(function()
            local bulletTable = {}
            table.insert(bulletTable, {
                Hit = target,
                Distance = 10000,
                Cframe = CFrame.new(0,1,1),
                RayObject = Ray.new(Vector3.new(0.1,0.2), Vector3.new(0.3,0.4))
            })
            game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
        end))
        wait()
        end
    end
    
    local function runCoroutine(func)
        local co = coroutine.create(func)
        coroutine.resume(co)
    end
    
    runCoroutine(FireGun)
    runCoroutine(FireGun)
end

local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

local function startfun()
    fun()
    local function respawnListener()
        while true do
            game:GetService("Players").PlayerAdded:Wait()
            fun()
        end
    end

    coroutine.wrap(function()
        while true do
            humanoid.Died:Wait()
            coroutine.wrap(respawnListener)()
            fun()
        end
    end)()
end

local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = gui
local button = Instance.new("TextButton")
button.Parent = screenGui
button.Position = UDim2.new(0.05, 0, 0.9, 0)
button.Size = UDim2.new(0, 100, 0, 50)
button.Text = "Nuke server"
button.TextSize = 10
button.MouseButton1Click:Connect(startfun)
print('the coroutines update')
