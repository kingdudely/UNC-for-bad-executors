_G.ENV = type(_G.ENV) == "table" and _G.ENV or {
	getgenv = function()
		return _G.ENV	
	end,
}

while task.wait() do
	for k, v in _G.ENV do
		getfenv()[k] = v
	end
end
