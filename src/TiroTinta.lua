TiroTinta = Tiro:extend()

function TiroTinta:new(initX, initY, targetX, targetY)
    ImageTiroTinta = love.graphics.newImage("/assets/mancha.png")
    TiroTinta.super.new(self, initX, initY, 3, 3, targetX, targetY)
    Color = {1, 1, 0}
end

function TiroTinta:hitEnemy(inimigoX, inimigoY, inimigoWidth, inimigoHeight)
    if self.pos.x <= inimigoX - inimigoWidth / 2 or
    inimigoX + inimigoWidth / 2 <= self.pos.x or
    self.pos.y <= inimigoY - inimigoHeight / 2 or
    inimigoY + inimigoHeight + inimigoHeight / 2 <= self.pos.y then
        return false
    end

    return true
end

function TiroTinta:checkHitEnemy(enemies)
    for i, inimigo in ipairs(enemies) do
        if self:hitEnemy(inimigo.x, inimigo.y, inimigo.size[1], inimigo.size[2]) then
            inimigo:inkHit(Color, 5)
            return true
        end
    end
    
    return false
end

function TiroTinta:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(ImageTiroTinta, self.pos.x, self.pos.y, 0, 0.2, 0.2)
    -- love.graphics.arc('fill', self.pos.x, self.pos.y, self.size, 0, 360)
end