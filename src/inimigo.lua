Inimigo = Object:extend()

function Inimigo:new(x, y)
    self.x = x
    self.y = y
    self.speed = 100
    self.image = love.graphics.newImage("/assets/temp/enemy 64.png")
    self.y_limits = {self.y - 50, self.y + 100}
end

function Inimigo:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
end

function Inimigo:update(dt)
    self.y = self.y + self.speed*dt

    if self.y < self.y_limits[1] or self.y > self.y_limits[2] then
        self.speed = -self.speed
    end
end