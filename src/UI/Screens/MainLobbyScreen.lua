-- ========================================
-- MAIN LOBBY SCREEN - Home Hub
-- ========================================

local MainLobbyScreen = {}
local Theme = require(game.ReplicatedStorage.Modules.UI.Theme)
local UIHelper = require(game.ReplicatedStorage.Modules.UI.Utilities.UIHelper)
local AnimationController = require(game.ReplicatedStorage.Modules.UI.Utilities.AnimationController)
local ButtonFactory = require(game.ReplicatedStorage.Modules.UI.Utilities.ButtonFactory)
local PlayerDataManager = require(game.ReplicatedStorage.Modules.PlayerDataManager)

-- ========== CREATE MAIN LOBBY ==========
function MainLobbyScreen:Create()
	local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	-- Screen GUI
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MainLobby"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndex = 50
	screenGui.Parent = playerGui
	
	-- Background
	local background = UIHelper:CreateRoundedFrame(screenGui, {
		BackgroundColor3 = Theme.Colors.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 1, 0),
	})
	
	-- Add gradient background
	AnimationController:CreateGradient(background, Theme.Gradients.DarkToCyan)
	
	-- ===== TOP BAR =====
	local topBar = UIHelper:CreateRoundedFrame(background, {
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		BackgroundTransparency = 0.2,
		Size = UDim2.new(1, 0, 0, 80),
		Position = UDim2.new(0, 0, 0, 0),
	})
	UIHelper:AddStroke(topBar, Theme.Colors.Primary, 1, 0.5)
	
	local topButtonsContainer = Instance.new("Frame")
	topButtonsContainer.Name = "TopButtons"
	topButtonsContainer.BackgroundTransparency = 1
	topButtonsContainer.Size = UDim2.new(1, -40, 1, 0)
	topButtonsContainer.Position = UDim2.new(0, 20, 0, 0)
	topButtonsContainer.Parent = topBar
	
	UIHelper:CreateListLayout(topButtonsContainer, {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 15),
	})
	
	-- Top buttons: Events, Garage, Shop
	local eventsBtn = ButtonFactory:CreatePrimaryButton(topButtonsContainer, {
		Text = "📅 Events",
		Size = UDim2.new(0, 120, 0, 50),
		OnClick = function()
			print("Events clicked")
		end,
	})
	eventsBtn.LayoutOrder = 1
	
	local garageBtn = ButtonFactory:CreateSecondaryButton(topButtonsContainer, {
		Text = "🏠 Garage",
		Size = UDim2.new(0, 120, 0, 50),
		OnClick = function()
			print("Garage clicked")
		end,
	})
	garageBtn.LayoutOrder = 2
	
	local shopBtn = ButtonFactory:CreatePrimaryButton(topButtonsContainer, {
		Text = "🛍️ Shop",
		Size = UDim2.new(0, 120, 0, 50),
		OnClick = function()
			print("Shop clicked")
		end,
	})
	shopBtn.LayoutOrder = 3
	
	-- Wallet display (top right)
	local walletContainer = UIHelper:CreateRoundedFrame(topBar, {
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		BackgroundTransparency = 0.3,
		Size = UDim2.new(0, 180, 0, 50),
		Position = UDim2.new(1, -200, 0, 15),
		CornerRadius = UDim.new(0, 12),
	})
	
	local walletText = UIHelper:CreateTextLabel(walletContainer, {
		Text = "💰 $700",
		TextColor3 = Theme.Colors.Primary,
		Font = Theme.Fonts.Heading.Font,
		TextSize = 20,
		Size = UDim2.new(1, 0, 1, 0),
	})
	walletText.Parent = walletContainer
	
	-- ===== MAIN CONTENT =====
	local contentArea = Instance.new("Frame")
	contentArea.Name = "ContentArea"
	contentArea.BackgroundTransparency = 1
	contentArea.Size = UDim2.new(1, 0, 1, -80)
	contentArea.Position = UDim2.new(0, 0, 0, 80)
	contentArea.Parent = background
	
	-- Welcome message
	local welcomeLabel = UIHelper:CreateTextLabel(contentArea, {
		Text = "Welcome to Bid A Car World!",
		TextColor3 = Theme.Colors.TextPrimary,
		Font = Theme.Fonts.Title.Font,
		TextSize = 32,
		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.new(0, 0, 0, 30),
	})
	welcomeLabel.TextScaled = true
	
	-- Bid button (center, large)
	local bidButtonContainer = Instance.new("Frame")
	bidButtonContainer.Name = "BidButtonContainer"
	bidButtonContainer.BackgroundTransparency = 1
	bidButtonContainer.Size = UDim2.new(0, 300, 0, 120)
	bidButtonContainer.Position = UDim2.new(0.5, -150, 0.5, -60)
	bidButtonContainer.Parent = contentArea
	
	local bidButton = ButtonFactory:CreatePrimaryButton(bidButtonContainer, {
		Text = "🎯 START BID",
		Size = UDim2.new(1, 0, 1, 0),
		OnClick = function()
			print("Start Bid clicked")
		end,
	})
	bidButton.Name = "BidButton"
	
	-- Pulsing animation
	local pulseLoop = coroutine.create(function()
		while screenGui.Parent do
			AnimationController:Pulse(bidButton, Theme.Animations.Normal)
			wait(Theme.Animations.Normal + 0.5)
		end
	end)
	coroutine.resume(pulseLoop)
	
	-- ===== BOTTOM BUTTONS =====
	local bottomBar = Instance.new("Frame")
	bottomBar.Name = "BottomBar"
	bottomBar.BackgroundColor3 = Theme.Colors.BackgroundTertiary
	bottomBar.BackgroundTransparency = 0.2
	bottomBar.Size = UDim2.new(1, 0, 0, 100)
	bottomBar.Position = UDim2.new(0, 0, 1, -100)
	bottomBar.BorderSizePixel = 0
	bottomBar.Parent = background
	UIHelper:AddStroke(bottomBar, Theme.Colors.Primary, 1, 0.5)
	
	local bottomButtonsContainer = Instance.new("Frame")
	bottomButtonsContainer.Name = "BottomButtons"
	bottomButtonsContainer.BackgroundTransparency = 1
	bottomButtonsContainer.Size = UDim2.new(1, 0, 1, 0)
	bottomButtonsContainer.Parent = bottomBar
	
	UIHelper:CreateListLayout(bottomButtonsContainer, {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 20),
	})
	
	-- Bottom buttons: Inventory, Settings, Profile
	local inventoryBtn = ButtonFactory:CreateIconButton(bottomButtonsContainer, {
		Icon = "❤️",
		Size = UDim2.new(0, 70, 0, 70),
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		OnClick = function()
			print("Inventory clicked")
			-- Show inventory
		end,
	})
	inventoryBtn.LayoutOrder = 1
	
	local settingsBtn = ButtonFactory:CreateIconButton(bottomButtonsContainer, {
		Icon = "⚙️",
		Size = UDim2.new(0, 70, 0, 70),
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		OnClick = function()
			print("Settings clicked")
		end,
	})
	settingsBtn.LayoutOrder = 2
	
	local profileBtn = ButtonFactory:CreateIconButton(bottomButtonsContainer, {
		Icon = "👤",
		Size = UDim2.new(0, 70, 0, 70),
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		OnClick = function()
			print("Profile clicked")
		end,
	})
	profileBtn.LayoutOrder = 3
	
	-- Update wallet display
	local function updateWallet()
		local playerId = game.Players.LocalPlayer.UserId
		local money = PlayerDataManager:GetMoney(playerId) or 700
		walletText.Text = "💰 $" .. money
	end
	updateWallet()
	
	return screenGui
end

return MainLobbyScreen