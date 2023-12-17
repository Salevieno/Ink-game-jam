Inimigo = Object:extend()

function Inimigo:new(x, y)
    self.x = x
    self.y = y
    self.speed = 100
    self.image = love.graphics.newImage("/assets/temp/enemy 64.png")
    self.y_limits = {self.y - 50, self.y + 100}
    self.dt_since_shoot = 0
    self.color_arr = {1, 1, 1}
end

function Inimigo:draw()
    love.graphics.setColor(self.color_arr[1], self.color_arr[2], self.color_arr[3])
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
end

function Inimigo:setColor(color_arr)
    self.color_arr = color_arr
end

function Inimigo:update(dt, Player)
    self.dt_since_shoot = self.dt_since_shoot + dt
    self.y = self.y + self.speed*dt

    if self.y < self.y_limits[1] then
        self.speed = 100
    elseif self.y > self.y_limits[2] then
        self.speed = -100
    end

    if self.dt_since_shoot >= 2 then
        self.dt_since_shoot = 0
        return self:shoot(Player)
    end

    return nil
end

function Inimigo:shoot(Player)
    return TiroGeral(self.x, self.y, Player.x, Player.y)
end

function Inimigo.SpawnNewEnemy(Player)
    local image = love.graphics.newImage("/assets/temp/enemy 64.png")
    local half_w, half_h = image:getWidth()/2, image:getHeight()/2
    local min_x, min_y = half_w, half_h
    local max_x, max_y = love.graphics.getWidth() - half_w, love.graphics.getHeight() - half_h

    math.randomseed(os.time())
    local x, y

    repeat
        x, y = math.random(min_x, max_x), math.random(min_y, max_y)
    until Player:distanceToMid(x + half_w, y + half_h) > Player.distLimit + 5 and Player:distanceToMid(x - half_w, y - half_h) > Player.distLimit + 5
    
    return Inimigo(x, y)
end
