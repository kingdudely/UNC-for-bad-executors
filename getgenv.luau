local fenv = getfenv()

local genv = _G.globalEnv
genv = type(genv) == "table" and genv or {}
_G.globalEnv = genv

function getgenv()
	return setmetatable({}, {
		__index = function(_, k) return genv[k] end,
		__newindex = function(_, key, value)
			genv[key] = value
			fenv[key] = value
		end
	})
end
