-- NOT RECOMMENDED FOR USE JUST USE https://devforum.roblox.com/t/3614957

function copyrawmetatable(object)
	local metatable = getmetatable(object)
	local _, __metatable = pcall(rawget, metatable, "__metatable")

	-- If there is a metatable that is uneditable and not equal to its own __metatable, it's protected
	if metatable ~= nil and metatable ~= __metatable and not pcall(setmetatable, object, metatable) then
		local random = math.random(2^31 - 1) -- Math.random max value (int32 max value)

		-- This would be "getmetamethod" but it only returns the metamethod if it is a function and if it errors 
		local function getmetafunction(technique, ...)
			local _, metafunction = xpcall(technique, function() return debug.info(2, "f") end, ...)

			-- If the metafunction is the same as the technique, either the metamethod didn't handle it properly or it doesn't exist
			-- local ismetafunction
			return metafunction ~= technique and metafunction or nil
		end

		metatable = {
			__index = getmetafunction(function() return object[''] end),
			__newindex = getmetafunction(function() object['wefaefa'] = object[nil] end),

			-- Looks complex but it's just running a randomly generated method
			-- 'x' is added at the beginning so it is valid for calling it as a method
			__namecall = getmetafunction(loadstring(("(...):%s()"):format('x' .. random)), object),
			
			-- Operators here...
			__add = getmetafunction(function() return object + nil end),
			---

			-- Could just do typeof(object) == "Instance" but this checks if it is a custom userdata in general (but then again, I think only ROBLOX Instances have __type)
			__type = typeof(object) ~= type(object) and typeof(object) or nil,

			__metatable = metatable
		}
	end

	return metatable
end
