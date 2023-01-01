local plr = game:GetService("Players").LocalPlayer
local plrs = game:GetService("Players")

function click()
    game:GetService("ReplicatedStorage").Remotes.Click:InvokeServer()
end

function getBonuses()
    game:GetService("ReplicatedStorage").Remotes.Bonus:InvokeServer()
end

function chests()
    for i,v in next, workspace:GetChildren() do
        if string.match(v.Name, "Chest") then
            for i = 0,1 do
                firetouchinterest(plr.Character.HumanoidRootPart, v:FindFirstChild("hitPart"), i)
            end
        end
    end
end

local worlds = {}
local sworld

for i,v in next, game:GetService("Workspace").TeleportBricks:GetChildren() do
    if v.ClassName == "Part" then
        table.insert(worlds, v.Name)
    end
end

function teleportToWorld(world)
    plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").TeleportBricks:FindFirstChild(world).CFrame
end

function equipBest()
    local args = {
        [1] = {}
    }
    game:GetService("ReplicatedStorage").Remotes.equipBestItems:InvokeServer(unpack(args))    
end

local eggs = {}
local segg
local samount

for i,v in next, game:GetService("ReplicatedStorage").itemStorage:GetChildren() do
    if string.match(v.Name, "Egg") and v:IsA("Model") then
        table.insert(eggs, v.Name)
    end
end

function open(egg, amount)
    local args = {
        [1] = egg,
        [2] = amount
    }
    game:GetService("ReplicatedStorage").Remotes.buyEgg:InvokeServer(unpack(args))    
end

local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Soggyware V1.8",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local tab = win:Tab("Farming | Tab 1")

tab:Toggle("Click",false, function(t)
    getgenv().ClickToggle = t

    while ClickToggle do task.wait()
        if ClickToggle then
            click()
        else
            break
        end
    end
end)

tab:Toggle("Bonuses",false, function(t)
    getgenv().BonusesToggle = t

    while BonusesToggle do task.wait()
        if BonusesToggle then
            getBonuses()
        else
            break
        end
    end
end)

tab:Toggle("Rebirth",false, function(t)
    getgenv().RebirthToggle = t

    while RebirthToggle do task.wait(1)
        if RebirthToggle then
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
        else
            break
        end
    end
end)

local tab = win:Tab("Eggs | Tab 2")

tab:Toggle("Open Egg",false, function(t)
    getgenv().OpenEggToggle = t

    while OpenEggToggle do task.wait(1)
        if OpenEggToggle then
            open(segg, samount)
        else
            break
        end
    end
end)

tab:Slider("Egg Amount",1,3,1, function(t)
    samount = t
end)

tab:Dropdown("Select Egg",eggs, function(t)
    segg = t
end)

local tab = win:Tab("Misc | Tab 3")
local sequipDelay

tab:Toggle("Equip Best Pets",false, function(t)
    getgenv().EquipBestPetsToggle = t

    while EquipBestPetsToggle do task.wait(sequipDelay)
        if EquipBestPetsToggle then
            equipBest()
        else
            break
        end
    end
end)

local pickaxes = {}

for i,v in next, game:GetService("ReplicatedStorage").Pickaxes:GetChildren() do
    if v:IsA("Tool") then
        table.insert(pickaxes, v.Name)
    end
end

function buyPickaxes()
    for i = 1,#pickaxes do
        local args = {
            [1] = pickaxes[i]
        }
        game:GetService("ReplicatedStorage").Remotes.BuyPickaxe:InvokeServer(unpack(args))        
    end
end

function spamTrades()
    for i,v in next, plrs:GetPlayers() do
        if v.Name ~= plr.Name then
            local args = {
                [1] = v.Name
            }
            game:GetService("ReplicatedStorage").Remotes.GetTradeInfo:InvokeServer(unpack(args))            
        end
    end
end

tab:Toggle("Auto Buy Pickaxes",false, function(t)
    getgenv().BuyPickaxesToggle = t

    while BuyPickaxesToggle do task.wait(0.35)
        if BuyPickaxesToggle then
            equipBest()
        else
            break
        end
    end
end)

tab:Toggle("Spam Server Trades",false, function(t)
    getgenv().SpamServerTradesToggle = t

    while SpamServerTradesToggle do task.wait()
        if SpamServerTradesToggle then
            spamTrades()
        else
            break
        end
    end
end)

tab:Slider("Equip Best Pets Delay",1,100,5, function(t)
    sequipDelay = t
end)

tab:Dropdown("Teleport To World",worlds, function(t)
    teleportToWorld(t)
end)

local tab = win:Tab("Settings | Tab 4")

tab:Bind("Toggle UI",Enum.KeyCode.RightShift, function()
    if game:GetService("CoreGui"):FindFirstChild("ui").Enabled then
        game:GetService("CoreGui"):FindFirstChild("ui").Enabled = false
    else
        game:GetService("CoreGui"):FindFirstChild("ui").Enabled = true
    end
end)

tab:Colorpicker("Change UI Color",Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

tab:Label("~ Sunken")