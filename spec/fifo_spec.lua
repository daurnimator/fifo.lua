local new_fifo = require "fifo"

describe("Everything works.", function()
	it("peek works", function()
		local f = new_fifo()
		f:push("foo")
		assert.same("foo", f:peek())
		f:push("bar")
		assert.same("foo", f:peek())
		assert.same("bar", f:peek(2))
		f:pop()
		assert.same("bar", f:peek())
	end)
end)
