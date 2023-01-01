local localPlayer = game:GetService("Players").LocalPlayer
local currentCamera = game:GetService("Workspace").CurrentCamera
local mouse = localPlayer:GetMouse()
local plr = game.Players.LocalPlayer
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera
local boxes = {}

local function newLine()
    local v = Drawing.new("Line")
    v.Color = Color3.fromRGB(255, 255, 255)
    v.From = Vector2.new(1, 1)
    v.To = Vector2.new(0, 0)
    v.Visible = true
    v.Thickness = 2
    return v
end
local function newBox(player)
    local box = {
        ["Player"] = player,
        newLine(),
        newLine(),
        newLine(),
        newLine()
    }

    table.insert(boxes, box)
end

local function shapeBox(box)
    local player = box["Player"]
    local TL = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(-3, 3, 0).p)
    local TR = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(3, 3, 0).p)
    local BL = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(-3, -3, 0).p)
    local BR = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(3, -3, 0).p)
    box[1].From = Vector2.new(TL.X, TL.Y)
    box[1].To = Vector2.new(BL.X, BL.Y)
    box[2].To = Vector2.new(TR.X, TR.Y)
    box[2].From = Vector2.new(TL.X, TL.Y)
    box[3].To = Vector2.new(BR.X, BR.Y)
    box[3].From = Vector2.new(TR.X, TR.Y)
    box[4].To = Vector2.new(BR.X, BR.Y)
    box[4].From = Vector2.new(BL.X, BL.Y)
end
local function visBox(box, vis)
    for i, v in ipairs(box) do
        v.Visible = vis
    end
end

local function hasBox(player)
    for i, v in ipairs(boxes) do
        if v["Player"] == player then
            return true
        end
    end
end

function WTS(part)
    local screen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
    return Vector2.new(screen.x, screen.y)
end

function ESPText(part, color, namee)
    local name = Drawing.new("Text")
    name.Text = namee
    name.Color = color
    name.Position = WTS(part)
    name.Size = 20.0
    name.Outline = true
    name.Center = true
    name.Visible = true

    game:GetService("RunService").Stepped:connect(
        function()
            pcall(
                function()
                    local destroyed = not part:IsDescendantOf(workspace)
                    if destroyed and name ~= nil then
                        name:Remove()
                    end
                    if part ~= nil then
                        name.Position = WTS(part)
                    end
                    local _, screen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                    if screen then
                        name.Visible = true
                    else
                        name.Visible = false
                    end
                end
            )
        end
    )
end

local function getMobs()
    for _, v in next, game:GetService("Workspace").Entities:GetChildren() do
        if v.ClassName == "Model" then
            return v.Name
        end
    end
end

local function light(bool)
    a = Instance.new("SurfaceLight", game.Players.LocalPlayer.Character.Head)
    a.Name = "SpotlightSGWR"
    a.Brightness = 0.001
    a.Enabled = bool
    a.Color = Color3.new(255, 255, 255)
end

local function vision()
    a = game:GetService("Lighting")
    a.Ambient = Color3.new(2, 2, 2)
    a.FogEnd = 0
    a.FogStart = 0
end

local function entityEsp()
    for _, v in next, game:GetService("Workspace").Entities:GetChildren() do
        if v.ClassName == "Model" then
            if v:findFirstChild("HumanoidRootPart") then
                ESPText(v.HumanoidRootPart, Color3.new(255, 255, 255), v.Name)
            end
        end
    end
end

local function removeSound()
    for _, v in next, game:GetDescendants() do
        if v.ClassName == "Sound" then
            v:Destroy()
        end
    end
end

local interacts = {}

for _, v in next, game:GetService("Workspace").Ignored.Interacts:GetChildren() do
    if v.ClassName ~= "Folder" then
        table.insert(interacts, v.Name)
    end
end

local function teleportToInterect(x)
    for _, v in next, game:GetService("Workspace").Ignored.Interacts:GetChildren() do
        if v.Name == x then
            if v.ClassName == "Part" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            elseif v.ClassName == "Model" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
end

local function collectTrophies()
    for _, v in ipairs(game:GetService("Workspace").Ignored.Trophies:GetChildren()) do
        IllIIIllII = v:FindFirstChildOfClass("MeshPart")
        if IllIIIllII then
            game.Players.LocalPlayer.character.HumanoidRootPart.CFrame = IllIIIllII.CFrame
        end
    end
end

local areas = {}

for _, v in next, game:GetService("Workspace").Ignored.Regions:GetChildren() do
    table.insert(areas, v.Name)
end

local function teleportToArea(x)
    for _, v in next, game:GetService("Workspace").Ignored.Regions:GetChildren() do
        if v.Name == x then
            if v.ClassName == "Model" then
                game.Players.LocalPlayer.character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
            else
                game.Players.LocalPlayer.character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
end

local function getStuds()
    for _, v in next, game:GetService("Workspace").Entities:GetChildren() do
        if v.ClassName == "Model" then
            distance =
                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            distance = math.floor(distance)
            return v.Name .. " is " .. tostring(distance) .. " studs away from you"
        end
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

local distanceLabel = Tab:AddLabel("")

task.spawn(
    function()
        while true do
            wait(0.1)
            pcall(
                function()
                    distanceLabel:Set(getStuds())
                end
            )
        end
    end
)

Tab:AddToggle(
    {
        Name = "Collect Trophies",
        Default = false,
        Save = true,
        Flag = "trophies",
        Callback = function(val)
            getgenv().trophiesToggle = val

            while trophiesToggle do
                task.wait()
                if trophiesToggle == true then
                    collectTrophies()
                elseif trophiesToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Remove Sound",
        Callback = function()
            removeSound()
        end
    }
)

Tab:AddButton(
    {
        Name = "Remove Fog / Darkness",
        Callback = function()
            vision()
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Teleport",
        Icon = "rbxassetid://7072718266",
        PremiumOnly = false
    }
)

local plrs = {}
local selectedPlr

for _, v in next, game:GetService("Players"):GetPlayers() do
    if v.Name ~= game.Players.LocalPlayer.Name then
        table.insert(plrs, v.Name)
    end
end

Tab:AddDropdown(
    {
        Name = "Select Player",
        Default = "nil",
        Save = true,
        Flag = "players",
        Options = plrs,
        Callback = function(x)
            selectedPlr = x
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To Player",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players[selectedPlr].Character.HumanoidRootPart.CFrame
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Teleport To Interactable",
        Default = "nil",
        Save = false,
        Flag = "intereactbales",
        Options = interacts,
        Callback = function(x)
            teleportToInterect(x)
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Teleport To Area",
        Default = "nil",
        Save = false,
        Flag = "area",
        Options = areas,
        Callback = function(x)
            teleportToArea(x)
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Visuals",
        Icon = "rbxassetid://7072716095",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "X Ray",
        Default = false,
        Save = true,
        Flag = "xray",
        Callback = function(x)
            getgenv().xrayToggle = x

            while xrayToggle do
                task.wait()
                if xrayToggle == true then
                    for _, v in next, game:GetService("Workspace").Buildings:GetDescendants() do
                        if v.ClassName == "MeshPart" or v.ClassName == "Part" or v.ClassName == "UnionOperation" then
                            v.Transparency = 0.5
                        end
                    end
                elseif xrayToggle == false then
                    for _, v in next, game:GetService("Workspace").Buildings:GetDescendants() do
                        if v.ClassName == "MeshPart" or v.ClassName == "Part" or v.ClassName == "UnionOperation" then
                            v.Transparency = 0
                        end
                    end
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Flash Light",
        Default = false,
        Save = true,
        Flag = "flashlight",
        Callback = function(x)
            getgenv().flashlightToggle = x

            while xrayToggle do
                task.wait()
                if flashlightToggle == true then
                    light(true)
                elseif flashlightToggle == false then
                    light(false)
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Creature ESP",
        Default = false,
        Save = true,
        Flag = "esp",
        Callback = function(x)
            getgenv().espToggle = x

            if espToggle == true then
                entityEsp()
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Player",
        Icon = "rbxassetid://7072724538",
        PremiumOnly = false
    }
)

Tab:AddSlider(
    {
        Name = "Walkspeed",
        Min = 16,
        Max = 500,
        Default = 16,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(x)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = x
        end
    }
)

Tab:AddSlider(
    {
        Name = "Jump Power",
        Min = 50,
        Max = 500,
        Default = 50,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(x)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = x
        end
    }
)

Tab:AddSlider(
    {
        Name = "FOV",
        Min = 70,
        Max = 120,
        Default = 70,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(x)
            game:GetService("Workspace").Camera.FieldOfView = x
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Settings",
        Icon = "rbxassetid://7072721682",
        PremiumOnly = false
    }
)

Tab:AddButton(
    {
        Name = "Join Discord Server",
        Callback = function()
            local http = game:GetService("HttpService")
            if toClipboard then
                toClipboard("https://discord.gg/soggy")
            else
            end
            local req =
                syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or
                getgenv().request or
                request
            if req then
                req(
                    {
                        Url = "http://127.0.0.1:6463/rpc?v=1",
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json",
                            Origin = "https://discord.com"
                        },
                        Body = http:JSONEncode(
                            {
                                cmd = "INVITE_BROWSER",
                                nonce = http:GenerateGUID(false),
                                args = {code = "soggy"}
                            }
                        )
                    }
                )
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Anti-AFK",
        Callback = function()
            local Players = game:GetService("Players")
            local GC = getconnections or get_signal_cons
            if GC then
                for i, v in pairs(GC(Players.LocalPlayer.Idled)) do
                    if v["Disable"] then
                        v["Disable"](v)
                    elseif v["Disconnect"] then
                        v["Disconnect"](v)
                    else
                        print("")
                    end
                end
            elseif not GC then
                OrionLib:MakeNotification(
                    {
                        Name = "Soggyware | Error",
                        Content = "Your executor does not support getconnections " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072980286",
                        Time = 4
                    }
                )
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Destroy UI",
        Callback = function()
            OrionLib:Destroy()
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Load Config",
        Default = "",
        TextDisappear = true,
        Callback = function(x)
            print(x)
        end
    }
)

Tab:AddLabel("Need Support? discord.gg/soggy")
Tab:AddLabel("Made By: Sunken")

local Tab =
    Window:MakeTab(
    {
        Name = "Premium",
        Icon = "rbxassetid://7072717958",
        PremiumOnly = false
    }
)

Tab:AddButton(
    {
        Name = "Get Key",
        Callback = function()
            setclipboard("https://link-center.net/106218/keys")
            OrionLib:MakeNotification(
                {
                    Name = "Soggyware | Key System",
                    Content = "Copied Link To Clipboard " .. game.Players.LocalPlayer.Name,
                    Image = "rbxassetid://7072717958",
                    Time = 4
                }
            )
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Key",
        Default = "",
        TextDisappear = true,
        Callback = function(x)
            if x == "8442e63b-974e-a691-a97b-80dca2e67210" then
                OrionLib:MakeNotification(
                    {
                        Name = "Premium | Key System",
                        Content = "Correct Key, assigning premium now " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072717958",
                        Time = 4
                    }
                )
                Premium = true
            elseif x ~= "8442e63b-974e-a691-a97b-80dca2e67210" or x == "" then
                OrionLib:MakeNotification(
                    {
                        Name = "Premium | Key System",
                        Content = "Wrong Key " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072717958",
                        Time = 4
                    }
                )
            end
        end
    }
)

Tab:AddLabel("Premium unlocks extra features!")

OrionLib:Init()