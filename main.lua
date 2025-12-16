local Entity = require("src.entity")

GameState = {
	fullscreen = false,
}

local player

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	print(Entity)

	player = Entity.new()
end

---@param dt number
function love.update(dt)
	player:update(dt)
end

function love.draw()
	player:draw()
end

---@param key string
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "f11" then
		GameState.fullscreen = not GameState.fullscreen
		love.window.setFullscreen(GameState.fullscreen)
	end
end
