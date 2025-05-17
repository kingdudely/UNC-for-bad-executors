function getscripts()
	local scripts = {}

	for _, instance in game:GetDescendants() do
		if instance:IsA("LuaSourceContainer") then
			local _, enabled = pcall(function() return instance.Enabled end)
			if enabled then -- Module Scripts and enabled scripts
				table.insert(scripts, instance)
			end
		end
	end
	
	return scripts
end
