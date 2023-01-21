local Object = require "libraries/classic"
local Button = require"gui/button"
local GameOverScreen = Object:extend()

function GameOverScreen:new(highScore, floor)
    self.highScore = highScore
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight()
    self.floor = floor

    self.buttonTable = {}
    self.buttonMode = "fill"
    self.buttonWidth = 200
    self.buttonHeight = 60
    self.buttonY = self.floor + self.buttonHeight / 2
    self.buttonCorner = 10

    self.buttonList = {
        {
            mode = self.buttonMode,
            width = self.buttonWidth,
            height = self.buttonHeight,
            x = love.graphics.getWidth() * 1 / 7,
            y = self.buttonY,
            corner = self.buttonCorner,
            func = function()
                self:printDav()
            end
        },
        --{love.graphics.getWidth() * 6 / 7 - self.buttonWidth}
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
    self:drawText()
    for i = 1, #self.buttonTable do
        self.buttonTable[i]:draw()
    end
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

function GameOverScreen:spawnButtons()
    for i = 1, #self.buttonList do
        local btn = Button(
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

function GameOverScreen:printDav()
    print("david")
end

return GameOverScreen