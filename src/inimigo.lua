Inimigo = Object:extend()

function Inimigo:new(x, y)
    self.x = x
    self.y = y
    self.speed = 100
    self.image = love.graphics.newImage("/assets/temp/enemy 64.png")
end

function Inimigo:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
end