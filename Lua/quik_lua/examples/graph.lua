--[[
*******************************************************************
Пример демонстрирует возможности получения данных с графиков
и индикаторов. "Свечки" индексируются по номеру.
Для исполнения также требуется наличие скрипта tpf.lua.
*******************************************************************
]]

dofile("tpf.lua")

function main(  )
	file = io.open("1.txt", "w+t")
	-- должен быть создан график или индикатор с идентификатором zzz
	local x = getNumCandles("zzz") 	-- получаем количество свечек на графике
	local y = getLinesCount("zzz") 	-- получаем количество линий у графика
					-- у некоторых индикаторов линий может быть
					-- больше чем одна
	message("total ".. x .. " candles in " ..y .. " lines", 3)
	for i=0,y-1 do
		file:write("line = ".. i .. "\n")
		-- получаем 10 первых свечей с каждой линии
		t, num, legend = getCandlesByIndex("zzz", i, 0, 10)
		file:write("num = " .. num ..", legend = ".. legend .. "\n")
		for j=0,num-1 do
			--сохраняем каждую свечку в файл
			table_save( "candle["..j .. "]", file, t[j])
		end
	end

	file:close()
end