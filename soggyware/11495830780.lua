local Players = game:GetService("Players")
local Network = loadstring(game:HttpGet("https://soggy-ware.cf/Libs/Utility.lua"))().Network
local Player = Players.LocalPlayer
local ID = Player.UserId

local function Dunk()
    Network:Fire("DunkRequest")
end

local function GetEggs()
    local a = {}
    for i,v in next, game:GetService("ReplicatedStorage").Enums.PetsData.EggsImages:GetChildren() do
        table.insert(a, v.Name)
    end
    return a
end

local function Hatch()
    Network:Call(getgenv().amount, tonumber(getgenv().egg), {})
end

local function BringShoes()
    for i,v in next, game:GetService("Workspace")["C_PartsStorage"]:GetChildren() do task.wait(0.1)
        if v:IsA("BasePart") then
            Player.Character:PivotTo(v:GetPivot() + Vector3.new(0,5,0))
            task.wait(0.1)
            Network:Fire("CollectRequest")
            task.wait(0.1)
            v:Destroy()
            break
        end
    end
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Dunking Race",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Dunking Race"
    },
    Discord = {
        Enabled = true,
        Invite = "bBZxdAhS9J",
        RememberJoins = true
    }
})
local Tab = Window:CreateTab("Home Tab", 11600721595)

Tab:CreateSection("Information")
Tab:CreateLabel("Release")

local Tab = Window:CreateTab("Farming Tab", 11696994871)

Tab:CreateSection("Farming")

Tab:CreateToggle({
	Name = "Auto Dunk",
	CurrentValue = false,
	Flag = "Auto Dunk",
	Callback = function(x)
		getgenv()["Auto Dunk"] = x
        while getgenv()["Auto Dunk"] do
            if getgenv()["Auto Dunk"] == false then
                return
            end
            task.wait()
            Dunk()
        end
	end
})

Tab:CreateToggle({
	Name = "Auto Collect Shoes",
	CurrentValue = false,
	Flag = "Auto Collect Shoes",
	Callback = function(x)
		getgenv()["Auto Collect Shoes"] = x
        while getgenv()["Auto Collect Shoes"] do
            if getgenv()["Auto Collect Shoes"] == false then
                return
            end
            BringShoes()
            task.wait(3)
        end
	end
})

local Tab = Window:CreateTab("Pet Tab", 11600742450)

Tab:CreateSection("Eggs")

Tab:CreateToggle({
	Name = "Auto Hatch",
	CurrentValue = false,
	Flag = "Auto Hatch",
	Callback = function(x)
		getgenv()["Auto Hatch"] = x
        while getgenv()["Auto Hatch"] do
            if getgenv()["Auto Hatch"] == false then
                return
            end
            task.wait()
            pcall(Hatch)
        end
	end
})

Tab:CreateToggle({
	Name = "Triple Hatch",
	CurrentValue = false,
	Flag = "Triple Hatch",
	Callback = function(x)
        getgenv().amount = (x == true and "BuyTripleEgg" or x == false and "BuyEgg")
	end
})

Tab:CreateDropdown({
	Name = "Select Egg",
	Options = GetEggs(),
	CurrentOption = GetEggs()[1],
	Flag = "Select Egg",
	Callback = function(x)
		getgenv().egg = x
	end,
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)