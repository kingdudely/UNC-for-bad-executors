local fenv = getfenv()

do
    _G.ENV = _G.ENV or setmetatable({}, {
        __index = rawget,
        __newindex = function(t, k, v)
            rawset(t, k, v)
            rawset(fenv, k, v)
        end
    })

    local genv = _G.ENV
    
    for k, v in genv do
        fenv[k] = v
    end
    
    function getgenv()
        return genv
    end
end
