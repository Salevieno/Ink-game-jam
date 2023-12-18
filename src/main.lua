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
    BotaoStart = Botao(280, 230, love.graphics.newImage("/assets/botaoStart.png"), love.graphics.newImage("/assets/botaoStartSelected.png"))
    BotaoRestart = Botao(280, 300, love.graphics.newImage("/assets/botaoRestart.png"), love.graphics.newImage("/assets/botaoRestartSelected.png"))
    Cur_respawn_time = 2
    Num_fish_respawn = 2
    Current_dt = 0
    Score = 0
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
                Score = Score + 10
            end
        end
    
        -- move tiros gerais
        for i, tiro in ipairs(TirosGerais) do
            tiro:move()
            if tiro:hitPlayer(Player.x, Player.y, (Player.size.width + Player.size.height) / 2) then
                Player:decHeart()
                table.remove(TirosGerais, i)
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
            if tiro:checkHitEnemy(Inimigos) then
                table.remove(TirosTinta, i)
            end
        end
    end

    if Player.hearts == 0 then
        Tela:gameOver()
    end
end

function love.mousemoved(x, y)
    if Tela.status == "Tela inicial" then
        BotaoStart:checkHover(x, y)
        if BotaoStart:isHovered(x, y) then
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
            return
        end
    end

    if Tela.status == "Fim de jogo" then
        BotaoRestart:checkHover(x, y)
        if BotaoRestart:isHovered(x, y) then
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
            return
        end
    end
    
    love.mouse.setCursor()
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
    if Tela.status == "Tela inicial" then
        if BotaoStart:isHovered(x, y) then
            Tela:run()
        end
    end

    -- botão restart
    if Tela.status == "Fim de jogo" then
        if BotaoRestart:isHovered(x, y) then
            Tela:inicial()
            Player:refillHearts()
            Inimigos = {}
            TirosAmigaveis = {}
            TirosGerais = {}
            TirosTinta = {}
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

    if Tela.status == "Tela inicial" then
        BotaoStart:draw()
    end

    -- botão restart
    if Tela.status == "Fim de jogo" then
        BotaoRestart:draw()
    end

    if Tela.status == 'Jogo rodando' or Tela.status == 'Jogo pausado' then
        Player:drawInkStorage()
        Player:draw()
        Player:drawHearts()
        for i, v in ipairs(Inimigos) do
            v:draw()
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
end
