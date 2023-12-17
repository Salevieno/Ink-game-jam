Polvo = Object:extend()

function Polvo:new()
    AmountInkShot = 10
    MaxInkStored = 20
    self.image = love.graphics.newImage("/assets/temp/squid.png")
    self.x = love.graphics.getWidth()/2 - self.image:getWidth()/2
    self.y = love.graphics.getHeight()/2 - self.image:getHeight()/2
    self.size = {width = self.image:getWidth(), height = self.image:getHeight()}
    self.speed = 100
    self.distLimit = 100
    self.inkStorage = MaxInkStored
    self.inkReloadTime = 0
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

function Polvo:update(dt)
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

function Polvo:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.size.width/2, self.size.height/2)
end