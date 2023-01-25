local Object = require "libraries/classic"
local Button = Object:extend()

function Button:new(
    buttonText,
    buttonMode,
    buttonX,
    buttonY,
    buttonWidth,
    buttonHeight,
    buttonCorner,
    buttonFunc
)
    self.text = buttonText
    self.mode = buttonMode
    self.width = buttonWidth
    self.height = buttonHeight
    self.x = buttonX
    self.y = buttonY
    self.corner = buttonCorner
    self.func = buttonFunc
    self.mouseClicked = false

    local rw,lines = font:getWrap(self.text, self.width) 
    local lineheight = font:getLineHeight() * (font:getAscent() + font:getDescent())
    local height = #lines * lineheight
    self.textY = self.height / 2 - height / 2
end

function Button:update(mouseX, mouseY)
    self:detectClick(mouseX, mouseY)
end

function Button:draw()
    self:drawButton()
end

function Button:drawButton()
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

    love.graphics.rectangle(
        "line",
        self.x,
        self.y,
        self.width,
        self.height,
        self.corner
    )

    self:drawText()
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

function Button:drawText()
    love.graphics.setColor(248/255, 132/255, 170/255, 1)
    love.graphics.printf(
        self.text,
        font,
        self.x ,
        self.y + self.textY,
        self.width,
        "center"
    )
    love.graphics.setColor(1, 1, 1, 1)
end

return Button