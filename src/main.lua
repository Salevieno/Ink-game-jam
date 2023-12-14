require 'bolinha'

function love.load()

end

function love.update ()
    bolinha:updateSpeed()
    bolinha:move()
end

function love.draw ()
    love.graphics.setColor(0, 0, 0)
    love.graphics.arc('fill', bolinha.pos.x, bolinha.pos.y, 10, 0, 360)
    love.graphics.arc('fill', 300, 300, bolinha.getSize(30), 0, 360)
end