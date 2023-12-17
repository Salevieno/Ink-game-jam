TiroAmigavel = Tiro:extend()

function TiroAmigavel:new(initX, initY, targetX, targetY)
    TiroAmigavel.super.new(self, initX, initY, 3, 3, targetX, targetY)
end

function TiroAmigavel:hitEnemy(inimigoX, inimigoY, inimigoSize)
    return TiroAmigavel.super.dist(self, inimigoX, inimigoY) <= inimigoSize
end

function TiroAmigavel:checkHitEnemy(enemies)
    -- inimigo.size = 20
    for i, inimigo in ipairs(enemies) do
        if self:hitEnemy(inimigo.x, inimigo.y, 20) and inimigo.controlled == false then
            table.remove(enemies, i)
            return true
        end
    end
    
    return false
end

function TiroAmigavel:draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end