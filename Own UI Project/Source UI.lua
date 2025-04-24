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
	Frame.Position = UDim2.new(0.201, 0, 0.134, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Frame.BorderSizePixel = 2
	Frame.Parent = ScreenGui

	local FrameTop = Instance.new("Frame")
	FrameTop.Size = UDim2.new(0, 726, 0, 26)
	FrameTop.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	FrameTop.BorderSizePixel = 2
	FrameTop.Parent = Frame

	local axallua = Instance.new("TextLabel")
	axallua.Size = UDim2.new(0, 100, 0, 26)
	axallua.BackgroundTransparency = 1
	axallua.Text = windowName .. " |"
	axallua.Font = Enum.Font.SourceSans
	axallua.TextSize = 14
	axallua.TextColor3 = Color3.fromRGB(255, 255, 255)
	axallua.TextXAlignment = Enum.TextXAlignment.Left
	axallua.Parent = FrameTop

	local aftermath = Instance.new("TextLabel")
	aftermath.Size = UDim2.new(0, 150, 0, 26)
	aftermath.Position = UDim2.new(0.15, 0, 0, 0)
	aftermath.BackgroundTransparency = 1
	aftermath.Text = tag or "aftermath"
	aftermath.Font = Enum.Font.SourceSans
	aftermath.TextSize = 14
	aftermath.TextColor3 = Color3.fromRGB(127, 35, 255)
	aftermath.TextXAlignment = Enum.TextXAlignment.Left
	aftermath.Parent = FrameTop

	local Beta = Instance.new("TextLabel")
	Beta.Size = UDim2.new(0, 100, 0, 26)
	Beta.Position = UDim2.new(1, -100, 0, 0)
	Beta.BackgroundTransparency = 1
	Beta.Text = "Beta"
	Beta.Font = Enum.Font.SourceSans
	Beta.TextSize = 14
	Beta.TextColor3 = Color3.fromRGB(112, 112, 112)
	Beta.TextXAlignment = Enum.TextXAlignment.Right
	Beta.Parent = FrameTop

	self.MainFrame = Frame
	self.Tabs = {}
	self.TabButtons = {}

	return self
end

function UILib:CreateTab(name)
	local tabFrame = Instance.new("Frame")
	tabFrame.Size = UDim2.new(0, 726, 0, 575)
	tabFrame.Position = UDim2.new(0, 0, 0, 26)
	tabFrame.BackgroundTransparency = 1
	tabFrame.Visible = false
	tabFrame.Name = name
	tabFrame.Parent = self.MainFrame

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 100, 0, 26)
	button.Position = UDim2.new(0, (#self.TabButtons) * 100, 0, 0)
	button.Text = name
	button.Font = Enum.Font.SourceSans
	button.TextSize = 14
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	button.BorderSizePixel = 0
	button.Parent = self.MainFrame:FindFirstChildOfClass("Frame")

	button.MouseButton1Click:Connect(function()
		for _, t in pairs(self.Tabs) do t.Visible = false end
		tabFrame.Visible = true
	end)

	table.insert(self.Tabs, tabFrame)
	table.insert(self.TabButtons, button)

	if #self.Tabs == 1 then
		tabFrame.Visible = true
	end

	return tabFrame
end

function UILib:CreateButton(parentTab, text, callback)
	local padding = 10
	local spacing = 40
	local btnCount = 0

	for _, child in ipairs(parentTab:GetChildren()) do
		if child:IsA("TextButton") then
			btnCount += 1
		end
	end

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 250, 0, 32)
	button.Position = UDim2.new(0, padding, 0, padding + (btnCount * spacing))
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.TextColor3 = Color3.fromRGB(220, 220, 220)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.BorderColor3 = Color3.fromRGB(20, 20, 20)
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
