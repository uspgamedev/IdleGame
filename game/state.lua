module('state', package.seeall)

local settings = {
	0, 		--mana
	1, 		--mps
	0, 		--gold
	false,	--magic
	false 	--transmute
}
local _PATH = "stats.data"
local _FILE = love.filesystem.newFile(_PATH)

exists = love.filesystem.exists

function read()
	local file = _FILE
	if not exists(_PATH) then 
		file:open('w')
		local fwrite = function(...) file:write(...) end
		for _,v in ipairs(settings) do
			fwrite(tostring(v)..'\n')
		end
		file:close()
	end
	file:open('r')
	local it = function(...) return file:lines(...) end
	local k
	for i,v in it() do
		if type(v)=='number' then 
			k = tonumber(v)
		else
			k = v=='true' and true or false
		end
		settings[i] = k
	end
	file:close()
end

function write()
	local file = _FILE
	file:open('w')
	local fwrite = function(...) file:write(...) end
	for _,v in ipairs(settings) do
		fwrite(tostring(v)..'\n')
	end
	file:close()
end

function getValues() return unpack(settings) end