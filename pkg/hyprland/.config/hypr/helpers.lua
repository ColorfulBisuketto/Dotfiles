-- helper functions

function excludeRegexValues(exclude)
	local temp = {}
	for _, value in pairs(exclude) do
		temp[#temp + 1] = "(" .. value .. "){0}"
	end
	return table.concat(temp)
end
