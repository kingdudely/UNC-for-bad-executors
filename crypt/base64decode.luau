local HttpService = game:GetService("HttpService")

function crypt.base64decode(data : string) : string
	return buffer.tostring(HttpService:JSONDecode(`\{"m":null,"t":"buffer","base64":"{Input}"\}`))
end
