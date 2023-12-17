function love.load()
    -- carregam no início
    Object = require "classic"
    require "Tela"
    require "polvo"
    require "TiroAmigavel"
    require "TiroGeral"
    require "inimigo"

    Tela = Tela()
    Player = Polvo()
    Inim = Inimigo(200, 400)
    TirosAmigaveis = {}
    TirosGerais = {}
end

function love.update(dt)
    -- ocorrem o tempo todo (a cada frame). dt -> intervalo de tempo
    if Tela.status == 'Jogo rodando' then
        Player:update(dt)
        Inim:update(dt)
    end

    for i, tiro in ipairs(TirosAmigaveis) do
        tiro:move()
        if tiro:isOffScreen() then
            table.remove(TirosAmigaveis, i)
        end
    end

    -- move tiros gerais
    for i, tiro in ipairs(TirosGerais) do
        tiro:move()
        if tiro:isOffScreen() then
            table.remove(TirosGerais, i)
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    -- ocorre quando uma tecla é pressionada
    if key == 'return' then
        Tela:pauseResume()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    -- ocorre quando o mouse é apertado
    if button == 2 then
        Tela:incScreen()
    end
    if Tela.status == 'Jogo rodando' then
        if button == 1 then
            Player:shoot(x, y)
        end
    end
end

function love.draw()
    -- desenha na tela
    love.graphics.setColor(1, 1, 1)
    Tela:draw()
    
    if Tela.status == 'Jogo rodando' or Tela.status == 'Jogo pausado' then
        Player:draw()
        Inim:draw()
    end

    love.graphics.setColor(0, 1, 0)
    for i = 1, #TirosAmigaveis do
        TirosAmigaveis[i]:draw()
    end

    love.graphics.setColor(1, 0, 0)
    for i = 1, #TirosGerais do
        TirosGerais[i]:draw()
    end
    
end
