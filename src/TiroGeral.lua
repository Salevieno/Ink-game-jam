TiroGeral = Tiro:extend()

function TiroGeral:new(x, y, targetX, targetY)
    TiroAmigavel.super.new(self, x, y, 3, 1, targetX, targetY)
end

function TiroGeral:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end