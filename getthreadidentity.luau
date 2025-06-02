local LogService = game:GetService("LogService")

function getthreadidentity() : number
	local identity

	LogService.MessageOut:Once(function(message)
		identity = message:match("%d+")
	end)

	printidentity("")

	repeat task.wait() until identity

	return identity
end
