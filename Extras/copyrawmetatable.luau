function copyrawmetatable(object)
	local metatable = getmetatable(object)

	-- If there is a metatable but we can't edit it, it's protected
	if metatable ~= nil and not pcall(setmetatable, object, metatable) then
		-- 'x' is added at the beginning so it is valid for most use cases (such as a method name)
		local UUID = 'x' .. math.random(2^31 - 1) -- Math.random max value (int32 max value)

		-- This would be "getmetamethod" but it only returns the metamethod if it is a function and if it errors 
		local function getmetafunction(technique, ...)
			local _, metafunction = xpcall(technique, function() return debug.info(2, "f") end, ...)

			-- If the metafunction is the same as the technique, either the metamethod didn't handle it properly or it doesn't exist
			-- local ismetafunction
			return metafunction ~= technique and metafunction or nil
		end

		metatable = {
			-- Or object['']
			__index = getmetafunction(function() return object[nil] end),
			__newindex = getmetafunction(function() object[nil] = object[nil] end),

			-- Looks complex but it's just running a randomly generated method
			-- (object)
			__namecall = getmetafunction(loadstring(("(...):%s()"):format(UUID)), object),
			
			__add = getmetafunction(function() return object + nil end),
			
			-- Could just do typeof(object) == "Instance" but this checks if it is a custom userdata in general (but then again, I think only ROBLOX Instances have __type)
			__type = typeof(object) ~= type(object) and typeof(object) or nil,

			__metatable = metatable
		}
	end

	return metatable
end
