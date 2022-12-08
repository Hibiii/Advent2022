File = {}

Grid = {}

function Grid.new()
	local out = {
		width = 0,
		height = 0,
	}
	return out
end

function Grid.new_with_height(height)
	local out = Grid.new()
	for y = 1, height do
		out[y] = {}
	end
	return out
end

function File.append_line(grid, line)
	if not line then return end
	local row = {}
	for char in line:gmatch("%d") do
		local int = tonumber(char)
		if not int then goto continue end
		row[#row+1] = int
		::continue::
	end
	grid[#grid+1] = row
end

function File.read_file(path)
	local file = io.open(path, "r")
	if not file then
		error("could not open file \""..path.."\"")
	end
	local grid = Grid.new()
	for line in file:lines("l") do
		File.append_line(grid, line)
	end
	file:close()
	grid.width = #grid[1]
	grid.height = #grid
	return grid
end
