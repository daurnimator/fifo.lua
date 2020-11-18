A lua library/'class' that implements a FIFO.
Objects in the fifo can be of any type, including `nil`.

Compatible with Lua 5.1, 5.2, 5.3, 5.4 and LuaJIT


# Status

This project has been used in production since 2012.

[![Build Status](https://travis-ci.org/daurnimator/fifo.lua.svg)](https://travis-ci.org/daurnimator/fifo.lua)
[![Coverage Status](https://coveralls.io/repos/daurnimator/fifo.lua/badge.svg?branch=master)](https://coveralls.io/r/daurnimator/fifo.lua?branch=master)


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

You will need

  - [busted](http://olivinelabs.com/busted/)
  - [luacov](https://keplerproject.github.io/luacov/)

Run `busted -c` to run tests
You can then generate a coverage report by running `luacov`
(it will write the report to luacov.report.out)


# History

This was previously a component of [lomp](https://github.com/daurnimator/lomp2)
but was useful enough in other projects that I split it out.
