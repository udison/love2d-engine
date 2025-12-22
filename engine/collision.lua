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

return Collision
