function setreadonly(tbl, readonly)
    assert(typeof(tbl) == "table", "table expected, got " .. typeof(tbl))
	assert(typeof(tbl) == "boolean", "boolean expected, got " .. typeof(tbl))
	
	if readonly then
		return table.freeze(tbl)
	else
		if type(tbl) ~= "table" then
			return tbl
		end

		local copy = table.clone(tbl)
    	for k, v in copy do
        	copy[k] = thaw(v)
    	end

    	return copy
	end
end
