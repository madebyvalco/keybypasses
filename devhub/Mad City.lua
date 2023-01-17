local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
	Name = "DevHub",
	LoadingTitle = "Mad City Chapter 2",
	LoadingSubtitle = "by HevX",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "DevHub"
	},
        Discord = {
        	Enabled = true,
        	Invite = "ftMc57WuGd", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = false -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "DevHub",
		Subtitle = "Key System",
		Note = "Join the discord for the key (discord.gg/ftMc57WuGd)",
		FileName = "DevKey",
		SaveKey = false,
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "S1nvL94E5AY8g9t"
	}
})

local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Main")
local Button = Tab:CreateButton({
	Name = "AutoRob",
	Callback = function()
    --Discord: discord.gg/NekoHub

loadstring(game:HttpGet('https://nekoscripts.xyz/neko/Scripts/Auto_Rob.lua'))()
		-- The function that takes place when the button is pressed
	end,
})

local Button = Tab:CreateButton({
	Name = "Silent Aim [OP]",
	Callback = function()
        getgenv().fov = 260 -- Field of View: The silent aim is only targetted at the target inside the fov's radius.
        getgenv().bodypart = "Head" -- Targetting: "Head", "Torso". For example: Using "Head" will only deal headshots.
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Cesare0328/my-scripts/main/SAMCH2', true))()

Rayfield:Notify({
    Title = "Warning",
    Content = "Make sure you execute silent aim before equiping the gun!",
    Duration = 50,
    Image = 4483362458,
    Actions = { -- Notification Buttons
        Ignore = {
            Name = "Okay!",
            Callback = function()
                print("The user tapped Okay!")
            end
		},
	},
})
		-- The function that takes place when the button is pressed
	end,
})


local Paragraph = Tab:CreateParagraph({Title = "Note", Content = "Couldn't find anything else for chapter 2."})

local Button = Tab:CreateButton({
	Name = "ESP",
	Callback = function()
MobEsp = false
MobLocations = {game:GetService("Workspace")} --add locations of the mobs in the workspace
MobNames = {""} --add the names of the mobs

PlayerESP = true

plr = game.Players.LocalPlayer
_G.on = true --set to false if you want to turn it off

names = {}
function isin(obj,tbl)
	for a = 1,#tbl do
		if obj == tbl[a] then
			return true
		end
	end
	return false
end
function test1(D)
	local d = tonumber(string.sub(D,1,string.find(D,".",1,true) + 1))
	return d
end
function Label(Part,Distance)
	local MainName = Part.Parent.Name
	local check = Part:FindFirstChild(MainName .. " Tracker")
	if check then
		destroyed = false
		while not destroyed do
			for i = 1,#names do
				if names[i] == MainName then
					table.remove(names,i)
					destroyed = true
					break
				end
			end
			destroyed = true
		end
		check:Destroy()
	end
	local Gui = Instance.new("BillboardGui")
	local Text = Instance.new("TextLabel")
	if Distance ~= nil then
		local assa,D = pcall(test1,Distance)
		if D ~= nil and D then
			D = tonumber(D)
			table.insert(names,MainName)
			Gui.Name = MainName.." Tracker"
			Gui.Parent = Part
			Gui.Adornee = Part
			Gui.ExtentsOffsetWorldSpace = Vector3.new(0,3,0)
			Gui.MaxDistance = 2500
			Gui.Size = UDim2.new(0,200,0,50)
			Gui.AlwaysOnTop = true
			Text.Parent = Gui
			Text.TextWrapped = true
			Text.BackgroundTransparency = 1
			Text.TextSize = 8
			Text.Size = UDim2.new(0, 200, 0, 50)
			Text.Font = Enum.Font.Legacy
			if D ~= nil and D < 30 then
				Text.TextColor3 = Color3.fromRGB(33, 231, 40)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			elseif D ~= nil and D < 100 then
				Text.TextColor3 = Color3.fromRGB(228, 231, 34)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			elseif D ~= nil and D < 500 then
				Text.TextColor3 = Color3.fromRGB(255, 140, 46)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			elseif D ~= nil and D < 2500 then
				Text.TextColor3 = Color3.fromRGB(255, 0, 0)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			end
		end
	end
end

function Root()
	plr = game.Players:FindFirstChild(game.Players.LocalPlayer.Name)
	if plr then
		local root = plr.Character:FindFirstChild("HumanoidRootPart")
		if root then
			return root
		else
			for i = 1,#names do
				local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
				if check then
					table.remove(names,i)
					check:Destroy()
					break
				end
			end
			game:GetService('RunService').Stepped:wait()
			Root()
		end
	end
end

while _G.on do
	game:GetService('RunService').Stepped:wait()
	plr = game.Players.LocalPlayer
	if MobEsp then
		for iter = 1,#MobLocations do
			local check = MobLocations[iter]:FindFirstChildOfClass("Model")
			local check2 = MobLocations[iter]:FindFirstChildOfClass("Part")
			if check or check2 then
				for i,v in pairs(MobLocations[iter]:GetChildren()) do
					if v.ClassName == "Model" or v.ClassName == "Part" and isin(v.Name,MobNames) == true then
						local placed = false
						for a,b in pairs(v:GetChildren()) do
							if b.Name == "Head" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								Label(b,(Root().Position - b.Position).Magnitude)
							elseif b.Name == "UpperTorso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								Label(b,(Root().Position - b.Position).Magnitude)
							elseif b.Name == "Torso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								Label(b,(Root().Position - b.Position).Magnitude)
							elseif b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								repeat wait() until game.Players.LocalPlayer.Character ~= nil
								Label(b,(Root().Position - b.Position).Magnitude)
							end
						end
					end
				end
			end
		end
	end
	if PlayerESP then
		for z,d in pairs(game.Players:GetChildren()) do
			if d.Character ~= nil and d ~= plr then
				local prt = d.Character:FindFirstChildOfClass("Part")
				if prt then
					local placed = false
					for j,g in pairs(d.Character:GetChildren()) do
						if g.Name == "Head" and not placed then
							placed = true
							Label(g,(Root().Position - g.Position).Magnitude)
						elseif g.Name == "UpperTorso" and not placed then
							placed = true
							Label(g,(Root().Position - g.Position).Magnitude)
						elseif g.Name == "Torso" and not placed then
							placed = true
							Label(g,(Root().Position - g.Position).Magnitude)
						end
					end
				end
			end
		end
	end
end
while #names > 0 do
	game:GetService('RunService').Stepped:wait()
	for i = 1,#names do
		local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
		if check then
			table.remove(names,i)
			check:Destroy()
			break
		end
	end
end
		-- The function that takes place when the button is pressed
	end,
})

local Tab = Window:CreateTab("Character", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Character")

local Button = Tab:CreateButton({
	Name = "Anti-AFK",
	Callback = function()
		local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
		-- The function that takes place when the button is pressed
	end,
})
