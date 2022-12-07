Vfs = {
}

function Vfs:add(action)
	self.size = self.size + action.size
	if not self.parent then return end
	repeat
		self = self.parent
		self.size = self.size + action.size
	until not self.parent
end

function Vfs:mkdir(action)
	local out = {size = 0, subdirs = {}, parent = self}
	if self ~= nil then
		self.subdirs[action.param] = out
	end
	out.mkdir = Vfs.mkdir
	out.add = Vfs.add
	return out
end

function Vfs:mk()
	local out = {}
	out.root = Vfs.mkdir(nil, "root")
	return out
end
