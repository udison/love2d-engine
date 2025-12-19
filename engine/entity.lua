local Vec2 = require("math.vec2")

---@class Entity
local Entity = {
	-- Transforms
	position = Vec2.zero(),
	motion = Vec2.zero(),

	-- Sprite
	---@type love.Image
	sprite = nil, -- TODO: maybe refactor to a separate "Sprite" class?
	sprite_width = 0,
	sprite_height = 0,

	-- Physics
	speed = 30,

	-- Debug
	draw_origin = false,
}
Entity.__index = Entity

function Entity.new()
	local e = setmetatable({}, Entity)

	e.sprite = love.graphics.newImage("assets/sprites/player_base.png")
	e.sprite_width = e.sprite:getWidth()
	e.sprite_height = e.sprite:getHeight()

	table.insert(Gs.entities, e)
	return e
end

function Entity:draw()
	love.graphics.draw(self.sprite, self.position.x - 16, self.position.y - 21)

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
end

---@param dt number
function Entity:update(dt)
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

return Entity
