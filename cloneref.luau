function cloneref(object)
	local proxy = newproxy(true)
	local metatable = getmetatable(proxy)

	local metamethods = {
		type      = typeof(object),
		newindex  = object,
		metatable = getmetatable(object),
		tostring  = function() return tostring(object) end,
		call      = function() return object() end,
		unm       = function() return -object end,
		len       = function() return #object end,
		index     = function(_, key)
			local value = object[key]

			if type(value) == "function" then
				return function(_, ...)
					return value(object, ...)
				end
			end

			return value
		end,
	}

	local operators = {
		add     = "+",
		sub     = "-",
		mul     = "*",
		div     = "/",
		idiv    = "//",
		mod     = "%",
		pow     = "^", 
		eq      = "==",
		lt      = "<",
		le      = "<=",
		concat  = "..",
	}

	for name, operator in operators do
		metamethods[name] = function(_, object1)
			return loadstring(
				([[local objects = {...}; 
			      
			      return objects[1] %s objects[2]
			    ]]):format(operator))(object, object1)
		end
	end

	for name, value in metamethods do
		metatable["__" .. name] = value
	end

	return proxy
end
