local Object = require "libraries/classic"
local Carrot = Object:extend()

function Carrot:new(spawnX, spawnY, width, height, game)
    self.game = game
    self.mode = "fill"
    self.x = spawnX
    self.y = spawnY - height
    self.width = width
    self.height = height
end

function Carrot:update(dt)
    self.x = self.x - self.game.speed * dt
end

function Carrot:draw()
    love.graphics.setColor(237/255, 145/255, 33/255, 1)
    love.graphics.rectangle(
        self.mode,
        self.x,
        self.y,
        self.width,
        self.height,
        15
    )
    love.graphics.setColor(1,1,1,1)
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle(
        "line",
        self.x,
        self.y,
        self.width,
        self.height,
        15)
    love.graphics.setColor(1,1,1,1)

    love.graphics.setColor(106/255, 190/255, 48/255, 1)
    love.graphics.polygon(
        "fill",
        self.x,
        self.y + self.height,
        self.x + self.width,
        self.y + self.height,
        self.x + self.width / 2,
        self.y + self.height * 3 / 4
    )
    love.graphics.setColor(1,1,1,1)

    love.graphics.setColor(0,0,0,1)
    love.graphics.polygon(
        "line",
        self.x,
        self.y + self.height,
        self.x + self.width,
        self.y + self.height,
        self.x + self.width / 2,
        self.y + self.height * 3 / 4
    )
    love.graphics.setColor(1,1,1,1)
end

return Carrot