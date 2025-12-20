local Entity = require("engine.entity")
local Sprite = require("engine.sprite")
local Vec2 = require("math.vec2")

---@class Chest
local Chest = {}
Chest.__index = Chest
setmetatable(Chest, { __index = Entity })

function Chest.new()
	local c = Entity.new()

	c.sprite = Sprite.new("assets/sprites/chest.png", Vec2.new())

	return c
end

return Chest
