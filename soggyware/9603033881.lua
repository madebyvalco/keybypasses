local warehouseNames = {
    "Da Hood",
    "Warehouse",
    "The Store",
    "Moda",
    "Cabin",
    "Tropical Island",
    "Beverley Hills",
    "King Henry's Pad",
    "Steampunk",
    "Mansion House",
    "Greek Temple",
    "Space Base"
}

local valueList = {
    ["Da Hood"] = {
        MinimumValue = 1,
        MaxValue = 26
    },
    ["Warehouse"] = {
        MinimumValue = 7,
        MaxValue = 50
    },
    ["The Store"] = {
        MinimumValue = 16,
        MaxValue = 185
    },
    ["Moda"] = {
        MinimumValue = 50,
        MaxValue = 500
    },
    ["Cabin"] = {
        MinimumValue = 125,
        MaxValue = 1000
    },
    ["Tropical Island"] = {
        MinimumValue = 220,
        MaxValue = 2500
    },
    ["Beverley Hills"] = {
        MinimumValue = 350,
        MaxValue = 5500
    },
    ["King Henry's Pad"] = {
        MinimumValue = 450,
        MaxValue = 10000
    },
    ["Steampunk"] = {
        MinimumValue = 550,
        MaxValue = 15000
    },
    ["Mansion House"] = {
        MinimumValue = 200,
        MaxValue = 1000
    },
    ["Greek Temple"] = {
        MinimumValue = 900,
        MaxValue = 20000
    },
    ["Space Base"] = {
        MinimumValue = 999999999999,
        MaxValue = 999999999999
    }
}

local sauction = "Da Hood"

function returnAmountOfObjectsInsideAuctionHouse(aaa)
    if game:GetService("Workspace").Debris.Auctions:FindFirstChild(tostring(aaa)) then
        return #game:GetService("Workspace").Debris.Auctions:FindFirstChild(tostring(aaa)).Items:GetChildren()
    else
        return 0
    end
end

function returnAuctionHouseAverageValue(a)
    returningValue1 = math.floor(valueList[sauction].MaxValue + valueList[sauction].MinimumValue)
    returningValue2 = math.floor(returningValue1 / 2)
    returningValue3 = math.floor(returningValue2 * returnAmountOfObjectsInsideAuctionHouse(a))
    if returningValue3 ~= nil then
        return (sauction .. " Room " .. a .. " | Estimated / Average Value: " .. returningValue3)
    elseif returningValue3 == nil then
        return
    end
end

local title = "Soggyware | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()

OrionLib:MakeNotification(
    {
        Name = "Soggyware",
        Content = "Welcome " .. game.Players.LocalPlayer.Name .. " the hub is loading now!",
        Image = "rbxassetid://7072718307",
        Time = 4
    }
)

local Window = OrionLib:MakeWindow({Name = title, HidePremium = false, SaveConfig = true, ConfigFolder = "Soggyware"})

local Tab =
    Window:MakeTab(
    {
        Name = "Main",
        Icon = "rbxassetid://7072717697",
        PremiumOnly = false
    }
)

Tab:AddDropdown(
    {
        Name = "Select Auction House",
        Default = "Da Hood",
        Save = true,
        Color = Color3.fromRGB(0, 105, 255),
        Flag = "Upgrade Option",
        Options = warehouseNames,
        Callback = function(x)
            sauction = x
        end
    }
)

local label1 = Tab:AddLabel("Waiting For Auction Houses")
local label2 = Tab:AddLabel("Waiting For Auction Houses")
local label3 = Tab:AddLabel("Waiting For Auction Houses")

task.spawn(
    function()
        while wait() do
            label1:Set(returnAuctionHouseAverageValue(1))
            label2:Set(returnAuctionHouseAverageValue(2))
            label3:Set(returnAuctionHouseAverageValue(3))
        end
    end
)

Tab:AddButton(
    {
        Name = "Gamepasses",
        Callback = function()
            for i, v in next, game:GetService("Players").LocalPlayer.Gamepasses:GetChildren() do
                if v.Value == false then
                    v.Value = true
                end
            end
        end
    }
)