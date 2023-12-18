Botao = Object:extend()

function Botao:new(initX, initY, image, selectedImage)
    Scale = 0.4
    self.size = {x = Scale * image:getWidth(), y = Scale * image:getHeight()}
    self.pos = {x = initX, y = initY}
    self.image = image
    self.selectedImage = selectedImage
    self.hovered = false
end

function Botao:checkHover(mouseX, mouseY)
    if self.pos.x <= mouseX and mouseX <= self.pos.x + self.size.x and self.pos.y <= mouseY and mouseY <= self.pos.y + self.size.y then
        self.hovered = true
    else
        self.hovered = false
    end
end

function Botao:isHovered(mouseX, mouseY)
    return self.pos.x <= mouseX and mouseX <= self.pos.x + self.size.x and self.pos.y <= mouseY and mouseY <= self.pos.y + self.size.y
end

function Botao:draw()
    love.graphics.setColor(1, 1, 1)
    if self.hovered then
        love.graphics.draw(self.selectedImage, self.pos.x, self.pos.y, 0, Scale, Scale)
    else
        love.graphics.draw(self.image, self.pos.x, self.pos.y, 0, Scale, Scale)
    end
end
