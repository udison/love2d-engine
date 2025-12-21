local Vec2 = require("math.vec2")
local Collision = require("engine.collision")

---@class Entity A entity that exists in the game world (player, items, objects, plants, etc)
---@field name string Internal name of the entity
---@field initialize function A function called once upon entity creation
---@field update function A function called once per frame
---@field position Vec2 The entity position in world space
---@field motion Vec2 The movement input
---@field sprite Sprite The entity sprite (texture)
---@field speed number The entity speed
---@field do_collision boolean Defines whether or not the entity will be considered on physics update for collision detection
---@field collision_shape AABB The collision shape (just AABB for the time being)
---@field collision_shape_offset [Vec2, Vec2] The collision shape offset relative to the entity origin point, this is added to the entity position every physics frame in order to determine the collision shape size and position in the world.
---@field draw_origin boolean Draws the entity origin point when true
---@field draw_collision_shape boolean Draws the entity collision shape when true
---@field draw_collision_shape_color [number, number, number] The color of the collision shape debug draw (RGB)
local Entity = {}
Entity.__index = Entity

function Entity.new()
	local e = setmetatable({
		-- Metadata
		name = "entity",

		-- Callbacks
		initialize = nil,
		update = nil,

		-- Transforms
		position = Vec2.zero(),
		motion = Vec2.zero(),

		-- Sprite
		sprite = nil,

		-- Physics
		speed = 0,
		do_collision = false,
		collision_shape = nil,
		collision_shape_offset = { Vec2.zero(), Vec2.zero() },

		-- Debug
		draw_origin = false,
		draw_collision_shape = false,
		draw_collision_shape_color = { 0.3, 0.2, 1 },
	}, Entity)

	table.insert(Gs.entities, e)

	return e
end

function Entity:draw()
	if self.sprite then
		love.graphics.draw(
			self.sprite.texture,
			self.position.x - self.sprite.offset.x,
			self.position.y - self.sprite.offset.y
		)
	end

	if self.draw_origin then
		love.graphics.push()
		love.graphics.circle("fill", self.position.x, self.position.y, 0.5)
		love.graphics.setLineWidth(0.2)
		love.graphics.setColor({ 0.8, 0, 0, 1 })
		love.graphics.line({ self.position.x, self.position.y - 2, self.position.x, self.position.y + 2 })
		love.graphics.setColor({ 0, 0.8, 0, 1 })
		love.graphics.line({ self.position.x - 2, self.position.y, self.position.x + 2, self.position.y })
		love.graphics.pop()
	end

	if self.draw_collision_shape then
		local x = self.collision_shape.min.x
		local y = self.collision_shape.min.y
		local w = self.collision_shape.max.x - self.collision_shape.min.x
		local h = self.collision_shape.max.y - self.collision_shape.min.y
		local r = self.draw_collision_shape_color[1]
		local g = self.draw_collision_shape_color[2]
		local b = self.draw_collision_shape_color[3]

		love.graphics.setColor(r, g, b, 0.3)
		love.graphics.rectangle("fill", x, y, w, h)
		love.graphics.setColor(r, g, b, 0.8)
		love.graphics.setLineWidth(0.2)
		love.graphics.rectangle("line", x, y, w, h)
		love.graphics.setColor(1, 1, 1, 1)
	end
end

--- Called once per frame. Its use is exclusively to the engine and shall not be used by inherited entities.
--- Refer to the "update" function if you want to add custom behavior to an entity.
--- @param dt number
function Entity:internal_update(dt)
	-- TODO: create a "update_position" method on AABB
	self.collision_shape = self.collision_shape.new(
		self.position + self.collision_shape_offset[1],
		self.position + self.collision_shape_offset[2]
	)
end

return Entity
