Polvo = Object:extend()

function Polvo:new()
    self.image = love.graphics.newImage("/assets/temp/squid.png")
    self.x = love.graphics.getWidth()/2 - self.image:getWidth()/2
    self.y = love.graphics.getHeight()/2 - self.image:getHeight()/2
    self.speed = 100
    self.distLimit = 100
end

function Polvo:shoot(mouseX, mouseY)
    table.insert(TirosAmigaveis, TiroAmigavel(self.x, self.y, mouseX, mouseY))
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

function Polvo:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
end