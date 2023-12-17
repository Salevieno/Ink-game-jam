function love.load()
    -- carregam no início
    TirosAmigaveis = {}
    TirosGerais = {}
    Object = require "classic"
    require "Tela"
    require "polvo"

    Tela = Tela()
    Player = Polvo()
end

function love.update(dt)
    -- ocorrem o tempo todo (a cada frame). dt -> intervalo de tempo
    Player:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'return' then
        Tela:pauseResume()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    -- ocorre quando o mouse é apertado
    if button == 1 then
        Tela:incScreen()
    end
end

function love.draw()
    -- desenha na tela
    Tela:draw()
    -- love.graphics.rectangle('fill', 100, 100, 10, 10)
    Player:draw()
end
