local HttpService = game:GetService("HttpService")

function crypt.base64decode(data : string) : string
	return buffer.tostring(HttpService:JSONDecode(`\{"m":null,"t":"buffer","{Text:match("^KLUv/") and "zbase64" or "base64"}":"{Text}"\}`))
end
