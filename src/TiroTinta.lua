TiroTinta = Tiro:extend()

function TiroTinta:new(initX, initY, targetX, targetY)
    TiroTinta.super.new(self, initX, initY, 3, 3, targetX, targetY)
    Color = {1, 1, 0}
end

function TiroTinta:hitEnemy(inimigoX, inimigoY, inimigoSize)
    return TiroTinta.super.dist(self, inimigoX, inimigoY) <= inimigoSize
end

function TiroTinta:checkHitEnemy(enemies)
    -- inimigo.size = 20
    for i, inimigo in ipairs(enemies) do
        if self:hitEnemy(inimigo.x, inimigo.y, 20) then
            inimigo:inkHit(Color, 5)
            return true
        end
    end
    
    return false
end

function TiroTinta:draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end