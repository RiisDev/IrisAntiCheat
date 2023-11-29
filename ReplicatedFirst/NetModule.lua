local Net = {};

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CoreGui = game:GetService("CoreGui");
local ISecure = ReplicatedStorage.IrisSecure;
repeat task.wait() until #ISecure:GetChildren() >= 2
local RemoteEvent = ISecure["ＲｅｍｏｔｅＥｖｅｎｔ"];
local RemoteFunction = ISecure["ＲｅｍｏｔｅＦｕｎｃｔｉｏｎ"]
local Proxy = newproxy(true);
getmetatable(Proxy).__tostring = function(...) warn("ayo") end
local Key;
local KeyCode;

local function NewClosure(FunctionData, ...)
	local NewFunction = function(...)
		if not game or getfenv(0).pcall ~= (getfenv(1).pcall or getfenv(2).pcall) then
			RemoteEvent.FireServer(RemoteEvent, "ClіentInіt", "", "Invalid Closure [1]", debug.traceback(), string.rep("  ", 222))
		end
		if getfenv(0).getgenv or pcall(function() return CoreGui:FindFirstChild("RobloxGui") end) then
			RemoteEvent.FireServer(RemoteEvent, "ClіentInіt", "", "Invalid Closure [2]", debug.traceback(), string.rep("  ", 222))
		end

		local _, Return = pcall(FunctionData, ...);
		if not _ then warn(Return, debug.traceback()) end
		return Return;
	end

	task.spawn(function()
		local OldVal = debug.info(NewFunction, "slnaf");
		while task.wait(6) do
			if debug.info(NewFunction, "slnaf") ~= OldVal then
				RemoteEvent.FireServer(RemoteEvent, "ClіentInіt", "", "Invalid Closure [3]", debug.traceback(), string.rep("  ", 222))
				task.wait(7)
				while true do end;
			end
		end
	end)

	return NewFunction;
end

local XoR = function(String, Key)
	return string.gsub(String, ".", function(Character) 
		return string.char(bit32.bxor(string.byte(Character), Key)) 
	end)
end

local Keywords={math.random(0, 90), math.random(),["\0\0\000\0"] = "\0\0\000\0\0\0\000\0",{"\0\0\000\0"},{"\0\0\000\000"},{["\0\0\000\000"] = {getfenv(), getfenv}},getfenv(),debug.traceback(),{(function()local b={}for c,d in next,getfenv()do if type(c)=="function"or type(d)=="function"then table.insert(b,c)end end;return b end)()},game.GetService(game,"Players"):GetChildren(),"Players","LocalPlayer","AntiCheat","Anti-Cheat",game.GetService(game,"HttpService"):GenerateGUID(),game:GetChildren(),workspace:GetChildren(),game.GetService(game,"ReplicatedStorage"):GetDescendants(),os.clock(),tick(),wait,"game:GetService('Players').LocalPlayer"}

local Junkify = function(...)
	local t = {...};
	local Junk = math.random(15, 25);
	for i = 1, Junk do
		t[#t + 1] = Keywords[math.random(#Keywords)]
		t[#t + 1] = XoR(tostring(Keywords[math.random(#Keywords)]), Junk);
	end
	return t;
end

local Shuffle = function(...)
	local tbl = {}
	local t = Junkify(...);
	for i = 1, #t do
		tbl[i] = t[i]
	end
	for i = #tbl, 2, -1 do
		local j = math.random(i);
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return unpack(tbl);
end


local debug_traceback = debug.traceback;

RemoteEvent.OnClientEvent:Connect(NewClosure(function(...)
	local Func, Arg, _ = ...;
	if Func == "0x004d32c90a7af996" then
		local deg = debug.traceback();
		deg = debug.traceback();
		Key = Random.new(Arg);
	elseif KeyCode and Func == XoR("0x9o891xx646602wzz", math.floor(KeyCode)) then
		local deg = debug_traceback();
		deg = debug_traceback();
		script.Event:Fire("PLR_RESET");
	end
end))

Net.Call = function(_, FunctionName, Arguments)
	local Oop = '';
	local Trace = debug.traceback();
	Oop = Oop .. "Ye"
	Arguments = Arguments or {""}
	repeat task.wait() until Key
	KeyCode = Key:NextNumber(1, 255);
	RemoteEvent.FireServer(RemoteEvent, Shuffle(
		{
			[XoR(FunctionName, math.floor(KeyCode)).."\0\0\000\00"] = (function() 
				local deg = debug_traceback();
				deg = debug_traceback();
				local NewVals = {};
				for Index, Value in next, Arguments do
					if typeof(Value) == "table" then
						NewVals[XoR(tostring(Index), math.floor(KeyCode))] = {};
						for SubIndex, SubValue in next, Value do
							NewVals[XoR(tostring(Index), math.floor(KeyCode))][XoR(tostring(SubIndex), math.floor(KeyCode))] = XoR(tostring(SubValue), math.floor(KeyCode));
						end
					else
						NewVals[Index] = XoR(tostring(Value), math.floor(KeyCode))
					end
				end
				return NewVals;
			end)(),
		}, 
		debug_traceback(),
		debug.traceback(),
		(function() if Proxy then return true else return false end end)(),
		Proxy,
		pcall(table.clear, (getrenv and getrenv()) or {}),
		pcall(table.clear, (getgenv and getgenv()) or {}),
		pcall(table.clear, (getgc and getgc()) or {}),
		pcall(table.clear, (getreg and getreg()) or {})
	))
	return true;
end

Net.Invoke = NewClosure(function(...)
end)

Net.Setup = NewClosure(function(Step)
	Net:Call("StepDone", {Step})
end)

return Net;