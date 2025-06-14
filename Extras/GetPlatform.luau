local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local function GetPlatform()
	local version, dotCount = version():gsub("%.", ".");
	
	if GuiService.IsWindows then
		if dotCount <= 2 then
			return Enum.Platform.UWP
		end

		return Enum.Platform.Windows
	elseif GuiService:IsTenFootInterface() then
		if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonStart) == "ButtonStart" then
			-- game:FindFirstChild("OneStatFrame", true)
			return Enum.Platform.XboxOne -- Xbox360
		else
			return Enum.Platform.PS5 -- PS4
		end
	end

	return Enum.Platform.Unknown
end
