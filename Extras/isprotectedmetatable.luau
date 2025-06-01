function isprotectedmetatable(object)
	local metatable = getmetatable(object)
	return metatable ~= nil and not pcall(setmetatable, object, metatable) 
end
