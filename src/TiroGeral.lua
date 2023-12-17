TiroGeral = Tiro:extend()

function TiroGeral:new(x, y, targetX, targetY)
    TiroGeral.super.new(self, x, y, 3, 3, targetX, targetY)
end

function TiroGeral:hitPlayer(playerX, playerY, playerSize)
    return TiroGeral.super.dist(self, playerX, playerY) <= playerSize
end

function TiroGeral:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end