Tela = Object:extend()

function Tela:new()
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
    if (self.status == "Tela inicial") then
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

function Tela:draw()
    love.graphics.print(self.status, 100, 100)
end