local HttpService = game:GetService("HttpService")

function crypt.base64encode(data : string) : string
	local Encoded = HttpService:JSONEncode(buffer.fromstring(data))
	local Buffer = buffer.fromstring(Encoded)
	local Length = buffer.len(Buffer)

	local Base64Length = Length - Offset - 2 
	local Base64Buffer = buffer.create(Base64Length)
	buffer.copy(Base64Buffer, 0, Buffer, Offset, Base64Length)
	
	return buffer.tostring(Base64Buffer)
end
