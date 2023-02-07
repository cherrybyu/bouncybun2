local Object = require "libraries/classic"
local Cloud = require "cloud_control/cloud"
local CloudManager = Object:extend()

function CloudManager:new(game)
    self.game = game
    self.cloudTable = {}

    self.spawnTimer = 10
   
    self.cloudImages = {
        love.graphics.newImage("assets/clouds/cloud1.png"),
        love.graphics.newImage("assets/clouds/cloud2.png"),
        love.graphics.newImage("assets/clouds/cloud3.png"),
        love.graphics.newImage("assets/clouds/cloud4.png"),
        love.graphics.newImage("assets/clouds/cloud5.png"),
        love.graphics.newImage("assets/clouds/cloud6.png")
    }

    self.spawnX = love.graphics.getWidth()
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