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
	
	local success, index = pcall(function()
		local stack = debug.getstack(4)
        local index = table.find(stack, object)
    	
        return index
	end)
	
	return nil, (success and index)
end
