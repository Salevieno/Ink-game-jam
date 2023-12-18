Tela = Object:extend()

function Tela:new()
    self.imageInicial = love.graphics.newImage("/assets/BG Main.png")
    self.imagePause = love.graphics.newImage("/assets/pause.png")
    self.tentaculos = love.graphics.newImage("/assets/tentaclesInitialScreen.png")
    self.status = "Tela inicial"
end

function Tela:inicial()
    self.status = "Tela inicial"
end

function Tela:run()
    self.status = "Jogo rodando"
end

function Tela:pause()
    self.status = "Jogo pausado"
end

function Tela:gameOver()
    self.status = "Fim de jogo"
end

function Tela:pauseResume()
    if self.status == 'Jogo rodando' then
        self:pause()
    elseif self.status == "Jogo pausado" then
        self:run()
    end
end

function Tela:drawScore(x, y, scale)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score = "..Score, x, y, 0, scale, scale)
end

function Tela:draw()
    if self.status == "Tela inicial" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.imageInicial, 0, 0)
        love.graphics.draw(self.tentaculos, 0, 0)

    elseif self.status == "Jogo rodando" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.imageInicial, 0, 0)
        self:drawScore(10, 10, 1)

    elseif self.status == "Jogo pausado" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.imageInicial, 0, 0)
        love.graphics.draw(self.imagePause, 0, 0)
        self:drawScore(10, 10, 1)
        
    elseif self.status == "Fim de jogo" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.draw(self.imageInicial, 0, 0)
        love.graphics.draw(self.tentaculos, 0, 0)
        self:drawScore(300, 200, 3)
    end
    -- love.graphics.print(self.status, 100, 100)
end