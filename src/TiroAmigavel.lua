TiroAmigavel = Tiro:extend()

function TiroAmigavel:new(initX, initY, targetX, targetY)
    TiroAmigavel.super.new(self, initX, initY, 3, 3, targetX, targetY)
end

function TiroAmigavel:hitEnemy(inimigoX, inimigoY, inimigoWidth, inimigoHeight)
    if self.pos.x <= inimigoX - inimigoWidth / 2 or
    inimigoX + inimigoWidth / 2 <= self.pos.x or
    self.pos.y <= inimigoY - inimigoHeight / 2 or
    inimigoY + inimigoHeight + inimigoHeight / 2 <= self.pos.y then
        return false
    end

    return true
end

function TiroAmigavel:checkHitEnemy(enemies)
    for i, inimigo in ipairs(enemies) do
        if self:hitEnemy(inimigo.x, inimigo.y, inimigo.size[1], inimigo.size[2]) then
            if inimigo.controled == false then
                table.remove(enemies, i)
                return true
            end
        end
    end
    
    return false
end

function TiroAmigavel:draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end