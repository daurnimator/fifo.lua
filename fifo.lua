local select , setmetatable = select , setmetatable

local pack = table.pack or function(...) return { n = select("#", ...); ... } end

local function is_integer(x)
	return x % 1 == 0
end

local fifo = {}
local fifo_mt = {
	__index = fifo ;
	__newindex = function ( f , k , v )
		error("Tried to set table field in fifo")
	end ;
}

local empty_default = function ( _ ) error ( "Fifo empty" ) end

function fifo.new ( ... )
	local self = setmetatable({
		empty = empty_default;
		head = false;
		tail = false;
		n = 0;
	}, fifo_mt)
	local a = pack(...)
	for i=1, a.n do
		self:push(a[i])
	end
	return self
end

function fifo:length ( )
	return self.n
end
fifo_mt.__len = fifo.length

-- Peek at the nth item
function fifo:peek ( n )
	n = n or 1
	assert(is_integer(n), "bad index to :peek()")

	local node = self.head
	if node == false then return nil, false end
	for i=1, n-1 do
		node = node.next
		if node == false then return nil, false end
	end
	return node.data, true
end

function fifo:push ( v )
	local new_node = {
		next = false;
		data = v;
	}
	local prev_tail = self.tail
	if prev_tail then
		prev_tail.next = new_node
	else
		self.head = new_node
	end
	self.tail = new_node
	self.n = self.n + 1
end

function fifo:pop ( )
	local node = self.head
	if node == false then return self:empty() end
	self.head = node.next
	if self.tail == node then
		self.tail = false
	end
	self.n = self.n - 1
	return node.data
end

function fifo:insert ( n , v )
	if n <= 0 or not is_integer(n) then
		error("bad index to :insert()")
	end
	local prev_node
	local node = self.head
	for i=1, n-1 do
		if node == false then error("bad index to :insert()") end
		prev_node, node = node, node.next
	end
	local new_node = {
		next = node;
		data = v;
	}
	if n == 1 then
		self.head = new_node
	else
		prev_node.next = new_node
	end
	if node == false then
		self.tail = new_node
	end
	self.n = self.n + 1
end

function fifo:remove ( n )
	if n <= 0 or not is_integer(n) then
		error("bad index to :remove()")
	end
	local prev_node
	local node = self.head
	if n == 1 then
		if node == false then return self:empty() end
		self.head = node.next
	else
		for i=1, n-1 do
			if node == false then return self:empty() end
			prev_node, node = node, node.next
		end
		prev_node.next = node.next
	end
	if self.tail == node then
		self.tail = false
	end
	self.n = self.n - 1
	return node.data
end

function fifo:setempty ( func )
	self.empty = func
	return self
end

return fifo.new
