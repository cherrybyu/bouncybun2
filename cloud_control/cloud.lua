local Object = require "libraries/classic"
local Cloud = Object:extend()

function Cloud:new(image, spawnX, orientation, speed)
    self.speed = speed

    self.image = image
    self.x = spawnX
    self.y = math.random(5, 200)
    self.orientation = orientation
    self.scale = math.random(0.7, 0.85)
end

function Cloud:update(dt)
    self.x = self.x - self.speed * dt
end

function Cloud:draw()
    love.graphics.draw(
        self.image,
        self.x,
        self.y,
        self.orientation,
        self.scale
    )
end

return Cloud