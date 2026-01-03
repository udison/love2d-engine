local Entity = require("engine.entity")
local Utils = require("engine.utils")
local Sprite = require("engine.sprite")
local Vec2 = require("math.vec2")
local AABB = require("engine.aabb")

---@class Player : Entity
local Player = {}
Player.__index = Player
setmetatable(Player, { __index = Entity })

function Player.new()
	local self = Entity.new()
	self = setmetatable(self, Player)

	self.name = "player"
	self.sprite = Sprite.new("assets/sprites/player_base.png", Vec2.new(16, 21))
	self.speed = 30

	self.collision_enabled = true
	self.collision_static = false
	self.collision_shape_offset = {
		Vec2.new(-3, -1),
		Vec2.new(2, 1),
	}
	self.collision_shape = AABB.new()
	self.draw_collision_shape = true

	return self
end

---@param dt number
function Player:update(dt)
	self.motion.x = 0
	self.motion.y = 0

	-- TODO: remove one of the 'nice' on the comment below
	-- TODO: a nice action-based input system would be nice
	if love.keyboard.isDown("a") then
		self.motion.x = -1
	elseif love.keyboard.isDown("d") then
		self.motion.x = 1
	end

	if love.keyboard.isDown("w") then
		self.motion.y = -1
	elseif love.keyboard.isDown("s") then
		self.motion.y = 1
	end

	self.motion = self.motion:normalized()

	self:move_and_collide(dt)
end

return Player
