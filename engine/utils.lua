local Utils = {}
Utils.__index = Utils

function Utils.print_table(t, indent)
	indent = indent or ""
	for k, v in pairs(t) do
		local valueType = type(v)
		if valueType == "table" then
			print(indent .. k .. ": {")
			Utils.print_table(v, indent .. "  ") -- Recurse with increased indentation
			print(indent .. "}")
		else
			print(indent .. k .. ": " .. tostring(v))
		end
	end
end

return Utils
