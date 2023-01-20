local Object = require "libraries/classic"
local GameOverScreen = Object:extend()

function GameOverScreen:new(highScore, floor)
    self.highScore = highScore
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight()
    self.floor = floor

    self.buttonMode = "fill"
    self.buttonWidth = 200
    self.buttonHeight = 60
    self.buttonY = self.floor + self.buttonHeight / 2

    self.button1x = love.graphics.getWidth() * 1 / 7
    self.button2x = love.graphics.getWidth() * 6 / 7 - self.buttonWidth
end

function GameOverScreen:update()
    self.mouseX, self.mouseY = love.mouse.getPosition()

    local buttonTop = self.buttonY
    local buttonBottom = self.buttonY + self.buttonHeight

    local button1Left = self.button1x
    local button1Right = self.button1x + self.buttonWidth

    local button2Left = self.button2x
    local button2Right = self.button2x + self.buttonWidth

    if love.mouse.isDown(1)
        and self.mouseX >= button1Left
        and self.mouseX <= button1Right
        and self.mouseY >= buttonTop
        and self.mouseY <= buttonBottom
    then
        print(":3")
    end

    if love.mouse.isDown(1)
        and self.mouseX >= button2Left
        and self.mouseX <= button2Right
        and self.mouseY >= buttonTop
        and self.mouseY <= buttonBottom
    then
        print(":0")
    end
end

function GameOverScreen:draw()
    self:drawScreen()
    self:drawText()
    self:drawButtons()
end

function GameOverScreen:drawScreen()
    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle(
        "fill",
        0,
        0,
        love.graphics.getWidth(),
        love.graphics.getHeight()
    )
    love.graphics.setColor(1, 1, 1, 1)
end

function GameOverScreen:drawText()
    love.graphics.printf(
        "GAME OVER",
        bigFont,
        0,
        love.graphics.getHeight()/5,
        love.graphics.getWidth(),
        "center"
    )
    love.graphics.printf(
        "HIGH SCORE: "..self.highScore,
        font,
        0,
        love.graphics.getHeight()*2/5,
        love.graphics.getWidth(),
        "center"
    )
end

function GameOverScreen:drawButtons()
    love.graphics.setColor(237/255, 145/255, 33/255, 1)
    love.graphics.rectangle(
        self.buttonMode,
        self.button1x,
        self.buttonY,
        self.buttonWidth,
        self.buttonHeight,
        10
    )
    love.graphics.rectangle(
        self.buttonMode,
        self.button2x,
        self.buttonY,
        self.buttonWidth,
        self.buttonHeight,
        10
    )
    love.graphics.setColor(237/255, 145/255, 33/255, 1)
end

return GameOverScreen