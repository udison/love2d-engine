local Vec2 = require("math.vec2")

---@class Animation Represents a sprite animation in a spritesheet (row based)
---@field name string The animation name
---@field row_index number The row which the animation starts (starting at 1)
---@field length number The amount of frames in the animation
---@field fps number The frames per second of the animation
---@field loop boolean When true the animation will loop
local Animation = {
	name = "",
	row_index = 0,
	length = 0,
	fps = 0,
	loop = false,
}
Animation.__index = Animation

---@class Sprite
---@field texture? love.Image The sprite/spritesheet image
---@field width number The width of the texture
---@field height number The height of the texture
---@field cell_width number The cell width
---@field cell_height number The cell height
---@field offset Vec2 The origin offset from top-left corner
---@field animations table<string, Animation> A table with all this spritesheet animations
local Sprite = {
	texture = nil,
	width = 0,
	height = 0,
	cell_width = 0,
	cell_height = 0,
	offset = Vec2.zero(),
	animations = {},
}
Sprite.__index = Sprite

--- Creates a new sprite
---@param path string The sprite image file path
---@param offset Vec2 The origin offset from top-left corner
---@param cell_width number The cell width
---@param cell_height number The cell height
---@return Sprite
function Sprite.new(path, offset, cell_width, cell_height)
	local spr = setmetatable({}, Sprite)

	if offset == nil then
		offset = Vec2.zero()
	end

	spr.texture = love.graphics.newImage(path)
	spr.width = spr.texture:getWidth()
	spr.height = spr.texture:getHeight()
	spr.cell_width = cell_width
	spr.cell_height = cell_height
	spr.offset = offset

	return spr
end

--- Creates a new sprite animtion
---@param name string The animation name
---@param row number The row in the spritesheet where the animation is located (starts at 1)
---@param length number The amount of frames in the animation
---@param fps number? The frames per second of the animation (default is 8)
function Sprite:new_anim(name, row, length, fps)
	if fps == nil then
		fps = 8
	end

	local new_anim = setmetatable({
		name = name,
		row_index = row,
		length = length,
		fps = fps,
	}, Animation)

	self.animations[name] = new_anim
end

return Sprite
