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

function UILib:CreateButton(tab, text, callback)
	local y = #tab:GetChildren() * 40

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 250, 0, 32)
	button.Position = UDim2.new(0, 20, 0, y + 20)
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.TextColor3 = Color3.fromRGB(230, 230, 230)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.BorderSizePixel = 1
	button.BorderColor3 = Color3.fromRGB(60, 60, 60)
	button.AutoButtonColor = false
	button.Parent = tab

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end)

	button.MouseButton1Click:Connect(function()
		callback()
	end)
end

function UILib:CreateToggle(tab, text, default, callback)
	local y = #tab:GetChildren() * 40

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 200, 0, 32)
	label.Position = UDim2.new(0, 20, 0, y + 20)
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = tab

	local box = Instance.new("TextButton")
	box.Size = UDim2.new(0, 20, 0, 20)
	box.Position = UDim2.new(0, 230, 0, y + 26)
	box.BackgroundColor3 = default and Color3.fromRGB(127, 35, 255) or Color3.fromRGB(25, 25, 25)
	box.BorderColor3 = Color3.fromRGB(50, 50, 50)
	box.Text = ""
	box.Parent = tab

	local toggled = default

	box.MouseButton1Click:Connect(function()
		toggled = not toggled
		box.BackgroundColor3 = toggled and Color3.fromRGB(127, 35, 255) or Color3.fromRGB(25, 25, 25)
		callback(toggled)
	end)
end

function UILib:CreateDropdown(tab, text, options, callback)
	local y = #tab:GetChildren() * 40

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 200, 0, 32)
	label.Position = UDim2.new(0, 20, 0, y + 20)
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = tab

	local dropdown = Instance.new("TextButton")
	dropdown.Size = UDim2.new(0, 150, 0, 28)
	dropdown.Position = UDim2.new(0, 230, 0, y + 24)
	dropdown.Text = "Select"
	dropdown.Font = Enum.Font.Gotham
	dropdown.TextSize = 14
	dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
	dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	dropdown.BorderColor3 = Color3.fromRGB(50, 50, 50)
	dropdown.Parent = tab

	local open = false
	local optionFrame = Instance.new("Frame")
	optionFrame.Size = UDim2.new(0, 150, 0, #options * 25)
	optionFrame.Position = dropdown.Position + UDim2.new(0, 0, 1, 0)
	optionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	optionFrame.BorderSizePixel = 1
	optionFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
	optionFrame.Visible = false
	optionFrame.Parent = tab

	for i, opt in pairs(options) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 25)
		btn.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
		btn.Text = opt
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 14
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		btn.BorderSizePixel = 0
		btn.Parent = optionFrame

		btn.MouseButton1Click:Connect(function()
			dropdown.Text = opt
			optionFrame.Visible = false
			open = false
			callback(opt)
		end)
	end

	dropdown.MouseButton1Click:Connect(function()
		open = not open
		optionFrame.Visible = open
	end)
end

function UILib:CreateColorPicker(tab, text, callback)
	local y = #tab:GetChildren() * 40

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 200, 0, 32)
	label.Position = UDim2.new(0, 20, 0, y + 20)
	label.Text = text .. " (RGB)"
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = tab

	local inputs = {}
	for i, channel in ipairs({"R", "G", "B"}) do
		local box = Instance.new("TextBox")
		box.Size = UDim2.new(0, 40, 0, 24)
		box.Position = UDim2.new(0, 230 + (i - 1) * 45, 0, y + 26)
		box.Text = "0"
		box.Font = Enum.Font.Gotham
		box.TextSize = 14
		box.TextColor3 = Color3.fromRGB(255, 255, 255)
		box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		box.BorderColor3 = Color3.fromRGB(60, 60, 60)
		box.Parent = tab
		inputs[channel] = box
	end

	local function updateColor()
		local r = tonumber(inputs.R.Text) or 0
		local g = tonumber(inputs.G.Text) or 0
		local b = tonumber(inputs.B.Text) or 0
		callback(Color3.fromRGB(r, g, b))
	end

	for _, box in pairs(inputs) do
		box.FocusLost:Connect(updateColor)
	end
end

-- Permet de bouger le GUI avec la souris
function UILib:EnableDragging()
	local UIS = game:GetService("UserInputService")
	local dragging, dragInput, dragStart, startPos
	local gui = self.MainFrame

	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- Permet de cacher / afficher avec RightShift
function UILib:BindToggleKey()
	local UIS = game:GetService("UserInputService")
	local gui = self.MainFrame
	local visible = true

	UIS.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
			visible = not visible
			gui.Visible = visible
		end
	end)
end

return UILib
