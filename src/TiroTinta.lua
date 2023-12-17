TiroTinta = Tiro:extend()

function TiroTinta:new(initX, initY, targetX, targetY)
    TiroTinta.super.new(self, initX, initY, 3, 1, targetX, targetY)
end

function TiroTinta:draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end