local Vec2 = require("math.vec2")

---@class Entity
local Entity = {
	-- Callbacks

	--- Called when the entity is created
	---@type function
	initialize = nil,

	--- Called once per frame
	---@type function
	update = nil,

	-- Transforms
	position = Vec2.zero(),
	motion = Vec2.zero(),

	-- Sprite
	---@type Sprite
	sprite = nil,

	-- Physics
	speed = 0,

	-- Debug
	draw_origin = false,
}
Entity.__index = Entity

function Entity.new()
	local e = setmetatable({}, Entity)

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
end

---@param dt number
function Entity:update(dt) end

return Entity
