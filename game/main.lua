require "timer"


function readstats()
    local file = love.filesystem.newFile("stats") -- Le o arquivo com os stats salvados
    if not love.filesystem.exists("stats") then -- Se não existe um arquivo já, ele cria um novo
        file:open('w')
        file:write("0\n1\n0\nfalse\nfalse") -- Mana/Mana Per second/Gold/First Magic/usedTransmugate
        file:close()
    end
    file:open('r')              -- Atualiza as variáveis com os valores do arquivo
    local it = file:lines()
    local r = it()
    if not r then r = 0 end
    mana = 0 + r
    local r = it()
    persecond = 0 + r
    local r = it()
    gold = 0 + r
    local r = it()
    firstmagic = r
    local r = it()
    usedTransmugate = r
    file:close()
end

function save() -- Salva o jogo
    local file = love.filesystem.newFile("stats")
    file:open('w')
    mana = mana
    persecond = persecond
    gold = gold
    firstmagic = firstmagic
    usedTransmugate = usedTransmugate
    file:write(mana .. "\n" .. persecond "\n" .. gold "\n" .. firstmagic "\n" .. usedTransmugate)
    file:close()
end

function transmugate()
    mana = mana - 10
    gold = gold + 1
    usedTransmugate = true
end

function love.load()
	readstats()

    saved = false -- Texto se você acabou de salvar
end

function love.update(dt)
	mana = mana+persecond*dt -- Atualiza mana atual

    if mana >= 10 then firstmagic = true end -- Ativa primeira magia

    timer.update(dt,1,false) -- Atualiza todos os timers
end

function love.draw()
	
    love.graphics.setColor(255,255,255)
    love.graphics.print(string.format("Mana: %d", mana), 25, 25)
	love.graphics.print("Mana per Second: " .. persecond, 25, 35)
    
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill", 600, 30, 60, 30) -- Botão de salvar o jogo
    love.graphics.setColor(255,255,255)
    love.graphics.print("Save", 610, 35)
    if saved then
        love.graphics.setColor(255,255,255)
        love.graphics.print("Game saved", 590, 60)
    end

    if usedTransmugate == true then -- Usou a magia alguma vez, ou seja, começa a aparecer escrito "gold"
        love.graphics.print("Gold: " .. gold, 25, 47)
    end
    if firstmagic == true then -- Tem mana suficiente pra ativar a primeira magia, então aparece seu botão
        love.graphics.setColor(0,255,0)
        love.graphics.rectangle("fill", 25, 80, 120, 30) -- Botão de primeira magia
        love.graphics.setColor(255,255,255)
        love.graphics.print("Transmugate", 50, 78)
    end
     if transmugate == true then
        love.graphics.setColor(255,255,255)
        love.graphics.print("You tranformed 10 mana into 1 gold!", 150, 100)
    end
end

function love.mousepressed(x, y, button)
	if button == "l" and x <= 660 and x >= 600 and y <= 60 and y >= 30 then -- Ao clicar no botão de salvar
		save()
        saved = true
        saveTimer = timer.new(1, function() saved = false end, true) -- Timer para desaparecer o texto "game saved"
	end
    if button == "l" and x <= 145 and x >= 25 and y <= 110 and y >= 80 and mana >= 10 and firstmagic then -- Ao clicar no botão de Transmugate
        transmugate()
        transmugate = true
        transmugateTimer = timer.new(1, function() transmugate = false end, true) -- Timer para desaparecer o texto de transmugate
    end
end
