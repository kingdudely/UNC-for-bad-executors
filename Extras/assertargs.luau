function assertargs(expected, ...) -- expected types
	local varargs = {...}
	
	for nth, validtype in expected do
		local vartype = type(varargs[nth])

		assert(vartype == validtype, `invalid argument #{nth} to '{debug.info(2, "n")}' ({validtype} expected, got {vartype})`)
	end
end
