local Entity = require("src.entity")
local Draw = require("src.draw")

Gs = {
	fullscreen = false,

	camera = {
		x = 0,
		y = 0,
	},
}

local player

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	player = Entity.new()
end

---@param dt number
function love.update(dt)
	player:update(dt)

	Gs.camera.x = player.x - love.graphics.getWidth() / 8
	Gs.camera.y = player.y - love.graphics.getHeight() / 8
end

function love.draw()
	-- world space
	love.graphics.push()
	love.graphics.scale(4, 4) -- camera zoom
	love.graphics.translate(-Gs.camera.x, -Gs.camera.y)

	player:draw()

	love.graphics.pop()

	-- screen space
	-- Draw.cross_whole_screen({ 0, 128, 0, 255 })
end

---@param key string
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "f11" then
		Gs.fullscreen = not Gs.fullscreen
		love.window.setFullscreen(Gs.fullscreen)
	end
end
