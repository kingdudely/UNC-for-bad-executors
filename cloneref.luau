function cloneref(instance)
	local metamethods = {
		newindex = instance,
		metatable = getmetatable(instance),
		tostring = function() return tostring(instance) end,
		call = function() return instance() end,
		unm = function() return -instance end,
		len = function() return #instance end,
		concat = "..", add = "+", sub = "-", mul = "*", div = "/", 
		idiv = "//", mod = "%", pow = "^", eq = "==", lt = "<", le = "<=",
	}

	local obj = newproxy(true)
	local obj_meta = getmetatable(obj)
	
	obj_meta.__index = function(t, i)
		local v = instance[i]

		return 
			if type(v) == "function" then
				function(self, ...)
					return v(self and instance, ...)
				end
			else
				v
	end
	
	for method, value in metamethods do
		obj_meta["__" .. method] =
			type(value) == "string" and
				function(_, compare)
					return loadstring(`return {instance}{value}{compare}`)()
				end 
			or
				value
	end
		
	return obj
end
