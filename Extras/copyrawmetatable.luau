function copyrawmetatable(object)
	local metatable = getmetatable(object)

	if metatable ~= nil and not pcall(setmetatable, object, metatable) then
		local random = math.random(2^31 - 1)

		local function getmetafunction(technique, ...)
			local _, metafunction = xpcall(technique, function() return debug.info(2, "f") end, ...)

			return metafunction ~= technique and metafunction or nil
		end

		metatable = {
			__index = getmetafunction(function() return object[''] end),
			__newindex = getmetafunction(function() object[''] = object[''] end),
			__namecall = getmetafunction(loadstring(("(...):%s()"):format('x' .. random)), object),
			
			-- Operators here...
			__add = getmetafunction(function() return object + nil end),

			__type = typeof(object) ~= type(object) and typeof(object) or nil,
			__metatable = metatable
		}
	end

	return metatable
end
