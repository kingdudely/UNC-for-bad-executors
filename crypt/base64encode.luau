local HttpService = game:GetService("HttpService")

function crypt.base64encode(data : string) : string
	return HttpService:JSONEncode(buffer.fromstring(data)):match('"z?base64":"(.+)"') -- '"[bz]?base64"%s*:%s*"([^"]+)"'
end
