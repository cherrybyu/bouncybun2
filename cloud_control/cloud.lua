local Object = require "libraries/classic"
local Cloud = Object:extend()

function Cloud:new(image, spawnX, speed)
    self.speed = speed

    self.image = image
    self.x = spawnX
    self.y = math.random(5, 200)
end

function Cloud:update(dt)
    self.x = self.x - self.speed * dt
end

function Cloud:draw()
    love.graphics.draw(
        self.image,
        self.x,
        self.y
    )
end

return Cloud