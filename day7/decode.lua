Action = {
	command = "",
	param = "",
	size = 0,
}

Decode = {}

function Decode:try_prompt(line)
	local prompt, command = line:match("($) (%S+)")
	if not prompt then return end
	if command == "cd" then
		local param = line:match("$ %S+ (%S+)")
		if not param then
			error("cd with no parameter")
		elseif param == "/" then
			return {command = "cd_root"}
		elseif param == ".." then
			return {command = "cd_up"}
		else
			return {command = "cd", param = param}
		end
	end
	if command == "ls" then
		return {command = "ls"}
	end
end

function Decode:try_listing(line)
	local type_or_size, name = line:match("(%S+) (%S+)")
	if type_or_size == "dir" then
		return {command = "mkdir", param = name}
	else
		return {command = "add", size = tonumber(type_or_size)}
	end
end