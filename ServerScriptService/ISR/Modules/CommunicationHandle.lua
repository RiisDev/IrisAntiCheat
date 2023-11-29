return function (String, Key)
	return string.gsub(String, ".", function(Character) 
		return string.char(bit32.bxor(string.byte(Character), Key)) 
	end)
end