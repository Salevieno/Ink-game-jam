Polvo = Object:extend()

function Polvo:new()
    AmountInkShot = 10
    MaxInkStored = 30
    ScalePolvo = 0.2
    self.image = love.graphics.newImage("/assets/polvo.png")
    self.heartImage = love.graphics.newImage("/assets/heart.png")
    self.x = love.graphics.getWidth()/2
    self.y = love.graphics.getHeight()/2
    self.size = {width = ScalePolvo * self.image:getWidth(), height = ScalePolvo * self.image:getHeight()}
    self.speed = 150
    self.distLimit = 150
    self.inkStorage = MaxInkStored
    self.inkReloadTime = 0
    self.hearts = 3
end

function Polvo:refillHearts()
    self.hearts = 3
end

function Polvo:decHeart()
    if 0 < self.hearts then
        self.hearts = self.hearts - 1
    end
end

function Polvo:hasInk()
    return AmountInkShot <= self.inkStorage
end

function Polvo:reloadInk(dt)
    self.inkReloadTime = self.inkReloadTime + 10 * dt
    if 2 <= self.inkReloadTime and self.inkStorage <= MaxInkStored - 10 * dt then
        self.inkStorage = self.inkStorage + 1
        self.inkReloadTime = 0
    end
end

function Polvo:shoot(mouseX, mouseY)
    table.insert(TirosAmigaveis, TiroAmigavel(self.x, self.y, mouseX, mouseY))
end

function Polvo:shootInk(mouseX, mouseY)
    table.insert(TirosTinta, TiroTinta(self.x, self.y, mouseX, mouseY))
    self.inkStorage = self.inkStorage - AmountInkShot
end

function Polvo:move(dt)
    local old_x, old_y = self.x, self.y

    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed*dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed*dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed*dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed*dt
    end

    if self:distanceToMid(self.x, self.y) > self.distLimit then
        self.x, self.y = old_x, old_y
    end

end

function Polvo:distanceToMid(x, y)
    local mid_x, mid_y = love.graphics.getWidth()/2, love.graphics.getHeight()/2
    local horizontal_distance = mid_x - x
    local vertical_distance = mid_y - y
    local a = horizontal_distance ^2
    local b = vertical_distance ^2

    local c = a + b
    local distance = math.sqrt(c)
    return distance
end

function Polvo:drawInkStorage()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('line', 740, 580, 20, -3 * MaxInkStored)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle('fill', 740, 580, 20, -3 * self.inkStorage)
end

function Polvo:drawSafeCircle()
    love.graphics.setColor(0.3, 0.7, 0.9)
    love.graphics.arc('line', love.graphics.getWidth()/2, love.graphics.getHeight()/2, self.distLimit, 0, 360)
end

function Polvo:drawHearts()
    love.graphics.setColor(1, 1, 1)
    for i = 1, self.hearts do
        love.graphics.draw(self.heartImage, 10 + (0.05 * self.heartImage:getWidth() + 3) * (i - 1), 30, 0, 0.05, 0.05)
    end
end

function Polvo:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, self.x - self.size.width / 2, self.y - self.size.height / 2, 0, ScalePolvo, ScalePolvo)
end