function unfreeze(table)
    local additions = {}

    return setmetatable({}, {
        __index = function(_, key)
            if additions[key] ~= nil then
                return additions[key]
            end
            
            return table[key]
        end,

        __newindex = function(_, key, value)
            if table[key] ~= nil then
                error(tostring(key) .. " already exists", 2)
            end

            additions[key] = value
        end
    })
end
