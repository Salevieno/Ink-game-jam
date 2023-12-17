Polvo = Object:extend()

function Polvo:new()
    self.image = love.graphics.newImage("/assets/temp/squid.png")
    self.x = love.graphics.getWidth()/2
    self.y = love.graphics.getHeight()/2
    self.speed = 100
end

function Polvo:update(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed*dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed*dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed*dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed*dt
    end
end

function Polvo:draw()
    love.graphics.draw(self.image, self.x, self.y)
end