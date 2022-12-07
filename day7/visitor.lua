Visitor = {}

function Visitor:cd_up(action)
	if self.here.parent then
		self.here = self.here.parent
	end
end

function Visitor:cd_root(action)
	self.here = self.fs.root
end

function Visitor:cd(action)
	local target = self.here.subdirs[action.param]
	if not target then
		error("trying to cd to nonexisting directory")
		return
	end
	self.here = target
end

function Visitor:ls(action)
end

function Visitor:new(vfs)
	local out = { here = vfs.root, fs = vfs }
	out.cd_up = Visitor.cd_up
	out.cd_root = Visitor.cd_root
	out.cd = Visitor.cd
	out.ls = Visitor.ls
	return out
end