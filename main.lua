local Game = require "game"

font = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 24)
bigFont = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 42)

function love.load()
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end

