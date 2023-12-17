Inimigo = Object:extend()

function Inimigo:new(x, y)
    self.x = x
    self.y = y
    self.speed = 100
    self.image = love.graphics.newImage("/assets/temp/enemy 64.png")
    self.y_limits = {self.y - 50, self.y + 100}
    self.dt_since_shoot = 0
end

function Inimigo:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
end

function Inimigo:update(dt, Player)
    self.dt_since_shoot = self.dt_since_shoot + dt
    self.y = self.y + self.speed*dt

    if self.y < self.y_limits[1] or self.y > self.y_limits[2] then
        self.speed = -self.speed
    end

    if self.dt_since_shoot >= 2 then
        self.dt_since_shoot = 0
        return self:shoot()
    end

    return nil
end

function Inimigo:shoot()
    return TiroGeral()
end
