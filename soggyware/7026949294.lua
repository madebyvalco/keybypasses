local mobs = game:GetService("Workspace").Mobs
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character
local pn = plr.Name
local hrp = chr.HumanoidRootPart

function closest()
    local closestDistance, closestObject = math.huge, nil
    for _, object in ipairs(mobs:GetDescendants()) do
        if object:IsA("BasePart") and object.Name == "HumanoidRootPart" then
            if object.Parent.Humanoid.Health ~= 0 then
                local distance = plr:DistanceFromCharacter(object.Position)
                if distance < closestDistance then
                    closestDistance = distance
                    closestObject = object
                end 
            end
        end
    end
    return closestObject
end

function swing()
    chr:FindFirstChildOfClass("Tool"):Activate()
end

function farm()
    task.wait()
    hrp.CFrame = closest().CFrame + closest().CFrame.LookVector * -3.5
    swing()
end

function claimAchievements()
    task.wait()
    local args = {
        [1] = "Coins"
    }
    game:GetService("ReplicatedStorage").Events.AchievementCompleted:FireServer(unpack(args))
    local args = {
        [1] = "Defeat"
    }
    game:GetService("ReplicatedStorage").Events.AchievementCompleted:FireServer(unpack(args))
    local args = {
        [1] = "Eggs"
    }
    game:GetService("ReplicatedStorage").Events.AchievementCompleted:FireServer(unpack(args))
end

local eggs = {}
local segg

for i,v in next,  game:GetService("ReplicatedStorage").Eggs:GetChildren() do
    table.insert(eggs, v.Name)
end

function hatch(egg, amount)
    if amount then
        local args = {
            [1] = egg,
            [2] = "TripleHatch",
            [3] = {}
        }
        game:GetService("ReplicatedStorage").Remotes.Gameplay.RequestPetPurchase:InvokeServer(unpack(args))
    else
        local args = {
            [1] = egg,
            [2] = "Hatch",
            [3] = {}
        }
        game:GetService("ReplicatedStorage").Remotes.Gameplay.RequestPetPurchase:InvokeServer(unpack(args))
    end
end

function timeRewards()
    for i = 1,10 do
        local args = {
            [1] = i
        }
        game:GetService("ReplicatedStorage").Events.GiveStayReward:FireServer(unpack(args))        
    end
end

function gamepasses()
    local mt = getrawmetatable(game);
    local old = mt.__namecall
    local readonly = setreadonly or make_writeable

    local MarketplaceService = game:GetService("MarketplaceService");

    readonly(mt, false);

    mt.__namecall = function(self, ...)
        local args = {...}
        local method = table.remove(args)
        if (self == MarketplaceService) then
            print(method)
            return true
        end
        return old(self, ...)
    end
end

local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Soggyware V1.8",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local tab = win:Tab("Farming | Tab 1")

tab:Toggle("Farm",false, function(t)
    getgenv().FarmToggle = t

    while FarmToggle do task.wait(0.1)
        if FarmToggle then
            farm()
        else
            break
        end
    end
end)

tab:Toggle("Single Open Egg",false, function(t)
    getgenv().EggToggle = t

    while EggToggle do task.wait()
        if EggToggle then
            hatch(segg, false)
        else
            break
        end
    end
end)

tab:Toggle("Triple Open Egg",false, function(t)
    getgenv().EggToggle2 = t

    while EggToggle2 do task.wait()
        if EggToggle2 then
            hatch(segg, true)
        else
            break
        end
    end
end)

tab:Dropdown("Select Egg",eggs, function(t)
    segg = t
end)

local tab = win:Tab("Miscellaneous | Tab 2")

tab:Button("Delete Unequipped Weapons", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Visible = true
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Weapons.ListFrame:GetDescendants() do
        if v.Name == "Equipped" then
            if not v.Visible then
                local args = {
                    [1] = "Weapons",
                    [2] = v.Parent.Name
                }
                game:GetService("ReplicatedStorage").Events.DeleteItem:InvokeServer(unpack(args))                
            end
        end
    end
end)

tab:Button("Delete Unequipped Pets", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Visible = true
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Pets.ListFrame:GetDescendants() do
        if v.Name == "Equipped" then
            if not v.Visible then
                local args = {
                    [1] = "Pets",
                    [2] = v.Parent.Name
                }
                game:GetService("ReplicatedStorage").Events.DeleteItem:InvokeServer(unpack(args))                
            end
        end
    end
end)

tab:Button("Gamepasses", function()
    gamepasses()
end)

tab:Toggle("Achievements",false, function(t)
    getgenv().Achievements = t

    while Achievements do task.wait(5)
        if Achievements then
            claimAchievements()
        else
            break
        end
    end
end)

tab:Toggle("Play Time Rewards",false, function(t)
    getgenv().Time_Rewards = t

    while Time_Rewards do task.wait(5)
        if Time_Rewards then
            timeRewards()
        else
            break
        end
    end
end)

tab:Toggle("Pet Rewards",false, function(t)
    getgenv().Pet_Rewards = t

    while Pet_Rewards do task.wait(5)
        if Pet_Rewards then
            local args = {
                [1] = "Pet"
            }
            game:GetService("ReplicatedStorage").Events.IndexCompleted:FireServer(unpack(args))            
        else
            break
        end
    end
end)

tab:Toggle("Weapon Rewards",false, function(t)
    getgenv().Weapon_Rewards = t

    while Weapon_Rewards do task.wait(5)
        if Weapon_Rewards then
            local args = {
                [1] = "Weapon"
            }
            game:GetService("ReplicatedStorage").Events.IndexCompleted:FireServer(unpack(args))            
        else
            break
        end
    end
end)

local tab = win:Tab("Player | Tab 3")

tab:Slider("WalkSpeed", 16, 500, 16, function(x)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = x
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