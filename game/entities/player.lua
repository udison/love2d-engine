local Entity = require("engine.entity")

---@class Player
local Player = {}
Player.__index = Player
setmetatable(Player, { __index = Entity })

function Player.new()
	local self = Entity.new()
	self = setmetatable(self, Player)

	self.sprite = love.graphics.newImage("assets/sprites/player_base.png")
	self.sprite_width = self.sprite:getWidth()
	self.sprite_height = self.sprite:getHeight()
	self.sprite_offset = Vec2.new(16, 21)

	return self
end

---@param dt number
function Player:update(dt)
	self.motion.x = 0
	self.motion.y = 0

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

	self.position.x = self.position.x + self.motion.x * self.speed * dt
	self.position.y = self.position.y + self.motion.y * self.speed * dt
end

return Player
