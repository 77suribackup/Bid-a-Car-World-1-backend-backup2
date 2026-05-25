-- ========================================
-- ANIMATION CONTROLLER - Tween Helper
-- ========================================

local AnimationController = {}
local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent.Parent.Theme)

-- ========== TWEEN PROPERTY ==========
function AnimationController:TweenProperty(instance, properties, duration, easing)
	duration = duration or Theme.Animations.Normal
	easing = easing or Theme.Animations.EaseInOutQuad
	
	local tweenInfo = TweenInfo.new(
		duration,
		easing,
		Theme.Animations.EaseInOut
	)
	
	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()
	
	return tween
end

-- ========== FADE IN ==========
function AnimationController:FadeIn(instance, duration)
	duration = duration or Theme.Animations.Normal
	return self:TweenProperty(instance, {BackgroundTransparency = 0}, duration)
end

-- ========== FADE OUT ==========
function AnimationController:FadeOut(instance, duration)
	duration = duration or Theme.Animations.Normal
	return self:TweenProperty(instance, {BackgroundTransparency = 1}, duration)
end

-- ========== SLIDE IN ==========
function AnimationController:SlideIn(instance, direction, distance, duration)
	direction = direction or "Up"
	distance = distance or 50
	duration = duration or Theme.Animations.Normal
	
	local startPos = instance.Position
	local endPos = startPos
	
	if direction == "Up" then
		instance.Position = startPos + UDim2.new(0, 0, 0, distance)
	elseif direction == "Down" then
		instance.Position = startPos - UDim2.new(0, 0, 0, distance)
	elseif direction == "Left" then
		instance.Position = startPos + UDim2.new(0, distance, 0, 0)
	elseif direction == "Right" then
		instance.Position = startPos - UDim2.new(0, distance, 0, 0)
	end
	
	return self:TweenProperty(instance, {Position = endPos}, duration)
end

-- ========== SCALE ANIMATION ==========
function AnimationController:Scale(instance, targetScale, duration)
	duration = duration or Theme.Animations.Normal
	targetScale = targetScale or 1.1
	
	local originalSize = instance.Size
	local newSize = UDim2.new(
		originalSize.X.Scale * targetScale,
		originalSize.X.Offset,
		originalSize.Y.Scale * targetScale,
		originalSize.Y.Offset
	)
	
	return self:TweenProperty(instance, {Size = newSize}, duration)
end

-- ========== PULSE EFFECT ==========
function AnimationController:Pulse(instance, duration)
	duration = duration or Theme.Animations.Normal
	
	-- Scale up
	local scaleUp = self:Scale(instance, 1.1, duration / 2)
	
	scaleUp.Completed:Connect(function()
		-- Scale back down
		self:Scale(instance, 1, duration / 2)
	end)
	
	return scaleUp
end

-- ========== GLOW EFFECT ==========
function AnimationController:Glow(instance, glowColor, duration)
	glowColor = glowColor or Theme.Colors.Primary
	duration = duration or Theme.Animations.Normal
	
	-- Add stroke if not exists
	if not instance:FindFirstChild("UIStroke") then
		local stroke = Instance.new("UIStroke")
		stroke.Color = glowColor
		stroke.Transparency = 1
		stroke.Thickness = 3
		stroke.Parent = instance
	end
	
	local stroke = instance:FindFirstChild("UIStroke")
	return self:TweenProperty(stroke, {Transparency = 0}, duration)
end

-- ========== UNGLOW EFFECT ==========
function AnimationController:UnGlow(instance, duration)
	duration = duration or Theme.Animations.Normal
	
	local stroke = instance:FindFirstChild("UIStroke")
	if stroke then
		return self:TweenProperty(stroke, {Transparency = 1}, duration)
	end
end

-- ========== ROTATE ANIMATION ==========
function AnimationController:Rotate(instance, targetRotation, duration)
	duration = duration or Theme.Animations.Normal
	targetRotation = targetRotation or 360
	
	return self:TweenProperty(instance, {Rotation = targetRotation}, duration)
end

-- ========== BOUNCE ANIMATION ==========
function AnimationController:Bounce(instance, bounceHeight, duration)
	duration = duration or Theme.Animations.Normal
	bounceHeight = bounceHeight or 20
	
	local originalPos = instance.Position
	local upPos = originalPos - UDim2.new(0, 0, 0, bounceHeight)
	
	-- Bounce up
	local bounceUp = self:TweenProperty(instance, {Position = upPos}, duration / 2)
	
	bounceUp.Completed:Connect(function()
		-- Bounce down
		self:TweenProperty(instance, {Position = originalPos}, duration / 2)
	end)
	
	return bounceUp
end

-- ========== MOVE TO POSITION ==========
function AnimationController:MoveTo(instance, targetPosition, duration)
	duration = duration or Theme.Animations.Normal
	
	return self:TweenProperty(instance, {Position = targetPosition}, duration)
end

-- ========== COLOR TRANSITION ==========
function AnimationController:ColorTransition(instance, targetColor, duration)
	duration = duration or Theme.Animations.Normal
	
	return self:TweenProperty(instance, {BackgroundColor3 = targetColor}, duration)
end

return AnimationController