require("vm")
require("graphics")

Accumulator = 0

local observed_cycles = {
	[20] = true,
	[60] = true,
	[100] = true,
	[140] = true,
	[180] = true,
	[220] = true,
}

local function observe(vm)
	if observed_cycles[vm.cycle] then
		Accumulator = Accumulator + (vm.cycle * vm.register_x)
	end
end

function Main()
	local file = io.open("input", "r")
	if not file then error("Could not open input file \"input\"") end
	local vm = New_Vm()
	for line in file:lines("l") do
		vm.listing[#vm.listing+1] = Ins.from(line)
	end
	file:close()
	for _, ins in ipairs(vm.listing) do
		for cycle = 1, ins.cycles do
			observe(vm)
			Graphics:paint(vm)
			ins:execute(vm, cycle)
			vm.cycle = vm.cycle + 1
		end
	end
	Graphics:finalize()
	print("Sum of observed signal strengthes: "..Accumulator)
	for _, str in ipairs(Graphics.lines) do
		print("|"..str.."|")
	end
end

Main()