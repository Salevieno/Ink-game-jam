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
    TirosAmigaveis = {TiroAmigavel(), TiroAmigavel(), TiroAmigavel(), TiroAmigavel(), TiroAmigavel(), TiroAmigavel(), TiroAmigavel(), TiroAmigavel(), TiroAmigavel()}
    TirosGerais = {TiroGeral(), TiroGeral(), TiroGeral(), TiroGeral(), TiroGeral(), TiroGeral(), TiroGeral(), TiroGeral()}
end

function love.update(dt)
    -- ocorrem o tempo todo (a cada frame). dt -> intervalo de tempo
    if Tela.status == 'Jogo rodando' then
        Player:update(dt)
    end

    -- move tiros amigáveis
    -- for i = 1, #TirosAmigaveis do
    --     TirosAmigaveis[i]:move()
    -- end

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
    if button == 1 then
        Tela:incScreen()
    end
end

function love.draw()
    -- desenha na tela
    Tela:draw()
    -- love.graphics.rectangle('fill', 100, 100, 10, 10)
    if Tela.status == 'Jogo rodando' or Tela.status == 'Jogo pausado' then
        Player:draw()
        Inim:draw()
    end
    love.graphics.setColor(0, 255, 0)
    for i = 1, #TirosAmigaveis do
        TirosAmigaveis[i]:draw()
    end
    love.graphics.setColor(255, 0, 0)
    for i = 1, #TirosGerais do
        TirosGerais[i]:draw()
    end
    
end
