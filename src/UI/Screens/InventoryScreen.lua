-- ========================================
-- INVENTORY SCREEN - Items/Cars/Lockers
-- ========================================

local InventoryScreen = {}
local Theme = require(game.ReplicatedStorage.Modules.UI.Theme)
local UIHelper = require(game.ReplicatedStorage.Modules.UI.Utilities.UIHelper)
local AnimationController = require(game.ReplicatedStorage.Modules.UI.Utilities.AnimationController)
local ButtonFactory = require(game.ReplicatedStorage.Modules.UI.Utilities.ButtonFactory)
local PlayerDataManager = require(game.ReplicatedStorage.Modules.PlayerDataManager)

-- ========== CREATE INVENTORY SCREEN ==========
function InventoryScreen:Create(mainLobbyGui, onClose)
	local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	local playerId = game.Players.LocalPlayer.UserId
	
	-- Screen GUI
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "InventoryScreen"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndex = 75
	screenGui.Parent = playerGui
	
	-- Overlay
	local overlay = Instance.new("Frame")
	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	overlay.BackgroundTransparency = 0.3
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.Parent = screenGui
	
	overlay.MouseButton1Click:Connect(function()
		if onClose then onClose() end
	end)
	
	-- Main container
	local container = UIHelper:CreateRoundedFrame(screenGui, {
		BackgroundColor3 = Theme.Colors.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(0.9, 0, 0.85, 0),
		Position = UDim2.new(0.05, 0, 0.075, 0),
		CornerRadius = UDim.new(0, 20),
		Padding = UDim.new(0, 20),
	})
	UIHelper:AddStroke(container, Theme.Colors.Primary, 2, 0.3)
	
	-- Header with top buttons
	local header = Instance.new("Frame")
	header.Name = "Header"
	header.BackgroundTransparency = 1
	header.Size = UDim2.new(1, 0, 0, 70)
	header.Parent = container
	
	UIHelper:CreateListLayout(header, {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.SpaceBetween,
		VerticalAlignment = Enum.VerticalAlignment.Center,
	})
	
	-- Top buttons: Events, Garage, Shop
	local topButtonsContainer = Instance.new("Frame")
	topButtonsContainer.BackgroundTransparency = 1
	topButtonsContainer.Size = UDim2.new(0.5, 0, 1, 0)
	topButtonsContainer.Parent = header
	
	UIHelper:CreateListLayout(topButtonsContainer, {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 10),
	})
	
	local eventsBtn = ButtonFactory:CreateOutlineButton(topButtonsContainer, {
		Text = "📅 Events",
		Size = UDim2.new(0, 100, 0, 50),
		OnClick = function() print("Events") end,
	})
	
	local garageBtn = ButtonFactory:CreateOutlineButton(topButtonsContainer, {
		Text = "🏠 Garage",
		Size = UDim2.new(0, 100, 0, 50),
		OnClick = function() print("Garage") end,
	})
	
	local shopBtn = ButtonFactory:CreateOutlineButton(topButtonsContainer, {
		Text = "🛍️ Shop",
		Size = UDim2.new(0, 100, 0, 50),
		OnClick = function() print("Shop") end,
	})
	
	-- Close button (top right)
	local closeBtn = ButtonFactory:CreateOutlineButton(header, {
		Text = "✕",
		Size = UDim2.new(0, 50, 0, 50),
		OnClick = function()
			AnimationController:FadeOut(container, Theme.Animations.Normal)
			wait(Theme.Animations.Normal)
			screenGui:Destroy()
			if onClose then onClose() end
		end,
	})
	
	-- Tabs
	local tabsContainer = Instance.new("Frame")
	tabsContainer.BackgroundTransparency = 1
	tabsContainer.Size = UDim2.new(1, 0, 0, 50)
	tabsContainer.Position = UDim2.new(0, 0, 0, 80)
	tabsContainer.Parent = container
	
	UIHelper:CreateListLayout(tabsContainer, {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 10),
	})
	
	local currentTab = "cars"
	local contentFrame = Instance.new("Frame")
	contentFrame.Name = "ContentFrame"
	contentFrame.BackgroundTransparency = 1
	contentFrame.Size = UDim2.new(1, 0, 1, -150)
	contentFrame.Position = UDim2.new(0, 0, 0, 140)
	contentFrame.Parent = container
	
	local function createTab(tabName, tabLabel, tabContent)
		local tabBtn = ButtonFactory:CreateOutlineButton(tabsContainer, {
			Text = tabLabel,
			Size = UDim2.new(0, 110, 0, 40),
			OnClick = function()
				currentTab = tabName
				-- Clear content
				for _, child in ipairs(contentFrame:GetChildren()) do
					if child ~= contentFrame:FindFirstChild("UIGridLayout") then
						child:Destroy()
					end
				end
				-- Show content
				tabContent()
			end,
		})
		return tabBtn
	end
	
	-- Tab: Cars
	local carsTabBtn = createTab("cars", "🚗 Cars", function()
		local cars = PlayerDataManager:GetCars(playerId) or {}
		
		UIHelper:CreateGridLayout(contentFrame, {
			CellSize = UDim2.new(0, 150, 0, 150),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			FillDirectionMaxSize = 500,
		})
		
		for _, car in ipairs(cars) do
			local carCard = UIHelper:CreateRoundedFrame(contentFrame, {
				BackgroundColor3 = Theme.Colors.BackgroundTertiary,
				BackgroundTransparency = 0.2,
				Size = UDim2.new(0, 140, 0, 140),
				CornerRadius = UDim.new(0, 12),
				Padding = UDim.new(0, 10),
			})
			UIHelper:AddStroke(carCard, Theme.Colors.Primary, 1, 0.5)
			
			-- Car image (placeholder)
			local carImage = UIHelper:CreateImageLabel(carCard, {
				Image = car.image or "",
				Size = UDim2.new(1, 0, 0.7, 0),
			})
			
			-- Car name
			local carName = UIHelper:CreateTextLabel(carCard, {
				Text = car.name or "Unknown Car",
				TextColor3 = Theme.Colors.TextPrimary,
				Font = Theme.Fonts.BodySmall.Font,
				TextSize = 12,
				Size = UDim2.new(1, 0, 0.3, 0),
				Position = UDim2.new(0, 0, 0.7, 0),
			})
			carName.TextScaled = true
		end
	end)
	
	-- Tab: Items
	local itemsTabBtn = createTab("items", "📦 Items", function()
		local items = PlayerDataManager:GetInventoryItems(playerId, "item") or {}
		
		UIHelper:CreateListLayout(contentFrame, {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 10),
		})
		
		for _, item in ipairs(items) do
			local itemLabel = UIHelper:CreateTextLabel(contentFrame, {
				Text = (item.name or "Item") .. " x" .. (item.quantity or 1),
				TextColor3 = Theme.Colors.TextPrimary,
				Font = Theme.Fonts.Body.Font,
				Size = UDim2.new(1, 0, 0, 40),
			})
		end
	end)
	
	-- Tab: Lockers
	local lockersTabBtn = createTab("lockers", "🔐 Lockers", function()
		local lockers = PlayerDataManager:GetLockers(playerId) or {}
		
		UIHelper:CreateListLayout(contentFrame, {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 10),
		})
		
		for _, locker in ipairs(lockers) do
			local lockerLabel = UIHelper:CreateTextLabel(contentFrame, {
				Text = (locker.type or "Locker") .. " - Opens in " .. (locker.timeRemaining or "00:00"),
				TextColor3 = Theme.Colors.TextSecondary,
				Font = Theme.Fonts.Body.Font,
				Size = UDim2.new(1, 0, 0, 40),
			})
		end
	end)
	
	-- Tab: Index
	local indexTabBtn = createTab("index", "📇 Index", function()
		local cars = PlayerDataManager:GetCars(playerId) or {}
		
		UIHelper:CreateGridLayout(contentFrame, {
			CellSize = UDim2.new(0, 150, 0, 150),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			FillDirectionMaxSize = 500,
		})
		
		for _, car in ipairs(cars) do
			local indexCard = UIHelper:CreateRoundedFrame(contentFrame, {
				BackgroundColor3 = Theme.Colors.BackgroundTertiary,
				BackgroundTransparency = 0.2,
				Size = UDim2.new(0, 140, 0, 140),
				CornerRadius = UDim.new(0, 12),
			})
			UIHelper:AddStroke(indexCard, Theme.Colors.Secondary, 1, 0.5)
			
			local indexText = UIHelper:CreateTextLabel(indexCard, {
				Text = car.name or "Car",
				TextColor3 = Theme.Colors.TextPrimary,
				Font = Theme.Fonts.Body.Font,
				Size = UDim2.new(1, 0, 1, 0),
			})
			indexText.TextScaled = true
		end
	end)
	
	-- Show cars by default
	carsTabBtn.MouseButton1Click:Fire()
	
	return screenGui
end

return InventoryScreen