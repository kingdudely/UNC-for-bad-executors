function hookfunction(old, new)
	local env, index = getkenv(old) -- Extras/getkenv

	if index then
		if type(env) == "number" and type(index) == "number" then
			debug.setstack(env, index, new)
		elseif env then
			env[index] = new
		end

		return old
	end

	warn("Hook failed")
end
