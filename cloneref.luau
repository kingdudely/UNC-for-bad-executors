function cloneref(instance)
	local obj = newproxy(true)
	local meta = getmetatable(obj)

	local metamethods = {
		__type      = "Instance",
		__newindex  = instance,
		__metatable = getmetatable(instance),
		__tostring  = function() return tostring(instance) end,
		__call      = function() return instance() end,
		__unm       = function() return -instance end,
		__len       = function() return #instance end,
		__index     = function(_, key)
			local selected = instance[key]
			
			if type(selected) == "function" then
				return function(_, ...)
					return selected(instance, ...)
				end
			end
			
			return selected
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
	    concat  = ".."
	}

	for name, operator in operators do
		metamethods["__" .. name] = function(_, other)
		    
			return loadstring(
			    ([[local objects = {...}; 
			      
			      return objects[1] %s objects[2]
			     ]]):format(operator))(instance, other)
		end
	end

	for name, value in metamethods do
		meta[name] = value
	end

	return obj
end
