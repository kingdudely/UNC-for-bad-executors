function isprotectedmetatable(object)
	local metatable = getmetatable(object)
	local success = pcall(setmetatable, object, metatable)
	return (not success) and metatable ~= nil
end
