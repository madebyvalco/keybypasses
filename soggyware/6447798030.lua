local Players = game:GetService("Players")
local function CollectGoldRing()
    for i,v in next, game:GetService("Workspace").Map.FunctionalBuildings.RingSpawners:GetDescendants() do
        if v:IsA("MeshPart") then
            if v.Transparency ~= 1 then
                Players.LocalPlayer.Character:PivotTo(v:GetPivot())
                break
            end
        end
    end
end

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "Funky Friday",
	LoadingTitle = "Soggyware",
	LoadingSubtitle = "EST. 2022",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Soggyware",
		FileName = "Funky Friday"
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
	Name = "Auto Collect Sonic Rings",
	CurrentValue = false,
	Flag = "Auto Collect Sonic Rings",
	Callback = function(x)
		getgenv()["Auto Collect Sonic Rings"] = x
		while getgenv()["Auto Collect Sonic Rings"] do
			task.wait()
			if getgenv()["Auto Collect Sonic Rings"] == false then
				return
			end
			pcall(CollectGoldRing)
		end
	end
})

local RingLabel = Tab:CreateLabel("0 / 1000 Rings Collected")

task.spawn(function()
    while task.wait(0.25) do
        local Rings = game:GetService("ReplicatedStorage").RF:InvokeServer({
            [1] = "Server",
            [2] = "QuestHandler",
            [3] = "GetProgress"
        }, {
            [1] = "SonicIntegration_3"
        })[1]

        RingLabel:Set(Rings .. " / 1000 Rings Collected")
    end
end)