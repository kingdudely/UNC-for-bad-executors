function checktypes(types, ...)
	local varargs = {...}
	
	for nth, type in types do
		local selectedtype = typeof(varargs[nth])

		assert(selectedtype == type, `invalid argument #{nth} to '{debug.info(2, "n")}' ({type} expected, got {selectedtype})`)
	end
end

-- checktypes({"table"}, {}) Good
-- checktypes({"number", "string"}, 1, 2) Error
