local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Network = loadstring(game:HttpGet("https://soggy-ware.cf/Libs/Utility.lua"))().Network

local function GetEggs()
	local a = {}
	for i, v in next, game:GetService("Workspace").MapFunctions.Eggs:GetChildren() do
		table.insert(a, v.Name)
	end
	return a
end

local function Click()
	Network:Fire("ToolEvent", Player.ClientData.ToolEquipped.Value, Player)
end

local function GetBestSell()
	local dist, inst = math.huge, nil
    for i,v in next, game:GetService("Workspace").MapFunctions.Sell:GetChildren() do
        local mag = (Player.Character:GetPivot().Position - v.Position).Magnitude
        if mag < dist then
            dist = mag
            inst = v
        end
    end
    return inst
end

local function isFull()
    local a = Player.PlayerGui.MainGui.LeftUIFrame.BackpackFrame.Amount.Text:split("/")
    return a[1] == a[2]
end

local function GetChests()
    for i,v in next, game:GetService("Workspace").MapFunctions.Chests:GetDescendants() do
        if v.Name == "Hitbox" then
            for x = 0, 1 do
                firetouchinterest(Player.Character.PrimaryPart, v, x)
            end
        end
    end
end

local function Hatch()
    Network:Call("EggFunction", getgenv().egg, getgenv().amount, Player)
end

local function Sell()
    if isFull() == false then return end
    local sell = GetBestSell()
    Player.Character:PivotTo(sell:GetPivot())
    Network:Fire("SellEvent", sell.Name, Player)
end

local function BuyAll()
    Network:Fire("BuyAllTools", Player)
end

local function BuyAll2()
    Network:Fire("BuyAllBackpacks", Player)
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
	Name = "YoYo Simulator",
	LoadingTitle = "Soggyware",
	LoadingSubtitle = "EST. 2022",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Soggyware",
		FileName = "YoYo Simulator"
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
	Name = "Auto Click",
	CurrentValue = false,
	Flag = "Auto Click",
	Callback = function(x)
		getgenv()["Auto Click"] = x
		while getgenv()["Auto Click"] do
			task.wait(0.25)
			if getgenv()["Auto Click"] == false then
				return
			end
            pcall(function()
                Player.Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild(Player.ClientData.ToolEquipped.Value))
                Click()
            end)
		end
	end
})

Tab:CreateToggle({
	Name = "Auto Sell",
	CurrentValue = false,
	Flag = "Auto Sell",
	Callback = function(x)
		getgenv()["Auto Sell"] = x
		while getgenv()["Auto Sell"] do
			task.wait()
			if getgenv()["Auto Sell"] == false then
				return
			end
			pcall(Sell)
		end
	end
})

local Tab = Window:CreateTab("Pet Tab", 11600742450)

local Section = Tab:CreateSection("Eggs")

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
        getgenv().amount = (x == true and "TripleEgg" or x == false and "SingleEgg")
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

local Tab = Window:CreateTab("Misc Tab", 11600761450)

Tab:CreateSection("Chests")

Tab:CreateToggle({
	Name = "Auto Chests",
	CurrentValue = false,
	Flag = "Auto Chests",
	Callback = function(x)
		getgenv()["Auto Chests"] = x
        while getgenv()["Auto Chests"] do
            task.wait()
            if getgenv()["Auto Chests"] == false then return end
            pcall(GetChests)
        end
    end
})

Tab:CreateSection("Shop")

Tab:CreateToggle({
	Name = "Auto Buy Tools",
	CurrentValue = false,
	Flag = "Auto Buy Tools",
	Callback = function(x)
		getgenv()["Auto Buy Tools"] = x
        while getgenv()["Auto Buy Tools"] do
            task.wait()
            if getgenv()["Auto Buy Tools"] == false then return end
            pcall(BuyAll)
        end
    end
})

Tab:CreateToggle({
	Name = "Auto Buy Backpacks",
	CurrentValue = false,
	Flag = "Auto Buy Backpacks",
	Callback = function(x)
		getgenv()["Auto Buy Backpacks"] = x
        while getgenv()["Auto Buy Backpacks"] do
            task.wait()
            if getgenv()["Auto Buy Backpacks"] == false then return end
            pcall(BuyAll2)
        end
    end
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)