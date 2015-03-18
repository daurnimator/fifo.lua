A lua library/'class' that implements a FIFO.
Objects in the fifo can be of any type, including `nil`.

Compatible with Lua 5.0, 5.1, 5.2, 5.3 and LuaJIT


# Documentation

Please see the `doc/` folder.

You can generate a man page using [pandoc](http://pandoc.org/):

```
pandoc doc/index.md -s -t man -o /usr/local/share/man/man3/fifo.lua.3
```


# Installation

Available via luarocks: `luarocks install fifo`

Alternatively, you may just copy fifo.lua to your own project.


# Tests

Use [`busted`](http://olivinelabs.com/busted/) to run tests.


# History

This was previously a component of [lomp](https://github.com/daurnimator/lomp2)
but was useful enough in other projects that I split it out.
