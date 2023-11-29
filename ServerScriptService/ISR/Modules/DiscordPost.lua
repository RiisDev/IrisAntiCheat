local Http = game:GetService("HttpService");
local function GetUserHeadshot(PlayerId)
	local ReturnVal = Http:GetAsync(("https://api.irisapp.ca/RobloxAPI/Proxy/thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%s&size=60x60&format=Png&isCircular=false"):format(PlayerId))
	local ReturnJson = Http:JSONDecode(ReturnVal);
	return ReturnJson["data"][1]["imageUrl"];
end

return function(Player, Reason, StackTrace, DoKick)
	StackTrace = StackTrace:sub(1, #StackTrace)

	local PublicUrl = "https://irisapp.ca/IrisHook/api/465727038305599500/WEBHOOKLINK";
	local PrivateUrl = "https://irisapp.ca/IrisHook/api/465727038305599500/WEBHOOKLINK";
	local PostData = {
		["avatar_url"] = "https://api.irisapp.ca/RobloxAPI/ISU.webp",
		["username"] = "Exploit Posting",
		["content"] = "",
		["embeds"] = {
			{
				["title"] = "Anti Cheat Received a Detection",
				["description"] = "**A player has been caught by the anti-cheat.**",
				["color"] = 4980991,
				["fields"] = {
					{
						["name"] = "**Player Name**",
						["value"] = ("``%s``"):format(Player and Player.Name or "Roblox | N/A"),
						["inline"] = true
					},
					{
						["name"] = "**Player UserId**",
						["value"] = ("``%s``"):format(Player and Player.UserId or 0),
						["inline"] = true
					},
					{
						["name"] = "**Reason**",
						["value"] = ("``%s``"):format(Reason or "N/A"),
						["inline"] = false
					},
					{
						["name"] = "**Stack Trace**",
						["value"] = ("``%s``"):format(StackTrace or " N/A"),
						["inline"] = false
					},
					{
						["name"] = "**Place ID**",
						["value"] = ("``%s``"):format(game and game.PlaceId or "N/A"),
						["inline"] = false
					},
					{
						["name"] = "**Private Server**",
						["value"] = ("``%s``"):format(tostring((function() return game and game.PrivateServerId ~= "" end)())),
						["inline"] = false
					},
					{
						["name"] = "**Server ID**",
						["value"] = ("``%s``"):format(game and game.JobId or "N/A"),
						["inline"] = false
					}
				},
				["thumbnail"] = {
					["url"] = ("%s"):format(GetUserHeadshot(Player.UserId)),
					["height"] = 0,
					["width"] = 0
				},
				["footer"] = {
					["text"] = ("{ Iris Anti Exploit } • %s • %s %s %s"):format(os.date("%x"), os.date("%I:%M"), os.date("%p"), "MST")
				},
				["url"] = ("https://www.roblox.com/games/%s/#"):format(game and game.PlaceId or 0);
			}
		}
	}
	local PrivateJson = Http:JSONEncode(PostData);
	
	local PublicJson = PostData;
	PublicJson.embeds[1].fields[4].value = "``Stack trace redacted``"
	PublicJson = Http:JSONEncode(PublicJson);
	
 	--Http:PostAsync(PublicUrl, PublicJson, Enum.HttpContentType.ApplicationJson, false);
	Http:PostAsync(PrivateUrl, PrivateJson, Enum.HttpContentType.ApplicationJson, false);
	
	if DoKick.KickUser then
		Player.Parent = nil
	end
end