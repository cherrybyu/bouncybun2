Carrot = Object:extend()



function Carrot:new(spawnX, spawnY, width, height, speed)
    self.x = spawnX - width
    self.y = spawnY - height
    self.width = width
    self.height = height
    self.move = true
    self.speed = speed
end

function Carrot:update(dt)

end

function Carrot:draw()
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height,
        15
    )
end

function Carrot:setMove(move)
    self.move = move
end