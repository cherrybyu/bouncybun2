local Object = require "libraries/classic"
local Carrot = require "carrot_control/carrot"
local CarrotManager = Object:extend()

function CarrotManager:new(game)
    self.game = game
    self.carrotTable = {}
    self.spawnX = love.graphics.getWidth()
    self.spawnY = game.floor
    self.carrotTemplates = {
        {width = 35, height = 50},
        {width = 30, height = 175},
        {width = 30, height = 175},
        {width = 40, height = 200},
        {width = 55, height = 75},
        {width = 35, height = 200},
        {width = 45, height = 90},
        {width = 50, height = 160},
        {width = 25, height = 150},
        {width = 30, height = 190}
    }
end

function CarrotManager:update(dt)
    for i = 1, #self.carrotTable do
        self.carrotTable[i]:update(dt)
    end
    self:carrotDespawn()
end

function CarrotManager:draw()
    for i = 1, #self.carrotTable do
        self.carrotTable[i]:draw()
    end
end

function CarrotManager:spawnCarrot()
    local carrotIndex = math.random(1, #self.carrotTemplates)
    local crt = Carrot(
        self.spawnX,
        self.spawnY,
        self.carrotTemplates[carrotIndex].width,
        self.carrotTemplates[carrotIndex].height,
        self.game
    )
    table.insert(self.carrotTable, crt)
end

function CarrotManager:carrotDespawn()
    if #self.carrotTable > 0 and self.carrotTable[1].x <= -self.carrotTable[1].width then
        table.remove(self.carrotTable, 1)
    end
end

return CarrotManager