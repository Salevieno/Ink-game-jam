Botao = Object:extend()

function Botao:new(initX, initY, name)
    self.name = name
    self.size = {x = 200, y = 50}
    self.pos = {x = initX, y = initY}
end

function Botao:isHovered(mouseX, mouseY)
    return self.pos.x <= mouseX and mouseX <= self.pos.x + self.size.x and self.pos.y <= mouseY and mouseY <= self.pos.y + self.size.y
end

function Botao:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', self.pos.x, self.pos.y, self.size.x, self.size.y)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.name, self.pos.x, self.pos.y)
end
