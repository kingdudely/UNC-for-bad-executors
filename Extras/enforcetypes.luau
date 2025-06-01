local function enforcetypes(types, ...)
	local args = {...}

	for nth, expected in types do
		local type = typeof(args[nth])
		local name = debug.info(2, "n"):match(".+") or "main" -- If #functionName <= 0, :match(".+") returns nil

		local message = `%s argument #{nth} to '{name}' ({expected} expected%s)`
		
		assert(type == expected,
			if type == "nil" then
				message:format("missing", "") 
			else 
				message:format("invalid", `, got {type}`)
		)
	end
end

-- enforcetypes({"table"}, {}) Good
-- enforcetypes({"number", "string"}, {}, 2) Error
