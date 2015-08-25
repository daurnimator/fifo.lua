local new_fifo = require "fifo"

describe("Everything works.", function()
	it("doesn't let you set a field", function()
		local f = new_fifo()
		assert.errors(function() f.foo = "bar" end)
	end)
	it("peek works", function()
		local f = new_fifo()
		f:push("foo")
		assert.same("foo", (f:peek()))
		f:push("bar")
		assert.same("foo", (f:peek()))
		assert.same("bar", (f:peek(2)))
		f:pop()
		assert.same("bar", (f:peek()))

		assert.same({nil, false}, {f:peek(20)})
	end)
	it("length works", function()
		local f = new_fifo("foo", "bar")
		assert.same(2, f:length())
		f:push("baz")
		assert.same(3, f:length())
		f:pop()
		f:pop()
		f:pop()
		assert.same(0, f:length())
	end)
	if _VERSION > "Lua 5.1" then
		it("length operator works", load([[
			local new_fifo = require "fifo"
			local f = new_fifo("foo", "bar")
			assert.same(2, #f)
			f:push("baz")
			assert.same(3, #f)
			f:pop()
			f:pop()
			f:pop()
			assert.same(0, #f)
		]], nil, "t", _ENV)) -- luacheck: ignore 113
	end
	it("insert works", function()
		local f = new_fifo("foo")
		f:insert(1, "baz")
		f:insert(f:length()+1, "bar")
		f:insert(f:length(), "corge") -- 2nd from end
		assert.same("baz", f:pop())
		assert.same("foo", f:pop())
		assert.same("corge", f:pop())
		assert.same("bar", f:pop())
		assert.errors(function() f:pop() end)

		f:insert(1, "qux")
		assert.same("qux", f:pop())

		assert.errors(function() f:insert(2, "too far") end)

		assert.errors(function() f:insert(0) end)
	end)
	it("remove works", function()
		local f = new_fifo()

		assert.errors(function() f:remove(1) end)

		f:setempty(function() return "EMPTY" end)
		assert.same("EMPTY", f:remove(1))

		f:push("foo")
		f:push("bar")
		f:push("baz")
		f:push("qux")
		f:push("corge")
		assert.same("baz", f:remove(3))
		assert.same("corge", f:remove(4))
		assert.same("foo", f:remove(1))
		assert.same("qux", f:remove(2))
		assert.same("bar", f:remove(1))
		assert.same(0, f:length())

		assert.errors(function() f:remove(50.5) end)
	end)
end)
