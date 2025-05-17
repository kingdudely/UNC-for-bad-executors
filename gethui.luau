function gethui()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local PlayerGui = LocalPlayer.PlayerGui
	local success, RobloxGui = pcall(function() return game:GetService("CoreGui"):FindFirstChild("RobloxGui") end) -- IDK why not just Coregui

	return cloneref(success and RobloxGui or PlayerGui)
end
