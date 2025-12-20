local Draw = {}

--- Draws a cross on the whole screen... pretty self-explanatory huh.
--- If a color is provided, it will be set to white at the end of the function.
--- @param color table? A table of four values RGBA from 0 to 1
function Draw.cross_whole_screen(color)
	if color ~= nil then
		love.graphics.setColor(color)
	end

	local x1 = love.graphics.getWidth() / 2
	local y1 = 0
	local x2 = love.graphics.getWidth() / 2
	local y2 = love.graphics.getHeight()
	love.graphics.line(x1, y1, x2, y2)

	x1 = 0
	y1 = love.graphics.getHeight() / 2
	x2 = love.graphics.getWidth()
	y2 = love.graphics.getHeight() / 2
	love.graphics.line(x1, y1, x2, y2)

	if color ~= nil then
		love.graphics.setColor({ 1, 1, 1, 1 })
	end
end

return Draw
