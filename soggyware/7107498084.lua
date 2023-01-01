function punch()
    require(game:GetService("Players").LocalPlayer.PlayerScripts.HandlerGet.Combat).RequestCombat()
end

function fastHatch()
    require(game:GetService("Players").LocalPlayer.PlayerScripts.HandlerGet.Hatch).IsInHatch = false
end

function giveCoins()
    syn.set_thread_identity(2)
    local _fake = {}
    table.insert(_fake, game:GetService("HttpService"):GenerateGUID(false))
    table.insert(_fake, game:GetService("HttpService"):GenerateGUID(false))
    table.insert(_fake, game:GetService("HttpService"):GenerateGUID(false))
    table.insert(_fake, game:GetService("HttpService"):GenerateGUID(false))
    require(game:GetService("Players").LocalPlayer.PlayerScripts.HandlerGet.Collectibles.Get.Currency).Create(_fake, 6942006024, "Yen",  game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
    syn.set_thread_identity(7)
end

function removeShake()
    require(game:GetService("ReplicatedStorage").UtilitiesGet.CameraShake).Shake = function() return wait(9e9) end
    require(game:GetService("ReplicatedStorage").UtilitiesGet.CameraShake).Update = function() return wait(9e9) end
    require(game:GetService("ReplicatedStorage").UtilitiesGet.CameraShake).Start = function() return wait(9e9) end
end

function closest()
    local closestDistance, closestObject = math.huge, nil
    for _, v in ipairs(game:GetService("Workspace").Enemies:GetDescendants()) do
        if v.Name == "HumanoidRootPart" then
            local distance = game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Position)
            if distance < closestDistance then
                closestDistance = distance
                closestObject = v.Parent
            end
        end
    end
    return closestObject
end

function attack()
    for i = 1,5 do
        local v = closest()
        require(game:GetService("Players").LocalPlayer.PlayerScripts.HandlerGet.Combat).HandleCombatHit(v.Humanoid, 5) 
    end
end

function collect()
    game:GetService("Workspace").Collectibles.ChildAdded:Connect(function(v)
        require(game:GetService("Players").LocalPlayer.PlayerScripts.HandlerGet.Collectibles.Get.Currency).Remove(v.Name)
    end)
end

local title = "Soggyware | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local Config = {
    WindowName = title,
    Color = Color3.fromRGB(3, 127, 252),
    Keybind = Enum.KeyCode.F
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab = Window:CreateTab("Main")

local Section = Tab:CreateSection("Stuff")

Section:CreateToggle(
    "Kill All",
    nil,
    function(x)
        getgenv().kill = x  

        while kill do wait(0.1)
            attack()
        end
    end
)

Section:CreateToggle(
    "Collect Drops",
    nil,
    function(x)
        getgenv().collectt = x  

        while collectt do wait()
            collect()
        end
    end
)

Section:CreateButton("Give Coins | Visual", function()
    giveCoins()
end)

Section:CreateButton("Fast Hatch | Breaks UI", function()
    spawn(function()
        while true do
            fastHatch() wait()     
        end
    end)
end)

Section:CreateButton("Remove Screen Shake", function()
    removeShake()
end)