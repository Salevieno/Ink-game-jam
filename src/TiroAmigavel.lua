TiroAmigavel = Object:extend()

function TiroAmigavel:new(initX, initY, targetX, targetY)
    self.pos = {x = initX, y = initY}
    self.size = 3

    local speedIntensity = TiroAmigavel.normalizeSpeed((targetX - initX), (targetY - initY))
    local speedMax = 1
    self.speed = {x = speedMax * (targetX - initX) / speedIntensity, y = speedMax * (targetY - initY) / speedIntensity}
end

function TiroAmigavel.normalizeSpeed(speedX, speedY)
    return math.sqrt(speedX ^ 2 + speedY ^ 2)
end

function TiroAmigavel:createShot()
    
end

-- function TiroAmigavel:calcDirection(target)
    
-- end
-- function TiroAmigavel:moveToPlayer()
    
-- end

function TiroAmigavel:isOffScreen()
    if self.pos.x <= 0 or love.graphics.getWidth() <= self.pos.x or self.pos.y <= 0 or love.graphics.getHeight() <= self.pos.y then
        return true
    end
    return false
end

function TiroAmigavel:move(target)
    self.pos.x = self.pos.x + self.speed.x
    self.pos.y = self.pos.y + self.speed.y
end

function TiroAmigavel:draw()
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end