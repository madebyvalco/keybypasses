local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "DOORS Lobby 👁️",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "- Soggyware Team",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "DOORS Lobby"
    },
    Discord = {
        Enabled = true,
        Invite = "bBZxdAhS9J",
        RememberJoins = true
    }
})

local Tab = Window:CreateTab("Home Tab", 11600721595)

local Section = Tab:CreateSection("Join A Game And Re-Execute")

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        (queue_on_teleport or syn.queue_on_teleport)('loadstring(game:HttpGet("https://soggyhubv2.vercel.app"))()')
    end
end)