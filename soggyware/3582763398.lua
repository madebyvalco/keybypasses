local function DoObby()
    local Position = game.PlaceId == 7227293156 and game:GetService("Workspace").tower.sections.finishEvent.FinishGlow.CFrame or game:GetService("Workspace").tower.sections.finish.FinishGlow.CFrame + Vector3.new(5,0,0)
    task.wait(0.5)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(0.1)
    game.Players.LocalPlayer.Character:PivotTo(Position)
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Tower Of Hell",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Tower Of Hell RB Battles"
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

Tab:CreateButton({
    Name = "Complete Obby",
    Callback = DoObby
})