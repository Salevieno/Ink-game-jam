TiroGeral = Tiro:extend()

function TiroGeral:new(x, y, targetX, targetY)
    TiroGeral.super.new(self, x, y, 3, 2, targetX, targetY)
end

function TiroGeral:hitPlayer(playerX, playerY, playerSize)
    if self.pos.x <= playerX - playerSize.width / 2 or
    playerX + playerSize.width / 2 <= self.pos.x or
    self.pos.y <= playerY - playerSize.height / 2 or
    playerY + playerSize.height + playerSize.height / 2 <= self.pos.y then
        return false
    end

    return true
end

function TiroGeral:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end