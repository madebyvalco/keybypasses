function teleportToGun()
    for i, v in next, workspace:GetChildren() do
        if v.ClassName == "Tool" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChildOfClass("Part").CFrame
        end
    end
end

local esplib = loadstring(game:HttpGet("https://rentry.co/5yod5m/raw"))()

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

Section:CreateButton(
    "Teleport To Gun",
    function()
        teleportToGun()
    end
)

Section:CreateButton(
    "Set Loadout To Clipboard",
    function()
        setclipboard(
            "!sts sr+kob+com+red sr+heav+red+coy rem+eot+red+com+erg med def chey+hun+sup+gre fire ballistic ballisticsv nv"
        )
    end
)

Section:CreateButton(
    "Full Bright",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/06iG6YkU", true))()
    end
)

Section:CreateButton(
    "Mod Gun",
    function()
        local contextactionservice = game:GetService("ContextActionService")

        contextactionservice.LocalToolEquipped:Connect(function(tool)
            for _, v in pairs(debug.getregistry()) do
                if typeof(v) == "function" and not is_synapse_function(v) then
                    local script = rawget(getfenv(v), "script")
                    if typeof(script) == "Instance" and script.Name == "GunScript" then
                        local x = getsenv(script)
                        x.auto = true
                        x.waittime = 0.025
                        x.scatter = 75
                        
                        x.Projectiles = 10000
                        x.AimScatterMultiplyer = 1
                        x.ReloadSpeed = 0.1
                        tx.GunRecoil = 0
                        
                        table.foreach(x, print)
                    end
                end
            end
        end)
    end
)

local Section = Tab:CreateSection("ESP")

Section:CreateToggle(
    "ESP TOGGLE",
    nil,
    function(x)
        esplib:Toggle(x)
    end
)

Section:CreateToggle(
    "ESP BOXES",
    false,
    function(x)
        esplib.Boxes = x
    end
)

Section:CreateToggle(
    "ESP NAMES",
    false,
    function(x)
        esplib.Names = x
    end
)

Section:CreateToggle(
    "ESP FACE CAMERA",
    false,
    function(x)
        esplib.FaceCamera = x
    end
)