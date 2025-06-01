function debug.getinfo(level, options)
    options = options or "slnafu"
    local result = {}

    -- Blud thinks this is CSS
    local 
    short_src,
    currentline,
    name,
    numparams,
    is_vararg,
    func = debug.info(level, "slnaf")

    local what = iscclosure(level) and "C" or "Lua"

    local source = "@" .. short_src
    local nups = -1 -- Number of up values

    local info = {
        s = {
            short_src = short_src,
            source = source,
            what = what
        },

        n = {
            name = name
        },

        l = {
            currentline = currentline
        },

        a = {
            numparams = numparams,
            is_vararg = is_vararg
        },

        f = {
            func = func
        },

        u = {
            nups = nups
        }
    }

    for option in options:gmatch(".") do
        local properties = info[option]

        if type(properties) == "table" then
            for property, value in properties do
                result[property] = value
            end
        end
    end

    return result
end
