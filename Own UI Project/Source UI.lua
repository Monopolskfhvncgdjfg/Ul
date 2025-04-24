local UILib = {}
UILib.__index = UILib

function UILib:CreateWindow(windowName, tag)
	local self = setmetatable({}, UILib)

	-- Créer l'interface principale
	local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
	screenGui.Name = "CustomUILib"

	local mainFrame = Instance.new("Frame", screenGui)
	mainFrame.Size = UDim2.new(0, 600, 0, 400)
	mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
	mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	local titleLabel = Instance.new("TextLabel", mainFrame)
	titleLabel.Text = windowName .. " | " .. tag
	titleLabel.Size = UDim2.new(1, 0, 0, 30)
	titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	self.MainFrame = mainFrame
	self.Tabs = {}

	return self
end

function UILib:CreateTab(tabName)
	local tab = Instance.new("Frame", self.MainFrame)
	tab.Name = tabName
	tab.Size = UDim2.new(1, 0, 1, -30)
	tab.Position = UDim2.new(0, 0, 0, 30)
	tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	tab.Visible = true -- tu peux ajouter un système de switch

	local tabLabel = Instance.new("TextLabel", tab)
	tabLabel.Text = tabName
	tabLabel.Position = UDim2.new(0, 10, 0, 10)
	tabLabel.Size = UDim2.new(0, 200, 0, 20)
	tabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabLabel.BackgroundTransparency = 1

	table.insert(self.Tabs, tab)

	return tab
end

return UILib
