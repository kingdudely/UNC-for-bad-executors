--[[
local HttpService = game:GetService("HttpService")
HttpService:GenerateGUID():gsub("[^%w_]", "")

			local function geterror(message)
				-- Get everything after the last colon - or just use message if it there are no colons - then trim whitespace characters
				return type(message) == "string" and (message:match(".*:([^:]+)$") or message):match("^%s*(.-)%s*$") or nil
			end
]]

function copyrawmetatable(object)
	local metatable = getmetatable(object)

	-- If there is a metatable but we can't edit it, it's protected
	if metatable ~= nil and not pcall(setmetatable, object, metatable) then
		-- 'x' is added at the beginning so it is valid for most use cases (such as a method name)
		local UUID = 'x' .. math.random(2^31 - 1) -- Math.random max value (int32 max value)

		-- This would be "getmetamethod" but it only returns the metamethod if it is a function and if it errors 
		local function getmetafunction(technique, ...)
			local _, result = xpcall(technique, function(techerror)
				local metafunction = debug.info(2, "f")

				-- If the metafunction is the same as the technique, either the metamethod didn't handle it properly or it doesn't exist
				local ismetafunction = metafunction ~= technique
				return ismetafunction and metafunction or nil
			end, ...)

			return result
		end

		metatable = {
			-- Could be object[nil], but if __index/__newindex does not exist it will say "table index is nil"
			__index = getmetafunction(function() return object[''] end),
			__newindex = getmetafunction(function() object[''] = object[''] end),

			-- Looks complex but it's just running a randomly generated name as a method
			-- (object)
			__namecall = getmetafunction(function() return loadstring(("(...):%s()"):format(UUID)) end, object),
			
			__add = getmetafunction(function() return object + nil end),
			
			-- Could just do typeof(object) == "Instance" but this checks if it is a custom userdata in general (but then again, I think only ROBLOX Instances have __type)
			__type = typeof(object) ~= type(object) and typeof(object) or nil,

			__metatable = metatable
		}
	end

	return metatable
end

local b = setmetatable({}, {
	__add = function(a, b, c) print(a,b,c) return c + b * 1 end,
	__metatable = false
})

print(getrawmetatable(game))
