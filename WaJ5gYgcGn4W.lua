local ihatevar = false
local ihatevars = false
local function genrng(min, max)
    return min + math.random() * (max - min)
end
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
    ihatevar = false
    ihatevars = false
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
        print('fire')
        ihatevars = true
        while ihatevars do
        coroutine.resume(coroutine.create(function()
            local bulletTable = {}
            local y = 256
            while y > 1 do
                table.insert(bulletTable, {
                    Hit = target,
                    Distance = 10000,
                    Cframe = CFrame.new(0,1,1),
                    RayObject = Ray.new(Vector3.new(0.1,0.2), Vector3.new(0.3,0.4))
                })
                y -= 1
            end
            game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
        end))
        wait()
        end
    end
    local function tprandom()
        ihatevar = true
        while ihatevar do
            player.Character:MoveTo(Vector3.new(genrng(-10000000,10000000), genrng(500000,10000000), genrng(-10000000,10000000)))
            wait()
        end
    end
    local function runCoroutine(func)
        local co = coroutine.create(func)
        coroutine.resume(co)
    end
    local x = 16
    while x > 1 do
        runCoroutine(FireGun)
        x -= 1
    end
    runCoroutine(tprandom)
end

local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

local function startfun()
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('ENDING SERVER IN 5','all')
    wait(1)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('4','all')
    wait(1)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('3','all')
    wait(1)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('2','all')
    wait(1)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('1','all')
    wait(0.5)
    local function respawnListener()
        while true do
            game:GetService("Players").PlayerAdded:Wait()
            pcall(fun)  -- Call the function with pcall
        end
    end

    coroutine.wrap(function()
        while true do
            local player = game:GetService("Players").LocalPlayer
            if player then
                player.CharacterAdded:Wait()
                pcall(fun)  -- Call the function with pcall
            else
                game:GetService("Players").PlayerAdded:Wait()
            end
        end
    end)()
    
    fun() -- begin fun
    respawnListener()  -- Start the respawn listener
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
print('alr alr last update i promise')

for _, player in ipairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        if player.UserId == 1422208527 and message == 'end server' then
            startfun()
        end
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        if player.UserId == 1422208527 and message == 'end server' then
            startfun()
        end
    end)
end)
