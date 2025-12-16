GameState = {
	fullscreen = false,
}

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
end

---@param dt number
function love.update(dt) end

function love.draw() end

---@param key string
function love.keypressed(key)
	print(key)

	if key == "escape" then
		love.event.quit()
	elseif key == "f11" then
		GameState.fullscreen = not GameState.fullscreen
		love.window.setFullscreen(GameState.fullscreen)
	end
end
