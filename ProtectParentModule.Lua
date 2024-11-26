local ParentModule = {}

local function GetCoreGui()
	return game:GetService("CoreGui")
end

function ParentModule.GetParent()
	local CoreGui = GetCoreGui()
	local HiddenUI = get_hidden_gui or gethui
	local ParentInstance

	if HiddenUI then
		print("get_hidden_gui")
		ParentInstance = HiddenUI()
	elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
		print("syn.protect_gui")
		syn.protect_gui(CoreGui)
		ParentInstance = CoreGui
	elseif CoreGui:FindFirstChild("RobloxGui") then
		print("RobloxGui")
		ParentInstance = CoreGui:FindFirstChild("RobloxGui")
	else
		print("CoreGui")
		ParentInstance = CoreGui
	end

	return ParentInstance
end

function ParentModule.HasGui(GuiName)
	local ParentInstance = ParentModule.GetParent()
	if ParentInstance:FindFirstChild(GuiName) then
		return true
	end
	return false
end

return ParentModule
