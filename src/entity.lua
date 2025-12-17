local Entity = {
	-- Transforms
	x = 0,
	y = 0,
	motion = { 0, 0 }, -- TODO: implement a vec2

	-- Sprite
	sprite = nil, -- TODO: maybe refactor to a separate "Sprite" class?
	sprite_width = 0,
	sprite_height = 0,

	-- Physics
	speed = 15,
}
Entity.__index = Entity

function Entity.new()
	local e = setmetatable({}, Entity)

	e.sprite = love.graphics.newImage("assets/sprites/player_base.png")
	e.sprite_width = e.sprite:getWidth()
	e.sprite_height = e.sprite:getHeight()

	return e
end

function Entity:draw()
	love.graphics.draw(self.sprite, self.x - 16, self.y - 21)
end

---@param dt number
function Entity:update(dt)
	self.motion = { 0, 0 }
	if love.keyboard.isDown("a") then
		self.motion[1] = -1
	elseif love.keyboard.isDown("d") then
		self.motion[1] = 1
	end

	if love.keyboard.isDown("w") then
		self.motion[2] = -1
	elseif love.keyboard.isDown("s") then
		self.motion[2] = 1
	end

	self.x = self.x + self.motion[1] * self.speed * dt
	self.y = self.y + self.motion[2] * self.speed * dt
end

return Entity
