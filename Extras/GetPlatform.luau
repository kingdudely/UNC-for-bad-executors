local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local function GetPlatform()
    if GuiService.IsWindows then
        return Enum.Platform.Windows
    elseif GuiService:IsTenFootInterface() then
        if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonStart) == "ButtonStart" then
            return Enum.Platform.XboxOne -- Xbox360
        else
            return Enum.Platform.PS5 -- PS4
        end
    end
    
    return Enum.Platform.Unknown
end
