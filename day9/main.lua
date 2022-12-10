require("game")

function Main()
	local input = {}
	do
		local file = io.open("input", "r")
		if not file then error("missing input file") end
		while true  do
			local line = file:read("l")
			if not line then break end
			input[#input+1] = line
		end
		file:close()
	end

	local game_1 = Game.new(2)
	local game_2 = Game.new(10)
	for _, line in ipairs(input) do
		local direction, steps = line:match("(%a) (%d+)")
		for i = 1, tonumber(steps) do
			game_1.rope:move(direction)
			game_1.rope:update()
			game_1:record()
			game_2.rope:move(direction)
			game_2.rope:update()
			game_2:record()
		end
	end

	local accumulator_1 = 0
	local accumulator_2 = 0
	for k,v in pairs(game_1.records) do
		accumulator_1 = accumulator_1 + 1
	end
	for k,v in pairs(game_2.records) do
		accumulator_2 = accumulator_2 + 1
	end
	print("1-long rope unique positions: ".. accumulator_1)
	print("10-long rope unique positions: ".. accumulator_2)
end

Main()