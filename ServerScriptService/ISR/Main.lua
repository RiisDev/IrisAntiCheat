warn(("ISR Version %s"):format(tostring(game.PlaceVersion):gsub("(.)", "%1."):sub(0, -2)));

--[[ Anti Exploit Shtuff ]] --

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserData = {}
local IrisSecureRemote;
_G.ISRServer = {}

function _G.DetectedPost(Player, Reason, StackTrace)
	if UserData[Player.UserId].Kicked then
		return
	end

	local success, result = pcall(function()
		UserData[Player.UserId].Kicked = true
		require(script.DiscordPost)(Player, Reason, StackTrace, {
			KickUser = true,
			Reason = Reason
		})
	end)

	if not success then	return end

	repeat
		task.wait(0.1)
	until not Players:FindFirstChild(Player.Name)
end


game:GetService("Players").PlayerAdded:Connect(function(Player)
	UserData[Player.UserId] = {
		Player = Player,
		Kicked = false,
		KeyData = {
			Seed = math.floor(math.random(tick() / 2, tick()) * os.clock());
			Key = 0,
			KeyCode = 0,
			Requested = false,
			Ready = false
		},
		Steps = {
			["0x0otNzGrlVsY8b8YriJhq2"] = false,
			["0x0frr2B2nSc4cf05lAbOpp"] = false,
			["0x0UEgnF3U6iVhLGhI06agg"] = false,
			["0x0iPwDjwKZijQpef6Xm2w7"] = false,
			["0x0E8GRilyeOyNHjm2z2oUE"] = false,
			["0x02ndTlhVVerFBqylB3IAm"] = false,
			["0x0k0nm5jPtXKxvUOzYzJ1H"] = false,
			["0x02qyW9z7VuRNawLxazoh8"] = false,
			["0x0jKHX2ZZTW4GJiG1RrFIU"] = false,
			["0x0p4d22QjzzFSbTl86Kbzd"] = false,
			["0x0Z2qsoc8mfB5e3CIyXfDq"] = false,
		},
		LastCall = 0,
	}
	UserData[Player.UserId].KeyData.Key = Random.new(UserData[Player.UserId].KeyData.Seed)
	--task.spawn(require(script.ServerSideDetections), Player);
	
	task.wait(7);
	
	if not UserData[Player.UserId].KeyData.Requested then
		_G.DetectedPost(Player, "Handshake timed out.", " Server Kick");
	end
	
	IrisSecureRemote.Remotes.RemoteEvent.Remote:FireClient(Player, IrisSecureRemote.DoCommunication("0x9o891xx646602wzz", math.floor(UserData[Player.UserId].KeyData.KeyCode)))
	
	task.wait(4);
	local ran = pcall(function()
		for Step, IsDone in next, UserData[Player.UserId].Steps do
			if not IsDone then
				_G.DetectedPost(Player, "Steps timed out. | "..Step, " Server Step");
			end
		end
	end)
	
	if not ran then 
		Player:Destroy();
	else
		UserData[Player.UserId].LastCall = tick();
		UserData[Player.UserId].KeyData.Ready = true	
	end
end)


--[[ Actual ISR ]] --

IrisSecureRemote = {
	DoCommunication = require(script.CommunicationHandle),
	Functions = {
		ConnectionMalfold = function(Player)
			Player:Kick("Unexpected client behaviour. 274");
		end,
		ServerError = function(Player, Message, Stack)
			warn(Message,Stack);
		end,
		ClientError = function(Player, Message, Stack, Source)
			
		end,
		["ClientInit‎"] = function(Player, ...) end,
		["ClientInit"] = function(Player)
			UserData[Player.UserId].LastCall = tick();
		end,
		StepDone = function(Player, Step)
			UserData[Player.UserId].Steps[Step[1]] = true;
		end,
		
		UpdateHandshake = function(Player, ...)
			--task.spawn(require(game.ServerScriptService.ISR.Main.ServerSideDetections.SanityCheck), Player, ...)
			UserData[Player.UserId].LastCall = tick();
			task.wait(5);
			IrisSecureRemote.Remotes.RemoteEvent.Remote:FireClient(Player, IrisSecureRemote.DoCommunication("0x9o891xx646602wzz", UserData[Player.UserId].KeyData.KeyCode))
		end,
	},
	Remotes = {
		RemoteEvent = {
			Remote = Instance.new("RemoteEvent"),
			Name = "ＲｅｍｏｔｅＥｖｅｎｔ"
		},
		RemoteFunction = {
			Remote = Instance.new("RemoteFunction"),
			Name = "ＲｅｍｏｔｅＦｕｎｃｔｉｏｎ"
		}
	},
	VerifiedScripts = {
		["​"] = true,
		["​​"] = true,
		[""] = true,
		["Framework"] = true
	}
}


for Index, Value in next, IrisSecureRemote.Remotes do
	Value.Remote.Name = Value.Name;
	Value.Remote.Parent = ReplicatedStorage.IrisSecure;
end

local function SplitString(inputstr, sep)
	sep = sep or "%s"
	return string.split(inputstr, sep)
end


local function FindLast(haystack, needle)
	local i = haystack:find(needle)
	if not i then return nil end
	return i - 1
end



IrisSecureRemote.Remotes.RemoteEvent.Remote.OnServerEvent:Connect(function(Player, ...)
	local ActualArgs = nil;
	local ScriptName = nil;		
	local FuncName = nil;	
	
	local FunctionExists = false;
	
	local DecryptedArgs = {};
	local Arguments = {...};
		
	local Success, ErrorMessage = pcall(function()
		if Arguments[1] == "ClіentInіt" then
			_G.DetectedPost(Player, Arguments[2], Arguments[3] );
			return;
		end
		
		if Arguments[1] == "0x699fa7a09c23d400" then
			if not UserData[Player.UserId].KeyData.Requested then
				IrisSecureRemote.Remotes.RemoteEvent.Remote:FireClient(Player, "0x004d32c90a7af996", UserData[Player.UserId].KeyData.Seed);
				UserData[Player.UserId].KeyData.Requested = true;
			else
				_G.DetectedPost(Player, "Key already invoked", " Server Key Invoke Check");
			end
			return;
		end
		
		for _, Value in next, Arguments do
			if typeof(Value) == "table" and not ActualArgs then
				for Index, __ in next, Value do
					if tostring(Index):find("\0\0\000\00") and tostring(Index) ~= "\0\0\000\00" then
						ActualArgs = Value
					end
				end
			elseif typeof(Value) == "string" then
				if Value:find(":%d") and Value:find("%.") and not ScriptName then
					ScriptName = Value;
				end
			end
		end
				
		if not ActualArgs then error'NoArg' end
		if not ScriptName then error'NoScript' end
		
		local TracebackTable = SplitString(ScriptName, "\n");
		local FinalTrace = TracebackTable[#TracebackTable];		
		local ScriptNameNew = (function()
			if FinalTrace:find(".") then
				return FinalTrace:sub(FindLast(FinalTrace, "%.")+1, FinalTrace:find(":")-1);
			end
			return FinalTrace;
		end)() 
	
		if not IrisSecureRemote.VerifiedScripts[ScriptNameNew] then
			_G.DetectedPost(Player, "Invalid ScriptName | "..tostring(ScriptName), " Server ScriptName Check");
			return;
		end
				
		local CommunicationKey = UserData[Player.UserId].KeyData.Key:NextNumber(1, 255);
		UserData[Player.UserId].KeyData.KeyCode = CommunicationKey;
				
		for ArgumentIndex, ArgumentValue in next, ActualArgs do
			if typeof(ArgumentIndex) == "string" then ArgumentIndex = ArgumentIndex:gsub("\0\0\000\00", "") end;
			DecryptedArgs[IrisSecureRemote.DoCommunication(ArgumentIndex, CommunicationKey)] = (function()
				if type(ArgumentValue) == "table"then
					local ArgsData = {}
					for a1,a2 in next, ArgumentValue do 
						if typeof(a2) == "table" then
							ArgsData[IrisSecureRemote.DoCommunication(a1, CommunicationKey)] = {};
							for Value, Index in next, a2 do
								ArgsData[IrisSecureRemote.DoCommunication(a1, CommunicationKey)][IrisSecureRemote.DoCommunication(Value, CommunicationKey)] = IrisSecureRemote.DoCommunication(Index, CommunicationKey);
							end
						else
							ArgsData[a1] = IrisSecureRemote.DoCommunication(a2, CommunicationKey);
						end
					end  
					return ArgsData;
				else
					IrisSecureRemote.DoCommunication(ArgumentValue, CommunicationKey);
				end
			end)() 
		end
		
		for FunctionName, Args in next, DecryptedArgs do
			FuncName = FunctionName;
			if IrisSecureRemote.Functions[FunctionName] then
				task.spawn(IrisSecureRemote.Functions[FunctionName], Player, Args);
				FunctionExists = true;
			end
		end


		if not FunctionExists then
			_G.DetectedPost(Player, "Invalid Function | "..FuncName, " Server Function Check");
			return;
		end
	end)
	
	

	if not Success then
		_G.DetectedPost(Player, "Error in communication.", " Server Error Check\n" .. "Communication Key: " .. tostring(nil) .. "\nArguments: " .. tostring(Arguments) .. "\nScriptName: " .. tostring(ScriptName) .."\n\n"..tostring(ErrorMessage));
		IrisSecureRemote.Functions.ServerError(ErrorMessage, debug.traceback())
	end
end)

task.spawn(function()
	while true do
		for UserId, Data in next, UserData do
			if Data.KeyData.Ready then
				IrisSecureRemote.Remotes.RemoteEvent.Remote:FireClient(Data.Player, IrisSecureRemote.DoCommunication("0x9o891xx646602wzz", Data.KeyData.KeyCode))
				task.spawn(function()
					if Data.LastCall == 0 and Data.KeyData.Requested then
						Data.LastCall = tick();
					elseif Data.KeyData.Requested and (tick() - Data.LastCall) > 5 and Players:FindFirstChild(Data.Player.Name) and not UserData[UserId].Kicked then
						_G.DetectedPost(Data.Player, "Handshake failed", " Server Handshake")
						UserData[UserId] = nil
					end
				end)
			end
		end
		task.wait(3);
	end
end)

for i = 1, math.random(50, 70) do
	script.FakeRemotes:FindFirstChildOfClass("RemoteEvent"):Clone().Parent = IrisSecureRemote.Remotes.RemoteEvent.Remote.Parent;
	script.FakeRemotes:FindFirstChildOfClass("RemoteFunction"):Clone().Parent = IrisSecureRemote.Remotes.RemoteFunction.Remote.Parent;
end