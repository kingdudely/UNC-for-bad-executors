local function find(t, x)
    for k, v in t do
        if v == x then
            return t, k, v
        elseif type(v) == "table" then
            t, k, v = find(v, x)

            if k and v then
                return t, k, v
            end
        end
    end
end
