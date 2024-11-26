local InvisibilityModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/James-Lol/Invisibility-RBLX/refs/heads/main/InvisibilityModule.Lua"))()
if not InvisibilityModule then
	warn("Failed to load InvisibilityModule.")
	return
end

local ProtectParentModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/James-Lol/Invisibility-RBLX/refs/heads/main/ProtectParentModule.Lua"))()
if not ProtectParentModule then
	warn("Failed to load ProtectParentModule.")
	return
end

if ProtectParentModule.HasGui("Invisibility UI") then return end

local LocalPlayer = game:GetService("Players").LocalPlayer
local PositionAboveVoid = Vector3.new(0, workspace.FallenPartsDestroyHeight + 10, 0)

local Invisibility_UI = Instance.new("ScreenGui")
Invisibility_UI.Name = "Invisibility UI"
Invisibility_UI.IgnoreGuiInset = true
Invisibility_UI.ResetOnSpawn = false
Invisibility_UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Invisibility_UI.Parent = ProtectParentModule.GetParent()

local Toggle = Instance.new("TextButton")
Toggle.Name = "Toggle"
Toggle.Position = UDim2.new(0.438377, 0, 0.0811404, 0)
Toggle.Size = UDim2.new(0.1, 0, 0.1, 0)
Toggle.BackgroundColor3 = Color3.new(0.835294, 0.0901961, 0.117647)
Toggle.BorderSizePixel = 0
Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
Toggle.Text = "Turn Invisible"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.TextSize = 14
Toggle.TextScaled = true
Toggle.TextWrapped = true
Toggle.RichText = true
Toggle.AutoButtonColor = false
Toggle.Parent = Invisibility_UI

local UICorner = Instance.new("UICorner")
UICorner.Parent = Toggle

local ReSync = Instance.new("TextButton")
ReSync.Name = "ReSync"
ReSync.Position = UDim2.new(0.560842, 0, 0.0811404, 0)
ReSync.Size = UDim2.new(0.1, 0, 0.1, 0)
ReSync.BackgroundColor3 = Color3.new(0.835294, 0.0901961, 0.117647)
ReSync.BorderSizePixel = 0
ReSync.AnchorPoint = Vector2.new(0.5, 0.5)
ReSync.Text = "ReSync"
ReSync.TextColor3 = Color3.new(1, 1, 1)
ReSync.TextSize = 14
ReSync.TextScaled = true
ReSync.TextWrapped = true
ReSync.RichText = true
ReSync.AutoButtonColor = false
ReSync.Parent = Invisibility_UI

local UICorner2 = Instance.new("UICorner")
UICorner2.Parent = ReSync

local IsInvisible = false

local function onCharacterAdded(character)
	IsInvisible = false
	Toggle.Text = "Turn Invisible"
	InvisibilityModule.TurnVisible()
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

Toggle.MouseButton1Click:Connect(function()
	IsInvisible = not IsInvisible
	if IsInvisible then
		local Character = LocalPlayer.Character
		Toggle.Text = "Turn Visible"
		if Character then
			local CharacterCframe = Character:GetPivot()
			InvisibilityModule.TurnInvisible(CFrame.new(CharacterCframe.Position.X, PositionAboveVoid.Y, CharacterCframe.Position.Z))
		end
	else
		Toggle.Text = "Turn Invisible"
		InvisibilityModule.TurnVisible()
	end
end)

ReSync.MouseButton1Click:Connect(function()
	InvisibilityModule.Resynchronize()
end)
