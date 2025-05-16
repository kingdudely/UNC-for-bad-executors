local function hookfunction(old, new)
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

    local envs = {
        getfenv(),
        getgenv(),
        _G
    }

    for _, env in envs do
        local name = find(env, old)

        if name then
            env[name] = new
            return old
        end
    end
    
    local success = xpcall(function()
        local stack = debug.getstack(4)
        local index = table.find(stack, old)

        debug.setstack(4, index, new)
    end, function()
        warn("Function hook failed!")    
    end)
    
    return success and old
end
