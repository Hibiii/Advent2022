require("more")

Direction = {
	UP = "U",
	LEFT = "L",
	RIGHT = "R",
	DOWN = "D",
}

Game = {
	rope = {},
	records = {},
}

function Game.rope.update_node(this, previous)
	local distance = {previous[1] - this[1], previous[2] - this[2]}
	if math.abs(distance[1]) <= 1 and math.abs(distance[2]) <= 1 then
		return
	end
	this[1] = this[1] + math.sign(distance[1])
	this[2] = this[2] + math.sign(distance[2])
end

function Game.rope:update()
	for i = 2, #self do
		Game.rope.update_node(self[i], self[i - 1])
	end
end

function Game.rope:move(direction)
	if direction == Direction.UP then
		self[1][2] = self[1][2] - 1
	elseif direction == Direction.DOWN then
		self[1][2] = self[1][2] + 1
	elseif direction == Direction.LEFT then
		self[1][1] = self[1][1] - 1
	elseif direction == Direction.RIGHT then
		self[1][1] = self[1][1] + 1
	end
end

function Game:record()
	local pos = self.rope[#self.rope]
	local str = pos[1] .. "," .. pos[2]
	self.records[str] = (self.records[str] or 0) + 1
end

function Game.new(rope_length)
	local out = {
		rope = {
			update = Game.rope.update,
			move = Game.rope.move,
		},
		records = {},
		record = Game.record,
	}
	for i = 1, rope_length do
		out.rope[i] = {0, 0}
	end
	return out
end
