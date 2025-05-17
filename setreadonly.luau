function setreadonly(tbl, readonly)
	assertargs({"table", "boolean"}, tbl, readonly) -- Extras/assertargs

	local function copy(tbl)
		if type(tbl) ~= "table" then
			return tbl   
		end
        
		local clone = table.clone(tbl)
        
		for k, v in clone do
			clone[k] = copy(v)
		end
		
		return clone
	end

	if readonly then
		pcall(table.freeze, tbl)
	else
		local clone = copy(tbl)
		local env, index = getkenv(tbl) -- Extras/getkenv

		if index then
			if type(env) == "number" and type(index) == "number" then
				debug.setstack(env, index, clone)
			elseif env then
				env[index] = clone
			end
		else
			warn("Setting readonly failed")
		end
	end
end
