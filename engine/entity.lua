local Vec2 = require("math.vec2")
local Collision = require("engine.collision")
local MathUtils = require("math.math_utils")

---@class Entity A entity that exists in the game world (player, items, objects, plants, etc)
---@field name string Internal name of the entity
---@field initialize function A function called once upon entity creation
---@field update function A function called once per frame
---@field position Vec2 The entity position in world space
---@field motion Vec2 The movement input
---@field sprite Sprite The entity sprite (texture)
---@field speed number The entity speed
---@field collision_enabled boolean Defines whether or not the entity will be considered on physics update for collision detection
---@field collision_static boolean When true, this object stops detecting collisions, leaving the work only for the entities that move
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
		collision_enabled = false,
		collision_static = true,
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
		local sprite_row = self.sprite.current_animation and self.sprite.current_animation.row_index - 1 or 0
		local sprite_idx = self.sprite.current_animation and self.sprite.frame - 1 or 0
		local quad = love.graphics.newQuad(
			sprite_idx * self.sprite.cell_width,
			sprite_row * self.sprite.cell_height,
			self.sprite.cell_width,
			self.sprite.cell_height,
			self.sprite.texture
		)

		love.graphics.draw(
			self.sprite.texture,
			quad,
			self.position.x,
			self.position.y,
			0,
			1,
			1,
			self.sprite.offset.x,
			self.sprite.offset.y
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
	self:update_collision()
	self.sprite:handle_animation(dt)
end

function Entity:update_collision(position)
	if position == nil then
		position = self.position
	end

	-- TODO: create a "update_position" method on AABB
	self.collision_shape =
		self.collision_shape.new(position + self.collision_shape_offset[1], position + self.collision_shape_offset[2])
end

function Entity:move_and_collide(dt)
	local target_position = self.position + self.motion * self.speed * dt
	self:update_collision()

	local intersection = false
	local push_vector = Vec2.zero()
	for i, entity in ipairs(Gs.entities) do
		if not entity.collision_enabled or entity == self then
			goto continue
		end

		intersection = Collision.aabb_to_aabb(self.collision_shape, entity.collision_shape)

		if intersection then
			push_vector = Collision.aabb_resolve(self.collision_shape, entity.collision_shape)
			break
		end

		::continue::
	end

	if intersection then
		self.position = target_position + push_vector
	else
		self.position = target_position
	end
end

return Entity
