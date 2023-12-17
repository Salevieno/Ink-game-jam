TiroAmigavel = Tiro:extend()

function TiroAmigavel:new(initX, initY, targetX, targetY)
    TiroAmigavel.super.new(self, initX, initY, 3, 1, targetX, targetY)
end
