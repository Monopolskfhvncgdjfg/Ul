local UILib = {}
UILib.__index = UILib

function UILib:CreateWindow(windowName, tag)
	local self = setmetatable({}, UILib)

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "AxalUILib"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, 726, 0, 601)
	Frame.Position = UDim2.new(0.5, -363, 0.5, -300)
	Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Frame.BorderSizePixel = 0
	Frame.Parent = ScreenGui

	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 26)
	TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	TopBar.BorderSizePixel = 0
	TopBar.Parent = Frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(0.3, 0, 1, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = windowName .. " |"
	titleLabel.Font = Enum.Font.Gotham
	titleLabel.TextSize = 14
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Position = UDim2.new(0, 10, 0, 0)
	titleLabel.Parent = TopBar

	local tagLabel = Instance.new("TextLabel")
	tagLabel.Size = UDim2.new(0.3, 0, 1, 0)
	tagLabel.BackgroundTransparency = 1
	tagLabel.Text = tag or "aftermath"
	tagLabel.Font = Enum.Font.Gotham
	tagLabel.TextSize = 14
	tagLabel.TextColor3 = Color3.fromRGB(127, 35, 255)
	tagLabel.TextXAlignment = Enum.TextXAlignment.Left
	tagLabel.Position = UDim2.new(0.2, 0, 0, 0)
	tagLabel.Parent = TopBar

	local betaLabel = Instance.new("TextLabel")
	betaLabel.Size = UDim2.new(0, 80, 1, 0)
	betaLabel.Position = UDim2.new(1, -90, 0, 0)
	betaLabel.BackgroundTransparency = 1
	betaLabel.Text = "Beta"
	betaLabel.Font = Enum.Font.Gotham
	betaLabel.TextSize = 14
	betaLabel.TextColor3 = Color3.fromRGB(112, 112, 112)
	betaLabel.TextXAlignment = Enum.TextXAlignment.Right
	betaLabel.Parent = TopBar

	self.MainFrame = Frame
	self.Tabs = {}
	self.TabButtons = {}

	return self
end

function UILib:CreateTab(name)
	local tabFrame = Instance.new("Frame")
	tabFrame.Size = UDim2.new(1, 0, 1, -26)
	tabFrame.Position = UDim2.new(0, 0, 0, 26)
	tabFrame.BackgroundTransparency = 1
	tabFrame.Visible = false
	tabFrame.Name = name
	tabFrame.Parent = self.MainFrame

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 100, 0, 26)
	btn.Position = UDim2.new(0, #self.TabButtons * 100, 0, 0)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	btn.BorderSizePixel = 0
	btn.Parent = self.MainFrame:FindFirstChildWhichIsA("Frame")

	btn.MouseButton1Click:Connect(function()
		for _, t in pairs(self.Tabs) do
			t.Visible = false
		end
		tabFrame.Visible = true
	end)

	table.insert(self.Tabs, tabFrame)
	table.insert(self.TabButtons, btn)

	if #self.Tabs == 1 then
		tabFrame.Visible = true
	end

	return tabFrame
end

function UILib:CreateButton(parentTab, text, callback)
	local spacing = 40
	local btnCount = 0

	for _, child in ipairs(parentTab:GetChildren()) do
		if child:IsA("TextButton") then
			btnCount += 1
		end
	end

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 250, 0, 32)
	button.Position = UDim2.new(0, 20, 0, 20 + (btnCount * spacing))
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.TextColor3 = Color3.fromRGB(230, 230, 230)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.BorderColor3 = Color3.fromRGB(60, 60, 60)
	button.BorderSizePixel = 1
	button.AutoButtonColor = false
	button.Parent = parentTab

	-- Hover effect
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end)

	button.MouseButton1Click:Connect(function()
		if callback then
			callback()
		end
	end)
end

return UILib
