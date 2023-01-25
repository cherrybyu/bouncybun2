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

    bgm = love.audio.newSource("assets/bgm/bgm2.mp3", "static")
    bgm:setLooping(true)
    love.audio.setVolume(0.1)
    love.audio.play(bgm)
end

function love.update(dt)
    mainMenu:update(dt)
    --game:update(dt)
end

function love.draw()
    --game:draw()
    mainMenu:draw()
end

