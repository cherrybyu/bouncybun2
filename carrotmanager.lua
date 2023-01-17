require "carrot"
CarrotManager = Object:extend()


function CarrotManager:new()
    self.spawnX = love.graphics.getWidth()
    self.spawnY = love.graphics.getHeight()/5*4
    self.carrotsTable = {
        {width=35, height=50},
        {width=30, height=175},
        {width=30, height=175},
        {width=40, height=200},
        {width=55, height=75},
        {width=35, height=200},
        {width=45, height=90},
        {width=50, height=160},
        {width=25, height=150},
        {width=30, height=190}
    }
    self.move = true
    self.speed = 100
    
    --creates a carrot
    self.crt = Carrot(
        self.spawnX,
        self.spawnY,
        self.carrotsTable[1].width,
        self.carrotsTable[1].height
    ) 
end

function CarrotManager:update(dt)
    if self.move then
        self.spawnX = self.spawnX - self.speed * dt
    end
end

function CarrotManager:draw()
    self.crt:draw()
end