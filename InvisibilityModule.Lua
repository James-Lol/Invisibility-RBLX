local LocalPlayer = game:GetService("Players").LocalPlayer
local InvisibleSeat = nil
local AvatarTransparency = 0
local PreviousHideCFrame = CFrame.new(0, 0, 0)
local IsVisible = true

local InvisibilityModule = {}

local function SetupAvatarTransparency()
	coroutine.wrap(function()
		game:GetService("RunService").Heartbeat:Connect(function()
			if LocalPlayer.Character then
				for _, Part in pairs(LocalPlayer.Character:GetDescendants()) do
					if Part:IsA("BasePart") then
						Part.LocalTransparencyModifier = AvatarTransparency
					elseif Part:IsA("Decal") then
						Part.Transparency = AvatarTransparency
					elseif Part:IsA("Texture") then
						Part.Transparency = AvatarTransparency
					end
				end
			end
		end)
	end)()
end

local function GenerateRandomString(Length)
	local Characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local Result = {}
	for Index = 1, Length do
		local RandomIndex = math.random(1, #Characters)
		Result[Index] = Characters:sub(RandomIndex, RandomIndex)
	end
	return table.concat(Result)
end

function InvisibilityModule.TurnVisible()
	print("Turning Visible")
	IsVisible = true
	AvatarTransparency = 0
	if InvisibleSeat then
		InvisibleSeat:Destroy()
		InvisibleSeat = nil
	end
end

function InvisibilityModule.TurnInvisible(HideCFrame)
	print("Turning Invisible")
	if not HideCFrame then return false end

	PreviousHideCFrame = HideCFrame
	IsVisible = false

	InvisibilityModule.TurnVisible()

	local Character = LocalPlayer.Character
	if not Character then return false end
	local Torso = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")
	if not Torso then return false end

	local OriginalCharacterCFrame = Character:GetPivot()

	for i = 0, 5, 1 do
		Character:PivotTo(HideCFrame)
		task.wait(0.01)
	end

	Character:PivotTo(HideCFrame)

	InvisibleSeat = Instance.new("Seat")
	InvisibleSeat.Parent = game:GetService("Workspace")
	InvisibleSeat.Name = GenerateRandomString(250)
	InvisibleSeat.Anchored = false
	InvisibleSeat.CanCollide = false
	InvisibleSeat.CanQuery = false
	InvisibleSeat.CanTouch = false
	InvisibleSeat.Transparency = 1
	InvisibleSeat.CFrame = OriginalCharacterCFrame

	local Weld = Instance.new("Weld", InvisibleSeat)
	Weld.Part0 = InvisibleSeat
	Weld.Part1 = Torso

	Character:PivotTo(OriginalCharacterCFrame)

	AvatarTransparency = 0.9

	return true
end

function InvisibilityModule.Resynchronize()
	if IsVisible then
		InvisibilityModule.TurnVisible()
	else
		InvisibilityModule.TurnInvisible(PreviousHideCFrame)
	end
end

SetupAvatarTransparency()

return InvisibilityModule
