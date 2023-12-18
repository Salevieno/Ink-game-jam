Inimigo = Object:extend()

function Inimigo:new(x, y)
    self.x0 = x
    self.y0 = y
    ScaleInimigo = 1 / 6
    self.x = x
    self.y = y
    self.speed = 0
    self.image = love.graphics.newImage("/assets/peixe.png")
    self.size = {ScaleInimigo * self.image:getWidth(), ScaleInimigo * self.image:getHeight()}
    self.y_limits = {self.y - 50, self.y + 100}
    self.dt_since_shoot = 0
    self.color_arr = {1, 1, 1}
    self.controled = false
    self.controled_timer = 2
    self.moveTime = 0
end

function Inimigo:draw()
    love.graphics.setColor(self.color_arr[1], self.color_arr[2], self.color_arr[3])
    love.graphics.draw(self.image, self.x, self.y, 0, ScaleInimigo, ScaleInimigo, self.image:getWidth()/2, self.image:getHeight()/2)
end

function Inimigo:inkHit(color_arr, controled_timer)
    self.color_arr = color_arr
    self.controled = true
    self.controled_timer = controled_timer
end

function Inimigo:update(dt, Player) 
    self.dt_since_shoot = self.dt_since_shoot + dt
    local new_x = self.x
    local new_y = self.y

    if self.controled then

        if love.keyboard.isDown("w") then
            new_y = self.y - (Player.speed/2)*dt
        end
        if love.keyboard.isDown("s") then
            new_y = self.y + (Player.speed/2)*dt
        end
        if love.keyboard.isDown("d") then
            new_x = self.x + (Player.speed/2)*dt
        end
        if love.keyboard.isDown("a") then
            new_x = self.x - (Player.speed/2)*dt
        end

        self.controled_timer = self.controled_timer - dt

        if self.controled_timer <= 0 then
            self.controled = false
            self.color_arr = {1, 1, 1}
        end
        
    end

    self:MoverCirculo()
    self.moveTime = self.moveTime + dt

    if self.dt_since_shoot >= 2 then
        self.dt_since_shoot = 0
        return self:shoot(Player)
    end

    return nil
end

function Inimigo:MoverCirculo()
    local raio = 75
    local angulo = math.fmod(self.moveTime, 6.28)*self.speed
    local new_x = (self.x0 + raio*math.sin(angulo))
    local new_y = (self.y0 + raio*math.cos(angulo))

    local half_w, half_h = self.image:getWidth()/2, self.image:getHeight()/2
    if Player:distanceToMid(new_x + half_w, new_y + half_h) > Player.distLimit + 25 then
        self.x = new_x
        self.y = new_y
    end
end

function Inimigo:shoot(Player)
    return TiroGeral(self.x, self.y, Player.x, Player.y)
end

function Inimigo:shootControled(x, y)
    return TiroAmigavel(self.x, self.y, x, y)
end

function Inimigo.SpawnNewEnemy(Player, seed)
    local image = love.graphics.newImage("/assets/temp/enemy 64.png")
    local half_w, half_h = image:getWidth()/2, image:getHeight()/2
    local min_x, min_y = half_w, half_h
    local max_x, max_y = love.graphics.getWidth() - half_w, love.graphics.getHeight() - half_h

    math.randomseed(os.time() + seed)
    local x, y

    repeat
        x, y = math.random(min_x, max_x), math.random(min_y, max_y)
    until Player:distanceToMid(x + half_w, y + half_h) > Player.distLimit + 5 and Player:distanceToMid(x - half_w, y - half_h) > Player.distLimit + 5
    
    return Inimigo(x, y)
end
