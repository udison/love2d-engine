local Collision = {}
Collision.__index = Collision

--- Checks for a collision between two AABBs
--- @param bb1 AABB
--- @param bb2 AABB
--- @return boolean
function Collision.aabb_to_aabb(bb1, bb2)
	-- TODO: this is a simple implementation of aabb to aabb collision detection
	-- there are some cool features that can be implemented as necessity arises like:
	-- [ ] collision resolution: computes a "minimum translation vector" to separate both objects
	-- [ ] swept aabb: a continuous collision detection that prevents some problems with high velocity objects
	return bb1.min.x < bb2.max.x
end

return Collision
