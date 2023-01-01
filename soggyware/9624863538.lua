function click()
    game:GetService("ReplicatedStorage").RemoteEvents.Tap:FireServer()
end

function gifts()
    for i = 1,9 do
        local args = {
            [1] = tostring(i)
        }

        game:GetService("ReplicatedStorage").RemoteFunctions.ClaimReward:InvokeServer(unpack(args))
    end
end

function spin()
game:GetService("ReplicatedStorage").RemoteFunctions.SpinTheWheel:InvokeServer()
end

function boosts()
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerData.Boosts:GetChildren() do
        v.Value += 9999999999
    end
end

function chests()
    for i,v in next, game:GetService("Workspace").Main.POI.Chests:GetDescendants() do
        if v.Name == "TouchInterest" and v.Parent then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
        end
    end
end

function returnInvAmount()
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.UI.Main.Frames.Pets.PetsFrameNew.Top.Holder.Inventory.Holder:GetChildren() do
        if v.ClassName == "Frame" then
            return #game:GetService("Players").LocalPlayer.PlayerGui.UI.Main.Frames.Pets.PetsFrameNew.Top.Holder.Inventory.Holder:GetChildren()
        end
    end
end

local eggs = {}

for im,v in next, game:GetService("Workspace").Eggs:GetChildren() do
    table.insert(eggs, v.Name)
end

spawn(function()
    while true do wait(0.1)
        game:GetService("Players").LocalPlayer.PlayerGui.UI.Main.Frames.Pets.PetsFrameNew.Top.Holder.Stats.PetEquip.Label.Text = tostring(returnInvAmount() .. " / 700")
    end
end)

function hatch(egg, amount)
    local args = {
        [1] = egg,
        [2] = "openEgg",
        [3] = amount
    }

    game:GetService("ReplicatedStorage").Assets.Remotes.Functions.EggOpened:InvokeServer(unpack(args))
end

local rebirths = {}

for i,v in next, require(game:GetService("ReplicatedStorage").Shared.Utilities.RebirthUtil).List do
    if v.Desc then
        table.insert(rebirths, v.Desc)
    end
end

function rebirth(amt)
    local args = {
        [1] = amt
    }

    game:GetService("ReplicatedStorage").RemoteFunctions.Rebirth:InvokeServer(unpack(args))
end

function visualDupe()
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.UI.Main.Frames.Pets.PetsFrameNew.Top.Holder.Inventory.Holder:GetChildren() do
        if v.ClassName == "Frame" then
            a = v:Clone()
            a.Parent = v.Parent
        end
    end
end

function gamepass()
    require(game:GetService("ReplicatedStorage").Shared.Modules.Gamepass).PromptProduct = function() return true end
    require(game:GetService("ReplicatedStorage").Shared.Modules.Gamepass).CheckPass = function() return true end
end

function infinitePetStats()
    require(game:GetService("ReplicatedStorage").Shared.Modules.Functions).getEquippedMultiplier = function() return math.huge end
    require(game:GetService("ReplicatedStorage").Shared.Modules.Functions).getPetMultiplier = function() return math.huge end
end

function unlockAllGifts()
    require(game:GetService("ReplicatedStorage").Shared.Utilities.RewardsUtil).List = {

        ["1"] = 1,
        ["2"] = 1,
        ["3"] = 1,
        ["4"] = 1,
        ["5"] = 1,
        ["6"] = 1,
        ["7"] = 1,
        ["8"] = 1,
        ["9"] = 1,

    }
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

local a = Tab:CreateSection("Main")

a:CreateToggle(
    "Click",
    nil,
    function(x)
        getgenv().Click = x

        while Click do wait()
            click()
        end
    end
)

local selectedEgg

a:CreateToggle(
    "Single Egg",
    nil,
    function(x)
        getgenv().Single_Egg = x

        while Single_Egg do wait()
            hatch(selectedEgg, 1)
        end
    end
)

a:CreateToggle(
    "Triple Egg",
    nil,
    function(x)
        getgenv().Triple_Egg = x

        while Triple_Egg do wait()
            hatch(selectedEgg, 3)
        end
    end
)

a:CreateToggle(
    "Collect Gifts",
    nil,
    function(x)
        getgenv().Collect_Gifts = x

        while Collect_Gifts do wait()
            gifts()
        end
    end
)

local selectedrebirth

a:CreateToggle(
    "Rebirth",
    nil,
    function(x)
        getgenv().Rebirth = x

        while Rebirth do wait()
            rebirth(selectedrebirth)
        end
    end
)

a:CreateToggle(
    "Spin Wheel",
    nil,
    function(x)
        getgenv().Spin_Wheel = x

        while Spin_Wheel do wait()
            spin()
        end
    end
)

a:CreateToggle(
    "Boosts",
    nil,
    function(x)
        getgenv().Boosts = x

        while Boosts do wait()
            boosts()
        end
    end
)

a:CreateToggle(
    "Collect Chests",
    nil,
    function(x)
        getgenv().Collect_Chests = x

        while Collect_Chests do wait()
            chests()
        end
    end
)

local a = Tab:CreateSection("Settings")

a:CreateDropdown(
    "Select Egg",
    eggs,
    function(x)
        selectedEgg = x
    end
)

a:CreateDropdown(
    "Select Rebirth",
    rebirths,
    function(x)
        selectedrebirth = x
    end
)

a:CreateButton("Gamepasses", function()
    gamepass()
end)

a:CreateButton("V | Dupe Pets", function()
    visualDupe()
end)

a:CreateButton("V | Infinite Pet Stats", function()
    infinitePetStats()
end)

a:CreateButton("Remove Gift Timing", function()
    unlockAllGifts()
end)