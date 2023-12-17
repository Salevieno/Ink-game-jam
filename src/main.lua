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
    --Inim = Inimigo(200, 400)
    TirosAmigaveis = {}
    TirosGerais = {}
    TirosTinta = {}
    Botoes = {Start = Botao(400, 300, "Começar jogo")}
    cur_respawn_time = 2
    num_fish_respawn = 1
    current_dt = 0
end

function love.update(dt)
    -- ocorrem o tempo todo (a cada frame). dt -> intervalo de tempo
    if Tela.status == 'Jogo rodando' then
        current_dt = current_dt + dt
    
        if current_dt >= cur_respawn_time then
            current_dt = 0
            if cur_respawn_time - 0.25 > 0 then
                cur_respawn_time = cur_respawn_time - 0.25
            else
                cur_respawn_time = 2
                num_fish_respawn = num_fish_respawn + 1
            end

            for i=1, num_fish_respawn do
                table.insert(Inimigos, Inimigo.SpawnNewEnemy(Player))
            end

        end

        Player:update(dt)
        for i, v in ipairs(Inimigos) do
            local possivelTiro = v:update(dt, Player)
            if possivelTiro ~= nil then
                table.insert(TirosGerais, possivelTiro)
            end
        end
    end

    Player:reloadInk(dt)

    -- remove tiros fora da tela
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

    -- move tiros gerais
    for i, tiro in ipairs(TirosTinta) do
        tiro:move()
        if tiro:isOffScreen() then
            table.remove(TirosTinta, i)
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
