local fenv = getfenv()

local genv = _G.ENV
genv = type(genv) == "table" and genv or {}
_G.ENV = genv

function getgenv()
	return setmetatable({}, {
		__index = function(_, k) return genv[k] end,
		__newindex = function(_, key, value)
			genv[key] = value
			fenv[key] = value
		end
	})
end
