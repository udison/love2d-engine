local MathUtils = {}

function MathUtils.wrap_int(val, min, max)
	local range = max - min
	return (val - min) % range + min
end

return MathUtils
