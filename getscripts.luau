function getscripts()
	local scripts = {}

	for _, instance in game:GetDescendants() do
		if instance:IsA("BaseScript") then
			table.insert(scripts, instance)
		end
	end
	
	return scripts
end
