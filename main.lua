local Entity = require("engine.entity")
local Draw = require("engine.draw")

Gs = {
	fullscreen = false,

	camera = {
		x = 0,
		y = 0,
		zoom = 4,
	},

	entities_max_size = 4096,
	entities = {},
	---@type Entity
	player = nil,
}

local player

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	-- Initializes the entities array to the max size to keep its size fixed
	Gs.entities[Gs.entities_max_size] = true
	Gs.entities[Gs.entities_max_size] = nil

	player = Entity.new()
end

---@param dt number
function love.update(dt)
	player:update(dt)

	local zoom_factor = Gs.camera.zoom * 2
	Gs.camera.x = player.position.x - love.graphics.getWidth() / zoom_factor
	Gs.camera.y = player.position.y - love.graphics.getHeight() / zoom_factor
end

function love.draw()
	love.graphics.clear({ 0.1, 0.47, 0.3, 1 })

	-- world space
	love.graphics.push()
	love.graphics.scale(Gs.camera.zoom, Gs.camera.zoom)
	love.graphics.translate(-Gs.camera.x, -Gs.camera.y)

	love.graphics.setColor({ 0.8, 0.2, 0.3, 1 })
	love.graphics.circle("fill", 35, 5, 2)
	love.graphics.setColor({ 1, 1, 1, 1 })

	player:draw()

	love.graphics.pop()

	-- screen space
	-- Draw.cross_whole_screen({ 0, 1, 0, 1 })
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
