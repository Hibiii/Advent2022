Graphics = {
	lines = {},
	currentline = "",
}

local function pixel_is_lit(vm, idx)
	if math.abs(vm.register_x - idx) > 1 then
		return false
	end
	return true
end

function Graphics:paint(vm)
	if #self.currentline == 40 then
		self.lines[#self.lines+1] = self.currentline
		self.currentline = ""
	end
	local lit = pixel_is_lit(vm, #self.currentline)
	if lit then self.currentline = self.currentline .. "#"
	else self.currentline = self.currentline .. " "
	end
end

function Graphics:finalize()
	self.lines[#self.lines+1] = self.currentline
	self.currentline = ""
end