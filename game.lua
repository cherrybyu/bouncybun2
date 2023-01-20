local Object = require "libraries/classic"
local Bunny = require "bunny"
local CarrotManager = require "carrotmanager"
local GameOverScreen = require "menus/gameoverscreen"
local Game = Object:extend()

Game.floor = love.graphics.getHeight()/5*4

function Game:new()
    self.carrotManager = CarrotManager(self)
    self.bunny = Bunny(self)
    
    self.gameOver = false
    
    self.speed = 100 
    self.spawnTimer = 5
    self.spawnFrequency = (100/self.speed)*5

    self.addScore = false
    self.score = 0
    self.highScore = 0

    if love.filesystem.getInfo("highScoreFile.txt") ~= nil then
        content, size = love.filesystem.read("highScoreFile.txt")
        self.highScore = tonumber(content)
    end

    self.gameOverScreen = GameOverScreen(self.highScore, self.floor)

    self.cursor = love.mouse.newCursor("assets/carrotcursor.png", 0, 0)   
    love.mouse.setCursor(self.cursor)
end

function Game:update(dt)
    if self.gameOver == false then
        self.carrotManager:update(dt)
        self:handleAddScore()
    end

    love.mouse.setVisible(self.gameOver)

    self.bunny:update(dt)
    self.gameOver = self:checkCollision()

    if self.gameOver then
        self.spawnTimer = 0
        self:saveHighScore()
        self.gameOverScreen:update()
    end

    self:handleSpawnTimer(dt)
end

function Game:draw()
    love.graphics.setBackgroundColor(135/255, 206/255, 235/255, 1)
    self:drawFloor()
    self.carrotManager:draw()
    self.bunny:draw()

    local score_y = love.graphics.getHeight()/25
    love.graphics.printf(
        self.score,
        font,
        -love.graphics.getWidth()/25,
        score_y,
        love.graphics.getWidth(),
        "right"
    )

    if self.gameOver then
        self.gameOverScreen:draw()
    end

end

function Game:checkCollision()
    local bunnyLeft = self.bunny.x
    local bunnyRight = self.bunny.x + self.bunny.width
    local bunnyTop = self.bunny.y
    local bunnyBottom = self.bunny.y + self.bunny.height

    for i=1, #self.carrotManager.carrotTable do
        local carrotLeft = self.carrotManager.carrotTable[i].x
        local carrotRight = self.carrotManager.carrotTable[i].x + self.carrotManager.carrotTable[i].width
        local carrotTop = self.carrotManager.carrotTable[i].y
        local carrotBottom = self.carrotManager.carrotTable[i].y + self.carrotManager.carrotTable[i].height

        --early returns when bunny collides with carrot
        if bunnyRight > carrotLeft
            and bunnyLeft < carrotRight
            and bunnyBottom > carrotTop
            and bunnyTop < carrotBottom then
            return true
        end

        --otherwise early returns if this carrot is the first carrot to the 
        --right of bunny
        if carrotLeft > bunnyRight then
            return false
        end
    end

    return false
end

function Game:handleSpawnTimer(dt)
    if self.spawnTimer >= self.spawnFrequency then
        self.spawnTimer = 0
        self.carrotManager:spawnCarrot()
    end
    
    self.spawnTimer = self.spawnTimer + dt
    self.speed = math.min(self.speed + 2 * dt, 350)
    self.spawnFrequency = (100/self.speed)*5
end

function Game:saveHighScore()
    if self.score > self.highScore then
        self.highScore = self.score
        if love.filesystem.getInfo("highScoreFile.txt") == nil then
            love.filesystem.newFile("highScoreFile.txt")
            love.filesystem.write("highScoreFile.txt", tostring(self.highScore))
        else 
            love.filesystem.write("highScoreFile.txt", tostring(self.highScore))
        end
    end
end

function Game:handleAddScore()
    for i = 1, #self.carrotManager.carrotTable do
        local bunnyLeft = self.bunny.x
        local bunnyRight = self.bunny.x + self.bunny.width
        local carrotRight = self.carrotManager.carrotTable[i].x + self.carrotManager.carrotTable[i].width
        if bunnyLeft <= carrotRight and bunnyRight >= carrotRight then
            self.addScore = true
        end
        if bunnyLeft > carrotRight and self.addScore then
            self.score = self.score + 1
            self.addScore = false
        end
    end
end

function Game:drawFloor()
    love.graphics.setColor(72/255, 111/255, 56/255, 1)
    love.graphics.rectangle(
        "fill",
        0,
        self.floor,
        love.graphics.getWidth(),
        self.floor
    )
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(
        0,
        self.floor,
        love.graphics.getWidth(),
        self.floor
    )
    love.graphics.setColor(1, 1, 1, 1)
end

return Game