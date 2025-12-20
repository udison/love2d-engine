---@class Vec2
---@field x number
---@field y number
local Vec2 = {
	x = 0,
	y = 0,
}
Vec2.mt = {}
Vec2.__index = Vec2

function Vec2.new(x, y)
	local v = setmetatable({}, Vec2)

	v.x = x or 0
	v.y = y or 0

	return v
end

function Vec2.__add(v1, v2)
	-- vec2 + vec2
	if getmetatable(v1) == Vec2 and getmetatable(v2) == Vec2 then
		return Vec2.new(v1.x + v2.x, v1.y + v2.y)

	-- vec2 + number
	elseif getmetatable(v1) == Vec2 and type(v2) == "number" then
		return Vec2.new(v1.x + v2, v1.y + v2)

	-- number + vec2
	elseif getmetatable(v2) == Vec2 and type(v1) == "number" then
		return Vec2.new(v2.x + v1, v2.y + v1)
	end
end

function Vec2.__mul(v1, v2)
	-- vec2 * vec2
	if getmetatable(v1) == Vec2 and getmetatable(v2) == Vec2 then
		return Vec2.new(v1.x * v2.x, v1.y * v2.y)

	-- vec2 * number
	elseif getmetatable(v1) == Vec2 and type(v2) == "number" then
		return Vec2.new(v1.x * v2, v1.y * v2)

	-- number * vec2
	elseif getmetatable(v2) == Vec2 and type(v1) == "number" then
		return Vec2.new(v2.x * v1, v2.y * v1)
	end
end

-- TODO: neither work for some reason
-- function Vec2.__call(x, y)
-- 	return Vec2.new(x, y)
-- end
-- Vec2.__call = Vec2.new

function Vec2.zero()
	return Vec2.new()
end

function Vec2.right()
	return Vec2.new(1, 0)
end

function Vec2.left()
	return Vec2.new(-1, 0)
end

function Vec2.up()
	return Vec2.new(0, -1)
end

function Vec2.down()
	return Vec2.new(0, 1)
end

--- Returns the magnitude (length) of the vector.
--- @return number The length of the vector
function Vec2:magnitude()
	return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2))
end

--- Returns a normalized copy of the vector
--- @return Vec2 The normalized vector
function Vec2:normalized()
	local mag = self:magnitude()

	if mag == 0 then
		mag = 1
	end

	return Vec2.new(self.x / mag, self.y / mag)
end

return Vec2
