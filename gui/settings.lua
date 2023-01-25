local Object = require "libraries/classic"
local Button = require"gui/button"
local Settings = Object:extend()

function Settings:new(mainMenu)
    self.mainMenu = mainMenu

    self.mode = "fill"
    self.x = 15
    self.y = 15
    self.width = love.graphics.getWidth() - self.x * 2
    self.height = love.graphics.getHeight() - self.y * 2
    self.corner = 50

    self.buttonTable = {}
    self.buttonList = {
        {
            text = "BACK TO MENU",
            mode = "fill",
            x = love.graphics.getWidth() / 2 - 350/2,
            y = love.graphics.getHeight() * 3 / 5,
            width = 350,
            height = 100,
            corner = 30,
            func = function()
                self:returnToMenu()
            end
        }
    }

    self:spawnButtons()
end

function Settings:update(dt)
    love.mouse.setVisible(true)
    self.mouseX, self.mouseY = love.mouse.getPosition()

    for i = 1, #self.buttonTable do
        self.buttonTable[i]:update(self.mouseX, self.mouseY)
    end
end

function Settings:draw()
    love.graphics.setColor(252/255, 204/255, 220/255, 1)
    love.graphics.rectangle(
        self.mode,
        self.x,
        self.y,
        self.width,
        self.height,
        self.corner
    )
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle(
        "line",
        self.x,
        self.y,
        self.width,
        self.height,
        self.corner
    )
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.printf(
        "COMING SOON ...",
        bigFont,
        15,
        love.graphics.getHeight() * 1 / 3,
        love.graphics.getWidth() - 15 * 2,
        "center"
    )

    for i = 1, #self.buttonTable do
        self.buttonTable[i]:draw()
    end
end

function Settings:spawnButtons()
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

function Settings:returnToMenu()
    self.mainMenu.settingsPage = false
end

return Settings