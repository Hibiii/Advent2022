require("file")

local function has_sightline(grid, of_y, of_x, dy, dx)
	local local_max = -1
	local ty, tx = of_y, of_x
	local height = grid[of_y][of_x]
	while true do
		ty = ty + dy
		tx = tx + dx
		if ty < 1 or tx < 1 or ty > grid.height or tx > grid.width then break end
		local_max = local_max > grid[ty][tx] and local_max or grid[ty][tx]
		if local_max >= height then return false end
	end
	return true
end

local function view_distance(grid, from_y, from_x, dy, dx)
	local height = grid[from_y][from_x]
	local local_max = -1
	local count = 0
	local ty, tx = from_y, from_x
	while true do
		ty = ty + dy
		tx = tx + dx
		if ty < 1 or tx < 1 or ty > grid.height or tx > grid.width then break end
		count = count + 1
		if grid[ty][tx] >= height then
			break
		end
	end
	return count
end

local function iterate(grid, callback)
	local work_grid = Grid.new_with_height(grid.height)
	work_grid.width = grid.width
	work_grid.height = grid.height
	for y = 1, grid.height do
		for x = 1, grid.width do callback(work_grid, y, x)
		end
	end
	return work_grid
end

local function count_visible_trees(grid)
	local accumulator = 0
	iterate(grid, function(wg, y, x)
		wg[y][x] = has_sightline(grid, y, x, 1, 0)
		or has_sightline(grid, y, x, 0, 1)
		or has_sightline(grid, y, x, -1, 0)
		or has_sightline(grid, y, x, 0, -1)
		accumulator = wg[y][x] and accumulator + 1 or accumulator
	end)
	return accumulator
end

local function find_highest_scenic_score(grid)
	local local_max = 0
	local wg =
	iterate(grid, function(wg, y, x)
		wg[y][x] = view_distance(grid, y, x, 1, 0)
		* view_distance(grid, y, x, 0, 1)
		* view_distance(grid, y, x, -1, 0)
		* view_distance(grid, y, x, 0, -1)
		if wg[y][x] > local_max then
			local_max = wg[y][x]
		end
	end)
	return local_max
end

local function main()
	local grid = File.read_file("input")
	local visible_count = count_visible_trees(grid)
	local highest_score = find_highest_scenic_score(grid)
	print("Trees visible from outside: "..visible_count)
	print("Highest scenic score: "..highest_score)
end

main()
