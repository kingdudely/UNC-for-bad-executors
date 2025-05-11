local genv = getgenv()

function thaw(tbl)
    if type(tbl) ~= "table" then
        return tbl
    end

    local copy = table.clone(tbl)
    for k, v in copy do
        copy[k] = thaw(v)
    end

    return copy
end

genv.table = thaw(table)
genv.table.thaw = thaw
genv.table = table.freeze(table)
