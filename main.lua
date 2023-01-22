local Game = require "game"
local MainMenu = require "gui/mainmenu"

smallFont = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 20)
font = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 24)
bigFont = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 42)

cursor = love.mouse.newCursor("assets/carrotcursor.png", 0, 0)   
love.mouse.setCursor(cursor)

function love.load()
   -- game = Game()
    mainMenu = MainMenu()
end

function love.update(dt)
    mainMenu:update(dt)
    --game:update(dt)
end

function love.draw()
    --game:draw()
    mainMenu:draw()
end

