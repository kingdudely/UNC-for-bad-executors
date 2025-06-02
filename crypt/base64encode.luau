local HttpService = game:GetService("HttpService")

function crypt.base64encode(data : string) : string
	return HttpService:JSONEncode(buffer.fromstring(Input)):sub(34, -3)
end
