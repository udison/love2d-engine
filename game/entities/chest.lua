local Entity = require("engine.entity")
local Sprite = require("engine.sprite")
local Vec2 = require("math.vec2")
local AABB = require("engine.aabb")

---@class Chest : Entity
local Chest = {}
Chest.__index = Chest
setmetatable(Chest, { __index = Entity })

function Chest.new()
	local c = Entity.new()
	c = setmetatable(c, Chest)

	c.name = "chest"
	c.sprite = Sprite.new("assets/sprites/chest.png", Vec2.new(8, 13), 32, 32)
	c.collision_enabled = true
	c.collision_shape_offset = { Vec2.new(-7, -3), Vec2.new(7, 1) }
	c.collision_shape = AABB.new()

	return c
end

return Chest
