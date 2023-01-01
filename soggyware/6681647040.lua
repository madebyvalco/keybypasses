function closest()
    local closestDistance, closestObject = math.huge, nil
    for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local distance = game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)
            if distance < closestDistance then
                closestDistance = distance
                closestObject = v.Name
            end
        end
    end
    return closestObject
end

function teleport(a)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[a].Character.HumanoidRootPart.CFrame + game.Players[a].Character.HumanoidRootPart.CFrame.LookVector * -3.5
end

function collectCoins()
    for _,v in next, game:GetService("Workspace").RealTrash:GetDescendants() do
        if v.Name == "TouchInterest" and v.Parent then
            for i = 0,1 do
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, i)
            end
        end
    end
end

function q()
    local args = {
        [1] = Enum.KeyCode.Q
    }

    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Tricky Sign").Remote:FireServer(unpack(args))
end

local title = "Soggyware | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local Config = {
    WindowName = title,
    Color = Color3.fromRGB(3, 127, 252),
    Keybind = Enum.KeyCode.F
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))
local esplib = loadstring(game:HttpGet("https://rentry.co/5yod5m/raw"))()

local Tab = Window:CreateTab("Main")

local a = Tab:CreateSection("Main")

a:CreateToggle(
    "Teleport To Closest Player",
    nil,
    function(x)
        getgenv().playerTeleport = x

        while playerTeleport do task.wait()
            teleport(closest())
        end
    end
)

local selectedPlr

a:CreateToggle(
    "Teleport To Specific",
    nil,
    function(x)
        getgenv().playerTeleport2 = x

        while playerTeleport2 do task.wait()
            teleport(selectedPlr)
        end
    end
)

local Mouse = game.Players.LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local function GetClosestPlayer()
	local Closest = {nil, nil}
	local MousePos = Vector2.new(Mouse.X, Mouse.Y)
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player == game.Players.LocalPlayer then continue end
		local Character = Player.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local vector, onScreen = Camera:WorldToScreenPoint(HumanoidRootPart.Position)
				if onScreen then
					local Distance = (MousePos - Vector2.new(vector.X, vector.Y)).Magnitude
					if Closest[1] == nil then Closest = Player.Name continue end
					if  Distance < Closest[1] then
						Closest = Player.Name
					end
				end
			end
		end
	end
	return Closest
end

closestplr = GetClosestPlayer()

a:CreateToggle(
    "Silent Aim | Throwing Weapons",
    nil,
    function(x)
        getgenv().silentaim = x

        while silentaim do task.wait()
            pcall(function()
                local args = {
                    [1] = game.Players[closestplr].Character.HumanoidRootPart.Position
                }

                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").MouseEvent:FireServer(unpack(args))
            end)
        end
    end
)

local players = {}

for _,v in next, game:GetService("Players"):GetPlayers() do
    if v.Name ~= game.Players.LocalPlayer.Name then
        if not table.find(players, v.Name) then
            table.insert(players, v.Name)
        end
    end
end

a:CreateDropdown(
    "Select Player",
    players,
    function(x)
        selectedPlr = x
    end
)

local a = Tab:CreateSection("ESP + Misc")

a:CreateToggle(
    "Press Q",
    nil,
    function(x)
        getgenv().pressq = x

        while pressq do task.wait()
            q()
        end
    end
)

a:CreateToggle(
    "Toggle ESP",
    nil,
    function(x)
        esplib:Toggle(x)
    end
)

a:CreateToggle(
    "Name ESP",
    nil,
    function(x)
        esplib.Names = x
    end
)

a:CreateToggle(
    "Box ESP",
    nil,
    function(x)
        esplib.Boxes = x
    end
)

a:CreateToggle(
    "Toggle Boxes Face Cam",
    nil,
    function(x)
        esplib.FaceCamera = x
    end
)

local Tab = Window:CreateTab("Settings")

local a = Tab:CreateSection("Settings")

local toggleui =
a:CreateToggle(
    "Toggle UI",
    nil,
    function(x)
        for _, v in next, game:GetService("CoreGui"):GetChildren() do
            a = v:FindFirstChild("ToolTip")
            if a then
                if x == true then
                    a.Parent.Enabled = false
                elseif x == false then
                    a.Parent.Enabled = true
                end
            end
        end
    end
)

a:CreateButton(
    "Close UI",
    function()
        for _, v in next, game:GetService("CoreGui"):GetChildren() do
            a = v:FindFirstChild("ToolTip")
            if a then
                a.Parent:Destroy()
            end
        end
    end
)

a:CreateButton(
    "Join Discord",
    function()
        local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = rhttp:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = game:GetService('HttpService'):GenerateGUID(false),
                    args = {code = 'dYHag43eeU'}
                })
            })
        end
    end
)
toggleui:CreateKeybind("F")