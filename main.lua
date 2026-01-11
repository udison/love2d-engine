local Utils = require("engine.utils")
local Player = require("game.entities.player")
local Chest = require("game.entities.chest")
local Vec2 = require("math.vec2")
local Draw = require("engine.draw")
local Collision = require("engine.collision")
local math_utils = require("math.math_utils")

Gs = {
	fullscreen = false,

	camera = {
		x = 0,
		y = 0,
		zoom = 4,
		smoothness = 0, -- TODO: implement camera smoothness
	},

	entities_max_size = 4096,
	entities = {},

	---@type Entity
	player = nil,
}

local player
local chest

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	-- Initializes the entities array to the max size to keep its size fixed
	Gs.entities[Gs.entities_max_size] = true
	Gs.entities[Gs.entities_max_size] = nil

	player = Player.new()
	chest = Chest.new()
	chest.position = Vec2.new(30, 30)
end

---@param dt number
function love.update(dt)
	for index, entity in ipairs(Gs.entities) do
		entity:internal_update(dt)

		if entity.update ~= nil then
			entity:update(dt)
		end
	end

	-- TODO: implement timed physics update (run at 60 fps)
	-- for index, entity in ipairs(Gs.entities) do
	-- 	entity:physics_update(dt)
	-- end

	local zoom_factor = Gs.camera.zoom * 2
	Gs.camera.x = player.position.x - love.graphics.getWidth() / zoom_factor
	Gs.camera.y = player.position.y - love.graphics.getHeight() / zoom_factor
end

function love.draw()
	love.graphics.clear({ 0.1, 0.47, 0.3, 1 })

	-- camera settings
	love.graphics.push()
	love.graphics.scale(Gs.camera.zoom, Gs.camera.zoom)
	love.graphics.translate(-Gs.camera.x, -Gs.camera.y)

	-- world space
	Draw.y_sort_entities()

	for _, entity in ipairs(Gs.entities) do
		entity:draw()
	end

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
