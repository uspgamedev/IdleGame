require "timer"


function readstats()
    local file = love.filesystem.newFile("stats") -- Le o arquivo com os stats salvados
    if not love.filesystem.exists("stats") then -- Se não existe um arquivo já, ele cria um novo
        file:open('w')
        file:write("0\n1")
        file:close()
    end
    file:open('r')              -- Atualiza as variáveis com os valores do arquivo
    local it = file:lines()
    local r = it()
    if not r then r = 0 end
    mana = 0 + r
    local r = it()
    persecond = 0 + r
    file:close()
end

function save() -- Salva o jogo
    local file = love.filesystem.newFile("stats")
    file:open('w')
    mana = mana
    persecond = persecond
    file:write(mana .. "\n" .. persecond)
    file:close()
end

function love.load()
	readstats()

    saved = false -- Texto se você acabou de salvar
end

function love.update(dt)
	mana = mana+persecond*dt -- Atualiza mana atual

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

end

function love.mousepressed(x, y, button)
	if button == "l" and x <= 660 and x >= 600 and y <= 60 and y >= 30 then -- Ao clicar no botão de salvar
		save()
        saved = true
        saveTimer = timer.new(1, function() saved = false end, true) -- Timer para desaparecer o texto "game saved"
	end
end
