-- Tell luacheck about busted globals
files["spec/"] = {
	new_read_globals = { "describe", "it" };
}
