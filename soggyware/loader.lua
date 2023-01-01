request = http_request or request or HttpPost or syn.request

local req = game:HttpGet("https://raw.githubusercontent.com/RiseValco/keybypasses/main/soggyware/"..game.PlaceId..".lua")
local discord = game:HttpGet("https://raw.githubusercontent.com/RiseValco/keybypasses/main/discord")
pcall(function()
request({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = http:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = http:GenerateGUID(false),
				args = {code = discord}
			})
		})
end)


if string.find(req, "404: Not Found") then return end
loadstring(req)()


