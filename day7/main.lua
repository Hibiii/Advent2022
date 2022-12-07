require("init")

local accumulator = 0
local capacity = 70000000
local unused = 0
local needed = 30000000

local function traverse_sum_of_dirs_less_than_100k(dir)
	if dir.size <= 100000 then
		accumulator = accumulator + dir.size
	end
	for _, subdir in pairs(dir.subdirs) do
		traverse_sum_of_dirs_less_than_100k(subdir)
	end
end

local function traverse_find_smallest(dir)
	if dir.size < accumulator and unused + dir.size >= needed  then
		accumulator = dir.size
	end
	for _, subdir in pairs(dir.subdirs) do
		traverse_find_smallest(subdir)
	end
end

function Main()
	local fs = Init:read_shell_log()
	traverse_sum_of_dirs_less_than_100k(fs.root)
	print("Part 1: " .. accumulator)
	accumulator = fs.root.size
	unused = capacity - fs.root.size
	traverse_find_smallest(fs.root)
	print("Part 2: " .. accumulator)
end

Main()