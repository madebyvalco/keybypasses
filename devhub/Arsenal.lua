local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "DevHub",
   LoadingTitle = "DevHub [Arsenal]",
   LoadingSubtitle = "by HevX",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Dev Hub"
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
      Note = "Join the discord (discord.gg/ftMc57WuGd)",
      FileName = "DevKey",
      SaveKey = false,
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = "S1nvL94E5AY8g9t"
   }
})

local Tab = Window:CreateTab("GUIs", 4483362458) -- Title, Image
local Section = Tab:CreateSection("GUIs")
local Button = Tab:CreateButton({
   Name = "Voidz Hub",
   Callback = function()
      loadstring(game:HttpGet(('https://raw.githubusercontent.com/RTrade/Voidz/main/other-scripts/VoidzCombatV3'),true))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = Tab:CreateButton({
   Name = "Owl Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
   -- The function that takes place when the button is pressed
   end,
})

local Button = Tab:CreateButton({
   Name = "Nexus Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/GwnStefano/NexusHub/main/Main", true))()
   -- The function that takes place when the button is pressed
   end,
})

local Label = Tab:CreateLabel("More GUIs will be added, stay tuned.")