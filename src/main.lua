function love.load()
    Object = require "classic"
    require "polvo"
    Player = Polvo()
end

function love.update(dt)
    Player:update(dt)
end

function love.draw()
    Player:draw()
end