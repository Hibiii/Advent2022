Ins = {
	noop = {
		cycles = 1,
		execute = function (vm, cycle)
		end,
	},
	addx = {
		cycles = 2,
	}
}

function Ins.addx:execute(vm, cycle)
	if cycle == 2 then
		vm.register_x = vm.register_x + self.parameter
	end
end

function Ins.from(string)
	local mnemonic = string:match("(%S+)")
	if mnemonic == "noop" then
		local out = {}
		for key, value in pairs(Ins.noop) do
			out[key] = value
		end
		return out
	elseif mnemonic == "addx" then
		local parameter = tonumber(string:match("%S+%s+(-?%d+)"))
		local out = {parameter = parameter}
		for key, value in pairs(Ins.addx) do
			out[key] = value
		end
		return out
	else
		error("Unknown mnemonic: "..mnemonic)
	end
end

function New_Vm()
	return {
		register_x = 1,
		cycle = 1,
		listing = {}
	}
end

