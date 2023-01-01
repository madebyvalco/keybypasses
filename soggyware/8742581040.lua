local Options = {
    SelectedOre = "Copper"
}
local info = {}
local funcs = {}
local Players = game:GetService("Players")
local client = Players.LocalPlayer
local events = require(game:GetService("ReplicatedStorage").Utilities.Events)
setmetatable(funcs, {
    __index = function(a,b)
        if b == "RemoveProjectiles" then
            return(function()
                for i,v in next, game:GetService("Workspace").Projectiles:GetChildren() do
                    v:Destroy()
                end
            end)
        end
        if b == "GetOre" then
            return(function()
                local closestDistance, closestObject = math.huge, nil
                for _, v in ipairs(game:GetService("Workspace").Materials:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Ore") and v.Name == "Ore" and v.Ore.Type.Value == Options.SelectedOre then
                        local distance = game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Ore.Position)
                        if distance < closestDistance then
                            closestDistance = distance
                            closestObject = v
                        end
                    end
                end
                return closestObject
            end)
        end
        if b == "GetLeather" then
            return(function()
                local closestDistance, closestObject = math.huge, nil
                for _, v in ipairs(game:GetService("Workspace").Materials:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Leather") and v.Name == "LeatherSource" and v.Leather:FindFirstChild("ClickDetector") then
                        local distance = game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Leather.Position)
                        if distance < closestDistance then
                            closestDistance = distance
                            closestObject = v
                        end
                    end
                end
                return closestObject
            end)
        end
        if b == "GetTree" then
            return(function()
                local closestDistance, closestObject = math.huge, nil
                for _, v in ipairs(game:GetService("Workspace").Materials.Trees:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Trunk") and v.Name == "Tree" then
                        local distance = game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Trunk.Position)
                        if distance < closestDistance then
                            closestDistance = distance
                            closestObject = v
                        end
                    end
                end
                return closestObject
            end)
        end
        if b == "Jump" then
            return(function()
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(3)
            end)
        end
        if b == "GetPickaxe" then
            return(function()
                for i,v in next, client.Backpack:GetDescendants() do
                    if v.Name == "PickSwing" then
                        return v.Parent.Parent
                    end
                end
                for i,v in next, client.Character:GetDescendants() do
                    if v.Name == "PickSwing" then
                        return v.Parent.Parent
                    end
                end
            end)
        end
        if b == "GetAxe" then
            return(function()
                for i,v in next, client.Backpack:GetDescendants() do
                    if v.Name == "AxeSwing" then
                        return v.Parent.Parent
                    end
                end
                for i,v in next, client.Character:GetDescendants() do
                    if v.Name == "AxeSwing" then
                        return v.Parent.Parent
                    end
                end
            end)
        end
    end
})
setmetatable(info, {
    __index = function(a,b)
        do
            if b == "Interactions" then
                local x = {}
                for i,v in next, game:GetService("Workspace").Interactions:GetChildren() do
                    if not table.find(x, v.Name) then
                        table.insert(x, v.Name)
                    end
                end
                return x
            end
            if b == "Data" then
                return game:GetService("ReplicatedStorage").Utilities.Events.GetData
            end
            if b == "LootCrates" then
                local x = {}
                for i,v in next, game:GetService("Workspace").LootCrates:GetChildren() do
                    if not table.find(x, v.Name) then
                        table.insert(x, v.Name)
                    end
                end
                return x
            end
            if b == "Stables" then
                local a = {}
                for i,v in next, game:GetService("Workspace").Stables:GetChildren() do
                    if not a[v.Name] then
                        a[v.Name] = v:FindFirstChild("Spawns"):FindFirstChild("Spawn")
                    end
                end
                return a
            end
            if b == "Volcano" then
                return game:GetService("Workspace").Volcano.Block
            end
            if b == "Locations" then
                local a = {}
                for i,v in next, game:GetService("Workspace").Locations:GetChildren() do
                    table.insert(a, v)
                end
                return a
            end
            if b == "Ores" then
                local a = {}
                for i,v in next, getgc(true) do
                    if typeof(v) == "table" then
                        if rawget(v, "Iron") and rawget(v, "Copper")  then
                            if typeof(v.Iron) == "table" then
                                for i2,v2 in next, v do
                                    if i2 ~= "Oak" and i2 ~= "Leather" then
                                        table.insert(a, i2)
                                    end
                                end
                                break
                            end
                        end
                    end
                end
                return a
            end
        end
    end
})

local rawmetmeta = getrawmetatable(game)
local oldfthing = rawmetmeta.__index
setreadonly(rawmetmeta, false)
rawmetmeta.__index = newcclosure(function(a, b)
	if b == "WalkSpeed" then
		return 10
	end
	if b == "JumpPower" then
		return 50
	end
	return oldfthing(a, b)
end)
setreadonly(rawmetmeta, true)

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "Roman Universe",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "- 2021-2022 -",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Roman Universe"
    },
    Discord = {
        Enabled = true,
        Invite = "bBZxdAhS9J",
        RememberJoins = true
    }
})

local Tab = Window:CreateTab("Home Tab", 11600721595)

local Section = Tab:CreateSection("Information")

Tab:CreateLabel("Release | V1.0")

local Tab = Window:CreateTab("Farming Tab", 11600741115)

local Section = Tab:CreateSection("Farming")

Tab:CreateDropdown({
	Name = "Select Ore",
	Options = info.Ores,
	CurrentOption = Options.SelectedOre,
	Flag = "Select Ore",
	Callback = function(x)
		Options.SelectedOre = x
	end
})

Tab:CreateToggle({
	Name = "Auto Farm Selected Ore",
	CurrentValue = false,
	Flag = "Auto Farm Selected Ore",
	Callback = function(x)
		getgenv()["Auto Farm Selected Ore"] = x
		while getgenv()["Auto Farm Selected Ore"] do
			task.wait()
			if getgenv()["Auto Farm Selected Ore"] == false then
				return
			end
			local Ore = funcs.GetOre()
            if Ore ~= nil then
                OreInfo:Set(("Ore Information: %s"):format(Options.SelectedOre))
                client.Character.HumanoidRootPart.CFrame = CFrame.lookAt(client.Character.HumanoidRootPart.Position, Ore.Ore.Position)
                client.Character:PivotTo(CFrame.new(Ore:GetPivot().p + (Ore:GetPivot().LookVector * 3.5)))
                events.Call("Hit", Ore.Ore, funcs.GetPickaxe().Name)
                task.wait(0.2)
            else
                OreInfo:Set(("Ore Information: %s"):format((("Not Found %s"):format(Options.SelectedOre))))
            end
		end
	end
})

Tab:CreateToggle({
	Name = "Auto Equip Pickaxe",
	CurrentValue = false,
	Flag = "Auto Equip Pickaxe",
	Callback = function(x)
		getgenv()["Auto Equip Pickaxe"] = x
		while getgenv()["Auto Equip Pickaxe"] do
			task.wait()
			if getgenv()["Auto Equip Pickaxe"] == false then
				return
			end
			pcall(function()
                client.Character.Humanoid:EquipTool(funcs.GetPickaxe())
            end)
		end
	end
})

OreInfo = Tab:CreateLabel("Ore Information: %s")

local Section = Tab:CreateSection("Others")

Tab:CreateToggle({
	Name = "Auto Grab Leather | HAVE NOTHING EQUIPPED",
	CurrentValue = false,
	Flag = "Auto Grab Leather",
	Callback = function(x)
		getgenv()["Auto Grab Leather"] = x
		while getgenv()["Auto Grab Leather"] do
			task.wait()
			if getgenv()["Auto Grab Leather"] == false then
				return
			end
			pcall(function()
                local Leather = funcs.GetLeather()
                if Leather ~= nil then
                    client.Character:PivotTo(Leather.Leather:GetPivot())
                    fireclickdetector(Leather.Leather.ClickDetector)
                end
            end)
		end
	end
})

local leatherThreshold = 50

Tab:CreateToggle({
	Name = "Auto Buy Scarfs",
	CurrentValue = false,
	Flag = "Auto Buy Scarfs",
	Callback = function(x)
		getgenv()["Auto Buy Scarfs"] = x
		while getgenv()["Auto Buy Scarfs"] do
			if getgenv()["Auto Buy Scarfs"] == false then
				return
			end
            local data = info["Data"]:InvokeServer()
            local leather = data.Materials.Leather
            if leather >= leatherThreshold then
                events.Call("Craft", game:GetService("ReplicatedStorage").GameTools:FindFirstChild("White Hood & White Scarf"))
            end
            task.wait(0.25)
		end
	end
})

Tab:CreateToggle({
	Name = "Auto Sell Scarfs",
	CurrentValue = false,
	Flag = "Auto Sell Scarfs",
	Callback = function(x)
		getgenv()["Auto Sell Scarfs"] = x
		while getgenv()["Auto Sell Scarfs"] do
			if getgenv()["Auto Sell Scarfs"] == false then
				return
			end
            local data = info["Data"]:InvokeServer()
            for i,v in next, data.Inventory do
                if v.Name == "White Hood & White Scarf" then
                    if v.Type == "HATS" then
                        events.Call("TradeIn", v.Tag)
                    end
                end
            end
            task.wait(0.25)
		end
	end
})

Tab:CreateSlider({
	Name = "Buy Scarfs At",
	Range = {
		10,
		50
	},
	Increment = 1,
	Suffix = "Leather",
	CurrentValue = 25,
	Flag = "Buy Scarfs At",
	Callback = function(x)
		leatherThreshold = x
	end
})

Tab:CreateToggle({
	Name = "Auto Farm Wood",
	CurrentValue = false,
	Flag = "Auto Farm Wood",
	Callback = function(x)
		getgenv()["Auto Farm Wood"] = x
		while getgenv()["Auto Farm Wood"] do
			task.wait()
			if getgenv()["Auto Farm Wood"] == false then
				return
			end
			pcall(function()
                local Tree = funcs.GetTree()
                client.Character.HumanoidRootPart.CFrame = CFrame.lookAt(client.Character.HumanoidRootPart.Position, Tree.Trunk.Position)
                client.Character:PivotTo(CFrame.new(Tree:GetPivot().p + (Tree:GetPivot().LookVector * 3.5)))
                events.Call("Hit", Tree.Trunk, funcs.GetAxe().Name)
                task.wait(0.2)
            end)
		end
	end
})

Tab:CreateToggle({
	Name = "Auto Equip Axe",
	CurrentValue = false,
	Flag = "Auto Equip Axe",
	Callback = function(x)
		getgenv()["Auto Equip Axe"] = x
		while getgenv()["Auto Equip Axe"] do
			task.wait()
			if getgenv()["Auto Equip Axe"] == false then
				return
			end
			pcall(function()
                client.Character.Humanoid:EquipTool(funcs.GetAxe())
            end)
		end
	end
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)