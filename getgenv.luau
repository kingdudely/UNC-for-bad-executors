if not _G.__GENV then
    local genv = {}
    setmetatable(genv, {
        __index = _G,
        __newindex = rawset
    })
    _G.__GENV = genv
end

function getgenv()
    return _G.__GENV
end

local env = getfenv(1)
setmetatable(env, {
    __index = getgenv(),
    __newindex = function(_, k, v)
        getgenv()[k] = v
    end
})

setfenv(1, env)
