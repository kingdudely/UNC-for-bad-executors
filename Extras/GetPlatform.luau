-- https://devforum.roblox.com/t/3772157

local sub = string.sub
local match = string.match
local len = string.len
local lower = string.lower

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local TextService = game:GetService("TextService")

local TextSettings = {
	16,
	"SourceSans",
	Vector2.one * 1000,
}

-- char(2 ^ 16 - 1)
local invalidSize = TextService:GetTextSize("\u{FFFF}", unpack(TextSettings))

local function isValidCharacter(character)
	local size = TextService:GetTextSize(character, unpack(TextSettings))
	
	return size.Magnitude ~= invalidSize.Magnitude
end

local function getArchitecture()
	local address = tonumber(sub(tostring{math.huge}, 8))

	if len(tostring(address)) <= 10 then
		return 32
	end

	return 64
end

local function GetPlatform()
	-- Implement Grapejuice and PS4/PS5 detection If you know how to pls tell me bro 🙏🙏
	local version = version()

	local Desktop = match(version, "^0%.") ~= nil
	local Console = GuiService:IsTenFootInterface() or (match(version, "^1%.") ~= nil)
	local Mobile = match(version, "^2%.") ~= nil
	local VR = UserInputService.VREnabled and VRService.VREnabled
	
	if GuiService.IsWindows then
		if Mobile then
			return Enum.Platform.UWP
		elseif Console then -- Not sure if this works
			return Enum.Platform.XBoxOne
		elseif isValidCharacter("\u{E0FF}") then -- Not sure if this works either Lol (Ubuntu)
			return Enum.Platform.Linux
		end

		return Enum.Platform.Windows
	elseif Desktop then
		return Enum.Platform.OSX
	elseif Console then
        -- GetStringForKeyCode
		local ButtonSelect = lower(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect))
	
        if match(ButtonSelect, "ps4") then -- "rbxasset://textures/ui/Controls/PlayStationController/PS4/ButtonTouchpad@2x.png"
			return Enum.Platform.PS4
		elseif match(ButtonSelect, "ps5") then -- "rbxasset://textures/ui/Controls/PlayStationController/PS5/ButtonShare@2x.png"
			return Enum.Platform.PS5
		elseif match(ButtonSelect, "xbox") then -- "rbxasset://textures/ui/Controls/XboxController/ButtonSelect@2x.png"
			return Enum.Platform.XboxOne -- game:FindFirstChild("OneStatFrame", true)?
		end
	elseif Mobile then
		if VR then
			return Enum.Platform.MetaOS
		elseif getArchitecture() == 32 or not isValidCharacter("\u{F8FF}") then
			if not UserInputService.TouchEnabled then
				return Enum.Platform.Linux -- Sober
			end
			
			return Enum.Platform.Android
		end
		
		return Enum.Platform.IOS
	elseif VR then
		-- Other VR platform IDK
	end

	return Enum.Platform.None
end
