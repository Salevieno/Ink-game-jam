Tiro = Object:extend()

function Tiro:new(initX, initY, size, speedMax, targetX, targetY)
    self.pos = {x = initX, y = initY}
    self.size = size

    local speedIntensity = Tiro.normalizeSpeed((targetX - initX), (targetY - initY))
    local speedMax = speedMax
    self.speed = {x = speedMax * (targetX - initX) / speedIntensity, y = speedMax * (targetY - initY) / speedIntensity}
end

function Tiro.normalizeSpeed(speedX, speedY)
    return math.sqrt(speedX ^ 2 + speedY ^ 2)
end

function Tiro:createShot()
    
end

-- function Tiro:calcDirection(target)
    
-- end
-- function Tiro:moveToPlayer()
    
-- end

function Tiro:isOffScreen()
    if self.pos.x <= 0 or love.graphics.getWidth() <= self.pos.x or self.pos.y <= 0 or love.graphics.getHeight() <= self.pos.y then
        return true
    end
    return false
end

function Tiro:move(target)
    self.pos.x = self.pos.x + self.speed.x
    self.pos.y = self.pos.y + self.speed.y
end

function Tiro:draw()
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end