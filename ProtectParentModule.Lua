local ParentModule = {}

local function GetCoreGui()
    return game:GetService("CoreGui")
end

function ParentModule.GetParent()
    local CoreGui = GetCoreGui()
    local HiddenUI = get_hidden_gui or gethui
    local ParentInstance

    if HiddenUI then
        print("Using get_hidden_gui or gethui")
        ParentInstance = HiddenUI()
    elseif syn and syn.protect_gui and not is_sirhurt_closure then
        print("Using syn.protect_gui")
        syn.protect_gui(CoreGui)
        ParentInstance = CoreGui
    elseif CoreGui:FindFirstChild("RobloxGui") then
        print("Using RobloxGui")
        ParentInstance = CoreGui:FindFirstChild("RobloxGui")
    else
        print("Using CoreGui directly")
        ParentInstance = CoreGui
    end

    return ParentInstance
end

function ParentModule.HasGui(GuiName)
    local ParentInstance = ParentModule.GetParent()
    return ParentInstance:FindFirstChild(GuiName) ~= nil
end

return ParentModule
