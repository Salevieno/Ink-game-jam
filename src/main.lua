function love.load()
    -- carregam no início
    Object = require "classic"
    require "Tela"
    require "polvo"
    require "Tiro"
    require "TiroAmigavel"
    require "TiroGeral"
    require "TiroTinta"
    require "Botao"
    require "inimigo"


    Tela = Tela()
    Player = Polvo()
    Inimigos = {} 
    TirosAmigaveis = {}
    TirosGerais = {}
    TirosTinta = {}
    Botoes = {Start = Botao(300, 250, "Começar jogo")}
    Cur_respawn_time = 2
    Num_fish_respawn = 2
    Current_dt = 0

    
end

function love.update(dt)
    -- ocorrem o tempo todo (a cada frame). dt -> intervalo de tempo
    if Tela.status == 'Jogo rodando' then
        Current_dt = Current_dt + dt
    
        if Current_dt >= Cur_respawn_time then
            Current_dt = 0
            if Cur_respawn_time - 0.25 > 0 then
                Cur_respawn_time = Cur_respawn_time - 0.25
            else
                Cur_respawn_time = 2
                Num_fish_respawn = Num_fish_respawn + 1
            end

            for i=1, Num_fish_respawn do
                table.insert(Inimigos, Inimigo.SpawnNewEnemy(Player, i))
            end

        end

        Player:move(dt)
        for i, inimigo in ipairs(Inimigos) do
            local possivelTiro = inimigo:update(dt, Player)
            if possivelTiro ~= nil then
                table.insert(TirosGerais, possivelTiro)
            end
        end

        Player:reloadInk(dt)
    
        -- move tiros amigáveis
        for i, tiro in ipairs(TirosAmigaveis) do
            tiro:move()
            if tiro:isOffScreen() then
                table.remove(TirosAmigaveis, i)
            end
            if tiro:checkHitEnemy(Inimigos, TirosAmigaveis) then
                table.remove(TirosAmigaveis, i)
            end
        end
    
        -- move tiros gerais
        for i, tiro in ipairs(TirosGerais) do
            tiro:move()
            if tiro:hitPlayer(Player.x, Player.y, (Player.size.width + Player.size.height) / 2) then
                -- Tela:gameOver()
            end

            if tiro:isOffScreen() then
                table.remove(TirosGerais, i)
            end
        end
    
        -- move tiros de tinta
        for i, tiro in ipairs(TirosTinta) do
            tiro:move()
            if tiro:isOffScreen() then
                table.remove(TirosTinta, i)
            end
        end

        -- 

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

    -- botão start
    if Botoes.Start ~= nil then
        if Botoes.Start:isPressed(x, y) then
            -- BotaoStart.act()
            Tela:incScreen()
            Botoes.Start = nil
        end
    end

    -- player atira
    if Tela.status == 'Jogo rodando' then
        if button == 1 then
            Player:shoot(x, y)
            for i, inimigo in ipairs(Inimigos) do
                if inimigo.controled then
                    table.insert(TirosAmigaveis, inimigo:shootControled(x, y))
                end
            end
        end
        if button == 2 and Player:hasInk() then
            Player:shootInk(x, y)
        end
    end
end

function love.draw()
    -- desenha na tela
    Tela:draw()

    for i, botao in pairs(Botoes) do
        botao:draw()
    end

    if Tela.status == 'Jogo rodando' or Tela.status == 'Jogo pausado' then
        Player:drawInkStorage()
        Player:draw()
        for i, v in ipairs(Inimigos) do
            v:draw()
        end
    end

    for i = 1, #TirosAmigaveis do
        TirosAmigaveis[i]:draw()
    end

    for i = 1, #TirosGerais do
        TirosGerais[i]:draw()
    end

    for i = 1, #TirosTinta do
        TirosTinta[i]:draw()
    end
end
