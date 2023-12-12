bolinha = 
{
    pos = {x = 100, y = 100},
    speed = {x = 0, y = 0},
    a = {x = 0, y = 0.1},
    elastic = 0.8,
    getSize = function (minSize)
        return 2 * minSize
    end,
    updateSpeed = function (self)
        self.speed.x = self.speed.x + self.a.x
        self.speed.y = self.speed.y + self.a.y
    end,
    move = function (self)
        self.pos.x = self.pos.x + self.speed.x
        self.pos.y = self.pos.y + self.speed.y
        if 200 < self.pos.y + self.speed.y then
            self.pos.y = 200
        end
        if self.pos.y == 200 then
            self.speed.y = -self.elastic * self.speed.y
        end
    end
}

return bolinha