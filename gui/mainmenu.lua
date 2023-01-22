local Object = require "libraries/classic"
local Button = require"gui/button"
local Game = require "game"
local MainMenu = Object:extend()

function MainMenu:new()
    self.game = nil
    self.text = "BOUNCY BUN"
    self.textX = 0
    self.textY = love.graphics.getHeight() * 1 / 4
    self.textLimit =  love.graphics.getWidth()
    self.textAlign = "center"

    self.buttonTable = {}
    -- self.buttonMode = "fill"
    -- self.buttonWidth = 200
    -- self.buttonHeight = 60
    -- self.buttonY = self.floor + self.buttonHeight / 2
    -- self.buttonCorner = 10

    self.buttonList = {
        {
            text = "START GAME",
            mode = "fill",
            x = 0,
            y = 0,
            width = 200,
            height = 100,
            corner = 20,
            func = function()
                self:startGame()
            end
        }
    }
    self:spawnButtons()
end

function MainMenu:update(dt)
    if self.game == nil then
        love.mouse.setVisible(true)
        self.mouseX, self.mouseY = love.mouse.getPosition()

        for i = 1, #self.buttonTable do
            self.buttonTable[i]:update(self.mouseX, self.mouseY)
        end
    else
        self.game:update(dt)
    end
end

function MainMenu:draw()
    love.graphics.setBackgroundColor(135/255, 206/255, 235/255, 1)
    if self.game == nil then
        self:printTitle()

        for i = 1, #self.buttonTable do
            self.buttonTable[i]:draw()
        end
    else
        self.game:draw()
    end
end

function MainMenu:printTitle()
    love.graphics.printf(
        self.text,
        bigFont,
        self.textX,
        self.textY,
        self.textLimit,
        self.textAlign
    )
end

function MainMenu:spawnButtons()
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

function MainMenu:startGame()
    self.game = Game(self)
end

return MainMenu