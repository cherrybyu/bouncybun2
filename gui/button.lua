local Object = require "libraries/classic"
local Button = Object:extend()

function Button:new(
    buttonMode,
    buttonX,
    buttonY,
    buttonWidth,
    buttonHeight,
    buttonCorner,
    buttonFunc
)
    self.mode = buttonMode
    self.width = buttonWidth
    self.height = buttonHeight
    self.x = buttonX
    self.y = buttonY
    self.corner = buttonCorner
    self.func = buttonFunc
    self.mouseClicked = false
end

function Button:update(mouseX, mouseY)
    self:detectClick(mouseX, mouseY)
end

function Button:draw()
    self:drawButton()
end

function Button:drawButton()
    love.graphics.setColor(237/255, 145/255, 33/255, 1)
    love.graphics.rectangle(
        self.mode,
        self.x,
        self.y,
        self.width,
        self.height,
        self.corner
    )
    love.graphics.setColor(237/255, 145/255, 33/255, 1)
end

function Button:detectClick(mouseX, mouseY)
    local buttonTop = self.y
    local buttonBottom = self.y + self.height
    local buttonLeft = self.x
    local buttonRight = self.x + self.width

    if love.mouse.isDown(1)
        and self.mouseClicked == false
        and mouseX >= buttonLeft
        and mouseX <= buttonRight
        and mouseY >= buttonTop
        and mouseY <= buttonBottom
    then
        self.mouseClicked = true
        self.func()
    end

    if love.mouse.isDown(1) == false then
        self.mouseClicked = false
    end

end

return Button