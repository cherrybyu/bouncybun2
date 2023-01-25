local Object = require "libraries/classic"
local Button = require"gui/button"
local Game = require "game"
local Settings = require "gui/settings"
local MainMenu = Object:extend()

function MainMenu:new()
    self.game = nil
    self.settings = Settings(self)

    self.text = "BOUNCY BUN"
    self.textX = 0
    self.textY = love.graphics.getHeight() * 1 / 4
    self.textLimit =  love.graphics.getWidth()
    self.textAlign = "center"

    self.buttonTable = {}
    self.buttonList = {
        {
            text = "START GAME",
            mode = "fill",
            x = love.graphics.getWidth() * 1 / 7,
            y = love.graphics.getHeight() * 3 / 4,
            width = 275,
            height = 100,
            corner = 20,
            func = function()
                self:startGame()
            end
        },
        {
            text = "SETTINGS",
            mode = "fill",
            x = love.graphics.getWidth() * 6 / 7 - 250,
            y = love.graphics.getHeight() * 3 / 4,
            width = 275,
            height = 100,
            corner = 20,
            func = function()
                self:settingsButton()
            end
        }
    }
    self.settingsPage = false
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

    if self.settingsPage == true then
        self.settings:update()
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
    
    if self.settingsPage == true then
        self.settings:draw()
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

function MainMenu:settingsButton()
    self.settingsPage = true
end

return MainMenu