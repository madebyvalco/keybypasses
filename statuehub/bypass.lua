local key = game:HttpGet("https://pastebin.com/raw/xMfYa0Xr")


game.CoreGui.ChildAdded:Connect(function(v)
    if v.Name == "Statue" then
       local Holder = v:WaitForChild("Holder")
       Holder.Key.Text = key
       for _,v in pairs(getconnections(Holder.Submit.MouseButton1Click)) do
           v:Fire()
        end
    end
end)

loadstring(game:HttpGet("https://www.statuescripts.com/Script"))()
