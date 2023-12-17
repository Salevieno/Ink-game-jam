TiroAmigavel = Object:extend()

function TiroAmigavel:new()
    self.pos = {x = 100 + math.random(600), y = 100 + math.random(400)}
    self.size = 3
    self.speed = {x = 3, y = 0}
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