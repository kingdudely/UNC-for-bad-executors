function getkenv(object)
	local function find(table, value)
		for k, v in table do
			if v == value then
				return k, v
			elseif type(v) == "table" then
				k, v = find(v, value)
    
				if k and v then
					return k, v
				end
			end
		end
	end

	local senvs = getrunningscripts()
	for k, v in senvs do
		senvs[k] = getsenv(v)
	end
    
	local envs = {
		_G,
		getgenv(),
		getrenv(),
		senvs,
		getfenv(),
	}

	for _, env in envs do
		local name = find(env, object)
		
		if name then
			return env, name
		end
	end
	
	local index
	local level = 2 -- IDK why it should be 2
	
	while true do
		local success, stack = pcall(debug.getstack, level)
	    
		if not success then
			level -= 3 -- Change level so it is compatible with new environment
			break
		end
	    
		index = table.find(stack, object)
		level += 1
	    
		-- task.wait()
	end
	
	return level, index
end
