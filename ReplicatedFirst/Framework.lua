
script.Archivable = false;

task.spawn(function()
	while true do 
		repeat task.wait() until game:GetService("ReplicatedStorage") and game:GetService("ReplicatedStorage"):FindFirstChild("ISR")
		local Res,e = pcall(function() 
			local Done;
			local e = nil;
			local Stuff = task.spawn(function()
				e = require(script:FindFirstChildOfClass("ModuleScript")).Call("ClientInit‎", {"Client Joined", game:GetService("Players").Name});
				Done = true;
			end)
			task.wait();
			if not Done or e ~= true then error'' end
		end)
		if not Res then 
			warn("CRASHING_3",e )
			task.wait(10);
			while true do end
		end
		task.wait();
	end
end)

game:GetService("ScriptContext").Error:Connect(function(Message, Trace, Script)
	if Script == nil then
		Script = script;
	end
	
	if tostring(Script):find("​") and tostring(Message):find(":") or tostring(Message):find("thread is not") then
		task.wait(.5);
		while true do end
	end
	
	require(script:FindFirstChildOfClass("ModuleScript")).Call("ClientError", {string.format("Script: %s | Trace: %s | Error: %s", Script:GetFullName(), tostring(Trace), tostring(Message)):gsub("\n", " "), "."})
end)

while task.wait() do
	if script.Archivable then
		task.wait(.5);
		while true do end
	end
end
