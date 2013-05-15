require "timer"
require 'state'

function transmute()
    mana = mana - 10
    gold = gold + 1
    usedtransmute = true
end

function love.load()
	state.read()
    mana, persecond, gold, firstmagic, usedtransmute = state.getValues()


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

    if usedtransmute == true then -- Usou a magia alguma vez, ou seja, começa a aparecer escrito "gold"
        love.graphics.print("Gold: " .. gold, 25, 47)
    end
    if firstmagic == true then -- Tem mana suficiente pra ativar a primeira magia, então aparece seu botão
        love.graphics.setColor(0,255,0)
        love.graphics.rectangle("fill", 25, 80, 120, 30) -- Botão de primeira magia
        love.graphics.setColor(255,255,255)
        love.graphics.print("transmute", 50, 78)
    end
     if transmute == true then
        love.graphics.setColor(255,255,255)
        love.graphics.print("You tranformed 10 mana into 1 gold!", 150, 100)
    end
end

function love.mousepressed(x, y, button)
	if button == "l" and x <= 660 and x >= 600 and y <= 60 and y >= 30 then -- Ao clicar no botão de salvar
		state.write()
        saved = true
        saveTimer = timer.new(1, function() saved = false end, true) -- Timer para desaparecer o texto "game saved"
	end
    if button == "l" and x <= 145 and x >= 25 and y <= 110 and y >= 80 and mana >= 10 and firstmagic then -- Ao clicar no botão de transmute
        transmute()
        transmute = true
        transmuteTimer = timer.new(1, function() transmute = false end, true) -- Timer para desaparecer o texto de transmute
    end
end
