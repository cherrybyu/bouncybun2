Object = require "classic"
require "bunny"
require "carrotmanager"

font = love.graphics.newFont("PressStart2P-Regular.ttf", 24)
bigFont = love.graphics.newFont("PressStart2P-Regular.ttf", 42)

function love.load()
    carrotManager = CarrotManager()
end


function love.update(dt)
    carrotManager:update(dt)
end



function love.draw()
    carrotManager:draw()
end

