local genv = getgenv()

function unfreeze(table)
    return setmetatable({}, {
        __index = function(t, k)
            local modified = rawget(t, k)

            return modified ~= nil and modified or table[k] -- original
        end,

        __newindex = rawset
    })
end

genv.table = unfreeze(table)
genv.table.unfreeze = unfreeze
genv.table = table.freeze(table)
