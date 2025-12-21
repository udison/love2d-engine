local Vec2 = require("math.vec2")

--- @class AABB Defines an axis-aligned bounding box (AABB) used for collision detection
--- @field min Vec2 The top-left point of the bounding box
--- @field max Vec2 The bottom-right point of the bounding box
--- @field points [Vec2, Vec2, Vec2, Vec2] A array of 4 positions with every point of the bounding box, starting at the top-left and ending on the bottom-left clockwise
local AABB = {}
AABB.__index = AABB

--- Creates a new bounding box by providing its top-left (min) and bottom-right (max) points
--- @param min? Vec2 The top-left point of the bounding box
--- @param max? Vec2 The bottom-right point of the bounding box
function AABB.new(min, max)
	if min == nil then
		min = Vec2.zero()
	end

	if max == nil then
		max = Vec2.zero()
	end

	local bb = setmetatable({
		min = min,
		max = max,
		points = {
			min, -- top-left
			Vec2.new(max.x, min.y), -- top-right
			max, -- bottom-right
			Vec2.new(min.x, max.y), -- bottom-left
		},
	}, AABB)

	return bb
end

return AABB
