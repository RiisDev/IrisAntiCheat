--Test script, not meant to be final product


local PlayerData = {};
local FreeFall = Enum.HumanoidStateType.Freefall;

local function GetMagnitude(m1, m2)
	local NewVector = Vector2.new(m1.X, m1.Z);
	local NewVector2 = Vector2.new(m2.X, m2.Z);
	
	return (NewVector - NewVector2).Magnitude;
end

local function WalkSpeedDetection(Player)
	Player.Character.Humanoid.Running:Connect(function(WalkSpeed)
		if PlayerData[Player.UserId] and PlayerData[Player.UserId].CanCheck then
			if math.floor(WalkSpeed) > 18 then
				--_G.DetectedPost(Player, "WalkSpeed: "..math.floor(WalkSpeed), "Server Check")
			end
		end
	end)
end

local function ServerClientDetection(Player, Character)
	local BodyPosition = Instance.new("BodyPosition")
	local Head = Character:WaitForChild("Head", math.huge);
	BodyPosition.Name = "IS"
	BodyPosition.MaxForce = Vector3.new()
	BodyPosition.Parent = Head;
	
	BodyPosition.Changed:Connect(function()
		_G.DetectedPost(Player, "Verification Failure", "Server Check")
	end)
end

return function (Player)
	PlayerData[Player.UserId] = {}
	PlayerData[Player.UserId].CanCheck = false
	
	Player.CharacterAdded:Connect(function(Character)
		local Root = Character:WaitForChild("HumanoidRootPart", math.huge);
		local Humanoid = Character:WaitForChild("Humanoid", math.huge);
		
		Humanoid.Died:Connect(function()
			PlayerData[Player.UserId].CanCheck = false
		end)
		
		task.spawn(WalkSpeedDetection, Player);		
		task.spawn(ServerClientDetection, Player, Character);

		PlayerData[Player.UserId].CanCheck = true
	end)	
end