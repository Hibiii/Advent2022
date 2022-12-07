require("decode")
require("vfs")
require("visitor")

Init = {}

function Init:read_shell_log()
	local file = io.open("input", "r")
	if not file then error("could not read file \"input\"") end
	local vfs = Vfs:mk()
	local visitor = Visitor:new(vfs)
	while true do
		local line = file:read("l")
		if not line then break end
		local decoded = Decode:try_prompt(line)
		if decoded then
			visitor[decoded.command](visitor, decoded)
			goto continue
		end
		decoded = Decode:try_listing(line)
		if decoded then
			visitor.here[decoded.command](visitor.here, decoded)
			goto continue
		end
		::continue::
	end
	return vfs
end
