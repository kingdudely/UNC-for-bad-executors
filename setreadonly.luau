local function setreadonly(tbl, readonly)
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
    
	assert(typeof(tbl) == "table", "table expected, got " .. typeof(tbl))
	assert(typeof(readonly) == "boolean", "boolean expected, got " .. typeof(readonly))
	
	if readonly then
		table.freeze(tbl)
	else
		local clone = copy(tbl)
		local level, index = getkenv(tbl)

		debug.setstack(level, index, clone) -- Extras/getkenv
	end
end
