---@class Sprite
local Sprite = {
	---@type love.Image
	texture = nil,
	width = 0,
	height = 0,
	offset = Vec2.zero(),
}
Sprite.__index = Sprite

function Sprite.new(path, offset)
	local spr = setmetatable({}, Sprite)

	if offset == nil then
		offset = Vec2.zero()
	end

	spr.texture = love.graphics.newImage(path)
	spr.width = spr.texture:getWidth()
	spr.height = spr.texture:getHeight()
	spr.offset = offset

	return spr
end

return Sprite
