local Object = require "libraries/classic"
local Carrot = Object:extend()

function Carrot:new(spawnX, spawnY, width, height, game)
    self.game = game
    self.mode = "line"
    self.x = spawnX
    self.y = spawnY - height
    self.width = width
    self.height = height
end

function Carrot:update(dt)
    self.x = self.x - self.game.speed * dt
end

function Carrot:draw()
    love.graphics.rectangle(
        self.mode,
        self.x,
        self.y,
        self.width,
        self.height,
        15
    )
end

return Carrot