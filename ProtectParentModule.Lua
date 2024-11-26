local ParentModule = {}

local function GenerateRandomString()
    local Length = math.random(10, 20)
    local CharArray = {}
    for i = 1, Length do
        CharArray[i] = string.char(math.random(32, 126))
    end
    return table.concat(CharArray)
end

local function GetCoreGui()
    return game:GetService("CoreGui")
end

function ParentModule.GetParent()
    local CoreGui = GetCoreGui()
    local HiddenUI = get_hidden_gui or gethui
    local ParentInstance

    if HiddenUI then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = GenerateRandomString()
        ScreenGui.Parent = HiddenUI()
        ParentInstance = ScreenGui
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = GenerateRandomString()
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
        ParentInstance = ScreenGui
    elseif CoreGui:FindFirstChild("RobloxGui") then
        ParentInstance = CoreGui.RobloxGui
    else
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = GenerateRandomString()
        ScreenGui.Parent = CoreGui
        ParentInstance = ScreenGui
    end

    return ParentInstance
end

return ParentModule