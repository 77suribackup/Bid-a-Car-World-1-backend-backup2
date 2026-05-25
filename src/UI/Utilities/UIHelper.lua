-- ========================================
-- UI HELPER - Utility Functions
-- ========================================

local UIHelper = {}
local Theme = require(script.Parent.Parent.Theme)

-- ========== CREATE ROUNDED FRAME ==========
function UIHelper:CreateRoundedFrame(parent, properties)
	properties = properties or {}
	
	local frame = Instance.new("Frame")
	frame.BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.BackgroundTertiary
	frame.BackgroundTransparency = properties.BackgroundTransparency or 0
	frame.BorderSizePixel = 0
	frame.Size = properties.Size or UDim2.new(1, 0, 1, 0)
	frame.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	frame.Parent = parent
	
	-- Add rounded corners
	local corner = Instance.new("UICorner")
	corner.CornerRadius = properties.CornerRadius or Theme.Sizes.RadiusMedium
	corner.Parent = frame
	
	-- Add stroke if specified
	if properties.StrokeColor then
		local stroke = Instance.new("UIStroke")
		stroke.Color = properties.StrokeColor
		stroke.Thickness = properties.StrokeThickness or 2
		stroke.Transparency = properties.StrokeTransparency or 0
		stroke.Parent = frame
	end
	
	-- Add padding if specified
	if properties.Padding then
		local padding = Instance.new("UIPadding")
		padding.PaddingTop = properties.Padding
		padding.PaddingBottom = properties.Padding
		padding.PaddingLeft = properties.Padding
		padding.PaddingRight = properties.Padding
		padding.Parent = frame
	end
	
	return frame
end

-- ========== CREATE TEXT LABEL ==========
function UIHelper:CreateTextLabel(parent, properties)
	properties = properties or {}
	
	local label = Instance.new("TextLabel")
	label.Text = properties.Text or "Text"
	label.TextColor3 = properties.TextColor3 or Theme.Colors.TextPrimary
	label.TextSize = properties.TextSize or 16
	label.Font = properties.Font or Theme.Fonts.Body.Font
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.Size = properties.Size or UDim2.new(1, 0, 0, 30)
	label.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	label.TextWrapped = properties.TextWrapped or false
	label.TextScaled = properties.TextScaled or false
	label.Parent = parent
	
	return label
end

-- ========== CREATE IMAGE LABEL ==========
function UIHelper:CreateImageLabel(parent, properties)
	properties = properties or {}
	
	local image = Instance.new("ImageLabel")
	image.Image = properties.Image or ""
	image.BackgroundTransparency = 1
	image.BorderSizePixel = 0
	image.Size = properties.Size or UDim2.new(0, 100, 0, 100)
	image.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	image.ScaleType = properties.ScaleType or Enum.ScaleType.Fit
	image.ImageTransparency = properties.ImageTransparency or 0
	image.Parent = parent
	
	return image
end

-- ========== CREATE LIST LAYOUT ==========
function UIHelper:CreateListLayout(parent, properties)
	properties = properties or {}
	
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = properties.FillDirection or Enum.FillDirection.Vertical
	layout.HorizontalAlignment = properties.HorizontalAlignment or Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = properties.VerticalAlignment or Enum.VerticalAlignment.Top
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = properties.Padding or UDim.new(0, 10)
	layout.Parent = parent
	
	return layout
end

-- ========== CREATE GRID LAYOUT ==========
function UIHelper:CreateGridLayout(parent, properties)
	properties = properties or {}
	
	local layout = Instance.new("UIGridLayout")
	layout.CellSize = properties.CellSize or UDim2.new(0, 100, 0, 100)
	layout.HorizontalAlignment = properties.HorizontalAlignment or Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = properties.VerticalAlignment or Enum.VerticalAlignment.Top
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.FillDirectionMaxSize = properties.FillDirectionMaxSize or 500
	layout.Parent = parent
	
	return layout
end

-- ========== ADD PADDING ==========
function UIHelper:AddPadding(frame, padding)
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = padding
	pad.PaddingBottom = padding
	pad.PaddingLeft = padding
	pad.PaddingRight = padding
	pad.Parent = frame
	return pad
end

-- ========== ADD CORNER RADIUS ==========
function UIHelper:AddCorner(frame, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius or Theme.Sizes.RadiusMedium
	corner.Parent = frame
	return corner
end

-- ========== ADD STROKE ==========
function UIHelper:AddStroke(frame, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Theme.Colors.Primary
	stroke.Thickness = thickness or 2
	stroke.Transparency = transparency or 0
	stroke.Parent = frame
	return stroke
end

-- ========== CREATE GRADIENT ==========
function UIHelper:CreateGradient(frame, gradient)
	gradient = gradient or Theme.Gradients.CyanToPurple
	
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Color = gradient.Color
	uiGradient.Rotation = gradient.Rotation or 0
	uiGradient.Parent = frame
	
	return uiGradient
end

return UIHelper