local Object = require "libraries/classic"
local Button = require "gui/button"
local GameOverScreen = Object:extend()

function GameOverScreen:new(game)
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight()
    self.game = game

    self.buttonTable = {}
    self.buttonMode = "fill"
    self.buttonWidth = 200
    self.buttonHeight = 60
    self.buttonY = self.game.floor + self.buttonHeight / 2
    self.buttonCorner = 10
    self.buttonList = {
        {
            text = "PLAY AGAIN",
            mode = self.buttonMode,
            width = self.buttonWidth,
            height = self.buttonHeight,
            x = love.graphics.getWidth() * 1 / 7,
            y = self.buttonY,
            corner = self.buttonCorner,
            func = function()
                self:restartGame()
            end
        },
        {
            text = "MAIN MENU",
            mode = self.buttonMode,
            width = self.buttonWidth,
            height = self.buttonHeight,
            x = love.graphics.getWidth() * 6 / 7 - self.buttonWidth,
            y = self.buttonY,
            corner = self.buttonCorner,
            func = function()
                self:returnMainMenu()
            end
        }
    }
    self:spawnButtons()
end

function GameOverScreen:update()
    self.mouseX, self.mouseY = love.mouse.getPosition()

    for i = 1, #self.buttonTable do
        self.buttonTable[i]:update(self.mouseX, self.mouseY)
    end
end

function GameOverScreen:draw()
    self:drawScreen()
    for i = 1, #self.buttonTable do
        self.buttonTable[i]:draw()
    end
     self:drawText()
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
        "HIGH SCORE: "..self.game.highScore,
        font,
        0,
        love.graphics.getHeight()*2/5,
        love.graphics.getWidth(),
        "center"
    )
end

function GameOverScreen:spawnButtons()
    for i = 1, #self.buttonList do
        local btn = Button(
            self.buttonList[i].text,
            self.buttonList[i].mode,
            self.buttonList[i].x,
            self.buttonList[i].y,
            self.buttonList[i].width,
            self.buttonList[i].height,
            self.buttonList[i].corner,
            self.buttonList[i].func
        )
        table.insert(self.buttonTable, btn)
    end
    
end

function GameOverScreen:restartGame()
    self.game:new(self.game.mainMenu)
end

function GameOverScreen:returnMainMenu()
    self.game.mainMenu:new()
end

return GameOverScreen