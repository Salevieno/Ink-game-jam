Tela = Object:extend()

function Tela:new()
    self.imageInicial = love.graphics.newImage("/assets/BG Main.png")
    self.tentaculos = love.graphics.newImage("/assets/tentaclesInitialScreen.png")
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

function Tela:incScreen()
    if self.status == "Tela inicial" then
        self:run()
    end
end

function Tela:pauseResume()
    if self.status == 'Jogo rodando' then
        self:pause()
    elseif self.status == "Jogo pausado" then
        self:run()
    end
end

function Tela:drawScore()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score = "..Score, 10, 10)
end

function Tela:draw()
    -- love.graphics.print(self.status, 100, 100)
    if self.status == "Tela inicial" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.imageInicial, 0, 0)
        love.graphics.draw(self.tentaculos, 0, 0)
    elseif self.status == "Jogo rodando" then

    elseif self.status == "Jogo pausado" then
        
    elseif self.status == "Fim de jogo" then
    
    end
end