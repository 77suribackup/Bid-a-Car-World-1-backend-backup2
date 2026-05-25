-- ========================================
-- BUTTON FACTORY - Reusable Button Creator
-- ========================================

local ButtonFactory = {}
local Theme = require(script.Parent.Parent.Theme)
local UIHelper = require(script.Parent.UIHelper)
local AnimationController = require(script.Parent.AnimationController)

-- ========== CREATE PRIMARY BUTTON ==========
function ButtonFactory:CreatePrimaryButton(parent, properties)
	properties = properties or {}
	
	local button = UIHelper:CreateRoundedFrame(parent, {
		BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.Primary,
		Size = properties.Size or Theme.Sizes.ButtonLarge,
		Position = properties.Position or UDim2.new(0, 0, 0, 0),
		CornerRadius = UDim.new(0, 12),
	})
	
	-- Add text
	local textLabel = Instance.new("TextLabel")
	textLabel.Text = properties.Text or "Button"
	textLabel.TextColor3 = Theme.Colors.Background
	textLabel.TextSize = 18
	textLabel.Font = Theme.Fonts.Button.Font
	textLabel.BackgroundTransparency = 1
	textLabel.BorderSizePixel = 0
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.Parent = button
	
	-- Add hover effect
	button.MouseEnter:Connect(function()
		AnimationController:Scale(button, 1.05, Theme.Animations.VeryFast)
		AnimationController:ColorTransition(button, Theme.Colors.PrimaryLight, Theme.Animations.VeryFast)
	end)
	
	button.MouseLeave:Connect(function()
		AnimationController:Scale(button, 1, Theme.Animations.VeryFast)
		AnimationController:ColorTransition(button, properties.BackgroundColor3 or Theme.Colors.Primary, Theme.Animations.VeryFast)
	end)
	
	-- Click callback
	if properties.OnClick then
		button.MouseButton1Click:Connect(properties.OnClick)
	end
	
	button.LayoutOrder = properties.LayoutOrder or 0
	return button
end

-- ========== CREATE SECONDARY BUTTON ==========
function ButtonFactory:CreateSecondaryButton(parent, properties)
	properties = properties or {}
	properties.BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.Secondary
	return self:CreatePrimaryButton(parent, properties)
end

-- ========== CREATE OUTLINE BUTTON ==========
function ButtonFactory:CreateOutlineButton(parent, properties)
	properties = properties or {}
	
	local button = UIHelper:CreateRoundedFrame(parent, {
		BackgroundColor3 = Theme.Colors.Background,
		BackgroundTransparency = 0.1,
		Size = properties.Size or Theme.Sizes.ButtonLarge,
		Position = properties.Position or UDim2.new(0, 0, 0, 0),
		CornerRadius = UDim.new(0, 12),
		StrokeColor = properties.StrokeColor or Theme.Colors.Primary,
		StrokeThickness = 2,
	})
	
	-- Add text
	local textLabel = Instance.new("TextLabel")
	textLabel.Text = properties.Text or "Button"
	textLabel.TextColor3 = properties.TextColor3 or Theme.Colors.Primary
	textLabel.TextSize = 18
	textLabel.Font = Theme.Fonts.Button.Font
	textLabel.BackgroundTransparency = 1
	textLabel.BorderSizePixel = 0
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.Parent = button
	
	-- Add hover effect
	button.MouseEnter:Connect(function()
		AnimationController:Scale(button, 1.05, Theme.Animations.VeryFast)
		button.BackgroundTransparency = 0
	end)
	
	button.MouseLeave:Connect(function()
		AnimationController:Scale(button, 1, Theme.Animations.VeryFast)
		button.BackgroundTransparency = 0.1
	end)
	
	-- Click callback
	if properties.OnClick then
		button.MouseButton1Click:Connect(properties.OnClick)
	end
	
	button.LayoutOrder = properties.LayoutOrder or 0
	return button
end

-- ========== CREATE ICON BUTTON ==========
function ButtonFactory:CreateIconButton(parent, properties)
	properties = properties or {}
	
	local button = UIHelper:CreateRoundedFrame(parent, {
		BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.BackgroundTertiary,
		Size = properties.Size or UDim2.new(0, 50, 0, 50),
		Position = properties.Position or UDim2.new(0, 0, 0, 0),
		CornerRadius = UDim.new(0, 12),
	})
	
	-- Add icon
	local icon = Instance.new("TextLabel")
	icon.Text = properties.Icon or "🎮"
	icon.TextSize = 30
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Size = UDim2.new(1, 0, 1, 0)
	icon.Parent = button
	
	-- Add hover effect
	button.MouseEnter:Connect(function()
		AnimationController:Scale(button, 1.1, Theme.Animations.VeryFast)
	end)
	
	button.MouseLeave:Connect(function()
		AnimationController:Scale(button, 1, Theme.Animations.VeryFast)
	end)
	
	-- Click callback
	if properties.OnClick then
		button.MouseButton1Click:Connect(properties.OnClick)
	end
	
	return button
end

-- ========== CREATE DISABLED BUTTON ==========
function ButtonFactory:CreateDisabledButton(parent, properties)
	properties = properties or {}
	
	local button = self:CreatePrimaryButton(parent, properties)
	button.BackgroundColor3 = Theme.Colors.TextDisabled
	button.BackgroundTransparency = 0.7
	
	-- Disable interaction
	button.MouseButton1Click:Connect(function() end)
	
	return button
end

return ButtonFactory