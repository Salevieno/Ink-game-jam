TiroAmigavel = Tiro:extend()

function TiroAmigavel:new(initX, initY, targetX, targetY)
    TiroAmigavel.super.new(self, initX, initY, 3, 1, targetX, targetY)
end

function TiroAmigavel:draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end