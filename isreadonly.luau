function isreadonly(table)
	assertargs({"table"}, table) -- Extras/assertargs
	return not pcall(rawset, table, 1, table[1])
end
