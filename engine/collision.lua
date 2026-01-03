local Vec2 = require("math.vec2")

local Collision = {}
Collision.__index = Collision

--- Checks for a collision between two AABBs
--- @param a AABB
--- @param b AABB
--- @return boolean
function Collision.aabb_to_aabb(a, b)
	-- TODO: this is a simple implementation of aabb to aabb collision detection
	-- there are some cool features that can be implemented as necessity arises like:
	-- [ ] collision resolution: computes a "minimum translation vector" to separate both objects
	-- [ ] swept aabb: a continuous collision detection that prevents some problems with high velocity objects
	return a.min.x < b.max.x and a.max.x > b.min.x and a.min.y < b.max.y and a.max.y > b.min.y
end

--- Returns a the negative overlap vector to push the colliding entity away
--- @param a AABB
--- @param b AABB
--- @return Vec2
function Collision.aabb_resolve(a, b)
	local ax1, ay1 = a.min.x, a.min.y
	local ax2, ay2 = a.max.x, a.max.y
	local bx1, by1 = b.min.x, b.min.y
	local bx2, by2 = b.max.x, b.max.y
	local overlapX1 = ax2 - bx1
	local overlapX2 = bx2 - ax1
	local overlapY1 = ay2 - by1
	local overlapY2 = by2 - ay1
	local minX = math.min(overlapX1, overlapX2)
	local minY = math.min(overlapY1, overlapY2)
	if minX < minY then
		-- push horizontally
		if overlapX1 < overlapX2 then
			return Vec2.new(-overlapX1, 0)
		else
			return Vec2.new(overlapX2, 0)
		end
	else
		-- push vertically
		if overlapY1 < overlapY2 then
			return Vec2.new(0, -overlapY1)
		else
			return Vec2.new(0, overlapY2)
		end
	end
end

return Collision
