local Object = require "libraries/classic"
local Cloud = require "cloud_control/cloud"
local CloudManager = Object:extend()

function CloudManager:new(game)
    self.game = game
    self.cloudTable = {}

    self.spawnTimer = 10
   
    self.cloud1 = love.graphics.newImage("assets/clouds/cloud1.png")
    self.cloud2 = love.graphics.newImage("assets/clouds/cloud2.png")
    self.cloud3 = love.graphics.newImage("assets/clouds/cloud3.png")
    self.cloud4 = love.graphics.newImage("assets/clouds/cloud4.png")
    self.cloud5 = love.graphics.newImage("assets/clouds/cloud5.png")
    self.cloud6 = love.graphics.newImage("assets/clouds/cloud6.png")

    self.cloudImages = {
        self.cloud1,
        self.cloud2,
        self.cloud3,
        self.cloud4,
        self.cloud5,
        self.cloud6
    }

    self.spawnX = love.graphics.getWidth()
    self.orientation = 0
end

function CloudManager:update(dt)
    self.speed = math.random(75,100)
    self.spawnFrequency = math.random(5,10)

    self:handleCloudTimer(dt)

    for i = 1, #self.cloudTable do
        self.cloudTable[i]:update(dt)
    end
    self:cloudDespawn()
end

function CloudManager:draw()
    for i = 1, #self.cloudTable do
        self.cloudTable[i]:draw()
    end
end

function CloudManager:spawnCloud()
    local cloudIndex = math.random(1, #self.cloudImages)
    local cld = Cloud(
        self.cloudImages[cloudIndex],
        self.spawnX,
        self.orientation,
        self.speed
    )
    table.insert(self.cloudTable, cld)
end

function CloudManager:cloudDespawn()
    if #self.cloudTable >= 5 then
        table.remove(self.cloudTable, 1)
    end
end

function CloudManager:handleCloudTimer(dt)
    if self.spawnTimer >= self.spawnFrequency then
        self.spawnTimer = 0
        self:spawnCloud()
    end
    self.spawnTimer = self.spawnTimer + dt
end

return CloudManager