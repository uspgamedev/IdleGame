
function readstats()
    local file = love.filesystem.newFile("stats")
    if not love.filesystem.exists("stats") then
        file:open('w')
        file:write("0\n1")
        file:close()
    end
    file:open('r')
    local it = file:lines()
    local r = it()
    if not r then r = 0 end
    gold = 0 + r
    local r = it()
    persecond = 0 + r
    file:close()
end

function save()
    local file = love.filesystem.newFile("stats")
    file:open('w')
    gold = gold
    persecond = persecond
    file:write(gold .. "\n" .. persecond)
    file:close()
end

function love.load()
	readstats()
end

function love.update(dt)
	gold = gold+persecond*dt
end

function love.draw()
	love.graphics.print(string.format("Gold: %d", gold), 25, 25)
	love.graphics.print("Gold per Second: " .. persecond, 25, 35)
	love.graphics.rectangle("fill", 500, 30, 60, 30)
end

function love.mousepressed(x, y, button)
	if button == "l" and x<=560 and x>=500 and y<=60 and y>=30 then
		save()
	end
end
