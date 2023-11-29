--Test script, not meant to be final product

local function checkMessages(Player, logs)
	for _, Log in next, game.GetService(game, 'LogService'):GetLogHistory() do
		local Message = Log.message;
		if string.find(Message,"GetCollisionGroups") then
			_G.DetectedPost(Player, "SaveInstance", "Server Check")
		end
		for _, InvalidPrint in {'RemoteEvent', 'RemoteFunction', 'function:', "_G", 'task', 'wait', 'metatable', 'C-call', 'attempt to yield', 'error'} do
			if string.find(Message, InvalidPrint) and not string.find(Message, Player.Name) and not (string.find(Message, 'CoreScriptMemory') and string.find(Message, 'ReactFeatureFlags'))then
				_G.DetectedPost(Player, "Log Failure "..Message, "Server Check")
			end
		end
	end
end

return function(Player, ...)
	local Args = {...};Args=Args[1];
	checkMessages(Player, Args["\0\0\0\0\0\0\0\0\00\000\0"]);	
	local HumanoidRootPart = Args["HumanoidRootPart"]
	local Assemass = Vector3.new(HumanoidRootPart["AssemblyCenterMass"]);
	local LinerVeloc = Vector3.new(Args["Torso"]["AssemblyLinearVelocity"])
	
	
	if Assemass ~= Vector3.new(0,0,0) then
		_G.DetectedPost(Player, "Center Mass Failure", "Server Check")
	end
	
	if (LinerVeloc.X > 20 or LinerVeloc.Z > 20) then
		warn("Bad")
	else
		warn(LinerVeloc, Assemass)
	end
end