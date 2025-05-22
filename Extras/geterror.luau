local function geterror(message)
	-- Get everything after the last colon - or just use message if it there are no colons - then trim whitespace characters
	return type(message) == "string" and (message:match(".*:([^:]+)$") or message):match("^%s*(.-)%s*$") or nil
end
