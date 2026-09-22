local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function safeWait(parent, name, timeout)
    timeout = timeout or 10
    local startTime = tick()
    while parent:FindFirstChild(name) == nil do
        if tick() - startTime > timeout then
            return nil
        end
        task.wait(0.1)
    end
    return parent:WaitForChild(name, timeout)
end

local ErrorHandler = {
    lastError = nil,
    errorCount = 0
}

function ErrorHandler:Log(title, message)
    self.errorCount = self.errorCount + 1
    self.lastError = {title = title, message = message, time = tick()}
end

function ErrorHandler:Safe(func, fallback)
    local success, result = pcall(func)
    if not success then
        self:Log("Execution Error", tostring(result))
        if fallback then return fallback() end
        return nil
    end
    return result
end

local function createElement(elementType, properties, parent)
    local success, element = pcall(function()
        local el = Instance.new(elementType)
        
        if properties then
            for prop, value in pairs(properties) do
                pcall(function()
                    el[prop] = value
                end)
            end
        end
        
        if parent then
            el.Parent = parent
        end
        
        return el
    end)
    
    if not success then
        return nil
    end
    
    return element
end

local blacklist = {
	[10843492950] = true,
	[10933914415] = true,
	[4259121871] = true,
	[10351887890] = true,
	[3418445242] = true,
	[2703923001] = true,
	[6214327826] = true,
	[5442464002] = true,
	[2594304260] = true,
	[4173702575] = true,
	[9849967356] = true,
	[4169270440] = true,
	[10949366352] = true,
	[2552425052] = true,
	[6191285628] = true,
	[7524746689] = true,
	[1602735492] = true,
	[8811124870] = true,
	[3925605025] = true,
	[1314032465] = true,
	[5730660940] = true,
	[10924882438] = true,
	[10369826440] = true,
	[5678016749] = true,
	[1418580698] = true,
	[8470028585] = true,
	[3031897432] = true,
	[7337951768] = true,
	[9165738477] = true,
	[1109879759] = true,
	[3096623737] = true,
	[482412636] = true,
	[9829468024] = true,
	[4416527291] = true,
	[3785359949] = true,
	[4701384398] = true,
	[10390338903] = true,
	[4006367846] = true,
	[4576551440] = true,
	[10171108494] = true,
	[2371184123] = true,
	[5147363497] = true,
	[4765505719] = true,
	[3283567744] = true,
	[1614826732] = true,
	[8035462420] = true,
	[8827396423] = true,
	[10894786014] = true,
	[10894376478] = true,
	[7240313226] = true,
	[3446838904] = true,
	[7508286398] = true,
	[9629729872] = true,
	[3708326583] = true,
	[10653924439] = true,
	[9129601647] = true,
	[3737457177] = true,
	[10766380123] = true,
	[2660799873] = true,
	[10837593224] = true,
	[1303131962] = true,
	[10723269020] = true,
	[2656900726] = true,
	[5425036926] = true,
	[3297689455] = true,
	[3025340527] = true,
	[10798736371] = true,
	[4759483938] = true,
	[2257599761] = true,
	[10791996634] = true,
	[8779758770] = true,
	[10794794546] = true,
	[10637564471] = true,
	[5155864964] = true,
	[10785602004] = true,
	[3365293121] = true,
	[8006773074] = true,
	[10531002125] = true,
	[10774201066] = true,
	[10687686510] = true,
	[10131552842] = true,
	[1695945117] = true,
	[3116553981] = true,
	[4639914377] = true,
	[10746876787] = true,
	[3065681888] = true,
	[3060274510] = true,
	[10736785430] = true,
	[10717223472] = true,
	[1165135581] = true,
	[10440438172] = true,
	[10222758084] = true,
	[10706013484] = true,
	[1420284337] = true,
	[10685737154] = true,
	[9575997342] = true,
	[9223114170] = true,
	[10679011171] = true,
	[3882403525] = true,
	[4666991745] = true,
	[10675594869] = true,
	[1744024009] = true,
	[8648908234] = true,
	[7283008564] = true,
	[10304652238] = true,
	[10304502709] = true,
	[10398926657] = true,
	[10668510954] = true,
	[8988891364] = true,
	[10662802766] = true,
	[9837764566] = true,
	[10091372800] = true,
	[2351815552] = true,
	[10663737738] = true,
	[10662920806] = true,
	[5784075773] = true,
	[7754558795] = true,
	[2834245971] = true,
	[10652069577] = true,
	[10422950028] = true,
	[7563687996] = true,
	[4763507835] = true,
	[4770253770] = true,
	[2046570902] = true,
	[10537151901] = true,
	[5718061683] = true,
	[8565633070] = true,
	[1471515322] = true,
	[10550163737] = true,
	[7408774797] = true,
	[5256549469] = true,
	[1937480619] = true,
	[8981198590] = true,
	[1136831947] = true,
	[4163472181] = true,
	[10530102378] = true,
	[3043189557] = true,
	[7787606348] = true,
	[659933142] = true,
	[10502961269] = true,
	[5668355269] = true,
	[9187270630] = true
}

if blacklist[player.UserId] then
	player:Kick("Blacklisted.")
end

ErrorHandler:Safe(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://115861800482390"
    sound.Volume = 1
    sound.Parent = workspace
    
    task.delay(0.2, function()
        if sound.Parent then
            pcall(function() sound:Play() end)
        end
    end)
end)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LegacyServiceGui"
gui.ResetOnSpawn = false

local playerGui = safeWait(player, "PlayerGui", 15)
if playerGui then
    gui.Parent = playerGui
else
    return
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.35
frame.BorderSizePixel = 0
frame.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
stroke.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.6, 0)
title.Position = UDim2.new(0, 0, 0.05, 0)
title.BackgroundTransparency = 1
title.Text = "LEGACY SERVICE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextTransparency = 1
title.Parent = frame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0.25, 0)
subtitle.Position = UDim2.new(0, 0, 0.63, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "maded by: system"
subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.TextTransparency = 1
subtitle.Parent = frame

local tweenSuccess = pcall(function()
	local openTween = TweenService:Create(
		frame,
		TweenInfo.new(
			0.45,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Size = UDim2.new(0, 360, 0, 110)
		}
	)

	local titleTween = TweenService:Create(
		title,
		TweenInfo.new(0.3),
		{
			TextTransparency = 0
		}
	)

	local subtitleTween = TweenService:Create(
		subtitle,
		TweenInfo.new(0.3),
		{
			TextTransparency = 0
		}
	)

	openTween:Play()

	openTween.Completed:Connect(function()
		titleTween:Play()
		subtitleTween:Play()
	end)
end)

if not tweenSuccess then
	frame.Size = UDim2.new(0, 360, 0, 110)
	title.TextTransparency = 0
	subtitle.TextTransparency = 0
end

task.wait(6)

local fadeSuccess = pcall(function()
	local fadeFrame = TweenService:Create(
		frame,
		TweenInfo.new(
			0.6,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		),
		{
			BackgroundTransparency = 1
		}
	)

	local fadeStroke = TweenService:Create(
		stroke,
		TweenInfo.new(0.6),
		{
			Transparency = 1
		}
	)

	local fadeTitle = TweenService:Create(
		title,
		TweenInfo.new(0.6),
		{
			TextTransparency = 1
		}
	)

	local fadeSubtitle = TweenService:Create(
		subtitle,
		TweenInfo.new(0.6),
		{
			TextTransparency = 1
		}
	)

	fadeFrame:Play()
	fadeStroke:Play()
	fadeTitle:Play()
	fadeSubtitle:Play()

	fadeFrame.Completed:Connect(function()
		gui:Destroy()
	end)
end)

if not fadeSuccess then
	task.delay(1, function()
		pcall(function() gui:Destroy() end)
	end)
end

local StarterGui = game:GetService("StarterGui")

ErrorHandler:Safe(function()
	StarterGui:SetCore("SendNotification", {
		Title = "Thanks For using Legacy Service",
		Text = "Maded by System, say -Cmds to view Commands",
		Duration = 5
	})
end)

task.wait(1)

local link = "https://legacyservice.netlify.app"

local clipboardFunctions = {
    setclipboard,
    toclipboard,
    set_clipboard
}

local clipSuccess = false

for _, func in ipairs(clipboardFunctions) do
    if func then
        local result = pcall(function() func(link) end)
        if result then
            clipSuccess = true
            break
        end
    end
end

if not clipSuccess and syn and syn.write_clipboard then
    pcall(function() syn.write_clipboard(link) end)
    clipSuccess = true
end

if clipSuccess then
	ErrorHandler:Safe(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Link Copied",
			Text = "Official Website of Legacy Service Copied!",
			Duration = 5
		})
	end)
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer

local Library = {}

local tabChangeSound = Instance.new("Sound")
tabChangeSound.SoundId = "rbxassetid://82125543037296"
tabChangeSound.Volume = 0.5
tabChangeSound.Parent = workspace

local buttonClickSound = Instance.new("Sound")
buttonClickSound.SoundId = "rbxassetid://17208396156"
buttonClickSound.Volume = 0.5
buttonClickSound.Parent = workspace

Library.Theme = {
	Background = Color3.fromRGB(12,12,14),
	Secondary = Color3.fromRGB(20,20,23),
	Element = Color3.fromRGB(28,28,31),
	Border = Color3.fromRGB(70,70,75),
	Text = Color3.fromRGB(235,235,235),
	SubText = Color3.fromRGB(160,160,165),
	Accent = Color3.fromRGB(85,45,125),
	ToggleOff = Color3.fromRGB(45,45,48),
	AccentHover = Color3.fromRGB(100,55,145),
	GroupBackground = Color3.fromRGB(17,17,20)
}

Library.Settings = {
	Blur = true,
	BlurSize = 8,
	Transparency = 0.12,
	CornerRadius = 8,
	AnimationSpeed = 0.18,
	Tooltip = true,
	TooltipMaxWidth = 600
}

Library.Flags = {}

local function Tween(obj, info, props)
	if not obj or not obj.Parent then
		return nil
	end

	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

local function Anim(obj, props, speed)
	return Tween(
		obj,
		TweenInfo.new(
			speed or Library.Settings.AnimationSpeed,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),
		props
	)
end

local function Spring(obj, props)
	return Tween(
		obj,
		TweenInfo.new(
			0.24,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		props
	)
end

local function safeCallback(callback, ...)
	if callback then
		pcall(callback, ...)
	end
end

local function corner(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or Library.Settings.CornerRadius)
	c.Parent = obj
	return c
end

local function stroke(obj, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color or Library.Theme.Border
	s.Thickness = thickness or 1
	s.Transparency = 0.35
	s.Parent = obj
	return s
end

local function buttonAnimation(button, normalColor, hoverColor)
	button.MouseEnter:Connect(function()
		Anim(button,{
			BackgroundColor3 = hoverColor,
			Size = UDim2.new(1,0,0,35)
		},0.12)
	end)

	button.MouseLeave:Connect(function()
		Anim(button,{
			BackgroundColor3 = normalColor,
			Size = UDim2.new(1,0,0,34)
		},0.14)
	end)

	button.MouseButton1Down:Connect(function()
		Anim(button,{
			Size = UDim2.new(1,-4,0,32)
		},0.07)
	end)

	button.MouseButton1Up:Connect(function()
		Anim(button,{
			Size = UDim2.new(1,0,0,35)
		},0.1)
	end)
end

function Library:CreateWindow(options)
	options = options or {}

	local Window = {}
	Window.Tabs = {}
	Window.Groups = {}
	Window.CurrentTab = nil
	Window.Open = true

	local gui = Instance.new("ScreenGui")
	gui.Name = options.Name or "Library"
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent = game:GetService("CoreGui")

	Window.Gui = gui

	if Library.Settings.Blur then
		local blur = Instance.new("BlurEffect")
		blur.Name = "LibraryBlur"
		blur.Size = Library.Settings.BlurSize
		blur.Parent = Lighting
		Window.Blur = blur
	end

	local windowSize = options.Size or UDim2.new(0,500,0,340)

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Size = windowSize
	main.Position = UDim2.new(0.5,0,0.5,0)
	main.AnchorPoint = Vector2.new(0.5,0.5)
	main.BackgroundColor3 = Library.Theme.Background
	main.BackgroundTransparency = Library.Settings.Transparency
	main.BorderSizePixel = 0
	main.Parent = gui

	corner(main)
	stroke(main,Library.Theme.Border,1)

	Window.Main = main

	local top = Instance.new("Frame")
	top.Name = "TopBar"
	top.Size = UDim2.new(1,0,0,42)
	top.BackgroundColor3 = Library.Theme.Secondary
	top.BorderSizePixel = 0
	top.Parent = main

	corner(top)

	local topFix = Instance.new("Frame")
	topFix.Size = UDim2.new(1,0,0,12)
	topFix.Position = UDim2.new(0,0,1,-12)
	topFix.BackgroundColor3 = Library.Theme.Secondary
	topFix.BorderSizePixel = 0
	topFix.Parent = top

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,1,0)
	title.Position = UDim2.new(0,14,0,0)
	title.BackgroundTransparency = 1
	title.Text = options.Title or options.Name or "Library"
	title.TextColor3 = Library.Theme.Text
	title.TextSize = 15
	title.Font = Enum.Font.GothamMedium
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = top

	local tabs = Instance.new("ScrollingFrame")
	tabs.Name = "Tabs"
	tabs.Size = UDim2.new(0,120,1,-42)
	tabs.Position = UDim2.new(0,0,0,42)
	tabs.BackgroundColor3 = Library.Theme.Secondary
	tabs.BorderSizePixel = 0
	tabs.ScrollBarThickness = 2
	tabs.ScrollBarImageColor3 = Library.Theme.Border
	tabs.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tabs.CanvasSize = UDim2.new(0,0,0,0)
	tabs.Parent = main

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0,5)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Parent = tabs

	local tabPadding = Instance.new("UIPadding")
	tabPadding.PaddingTop = UDim.new(0,8)
	tabPadding.PaddingBottom = UDim.new(0,8)
	tabPadding.PaddingLeft = UDim.new(0,7)
	tabPadding.PaddingRight = UDim.new(0,7)
	tabPadding.Parent = tabs

	local pages = Instance.new("Frame")
	pages.Name = "Pages"
	pages.Size = UDim2.new(1,-120,1,-42)
	pages.Position = UDim2.new(0,120,0,42)
	pages.BackgroundTransparency = 1
	pages.Parent = main

	local tooltip = Instance.new("Frame")
	tooltip.Name = "Tooltip"
	tooltip.BackgroundColor3 = Library.Theme.Secondary
	tooltip.BackgroundTransparency = 0.02
	tooltip.BorderSizePixel = 0
	tooltip.Visible = false
	tooltip.ZIndex = 1000
	tooltip.Parent = gui

	corner(tooltip,6)
	stroke(tooltip,Library.Theme.Border,1)

	local tooltipText = Instance.new("TextLabel")
	tooltipText.BackgroundTransparency = 1
	tooltipText.Position = UDim2.new(0,9,0,7)
	tooltipText.TextColor3 = Library.Theme.Text
	tooltipText.Font = Enum.Font.Code
	tooltipText.TextSize = 13
	tooltipText.TextWrapped = true
	tooltipText.TextXAlignment = Enum.TextXAlignment.Left
	tooltipText.TextYAlignment = Enum.TextYAlignment.Top
	tooltipText.ZIndex = 1001
	tooltipText.Parent = tooltip

	Window.Tooltip = tooltip

	local tooltipConnection
	local tooltipToken = 0

	local function hideTooltip()
		tooltipToken += 1

		if tooltipConnection then
			tooltipConnection:Disconnect()
			tooltipConnection = nil
		end

		if not tooltip.Visible then
			return
		end

		Anim(tooltip,{
			BackgroundTransparency = 1
		},0.1)

		Anim(tooltipText,{
			TextTransparency = 1
		},0.1)

		task.delay(0.11,function()
			if tooltip and tooltip.Parent then
				tooltip.Visible = false
			end
		end)
	end

	local function showTooltip(text,target)
		if not Library.Settings.Tooltip then
			return
		end

		if not text or tostring(text) == "" then
			return
		end

		tooltipToken += 1
		local currentToken = tooltipToken

		if tooltipConnection then
			tooltipConnection:Disconnect()
			tooltipConnection = nil
		end

		text = tostring(text)

		local paddingX = 18
		local paddingY = 14
		local minWidth = 60
		local maxWidth = Library.Settings.TooltipMaxWidth or 600

		local rawSize = TextService:GetTextSize(
			text,
			13,
			Enum.Font.Code,
			Vector2.new(10000,10000)
		)

		local width = math.clamp(
			rawSize.X + paddingX,
			minWidth,
			maxWidth
		)

		local wrappedSize = TextService:GetTextSize(
			text,
			13,
			Enum.Font.Code,
			Vector2.new(width - paddingX,10000)
		)

		local height = math.max(
			30,
			wrappedSize.Y + paddingY
		)

		tooltip.Size = UDim2.new(
			0,
			math.ceil(width),
			0,
			math.ceil(height)
		)

		tooltipText.Size = UDim2.new(
			1,
			-paddingX,
			1,
			-paddingY
		)

		tooltipText.Text = text
		tooltipText.TextTransparency = 1

		local position

		if target then
			local targetPos = target.AbsolutePosition
			local targetSize = target.AbsoluteSize

			local camera = workspace.CurrentCamera
			local viewport = camera and camera.ViewportSize or Vector2.new(1000,700)

			local x = targetPos.X + targetSize.X + 8
			local y = targetPos.Y

			if x + width > viewport.X then
				x = targetPos.X - width - 8
			end

			if x < 5 then
				x = 5
			end

			if y + height > viewport.Y then
				y = viewport.Y - height - 8
			end

			if y < 5 then
				y = 5
			end

			position = UDim2.new(
				0,
				math.floor(x),
				0,
				math.floor(y)
			)
		else
			local mouse = UserInputService:GetMouseLocation()

			position = UDim2.new(
				0,
				mouse.X + 14,
				0,
				mouse.Y + 14
			)
		end

		tooltip.Position = position
		tooltip.Visible = true
		tooltip.BackgroundTransparency = 1

		Anim(tooltip,{
			BackgroundTransparency = 0.02
		},0.12)

		Anim(tooltipText,{
			TextTransparency = 0
		},0.12)

		if not target then
			tooltipConnection = UserInputService.InputChanged:Connect(function(input)
				if currentToken ~= tooltipToken then
					return
				end

				if input.UserInputType == Enum.UserInputType.MouseMovement then
					local mouse = UserInputService:GetMouseLocation()

					tooltip.Position = UDim2.new(
						0,
						mouse.X + 14,
						0,
						mouse.Y + 14
					)
				end
			end)
		end
	end

	local function addTooltip(target,info)
		if not info then
			return
		end

		target.MouseEnter:Connect(function()
			showTooltip(info,target)
		end)

		target.MouseLeave:Connect(function()
			hideTooltip()
		end)

		target.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				showTooltip(info,target)

				local token = tooltipToken

				task.delay(1.8,function()
					if token == tooltipToken then
						hideTooltip()
					end
				end)
			end
		end)
	end

	local draggingMain = false
	local dragInput
	local dragStart
	local startPos

	top.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			draggingMain = true
			dragStart = input.Position
			startPos = main.Position
		end
	end)

	top.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if draggingMain and input == dragInput then
			local delta = input.Position - dragStart

			main.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			draggingMain = false
		end
	end)

	local toggleButton = Instance.new("TextButton")
	toggleButton.Name = "ToggleButton"
	toggleButton.Size = UDim2.new(0,42,0,42)
	toggleButton.Position = UDim2.new(0,15,0.5,-21)
	toggleButton.BackgroundColor3 = Library.Theme.Element
	toggleButton.Text = "×"
	toggleButton.TextColor3 = Library.Theme.SubText
	toggleButton.TextSize = 22
	toggleButton.Font = Enum.Font.Gotham
	toggleButton.AutoButtonColor = false
	toggleButton.BorderSizePixel = 0
	toggleButton.Parent = gui

	corner(toggleButton,7)
	stroke(toggleButton,Library.Theme.Border,1)

	local buttonDragging = false
	local buttonDragInput
	local buttonDragStart
	local buttonStartPos

	toggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			buttonDragging = true
			buttonDragStart = input.Position
			buttonStartPos = toggleButton.Position
			buttonDragInput = input
		end
	end)

	toggleButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			buttonDragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if buttonDragging and input == buttonDragInput then
			local delta = input.Position - buttonDragStart

			toggleButton.Position = UDim2.new(
				buttonStartPos.X.Scale,
				buttonStartPos.X.Offset + delta.X,
				buttonStartPos.Y.Scale,
				buttonStartPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			buttonDragging = false
		end
	end)

	toggleButton.MouseEnter:Connect(function()
		if not buttonDragging then
			Spring(toggleButton,{
				BackgroundColor3 = Library.Theme.ToggleOff,
				TextColor3 = Library.Theme.Text,
				Size = UDim2.new(0,45,0,45)
			})
		end
	end)

	toggleButton.MouseLeave:Connect(function()
		Anim(toggleButton,{
			BackgroundColor3 = Library.Theme.Element,
			TextColor3 = Library.Theme.SubText,
			Size = UDim2.new(0,42,0,42)
		},0.14)
	end)

	toggleButton.MouseButton1Down:Connect(function()
		Anim(toggleButton,{
			Size = UDim2.new(0,38,0,38)
		},0.07)
	end)

	local windowClosed = false
	local windowTween
	local clickStartPosition

	toggleButton.MouseButton1Down:Connect(function()
		clickStartPosition = toggleButton.Position
	end)

	toggleButton.MouseButton1Click:Connect(function()
		if windowClosed then
			windowClosed = false

			if windowTween then
				windowTween:Cancel()
			end

			main.Visible = true

			main.Size = UDim2.new(
				windowSize.X.Scale,
				windowSize.X.Offset,
				0,
				0
			)

			main.BackgroundTransparency = 1

			if Window.Blur then
				Window.Blur.Enabled = true
			end

			toggleButton.Text = "×"
			toggleButton.TextSize = 22

			windowTween = Tween(
				main,
				TweenInfo.new(
					0.28,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),
				{
					Size = windowSize,
					BackgroundTransparency = Library.Settings.Transparency
				}
			)

			return
		end

		windowClosed = true
		hideTooltip()

		if windowTween then
			windowTween:Cancel()
		end

		if Window.Blur then
			Window.Blur.Enabled = false
		end

		toggleButton.Text = "≡"
		toggleButton.TextSize = 20

		windowTween = Tween(
			main,
			TweenInfo.new(
				0.22,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.In
			),
			{
				Size = UDim2.new(
					windowSize.X.Scale,
					windowSize.X.Offset,
					0,
					0
				),
				BackgroundTransparency = 1
			}
		)

		windowTween.Completed:Connect(function()
			if windowClosed then
				main.Visible = false
				main.BackgroundTransparency = Library.Settings.Transparency
			end
		end)
	end)

	toggleButton.MouseButton1Up:Connect(function()
		Anim(toggleButton,{
			Size = UDim2.new(0,42,0,42)
		},0.1)
	end)

	function Window:AddTab(name)
		local tab = {}
		tab.Name = name
		tab.Elements = {}
		tab.Groups = {}
		tab.SideCounter = 0

		local tabButton = Instance.new("TextButton")
		tabButton.Name = name.."Tab"
		tabButton.Size = UDim2.new(1,0,0,34)
		tabButton.BackgroundColor3 = Library.Theme.Element
		tabButton.BackgroundTransparency = 1
		tabButton.Text = name
		tabButton.TextColor3 = Library.Theme.SubText
		tabButton.TextSize = 12
		tabButton.Font = Enum.Font.GothamMedium
		tabButton.AutoButtonColor = false
		tabButton.BorderSizePixel = 0
		tabButton.Parent = tabs

		corner(tabButton,6)

		tabButton.MouseEnter:Connect(function()
			if Window.CurrentTab ~= tab then
				Anim(tabButton,{
					BackgroundTransparency = 0.65,
					BackgroundColor3 = Library.Theme.Element,
					TextColor3 = Library.Theme.Text
				},0.12)
			end
		end)

		tabButton.MouseLeave:Connect(function()
			if Window.CurrentTab ~= tab then
				Anim(tabButton,{
					BackgroundTransparency = 1,
					TextColor3 = Library.Theme.SubText
				},0.14)
			end
		end)

		tabButton.MouseButton1Down:Connect(function()
			Anim(tabButton,{
				Size = UDim2.new(1,-6,0,32)
			},0.07)
		end)

		tabButton.MouseButton1Up:Connect(function()
			Anim(tabButton,{
				Size = UDim2.new(1,0,0,34)
			},0.1)
		end)

		local page = Instance.new("Frame")
		page.Name = name.."Page"
		page.Size = UDim2.new(1,0,1,0)
		page.BackgroundTransparency = 1
		page.Visible = false
		page.Parent = pages

		local columns = Instance.new("Frame")
		columns.Name = "Columns"
		columns.Size = UDim2.new(1,0,1,0)
		columns.BackgroundTransparency = 1
		columns.Parent = page

		local left = Instance.new("ScrollingFrame")
		left.Name = "LeftColumn"
		left.Size = UDim2.new(0.5,-5,1,0)
		left.Position = UDim2.new(0,3,0,0)
		left.BackgroundTransparency = 1
		left.BorderSizePixel = 0
		left.ScrollBarThickness = 3
		left.ScrollBarImageColor3 = Library.Theme.Border
		left.AutomaticCanvasSize = Enum.AutomaticSize.Y
		left.CanvasSize = UDim2.new(0,0,0,0)
		left.ScrollingDirection = Enum.ScrollingDirection.Y
		left.Parent = columns

		local right = Instance.new("ScrollingFrame")
		right.Name = "RightColumn"
		right.Size = UDim2.new(0.5,-5,1,0)
		right.Position = UDim2.new(0.5,2,0,0)
		right.BackgroundTransparency = 1
		right.BorderSizePixel = 0
		right.ScrollBarThickness = 3
		right.ScrollBarImageColor3 = Library.Theme.Border
		right.AutomaticCanvasSize = Enum.AutomaticSize.Y
		right.CanvasSize = UDim2.new(0,0,0,0)
		right.ScrollingDirection = Enum.ScrollingDirection.Y
		right.Parent = columns

		local function setupColumn(column)
			local layout = Instance.new("UIListLayout")
			layout.Name = "Layout"
			layout.Padding = UDim.new(0,7)
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Parent = column

			local padding = Instance.new("UIPadding")
			padding.PaddingTop = UDim.new(0,5)
			padding.PaddingBottom = UDim.new(0,8)
			padding.PaddingLeft = UDim.new(0,3)
			padding.PaddingRight = UDim.new(0,6)
			padding.Parent = column
		end

		setupColumn(left)
		setupColumn(right)

		tab.Left = left
		tab.Right = right
		tab.Page = page
		tab.Button = tabButton

		local function getColumn(config)
			config = config or {}

			if config.Side then
				if string.lower(config.Side) == "right" then
					return right
				end
				return left
			end

			if tab.DefaultSide then
				if string.lower(tab.DefaultSide) == "right" then
					return right
				end
				return left
			end

			tab.SideCounter += 1

			if tab.SideCounter % 2 == 0 then
				return right
			end

			return left
		end

		function tab:SetSide(side)
			self.DefaultSide = side
		end

		function tab:AddSection(config)
			if typeof(config) == "string" then
				config = {Name = config}
			end

			config = config or {}

			local column = getColumn(config)

			local section = Instance.new("Frame")
			section.Size = UDim2.new(1,0,0,40)
			section.BackgroundTransparency = 1
			section.Parent = column

			local nameLabel = Instance.new("TextLabel")
			nameLabel.Size = UDim2.new(1,0,0,20)
			nameLabel.BackgroundTransparency = 1
			nameLabel.Text = config.Name or "Section"
			nameLabel.TextColor3 = Library.Theme.Text
			nameLabel.TextSize = 14
			nameLabel.Font = Enum.Font.GothamBold
			nameLabel.TextXAlignment = Enum.TextXAlignment.Left
			nameLabel.Parent = section

			local info = Instance.new("TextLabel")
			info.Size = UDim2.new(1,0,0,18)
			info.Position = UDim2.new(0,0,0,20)
			info.BackgroundTransparency = 1
			info.Text = config.Info or ""
			info.TextColor3 = Library.Theme.SubText
			info.TextSize = 10
			info.Font = Enum.Font.Gotham
			info.TextXAlignment = Enum.TextXAlignment.Left
			info.Parent = section

			addTooltip(section,config.Info)

			return section
		end

		function tab:AddLabel(text,config)
			if typeof(text) == "table" then
				config = text
				text = config.Name or config.Text or ""
			end

			config = config or {}

			local column = getColumn(config)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1,0,0,28)
			label.BackgroundTransparency = 1
			label.Text = text or ""
			label.TextColor3 = Library.Theme.SubText
			label.TextSize = 12
			label.Font = Enum.Font.Gotham
			label.TextWrapped = true
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = column

			addTooltip(label,config.Info)

			local object = {}

			function object:Set(value)
				label.Text = tostring(value)
			end

			function object:SetInfo(value)
				addTooltip(label,value)
			end

			return object
		end

		function tab:AddButton(config)
			config = config or {}

			local column = getColumn(config)

			local button = Instance.new("TextButton")
			button.Size = UDim2.new(1,0,0,34)
			button.BackgroundColor3 = Library.Theme.Element
			button.Text = config.Name or "Button"
			button.TextColor3 = Library.Theme.Text
			button.TextSize = 12
			button.Font = Enum.Font.GothamMedium
			button.AutoButtonColor = false
			button.BorderSizePixel = 0
			button.Parent = column

			corner(button,6)
			stroke(button,Library.Theme.Border,1)

			buttonAnimation(
				button,
				Library.Theme.Element,
				Library.Theme.AccentHover
			)

			button.MouseButton1Click:Connect(function()
				buttonClickSound:Play()
				safeCallback(config.Callback)
			end)

			addTooltip(button,config.Info)

			return button
		end

		function tab:AddToggle(config)
			config = config or {}

			local column = getColumn(config)

			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1,0,0,36)
			holder.AutomaticSize = Enum.AutomaticSize.Y
			holder.BackgroundColor3 = Library.Theme.Element
			holder.BorderSizePixel = 0
			holder.Parent = column

			corner(holder,6)
			stroke(holder,Library.Theme.Border,1)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1,-55,1,0)
			label.Position = UDim2.new(0,10,0,0)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Toggle"
			label.TextColor3 = Library.Theme.Text
			label.TextSize = 12
			label.Font = Enum.Font.GothamMedium
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = holder

			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(0,38,0,20)
			toggle.Position = UDim2.new(1,-46,0.5,-10)
			toggle.BackgroundColor3 = Library.Theme.ToggleOff
			toggle.Text = ""
			toggle.AutoButtonColor = false
			toggle.BorderSizePixel = 0
			toggle.Parent = holder

			corner(toggle,10)

			local knob = Instance.new("Frame")
			knob.Size = UDim2.new(0,16,0,16)
			knob.Position = UDim2.new(0,2,0.5,-8)
			knob.BackgroundColor3 = Library.Theme.SubText
			knob.BorderSizePixel = 0
			knob.Parent = toggle

			corner(knob,8)

			local state = config.Default == true

			local function update(value,callback)
				state = value

				if state then
					Spring(toggle,{
						BackgroundColor3 = Library.Theme.Accent,
						Size = UDim2.new(0,40,0,21)
					})

					Spring(knob,{
						Position = UDim2.new(1,-18,0.5,-8),
						BackgroundColor3 = Library.Theme.Text
					})
				else
					Anim(toggle,{
						BackgroundColor3 = Library.Theme.ToggleOff,
						Size = UDim2.new(0,38,0,20)
					})

					Anim(knob,{
						Position = UDim2.new(0,2,0.5,-8),
						BackgroundColor3 = Library.Theme.SubText
					})
				end

				if config.Flag then
					Library.Flags[config.Flag] = state
				end

				if callback then
					safeCallback(config.Callback,state)
				end
			end

			toggle.MouseButton1Click:Connect(function()
				update(not state,true)
			end)

			update(state,false)
			addTooltip(holder,config.Info)

			local object = {}

			function object:Set(value)
				update(value,true)
			end

			function object:Get()
				return state
			end

			return object
		end

		function tab:AddTextbox(config)
			config = config or {}

			local column = getColumn(config)

			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1,0,0,36)
			holder.BackgroundColor3 = Library.Theme.Element
			holder.BorderSizePixel = 0
			holder.Parent = column

			corner(holder,6)
			stroke(holder,Library.Theme.Border,1)

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(1,-12,1,-10)
			box.Position = UDim2.new(0,6,0,5)
			box.BackgroundColor3 = Library.Theme.Secondary
			box.BorderSizePixel = 0
			box.Text = config.Default or ""
			box.PlaceholderText = config.Placeholder or "Text..."
			box.PlaceholderColor3 = Library.Theme.SubText
			box.TextColor3 = Library.Theme.Text
			box.TextSize = 12
			box.Font = Enum.Font.Gotham
			box.ClearTextOnFocus = false
			box.Parent = holder

			corner(box,5)
			stroke(box,Library.Theme.Border,1)

			box.Focused:Connect(function()
				Anim(box,{
					BackgroundColor3 = Library.Theme.Element
				},0.12)
			end)

			box.FocusLost:Connect(function()
				Anim(box,{
					BackgroundColor3 = Library.Theme.Secondary
				},0.12)

				safeCallback(config.Callback,box.Text)
			end)

			addTooltip(holder,config.Info)

			local object = {}

			function object:Set(value)
				box.Text = tostring(value)
				safeCallback(config.Callback,box.Text)
			end

			function object:Get()
				return box.Text
			end

			return object
		end

		function tab:AddSlider(config)
			config = config or {}

			local column = getColumn(config)

			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1,0,0,48)
			holder.BackgroundColor3 = Library.Theme.Element
			holder.BorderSizePixel = 0
			holder.Parent = column

			corner(holder,6)
			stroke(holder,Library.Theme.Border,1)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1,-55,0,20)
			label.Position = UDim2.new(0,8,0,3)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Slider"
			label.TextColor3 = Library.Theme.Text
			label.TextSize = 11
			label.Font = Enum.Font.GothamMedium
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = holder

			local valueLabel = Instance.new("TextLabel")
			valueLabel.Size = UDim2.new(0,45,0,20)
			valueLabel.Position = UDim2.new(1,-51,0,3)
			valueLabel.BackgroundTransparency = 1
			valueLabel.TextColor3 = Library.Theme.SubText
			valueLabel.TextSize = 11
			valueLabel.Font = Enum.Font.Gotham
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right
			valueLabel.Parent = holder

			local bar = Instance.new("Frame")
			bar.Size = UDim2.new(1,-16,0,5)
			bar.Position = UDim2.new(0,8,0,32)
			bar.BackgroundColor3 = Library.Theme.ToggleOff
			bar.BorderSizePixel = 0
			bar.Parent = holder

			corner(bar,3)

			local fill = Instance.new("Frame")
			fill.Size = UDim2.new(0,0,1,0)
			fill.BackgroundColor3 = Library.Theme.Accent
			fill.BorderSizePixel = 0
			fill.Parent = bar

			corner(fill,3)

			local min = config.Min or 0
			local max = config.Max or 100
			local value = config.Default or min
			local dragging = false

			local function setValue(v,callback)
				value = math.clamp(v,min,max)

				local percent = 0

				if max ~= min then
					percent = (value-min)/(max-min)
				end

				Anim(fill,{
					Size = UDim2.new(percent,0,1,0)
				},0.08)

				valueLabel.Text = tostring(math.floor(value*100)/100)

				if config.Flag then
					Library.Flags[config.Flag] = value
				end

				if callback then
					safeCallback(config.Callback,value)
				end
			end

			local function updateFromPosition(x)
				local percent = math.clamp(
					(x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,
					0,
					1
				)

				setValue(min+(max-min)*percent,true)
			end

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					updateFromPosition(input.Position.X)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and (
					input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch
				) then
					updateFromPosition(input.Position.X)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)

			setValue(value,false)
			addTooltip(holder,config.Info)

			local object = {}

			function object:Set(v)
				setValue(v,true)
			end

			function object:Get()
				return value
			end

			return object
		end

		function tab:AddGroup(config)
			config = config or {}

			local column = getColumn(config)

			local group = Instance.new("Frame")
			group.Name = config.Name or "Group"
			group.Size = UDim2.new(1,0,0,0)
			group.AutomaticSize = Enum.AutomaticSize.Y
			group.BackgroundColor3 = Library.Theme.GroupBackground
			group.BorderSizePixel = 0
			group.Parent = column

			corner(group,7)
			stroke(group,Library.Theme.Border,1)

			local groupPadding = Instance.new("UIPadding")
			groupPadding.PaddingTop = UDim.new(0,7)
			groupPadding.PaddingBottom = UDim.new(0,8)
			groupPadding.PaddingLeft = UDim.new(0,7)
			groupPadding.PaddingRight = UDim.new(0,7)
			groupPadding.Parent = group

			local groupLayout = Instance.new("UIListLayout")
			groupLayout.Padding = UDim.new(0,6)
			groupLayout.SortOrder = Enum.SortOrder.LayoutOrder
			groupLayout.Parent = group

			local groupTitle

			if config.Name and config.Name ~= "" then
				groupTitle = Instance.new("TextLabel")
				groupTitle.Name = "Title"
				groupTitle.Size = UDim2.new(1,0,0,24)
				groupTitle.BackgroundTransparency = 1
				groupTitle.Text = config.Name
				groupTitle.TextColor3 = Library.Theme.Text
				groupTitle.TextSize = 13
				groupTitle.Font = Enum.Font.GothamBold
				groupTitle.TextXAlignment = Enum.TextXAlignment.Left
				groupTitle.LayoutOrder = -1000
				groupTitle.Parent = group

				if config.Info then
					local groupInfo = Instance.new("TextLabel")
					groupInfo.Name = "Info"
					groupInfo.Size = UDim2.new(1,0,0,16)
					groupInfo.BackgroundTransparency = 1
					groupInfo.Text = config.Info
					groupInfo.TextColor3 = Library.Theme.SubText
					groupInfo.TextSize = 9
					groupInfo.Font = Enum.Font.Gotham
					groupInfo.TextXAlignment = Enum.TextXAlignment.Left
					groupInfo.LayoutOrder = -999
					groupInfo.Parent = group

					addTooltip(groupInfo,config.Info)
				end
			end

			local groupObject = {}

			function groupObject:SetTitle(text)
				if groupTitle then
					groupTitle.Text = tostring(text)
				end
			end

			function groupObject:AddButton(buttonConfig)
				buttonConfig = buttonConfig or {}

				local button = Instance.new("TextButton")
				button.Size = UDim2.new(1,0,0,34)
				button.AutomaticSize = Enum.AutomaticSize.Y
button.TextWrapped = true
				button.BackgroundColor3 = Library.Theme.Element
				button.Text = buttonConfig.Name or "Button"
				button.TextColor3 = Library.Theme.Text
				button.TextSize = 12
				button.Font = Enum.Font.GothamMedium
				button.AutoButtonColor = false
				button.BorderSizePixel = 0
				button.Parent = group

				corner(button,6)
				stroke(button,Library.Theme.Border,1)

				buttonAnimation(
					button,
					Library.Theme.Element,
					Library.Theme.AccentHover
				)

				button.MouseButton1Click:Connect(function()
					buttonClickSound:Play()
					safeCallback(buttonConfig.Callback)
				end)

				addTooltip(button,buttonConfig.Info)

				return button
			end

			function groupObject:AddLabel(text)
				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1,0,0,25)
				label.BackgroundTransparency = 1
				label.Text = tostring(text or "")
				label.TextColor3 = Library.Theme.SubText
				label.TextSize = 11
				label.Font = Enum.Font.Gotham
				label.TextWrapped = true
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = group

				local object = {}

				function object:Set(value)
					label.Text = tostring(value)
				end

				return object
			end

			function groupObject:AddSection(text)
				local section = Instance.new("TextLabel")
				section.Size = UDim2.new(1,0,0,23)
				section.BackgroundTransparency = 1
				section.Text = tostring(text or "")
				section.TextColor3 = Library.Theme.Text
				section.TextSize = 11
				section.Font = Enum.Font.GothamBold
				section.TextXAlignment = Enum.TextXAlignment.Left
				section.Parent = group

				return section
			end

			function groupObject:AddToggle(toggleConfig)
				toggleConfig = toggleConfig or {}

				local holder = Instance.new("Frame")
				holder.Size = UDim2.new(1,0,0,36)
				holder.BackgroundColor3 = Library.Theme.Element
				holder.BorderSizePixel = 0
				holder.Parent = group

				corner(holder,6)
				stroke(holder,Library.Theme.Border,1)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1,-55,1,0)
				label.Position = UDim2.new(0,10,0,0)
				label.BackgroundTransparency = 1
				label.Text = toggleConfig.Name or "Toggle"
				label.TextColor3 = Library.Theme.Text
				label.TextSize = 12
				label.Font = Enum.Font.GothamMedium
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = holder

				local toggle = Instance.new("TextButton")
				toggle.Size = UDim2.new(0,38,0,20)
				toggle.Position = UDim2.new(1,-46,0.5,-10)
				toggle.BackgroundColor3 = Library.Theme.ToggleOff
				toggle.Text = ""
				toggle.AutoButtonColor = false
				toggle.BorderSizePixel = 0
				toggle.Parent = holder

				corner(toggle,10)

				local knob = Instance.new("Frame")
				knob.Size = UDim2.new(0,16,0,16)
				knob.Position = UDim2.new(0,2,0.5,-8)
				knob.BackgroundColor3 = Library.Theme.SubText
				knob.BorderSizePixel = 0
				knob.Parent = toggle

				corner(knob,8)

				local state = toggleConfig.Default == true

				local function update(value,callback)
					state = value

					if state then
						Spring(toggle,{
							BackgroundColor3 = Library.Theme.Accent,
							Size = UDim2.new(0,40,0,21)
						})

						Spring(knob,{
							Position = UDim2.new(1,-18,0.5,-8),
							BackgroundColor3 = Library.Theme.Text
						})
					else
						Anim(toggle,{
							BackgroundColor3 = Library.Theme.ToggleOff,
							Size = UDim2.new(0,38,0,20)
						})

						Anim(knob,{
							Position = UDim2.new(0,2,0.5,-8),
							BackgroundColor3 = Library.Theme.SubText
						})
					end

					if toggleConfig.Flag then
						Library.Flags[toggleConfig.Flag] = state
					end

					if callback then
						safeCallback(toggleConfig.Callback,state)
					end
				end

				toggle.MouseButton1Click:Connect(function()
					update(not state,true)
				end)

				update(state,false)
				addTooltip(holder,toggleConfig.Info)

				local object = {}

				function object:Set(value)
					update(value,true)
				end

				function object:Get()
					return state
				end

				return object
			end

			function groupObject:AddTextbox(textboxConfig)
				textboxConfig = textboxConfig or {}

				local holder = Instance.new("Frame")
				holder.Size = UDim2.new(1,0,0,36)
				holder.BackgroundColor3 = Library.Theme.Element
				holder.BorderSizePixel = 0
				holder.Parent = group

				corner(holder,6)
				stroke(holder,Library.Theme.Border,1)

				local box = Instance.new("TextBox")
				box.Size = UDim2.new(1,-12,1,-10)
				box.Position = UDim2.new(0,6,0,5)
				box.BackgroundColor3 = Library.Theme.Secondary
				box.BorderSizePixel = 0
				box.Text = textboxConfig.Default or ""
				box.PlaceholderText = textboxConfig.Placeholder or "Text..."
				box.PlaceholderColor3 = Library.Theme.SubText
				box.TextColor3 = Library.Theme.Text
				box.TextSize = 12
				box.Font = Enum.Font.Gotham
				box.ClearTextOnFocus = false
				box.Parent = holder

				corner(box,5)
				stroke(box,Library.Theme.Border,1)

				box.Focused:Connect(function()
					Anim(box,{
						BackgroundColor3 = Library.Theme.Element
					},0.12)
				end)

				box.FocusLost:Connect(function()
					Anim(box,{
						BackgroundColor3 = Library.Theme.Secondary
					},0.12)

					safeCallback(textboxConfig.Callback,box.Text)
				end)

				addTooltip(holder,textboxConfig.Info)

				local object = {}

				function object:Set(value)
					box.Text = tostring(value)
					safeCallback(textboxConfig.Callback,box.Text)
				end

				function object:Get()
					return box.Text
				end

				return object
			end

			function groupObject:AddSlider(sliderConfig)
				sliderConfig = sliderConfig or {}

				local holder = Instance.new("Frame")
				holder.Size = UDim2.new(1,0,0,48)
				holder.BackgroundColor3 = Library.Theme.Element
				holder.BorderSizePixel = 0
				holder.Parent = group

				corner(holder,6)
				stroke(holder,Library.Theme.Border,1)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1,-55,0,20)
				label.Position = UDim2.new(0,8,0,3)
				label.BackgroundTransparency = 1
				label.Text = sliderConfig.Name or "Slider"
				label.TextColor3 = Library.Theme.Text
				label.TextSize = 11
				label.Font = Enum.Font.GothamMedium
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = holder

				local valueLabel = Instance.new("TextLabel")
				valueLabel.Size = UDim2.new(0,45,0,20)
				valueLabel.Position = UDim2.new(1,-51,0,3)
				valueLabel.BackgroundTransparency = 1
				valueLabel.TextColor3 = Library.Theme.SubText
				valueLabel.TextSize = 11
				valueLabel.Font = Enum.Font.Gotham
				valueLabel.TextXAlignment = Enum.TextXAlignment.Right
				valueLabel.Parent = holder

				local bar = Instance.new("Frame")
				bar.Size = UDim2.new(1,-16,0,5)
				bar.Position = UDim2.new(0,8,0,32)
				bar.BackgroundColor3 = Library.Theme.ToggleOff
				bar.BorderSizePixel = 0
				bar.Parent = holder

				corner(bar,3)

				local fill = Instance.new("Frame")
				fill.Size = UDim2.new(0,0,1,0)
				fill.BackgroundColor3 = Library.Theme.Accent
				fill.BorderSizePixel = 0
				fill.Parent = bar

				corner(fill,3)

				local min = sliderConfig.Min or 0
				local max = sliderConfig.Max or 100
				local value = sliderConfig.Default or min
				local dragging = false

				local function setValue(v,callback)
					value = math.clamp(v,min,max)

					local percent = 0

					if max ~= min then
						percent = (value-min)/(max-min)
					end

					Anim(fill,{
						Size = UDim2.new(percent,0,1,0)
					},0.08)

					valueLabel.Text = tostring(math.floor(value*100)/100)

					if sliderConfig.Flag then
						Library.Flags[sliderConfig.Flag] = value
					end

					if callback then
						safeCallback(sliderConfig.Callback,value)
					end
				end

				local function updateFromPosition(x)
					local percent = math.clamp(
						(x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,
						0,
						1
					)

					setValue(min+(max-min)*percent,true)
				end

				bar.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						updateFromPosition(input.Position.X)
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if dragging and (
						input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch
					) then
						updateFromPosition(input.Position.X)
					end
				end)

				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				setValue(value,false)
				addTooltip(holder,sliderConfig.Info)

				local object = {}

				function object:Set(v)
					setValue(v,true)
				end

				function object:Get()
					return value
				end

				return object
			end

			function groupObject:AddElement(element)
				element.Parent = group
				return element
			end

			function groupObject:SetColumns(columns)
				return
			end

			table.insert(tab.Groups,groupObject)
			table.insert(Window.Groups,groupObject)

			return groupObject
		end

		function tab:Select()
			for _,other in ipairs(Window.Tabs) do
				other.Page.Visible = false

				Anim(other.Button,{
					BackgroundTransparency = 1,
					TextColor3 = Library.Theme.SubText,
					Size = UDim2.new(1,0,0,34)
				},0.14)
			end

			page.Visible = true

			tabButton.BackgroundTransparency = 1
			tabButton.Size = UDim2.new(1,0,0,34)

			Spring(tabButton,{
				BackgroundTransparency = 0,
				BackgroundColor3 = Library.Theme.Element,
				TextColor3 = Library.Theme.Text,
				Size = UDim2.new(1,0,0,36)
			})

			task.delay(0.12,function()
				if Window.CurrentTab == tab then
					Anim(tabButton,{
						Size = UDim2.new(1,0,0,34)
					},0.1)
				end
			end)

			Window.CurrentTab = tab
		end

		tabButton.MouseButton1Click:Connect(function()
			tabChangeSound:Play()
			tab:Select()
		end)

		table.insert(Window.Tabs,tab)

		if not Window.CurrentTab then
			tab:Select()
		end

		return tab
	end

	return Window
end

local Window = Library:CreateWindow({
	Name = "Legacy service SCRIPT",
	Title = "Legacy Service",
	Size = UDim2.new(0,500,0,340)
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local currentState

local function getTime(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		return 0
	end

	local time = leaderstats:FindFirstChild("Time")
	return time and time.Value or 0
end

local function countParts(player)
	local function count(folderName, partName)
		local folder = workspace:FindFirstChild(folderName)
		if not folder then
			return 0
		end

		local playerFolder = folder:FindFirstChild(player.Name)
		if not playerFolder then
			return 0
		end

		local amount = 0

		for _, v in ipairs(playerFolder:GetDescendants()) do
			if v:IsA("BasePart") and v.Name == partName then
				amount += 1
			end
		end

		return amount
	end

	local bricks = count("Bricks", "Brick")
	if bricks > 0 then
		return bricks
	end

	return count("Cubes", "Cube")
end

local function getNameColor(player)
	if player.Team then
		local teamName = player.Team.Name
		if teamName == "Chosen" or teamName == "Admin" then
			return Color3.fromRGB(210,170,60)
		end
	end

	return Color3.fromRGB(110,125,145)
end

local function createBillboard(player, character)
	local head = character:FindFirstChild("Head")
	if not head then
		return
	end

	local old = head:FindFirstChild("PlayerInfo")
	if old then
		old:Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PlayerInfo"
	billboard.Size = UDim2.new(3,0,1.6,0)
	billboard.StudsOffset = Vector3.new(0,5,0)
	billboard.AlwaysOnTop = false
	billboard.Parent = head

	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromScale(1,1)
	frame.BackgroundColor3 = Color3.fromRGB(6,8,14)
	frame.BorderSizePixel = 0
	frame.Parent = billboard

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,12)
	corner.Parent = frame

	local username = Instance.new("TextLabel")
	username.BackgroundTransparency = 1
	username.Size = UDim2.new(1,-10,0.33,0)
	username.Position = UDim2.new(0,5,0,2)
	username.Font = Enum.Font.GothamSemibold
	username.TextScaled = true
	username.Text = "@"..player.Name
	username.TextColor3 = getNameColor(player)
	username.Parent = frame

	local timeLabel = Instance.new("TextLabel")
	timeLabel.BackgroundTransparency = 1
	timeLabel.Size = UDim2.new(1,-10,0.33,0)
	timeLabel.Position = UDim2.new(0,5,0.33,0)
	timeLabel.Font = Enum.Font.Gotham
	timeLabel.TextScaled = true
	timeLabel.TextColor3 = Color3.fromRGB(110,125,145)
	timeLabel.Parent = frame

	local bricksLabel = Instance.new("TextLabel")
	bricksLabel.BackgroundTransparency = 1
	bricksLabel.Size = UDim2.new(1,-10,0.33,0)
	bricksLabel.Position = UDim2.new(0,5,0.66,0)
	bricksLabel.Font = Enum.Font.Gotham
	bricksLabel.TextScaled = true
	bricksLabel.TextColor3 = Color3.fromRGB(110,125,145)
	bricksLabel.Parent = frame

	task.spawn(function()
		while billboard.Parent do
			username.TextColor3 = getNameColor(player)
			timeLabel.Text = "Time: "..getTime(player)
			bricksLabel.Text = "Bricks: "..countParts(player)
			task.wait(1)
		end
	end)
end

local function onPlayer(player)
	player.CharacterAdded:Connect(function(character)
		createBillboard(player, character)
	end)

	if player.Character then
		createBillboard(player, player.Character)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	onPlayer(player)
end

Players.PlayerAdded:Connect(onPlayer)

local StarterGui = game:GetService("StarterGui")

local function notify(msg)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Brick Cube Detect",
			Text = msg,
			Duration = 5
		})
	end)
end

local GROUPS = {
	{
		Id = 66480509,
		Text = "Cake Cult Member",
		Color = Color3.fromRGB(80, 220, 255)
	},
	{
		Id = 577101558,
		Text = "ULTRAS OF ROBLOXIA (Raider Alert)",
		Color = Color3.fromRGB(255, 60, 60)
	}
}

local function createTag(character, textValue, colorValue, name)
	local head = character:FindFirstChild("Head")
	if not head then
		return
	end

	if head:FindFirstChild(name) then
		return
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = name
	billboard.ResetOnSpawn = false
	billboard.Size = UDim2.new(1,0,1,0)
	billboard.StudsOffset = Vector3.new(0,2.8,0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 150
	billboard.Parent = head

	local text = Instance.new("TextLabel")
	text.BackgroundTransparency = 1
	text.Size = UDim2.new(1,0,1,0)
	text.Text = textValue
	text.TextColor3 = colorValue
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.new(0,0,0)
	text.Font = Enum.Font.GothamBold
	text.TextScaled = true
	text.Parent = billboard
end

local function setupPlayer(player)
	local playerGroups = {}

	for _, info in ipairs(GROUPS) do
		local success, result = pcall(function()
			return player:IsInGroup(info.Id)
		end)

		if success and result then
			table.insert(playerGroups, info)
		end
	end

	if #playerGroups == 0 then
		return
	end

	local function applyTags(character)
		for _, info in ipairs(playerGroups) do
			createTag(
				character,
				info.Text,
				info.Color,
				"GroupTag_"..info.Id
			)
		end
	end

	if player.Character then
		applyTags(player.Character)
	end

	player.CharacterAdded:Connect(applyTags)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "PerfGui"
gui.ResetOnSpawn = false
gui.Parent = safeWait(player, "PlayerGui", 15)

local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "Info"
infoLabel.Size = UDim2.new(0, 420, 0, 22)
infoLabel.Position = UDim2.new(0.5, -210, 1, -32)
infoLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
infoLabel.BackgroundTransparency = 0.55
infoLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
infoLabel.TextStrokeTransparency = 0.65
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextSize = 15
infoLabel.TextXAlignment = Enum.TextXAlignment.Center
infoLabel.TextYAlignment = Enum.TextYAlignment.Center
infoLabel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 5)
corner.Parent = infoLabel

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Transparency = 0.8
stroke.Parent = infoLabel

local fps = 0
local frames = 0
local last = tick()

RunService.RenderStepped:Connect(function()
	frames += 1

	local now = tick()

	if now - last >= 1 then
		fps = frames
		frames = 0
		last = now
	end

	local ping = 0

	pcall(function()
		ping = math.floor(
			Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
		)
	end)

	local dt = DateTime.now():ToLocalTime()
	local time = string.format(
		"%02d:%02d:%02d",
		dt.Hour,
		dt.Minute,
		dt.Second
	)

	local timezone = os.date("%Z")

	infoLabel.Text = string.format(
		"Ping: %d ms  |  FPS: %d  |  %s (%s)  |  JobId: %s",
		ping,
		fps,
		time,
		timezone,
		game.JobId
	)
end)

local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local ADMIN_USERIDS = {
	[7201591100] = true,
	[4168972012] = true
}

local adminGui = Instance.new("ScreenGui")
adminGui.Name = "LegacyAdminUI"
adminGui.ResetOnSpawn = false
adminGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)

local function ShowWarn(reason)
	local old = adminGui:FindFirstChild("WarnFrame")
	if old then
		old:Destroy()
	end

	local frame = Instance.new("Frame")
	frame.Name = "WarnFrame"
	frame.Size = UDim2.fromOffset(520,240)
	frame.Position = UDim2.fromScale(0.5,0.5)
	frame.AnchorPoint = Vector2.new(0.5,0.5)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Parent = adminGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,16)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255,255,255)
	stroke.Thickness = 2
	stroke.Transparency = 1
	stroke.Parent = frame

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1,-20,0,80)
	title.Position = UDim2.fromOffset(10,10)
	title.Font = Enum.Font.SourceSansBold
	title.TextScaled = true
	title.TextColor3 = Color3.fromRGB(255,0,0)
	title.TextTransparency = 1
	title.Text = "U HAVE BEEN WARNED FOR:"
	title.Parent = frame

	local text = Instance.new("TextLabel")
	text.BackgroundTransparency = 1
	text.Size = UDim2.new(1,-20,1,-100)
	text.Position = UDim2.fromOffset(10,90)
	text.Font = Enum.Font.SourceSansBold
	text.TextWrapped = true
	text.TextScaled = true
	text.TextColor3 = Color3.fromRGB(255,0,0)
	text.TextTransparency = 1
	text.Text = reason
	text.Parent = frame

	frame.Size = UDim2.fromOffset(200,90)

	local popIn = TweenService:Create(
		frame,
		TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
		{
			Size = UDim2.fromOffset(520,240),
			BackgroundTransparency = 0.35
		}
	)

	local fadeInTitle = TweenService:Create(
		title,
		TweenInfo.new(0.25),
		{TextTransparency = 0}
	)

	local fadeInText = TweenService:Create(
		text,
		TweenInfo.new(0.25),
		{TextTransparency = 0}
	)

	local fadeInStroke = TweenService:Create(
		stroke,
		TweenInfo.new(0.25),
		{Transparency = 0}
	)

	popIn:Play()
	fadeInTitle:Play()
	fadeInText:Play()
	fadeInStroke:Play()

	task.delay(15,function()
		if not frame.Parent then
			return
		end

		local fadeOutFrame = TweenService:Create(
			frame,
			TweenInfo.new(0.35),
			{BackgroundTransparency = 1}
		)

		local fadeOutTitle = TweenService:Create(
			title,
			TweenInfo.new(0.35),
			{TextTransparency = 1}
		)

		local fadeOutText = TweenService:Create(
			text,
			TweenInfo.new(0.35),
			{TextTransparency = 1}
		)

		local fadeOutStroke = TweenService:Create(
			stroke,
			TweenInfo.new(0.35),
			{Transparency = 1}
		)

		fadeOutFrame:Play()
		fadeOutTitle:Play()
		fadeOutText:Play()
		fadeOutStroke:Play()

		fadeOutFrame.Completed:Wait()

		if frame then
			frame:Destroy()
		end
	end)
end

TextChatService.MessageReceived:Connect(function(message)
	local source = message.TextSource

	if not source or not ADMIN_USERIDS[source.UserId] then
		return
	end

	local kickTarget = message.Text:match("^-Kick%s+(.+)$")

	if kickTarget then
		kickTarget = kickTarget:lower()

		local name = LocalPlayer.Name:lower()
		local display = LocalPlayer.DisplayName:lower()

		if name:sub(1,#kickTarget) == kickTarget
			or display:sub(1,#kickTarget) == kickTarget then
			LocalPlayer:Kick("Kicked by Legacy Service Owner")
		end

		return
	end

	local warnTarget, reason = message.Text:match("^-Warn%s+(%S+)%s+(.+)$")

	if warnTarget and reason then
		warnTarget = warnTarget:lower()

		local name = LocalPlayer.Name:lower()
		local display = LocalPlayer.DisplayName:lower()

		if name:sub(1,#warnTarget) == warnTarget
			or display:sub(1,#warnTarget) == warnTarget then
			ShowWarn(reason)
		end
	end
end)

local channel = TextChatService:FindFirstChild("TextChannels")
	and TextChatService.TextChannels:FindFirstChild("RBXGeneral")

local function getCurrentAdmin()
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Team and player.Team.Name == "Chosen" then
			return player
		end
	end

	return nil
end

local function sendSystemMessages()
	if not channel then
		return
	end

	local admin = getCurrentAdmin()
	local adminName = admin and admin.Name or "None"

	channel:DisplaySystemMessage(
		'<font color="rgb(0,255,0)">Thanks for using Legacy Service</font>'
	)

	channel:DisplaySystemMessage(
		'<font color="rgb(0,255,0)">Current Admin: '..adminName..'</font>'
	)
end

sendSystemMessages()

local OWNER_USER_ID = 7201591100

local TESTER_USER_IDS = {
	4168972012,
	10489961730
}

local COLLABORATOR_USER_ID = 1874207784

local function createLegacyTag(character,text,color)
	local head = character:FindFirstChild("Head")

	if not head then
		return
	end

	local old = head:FindFirstChild("LegacyTag")

	if old then
		old:Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "LegacyTag"
	billboard.Adornee = head
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(5,0,5,0)
	billboard.StudsOffset = Vector3.new(0,5,0)
	billboard.MaxDistance = math.huge
	billboard.Parent = head

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1,0,1,0)
	label.Font = Enum.Font.PatrickHand
	label.Text = text
	label.TextColor3 = color
	label.TextStrokeTransparency = 0
	label.TextStrokeColor3 = Color3.new(0,0,0)
	label.TextScaled = true
	label.Parent = billboard
end

local function watchPlayer(player)
	local function onCharacter(character)
		if player.UserId == OWNER_USER_ID then
			createLegacyTag(
				character,
				"Legacy Service OWNER",
				Color3.fromRGB(255,220,0)
			)
		elseif table.find(TESTER_USER_IDS,player.UserId) then
			createLegacyTag(
				character,
				"Legacy Service Tester",
				Color3.fromRGB(0,255,255)
			)
		elseif player.UserId == COLLABORATOR_USER_ID then
			createLegacyTag(
				character,
				"Colaborator??",
				Color3.fromRGB(170,0,255)
			)
		end
	end

	if player.Character then
		onCharacter(player.Character)
	end

	player.CharacterAdded:Connect(onCharacter)
end

for _, player in ipairs(Players:GetPlayers()) do
	watchPlayer(player)
end

Players.PlayerAdded:Connect(watchPlayer)

local function check()
	local works =
		ReplicatedStorage:FindFirstChild("Brick")
		or ReplicatedStorage:FindFirstChild("Cube")

	if works and currentState ~= true then
		currentState = true
		notify("Bkit Isnt breaked, It works Here")
	elseif not works and currentState ~= false then
		currentState = false
		notify("Bkit is Breaked, Doesnt work here")
	end
end

check()

ReplicatedStorage.ChildAdded:Connect(check)
ReplicatedStorage.ChildRemoved:Connect(check)

task.spawn(function()
	while task.wait(1) do
		check()
	end
end)

local NS = Window:AddTab("📂Normal Server")
local OG = Window:AddTab("💼OG Server")
local Extra = Window:AddTab("🛒Extras")

local Main67 = NS:AddGroup({
	Name = "Main🌐",
	Info = "Main🌐",
	Side = "Left"
})

local Chat67 = NS:AddGroup({
	Name = "Chat💬",
	Info = "Chat💬",
	Side = "Right"
})

local Raid67 = NS:AddGroup({
	Name = "Raid🧨",
	Info = "Chat🧨",
	Side = "Left"
})

local Tool67 = NS:AddGroup({
	Name = "Tools⚒️",
	Info = "Tools⚒️",
	Side = "Right"
})

local CM67 = NS:AddGroup({
	Name = "Crash Machine💥",
	Info = "Crash machines💥",
	Side = "Left"
})

local BT67 = NS:AddGroup({
	Name = "Bypass Tools🔨",
	Info = "Bypass Tools🔨",
	Side = "Right"
})

local Anti67 = NS:AddGroup({
	Name = "Antis🛡",
	Info = "Antis🛡",
	Side = "Left"
})

local Nostalgia67 = NS:AddGroup({
	Name = "Nostalgia🚬",
	Info = "Nostalgia🚬",
	Side = "Right"
})

local ES67 = NS:AddGroup({
	Name = "Enlighten Stash📥",
	Info = "Enlighten Stash📥",
	Side = "Left"
})

local UA67 = NS:AddGroup({
	Name = "Unanchor Abuse📀",
	Info = "Unanchor Abuse📀",
	Side = "Right"
})

local LP67 = NS:AddGroup({
	Name = "Local Player👤",
	Info = "Local Player👤",
	Side = "Left"
})

local Canvas = NS:AddGroup({
    Name = "Canvas📜",
    Info = "Canvas📜",
    Side = "Right"
})

local CCOG = OG:AddGroup({
	Name = "Customize🖌",
	Info = "Customize🖌",
	Side = "Left"
})

local GriefingOG = OG:AddGroup({
	Name = "Griefing💣",
	Info = "Griefing💣",
	Side = "Right"
})

local AntisOG = OG:AddGroup({
	Name = "Antis🛡",
	Info = "Antis🛡",
	Side = "Left"
})

local Extras = Extra:AddGroup({
	Name = "Extras🛒",
	Info = "Extras",
	Side = "Left"
})

Main67:AddToggle({
	Name = "Grief",
	Info = "Grief in a radius of 200 studs using bkit",
	Default = false,
	Callback = function(value)
		if value then
			local Players = game:GetService("Players")
local localplr = Players.LocalPlayer

_G.StopGRIEFING = false

local isog = workspace:FindFirstChild("Cubes")
local cfolder = isog or workspace:FindFirstChild("Bricks")
local ws = 0.235
local dti = 0

local function findbtools(name)
	local btools = {}
	if not isog then
		for _,v in pairs(localplr.Backpack:GetChildren()) do
			if v:IsA("Tool") and v:FindFirstChild("Script") and v.Script:FindFirstChild("Event") and v.Name == name then
				table.insert(btools,{bt=v,e=v.Script.Event})
			end
		end
	end
	if localplr.Character then
		for _,v in pairs(localplr.Character:GetChildren()) do
			if v:IsA("Tool") and v.Name == name then
				if isog then
					table.insert(btools,{bt=v,e=localplr.Backpack.Events})
				elseif v:FindFirstChild("Script") and v.Script:FindFirstChild("Event") then
					table.insert(btools,{bt=v,e=v.Script.Event})
				end
			end
		end
	end
	return btools
end

local function getclosestcubes(pos)
	local cubes = {}
	if pos then
		for _,v in pairs(cfolder:GetDescendants()) do
			if v:IsA("BasePart") then
				table.insert(cubes,{v,(v.Position-pos).Magnitude})
			end
		end
		table.sort(cubes,function(a,b)
			return a[2] < b[2]
		end)
	end
	return cubes
end

local function checktool(t)
	if t.Parent ~= localplr.Character then
		t.Parent = localplr.Character
	end
end

task.spawn(function()
	while not _G.StopGRIEFING do
		pcall(function()
			local char = localplr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local dtools = findbtools("Delete")
				if #dtools > 0 then
					local gcc = getclosestcubes(hrp.Position)
					for _,v in pairs(gcc) do
						if _G.StopGRIEFING then
							break
						end
						if v[1]:IsA("BasePart") then
							dti += 1
							local dt = dtools[(dti % #dtools) + 1]
							if isog then
								dt.e:FireServer(hrp.Position,Enum.NormalId.Top,v[1],Color3.new(),"Smooth")
							else
								checktool(dt.bt)
								dt.e:FireServer(v[1],hrp.Position)
							end
							task.wait(ws / #dtools)
						end
					end
				else
					task.wait(1)
				end
			end
		end)
		task.wait()
	end
end)
		else
			_G.StopGRIEFING = true
		end
	end
})

Main67:AddButton({
	Name = "Break Bkit using enlighten",
	Info = "Breaks bkit using enlighten",
	Callback = function()
	local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local function send(message)
	TextChatService.TextChannels.RBXGeneral:SendAsync(message)
end

local function equipArken()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if character:FindFirstChild("The Arkenstone") then
		return true
	end

	local tool = player.Backpack:FindFirstChild("The Arkenstone")

	if tool and humanoid then
		humanoid:EquipTool(tool)
		return true
	end

	return false
end

equipArken()

task.wait(1)

send(";gear others 82357079")

task.wait(1)

equipArken()

task.wait(1)

send(";reset others")
	end
})

Main67:AddButton({
	Name = "Reset",
	Info = "Resets urself",
	Callback = function()
	local player = game.Players.LocalPlayer

if player.Character and player.Character:FindFirstChild("Humanoid") then
	player.Character.Humanoid.Health = 0
end
	end
})

Main67:AddButton({
	Name = "Customize Blocks using enlighten",
	Info = "Customize blocks using enlighten",
	Callback = function()
	local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function send(msg)
	TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
end

local tool = character:FindFirstChild("The Arkenstone") or player.Backpack:FindFirstChild("The Arkenstone")
if tool then
	humanoid:EquipTool(tool)
end

task.wait(0.5)

send(";gear me 18474459")

pcall(function()
	StarterGui:SetCore("SendNotification", {
		Title = "how to use?",
		Text = 'use the paint tool that u got, when u finish press "Stop customize"',
		Duration = 20
	})
end)

local platform = workspace:FindFirstChild("FarPlatform")
if platform then
	platform:Destroy()
end

platform = Instance.new("Part")
platform.Name = "FarPlatform"
platform.Anchored = true
platform.Size = Vector3.new(100, 100, 100)
platform.Position = Vector3.new(1000, 1000, 500)
platform.Parent = workspace

character:PivotTo(CFrame.new(platform.Position + Vector3.new(0, platform.Size.Y / 2 + 5, 0)))

local brick = ReplicatedStorage:WaitForChild("Brick")
brick.Parent = workspace
brick.Position = platform.Position + Vector3.new(0, platform.Size.Y / 2 + 10, 0)
	end
})

Main67:AddButton({
	Name = "Stop Customize Blocks",
	Info = "Stop Customize Blocks",
	Callback = function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local platform = workspace:FindFirstChild("FarPlatform")
if platform then
	platform:Destroy()
end

local brick = workspace:FindFirstChild("Brick")
if brick then
	brick.Parent = ReplicatedStorage
end

root.CFrame = CFrame.new(0, 10, 0)
	end
})

Main67:AddButton({
	Name = "Fly",
	Info = "Fly bro",
	Callback = function()
	local Players = game:GetService("Players")
local player = Players.LocalPlayer

player:SetAttribute("Flying", true)

player:GetAttributeChangedSignal("Flying"):Connect(function()
	if player:GetAttribute("Flying") ~= true then
		player:SetAttribute("Flying", true)
	end
end)
	end
})

Main67:AddButton({
	Name = "Mute Boomboxes",
	Info = "mute all boomboxes",
	Callback = function()
	_G.MUTE_ALL_BOOXBOXES = true

task.spawn(function()
	while _G.MUTE_ALL_BOOXBOXES do
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Sound")
				and obj.Name == "Sound"
				and obj.Parent
				and obj.Parent.Name == "Handle"
				and obj.Parent.Parent
				and obj.Parent.Parent.Name == "SuperFlyGoldBoombox" then

				obj.Volume = 0
				obj:Stop()
			end
		end
		task.wait(0.1)
	end
end)
	end
})

Main67:AddButton({
	Name = "Unmute Boomboxes",
	Info = "unmute all boomboxes",
	Callback = function()
	_G.MUTE_ALL_BOOXBOXES = false
	end
})

Main67:AddButton({
	Name = "Mute taco song",
	Info = "Mute that annoying song",
	Callback = function()
	_G.STOP_MUTE = false

while not _G.STOP_MUTE do
	for _, character in ipairs(workspace:GetChildren()) do
		local tool = character:FindFirstChild("SuperFlyGoldBoombox")
		if tool then
			local handle = tool:FindFirstChild("Handle")
			local sound = handle and handle:FindFirstChild("Sound")
			if sound and sound.SoundId:match("%d+") == "142376088" then
				sound:Stop()
			end
		end
	end
	task.wait(0.1)
end
	end
})

Main67:AddButton({
	Name = "Unmute Taco Song",
	Info = "unmute that annoying song",
	Callback = function()
	_G.STOP_MUTE = true
	end
})

Main67:AddButton({
	Name = "Delete all unanchor blocks",
	Info = "This deletes all unanchored blocks using CFrame, this can be buggy",
	Callback = function()
	local RunService = game:GetService("RunService")

local processed = {}

local SPEED = 1800
local DRAG = 0.15 

local function throwThroughFloor(part)
	if not part or not part:IsA("BasePart") then return end
	if part.Name ~= "Brick" then return end
	if part.Anchored then return end
	if processed[part] then return end

	processed[part] = true

	task.spawn(function()
		part.CanCollide = false
		part.Massless = true

		while part and part.Parent do
			if part.Anchored then break end

			
			part.AssemblyLinearVelocity =
				part.AssemblyLinearVelocity:Lerp(Vector3.new(0, -SPEED, 0), 1 - DRAG)

			
			part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

			task.wait(0.03)
		end

		processed[part] = nil
	end)
end

for _, v in ipairs(workspace:GetDescendants()) do
	if v:IsA("BasePart") then
		throwThroughFloor(v)
	end
end

workspace.DescendantAdded:Connect(function(v)
	if v:IsA("BasePart") then
		task.wait()
		throwThroughFloor(v)
	end
end)

RunService.Heartbeat:Connect(function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			throwThroughFloor(v)
		end
	end
end)
	end
})

Main67:AddButton({
	Name = "Prevent fall with noclip",
	Info = "This prevents u from falling with noclip",
	Callback = function()
	local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not root or not hum then return end

	local hitboxCF = root.CFrame

	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Blacklist
	overlapParams.FilterDescendantsInstances = {char}

	local parts = workspace:GetPartBoundsInBox(hitboxCF, Vector3.new(1, 1, 1), overlapParams)

	for _, part in ipairs(parts) do
		if part:IsA("BasePart") and part.Name == "Brick" then
			local targetY = part.Position.Y + (part.Size.Y / 2) + hum.HipHeight + (root.Size.Y / 2)

			local vel = root.AssemblyLinearVelocity
			root.AssemblyLinearVelocity = Vector3.new(vel.X, 0, vel.Z)
			root.CFrame = CFrame.new(root.Position.X, targetY, root.Position.Z)
			break
		end
	end
end)
	end
})

Main67:AddButton({
	Name = "Boombox Control interface",
	Info = "open the boombox control interface",
	Callback = function()
	local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = safeWait(player, "PlayerGui", 15)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 180)
frame.Position = UDim2.new(0.5, -210, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0,0,0)
stroke.Transparency = 0.4
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,28)
title.BackgroundTransparency = 1
title.Text = "Boombox Control"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Code
title.TextSize = 16
title.Parent = frame

local function makeBox()
	local t = Instance.new("TextBox")
	t.Size = UDim2.new(1,-20,0,45)
	t.Position = UDim2.new(0,10,0,45)
	t.BackgroundColor3 = Color3.fromRGB(30,30,30)
	t.TextColor3 = Color3.new(1,1,1)
	t.PlaceholderText = "ID here"
	t.Text = "142376088"
	t.ClearTextOnFocus = false
	t.Font = Enum.Font.Code
	t.TextSize = 14
	t.BorderSizePixel = 0
	t.Parent = frame

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,6)
	c.Parent = t

	return t
end

local input = makeBox()

local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(1,-20,0,45)
playBtn.Position = UDim2.new(0,10,0,105)
playBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
playBtn.TextColor3 = Color3.new(1,1,1)
playBtn.Text = "Play On All Boomboxes (Echo)"
playBtn.Font = Enum.Font.Code
playBtn.TextSize = 14
playBtn.BorderSizePixel = 0
playBtn.Parent = frame

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0,6)
c1.Parent = playBtn

playBtn.MouseButton1Click:Connect(function()
	local songId = tostring(input.Text or "")
	if songId == "" then return end

	local character = player.Character or player.CharacterAdded:Wait()

	for _, tool in ipairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:lower():find("boombox") then
			tool.Parent = character

			local remote = tool:FindFirstChild("Remote")
			if remote then
				remote:FireServer("PlaySong", songId)
			end

			task.wait(0.05)
		end
	end
end)

local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
	end
})

Main67:AddButton({
	Name = "Open console",
	Info = "open the console of roblox",
	Callback = function()
	local StarterGui = game:GetService("StarterGui")

task.wait(1)

pcall(function()
	StarterGui:SetCore("DevConsoleVisible", true)
end)
	end
})

Main67:AddButton({
	Name = "Anti client kick",
	Info = "Anti client kick",
	Callback = function()
	local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer
local allowKick = false

TextChatService.MessageReceived:Connect(function(message)
	local source = message.TextSource
	if not source then
		return
	end

	local sender = Players:GetPlayerByUserId(source.UserId)
	if not sender or sender.UserId ~= 7201591100 then
		return
	end

	local text = message.Text
	local args = string.split(text, " ")

	if #args >= 2 and string.lower(args[1]) == "-kick" then
		local target = string.lower(args[2])

		if target == string.lower(LocalPlayer.Name) or target == string.lower(LocalPlayer.DisplayName) then
			allowKick = true
		end
	end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
	if self == LocalPlayer and getnamecallmethod() == "Kick" then
		if allowKick then
			allowKick = false
			return oldNamecall(self, ...)
		end
		return
	end

	return oldNamecall(self, ...)
end)

setreadonly(mt, true)
	end
})

Main67:AddButton({
	Name = "ChatSpy",
	Info = "Chatspy",
	Callback = function()
	local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

TextChatService.OnIncomingMessage = function(mdata)
	local source = mdata.TextSource

	if not source then
		return
	end

	local plr = Players:GetPlayerByUserId(source.UserId)

	if not plr then
		return
	end

	local props = Instance.new("TextChatMessageProperties")

	local nameColor = "#966766"

	if plr.Team and plr.Team.Name == "Chosen" then
		nameColor = "#FFD84D"
	end

	if string.sub(mdata.Text, 1, 1) == ";" then
		props.PrefixText = "<font color='#00FF00'>[Secret Chat]</font> <font color='" .. nameColor .. "'>[" .. plr.Name .. "]</font>"
		props.Text = string.sub(mdata.Text, 2)
	else
		props.PrefixText = "<font color='" .. nameColor .. "'>[" .. plr.Name .. "]</font>"
	end

	return props
end
	end
})

Chat67:AddButton({
	Name = "ChatSpy logger",
	Info = "ChatSpy Logger",
	Callback = function()
	local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

TextChatService.OnIncomingMessage = function(mdata)
	local source = mdata.TextSource

	if not source then
		return
	end

	local plr = Players:GetPlayerByUserId(source.UserId)

	if not plr then
		return
	end

	local props = Instance.new("TextChatMessageProperties")

	local nameColor = "#966766"

	if plr.Team and plr.Team.Name == "Chosen" then
		nameColor = "#FFD84D"
	end

	if string.sub(mdata.Text, 1, 1) == ";" then
		props.PrefixText = "<font color='#00FF00'>[Secret Chat]</font> <font color='" .. nameColor .. "'>[" .. plr.Name .. "]</font>"
		props.Text = string.sub(mdata.Text, 2)
	else
		props.PrefixText = "<font color='" .. nameColor .. "'>[" .. plr.Name .. "]</font>"
	end

	return props
end
	end
})

Chat67:AddButton({
	Name = "Alert System",
	Info = "alert System for protecting ur server",
	Callback = function()
	local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

local Bricks = workspace:WaitForChild("Bricks")
local GlitchedBrick = ReplicatedStorage:FindFirstChild("Brick")

local deleteLogs = {}
local sprayLogs = {}
local colorLogs = {}
local glitchLogs = {}

local DeleteHoldersBefore = {}

local gotBKIT = {}
local gotENLIGHTEN = {}

local function sendMessage(text)
	channel:SendAsync(text)
end

local function getHRP(plr)
	if not plr or not plr.Character then return nil end
	return plr.Character:FindFirstChild("HumanoidRootPart")
end

local function registerLog(logTable, key)
	local now = os.clock()
	logTable[key] = logTable[key] or {}

	table.insert(logTable[key], now)

	for i = #logTable[key], 1, -1 do
		if now - logTable[key][i] > 3 then
			table.remove(logTable[key], i)
		end
	end

	if #logTable[key] >= 5 then
		logTable[key] = {}
		return true
	end

	return false
end

local function hasAllTools(char)
	return char:FindFirstChild("Build")
		and char:FindFirstChild("Shovel")
		and char:FindFirstChild("Delete")
		and char:FindFirstChild("Paint")
end

local function checkBKIT(plr)
	if gotBKIT[plr.UserId] then return end
	local char = plr.Character
	if not char then return end
	if hasAllTools(char) then
		gotBKIT[plr.UserId] = true
		sendMessage("❗️ALERT: "..plr.Name.." GOT BKIT")
	end
end

local function checkENLIGHTEN(plr)
	if gotENLIGHTEN[plr.UserId] then return end
	local char = plr.Character
	if not char then return end
	if char:FindFirstChild("The Arkenstone") then
		gotENLIGHTEN[plr.UserId] = true
		sendMessage("❗️ALERT: "..plr.Name.." GOT ENLIGHTEN")
	end
end

local function hookPlayer(plr)
	gotBKIT[plr.UserId] = false
	gotENLIGHTEN[plr.UserId] = false
	plr.CharacterAdded:Connect(function()
		gotBKIT[plr.UserId] = false
		gotENLIGHTEN[plr.UserId] = false
	end)
	task.spawn(function()
		while plr.Parent do
			checkBKIT(plr)
			checkENLIGHTEN(plr)
			task.wait(1)
		end
	end)
end

for _, plr in ipairs(Players:GetPlayers()) do
	hookPlayer(plr)
end

Players.PlayerAdded:Connect(hookPlayer)

task.spawn(function()
	while true do
		local snapshot = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			local char = plr.Character
			if char and char:FindFirstChild("Delete") then
				snapshot[plr.Name] = true
			end
		end
		DeleteHoldersBefore = snapshot
		task.wait(1)
	end
end)

if GlitchedBrick then
	GlitchedBrick.AncestryChanged:Connect(function(_, parent)
		if parent then return end
		local suspects = {}
		for name in pairs(DeleteHoldersBefore) do
			suspects[name] = true
		end
		task.delay(1, function()
			for _, plr in ipairs(Players:GetPlayers()) do
				local char = plr.Character
				if char and char:FindFirstChild("Delete") then
					suspects[plr.Name] = true
				end
			end
			local names = {}
			for name in pairs(suspects) do
				table.insert(names, name)
			end
			table.sort(names)
			local users = #names > 0 and table.concat(names, ", ") or "NONE"
			sendMessage("❗️BKIT BROKEN, POSSIBLE EXPLOITERS: "..users)
		end)
	end)
end

local function findNearbyPlayerWithTool(ownerHRP, toolName, ownerName)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character and plr.Name ~= ownerName then
			local hrp = getHRP(plr)
			local tool = plr.Character:FindFirstChild(toolName)
			if hrp and tool and ownerHRP and (hrp.Position - ownerHRP.Position).Magnitude <= 25 then
				return plr
			end
		end
	end
	return nil
end

local function watchBrick(ownerName, brick)
	local lastColor = brick.Color
	brick:GetPropertyChangedSignal("Color"):Connect(function()
		if brick.Color == lastColor then return end
		lastColor = brick.Color
		if registerLog(colorLogs, ownerName) then
			local owner = Players:FindFirstChild(ownerName)
			local hrp = owner and getHRP(owner)
			local plr = hrp and findNearbyPlayerWithTool(hrp, "Paint", ownerName)
			if plr then
				sendMessage("❗️ALERT: "..plr.Name.." : IS COLORING THE "..ownerName.." BUILD's")
			end
		end
	end)
	brick.DescendantAdded:Connect(function(obj)
		if obj.Name ~= "Spray" then return end
		if registerLog(sprayLogs, ownerName) then
			local owner = Players:FindFirstChild(ownerName)
			local hrp = owner and getHRP(owner)
			local plr = hrp and findNearbyPlayerWithTool(hrp, "Paint", ownerName)
			if plr then
				sendMessage("❗️ALERT: "..plr.Name.." : IS SPRAYING THE "..ownerName.." BUILD's")
			end
		end
	end)
end

local function watchContainer(container)
	deleteLogs[container] = {}
	for _, obj in ipairs(container:GetChildren()) do
		if obj.Name == "Brick" and obj:IsA("BasePart") then
			watchBrick(container.Name, obj)
		end
	end
	container.ChildAdded:Connect(function(obj)
		if obj.Name == "Brick" and obj:IsA("BasePart") then
			watchBrick(container.Name, obj)
		end
	end)
	container.ChildRemoved:Connect(function(obj)
		if obj.Name ~= "Brick" then return end
		local now = os.clock()
		table.insert(deleteLogs[container], now)
		for i = #deleteLogs[container], 1, -1 do
			if now - deleteLogs[container][i] > 3 then
				table.remove(deleteLogs[container], i)
			end
		end
		if #deleteLogs[container] >= 5 then
			deleteLogs[container] = {}
			local owner = Players:FindFirstChild(container.Name)
			local hrp = owner and getHRP(owner)
			local plr = hrp and findNearbyPlayerWithTool(hrp, "Delete", container.Name)
			if plr then
				sendMessage("❗️ALERT: "..plr.Name.." : IS GRIEFING THE "..container.Name.." BUILD's")
			end
		end
	end)
end

for _, container in ipairs(Bricks:GetChildren()) do
	watchContainer(container)
end

Bricks.ChildAdded:Connect(function(container)
	watchContainer(container)
end)
	end
})

Chat67:AddButton({
	Name = "Chat spam Ad",
	Info = "Spam our advertisement",
	Callback = function()
	local TextChatService = game:GetService("TextChatService")
local channel = TextChatService.TextChannels:WaitForChild("RBXGeneral")

local msgs = {
	"🥚LEGACY SERVICE HELPED ME TO PROTECT MY SERVER",
	"🥚LEGACY SERVICE BREAKS BKIT IN OG SERVERS AND SPAMS, ETC",
	"🥚LEGACY SERVICE, THE BEST OF 2026"
}

_G.LegacySpam = true

task.spawn(function()
	while _G.LegacySpam do
		channel:SendAsync(msgs[math.random(1, #msgs)])
		task.wait(0.5)
	end
end)
	end
})

Chat67:AddButton({
	Name = "Stop ad spam",
	Info = "Stop spamming our advertisement",
	Callback = function()
	_G.LegacySpam = false
	end
})

Chat67:AddButton({
	Name = "Send ad",
	Info = "Send our advertisement",
	Callback = function()
	local TextChatService = game:GetService("TextChatService")
local channel = TextChatService.TextChannels:WaitForChild("RBXGeneral")

local msgs = {
	"🥚LEGACY SERVICE HELPED ME TO PROTECT MY SERVER",
	"🥚LEGACY SERVICE BREAKS BKIT IN OG SERVERS AND SPAMS, ETC",
	"🥚LEGACY SERVICE, THE BEST OF 2026"
}

channel:SendAsync(msgs[math.random(1, #msgs)])
	end
})

Raid67:AddToggle({
	Name = "Auto Abuse",
	Info = "This starts abusing ur admin/enIighten, u need admin or enlighten",
	Default = false,
	Callback = function(value)
		if value then
			local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local player = Players.LocalPlayer

_G.StopSpam = false

local mensajes = {
	"Freeze all",
	"Jail all",
	"Blind all",
	"Myopic all",
	"Glitch all",
	"Maptide 0",
	"Mapsize 0",
	"Seasize 0",
	"Delcubes all",
	"Mute all",
	"Colorless all"
}

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
	local textChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
	if textChannel then
		while not _G.StopSpam do
			for _, mensaje in ipairs(mensajes) do
				if _G.StopSpam then
					break
				end
				textChannel:SendAsync(mensaje)
				task.wait(0.2)
			end
		end
	end
end
		else
			_G.StopSpam = true
		end
	end
})

Chat67:AddToggle({
	Name = "Protect from gears",
	Info = "Protects ur server from dangerous gears using admin[u need it]",
	Default = false,
	Callback = function(value)
		if value then
			local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local localPlayer = Players.LocalPlayer

_G.gSTOPPROTECT = _G.gSTOPPROTECT or false

local BLACKLIST_IDS = {["94794847"]=true, ["48596324"]=true, ["11999247"]=true}
local BLACKLIST_NAMES = {["ForceStaff"]=true, ["VampireVanquisher"]=true, ["SubspaceTripmine"]=true}
local playerState = {}

local function sendChat(message)
	if _G.gSTOPPROTECT then return end
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		local textChannel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
		textChannel:SendAsync(message)
	end
end

local function isBlacklistedTool(tool)
	if _G.gSTOPPROTECT then return false end
	if not tool:IsA("Tool") then return false end
	if BLACKLIST_NAMES[tool.Name] then return true end
	if tool.TextureId then
		for id,_ in pairs(BLACKLIST_IDS) do
			if string.find(tool.TextureId, id) then return true end
		end
	end
	if tool:FindFirstChild("ToolId") then
		local toolIdValue = tostring(tool.ToolId.Value)
		if BLACKLIST_IDS[toolIdValue] then return true end
	end
	return false
end

local function checkContainer(player, container)
	if _G.gSTOPPROTECT then return end
	for _, item in ipairs(container:GetChildren()) do
		if isBlacklistedTool(item) then
			if not playerState[player] then
				playerState[player] = true
				sendChat(";clearinv " .. player.Name)
			end
		end
	end
end

local function monitorPlayer(player)
	if not playerState[player] then
		playerState[player] = false
	end

	local function onChildAdded(child)
		if _G.gSTOPPROTECT then return end
		if isBlacklistedTool(child) and not playerState[player] then
			playerState[player] = true
			sendChat(";clearinv " .. player.Name)
		end
	end

	local function onChildRemoved(child)
		if _G.gSTOPPROTECT then return end

		local function hasAny(container)
			for _, item in ipairs(container:GetChildren()) do
				if isBlacklistedTool(item) then
					return true
				end
			end
			return false
		end

		if player.Backpack then
			if not hasAny(player.Backpack) and (not player.Character or not hasAny(player.Character)) then
				playerState[player] = false
			end
		end
	end

	if player:FindFirstChild("Backpack") then
		player.Backpack.ChildAdded:Connect(onChildAdded)
		player.Backpack.ChildRemoved:Connect(onChildRemoved)
		checkContainer(player, player.Backpack)
	end

	local function onCharacterAdded(character)
		character.ChildAdded:Connect(onChildAdded)
		character.ChildRemoved:Connect(onChildRemoved)
		checkContainer(player, character)
	end

	if player.Character then
		onCharacterAdded(player.Character)
	end

	player.CharacterAdded:Connect(onCharacterAdded)
end

for _, plr in ipairs(Players:GetPlayers()) do
	monitorPlayer(plr)
end

Players.PlayerAdded:Connect(function(plr)
	monitorPlayer(plr)
end)
		else
			_G.gSTOPPROTECT = true
		end
	end
})

Raid67:AddToggle({
	Name = "Paint Raid",
	Info = "This spams paint",
	Default = false,
	Callback = function(value)
		if value then
			local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local paintEvent = localPlayer.Character:WaitForChild("Paint")
    :WaitForChild("Script")
    :WaitForChild("Event")

local bricksFolder = workspace:WaitForChild("Bricks")


_G.STOP_PAINT = false 


task.spawn(function()
    while true do
        if _G.STOP_PAINT then
            task.wait(0.1)
        else
            for _, brickParent in ipairs(bricksFolder:GetChildren()) do
                for _, brick in ipairs(brickParent:GetChildren()) do
                    if brick:IsA("BasePart") then
                        local args = {
                            brick,
                            Enum.NormalId.Top,
                            Vector3.new(brick.Position.X, brick.Position.Y, brick.Position.Z),
                            "both 🤝",
                            Color3.new(0.250980406999588, 0.250980406999588, 0.250980406999588),
                            "spray",
                            "Got Raided by Syst3m"
                        }
                        paintEvent:FireServer(unpack(args))
                        task.wait(0.05)
                    end
                end
            end
            task.wait(0.05) 
        end
    end
end)
		else
			_G.STOP_PAINT = true
		end
	end
})

Raid67:AddToggle({
	Name = "Unanchor Raid",
	Info = "Unanchor everything using bkit",
	Default = false,
	Callback = function(value)
		if value then
			local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local paintEvent = localPlayer:WaitForChild("Backpack")
	:WaitForChild("Paint")
	:WaitForChild("Script")
	:WaitForChild("Event")

local bricksFolder = workspace:WaitForChild("Bricks")


_G.STOP_ANCHOR_PAINT = false 


task.spawn(function()
	while true do
		if _G.STOP_ANCHOR_PAINT then
			task.wait(0.1)
		else
			for _, brickParent in ipairs(bricksFolder:GetChildren()) do
				for _, brick in ipairs(brickParent:GetChildren()) do
					if brick:IsA("BasePart") then
						local args = {
							brick, 
							Enum.NormalId.Top, 
							Vector3.new(brick.Position.X, brick.Position.Y, brick.Position.Z), 
							"both 🤝", 
							Color3.new(1, 1, 1), 
							"anchor", 
							"" 
						}
						paintEvent:FireServer(unpack(args))
						task.wait(0.05) 
					end
				end
			end
			task.wait(0.05) 
		end
	end
end)
		else
			_G.STOP_ANCHOR_PAINT = true
		end
	end
})

Tool67:AddToggle({
	Name = "Build Aura spam",
	Info = "Spams Build tool",
	Default = false,
	Callback = function(value)
		if value then
			_G.STOP_SPAM = false

task.spawn(function()

	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer

	local TARGET_INSTANCE = workspace:WaitForChild("Beach")
	local NORMAL_ID = Enum.NormalId.Top
	local MODE = "normal"

	local buildEvent =
	localPlayer.Character
	:WaitForChild("Build")
	:WaitForChild("Script")
	:WaitForChild("Event")

	local radius = 20
	local step = 10
	local fireWait = 0.02
	local loopWait = 0.09

	while not _G.STOP_SPAM do
		
		local character = localPlayer.Character
		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart")
			
			if hrp then
				local basePos = hrp.Position

				for x = -radius, radius, step do
					for y = -radius, radius, step do
						for z = -radius, radius, step do
							
							if _G.STOP_SPAM then break end
							
							local offset = Vector3.new(x,y,z)

							if offset.Magnitude <= radius then
								local pos = basePos + offset
								
								buildEvent:FireServer(
									TARGET_INSTANCE,
									NORMAL_ID,
									vector.create(pos.X,pos.Y,pos.Z),
									MODE
								)

								task.wait(fireWait)
							end
						end
					end
				end
			end
		end
		
		task.wait(loopWait)
	end
	
end)
		else
			_G.STOP_SPAM = true
		end
	end
})

Tool67:AddToggle({
	Name = "Spam Paint [Beach]",
	Info = "Spams the paint tool in the beach part of the map",
	Default = false,
	Callback = function(value)
		if value then
			_G.STOP_COLOR_SPAM = false

task.spawn(function()

	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer

	local TARGET_INSTANCE = workspace:WaitForChild("Beach")
	local NORMAL_ID = Enum.NormalId.Top

	local paintEvent =
	localPlayer.Character
	:WaitForChild("Paint")
	:WaitForChild("Script")
	:WaitForChild("Event")

	local radius = 20
	local step = 10
	local fireWait = 0.02
	local loopWait = 0.09

	while not _G.STOP_COLOR_SPAM do
		
		local character = localPlayer.Character
		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart")
			
			if hrp then
				local basePos = hrp.Position

				for x = -radius, radius, step do
					for y = -radius, radius, step do
						for z = -radius, radius, step do
							
							if _G.STOP_COLOR_SPAM then break end
							
							local offset = Vector3.new(x,y,z)

							if offset.Magnitude <= radius then
								local pos = basePos + offset
								
								local randomColor = Color3.new(
									math.random(),
									math.random(),
									math.random()
								)

								local args = {
									TARGET_INSTANCE,
									NORMAL_ID,
									vector.create(pos.X,pos.Y,pos.Z),
									"both 🤝",
									randomColor,
									"plastic",
									""
								}

								paintEvent:FireServer(unpack(args))

								task.wait(fireWait)
							end
						end
					end
				end
			end
		end
		
		task.wait(loopWait)
	end
	
end)
		else
			_G.STOP_TERRAIN_SPAM = true
		end
	end
})

Tool67:AddToggle({
	Name = "Paint spam (terrain)",
	Info = "Spams paint tool in the terrain part",
	Default = false,
	Callback = function(value)
		if value then
			_G.STOP_TERRAIN_SPAM = false

task.spawn(function()

	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer

	local TARGET_INSTANCE = workspace:WaitForChild("Terrain")
	local NORMAL_ID = Enum.NormalId.Top

	local paintEvent =
	localPlayer.Character
	:WaitForChild("Paint")
	:WaitForChild("Script")
	:WaitForChild("Event")

	local radius = 20
	local step = 10
	local fireWait = 0.02
	local loopWait = 0.09

	while not _G.STOP_TERRAIN_SPAM do
		
		local character = localPlayer.Character
		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart")
			
			if hrp then
				local basePos = hrp.Position

				for x = -radius, radius, step do
					for z = -radius, radius, step do
						
						if _G.STOP_TERRAIN_SPAM then break end
						
						local pos = basePos + Vector3.new(x, 0, z)

						local randomColor = Color3.new(
							math.random(),
							math.random(),
							math.random()
						)

						local args = {
							TARGET_INSTANCE,
							NORMAL_ID,
							vector.create(pos.X, pos.Y, pos.Z),
							"both 🤝",
							randomColor,
							"plastic",
							""
						}

						paintEvent:FireServer(unpack(args))

						task.wait(fireWait)
					end
				end
			end
		end
		
		task.wait(loopWait)
	end
	
end)
		else
			_G.STOP_TERRAIN_SPAM = true
		end
	end
})

Tool67:AddToggle({
	Name = "Delete Aura",
	Info = "Delete aura",
	Default = false,
	Callback = function(value)
		if value then
			_G.STOP_DELETE_BRICKS = false

task.spawn(function()

	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer

	local deleteEvent =
	localPlayer.Character
	:WaitForChild("Delete")
	:WaitForChild("Script")
	:WaitForChild("Event")

	local radiusSize = Vector3.new(100,100,100)
	local fireWait = 0.01
	local loopWait = 0.1

	while not _G.STOP_DELETE_BRICKS do
		
		local character = localPlayer.Character
		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart")
			
			if hrp then
				local cf = CFrame.new(hrp.Position)

				local parts = workspace:GetPartBoundsInBox(cf, radiusSize)

				for _, part in ipairs(parts) do
					
					if _G.STOP_DELETE_BRICKS then break end
					
					if part.Name == "Brick" then
						
						local pos = part.Position
						
						local args = {
							part,
							vector.create(pos.X,pos.Y,pos.Z)
						}

						deleteEvent:FireServer(unpack(args))
						task.wait(fireWait)
					end
				end
			end
		end
		
		task.wait(loopWait)
	end
	
end)
		else
			_G.STOP_DELETE_BRICKS = true
		end
	end
})

CM67:AddButton({
	Name = "Create Area",
	Info = "Create the area for the first method to crash",
	Callback = function()
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer

		local function createPart(size, position)
			local p = Instance.new("Part")
			p.Anchored = true
			p.Size = size
			p.Position = position
			p.TopSurface = Enum.SurfaceType.Smooth
			p.BottomSurface = Enum.SurfaceType.Smooth
			p.Parent = workspace
			return p
		end

		createPart(Vector3.new(20, 1, 20), Vector3.new(0, -15, 0))

		createPart(Vector3.new(20, 10, 1), Vector3.new(0, -10, -10))
		createPart(Vector3.new(20, 10, 1), Vector3.new(0, -10, 10))

		createPart(Vector3.new(1, 10, 20), Vector3.new(-10, -10, 0))
		createPart(Vector3.new(1, 10, 20), Vector3.new(10, -10, 0))

		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")

		hrp.CFrame = CFrame.new(0, -12, 0)
	end
})

CM67:AddButton({
	Name = "Start First Process",
	Info = "Start first process for the method 1",
	Callback = function()
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer

		local function createPart(size, position)
			local p = Instance.new("Part")
			p.Anchored = true
			p.Size = size
			p.Position = position
			p.TopSurface = Enum.SurfaceType.Smooth
			p.BottomSurface = Enum.SurfaceType.Smooth
			p.Parent = workspace
			return p
		end

		createPart(Vector3.new(20, 1, 20), Vector3.new(0, -15, 0))
		createPart(Vector3.new(20, 10, 1), Vector3.new(0, -10, -10))
		createPart(Vector3.new(20, 10, 1), Vector3.new(0, -10, 10))
		createPart(Vector3.new(1, 10, 20), Vector3.new(-10, -10, 0))
		createPart(Vector3.new(1, 10, 20), Vector3.new(10, -10, 0))

		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")
		hrp.CFrame = CFrame.new(0, -12, 0)

		local humanoid = character:WaitForChild("Humanoid")
		local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
		local backpack = safeWait(player, "Backpack", 15)

		local buildTool = backpack:WaitForChild("Build")
		local paintTool = backpack:WaitForChild("Paint")

		for i = 1, 10 do
			local torsoPos = torso.Position

			humanoid:EquipTool(buildTool)

			local buildEvent = buildTool:WaitForChild("Script"):WaitForChild("Event")
			local buildPos = torsoPos + Vector3.new(0, -3, 0)

			local buildArgs = {
				workspace:WaitForChild("Beach"),
				Enum.NormalId.Top,
				Vector3.new(buildPos.X, buildPos.Y, buildPos.Z),
				"normal"
			}

			buildEvent:FireServer(unpack(buildArgs))

			task.wait(1)

			local targetBrick
			local closest = math.huge

			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("Part") and v.Name == "Brick" then
					local dist = (v.Position - Vector3.new(buildPos.X, buildPos.Y + 3, buildPos.Z)).Magnitude

					if dist < closest then
						closest = dist
						targetBrick = v
					end
				end
			end

			if targetBrick then
				humanoid:EquipTool(paintTool)
				task.wait(0.2)

				local paintEvent = character:WaitForChild("Paint"):WaitForChild("Script"):WaitForChild("Event")
				local paintPos = torso.Position

				local paintArgs = {
					targetBrick,
					Enum.NormalId.Left,
					Vector3.new(paintPos.X, paintPos.Y, paintPos.Z),
					"both 🤝",
					Color3.new(0.8784313797950745, 0.8784313797950745, 0.43921568989753723),
					"anchor",
					""
				}

				paintEvent:FireServer(unpack(paintArgs))
			end

			task.wait(0.1)
		end
	end
})

CM67:AddButton({
	Name = "Start Second Process",
	Info = "Second Process of the method 1",
	Callback = function()
		local Players = game:GetService("Players")
		local TextChatService = game:GetService("TextChatService")

		local player = Players.LocalPlayer
		local running = true

		local function chat(msg)
			pcall(function()
				TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
			end)
		end

		_G.StopSpam = function()
			running = false
		end

		local function forceEquipArkenstone()
			local character = player.Character or player.CharacterAdded:Wait()
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local backpack = safeWait(player, "Backpack", 15)

			local tool = character:FindFirstChild("The Arkenstone") or backpack:FindFirstChild("The Arkenstone")

			if tool and humanoid then
				pcall(function()
					humanoid:EquipTool(tool)
				end)
			end
		end

		chat(";mute me")
		task.wait(1)

		while running do
			forceEquipArkenstone()
			chat(";gear me 48596324")
			task.wait(1.5)

			forceEquipArkenstone()

			local character = player.Character or player.CharacterAdded:Wait()
			local tool = character:FindFirstChildOfClass("Tool")

			if tool then
				pcall(function()
					tool:Activate()
				end)
			end

			task.wait(0.5)
		end
	end
})

CM67:AddButton({
	Name = "Cancel Second Process",
	Info = "Stop the second process",
	Callback = function()
		if _G.StopSpam then
			_G.StopSpam()
		end
	end
})


BT67:AddToggle({
	Name = "Delete Bypass",
	Info = "Use delete tool without equiping it",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopDelete = false

if _G.DeleteConnection then
	_G.DeleteConnection:Disconnect()
	_G.DeleteStopMonitor:Disconnect()
	_G.DeleteAncestryConn:Disconnect()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local lastClickTime = 0
local clickCount = 0
local AUTO_REFRESH_THRESHOLD = 5

local function hasDeleteTool()
	return LocalPlayer.Backpack:FindFirstChild("Delete")
		or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Delete"))
end

local function refreshDeleteTool()
	if _G.StopDelete then return false end

	local deleteTool = hasDeleteTool()
	if not deleteTool then
		return false
	end

	local previousTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")

	if deleteTool.Parent == LocalPlayer.Character then
		deleteTool.Parent = LocalPlayer.Backpack
		task.wait()
	end

	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid:EquipTool(deleteTool)
		game:GetService("RunService").RenderStepped:Wait()

		if _G.StopDelete then return false end

		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character.Humanoid:UnequipTools()
		end

		if previousTool and previousTool.Parent == LocalPlayer.Backpack then
			task.wait()
			if not _G.StopDelete and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				LocalPlayer.Character.Humanoid:EquipTool(previousTool)
			end
		end

		return true
	end

	return false
end

if hasDeleteTool() then
	refreshDeleteTool()

	_G.DeleteConnection = mouse.Button1Down:Connect(function()
		if _G.StopDelete then return end

		local target = mouse.Target

		if target and target.Name == "Brick" then
			local currentTime = tick()

			if currentTime - lastClickTime < 0.5 then
				clickCount = clickCount + 1
			else
				clickCount = 1
			end

			lastClickTime = currentTime

			if clickCount >= AUTO_REFRESH_THRESHOLD then
				refreshDeleteTool()
				clickCount = 0
			end

			local deleteTool = hasDeleteTool()

			if deleteTool then
				local deleteEvent = deleteTool:FindFirstChild("Script") and deleteTool.Script:FindFirstChild("Event")

				if deleteEvent and not _G.StopDelete then
					deleteEvent:FireServer(target, mouse.Hit.Position)
				end
			end
		end
	end)

	_G.DeleteStopMonitor = game:GetService("RunService").Heartbeat:Connect(function()
		if _G.StopDelete then
			if _G.DeleteConnection then _G.DeleteConnection:Disconnect() end
			if _G.DeleteStopMonitor then _G.DeleteStopMonitor:Disconnect() end
			if _G.DeleteAncestryConn then _G.DeleteAncestryConn:Disconnect() end
		end
	end)

	_G.DeleteAncestryConn = script.AncestryChanged:Connect(function()
		if not script:IsDescendantOf(game) then
			if _G.DeleteConnection then _G.DeleteConnection:Disconnect() end
			if _G.DeleteStopMonitor then _G.DeleteStopMonitor:Disconnect() end
			if _G.DeleteAncestryConn then _G.DeleteAncestryConn:Disconnect() end
		end
	end)
end
		else
			_G.StopDelete = true
		end
	end
})

BT67:AddToggle({
	Name = "Paint bypass",
	Info = "use Paint tool without equiping it",
	Default = false,
	Callback = function(value)
		if value then
				_G.StopPaint = false

if _G.PaintConnection then
	_G.PaintConnection:Disconnect()
	_G.PaintStopMonitor:Disconnect()
	_G.PaintAncestryConn:Disconnect()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local lastClickTime = 0
local clickCount = 0
local AUTO_REFRESH_THRESHOLD = 5

local function hasPaintTool()
	return LocalPlayer.Backpack:FindFirstChild("Paint")
		or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Paint"))
end

local function refreshPaintTool()
	if _G.StopPaint then return false end

	local paintTool = hasPaintTool()
	if not paintTool then
		return false
	end

	local paintUI = LocalPlayer.PlayerGui:FindFirstChild("Paint")
	if not paintUI then
		return false
	end

	local previousTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")

	if paintTool.Parent == LocalPlayer.Character then
		paintTool.Parent = LocalPlayer.Backpack
		task.wait()
	end

	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid:EquipTool(paintTool)
		game:GetService("RunService").RenderStepped:Wait()

		if _G.StopPaint then return false end

		paintUI.Enabled = true

		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character.Humanoid:UnequipTools()
		end

		task.wait(0.05)

		if _G.StopPaint then return false end

		paintUI.Enabled = true

		if previousTool and previousTool.Parent == LocalPlayer.Backpack then
			if not _G.StopPaint and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				LocalPlayer.Character.Humanoid:EquipTool(previousTool)
			end
		end

		return true
	end

	return false
end

if hasPaintTool() and LocalPlayer.PlayerGui:FindFirstChild("Paint") then
	refreshPaintTool()

	_G.PaintConnection = mouse.Button1Down:Connect(function()
		if _G.StopPaint then return end

		local target = mouse.Target
		local paintUI = LocalPlayer.PlayerGui:FindFirstChild("Paint")

		if target and paintUI and not paintUI.PickerUI.Visible then
			local currentTime = tick()

			if currentTime - lastClickTime < 0.5 then
				clickCount = clickCount + 1
			else
				clickCount = 1
			end

			lastClickTime = currentTime

			if clickCount >= AUTO_REFRESH_THRESHOLD then
				refreshPaintTool()
				clickCount = 0
			end

			local paintTool = hasPaintTool()

			if paintTool then
				local paintEvent = paintTool:FindFirstChild("Script") and paintTool.Script:FindFirstChild("Event")

				if paintEvent and paintUI and not _G.StopPaint then
					paintEvent:FireServer(
						target,
						mouse.TargetSurface,
						mouse.Hit.Position,
						paintUI.Button.Text,
						paintUI.Color.Value.BackgroundColor3,
						paintUI.Mater.Value.Text,
						paintUI.MaterUI.Spray.Input.Text
					)
				end
			end
		end
	end)

	_G.PaintStopMonitor = game:GetService("RunService").Heartbeat:Connect(function()
		if _G.StopPaint then
			if _G.PaintConnection then _G.PaintConnection:Disconnect() end
			if _G.PaintStopMonitor then _G.PaintStopMonitor:Disconnect() end
			if _G.PaintAncestryConn then _G.PaintAncestryConn:Disconnect() end
		end
	end)

	_G.PaintAncestryConn = script.AncestryChanged:Connect(function()
		if not script:IsDescendantOf(game) then
			if _G.PaintConnection then _G.PaintConnection:Disconnect() end
			if _G.PaintStopMonitor then _G.PaintStopMonitor:Disconnect() end
			if _G.PaintAncestryConn then _G.PaintAncestryConn:Disconnect() end
		end
	end)
end
		else
			_G.StopPaint = true
		end
	end
})

BT67:AddToggle({
	Name = "Shape Bypass",
	Info = "use shape tool without equiping it",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopShape = false

if _G.ShapeConnection then
	_G.ShapeConnection:Disconnect()
	_G.ShapeStopMonitor:Disconnect()
	_G.ShapeAncestryConn:Disconnect()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local lastClickTime = 0
local clickCount = 0
local AUTO_REFRESH_THRESHOLD = 5

local function hasShapeTool()
	return LocalPlayer.Backpack:FindFirstChild("Shape")
		or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Shape"))
end

local function refreshShapeTool()
	if _G.StopShape then return false end

	local shapeTool = hasShapeTool()
	if not shapeTool then
		return false
	end

	local shapeUI = LocalPlayer.PlayerGui:FindFirstChild("Shape")
	if not shapeUI then
		return false
	end

	local previousTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")

	if shapeTool.Parent == LocalPlayer.Character then
		shapeTool.Parent = LocalPlayer.Backpack
		task.wait()
	end

	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid:EquipTool(shapeTool)
		game:GetService("RunService").RenderStepped:Wait()

		if _G.StopShape then return false end

		shapeUI.Enabled = true

		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character.Humanoid:UnequipTools()
		end

		task.wait(0.05)

		if _G.StopShape then return false end

		shapeUI.Enabled = true

		if previousTool and previousTool.Parent == LocalPlayer.Backpack then
			if not _G.StopShape and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				LocalPlayer.Character.Humanoid:EquipTool(previousTool)
			end
		end

		return true
	end

	return false
end

if hasShapeTool() and LocalPlayer.PlayerGui:FindFirstChild("Shape") then
	refreshShapeTool()

	_G.ShapeConnection = mouse.Button1Down:Connect(function()
		if _G.StopShape then return end

		local target = mouse.Target
		local shapeUI = LocalPlayer.PlayerGui:FindFirstChild("Shape")

		if target and target.Name == "Brick" and shapeUI then
			local currentTime = tick()

			if currentTime - lastClickTime < 0.5 then
				clickCount = clickCount + 1
			else
				clickCount = 1
			end

			lastClickTime = currentTime

			if clickCount >= AUTO_REFRESH_THRESHOLD then
				refreshShapeTool()
				clickCount = 0
			end

			local shapeTool = hasShapeTool()

			if shapeTool then
				local shapeEvent = shapeTool:FindFirstChild("Script") and shapeTool.Script:FindFirstChild("Event")

				if shapeEvent and not _G.StopShape then
					shapeEvent:FireServer(
						target,
						mouse.TargetSurface,
						mouse.Hit.Position,
						shapeUI.Button.Text
					)
				end
			end
		end
	end)

	_G.ShapeStopMonitor = game:GetService("RunService").Heartbeat:Connect(function()
		if _G.StopShape then
			if _G.ShapeConnection then _G.ShapeConnection:Disconnect() end
			if _G.ShapeStopMonitor then _G.ShapeStopMonitor:Disconnect() end
			if _G.ShapeAncestryConn then _G.ShapeAncestryConn:Disconnect() end
		end
	end)

	_G.ShapeAncestryConn = script.AncestryChanged:Connect(function()
		if not script:IsDescendantOf(game) then
			if _G.ShapeConnection then _G.ShapeConnection:Disconnect() end
			if _G.ShapeStopMonitor then _G.ShapeStopMonitor:Disconnect() end
			if _G.ShapeAncestryConn then _G.ShapeAncestryConn:Disconnect() end
		end
	end)
end
		else
			_G.StopShape = true
		end
	end
})

BT67:AddToggle({
	Name = "Shovel Bypass",
	Info = "use shovel tool without equiping it",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopShovel = false

if _G.ShovelConnection then
	_G.ShovelConnection:Disconnect()
	_G.ShovelStopMonitor:Disconnect()
	_G.ShovelAncestryConn:Disconnect()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local lastClickTime = 0
local clickCount = 0
local AUTO_REFRESH_THRESHOLD = 5

local function hasShovelTool()
	return LocalPlayer.Backpack:FindFirstChild("Shovel")
		or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Shovel"))
end

local function refreshShovelTool()
	if _G.StopShovel then return false end

	local shovelTool = hasShovelTool()
	if not shovelTool then
		return false
	end

	local shovelUI = LocalPlayer.PlayerGui:FindFirstChild("Shovel")
	if not shovelUI then
		return false end

	local previousTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")

	if shovelTool.Parent == LocalPlayer.Character then
		shovelTool.Parent = LocalPlayer.Backpack
		task.wait()
	end

	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid:EquipTool(shovelTool)
		game:GetService("RunService").RenderStepped:Wait()

		if _G.StopShovel then return false end

		shovelUI.Enabled = true

		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character.Humanoid:UnequipTools()
		end

		task.wait(0.05)

		if _G.StopShovel then return false end

		shovelUI.Enabled = true

		if previousTool and previousTool.Parent == LocalPlayer.Backpack then
			if not _G.StopShovel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				LocalPlayer.Character.Humanoid:EquipTool(previousTool)
			end
		end

		return true
	end

	return false
end

if hasShovelTool() and LocalPlayer.PlayerGui:FindFirstChild("Shovel") then
	refreshShovelTool()

	_G.ShovelConnection = mouse.Button1Down:Connect(function()
		if _G.StopShovel then return end

		local target = mouse.Target
		local shovelUI = LocalPlayer.PlayerGui:FindFirstChild("Shovel")

		if target and shovelUI then
			local currentTime = tick()

			if currentTime - lastClickTime < 0.5 then
				clickCount = clickCount + 1
			else
				clickCount = 1
			end

			lastClickTime = currentTime

			if clickCount >= AUTO_REFRESH_THRESHOLD then
				refreshShovelTool()
				clickCount = 0
			end

			local shovelTool = hasShovelTool()

			if shovelTool then
				local shovelEvent = shovelTool:FindFirstChild("Script") and shovelTool.Script:FindFirstChild("Event")

				if shovelEvent and shovelUI and not _G.StopShovel then
					shovelEvent:FireServer(
						target,
						mouse.TargetSurface,
						mouse.Hit.Position,
						shovelUI.Button.Text
					)
				end
			end
		end
	end)

	_G.ShovelStopMonitor = game:GetService("RunService").Heartbeat:Connect(function()
		if _G.StopShovel then
			if _G.ShovelConnection then _G.ShovelConnection:Disconnect() end
			if _G.ShovelStopMonitor then _G.ShovelStopMonitor:Disconnect() end
			if _G.ShovelAncestryConn then _G.ShovelAncestryConn:Disconnect() end
		end
	end)

	_G.ShovelAncestryConn = script.AncestryChanged:Connect(function()
		if not script:IsDescendantOf(game) then
			if _G.ShovelConnection then _G.ShovelConnection:Disconnect() end
			if _G.ShovelStopMonitor then _G.ShovelStopMonitor:Disconnect() end
			if _G.ShovelAncestryConn then _G.ShovelAncestryConn:Disconnect() end
		end
	end)
end
		else
			_G.StopShovel = true
		end
	end
})



Anti67:AddToggle({
	Name = "Anti Maptide Nan",
	Info = "Anti Maptide nan",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiMaptideNan = false

			local Players = game:GetService("Players")
			local LocalPlayer = Players.LocalPlayer
			local nanConnection = nil

			local function isNaN(n)
				return n ~= n
			end

			local function isSafe(cf)
				local p = cf.Position
				return not (isNaN(p.X) or isNaN(p.Y) or isNaN(p.Z) or
					math.abs(p.X) == math.huge or
					math.abs(p.Y) == math.huge or
					math.abs(p.Z) == math.huge or
					math.abs(p.Y) > 500000)
			end

			local function isVoided()
				local spawn = workspace:FindFirstChild("Spawn")
				if not spawn then return false end
				local acm = spawn.AssemblyCenterOfMass
				return acm.X == 0 and acm.Y == -1000000 and acm.Z == 0
			end

			local function onCharacterAdded(character)
				if _G.StopAntiMaptideNan then return end
				local hrp = character:WaitForChild("HumanoidRootPart")
				if not isVoided() then return end
				hrp.Anchored = true
				task.wait(0.1)
				hrp.CFrame = CFrame.new(0, 3, 0)
				hrp.Anchored = false
			end

			local function enable()
				nanConnection = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
				if LocalPlayer.Character then
					onCharacterAdded(LocalPlayer.Character)
				end
			end

			local function disable()
				if nanConnection then
					nanConnection:Disconnect()
					nanConnection = nil
				end
			end

			enable()

			_G.AntiMaptideNanMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiMaptideNan then
					disable()
					if _G.AntiMaptideNanMonitor then _G.AntiMaptideNanMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiMaptideNan = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Jail",
	Info = "Anti Jail",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiJail = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local jailConnection = nil

			local function enable()
				jailConnection = RunService.Heartbeat:Connect(function()
					if _G.StopAntiJail then return end
					local char = workspace:FindFirstChild(LocalPlayer.Name)
					if not char then return end

					local jail = char:FindFirstChild("Jail")
					if not jail then return end

					for _, part in pairs(jail:GetChildren()) do
						if part:IsA("BasePart") and part.Name == "Part" then
							part.CanCollide = false
							part.Transparency = 1
						end
					end
				end)
			end

			local function disable()
				if jailConnection then
					jailConnection:Disconnect()
					jailConnection = nil
				end
			end

			enable()

			_G.AntiJailMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiJail then
					disable()
					if _G.AntiJailMonitor then _G.AntiJailMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiJail = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti KnockBack",
	Info = "Anti KnockBack",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiKnockBack = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local kbConnection = nil

			local function enable()
				kbConnection = RunService.Heartbeat:Connect(function()
					if _G.StopAntiKnockBack then return end
					local character = LocalPlayer.Character
					if not character then return end
					local hrp = character:FindFirstChild("HumanoidRootPart")
					if not hrp then return end
					hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
					hrp.AssemblyAngularVelocity = Vector3.zero
				end)
			end

			local function disable()
				if kbConnection then
					kbConnection:Disconnect()
					kbConnection = nil
				end
			end

			enable()

			_G.AntiKnockBackMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiKnockBack then
					disable()
					if _G.AntiKnockBackMonitor then _G.AntiKnockBackMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiKnockBack = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Ragdoll",
	Info = "Anti RagDoll",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiRagdoll = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local ragdollConnection = nil

			local function disableRagdoll()
				if _G.StopAntiRagdoll then return end
				local character = LocalPlayer.Character
				if not character then return end
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
					humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
				end
			end

			local function enable()
				disableRagdoll()
				
				ragdollConnection = RunService.Heartbeat:Connect(function()
					if _G.StopAntiRagdoll then return end
					local chr = LocalPlayer.Character
					if not chr then return end
					local hum = chr:FindFirstChildOfClass("Humanoid")
					if not hum then return end

					for _, part in pairs(chr:GetDescendants()) do
						if part:IsA("BallSocketConstraint") or part:IsA("HingeConstraint") then
							if part:FindFirstAncestorOfClass("Motor6D") == nil then
								part.Enabled = false
							end
						end
					end

					if hum:GetState() == Enum.HumanoidStateType.Ragdoll or
						hum:GetState() == Enum.HumanoidStateType.FallingDown then
						hum:ChangeState(Enum.HumanoidStateType.GettingUp)
					end
				end)
			end

			local function disable()
				if ragdollConnection then
					ragdollConnection:Disconnect()
					ragdollConnection = nil
				end
				
				local character = LocalPlayer.Character
				if not character then return end
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
					humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
				end
			end

			enable()

			_G.AntiRagdollMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiRagdoll then
					disable()
					if _G.AntiRagdollMonitor then _G.AntiRagdollMonitor:Disconnect() end
				end
			end)

			LocalPlayer.CharacterAdded:Connect(function()
				if not _G.StopAntiRagdoll then
					disableRagdoll()
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiRagdoll = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Teleport",
	Info = "Anti Teleport",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiTeleport = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local tpConnection = nil
			local lastPosition = nil

			local function enable()
				lastPosition = nil
				
				tpConnection = RunService.Heartbeat:Connect(function()
					if _G.StopAntiTeleport then return end
					local character = LocalPlayer.Character
					if not character then return end
					local root = character:FindFirstChild("HumanoidRootPart")
					if not root then return end
					if lastPosition then
						local distance = (root.Position - lastPosition).Magnitude
						if distance > 15 then
							root.CFrame = CFrame.new(lastPosition)
						end
					end
					lastPosition = root.Position
				end)
			end

			local function disable()
				if tpConnection then
					tpConnection:Disconnect()
					tpConnection = nil
				end
				lastPosition = nil
			end

			enable()

			_G.AntiTeleportMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiTeleport then
					disable()
					if _G.AntiTeleportMonitor then _G.AntiTeleportMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiTeleport = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Vampire",
	Info = "Anti Vampire",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiVampire = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local StarterGui = game:GetService("StarterGui")
			local vampireConnection = nil

			local function enable()
				vampireConnection = RunService.Heartbeat:Connect(function()
					if _G.StopAntiVampire then return end
					if LocalPlayer.Character then
						local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
						if humanoid and humanoid.Health > 0 then
							pcall(function()
								StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
							end)
							workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
							workspace.CurrentCamera.CameraSubject = humanoid
						end
					end
				end)
			end

			local function disable()
				if vampireConnection then
					vampireConnection:Disconnect()
					vampireConnection = nil
				end
			end

			enable()

			_G.AntiVampireMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiVampire then
					disable()
					if _G.AntiVampireMonitor then _G.AntiVampireMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiVampire = true
		end
	end
})

Anti67:AddToggle({
	Name = "Prevent Enlighten Drop",
	Info = "Prevent enlighten Drop",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiEnlighten = false

			local Players = game:GetService("Players")
			local LocalPlayer = Players.LocalPlayer
			local ENLIGHTEN_NAMES = {"arkenstone", "enlighten", "ark"}
			local enliConnections = {}

			local function isEnlighten(tool)
				if not tool:IsA("Tool") then return false end
				for _, name in ipairs(ENLIGHTEN_NAMES) do
					if tool.Name:lower():find(name:lower()) then
						return true
					end
				end
				return false
			end

			local function monitorEnlighten(tool)
				if not isEnlighten(tool) then return end

				local conn = tool.AncestryChanged:Connect(function()
					if _G.StopAntiEnlighten then return end
					if tool.Parent == workspace then
						task.wait(0.05)

						local char = LocalPlayer.Character
						local hum = char and char:FindFirstChildWhichIsA("Humanoid")

						if hum and hum.Health > 0 then
							pcall(function()
								hum:EquipTool(tool)
							end)
						end
					end
				end)

				table.insert(enliConnections, conn)
			end

			local function setupEnliCharacter(char)
				for _, tool in ipairs(char:GetChildren()) do
					monitorEnlighten(tool)
				end

				for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
					monitorEnlighten(tool)
				end

				local charConn = char.ChildAdded:Connect(function(child)
					if not _G.StopAntiEnlighten then
						monitorEnlighten(child)
					end
				end)
				table.insert(enliConnections, charConn)

				local backpackConn = LocalPlayer.Backpack.ChildAdded:Connect(function(child)
					if not _G.StopAntiEnlighten then
						monitorEnlighten(child)
					end
				end)
				table.insert(enliConnections, backpackConn)
			end

			local function enable()
				if LocalPlayer.Character then
					setupEnliCharacter(LocalPlayer.Character)
				end

				local charConn = LocalPlayer.CharacterAdded:Connect(function(char)
					if not _G.StopAntiEnlighten then
						setupEnliCharacter(char)
					end
				end)
				table.insert(enliConnections, charConn)
			end

			local function disable()
				for _, conn in ipairs(enliConnections) do
					conn:Disconnect()
				end
				enliConnections = {}
			end

			enable()

			_G.AntiEnlightenMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiEnlighten then
					disable()
					if _G.AntiEnlightenMonitor then _G.AntiEnlightenMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiEnlighten = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti AFK",
	Info = "Anti AFK",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiAFK = false

			local Players = game:GetService("Players")
			local LocalPlayer = Players.LocalPlayer
			local afkTask = nil

			local function enable()
				afkTask = task.spawn(function()
					while not _G.StopAntiAFK do
						local virtualUser = game:GetService("VirtualUser")
						virtualUser:CaptureController()
						virtualUser:ClickButton2(Vector2.new())
						task.wait(60)
					end
				end)
			end

			enable()

			_G.AntiAFKMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiAFK then
					if afkTask then
						task.cancel(afkTask)
						afkTask = nil
					end
					if _G.AntiAFKMonitor then _G.AntiAFKMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					if afkTask then
						task.cancel(afkTask)
						afkTask = nil
					end
				end
			end)
		else
			_G.StopAntiAFK = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Fling",
	Info = "Anti Fling",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiFling = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local antiFlingConnection = nil

			local function enable()
				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character then
						for _, part in pairs(player.Character:GetDescendants()) do
							if part:IsA("BasePart") then
								part.CanCollide = false
							end
						end
					end
				end

				if antiFlingConnection then
					antiFlingConnection:Disconnect()
				end
				antiFlingConnection = RunService.Stepped:Connect(function()
					if _G.StopAntiFling then return end
					for _, player in pairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character then
							for _, part in pairs(player.Character:GetDescendants()) do
								if part:IsA("BasePart") then
									part.CanCollide = false
								end
							end
						end
					end
				end)
			end

			local function disable()
				if antiFlingConnection then
					antiFlingConnection:Disconnect()
					antiFlingConnection = nil
				end

				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character then
						for _, part in pairs(player.Character:GetDescendants()) do
							if part:IsA("BasePart") then
								part.CanCollide = true
							end
						end
					end
				end
			end

			enable()

			_G.AntiFlingMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiFling then
					disable()
					if _G.AntiFlingMonitor then _G.AntiFlingMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiFling = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Freeze",
	Info = "Protects u from freeze!",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiFreeze = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local player = Players.LocalPlayer

			local function monitorCharacter(character)
				if _G.StopAntiFreeze then return end
				local humanoid = character:WaitForChild("Humanoid")
				local root = character:WaitForChild("HumanoidRootPart")

				RunService.RenderStepped:Connect(function()
					if _G.StopAntiFreeze then return end
					if not character or not character.Parent then return end
					
					local isFrozen = false
					
					if humanoid.WalkSpeed <= 0 then
						isFrozen = true
					end
					
					if humanoid.JumpPower <= 0 then
						isFrozen = true
					end
					
					if root.Anchored then
						isFrozen = true
					end
					
					if character:FindFirstChild("Freeze") or character:FindFirstChild("Ice") then
						isFrozen = true
					end
					
					if isFrozen then
						humanoid.Health = 0
					end
				end)
			end

			if player.Character then
				monitorCharacter(player.Character)
			end

			player.CharacterAdded:Connect(function(character)
				if not _G.StopAntiFreeze then
					monitorCharacter(character)
				end
			end)
		else
			_G.StopAntiFreeze = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Void Fall",
	Info = "Protects u from falling",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiVoidFall = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local player = Players.LocalPlayer
			local FALL_LIMIT = -50

			local function getSpawnLocation()
				for _, obj in pairs(workspace:GetDescendants()) do
					if obj:IsA("SpawnLocation") then
						return obj
					end
				end
				return nil
			end

			local function monitorCharacter(character)
				if _G.StopAntiVoidFall then return end
				local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

				RunService.RenderStepped:Connect(function()
					if _G.StopAntiVoidFall then return end
					if humanoidRootPart.Position.Y < FALL_LIMIT then
						local spawn = getSpawnLocation()
						if spawn then
							humanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
						end
					end
				end)
			end

			if player.Character then
				monitorCharacter(player.Character)
			end

			player.CharacterAdded:Connect(function(character)
				if not _G.StopAntiVoidFall then
					monitorCharacter(character)
				end
			end)
		else
			_G.StopAntiVoidFall = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Visuals",
	Info = "Anti Visuals",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiVisuals = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local LocalPlayer = Players.LocalPlayer
			local Lighting = game:GetService("Lighting")
			local visualConnection = nil

			local function enable()
				visualConnection = RunService.Heartbeat:Connect(function()
					if _G.StopAntiVisuals then return end
					local blur = Lighting:FindFirstChild("Blur")
					if blur then blur.Enabled = false end

					local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
					if playerGui then
						local blind = playerGui:FindFirstChild("Blind")
						if blind then
							local frame = blind:FindFirstChildOfClass("Frame")
							if frame then
								frame.BackgroundTransparency = 1
							end
						end
					end

					local fog = Lighting:FindFirstChild("Fog")
					if fog then fog.Density = 0 end

					local rgb = Lighting:FindFirstChild("RGB")
					if rgb then rgb.Enabled = false end
				end)
			end

			local function disable()
				if visualConnection then
					visualConnection:Disconnect()
					visualConnection = nil
				end
			end

			enable()

			_G.AntiVisualsMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiVisuals then
					disable()
					if _G.AntiVisualsMonitor then _G.AntiVisualsMonitor:Disconnect() end
				end
			end)

			LocalPlayer.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				if not LocalPlayer.Parent then
					disable()
				end
			end)
		else
			_G.StopAntiVisuals = true
		end
	end
})

Anti67:AddToggle({
	Name = "Anti Glitch",
	Info = "Make u Unglitched Automatic",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAntiGlitch = false

			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local player = Players.LocalPlayer
			local character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:WaitForChild("HumanoidRootPart")

			local targetPosition = Vector3.new(1234567, 1234567, 1234567)
			local tolerance = 100

			local function teleportToSpawn()
				if _G.StopAntiGlitch then return end
				local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
				if spawn then
					hrp.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
				else
					hrp.CFrame = CFrame.new(0, 5, 0)
				end
			end

			_G.AntiGlitchConnection = RunService.RenderStepped:Connect(function()
				if _G.StopAntiGlitch then return end
				local pos = hrp.Position
				if (pos - targetPosition).Magnitude <= tolerance then
					teleportToSpawn()
				end
			end)

			_G.AntiGlitchMonitor = game:GetService("RunService").Heartbeat:Connect(function()
				if _G.StopAntiGlitch then
					if _G.AntiGlitchConnection then _G.AntiGlitchConnection:Disconnect() end
					if _G.AntiGlitchMonitor then _G.AntiGlitchMonitor:Disconnect() end
				end
			end)
		else
			_G.StopAntiGlitch = true
		end
	end
})

Anti67:AddButton({
	Name = "Anti mute interface",
	Info = "Opens the anti mute interface",
	Callback = function()
		local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "anti mute todo feo"
gui.ResetOnSpawn = false
gui.Parent = safeWait(player, "PlayerGui", 15)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 180)
frame.Position = UDim2.new(0.5, -210, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0,0,0)
stroke.Transparency = 0.4
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,28)
title.BackgroundTransparency = 1
title.Text = "Antimute Gui"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Code
title.TextSize = 16
title.Parent = frame

local textbox = Instance.new("TextBox")
textbox.Size = UDim2.new(1,-20,0,45)
textbox.Position = UDim2.new(0,10,0,45)
textbox.BackgroundColor3 = Color3.fromRGB(30,30,30)
textbox.TextColor3 = Color3.new(1,1,1)
textbox.PlaceholderText = "insert text"
textbox.Text = ""
textbox.ClearTextOnFocus = false
textbox.Font = Enum.Font.Code
textbox.TextSize = 14
textbox.BorderSizePixel = 0
textbox.Parent = frame

local textboxCorner = Instance.new("UICorner")
textboxCorner.CornerRadius = UDim.new(0,6)
textboxCorner.Parent = textbox

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-20,0,45)
button.Position = UDim2.new(0,10,0,105)
button.BackgroundColor3 = Color3.fromRGB(25,25,25)
button.TextColor3 = Color3.new(1,1,1)
button.Text = "Send"
button.Font = Enum.Font.Code
button.TextSize = 14
button.BorderSizePixel = 0
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0,6)
buttonCorner.Parent = button

button.MouseButton1Click:Connect(function()
	local msg = textbox.Text

	if msg ~= "" then
		game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(";fuc "..msg)
	end
end)

local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
	end
})

Nostalgia67:AddButton({
	Name = "Old time",
	Info = "This gives u the old timer of tco",
	Callback = function()
		local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function applyChanges()
local characterFolder = workspace:WaitForChild(player.Name)
local tiempo = characterFolder:WaitForChild("Tiempo")
local text2 = tiempo:WaitForChild("Text2")

local text1 = tiempo:FindFirstChild("Text1")
if text1 then
	text1:Destroy()
end

local nombre = characterFolder:FindFirstChild("Nombre")
if nombre then
	nombre:Destroy()
end

text2.Font = Enum.Font.PatrickHand

text2.TextStrokeTransparency = 0
text2.TextStrokeColor3 = Color3.new(0, 0, 0)

if player.Team then
	if player.Team.Name == "Chosen" then
		text2.TextColor3 = Color3.fromRGB(255, 221, 0)
	elseif player.Team.Name == "Neutral" then
		text2.TextColor3 = Color3.fromRGB(200, 200, 200)
	end
end

tiempo.Size = UDim2.new(2, 0, 2, 0)

end

applyChanges()
	end
})

Nostalgia67:AddButton({
	Name = "Old paint interface",
	Info = "This mades ur paint tool have the old interface of tco",
	Callback = function()
		local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local selectedColor = Color3.new(1,1,1)
local gui
local antiPaintConnection

local buttonSize = 18
local padding = 3
local baseX = 8
local baseY = -238

local function enableAntiPaint()
	local playerGui = safeWait(player, "PlayerGui", 15)
	local old = playerGui:FindFirstChild("Paint")
	if old then
		old:Destroy()
	end

	if not antiPaintConnection then
		antiPaintConnection = playerGui.ChildAdded:Connect(function(child)
			if child.Name == "Paint" then
				child:Destroy()
			end
		end)
	end
end

local function createGUI()
	if gui then return end

	enableAntiPaint()

	gui = Instance.new("ScreenGui")
	gui.Name = "MiniPalette230"
	gui.ResetOnSpawn = false
	gui.Enabled = false
	gui.Parent = safeWait(player, "PlayerGui", 15)

	local topFrame = Instance.new("Frame")
	topFrame.Size = UDim2.new(0,230,0,buttonSize)
	topFrame.Position = UDim2.new(0,baseX,1,baseY)
	topFrame.BackgroundTransparency = 1
	topFrame.Parent = gui

	local topColors = {
		Color3.fromRGB(255,0,0),
		Color3.fromRGB(188,122,55),
		Color3.fromRGB(255,204,0),
		Color3.fromRGB(75,151,75),
		Color3.fromRGB(0,143,255),
		Color3.fromRGB(0,85,175),
		Color3.fromRGB(170,140,90),
		Color3.fromRGB(120,85,60)
	}

	local function createButton(parent,color,x,y)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0,buttonSize,0,buttonSize)
		b.Position = UDim2.new(0,x,0,y)
		b.BackgroundColor3 = color
		b.Text = ""
		b.BorderSizePixel = 2
		b.BorderColor3 = Color3.new(0,0,0)
		b.AutoButtonColor = false
		b.Parent = parent

		b.MouseButton1Click:Connect(function()
			selectedColor = color
		end)
	end

	for i,color in ipairs(topColors) do
		createButton(topFrame,color,(i-1)*(buttonSize+padding),0)
	end

	local gridBackground = Instance.new("Frame")
	gridBackground.Size = UDim2.new(0,200,0,180)
	gridBackground.Position = UDim2.new(0,baseX,1,baseY + 25)
	gridBackground.BackgroundColor3 = Color3.fromRGB(0,0,0)
	gridBackground.BackgroundTransparency = 0.3
	gridBackground.BorderSizePixel = 3
	gridBackground.BorderColor3 = Color3.new(0,0,0)
	gridBackground.Parent = gui

	for row = 0,7 do
		for col = 0,7 do
			if col ~= 3 then
				local hue = col/8
				local value = 1-(row*0.12)
				local color = Color3.fromHSV(hue,1,value)

				local adjustedCol = col
				if col > 3 then
					adjustedCol = col - 1
				end

				createButton(
					gridBackground,
					color,
					5 + adjustedCol*(buttonSize+padding),
					5 + row*(buttonSize+padding)
				)
			end
		end
	end

	local grayFrame = Instance.new("Frame")
	grayFrame.Size = UDim2.new(0,buttonSize,0,180)
	grayFrame.Position = UDim2.new(0,baseX + 205,1,baseY + 25)
	grayFrame.BackgroundTransparency = 1
	grayFrame.Parent = gui

	for i = 0,7 do
		local v = 1-(i*0.12)
		local gray = Color3.new(v,v,v)

		createButton(
			grayFrame,
			gray,
			0,
			i*(buttonSize+padding)
		)
	end
end

local function paint(hitPart, hitPosition, surface)
	local character = player.Character
	if not character then return end

	local tool = character:FindFirstChild("Paint")
	if not tool then return end

	local remote = tool:WaitForChild("Script"):WaitForChild("Event")

	local args = {
		hitPart,
		surface,
		Vector3.new(hitPosition.X, hitPosition.Y, hitPosition.Z),
		"both 🤝",
		selectedColor,
		"plastic",
		""
	}

	remote:FireServer(unpack(args))
end

local function setupTool(tool)
	if tool.Name ~= "Paint" then return end

	createGUI()

	tool.Equipped:Connect(function()
		gui.Enabled = true
	end)

	tool.Unequipped:Connect(function()
		gui.Enabled = false
	end)
end

local function onCharacter(character)
	enableAntiPaint()

	for _,v in pairs(character:GetChildren()) do
		if v:IsA("Tool") then
			setupTool(v)
		end
	end

	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then
			setupTool(child)
		end
	end)
end

if player.Character then
	onCharacter(player.Character)
end

player.CharacterAdded:Connect(onCharacter)

mouse.Button1Down:Connect(function()
	if not gui or not gui.Enabled then return end

	local target = mouse.Target
	if not target then return end

	local surface = mouse.TargetSurface or Enum.NormalId.Top
	local hitPos = mouse.Hit and mouse.Hit.Position
	if not hitPos then return end

	if target:IsA("Terrain") or target:IsDescendantOf(workspace) then
		paint(target, hitPos, surface)
	end
end)
	end
})

Nostalgia67:AddButton({
	Name = "Polish tool",
	Info = "The old way to paint blocks with material",
	Callback = function()
		local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local backpack = safeWait(player, "Backpack", 15)

local tool = Instance.new("Tool")
tool.Name = "Polish"
tool.RequiresHandle = true
tool.CanBeDropped = false
tool.Parent = backpack

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1,1,1)
handle.Shape = Enum.PartType.Ball
handle.Material = Enum.Material.Metal
handle.Color = Color3.fromRGB(255, 204, 0)
handle.TopSurface = Enum.SurfaceType.Smooth
handle.BottomSurface = Enum.SurfaceType.Smooth
handle.Reflectance = 0.25
handle.Parent = tool

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MaterialGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = safeWait(player, "PlayerGui", 15)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 80)
frame.Position = UDim2.new(0.5, -150, 0.05, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 12)
uicorner.Parent = frame

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(1,0,1,0)
textButton.Position = UDim2.new(0,0,0,0)
textButton.BackgroundTransparency = 1
textButton.BorderSizePixel = 0
textButton.TextColor3 = Color3.fromRGB(255,255,255)
textButton.TextScaled = true
textButton.Font = Enum.Font.PatrickHand
textButton.Parent = frame

local sections = {
	"Neon",
	"Wood",
	"Smooth",
	"Plastic",
	"Brick",
	"Toxic",
	"Ghost",
	"Concrete",
	"Metal"
}

local currentIndex = 1
textButton.Text = sections[currentIndex]

textButton.MouseButton1Click:Connect(function()
	currentIndex += 1
	if currentIndex > #sections then
		currentIndex = 1
	end
	textButton.Text = sections[currentIndex]
end)

frame.Visible = false

tool.Equipped:Connect(function()
	frame.Visible = true
end)

tool.Unequipped:Connect(function()
	frame.Visible = false
end)

local function paintBrick(brick, hitPos)
	if not brick then return end

	local section = string.lower(sections[currentIndex])
	local color = brick.Color

	local args = {
		brick,
		Enum.NormalId.Top,
		Vector3.new(hitPos.X, hitPos.Y, hitPos.Z),
		"both",
		color,
		section,
		""
	}

	local paintEvent = safeWait(player, "Backpack", 15)
		:WaitForChild("Paint")
		:WaitForChild("Script")
		:WaitForChild("Event")

	paintEvent:FireServer(unpack(args))
end

mouse.Button1Down:Connect(function()
	if player.Character and player.Character:FindFirstChildOfClass("Tool") == tool then
		local target = mouse.Target
		if target and target:IsDescendantOf(workspace:WaitForChild("Bricks")) then
			local hitPos = mouse.Hit.Position
			paintBrick(target, hitPos)
		end
	end
end)
	end
})

Nostalgia67:AddButton({
	Name = "Old build and delete texture",
	Info = "Old build and Delete texture of the og tco",
	Callback = function()
		local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer


local function setPlastic(tool)
    if tool and tool:FindFirstChild("Handle") then
        if tool.Handle.Material ~= Enum.Material.Plastic then
            tool.Handle.Material = Enum.Material.Plastic
        end
    end
end


local function checkTools()
    local character = localPlayer.Character
    if character then
        setPlastic(character:FindFirstChild("Build"))
        setPlastic(character:FindFirstChild("Delete"))
    end
end


while true do
    checkTools()
    task.wait(0.5)
end
	end
})

ES67:AddButton({
	Name = "Enlighten Stash",
	Info = "Stash ur enlighten",
	Callback = function()
		local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local player = Players.LocalPlayer
local backpack = safeWait(player, "Backpack", 15)

local function sendMessage(msg)
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
	else
		ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
		:WaitForChild("SayMessageRequest"):FireServer(msg,"All")
	end
end

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local basePosition = Vector3.new(1470.9,38.8,526.7)

local base = Instance.new("Part")
base.Size = Vector3.new(100,1,100)
base.Anchored = true
base.Name = "Baseplate"
base.Position = basePosition
base.Transparency = 0.5
base.Color = Color3.fromRGB(60,60,60)
base.Parent = workspace

local function teleportRandomOnBase()
	local char = getCharacter()
	local hrp = char:WaitForChild("HumanoidRootPart")

	local halfX = base.Size.X / 2
	local halfZ = base.Size.Z / 2

	local randomX = math.random(-halfX + 5, halfX - 5)
	local randomZ = math.random(-halfZ + 5, halfZ - 5)

	local pos = base.Position + Vector3.new(randomX, 5, randomZ)

	hrp.CFrame = CFrame.new(pos)
end

teleportRandomOnBase()

task.wait(0.5)

local function waitForTools()

	local blue
	local arken

	repeat
		for _,v in pairs(backpack:GetChildren()) do
			if v:IsA("Tool") then

				if v.Name == "BlueBucket" then
					blue = v
				end

				if v.Name == "The Arkenstone" then
					arken = v
				end

			end
		end
		task.wait()
	until arken

	return blue, arken

end

local blueBucket, arkenstone = waitForTools()

local keepEquipped = true

task.spawn(function()
	while keepEquipped do
		local c = getCharacter()
		if arkenstone and arkenstone.Parent ~= c then
			arkenstone.Parent = c
		end
		task.wait()
	end
end)

local char = getCharacter()

arkenstone.Parent = char

task.wait(0.5)

sendMessage(";gear me 25162389")

local humanoid = char:WaitForChild("Humanoid")

repeat
	task.wait()
until char:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")

task.wait(1)

humanoid:UnequipTools()

for _,v in pairs(char:GetChildren()) do
	if v:IsA("Tool") then
		v.Parent = backpack
	end
end

if blueBucket then
	blueBucket.Parent = char
end

task.wait(0.5)

sendMessage(";freeze me")
task.wait(0.4)

sendMessage(";clone me")
task.wait(0.4)

sendMessage(";r15")

task.wait(1)

keepEquipped = false
	end
})

ES67:AddButton({
	Name = "TP to area",
	Info = "TP to the stash area",
	Callback = function()
		local Players = game:GetService("Players")

local player = Players.LocalPlayer

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function tpToBase()
	local base = workspace:FindFirstChild("Baseplate")
	if not base then return end
	
	local char = getCharacter()
	local hrp = char:WaitForChild("HumanoidRootPart")
	
	hrp.CFrame = CFrame.new(base.Position + Vector3.new(0,5,0))
end

tpToBase()
	end
})

UA67:AddButton({
	Name = "Make a Nextbot interface",
	Info = "Make a nextbot using unanchored blocks",
	Callback = function()
		local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local jumpHeight = 70
local heightLimit = 8
local rayDistance = 15

local jumpPower = math.sqrt(2 * workspace.Gravity * jumpHeight)
local defaultJumpPower = jumpPower

local selected = {}
local outlines = {}
local connection
local selecting = false

local gui = Instance.new("ScreenGui")
gui.Name = "NextbotMaker"
gui.ResetOnSpawn = false
gui.Parent = safeWait(player, "PlayerGui", 15)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,420,0,180)
frame.Position = UDim2.new(0.5,-210,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0,0,0)
stroke.Transparency = 0.4
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,28)
title.BackgroundTransparency = 1
title.Text = "Nextbot Maker"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Code
title.TextSize = 16
title.Parent = frame

local function makeButton(text,x,y,w,h)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,w,0,h)
	b.Position = UDim2.new(0,x,0,y)
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = text
	b.Font = Enum.Font.Code
	b.TextSize = 14
	b.BorderSizePixel = 0
	b.Parent = frame

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,6)
	c.Parent = b

	return b
end

local selectBtn = makeButton("Select",10,45,127,45)
local confirmBtn = makeButton("Confirm",146,45,127,45)
local cancelBtn = makeButton("Cancel",282,45,128,45)

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0,195,0,45)
speedBox.Position = UDim2.new(0,10,0,105)
speedBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.PlaceholderText = "Speed"
speedBox.Text = "30"
speedBox.ClearTextOnFocus = false
speedBox.Font = Enum.Font.Code
speedBox.TextSize = 14
speedBox.BorderSizePixel = 0
speedBox.Parent = frame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0,6)
speedCorner.Parent = speedBox

local jumpPowerBox = Instance.new("TextBox")
jumpPowerBox.Size = UDim2.new(0,195,0,45)
jumpPowerBox.Position = UDim2.new(0,215,0,105)
jumpPowerBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
jumpPowerBox.TextColor3 = Color3.new(1,1,1)
jumpPowerBox.PlaceholderText = "Jump Power"
jumpPowerBox.Text = tostring(math.floor(defaultJumpPower))
jumpPowerBox.ClearTextOnFocus = false
jumpPowerBox.Font = Enum.Font.Code
jumpPowerBox.TextSize = 14
jumpPowerBox.BorderSizePixel = 0
jumpPowerBox.Parent = frame

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0,6)
jumpCorner.Parent = jumpPowerBox

local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		if dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local mouse = player:GetMouse()

local function addOutline(part)
	local box = Instance.new("SelectionBox")
	box.Adornee = part
	box.Color3 = Color3.fromRGB(255,140,0)
	box.LineThickness = 0.08
	box.Parent = workspace
	outlines[part] = box
end

local function clearSelection()
	for _,v in pairs(outlines) do
		v:Destroy()
	end

	table.clear(outlines)
	table.clear(selected)
end

local function errorNotify()
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "ERROR",
			Text = "Only Unanchored Blocks",
			Duration = 2
		})
	end)
end

selectBtn.MouseButton1Click:Connect(function()
	selecting = true
end)

mouse.Button1Down:Connect(function()
	if not selecting then
		return
	end

	local target = mouse.Target

	if target
	and target:IsA("BasePart")
	and target.Name == "Brick" then

		if target.Anchored then
			errorNotify()
			return
		end

		if not selected[target] then
			selected[target] = true
			addOutline(target)
		end
	end
end)

local function findBestDirection(part,targetDir,rayDistance,params)
	local right = Vector3.new(-targetDir.Z,0,targetDir.X)
	local left = -right

	local rayDirections = {
		{dir = targetDir,weight = 1.0},
		{dir = (targetDir + right).Unit,weight = 0.9},
		{dir = (targetDir - right).Unit,weight = 0.9},
		{dir = right,weight = 0.7},
		{dir = left,weight = 0.7},
		{dir = (targetDir * 0.3 + right).Unit,weight = 0.85},
		{dir = (targetDir * 0.3 + left).Unit,weight = 0.85}
	}

	local bestDir = targetDir
	local bestWeight = -1
	local hitObstacle = false

	for _,rayData in ipairs(rayDirections) do
		local hit = workspace:Raycast(
			part.Position,
			rayData.dir * rayDistance,
			params
		)

		if not hit then
			if rayData.weight > bestWeight then
				bestWeight = rayData.weight
				bestDir = rayData.dir
			end
		else
			hitObstacle = true
		end
	end

	if hitObstacle and bestWeight < 0.5 then
		bestDir = -targetDir
	end

	return bestDir,hitObstacle
end

local function startMovement()
	if connection then
		connection:Disconnect()
		connection = nil
	end

	local controlled = {}

	for part in pairs(selected) do
		if part:IsA("BasePart") then
			part.Anchored = false

			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(math.huge,0,math.huge)
			bv.Parent = part

			controlled[part] = {
				BV = bv,
				LastPos = part.Position,
				Stuck = 0,
				Side = 1,
				ObstacleCounter = 0,
				LastKnownGoodDir = Vector3.new(0,0,1)
			}
		end
	end

	for _,v in pairs(outlines) do
		v:Destroy()
	end

	table.clear(outlines)

	connection = RunService.Heartbeat:Connect(function(dt)
		for part,data in pairs(controlled) do
			if part.Parent then
				local target
				local closest = math.huge

				for _,plr in ipairs(Players:GetPlayers()) do
					local char = plr.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")

					if hrp then
						local distance = (hrp.Position - part.Position).Magnitude

						if distance < closest then
							closest = distance
							target = hrp
						end
					end
				end

				if target then
					local dir = Vector3.new(
						target.Position.X - part.Position.X,
						0,
						target.Position.Z - part.Position.Z
					)

					if dir.Magnitude > 0 then
						dir = dir.Unit
					end

					data.LastKnownGoodDir = dir

					local params = RaycastParams.new()
					params.FilterType = Enum.RaycastFilterType.Exclude
					params.FilterDescendantsInstances = {part}

					local newDir,hitObstacle =
						findBestDirection(
							part,
							dir,
							rayDistance,
							params
						)

					if hitObstacle then
						data.ObstacleCounter += dt
					else
						data.ObstacleCounter = 0
					end

					dir = newDir

					if (part.Position - data.LastPos).Magnitude < 0.2 then
						data.Stuck += dt
					else
						data.Stuck = 0
					end

					data.LastPos = part.Position

					if data.Stuck > 1 then
						data.Side *= -1

						dir = Vector3.new(
							-dir.Z * data.Side,
							0,
							dir.X * data.Side
						)

						if data.Stuck > 2.5 then
							dir = -data.LastKnownGoodDir
							data.Stuck = 0
						else
							data.Stuck = 0
						end
					end

					local currentSpeed = tonumber(speedBox.Text) or 30
					local velocity = dir * currentSpeed

					data.BV.Velocity = Vector3.new(
						velocity.X,
						0,
						velocity.Z
					)

					if target.Position.Y - part.Position.Y > heightLimit then
						local currentJumpPower =
							tonumber(jumpPowerBox.Text)
							or defaultJumpPower

						part.AssemblyLinearVelocity = Vector3.new(
							velocity.X,
							currentJumpPower,
							velocity.Z
						)
					end

					part.CFrame = CFrame.lookAt(
						part.Position,
						part.Position + Vector3.new(
							dir.X,
							0,
							dir.Z
						)
					)
				end
			end
		end
	end)
end

confirmBtn.MouseButton1Click:Connect(function()
	selecting = false
	startMovement()
end)

cancelBtn.MouseButton1Click:Connect(function()
	selecting = false

	if connection then
		connection:Disconnect()
		connection = nil
	end

	for part in pairs(selected) do
		for _,v in ipairs(part:GetChildren()) do
			if v:IsA("BodyVelocity") then
				v:Destroy()
			end
		end
	end

	clearSelection()
end)
	end
})

LP67:AddButton({
	Name = "Disable Delete Sound",
	Info = "Disables the delete sound effect",
	Callback = function()
		local localplr = game.Players.LocalPlayer
		local dtool = localplr.Character:FindFirstChild("Delete") or localplr.Backpack:FindFirstChild("Delete")
		if dtool and dtool:FindFirstChild("Script") and dtool.Script:FindFirstChild("Event") then
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("Brick") then
					dtool.Script.Event:FireServer(v.Character.HumanoidRootPart.Brick, localplr.Character.HumanoidRootPart.Position)
				end
			end
		end
	end
})

LP67:AddButton({
	Name = "Fix B-Kit interfaces",
	Info = "This fixes every interface bugged of bkit",
	Callback = function()
		local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TOOLS = {"Build","Paint","Shape","Shovel"}

local heartbeatConn
local lastUpdateTime = 0
local updateInterval = 0.1
local fixCount = 0

local function trackFix()
	fixCount += 1
end

local function updateUI()
	local currentTime = tick()

	if currentTime - lastUpdateTime < updateInterval then
		return
	end

	lastUpdateTime = currentTime

	local character = LocalPlayer.Character or workspace:FindFirstChild(LocalPlayer.Name)
	if not character then
		return
	end

	local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
	if not playerGui then
		return
	end

	for _,toolName in ipairs(TOOLS) do
		local gui = playerGui:FindFirstChild(toolName)
		local equipped = character:FindFirstChild(toolName) ~= nil

		if gui and gui.Enabled ~= equipped then
			gui.Enabled = equipped
			trackFix()
		end
	end
end

local function cleanup()
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end

	local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
	if playerGui then
		for _,toolName in ipairs(TOOLS) do
			local gui = playerGui:FindFirstChild(toolName)
			if gui then
				gui.Enabled = false
			end
		end
	end
end

if LocalPlayer.Character then
	updateUI()
end

LocalPlayer.CharacterAdded:Connect(function()
	task.wait(0.5)
	updateUI()
end)

heartbeatConn = RunService.Heartbeat:Connect(updateUI)

LocalPlayer.AncestryChanged:Connect(function(_, parent)
	if not parent then
		cleanup()
	end
end)

task.spawn(function()
	while heartbeatConn do
		task.wait(30)
	end
end)
	end
})

CCOG:AddButton({
	Name = "Customize brick",
	Info = "Customize the brick of replicated storage",
	Callback = function()
		_G.StopCubeLock = false

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

StarterGui:SetCore("SendNotification", {
	Title = "How to customize?",
	Text = "When u need Stop customizing the brick, press Stop custom",
	Duration = 8
})

local targetPosition = Vector3.new(0, 1000, 1000)

local cube = ReplicatedStorage:WaitForChild("Cube")

cube.Parent = Workspace
cube.Anchored = true
cube.Position = targetPosition

local platform = Instance.new("Part")
platform.Name = "CubePlatform"
platform.Size = Vector3.new(30, 1, 30)
platform.Anchored = true
platform.CanCollide = true
platform.Position = targetPosition - Vector3.new(0, 4, 0)
platform.Parent = Workspace

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

hrp.CFrame = CFrame.new(platform.Position + Vector3.new(0, 5, 0))

task.spawn(function()
	while not _G.StopCubeLock do
		if cube.Parent ~= Workspace then
			cube.Parent = Workspace
		end

		if cube.Position ~= targetPosition then
			cube.Position = targetPosition
		end

		if not cube.Anchored then
			cube.Anchored = true
		end

		if platform.Parent ~= Workspace then
			platform.Parent = Workspace
		end

		local wantedPlatformPosition = targetPosition - Vector3.new(0, 4, 0)

		if platform.Position ~= wantedPlatformPosition then
			platform.Position = wantedPlatformPosition
		end

		task.wait()
	end
end)
	end
})

CCOG:AddButton({
	Name = "Stop brick customize",
	Info = "Stop customizing",
	Callback = function()
		_G.StopCubeLock = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local cube = Workspace:FindFirstChild("Cube")

if cube then
	cube.Parent = ReplicatedStorage
end

local platform = Workspace:FindFirstChild("CubePlatform")

if platform then
	platform:Destroy()
end

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

hrp.CFrame = CFrame.new(0, 20, 0)
	end
})

GriefingOG:AddToggle({
	Name = "Grief",
	Info = "Griefs in a radius of 200 studs",
	Default = false,
	Callback = function(value)
		if value then
			local Players = game:GetService("Players")
local localplr = Players.LocalPlayer

_G.StopGriefing = false

local MaxBloquesPorCiclo = 50
local on = true

local isog = workspace:FindFirstChild("Cubes")
local cfolder = isog or workspace:FindFirstChild("Bricks")

local function gcp(p)
	local c = localplr.Character
	p = p:lower() == "hrp" and "HumanoidRootPart" or p
	if c and c:FindFirstChild(p) then
		return c:FindFirstChild(p)
	end
	return nil
end

local function findbtools(name)
	local btools = {}
	if not isog and localplr:FindFirstChild("Backpack") then
		for _, v in ipairs(localplr.Backpack:GetChildren()) do
			if v:IsA("Tool") and v.Name == name and v:FindFirstChild("Script") and v.Script:FindFirstChild("Event") then
				table.insert(btools, {bt = v, e = v.Script.Event})
			end
		end
	end
	if localplr.Character then
		for _, v2 in ipairs(localplr.Character:GetChildren()) do
			if v2:IsA("Tool") and v2.Name == name then
				if isog then
					local bpEvents = localplr:FindFirstChild("Backpack") and localplr.Backpack:FindFirstChild("Events")
					if bpEvents then
						table.insert(btools, {bt = v2, e = bpEvents})
					end
				elseif v2:FindFirstChild("Script") and v2.Script:FindFirstChild("Event") then
					table.insert(btools, {bt = v2, e = v2.Script.Event})
				end
			end
		end
	end
	return btools
end

local function checktool(t)
	if t.Parent ~= localplr.Character then
		t.Parent = localplr.Character
	end
	if not isog and t.Parent ~= localplr.Backpack then
		t.Parent = localplr.Backpack
	end
end

local function getclosestcubes(pos)
	local cubes = {}
	if pos then
		for _, v in ipairs(cfolder:GetDescendants()) do
			if v:IsA("BasePart") then
				table.insert(cubes, {v, (v.Position - pos).Magnitude})
			end
		end
		table.sort(cubes, function(a, b)
			return a[2] < b[2]
		end)
	end
	return cubes
end

task.spawn(function()
	local dti = 0
	while on do
		if _G.StopGriefing then
			break
		end

		local hrp = gcp("hrp")
		if hrp then
			local dtools = findbtools("Delete")
			if #dtools > 0 then
				local gcc = getclosestcubes(hrp.Position)
				local cuenta = 0

				for _, v in ipairs(gcc) do
					if _G.StopGriefing then
						break
					end

					if cuenta >= MaxBloquesPorCiclo then
						break
					end

					local parte = v[1]
					if parte and parte:IsA("BasePart") and parte.Parent then
						dti = dti + 1
						local dt = dtools[(dti % #dtools) + 1]

						if isog then
							dt.e:FireServer(hrp.Position, Enum.NormalId.Top, parte, Color3.new(0, 0, 0), "Smooth")
						else
							checktool(dt.bt)
							dt.e:FireServer(parte, hrp.Position)
						end

						cuenta = cuenta + 1
					end
				end
			else
				task.wait(0.5)
			end
		end
		task.wait()
	end
end)
		else
			_G.StopGriefing = true
		end
	end
})

GriefingOG:AddToggle({
	Name = "Build Aura Spam",
	Info = "Spams the build tool in a aura",
	Default = false,
	Callback = function(value)
		if value then
			_G.StopAuraSpam = false

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local radius = 30

task.spawn(function()
	while not _G.StopAuraSpam do
		local character = player.Character
		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

			if hrp then
				for i = 1, 25 do
					if _G.StopAuraSpam then
						break
					end

					local angle = math.rad(math.random(0, 360))
					local distance = math.random() * radius

					local x = math.cos(angle) * distance
					local z = math.sin(angle) * distance

					local pos = hrp.Position + Vector3.new(x, 0, z)

					local args = {
						vector.create(pos.X, pos.Y, pos.Z),
						Enum.NormalId.Top,
						workspace:WaitForChild("Trrain"):WaitForChild("Chunk"):WaitForChild("Mesh"),
						Color3.new(1, 1, 1),
						"Smooth"
					}

					player.Backpack.Events:FireServer(unpack(args))
				end
			end
		end

		task.wait(0.05)
	end
end)
		else
			_G.StopAuraSpam = true
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Blind",
	Info = "Anti Blind UI",
	Default = false,
	Callback = function(value)
		_G.StopAntiBlind = not value
		if value then
			local Players = game:GetService("Players")
			local lp = Players.LocalPlayer

			local function removeBlindGUI()
				local gui = lp:WaitForChild("PlayerGui"):FindFirstChild("BlindGUI")
				if gui then
					gui:Destroy()
				end
			end

			removeBlindGUI()
			
			lp.PlayerGui.ChildAdded:Connect(function(child)
				if child.Name == "BlindGUI" and not _G.StopAntiBlind then
					task.wait()
					child:Destroy()
				end
			end)
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Bkit Breaker",
	Info = "Anti Bkit Breaker",
	Default = false,
	Callback = function(value)
		_G.StopAntiBkit = not value
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		
		if value then
			task.spawn(function()
				while not _G.StopAntiBkit do
					if not ReplicatedStorage:FindFirstChild("Cube") then
						local Cube = Instance.new("Part")
						Cube.Name = "Cube"
						Cube.Size = Vector3.new(3, 3, 3)
						Cube.Anchored = true
						Cube.Parent = ReplicatedStorage
					end
					task.wait()
				end
			end)
		else
			local Cube = ReplicatedStorage:FindFirstChild("Cube")
			if Cube then
				Cube:Destroy()
			end
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Freeze",
	Info = "Anti freeze",
	Default = false,
	Callback = function(value)
		_G.StopAntiFreeze = not value
		if value then
			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local player = Players.LocalPlayer

			local function monitorCharacter(character)
				local humanoid = character:WaitForChild("Humanoid")
				local root = character:WaitForChild("HumanoidRootPart")

				RunService.RenderStepped:Connect(function()
					if _G.StopAntiFreeze or not character or not character.Parent then return end
					
					local isFrozen = false
					
					if humanoid.WalkSpeed <= 0 then
						isFrozen = true
					end
					
					if humanoid.JumpPower <= 0 then
						isFrozen = true
					end
					
					if root.Anchored then
						isFrozen = true
					end
					
					if character:FindFirstChild("Freeze") or character:FindFirstChild("Ice") then
						isFrozen = true
					end
					
					if isFrozen then
						humanoid.Health = 0
					end
				end)
			end

			if player.Character then
				monitorCharacter(player.Character)
			end

			player.CharacterAdded:Connect(function(character)
				if not _G.StopAntiFreeze then
					monitorCharacter(character)
				end
			end)
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Blur",
	Info = "Anti blur",
	Default = false,
	Callback = function(value)
		_G.StopAntiBlur = not value
		if value then
			local Lighting = game:GetService("Lighting")

			local function removeBlur()
				local blur = Lighting:FindFirstChildOfClass("BlurEffect")
				if blur then
					blur:Destroy()
				end
			end

			removeBlur()
			
			Lighting.ChildAdded:Connect(function(child)
				if child:IsA("BlurEffect") and not _G.StopAntiBlur then
					child:Destroy()
				end
			end)
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Colorless",
	Info = "Anti Colorless",
	Default = false,
	Callback = function(value)
		_G.StopAntiColorless = not value
		if value then
			local Lighting = game:GetService("Lighting")

			local function fixColorCorrection()
				local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
				if cc then
					cc.Brightness = 0
					cc.Contrast = 0
					cc.Saturation = 0
					cc.TintColor = Color3.new(1, 1, 1)
				end
			end

			fixColorCorrection()
			
			Lighting.ChildAdded:Connect(function(child)
				if child:IsA("ColorCorrectionEffect") and not _G.StopAntiColorless then
					task.wait()
					fixColorCorrection()
				end
			end)
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Fog",
	Info = "Anti Fog",
	Default = false,
	Callback = function(value)
		_G.StopAntiFog = not value
		if value then
			local Lighting = game:GetService("Lighting")

			local function fixFog()
				local fog = Lighting:FindFirstChild("Fog")
				if fog and fog:IsA("NumberValue") then
					fog.Value = 0
				end
			end

			fixFog()
			
			Lighting.ChildAdded:Connect(function(child)
				if child.Name == "Fog" and not _G.StopAntiFog then
					task.wait()
					fixFog()
				end
			end)

			for _, v in pairs(Lighting:GetChildren()) do
				if v.Name == "Fog" then
					v:GetPropertyChangedSignal("Value"):Connect(function()
						if not _G.StopAntiFog then
							fixFog()
						end
					end)
				end
			end
		end
	end
})

AntisOG:AddToggle({
	Name = "Anti Toxify",
	Info = "Anti Toxify",
	Default = false,
	Callback = function(value)
		_G.StopAntiToxify = not value
		if value then
			local Players = game:GetService("Players")
			local lp = Players.LocalPlayer

			local function removeNeonObject()
				local char = lp.Character
				if not char then return end

				local neonObj = char:FindFirstChild("Neon")
				if neonObj then
					neonObj:Destroy()
				end
			end

			removeNeonObject()

			lp.CharacterAdded:Connect(function(char)
				if _G.StopAntiToxify then return end
				task.wait(0.1)
				local neonObj = char:FindFirstChild("Neon")
				if neonObj then
					neonObj:Destroy()
				end

				char.ChildAdded:Connect(function(obj)
					if obj.Name == "Neon" and not _G.StopAntiToxify then
						task.wait()
						obj:Destroy()
					end
				end)
			end)
		end
	end
})

Extras:AddButton({
	Name = "Open Autobuild / build saver interface",
	Info = "this opens the auto build and build saver interface",
	Callback = function()
		local success,err = pcall(function()

local localplr = game.Players.LocalPlayer
local http = game:GetService("HttpService")
local starterui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local mult = 4
local built = false
local stopped = false
local skipblock = false
local on = true
local ors = true
local colorbool = false

local childcube = nil
local childcube2 = nil
local oldprt = nil
local tp = true
local blocks = {}
local cubehistory = {}
local historynum = 0
local historymax = 400
local cubechild = nil
local novel = false
local resizewait = 0.4
local wbs = false

local historynum2 = 0
local pinghistory = {}
for i=1,5 do pinghistory[i] = 0 end

local normalids = {}
normalids[Enum.NormalId.Right] = {Vector3.new(1,0,0),"X"}
normalids[Enum.NormalId.Top] = {Vector3.new(0,1,0),"Y"}
normalids[Enum.NormalId.Back] = {Vector3.new(0,0,1),"Z"}
normalids[Enum.NormalId.Left] = {Vector3.new(-1,0,0),"X"}
normalids[Enum.NormalId.Bottom] = {Vector3.new(0,-1,0),"Y"}
normalids[Enum.NormalId.Front] = {Vector3.new(0,0,-1),"Z"}

local colors = {}
colors["tan"] = Color3.fromRGB(188,155,93)
colors["pink"] = Color3.fromRGB(255,0,255)
colors["dark pink"] = Color3.fromRGB(160,0,160)
local defaultcolor = Color3.fromRGB(192,192,192)

local highlight = Instance.new("Highlight")
highlight.Parent = game.CoreGui
highlight.FillTransparency = 1
highlight.OutlineTransparency = 0


local materials = {}
materials[Enum.Material.SmoothPlastic] = "smooth"
materials[Enum.Material.Plastic] = "plastic"
materials[Enum.Material.CeramicTiles] = "tiles"
materials[Enum.Material.Brick] = "bricks"
materials[Enum.Material.WoodPlanks] = "planks"
materials[Enum.Material.Ice] = "ice"
materials[Enum.Material.Grass] = "grass"
materials[Enum.Material.Sand] = "sand"
materials[Enum.Material.Snow] = "snow"
materials[Enum.Material.Glass] = "glass"
materials[Enum.Material.Wood] = "wood"
materials[Enum.Material.Slate] = "stone"
materials[Enum.Material.Pebble] = "pebble"
materials[Enum.Material.Marble] = "marble"
materials[Enum.Material.Granite] = "granite"
materials[Enum.Material.DiamondPlate] = "steel"
materials[Enum.Material.Metal] = "metal"
materials[Enum.Material.Asphalt] = "asphalt"
materials[Enum.Material.Concrete] = "concrete"
materials[Enum.Material.Pavement] = "pavement"
materials[Enum.Material.Neon] = "neon"

local swappedmaterials = {}
for i,v in pairs(materials) do
	swappedmaterials[v] = i
end


if workspace.Bricks:FindFirstChild(localplr.Name) then
	cubechild = workspace.Bricks[localplr.Name].ChildAdded:Connect(function(child)
		childcube = child
		historynum = historynum + 1
		if historynum > historymax then
			historynum = 1
		end
		cubehistory[historynum] = child
		built = true
	end)
end


function roundnum(num,m)
	return math.round((num - 2) / m) * m + 2
end

function round(pos,m)
	return Vector3.new(roundnum(pos.X,m or mult),roundnum(pos.Y,m or mult),roundnum(pos.Z,m or mult))
end

function snap(pos,m)
	if m == nil then m = mult end
	return pos
end

function validate(name)
	local bannedsymbols = {}
	bannedsymbols["\""] = "''"
	bannedsymbols["*"] = "\u{2605}"
	bannedsymbols[":"] = ";"
	bannedsymbols["<"] = "\u{2264}"
	bannedsymbols[">"] = "\u{2265}"
	bannedsymbols["?"] = "\u{00BF}"
	bannedsymbols["\\"] = ""
	bannedsymbols["|"] = "I"
	bannedsymbols["/"] = "\u{2215}"
	
	for i,v in pairs(bannedsymbols) do
		name = name:gsub(i,v)
	end
	local s = string.find(name,"%.txt") or string.find(name,"%.json")
	if s then
		local addafter = string.sub(name,s)
		name = string.sub(name,1,s-1)
		name = name:gsub("%.","·")
		name = name..addafter
	else
		name = name:gsub("%.","·")
	end
	return name
end

function listfilesfixed(directory)
	local s,lf = pcall(function()
		return listfiles(directory)
	end)
	if s then
		for i,v in pairs(lf) do
			if string.sub(v,1,2) == "./" then
				v = string.sub(v,3)
			end
		end
	end
	return lf
end

function getfn(js,first)
	local fn = listfilesfixed("TCOLSaves/")
	if fn and typeof(fn) == "table" then
		if not js then
			for i,v in pairs(fn) do
				fn[i] = v:gsub(".json","")
			end
		end
		if not first then
			for i,v in pairs(fn) do
				fn[i] = v:gsub("TCOLSaves/","")
			end
		end
	else
		fn = {}
	end
	return fn
end

function createpartrepl(pos,bsize,col,mat,transp,anch,collide,sprays)
	if typeof(pos) == "Vector3" then
		pos = CFrame.new(pos)
	end
	local p = Instance.new("Part")
	oldprt = p
	p.Anchored = anch or true
	p.CanCollide = collide or false
	p.CastShadow = false
	p.CanQuery = false
	p.Color = col
	p.Transparency = transp or .5
	p.Material = mat
	if bsize ~= nil then
		pos = CFrame.new((pos.X + (bsize.X/2))-.5,(pos.Y + (bsize.Y/2))-.5,(pos.Z + (bsize.Z/2))-.5) * pos.Rotation
	end
	p.Size = bsize or Vector3.new(mult,mult,mult)
	p.CFrame = pos
	p.Parent = workspace
	return p
end

function buildblock(pos,texture,color,bsize,bsizev3,premadebuild,origmaterial,sprays,anchored,collide)
	task.wait(0.001)
	if anchored == nil then anchored = true end
	if collide == nil then collide = true end
	
	local needsresize = false
	local s,e = pcall(function()
		local s,e = pcall(function()
			localplr.Backpack.Build.Parent = localplr.Character
		end)
		local oo = false
		local c = 0
		childcube = nil
		
		if bsize == nil then
			bsize = "normal"
			local success = pcall(function()
				if localplr.PlayerGui:FindFirstChild("Build") then
					local buildGui = localplr.PlayerGui.Build
					if buildGui and buildGui:FindFirstChild("Button") then
						bsize = buildGui.Button.Text
					end
				end
			end)
			if bsizev3 ~= nil and (bsizev3.X ~= mult or bsizev3.Y ~= mult or bsizev3.Z ~= mult) then
				bsize = "detailed"
			end
		end
		
		local oldpos = pos
		pos = snap(pos)
		local args = {
			[1] = workspace.Terrain,
			[2] = Enum.NormalId.Top,
			[3] = pos,
			[4] = bsize or "normal"
		}
		
		built = false
		if localplr.Character:FindFirstChild("Build") then
			local event = (localplr.Character.Build:FindFirstChild("origevent") and localplr.Character.Build.origevent:Invoke(unpack(args))) or localplr.Character.Build.Script.Event:FireServer(unpack(args))
		end
		
		c = 0
		repeat
			c = c + 1
			if localplr.Character and not localplr.Character:FindFirstChild("Build") and localplr.Backpack:FindFirstChild("Build") then
				localplr.Backpack.Build.Parent = localplr.Character
			end
			if localplr.Character:FindFirstChild("Build") then
				local event = (localplr.Character.Build:FindFirstChild("origevent") and localplr.Character.Build.origevent:Invoke(unpack(args))) or localplr.Character.Build.Script.Event:FireServer(unpack(args))
			end
			local s,e = pcall(function()
				novel = true
				if tp then
					localplr.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,6,0))
				end
			end)
			task.wait(.1)
		until (built == true and childcube) or stopped == true or skipblock == true or c > 200
		novel = false
		built = false
		
		if colorbool and childcube and typeof(color) == "Color3" and (color ~= defaultcolor or childcube.Color ~= color) and (localplr.Backpack:FindFirstChild("Paint") or localplr.Character:FindFirstChild("Paint")) then
			local pos = (childcube and childcube.Position + childcube.Size/2) or pos
			local args = {
				[1] = childcube,
				[2] = Enum.NormalId.Top,
				[3] = pos,
				[4] = "color",
				[5] = color or nil,
				[6] = "tiles",
				[7] = ""
			}
			task.wait()
			local success,err = pcall(function()
				localplr.Backpack.Paint.Parent = localplr.Character
			end)
			if not childcube then
				if oldprt then oldprt:Destroy() end
				return
			end
			
			highlight.Adornee = childcube
			highlight.FillColor = childcube.Color
			c = 0
			local s,e = pcall(function()
				repeat
					c = c + 1
					if localplr.Character and not localplr.Character:FindFirstChild("Paint") and localplr.Backpack:FindFirstChild("Paint") then
						localplr.Backpack.Paint.Parent = localplr.Character
					end
					if localplr.Character and localplr.Character:FindFirstChild("Paint") then
						local event = (localplr.Character.Paint:FindFirstChild("origevent") and localplr.Character.Paint.origevent:Invoke(unpack(args))) or localplr.Character.Paint.Script.Event:FireServer(unpack(args))
					end
					local s,e = pcall(function()
						novel = true
						if tp then
							localplr.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,6,0))
						end
					end)
					task.wait(.2)
				until not childcube or not childcube.Parent or childcube.Color == color or stopped == true or skipblock == true or c > 2000
				novel = false
			end)
		end
		
		if childcube and texture and (localplr.Backpack:FindFirstChild("Paint") or localplr.Character:FindFirstChild("Paint")) then
			local pos = (childcube and childcube.Position + childcube.Size/2) or pos
			local args = {
				[1] = childcube,
				[2] = Enum.NormalId.Top,
				[3] = pos,
				[4] = "material",
				[5] = nil,
				[6] = texture,
				[7] = ""
			}
			task.wait()
			local success,err = pcall(function()
				localplr.Backpack.Paint.Parent = localplr.Character
			end)
			if not childcube then
				if oldprt then oldprt:Destroy() end
				return
			end
			
			highlight.Adornee = childcube
			highlight.FillColor = childcube.Color
			c = 0
			local s,e = pcall(function()
				repeat
					c = c + 1
					if localplr.Character and not localplr.Character:FindFirstChild("Paint") and localplr.Backpack:FindFirstChild("Paint") then
						localplr.Backpack.Paint.Parent = localplr.Character
					end
					if localplr.Character and localplr.Character:FindFirstChild("Paint") then
						local event = (localplr.Character.Paint:FindFirstChild("origevent") and localplr.Character.Paint.origevent:Invoke(unpack(args))) or localplr.Character.Paint.Script.Event:FireServer(unpack(args))
					end
					local s,e = pcall(function()
						novel = true
						if tp then
							localplr.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,6,0))
						end
					end)
					task.wait(.2)
				until not childcube or not childcube.Parent or childcube.Material == swappedmaterials[texture] or stopped == true or skipblock == true or c > 2000
				novel = false
			end)
		end
		
		if childcube and bsizev3 and (bsizev3.X ~= mult or bsizev3.Y ~= mult or bsizev3.Z ~= mult) and (localplr.Character:FindFirstChild("Shape") or localplr.Backpack:FindFirstChild("Shape")) then
			if not localplr.Character:FindFirstChild("Shape") and localplr.Backpack:FindFirstChild("Shape") then
				localplr.Backpack.Shape.Parent = localplr.Character
			end
			
			local args = {[1] = childcube, [2] = Enum.NormalId.Right, [3] = "", [4] = ""}
			
			if childcube and childcube.Size.X ~= bsizev3.X then
				c = 0
				repeat
					c = c + 1
					pos = (childcube and childcube.Position + childcube.Size/2) or pos
					args[4] = nil
					if childcube then
						args[3] = pos
						if childcube.Size.X > bsizev3.X then
							args[4] = "decrease"
						elseif childcube.Size.X < bsizev3.X then
							args[4] = "increase"
						end
					end
					if localplr.Character:FindFirstChild("Shape") then
						local event = (localplr.Character.Shape:FindFirstChild("origevent") and localplr.Character.Shape.origevent:Invoke(unpack(args))) or localplr.Character.Shape.Script.Event:FireServer(unpack(args))
					end
					task.wait(resizewait)
				until args[4] == nil or (args[4] == "decrease" and childcube and childcube.Size.X <= 1) or (childcube and childcube.Size.X == bsizev3.X) or stopped == true or skipblock == true or not childcube or c > (bsizev3.X*3)/resizewait
			end
			
			args[2] = Enum.NormalId.Top
			if childcube and childcube.Size.Y ~= bsizev3.Y then
				c = 0
				repeat
					c = c + 1
					pos = (childcube and childcube.Position + childcube.Size/2) or pos
					args[4] = nil
					if childcube then
						args[3] = pos
						if childcube.Size.Y > bsizev3.Y then
							args[4] = "decrease"
						elseif childcube.Size.Y < bsizev3.Y then
							args[4] = "increase"
						end
					end
					if localplr.Character:FindFirstChild("Shape") then
						local event = (localplr.Character.Shape:FindFirstChild("origevent") and localplr.Character.Shape.origevent:Invoke(unpack(args))) or localplr.Character.Shape.Script.Event:FireServer(unpack(args))
					end
					task.wait(resizewait)
				until args[4] == nil or (args[4] == "decrease" and childcube and childcube.Size.Y <= 1) or (childcube and childcube.Size.Y == bsizev3.Y) or stopped == true or skipblock == true or not childcube or c > (bsizev3.Y*3)/resizewait
			end
			
			args[2] = Enum.NormalId.Back
			if childcube and childcube.Size.Z ~= bsizev3.Z then
				c = 0
				repeat
					c = c + 1
					pos = (childcube and childcube.Position + childcube.Size/2) or pos
					args[4] = nil
					if childcube then
						args[3] = pos
						if childcube.Size.Z > bsizev3.Z then
							args[4] = "decrease"
						elseif childcube.Size.Z < bsizev3.Z then
							args[4] = "increase"
						end
					end
					if localplr.Character:FindFirstChild("Shape") then
						local event = (localplr.Character.Shape:FindFirstChild("origevent") and localplr.Character.Shape.origevent:Invoke(unpack(args))) or localplr.Character.Shape.Script.Event:FireServer(unpack(args))
					end
					task.wait(resizewait)
				until args[4] == nil or (args[4] == "decrease" and childcube and childcube.Size.Z <= 1) or (childcube and childcube.Size.Z == bsizev3.Z) or stopped == true or skipblock == true or not childcube or c > (bsizev3.Z*3)/resizewait
			end
		end
		
		highlight.Adornee = nil
		skipblock = false
	end)
	if oldprt then oldprt:Destroy() end
	novel = false
	childcube = nil
end

function saveblock(bl)
	local blockdata = {}
	if bl:IsA("BasePart") then
		local p = bl.Position
		local pt = {bl.Position.X,bl.Position.Y,bl.Position.Z}
		if (bl.CFrame - bl.Position) ~= CFrame.new() then
			blockdata.p = {bl.CFrame:GetComponents()}
		else
			blockdata.p = pt
		end
		blockdata.c = {math.round(bl.Color.R*255),math.round(bl.Color.G*255),math.round(bl.Color.B*255)}
		blockdata.a = bl.Anchored
		blockdata.cc = bl.CanCollide
		if bl.Size.X ~= mult or bl.Size.Y ~= mult or bl.Size.Z ~= mult then
			blockdata.p[1] = (blockdata.p[1] - (bl.Size.X/2))+.5
			blockdata.p[2] = (blockdata.p[2] - (bl.Size.Y/2))+.5
			blockdata.p[3] = (blockdata.p[3] - (bl.Size.Z/2))+.5
			blockdata.s = {bl.Size.X,bl.Size.Y,bl.Size.Z}
		end
		blockdata.m = materials[bl.Material]
		blockdata.o = bl.Material.Name
		blockdata.sp = {}
		for i,v in pairs(bl:GetChildren()) do
			if v.Name == "Spray" then
				table.insert(blockdata.sp,{v.Face.Name,v.Image.Image,string.gsub(v.Label.Text,'"','\"')})
			end
		end
	end
	return blockdata
end


local files = listfilesfixed("")
local s,e = pcall(function()
	if (not table.find(files,"TCOLSaves/") and not table.find(files,"TCOLSaves")) then
		if table.find(files,"thechosenonebuilds.txt") then
			local builds = http:JSONDecode(readfile("thechosenonebuilds.txt"))
			makefolder("TCOLSaves")
			local i2 = 0
			for i,v in pairs(builds) do
				i = validate(i)
				local s,e = pcall(function()
					writefile("TCOLSaves/"..i..".json",http:JSONEncode(v))
				end)
				if not s then
					i2 += 1
					writefile("TCOLSaves/CheckFile_Named_'TCO"..tostring(i2).."'.json",http:JSONEncode(v))
				end
				task.wait()
			end
		else
			makefolder("TCOLSaves")
		end
	end
end)


local function corner(obj, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = obj
end

local function stroke(obj, t)
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(0,0,0)
	s.Transparency = 0.4
	s.Thickness = t or 1
	s.Parent = obj
end

local function themeFrame(f)
	f.BackgroundColor3 = Color3.fromRGB(20,20,20)
	corner(f,10)
	stroke(f,2)
end

local function themeButton(b)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Font = Enum.Font.Gotham
	b.BorderSizePixel = 0
	corner(b,8)
	stroke(b,1)
end

local function themeLabel(l)
	l.BackgroundColor3 = Color3.fromRGB(18,18,18)
	l.TextColor3 = Color3.fromRGB(255,255,255)
	l.Font = Enum.Font.Gotham
	l.BorderSizePixel = 0
	corner(l,6)
	stroke(l,1)
end


local playerGui = localplr:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuildGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 1100)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.Parent = screenGui
mainFrame.ClipsDescendants = true
themeFrame(mainFrame)

local dragging = false
local dragStart
local startPos

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.Text = "AUTOBUILD / SAVE BUILD"
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame
themeLabel(title)

local yPos = 60


local saveSectionLabel = Instance.new("TextLabel")
saveSectionLabel.Size = UDim2.new(1,-20,0,30)
saveSectionLabel.Position = UDim2.new(0,10,0,yPos)
saveSectionLabel.Text = "SAVE BUILD"
saveSectionLabel.TextSize = 16
saveSectionLabel.Font = Enum.Font.GothamBold
saveSectionLabel.Parent = mainFrame
themeLabel(saveSectionLabel)
yPos = yPos + 40

local saveBox = Instance.new("TextBox")
saveBox.Size = UDim2.new(1,-20,0,35)
saveBox.Position = UDim2.new(0,10,0,yPos)
saveBox.PlaceholderText = "Enter build name here..."
saveBox.Text = ""
saveBox.TextSize = 14
saveBox.ClearTextOnFocus = false
saveBox.Parent = mainFrame
themeButton(saveBox)
yPos = yPos + 45

local savebuildnames = {}
local selectedBuild = nil

local function updatedropdown()
	local names = getfn()
	table.sort(names,function(a,b)
		return a:lower() < b:lower()
	end)
	writefile("thechosenonenames.txt",http:JSONEncode(savebuildnames))
end

local function button(text, x, y, width, callback)
	local b = Instance.new("TextButton")
	b.Size = width
	b.Position = UDim2.new(x/600, 0, 0, y)
	b.Text = text
	b.TextSize = 12
	b.Font = Enum.Font.GothamBold
	b.Parent = mainFrame
	themeButton(b)
	b.MouseButton1Click:Connect(callback)
	return b
end

local function buttonFull(text, y, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-20,0,40)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.TextSize = 13
	b.Font = Enum.Font.GothamBold
	b.Parent = mainFrame
	themeButton(b)
	b.MouseButton1Click:Connect(callback)
	return b
end

local saveMode = "local"

local saveLocalToggle = Instance.new("TextButton")
saveLocalToggle.Size = UDim2.new(0.48,-12,0,40)
saveLocalToggle.Position = UDim2.new(0,10,0,yPos)
saveLocalToggle.Text = "Save Local: ON"
saveLocalToggle.TextSize = 12
saveLocalToggle.Font = Enum.Font.GothamBold
saveLocalToggle.Parent = mainFrame
themeButton(saveLocalToggle)

local saveServerToggle = Instance.new("TextButton")
saveServerToggle.Size = UDim2.new(0.48,-12,0,40)
saveServerToggle.Position = UDim2.new(0.52,10,0,yPos)
saveServerToggle.Text = "Save Server: OFF"
saveServerToggle.TextSize = 12
saveServerToggle.Font = Enum.Font.GothamBold
saveServerToggle.Parent = mainFrame
themeButton(saveServerToggle)

saveLocalToggle.MouseButton1Click:Connect(function()
	if saveMode ~= "local" then
		saveMode = "local"
		saveLocalToggle.Text = "Save Local: ON"
		saveServerToggle.Text = "Save Server: OFF"
	end
end)

saveServerToggle.MouseButton1Click:Connect(function()
	if saveMode ~= "server" then
		saveMode = "server"
		saveServerToggle.Text = "Save Server: ON"
		saveLocalToggle.Text = "Save Local: OFF"
	end
end)

yPos = yPos + 50

button("SAVE", 10, yPos, UDim2.new(0.31,-10,0,40), function()
	if saveBox.Text == "" then
		status.Text = "Status: Enter a name!"
		return
	end
	
	local builddata = {}
	
	if saveMode == "local" then
		local folder = workspace:FindFirstChild("Bricks")
		if not folder or not folder:FindFirstChild(localplr.Name) then
			status.Text = "Status: No local builds found"
			return
		end
		
		for i,v in ipairs(folder[localplr.Name]:GetChildren()) do
			if v:IsA("BasePart") then
				table.insert(builddata, saveblock(v))
			end
		end
	else
		local folder = workspace:FindFirstChild("Bricks")
		if folder then
			for i,v in pairs(folder:GetChildren()) do
				if v:IsA("Model") then
					for i2,v2 in pairs(v:GetChildren()) do
						if v2:IsA("BasePart") then
							table.insert(builddata, saveblock(v2))
						end
					end
				end
			end
		end
	end
	
	if #builddata == 0 then
		status.Text = "Status: No builds found"
		return
	end
	
	local name = validate(saveBox.Text)
	if not savebuildnames[name] then savebuildnames[name] = 0 end
	savebuildnames[name] = savebuildnames[name] + 1
	local savename = name
	if savebuildnames[name] > 1 then savename = name..tostring(savebuildnames[name]) end
	
	writefile("TCOLSaves/" .. savename .. ".json", http:JSONEncode(builddata))
	updatedropdown()
	refreshBuilds()
	local modeText = saveMode == "local" and "Local" or "Server"
	status.Text = "Status: " .. modeText .. " saved ✓"
	saveBox.Text = ""
end)

button("EXPORT", 217, yPos, UDim2.new(0.31,-10,0,40), function()
	if not selectedBuild or selectedBuild == "" then
		return
	end
	
	local allBuilds = getfn()
	local buildExists = false
	
	for _, buildName in ipairs(allBuilds) do
		if buildName == selectedBuild then
			buildExists = true
			break
		end
	end
	
	if not buildExists then
		return
	end
	
	local fullPath = "TCOLSaves/" .. selectedBuild .. ".json"
	
	if isfile(fullPath) then
		local jsonContent = readfile(fullPath)
		if jsonContent and jsonContent ~= "" then
			if setclipboard then
				pcall(function() setclipboard(jsonContent) end)
			elseif toclipboard then
				pcall(function() toclipboard(jsonContent) end)
			elseif Clipboard and Clipboard.set then
				pcall(function() Clipboard.set(jsonContent) end)
			end
		end
	end
end)

button("IMPORT", 424, yPos, UDim2.new(0.31,-10,0,40), function()
	local importGui = Instance.new("ScreenGui")
	importGui.Name = "ImportBuildGUI"
	importGui.Parent = playerGui
	importGui.ResetOnSpawn = false
	
	local importFrame = Instance.new("Frame")
	importFrame.Size = UDim2.new(0, 500, 0, 600)
	importFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
	importFrame.Parent = importGui
	themeFrame(importFrame)
	
	local dragging2 = false
	local dragStart2
	local startPos2
	
	importFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging2 = true
			dragStart2 = input.Position
			startPos2 = importFrame.Position
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging2 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart2
			importFrame.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging2 = false
		end
	end)
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1,0,0,50)
	titleLabel.Text = "IMPORT BUILD"
	titleLabel.TextSize = 20
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = importFrame
	themeLabel(titleLabel)
	
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1,-20,0,25)
	nameLabel.Position = UDim2.new(0,10,0,60)
	nameLabel.Text = "Build Name:"
	nameLabel.TextSize = 12
	nameLabel.Font = Enum.Font.Gotham
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
	nameLabel.Parent = importFrame
	
	local nameBox = Instance.new("TextBox")
	nameBox.Size = UDim2.new(1,-20,0,35)
	nameBox.Position = UDim2.new(0,10,0,88)
	nameBox.PlaceholderText = "Enter a name"
	nameBox.Text = ""
	nameBox.TextSize = 12
	nameBox.Parent = importFrame
	themeButton(nameBox)
	
	local jsonLabel = Instance.new("TextLabel")
	jsonLabel.Size = UDim2.new(1,-20,0,25)
	jsonLabel.Position = UDim2.new(0,10,0,130)
	jsonLabel.Text = "JSON Code:"
	jsonLabel.TextSize = 12
	jsonLabel.Font = Enum.Font.Gotham
	jsonLabel.BackgroundTransparency = 1
	jsonLabel.TextColor3 = Color3.fromRGB(255,255,255)
	jsonLabel.Parent = importFrame
	
	local jsonBox = Instance.new("TextBox")
	jsonBox.Size = UDim2.new(1,-20,0,270)
	jsonBox.Position = UDim2.new(0,10,0,158)
	jsonBox.PlaceholderText = "Enter .Json code"
	jsonBox.Text = ""
	jsonBox.TextSize = 11
	jsonBox.TextWrapped = true
	jsonBox.TextXAlignment = Enum.TextXAlignment.Left
	jsonBox.TextYAlignment = Enum.TextYAlignment.Top
	jsonBox.ClearTextOnFocus = false
	jsonBox.MultiLine = true
	jsonBox.Parent = importFrame
	themeButton(jsonBox)
	
	local confirmBtn = Instance.new("TextButton")
	confirmBtn.Size = UDim2.new(0.48,-12,0,40)
	confirmBtn.Position = UDim2.new(0,10,0,440)
	confirmBtn.Text = "CONFIRM"
	confirmBtn.TextSize = 12
	confirmBtn.Font = Enum.Font.GothamBold
	confirmBtn.Parent = importFrame
	themeButton(confirmBtn)
	
	confirmBtn.MouseButton1Click:Connect(function()
		if nameBox.Text == "" then
			status.Text = "Status: Enter a name!"
			return
		end
		
		if jsonBox.Text == "" then
			status.Text = "Status: Enter JSON code!"
			return
		end
		
		local isJsonValid = false
		pcall(function()
			local decodedData = http:JSONDecode(jsonBox.Text)
			if decodedData and typeof(decodedData) == "table" then
				isJsonValid = true
			end
		end)
		
		if not isJsonValid then
			status.Text = "Status: Invalid JSON!"
			return
		end
		
		local name = validate(nameBox.Text)
		if not savebuildnames[name] then savebuildnames[name] = 0 end
		savebuildnames[name] = savebuildnames[name] + 1
		local savename = name
		if savebuildnames[name] > 1 then savename = name..tostring(savebuildnames[name]) end
		
		pcall(function()
			writefile("TCOLSaves/" .. savename .. ".json", jsonBox.Text)
			updatedropdown()
			refreshBuilds()
			status.Text = "Status: Imported ✓"
		end)
		
		task.wait(0.3)
		pcall(function() importGui:Destroy() end)
	end)
	
	local cancelBtn = Instance.new("TextButton")
	cancelBtn.Size = UDim2.new(0.48,-12,0,40)
	cancelBtn.Position = UDim2.new(0.52,10,0,440)
	cancelBtn.Text = "CANCEL"
	cancelBtn.TextSize = 12
	cancelBtn.Font = Enum.Font.GothamBold
	cancelBtn.Parent = importFrame
	themeButton(cancelBtn)
	
	cancelBtn.MouseButton1Click:Connect(function()
		importGui:Destroy()
	end)
end)

yPos = yPos + 50


local listLabel = Instance.new("TextLabel")
listLabel.Size = UDim2.new(1,-20,0,30)
listLabel.Position = UDim2.new(0,10,0,yPos)
listLabel.Text = "SAVED BUILDS"
listLabel.TextSize = 16
listLabel.Font = Enum.Font.GothamBold
listLabel.Parent = mainFrame
themeLabel(listLabel)
yPos = yPos + 40

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-20,0,130)
scroll.Position = UDim2.new(0,10,0,yPos)
scroll.BackgroundColor3 = Color3.fromRGB(18,18,18)
scroll.ScrollBarThickness = 8
scroll.Parent = mainFrame
corner(scroll,8)
stroke(scroll,2)

local listLayout = Instance.new("UIListLayout", scroll)
listLayout.Padding = UDim.new(0, 5)

local buildInfo = Instance.new("TextLabel")
buildInfo.Size = UDim2.new(1,-20,0,30)
buildInfo.Position = UDim2.new(0,10,0,yPos+140)
buildInfo.Text = "No build selected"
buildInfo.TextSize = 13
buildInfo.Parent = mainFrame
themeLabel(buildInfo)

yPos = yPos + 180

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,-20,0,30)
status.Position = UDim2.new(0,10,0,yPos)
status.Text = "Status: Ready"
status.TextSize = 13
status.Parent = mainFrame
themeLabel(status)
yPos = yPos + 40


local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.25,-12,0,25)
speedLabel.Position = UDim2.new(0,10,0,yPos)
speedLabel.Text = "Speed:"
speedLabel.TextSize = 12
speedLabel.Parent = mainFrame
themeLabel(speedLabel)

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.25,-12,0,25)
speedBox.Position = UDim2.new(0.25,5,0,yPos)
speedBox.Text = "0.1"
speedBox.TextSize = 11
speedBox.Parent = mainFrame
themeButton(speedBox)

local buildSpeed = 0.1
speedBox.FocusLost:Connect(function()
	local n = tonumber(speedBox.Text)
	if n then buildSpeed = math.clamp(n, 0.01, 5) else speedBox.Text = tostring(buildSpeed) end
end)

local histLabel = Instance.new("TextLabel")
histLabel.Size = UDim2.new(0.25,-12,0,25)
histLabel.Position = UDim2.new(0.5,10,0,yPos)
histLabel.Text = "History:"
histLabel.TextSize = 12
histLabel.Parent = mainFrame
themeLabel(histLabel)

local histBox = Instance.new("TextBox")
histBox.Size = UDim2.new(0.25,-12,0,25)
histBox.Position = UDim2.new(0.75,5,0,yPos)
histBox.Text = "400"
histBox.TextSize = 11
histBox.Parent = mainFrame
themeButton(histBox)

histBox.FocusLost:Connect(function()
	local n = tonumber(histBox.Text)
	if n then historymax = math.abs(n) else histBox.Text = tostring(historymax) end
end)

yPos = yPos + 35

local resizeLabel = Instance.new("TextLabel")
resizeLabel.Size = UDim2.new(0.25,-12,0,25)
resizeLabel.Position = UDim2.new(0,10,0,yPos)
resizeLabel.Text = "Resize Wait:"
resizeLabel.TextSize = 11
resizeLabel.Parent = mainFrame
themeLabel(resizeLabel)

local resizeBox = Instance.new("TextBox")
resizeBox.Size = UDim2.new(0.25,-12,0,25)
resizeBox.Position = UDim2.new(0.25,5,0,yPos)
resizeBox.Text = "0.4"
resizeBox.TextSize = 11
resizeBox.Parent = mainFrame
themeButton(resizeBox)

resizeBox.FocusLost:Connect(function()
	local n = tonumber(resizeBox.Text)
	if n then resizewait = math.clamp(n, 0.01, 5) else resizeBox.Text = tostring(resizewait) end
end)

local tpToggle = Instance.new("TextButton")
tpToggle.Size = UDim2.new(0.48,-12,0,25)
tpToggle.Position = UDim2.new(0.52,10,0,yPos)
tpToggle.Text = "TP: ON"
tpToggle.TextSize = 11
tpToggle.Parent = mainFrame
themeButton(tpToggle)

tpToggle.MouseButton1Click:Connect(function()
	tp = not tp
	tpToggle.Text = tp and "TP: ON" or "TP: OFF"
end)

yPos = yPos + 35

local colorToggle = Instance.new("TextButton")
colorToggle.Size = UDim2.new(1,-20,0,25)
colorToggle.Position = UDim2.new(0,10,0,yPos)
colorToggle.Text = "Color: ON"
colorToggle.TextSize = 11
colorToggle.Parent = mainFrame
themeButton(colorToggle)

colorbool = true

colorToggle.MouseButton1Click:Connect(function()
	colorbool = not colorbool
	colorToggle.Text = colorbool and "Color: ON" or "Color: OFF"
end)

yPos = yPos + 35


local function refreshBuilds()
	for _,v in ipairs(scroll:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	
	local builds = getfn()
	
	for _, name in ipairs(builds) do
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1,-10,0,30)
		b.Text = name
		b.TextSize = 12
		b.Parent = scroll
		themeButton(b)
		
		local buildName = name
		b.MouseButton1Click:Connect(function()
			selectedBuild = buildName
			buildInfo.Text = "Selected: " .. buildName
		end)
	end
	
	scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

refreshBuilds()

local offset = Vector3.new(0,0,0)
local prttable = nil


buttonFull("LOAD BUILD", yPos, function()
	if not selectedBuild then
		status.Text = "Status: Select build!"
		return
	end
	
	stopped = false
	
	task.spawn(function()
		local path = "TCOLSaves/" .. selectedBuild .. ".json"
		if not isfile(path) then
			status.Text = "Status: File not found"
			return
		end
		
		local data = http:JSONDecode(readfile(path))
		if not data then return end
		
		status.Text = "Status: Loading..."
		
		local char = localplr.Character or localplr.CharacterAdded:Wait()
		local bp = localplr:WaitForChild("Backpack")
		
		if bp:FindFirstChild("Build") then
			bp:FindFirstChild("Build").Parent = char
		end
		
		for i, b in ipairs(data) do
			if stopped then break end
			
			local posses = (b.p or b.pos)
			local pos = Vector3.new(posses[1], posses[2], posses[3]) + offset
			local color = Color3.fromRGB(table.unpack(b.c or b.color))
			local bsize = nil
			if b.s or b.size then
				bsize = Vector3.new(table.unpack(b.s or b.size))
			end
			
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
			end
			
			buildblock(pos, b.m or b.mat, color, nil, bsize, nil, b.o or b.origmat, b.sp or b.sprayed, b.a or b.anchored, b.cc or b.collide)
			task.wait(buildSpeed)
			
			status.Text = "Status: Loading " .. tostring(i) .. "/" .. tostring(#data)
		end
		
		status.Text = stopped and "Status: Stopped" or "Status: Done"
	end)
end)

yPos = yPos + 50


buttonFull("PAUSE / RESUME", yPos, function()
end)

yPos = yPos + 50

buttonFull("STOP", yPos, function()
	stopped = true
	status.Text = "Status: Stopped"
end)

yPos = yPos + 50


button("DELETE", 10, yPos, UDim2.new(0.33,-15,0,40), function()
	if not selectedBuild then
		status.Text = "Status: Select build!"
		return
	end
	
	local path = "TCOLSaves/" .. selectedBuild .. ".json"
	if isfile(path) then
		delfile(path)
		refreshBuilds()
		selectedBuild = nil
		buildInfo.Text = "No build selected"
		status.Text = "Status: Deleted"
	end
end)

button("OPTIMIZE", 205, yPos, UDim2.new(0.33,-15,0,40), function()
	if not selectedBuild then
		status.Text = "Status: Select build!"
		return
	end
	
	local path = "TCOLSaves/" .. selectedBuild .. ".json"
	if isfile(path) then
		local data = http:JSONDecode(readfile(path))
		for i,v in pairs(data) do
			if v.pos then v.p = v.pos; v.pos = nil end
			if v.size then v.s = v.size; v.size = nil end
			if v.color then v.c = v.color; v.color = nil end
			if v.material then v.m = v.material; v.material = nil end
			if v.anchored then v.a = v.anchored; v.anchored = nil end
			if v.collide then v.cc = v.collide; v.collide = nil end
		end
		writefile(path, http:JSONEncode(data))
		status.Text = "Status: Optimized"
	end
end)

button("OPTIMIZE ALL", 400, yPos, UDim2.new(0.33,-15,0,40), function()
	local count = 0
	for i,v in pairs(getfn()) do
		local path = "TCOLSaves/" .. v .. ".json"
		if isfile(path) then
			local data = http:JSONDecode(readfile(path))
			for i,b in pairs(data) do
				if b.pos then b.p = b.pos; b.pos = nil end
				if b.size then b.s = b.size; b.size = nil end
				if b.color then b.c = b.color; b.color = nil end
				if b.material then b.m = b.material; b.material = nil end
				if b.anchored then b.a = b.anchored; b.anchored = nil end
				if b.collide then b.cc = b.collide; b.collide = nil end
			end
			writefile(path, http:JSONEncode(data))
			count = count + 1
		end
	end
	status.Text = "Status: Optimized " .. tostring(count) .. " builds"
end)

yPos = yPos + 50

button("SET OFFSET", 10, yPos, UDim2.new(0.48,-12,0,40), function()
	local char = localplr.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		offset = round(workspace.Spawn.Position + char.HumanoidRootPart.Position)
		status.Text = "Status: Offset set"
	end
end)

button("RESET OFFSET", 302, yPos, UDim2.new(0.48,-12,0,40), function()
	offset = Vector3.new(0,0,0)
	status.Text = "Status: Offset reset"
end)

yPos = yPos + 50

buttonFull("REFRESH", yPos, function()
	refreshBuilds()
	status.Text = "Status: Refreshed"
end)

yPos = yPos + 50


local function cleanup()
	on = false
	stopped = true
	skipblock = true
	ors = false
	if oldprt then oldprt:Destroy() end
	if prttable then
		for i,v in pairs(prttable) do
			v:Destroy()
		end
	end
	if cubechild then cubechild:Disconnect() end
end

game:GetService("CoreGui").TopbarCornerFrame.AncestryChanged:Connect(function()
	if not screenGui.Parent then cleanup() end
end)


end)

	end
})

Extras:AddButton({
	Name = "Scrxptdev",
	Info = "Another script maded by a collaborator[friend] of me(is in spanish only, no english translation)",
	Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/pi684yd4"))()
	end
})

Extras:AddButton({
	Name = "Customize rich text interface",
	Info = "Customize ur sign or spray texts using this interface",
	Callback = function()
		local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local bypassOn = false
local italicOn = false
local underlineOn = false
local boldOn = false
local strokeOn = false

local colorDefaultOn = true
local hue, sat, val = 0, 0, 1
local selectedColor = Color3.fromHSV(hue, sat, val)

local dropdownOpen = false
local selectedFont = "Arial"
local availableFonts = {
"Arial",
"SourceSans",
"SourceSansLight",
"SourceSansSemibold",
"Bodoni",
"Garamond",
"Cartoon",
"Code",
"Highway",
"SciFi",
"Arcade",
"Fantasy",
"Antique",
"Gotham",
"GothamMedium",
"GothamBlack",
"AmaticSC",
"Bangers",
"Creepster",
"DenkOne",
"Fondamento",
"FredokaOne",
"GrenzeGotisch",
"IndieFlower",
"JosefinSans",
"Jura",
"Kalam",
"LuckiestGuy",
"Merriweather",
"Michroma",
"Nunito",
"Oswald",
"PatrickHand",
"PermanentMarker",
"Roboto",
"RobotoCondensed",
"RobotoMono",
"Sarpanch",
"SpecialElite",
"TitilliumWeb",
"Ubuntu",
"BuilderSans",
"BuilderSansMedium",
"BuilderSansExtraBold",
"Arimo"
}

local function wrapBold(text)
return "<b>" .. text .. "</b>"
end

local function wrapItalic(text)
return "<i>" .. text .. "</i>"
end

local function wrapUnderline(text)
return "<u>" .. text .. "</u>"
end

local function wrapFont(text)
local attrs = ""

if selectedFont ~= "Default" then
attrs = attrs .. " face='" .. selectedFont .. "'"
end

if not colorDefaultOn then
local r = math.floor(selectedColor.R * 255 + 0.5)
local g = math.floor(selectedColor.G * 255 + 0.5)
local b = math.floor(selectedColor.B * 255 + 0.5)
local hex = string.format("#%02X%02X%02X", r, g, b)
attrs = attrs .. " color='" .. hex .. "'"
end

if attrs ~= "" then
return "<font" .. attrs .. ">" .. text .. "</font>"
end

return text
end

local function letterTag(c, i, offset)
offset = offset or 0
local tags = {"c","t","w","y","r","g","b","m","a","d"}
local tag = tags[((i + offset) % #tags) + 1]
return "<" .. tag .. ">" .. c .. "</" .. tag .. ">"
end

local function makeTagged(text, offset)
offset = offset or 0
local out = ""
for i = 1, #text do
out ..= letterTag(text:sub(i,i), i, offset)
end
return out
end

local function applyStroke(text)
if not strokeOn then return text end
return "<stroke color='rgb(0,0,0)' thickness='1'>" .. text .. "</stroke>"
end

local function applyStyles(text)
if boldOn then text = wrapBold(text) end
if italicOn then text = wrapItalic(text) end
if underlineOn then text = wrapUnderline(text) end
text = wrapFont(text)
return text
end

local function generate(text, offset)
offset = offset or 0
if bypassOn then
text = makeTagged(text, offset)
end

text = applyStyles(text)
text = applyStroke(text)

return text
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = safeWait(player, "PlayerGui", 15)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 560)
frame.Position = UDim2.new(0.5, -300, 0.5, -280)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0,0,0)
stroke.Transparency = 0.4
stroke.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 80, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -40, 0.5, -20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Text = "Close"
toggleBtn.Font = Enum.Font.Code
toggleBtn.TextSize = 12
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 50
toggleBtn.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0,8)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.new(0,0,0)
toggleStroke.Transparency = 0.4
toggleStroke.Parent = toggleBtn

local isOpen = true
local draggingToggle = false
local dragToggleInput
local toggleStartPos
local toggleStartFrame
local moved = false

toggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
draggingToggle = true
moved = false
toggleStartPos = input.Position
toggleStartFrame = toggleBtn.Position
end
end)

toggleBtn.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch then
dragToggleInput = input
end
end)

UserInputService.InputChanged:Connect(function(input)
if draggingToggle and input == dragToggleInput then
local delta = input.Position - toggleStartPos

if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
moved = true
end

toggleBtn.Position = UDim2.new(
toggleStartFrame.X.Scale,
toggleStartFrame.X.Offset + delta.X,
toggleStartFrame.Y.Scale,
toggleStartFrame.Y.Offset + delta.Y
)
end
end)

UserInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then

if draggingToggle then
draggingToggle = false

if not moved then
local goal

if isOpen then
goal = {Size = UDim2.new(0,600,0,30)}
toggleBtn.Text = "Open"
else
goal = {Size = UDim2.new(0,600,0,560)}
toggleBtn.Text = "Close"
end

isOpen = not isOpen

TweenService:Create(
frame,
TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
goal
):Play()
end
end
end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "Rich Text Customize"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Code
title.TextSize = 16
title.Parent = frame

local dragging, dragInput, startPos, startFrame

frame.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
dragging = true
startPos = i.Position
startFrame = frame.Position
end
end)

frame.InputChanged:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
dragInput = i
end
end)

UserInputService.InputChanged:Connect(function(i)
if dragging and i == dragInput then
local d = i.Position - startPos
frame.Position = UDim2.new(
startFrame.X.Scale,
startFrame.X.Offset + d.X,
startFrame.Y.Scale,
startFrame.Y.Offset + d.Y
)
end
end)

UserInputService.InputEnded:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)

local function makeBox(x,y,w,h,ph)
local t = Instance.new("TextBox")
t.Size = UDim2.new(0,w,0,h)
t.Position = UDim2.new(0,x,0,y)
t.BackgroundColor3 = Color3.fromRGB(30,30,30)
t.TextColor3 = Color3.new(1,1,1)
t.PlaceholderText = ph
t.Text = ""
t.ClearTextOnFocus = false
t.Font = Enum.Font.Code
t.TextSize = 14
t.TextWrapped = true
t.BorderSizePixel = 0
t.Parent = frame

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,6)
c.Parent = t

return t
end

local function makePreview(x,y,w,h,ph)
local t = Instance.new("TextLabel")
t.Size = UDim2.new(0,w,0,h)
t.Position = UDim2.new(0,x,0,y)
t.BackgroundColor3 = Color3.fromRGB(30,30,30)
t.TextColor3 = Color3.new(1,1,1)
t.Text = ph
t.Font = Enum.Font.Code
t.TextSize = 14
t.TextWrapped = true
t.TextScaled = false
t.BorderSizePixel = 0
t.RichText = true
t.Parent = frame

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,6)
c.Parent = t

return t
end

local function makeButton(text,x,y,w)
local b = Instance.new("TextButton")
b.Size = UDim2.new(0,w,0,28)
b.Position = UDim2.new(0,x,0,y)
b.BackgroundColor3 = Color3.fromRGB(25,25,25)
b.TextColor3 = Color3.new(1,1,1)
b.Text = text
b.Font = Enum.Font.Code
b.TextSize = 14
b.BorderSizePixel = 0
b.Parent = frame

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,6)
c.Parent = b

return b
end

local textBox = makeBox(10, 40, 580, 80, "Text")

local dropdownBtn = makeButton("Font: " .. selectedFont, 10, 135, 140)

local dropdownMenu = Instance.new("ScrollingFrame")
dropdownMenu.Size = UDim2.new(0, 140, 0, 0)
dropdownMenu.Position = UDim2.new(0, 10, 0, 165)
dropdownMenu.BackgroundColor3 = Color3.fromRGB(30,30,30)
dropdownMenu.BorderSizePixel = 0
dropdownMenu.ClipsDescendants = true
dropdownMenu.ScrollBarThickness = 6
dropdownMenu.ZIndex = 100
dropdownMenu.Parent = frame

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0,6)
dropdownCorner.Parent = dropdownMenu

local dropdownStroke = Instance.new("UIStroke")
dropdownStroke.Thickness = 1
dropdownStroke.Color = Color3.fromRGB(50,50,50)
dropdownStroke.Parent = dropdownMenu

local dropdownLayout = Instance.new("UIListLayout")
dropdownLayout.Padding = UDim.new(0, 0)
dropdownLayout.Parent = dropdownMenu

local fontButtons = {}

for i, fontName in ipairs(availableFonts) do
local fontBtn = Instance.new("TextButton")
fontBtn.Size = UDim2.new(1, -6, 0, 25)
fontBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
fontBtn.TextColor3 = Color3.new(1,1,1)
fontBtn.Text = fontName
fontBtn.Font = Enum.Font.Code
fontBtn.TextSize = 12
fontBtn.BorderSizePixel = 0
fontBtn.ZIndex = 100
fontBtn.Parent = dropdownMenu

fontBtn.MouseEnter:Connect(function()
fontBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
end)

fontBtn.MouseLeave:Connect(function()
fontBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
end)

fontBtn.MouseButton1Click:Connect(function()
selectedFont = fontName
dropdownBtn.Text = "Font: " .. selectedFont

local tweenInfo = TweenInfo.new(
0.2,
Enum.EasingStyle.Quad,
Enum.EasingDirection.Out
)

local tweenGoal = {Size = UDim2.new(0, 140, 0, 0)}
local tween = TweenService:Create(dropdownMenu, tweenInfo, tweenGoal)
tween:Play()

tween.Completed:Connect(function()
dropdownOpen = false
end)
end)

table.insert(fontButtons, fontBtn)
end

dropdownMenu.CanvasSize = UDim2.new(0, 0, 0, #availableFonts * 25)

local function toggleDropdown()
if dropdownOpen then
local tweenInfo = TweenInfo.new(
0.2,
Enum.EasingStyle.Quad,
Enum.EasingDirection.Out
)

local tweenGoal = {Size = UDim2.new(0, 140, 0, 0)}
local tween = TweenService:Create(dropdownMenu, tweenInfo, tweenGoal)
tween:Play()

tween.Completed:Connect(function()
dropdownOpen = false
end)
else
dropdownOpen = true

local tweenInfo = TweenInfo.new(
0.2,
Enum.EasingStyle.Quad,
Enum.EasingDirection.Out
)

local tweenGoal = {Size = UDim2.new(0, 140, 0, math.min(150, #availableFonts * 25))}
local tween = TweenService:Create(dropdownMenu, tweenInfo, tweenGoal)
tween:Play()
end
end

dropdownBtn.MouseButton1Click:Connect(toggleDropdown)

local bypassBtn = makeButton("RichText Bypass: OFF", 160, 135, 180)

local italicBtn = makeButton("Italic: OFF", 10, 175, 130)
local boldBtn = makeButton("Bold: OFF", 150, 175, 130)
local underlineBtn = makeButton("Underline: OFF", 300, 175, 130)
local strokeBtn = makeButton("Stroke: OFF", 450, 175, 130)

local generateBtn = makeButton("Generate", 10, 220, 130)
local rerollBtn = makeButton("Reroll", 150, 220, 130)
local copyBtn = makeButton("Copy", 300, 220, 130)

local output = makeBox(10, 260, 580, 80, "Result")
output.TextEditable = false

local preview = makePreview(10, 350, 580, 150, "Preview")

local colorPickerBtn = makeButton("Color Picker", 10, 510, 130)
local colorDefaultBtn = makeButton("Color Default: ON", 150, 510, 200)

local colorPickerFrame = Instance.new("Frame")
colorPickerFrame.Size = UDim2.new(0, 230, 0, 260)
colorPickerFrame.Position = UDim2.new(0.5, 310, 0.5, -130)
colorPickerFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
colorPickerFrame.BorderSizePixel = 0
colorPickerFrame.Visible = false
colorPickerFrame.ZIndex = 200
colorPickerFrame.Parent = gui

local cpCorner = Instance.new("UICorner")
cpCorner.CornerRadius = UDim.new(0,10)
cpCorner.Parent = colorPickerFrame

local cpStroke = Instance.new("UIStroke")
cpStroke.Thickness = 2
cpStroke.Color = Color3.new(0,0,0)
cpStroke.Transparency = 0.4
cpStroke.Parent = colorPickerFrame

local cpTitle = Instance.new("TextLabel")
cpTitle.Size = UDim2.new(1, -30, 0, 26)
cpTitle.Position = UDim2.new(0,0,0,0)
cpTitle.BackgroundTransparency = 1
cpTitle.Text = "Color Picker"
cpTitle.TextColor3 = Color3.new(1,1,1)
cpTitle.Font = Enum.Font.Code
cpTitle.TextSize = 14
cpTitle.Active = true
cpTitle.ZIndex = 201
cpTitle.Parent = colorPickerFrame

local cpCloseBtn = Instance.new("TextButton")
cpCloseBtn.Size = UDim2.new(0, 20, 0, 20)
cpCloseBtn.Position = UDim2.new(1, -26, 0, 4)
cpCloseBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
cpCloseBtn.TextColor3 = Color3.new(1,1,1)
cpCloseBtn.Text = "X"
cpCloseBtn.Font = Enum.Font.Code
cpCloseBtn.TextSize = 12
cpCloseBtn.BorderSizePixel = 0
cpCloseBtn.ZIndex = 202
cpCloseBtn.Parent = colorPickerFrame

local cpCloseCorner = Instance.new("UICorner")
cpCloseCorner.CornerRadius = UDim.new(0,4)
cpCloseCorner.Parent = cpCloseBtn

cpCloseBtn.MouseButton1Click:Connect(function()
colorPickerFrame.Visible = false
end)

local cpDragging, cpDragInput, cpStartPos, cpStartFrame

cpTitle.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
cpDragging = true
cpStartPos = i.Position
cpStartFrame = colorPickerFrame.Position
end
end)

cpTitle.InputChanged:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
cpDragInput = i
end
end)

UserInputService.InputChanged:Connect(function(i)
if cpDragging and i == cpDragInput then
local d = i.Position - cpStartPos
colorPickerFrame.Position = UDim2.new(
cpStartFrame.X.Scale,
cpStartFrame.X.Offset + d.X,
cpStartFrame.Y.Scale,
cpStartFrame.Y.Offset + d.Y
)
end
end)

UserInputService.InputEnded:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
cpDragging = false
end
end)

local svBox = Instance.new("Frame")
svBox.Size = UDim2.new(0, 170, 0, 150)
svBox.Position = UDim2.new(0, 15, 0, 34)
svBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
svBox.BorderSizePixel = 0
svBox.ClipsDescendants = true
svBox.ZIndex = 201
svBox.Parent = colorPickerFrame

local svCorner = Instance.new("UICorner")
svCorner.CornerRadius = UDim.new(0,6)
svCorner.Parent = svBox

local whiteOverlay = Instance.new("Frame")
whiteOverlay.Size = UDim2.new(1,0,1,0)
whiteOverlay.BackgroundColor3 = Color3.new(1,1,1)
whiteOverlay.BorderSizePixel = 0
whiteOverlay.ZIndex = 201
whiteOverlay.Parent = svBox

local whiteGradient = Instance.new("UIGradient")
whiteGradient.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1)
})
whiteGradient.Parent = whiteOverlay

local blackOverlay = Instance.new("Frame")
blackOverlay.Size = UDim2.new(1,0,1,0)
blackOverlay.BackgroundColor3 = Color3.new(0,0,0)
blackOverlay.BorderSizePixel = 0
blackOverlay.ZIndex = 202
blackOverlay.Parent = svBox

local blackGradient = Instance.new("UIGradient")
blackGradient.Rotation = 90
blackGradient.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(1,0)
})
blackGradient.Parent = blackOverlay

local svCursor = Instance.new("Frame")
svCursor.Size = UDim2.new(0,10,0,10)
svCursor.AnchorPoint = Vector2.new(0.5,0.5)
svCursor.Position = UDim2.new(1,0,0,0)
svCursor.BackgroundColor3 = Color3.new(1,1,1)
svCursor.BorderSizePixel = 0
svCursor.ZIndex = 205
svCursor.Parent = svBox

local svCursorCorner = Instance.new("UICorner")
svCursorCorner.CornerRadius = UDim.new(1,0)
svCursorCorner.Parent = svCursor

local svCursorStroke = Instance.new("UIStroke")
svCursorStroke.Thickness = 2
svCursorStroke.Color = Color3.new(0,0,0)
svCursorStroke.Parent = svCursor

local hueStrip = Instance.new("Frame")
hueStrip.Size = UDim2.new(0, 20, 0, 150)
hueStrip.Position = UDim2.new(0, 195, 0, 34)
hueStrip.BorderSizePixel = 0
hueStrip.ZIndex = 201
hueStrip.Parent = colorPickerFrame

local hueCorner = Instance.new("UICorner")
hueCorner.CornerRadius = UDim.new(0,6)
hueCorner.Parent = hueStrip

local hueGradient = Instance.new("UIGradient")
hueGradient.Rotation = 90
hueGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromHSV(0,1,1)),
ColorSequenceKeypoint.new(1/6, Color3.fromHSV(1/6,1,1)),
ColorSequenceKeypoint.new(2/6, Color3.fromHSV(2/6,1,1)),
ColorSequenceKeypoint.new(3/6, Color3.fromHSV(3/6,1,1)),
ColorSequenceKeypoint.new(4/6, Color3.fromHSV(4/6,1,1)),
ColorSequenceKeypoint.new(5/6, Color3.fromHSV(5/6,1,1)),
ColorSequenceKeypoint.new(1, Color3.fromHSV(1,1,1))
})
hueGradient.Parent = hueStrip

local hueCursor = Instance.new("Frame")
hueCursor.Size = UDim2.new(1, 4, 0, 4)
hueCursor.AnchorPoint = Vector2.new(0.5,0.5)
hueCursor.Position = UDim2.new(0.5,0,0,0)
hueCursor.BackgroundColor3 = Color3.new(1,1,1)
hueCursor.BorderSizePixel = 0
hueCursor.ZIndex = 205
hueCursor.Parent = hueStrip

local hueCursorStroke = Instance.new("UIStroke")
hueCursorStroke.Thickness = 2
hueCursorStroke.Color = Color3.new(0,0,0)
hueCursorStroke.Parent = hueCursor

local previewSwatch = Instance.new("Frame")
previewSwatch.Size = UDim2.new(0, 40, 0, 40)
previewSwatch.Position = UDim2.new(0, 15, 0, 200)
previewSwatch.BackgroundColor3 = selectedColor
previewSwatch.BorderSizePixel = 0
previewSwatch.ZIndex = 201
previewSwatch.Parent = colorPickerFrame

local previewCorner = Instance.new("UICorner")
previewCorner.CornerRadius = UDim.new(0,6)
previewCorner.Parent = previewSwatch

local previewStroke = Instance.new("UIStroke")
previewStroke.Thickness = 1
previewStroke.Color = Color3.fromRGB(60,60,60)
previewStroke.Parent = previewSwatch

local hexLabel = Instance.new("TextLabel")
hexLabel.Size = UDim2.new(0, 150, 0, 40)
hexLabel.Position = UDim2.new(0, 65, 0, 200)
hexLabel.BackgroundTransparency = 1
hexLabel.TextColor3 = Color3.new(1,1,1)
hexLabel.Font = Enum.Font.Code
hexLabel.TextSize = 14
hexLabel.TextXAlignment = Enum.TextXAlignment.Left
hexLabel.Text = "#FFFFFF"
hexLabel.ZIndex = 201
hexLabel.Parent = colorPickerFrame

local function updateColorDisplay()
selectedColor = Color3.fromHSV(hue, sat, val)
previewSwatch.BackgroundColor3 = selectedColor
svBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)

local r = math.floor(selectedColor.R * 255 + 0.5)
local g = math.floor(selectedColor.G * 255 + 0.5)
local b = math.floor(selectedColor.B * 255 + 0.5)
hexLabel.Text = string.format("#%02X%02X%02X", r, g, b)
end

svCursor.Position = UDim2.new(sat, 0, 1 - val, 0)
hueCursor.Position = UDim2.new(0.5, 0, hue, 0)
updateColorDisplay()

local svDragging = false
local hueDragging = false

local function updateSVFromInput(inputPos)
local absPos = svBox.AbsolutePosition
local absSize = svBox.AbsoluteSize

if absSize.X <= 0 or absSize.Y <= 0 then return end

local relX = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
local relY = math.clamp((inputPos.Y - absPos.Y) / absSize.Y, 0, 1)

sat = relX
val = 1 - relY

svCursor.Position = UDim2.new(relX, 0, relY, 0)
updateColorDisplay()
end

local function updateHueFromInput(inputPos)
local absPos = hueStrip.AbsolutePosition
local absSize = hueStrip.AbsoluteSize

if absSize.Y <= 0 then return end

local relY = math.clamp((inputPos.Y - absPos.Y) / absSize.Y, 0, 1)

hue = relY
hueCursor.Position = UDim2.new(0.5, 0, relY, 0)
updateColorDisplay()
end

svBox.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
svDragging = true
updateSVFromInput(input.Position)
end
end)

hueStrip.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
hueDragging = true
updateHueFromInput(input.Position)
end
end)

UserInputService.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
if svDragging then
updateSVFromInput(input.Position)
elseif hueDragging then
updateHueFromInput(input.Position)
end
end
end)

UserInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
svDragging = false
hueDragging = false
end
end)

colorPickerBtn.MouseButton1Click:Connect(function()
colorPickerFrame.Visible = not colorPickerFrame.Visible
end)

colorDefaultBtn.MouseButton1Click:Connect(function()
colorDefaultOn = not colorDefaultOn
colorDefaultBtn.Text = "Color Default: " .. (colorDefaultOn and "ON" or "OFF")
end)

local function updatePreview()
preview.Text = output.Text
end

local function rerollText()
local currentText = output.Text
if currentText == "" or currentText == "Result" then
return
end

local cleanText = currentText:gsub("<[^>]+>", "")
local randomOffset = math.random(0, 9)
output.Text = generate(cleanText, randomOffset)
updatePreview()
end

bypassBtn.MouseButton1Click:Connect(function()
bypassOn = not bypassOn
bypassBtn.Text = "RichText Bypass: " .. (bypassOn and "ON" or "OFF")
end)

italicBtn.MouseButton1Click:Connect(function()
italicOn = not italicOn
italicBtn.Text = "Italic: " .. (italicOn and "ON" or "OFF")
end)

boldBtn.MouseButton1Click:Connect(function()
boldOn = not boldOn
boldBtn.Text = "Bold: " .. (boldOn and "ON" or "OFF")
end)

underlineBtn.MouseButton1Click:Connect(function()
underlineOn = not underlineOn
underlineBtn.Text = "Underline: " .. (underlineOn and "ON" or "OFF")
end)

strokeBtn.MouseButton1Click:Connect(function()
strokeOn = not strokeOn
strokeBtn.Text = "Stroke: " .. (strokeOn and "ON" or "OFF")
end)

generateBtn.MouseButton1Click:Connect(function()
output.Text = generate(textBox.Text)
updatePreview()
end)

rerollBtn.MouseButton1Click:Connect(function()
rerollText()
end)

copyBtn.MouseButton1Click:Connect(function()
setclipboard(output.Text)
end)
	end
})

Extras:AddButton({
	Name = "Tagify",
	Info = "Bypass every text u want to spray or sign",
	Callback = function()
		loadstring(game:HttpGet("https://yaso.su/tgify"))()
	end
})

Extras:AddButton({
	Name = "Decal tool",
	Info = "Spray every image u want, u need enlighten",
	Callback = function()
		local localplr = game.Players.LocalPlayer
local mouse = localplr:GetMouse()
local rs = game:GetService("RunService")
local tc = game.TextChatService.TextChannels

local isog = workspace:FindFirstChild("Cubes")
local cfolder = isog or workspace:FindFirstChild("Bricks")
local brickname = (isog and "Cube") or "Brick"
local adminteam = (isog and game.Teams.Admin) or game.Teams.Chosen

local tools = {}
local novel = false
local selection = nil
local currentdectool = nil

function getwc(plr1,plr2)
local ui1,ui2=tostring(plr1.UserId),tostring(plr2.UserId)
if not tc:FindFirstChild("RBXWhisper:"..ui1..""..ui2) then
local t=tick()
local a=0
repeat
if tick()>t then
t=tick()+1
a+=1
coroutine.wrap(function()
game.TextChatService.TextChannels.RBXGeneral:SendAsync("/w "..plr2.DisplayName)
end)()
end
task.wait()
until not plr1 or not plr2 or tc:FindFirstChild("RBXWhisper:"..ui1..""..ui2) or tc:FindFirstChild("RBXWhisper:"..ui2..""..ui1) or a>5
return tc:FindFirstChild("RBXWhisper:"..ui1..""..ui2) or tc:FindFirstChild("RBXWhisper:"..ui2..""..ui1)
else
return tc["RBXWhisper:"..ui1..""..ui2]
end
end

function hp()
if localplr.Character:FindFirstChild("The Arkenstone") then
return true
elseif localplr.Backpack:FindFirstChild("The Arkenstone") then
return true
end
return localplr.Team==adminteam
end

function henl()
if localplr.Character:FindFirstChild("The Arkenstone") then
return true
elseif localplr.Backpack:FindFirstChild("The Arkenstone") then
return true
end
return false
end

function eenl(unequipothers,equipenlighten)
if not equipenlighten and localplr.Team==adminteam then
return true
end
if unequipothers then
for _,v in ipairs(localplr.Character:GetChildren()) do
if v:IsA("Tool") and v.Name~="The Arkenstone" then
v.Parent=localplr.Backpack
end
end
end
if localplr.Character:FindFirstChild("The Arkenstone") then
return true,localplr.Character["The Arkenstone"]
elseif localplr.Backpack:FindFirstChild("The Arkenstone") then
localplr.Backpack["The Arkenstone"].Parent=localplr.Character
return true,localplr.Character["The Arkenstone"]
end
return false
end

function gcp(p,plr)
local c=(plr and plr.Character) or localplr.Character
p=p:lower()
if p=="hrp" then
p="HumanoidRootPart"
elseif p=="hum" then
p="Humanoid"
end
if c and c:FindFirstChild(p) then
return c[p]
end
return false
end

function teleportto(cf)
local hrp=gcp("hrp")
if hrp then
if typeof(cf)=="Vector3" then
cf=CFrame.new(cf)
end
hrp.AssemblyLinearVelocity=Vector3.zero
hrp.AssemblyAngularVelocity=Vector3.zero
hrp.CFrame=cf
end
end

function notify(text,color)
color=color or Color3.fromRGB(0,170,255)
game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(
string.format("<font color='#%s'>%s</font>",color:ToHex(),text)
)
end

function sayto(plr,text,color)
if not plr then
game.TextChatService.TextChannels.RBXGeneral:SendAsync(text)
elseif plr==localplr then
notify(text,color)
else
local wc=getwc(localplr,plr)
if wc then
wc:SendAsync(text)
end
end
end

function equiptool(toolname,unequipothers)
local rt
for _,v in ipairs(localplr.Character:GetChildren()) do
if v:IsA("Tool") then
if v.Name==toolname then
rt=v
elseif unequipothers then
v.Parent=localplr.Backpack
end
end
end
if not rt and localplr.Backpack:FindFirstChild(toolname) then
rt=localplr.Backpack[toolname]
rt.Parent=localplr.Character
end
return rt
end

function getplrpos(plr)
return (plr or localplr).Character.HumanoidRootPart.Position
end

function getplrcfr(plr)
return (plr or localplr).Character.HumanoidRootPart.CFrame
end

function isolatenumbers(str)
return str:gsub("%D+","")
end

function waitmemeify()
local c=localplr.Character or localplr.CharacterAdded:Wait()
return c:WaitForChild("Meme",10)
end

function getmemeify(returnblock)
if localplr.Character and localplr.Character:FindFirstChild("Meme") then
return returnblock and localplr.Character.Meme or isolatenumbers(localplr.Character.Meme.Front.Label.Image)
end
return false
end

function IsSelectable(part,hit)
if part and localplr.Character:FindFirstChild("HumanoidRootPart") then
return (hit-getplrpos()).Magnitude<30 and part:IsDescendantOf(cfolder)
end
return false
end

function getfixedthing(s)
local tb=s==Enum.NormalId.Top or s==Enum.NormalId.Bottom
return Vector3.new(0,tb and -1 or -0.25,tb and -0.76 or -0.01)
end

local dectool=Instance.new("Tool")
dectool.Name="Decal Tool"

local handle=Instance.new("Part")
handle.Name="Handle"
handle.Size=Vector3.one
handle.Shape=Enum.PartType.Block
handle.CanCollide=false
handle.Color=Color3.fromRGB(90,90,90)
handle.Material=Enum.Material.Slate
handle.TopSurface=Enum.SurfaceType.Studs
handle.BottomSurface=Enum.SurfaceType.Studs
handle.FrontSurface=Enum.SurfaceType.Studs
handle.BackSurface=Enum.SurfaceType.Studs
handle.LeftSurface=Enum.SurfaceType.Studs
handle.RightSurface=Enum.SurfaceType.Studs
handle.Parent=dectool
local memeifyid="11894923077"

local decalrotations={
[Enum.NormalId.Top]={math.rad(90),0,0},
[Enum.NormalId.Bottom]={math.rad(90),0,0},
[Enum.NormalId.Left]={0,math.rad(90),0},
[Enum.NormalId.Right]={0,math.rad(-90),0},
[Enum.NormalId.Back]={math.rad(180),0,math.rad(180)},
[Enum.NormalId.Front]={0,0,0}
}

local decalrotations2={
[Enum.NormalId.Top]={0,math.rad(1),0},
[Enum.NormalId.Bottom]={0,math.rad(1),0},
[Enum.NormalId.Left]={0,0,math.rad(1)},
[Enum.NormalId.Right]={0,0,math.rad(1)},
[Enum.NormalId.Back]={0,0,math.rad(1)},
[Enum.NormalId.Front]={0,0,math.rad(1)}
}

local idkwhattonamets={
[Enum.NormalId.Top]={"X","Z"},
[Enum.NormalId.Bottom]={"X","Z"},
[Enum.NormalId.Left]={"Z","Y"},
[Enum.NormalId.Right]={"Z","Y"},
[Enum.NormalId.Back]={"X","Y"},
[Enum.NormalId.Front]={"X","Y"}
}

local sui=Instance.new("ScreenGui")
sui.Parent=game.CoreGui
sui.ResetOnSpawn=false
sui.IgnoreGuiInset=true
sui.Enabled=false

local mainFrame=Instance.new("Frame")
mainFrame.Parent=sui
mainFrame.BackgroundColor3=Color3.fromRGB(8,10,15)
mainFrame.BackgroundTransparency=0.2
mainFrame.BorderColor3=Color3.fromRGB(18,18,18)
mainFrame.BorderSizePixel=2
mainFrame.Position=UDim2.new(.3,0,.2,0)
mainFrame.Size=UDim2.new(.4,0,.5,0)
mainFrame.Active=true
mainFrame.Draggable=true

local frameStroke=Instance.new("UIStroke")
frameStroke.Parent=mainFrame
frameStroke.Color=Color3.fromRGB(35,35,35)
frameStroke.Thickness=3

local corner=Instance.new("UICorner")
corner.CornerRadius=UDim.new(0,12)
corner.Parent=mainFrame

local headerLabel=Instance.new("TextLabel")
headerLabel.Parent=mainFrame
headerLabel.BackgroundColor3=Color3.fromRGB(12,15,22)
headerLabel.BackgroundTransparency=0.2
headerLabel.BorderSizePixel=0
headerLabel.Size=UDim2.new(1,0,.1,0)
headerLabel.Font=Enum.Font.FredokaOne
headerLabel.Text="DECAL TOOL"
headerLabel.TextColor3=Color3.fromRGB(190,220,255)
headerLabel.TextScaled=true

local headerStroke=Instance.new("UIStroke")
headerStroke.Parent=headerLabel
headerStroke.Color=Color3.fromRGB(35,35,35)
headerStroke.Thickness=2

local hc=Instance.new("UICorner")
hc.CornerRadius=UDim.new(0,12)
hc.Parent=headerLabel

local container=Instance.new("Frame")
container.Parent=mainFrame
container.BackgroundTransparency=1
container.Position=UDim2.new(.05,0,.15,0)
container.Size=UDim2.new(.9,0,.85,0)

local idLabel=Instance.new("TextLabel")
idLabel.Parent=container
idLabel.BackgroundTransparency=1
idLabel.Size=UDim2.new(1,0,.08,0)
idLabel.Font=Enum.Font.FredokaOne
idLabel.Text="Decal ID:"
idLabel.TextColor3=Color3.fromRGB(190,220,255)
idLabel.TextScaled=true
idLabel.TextXAlignment=Enum.TextXAlignment.Left

local setdecal=Instance.new("TextBox")
setdecal.Parent=container
setdecal.Position=UDim2.new(0,0,.1,0)
setdecal.Size=UDim2.new(1,0,.12,0)
setdecal.BackgroundColor3=Color3.fromRGB(14,18,24)
setdecal.BackgroundTransparency=0.2
setdecal.BorderSizePixel=0
setdecal.Font=Enum.Font.FredokaOne
setdecal.Text=""
setdecal.PlaceholderText="Enter ID here"
setdecal.PlaceholderColor3=Color3.fromRGB(80,90,100)
setdecal.TextColor3=Color3.fromRGB(255,255,255)
setdecal.TextScaled=true
setdecal.ClearTextOnFocus=false

local textboxStroke=Instance.new("UIStroke")
textboxStroke.Parent=setdecal
textboxStroke.Color=Color3.fromRGB(35,35,35)
textboxStroke.Thickness=2

local tcorner=Instance.new("UICorner")
tcorner.CornerRadius=UDim.new(0,8)
tcorner.Parent=setdecal

local previewLabel=Instance.new("TextLabel")
previewLabel.Parent=container
previewLabel.BackgroundTransparency=1
previewLabel.Position=UDim2.new(0,0,.25,0)
previewLabel.Size=UDim2.new(1,0,.08,0)
previewLabel.Font=Enum.Font.FredokaOne
previewLabel.Text="Preview:"
previewLabel.TextColor3=Color3.fromRGB(190,220,255)
previewLabel.TextScaled=true
previewLabel.TextXAlignment=Enum.TextXAlignment.Left

local imageindicator=Instance.new("ImageLabel")
imageindicator.Parent=container
imageindicator.Position=UDim2.new(0,0,.34,0)
imageindicator.Size=UDim2.new(1,0,.35,0)
imageindicator.BackgroundColor3=Color3.fromRGB(12,15,22)
imageindicator.BackgroundTransparency=0.2
imageindicator.BorderSizePixel=0

local imageStroke=Instance.new("UIStroke")
imageStroke.Parent=imageindicator
imageStroke.Color=Color3.fromRGB(35,35,35)
imageStroke.Thickness=2

local icorner=Instance.new("UICorner")
icorner.CornerRadius=UDim.new(0,8)
icorner.Parent=imageindicator

local rotatebutton=Instance.new("TextButton")
rotatebutton.Parent=container
rotatebutton.Position=UDim2.new(0,0,.72,0)
rotatebutton.Size=UDim2.new(1,0,.15,0)
rotatebutton.BackgroundColor3=Color3.fromRGB(20,30,45)
rotatebutton.BackgroundTransparency=0.2
rotatebutton.BorderSizePixel=0
rotatebutton.Font=Enum.Font.FredokaOne
rotatebutton.Text="ROTATE 90 DEGREES"
rotatebutton.TextColor3=Color3.new(1,1,1)
rotatebutton.TextScaled=true
local buttonStroke=Instance.new("UIStroke")
buttonStroke.Parent=rotatebutton
buttonStroke.Color=Color3.fromRGB(35,35,35)
buttonStroke.Thickness=2

local bcorner=Instance.new("UICorner")
bcorner.CornerRadius=UDim.new(0,8)
bcorner.Parent=rotatebutton

local oldcolor=rotatebutton.BackgroundColor3

rotatebutton.MouseEnter:Connect(function()
rotatebutton.BackgroundColor3=Color3.fromRGB(30,40,55)
end)

rotatebutton.MouseLeave:Connect(function()
rotatebutton.BackgroundColor3=oldcolor
end)

local ar=Instance.new("UIAspectRatioConstraint")
ar.AspectRatio=1
ar.Parent=imageindicator

local fakememe=Instance.new("Part")
fakememe.Anchored=true
fakememe.Transparency=1
fakememe.CanCollide=false
fakememe.CanTouch=false
fakememe.CanQuery=false
fakememe.Parent=workspace

local suui=Instance.new("SurfaceGui")
suui.Parent=game.CoreGui
suui.SizingMode=Enum.SurfaceGuiSizingMode.PixelsPerStud
suui.Adornee=fakememe
suui.Face=Enum.NormalId.Front
suui.Enabled=false

local imageindicator2=Instance.new("ImageLabel")
imageindicator2.Parent=suui
imageindicator2.BackgroundTransparency=1
imageindicator2.ImageTransparency=.3
imageindicator2.Size=UDim2.new(1,0,1,0)

function updatememeifydisplays()
local img="https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId="..memeifyid
imageindicator.Image=img
imageindicator2.Image=img
end

setdecal:GetPropertyChangedSignal("Text"):Connect(function()
memeifyid=isolatenumbers(setdecal.Text)
updatememeifydisplays()
end)

updatememeifydisplays()

local decalrotation=0

rotatebutton.MouseButton1Click:Connect(function()
decalrotation+=90
end)

function createdecaltool()
local connections={}
currentdectool=dectool:Clone()
local equipped=false

table.insert(connections,currentdectool.Equipped:Connect(function()
	equipped=true
	sui.Enabled=true
	suui.Enabled=true
end))

table.insert(connections,currentdectool.Unequipped:Connect(function()
	equipped=false
	sui.Enabled=false
	suui.Enabled=false
end))

table.insert(connections,currentdectool.Activated:Connect(function()
	if not equipped then
		return
	end

	if not hp() then
		sayto(localplr,"You need enlighten to use Decal Tool!")
		return
	end

	local issel=IsSelectable(mouse.Target,mouse.Hit.Position)

	if issel and henl() then
		local selectside=mouse.TargetSurface
		selection=mouse.Target
		local mid

		if gcp("hum").RigType~=Enum.HumanoidRigType.R15 then
			sayto(nil,";r15 me")
			task.wait(3)
			eenl()
		end

		if getmemeify() then
			mid=getmemeify()
		else
			eenl()
			sayto(nil,";memeify "..memeifyid)
			mid=memeifyid
			waitmemeify()
		end

		if mid~=memeifyid then
			eenl()
			sayto(nil,";memeify "..memeifyid)
			waitmemeify()
		end

		local axes=idkwhattonamets[selectside]
		local firstone,secondone=axes[1],axes[2]

		if decalrotation%180==90 then
			firstone,secondone=axes[2],axes[1]
		end

		local r1=decalrotations[selectside]
		local r2=decalrotations2[selectside]

		local lat=CFrame.Angles(
			r1[1]+r2[1]*decalrotation,
			r1[2]+r2[2]*decalrotation,
			r1[3]+r2[3]*decalrotation
		)

		local surfacecfr=CFrame.new(
			CFrame.new(
				selection.Position+
				Vector3.new(0,-1,0)+
				(Vector3.FromNormalId(selectside)*selection.Size/2)
			)*lat*getfixedthing(selectside)
		)*lat

		novel=true
		local looping=true

		pcall(function()
			gcp("hum").PlatformStand=true

			coroutine.wrap(function()
				while looping do
					teleportto(surfacecfr)
					task.wait()
				end
			end)()

			task.wait(1.5)

			eenl()
			sayto(nil,";width me "..tostring(selection.Size[firstone]/6))

			task.wait(1.5)

			sayto(nil,";height me "..tostring(selection.Size[secondone]/6))

			task.wait(2.5)

			if gcp("hrp").CollisionGroup~="NoClip" then
				sayto(nil,";noclip me")
				task.wait(3)
			end

			sayto(nil,";freeze me")
			task.wait(1)

			sayto(nil,";clone me")
			task.wait(1)

			sayto(nil,";unfreeze me")

			gcp("hum").PlatformStand=false

			task.wait(0.2)

			if currentdectool and currentdectool.Parent==localplr.Character then
				currentdectool.Parent=localplr.Backpack
			end
		end)

		looping=false
		novel=false
	end
end))

table.insert(connections,rs.Heartbeat:Connect(function()
	if equipped and mouse.Target and IsSelectable(mouse.Target,mouse.Hit.Position) and mouse.TargetSurface then
		local selectside=mouse.TargetSurface
		local selection=mouse.Target

		local axes=idkwhattonamets[selectside]
		local firstone,secondone=axes[1],axes[2]

		if decalrotation%180==90 then
			firstone,secondone=axes[2],axes[1]
		end

		fakememe.Size=Vector3.new(
			selection.Size[firstone],
			selection.Size[secondone],
			0.001
		)

		local r1=decalrotations[selectside]
		local r2=decalrotations2[selectside]

		local lat=CFrame.Angles(
			r1[1]+r2[1]*decalrotation,
			r1[2]+r2[2]*decalrotation,
			r1[3]+r2[3]*decalrotation
		)

		local surfacecfr=CFrame.new(
			CFrame.new(
				selection.Position+
				(Vector3.FromNormalId(selectside)*selection.Size/2)
			)*lat*getfixedthing(selectside)
		)*lat

		fakememe.CFrame=surfacecfr
		suui.Adornee=fakememe
	else
		suui.Adornee=nil
	end
end))

table.insert(connections,currentdectool.AncestryChanged:Connect(function()
	if not currentdectool or not currentdectool.Parent or not currentdectool.Parent.Parent then
		for _,v in ipairs(connections) do
			v:Disconnect()
		end
	end
end))

table.insert(tools,{currentdectool})

currentdectool.Parent=localplr.Backpack

task.wait()

return currentdectool
end

createdecaltool()
	end
})

Extras:AddButton({
	Name = "Command Brick interface",
	Info = "Opens a interface to make a real functional button",
	Callback = function()
		local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = safeWait(player, "PlayerGui", 15)

local gui = Instance.new("ScreenGui")
gui.Name = "CustomGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local brickData = {}
local touchConnections = {}
local cooldowns = {}

local selecting = false
local selectedPart = nil

local function setOutline(part)
	for _, v in ipairs(workspace:GetChildren()) do
		if v:IsA("Highlight") and v.Name == "Sel" then
			v:Destroy()
		end
	end

	if not part then return end

	local h = Instance.new("Highlight")
	h.Name = "Sel"
	h.FillTransparency = 1
	h.OutlineTransparency = 0
	h.OutlineColor = Color3.fromRGB(0,170,255)
	h.Adornee = part
	h.Parent = workspace
end

local function makeCorner(obj,r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,r)
	c.Parent = obj
end

local main = Instance.new("Frame")
main.Size = UDim2.new(0,540,0,340)
main.Position = UDim2.new(0.5,-270,0.5,-170)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
makeCorner(main,10)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0,0,0)
stroke.Transparency = 0.4
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,0,35)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "Command Button System"
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.Code
title.TextSize = 16
title.Parent = main

local container = Instance.new("Frame")
container.Size = UDim2.new(1,-20,1,-50)
container.Position = UDim2.new(0,10,0,45)
container.BackgroundTransparency = 1
container.Parent = main

local left = Instance.new("Frame")
left.Size = UDim2.new(0.42,0,1,0)
left.BackgroundColor3 = Color3.fromRGB(25,25,25)
left.BorderSizePixel = 0
left.Parent = container
makeCorner(left,6)

local leftStroke = Instance.new("UIStroke")
leftStroke.Thickness = 1
leftStroke.Color = Color3.new(0,0,0)
leftStroke.Transparency = 0.4
leftStroke.Parent = left

local right = Instance.new("Frame")
right.Size = UDim2.new(0.56,0,1,0)
right.Position = UDim2.new(0.44,0,0,0)
right.BackgroundColor3 = Color3.fromRGB(25,25,25)
right.BorderSizePixel = 0
right.Parent = container
makeCorner(right,6)

local rightStroke = Instance.new("UIStroke")
rightStroke.Thickness = 1
rightStroke.Color = Color3.new(0,0,0)
rightStroke.Transparency = 0.4
rightStroke.Parent = right

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9,0,0,40)
textBox.Position = UDim2.new(0.05,0,0.06,0)
textBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
textBox.BorderSizePixel = 0
textBox.TextColor3 = Color3.new(1,1,1)
textBox.PlaceholderText = ""
textBox.Text = ""
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Code
textBox.TextSize = 14
textBox.Parent = left
makeCorner(textBox,6)

local function button(txt,y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.9,0,0,38)
	b.Position = UDim2.new(0.05,0,y,0)
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.BorderSizePixel = 0
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = txt
	b.Font = Enum.Font.Code
	b.TextSize = 14
	b.Parent = left
	makeCorner(b,6)
	return b
end

local selectBtn = button("Select",0.28)
local finishBtn = button("Finish",0.42)
local cancelBtn = button("Cancel",0.56)

local addBtn = Instance.new("TextButton")
addBtn.Size = UDim2.new(0.9,0,0,38)
addBtn.Position = UDim2.new(0.05,0,0.05,0)
addBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
addBtn.BorderSizePixel = 0
addBtn.TextColor3 = Color3.new(1,1,1)
addBtn.Text = "Add"
addBtn.Font = Enum.Font.Code
addBtn.TextSize = 14
addBtn.Parent = right
makeCorner(addBtn,6)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.9,0,0,20)
label.Position = UDim2.new(0.05,0,0.18,0)
label.BackgroundTransparency = 1
label.Text = "Commands"
label.TextColor3 = Color3.fromRGB(200,200,200)
label.Font = Enum.Font.Code
label.TextSize = 13
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = right

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9,0,0.75,0)
scroll.Position = UDim2.new(0.05,0,0.23,0)
scroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0,0,5,0)
scroll.Parent = right
makeCorner(scroll,6)

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0,6)
list.Parent = scroll

local function clearScroll()
	for _,v in ipairs(scroll:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
end

local function load(part)
	clearScroll()

	local cmds = brickData[part]
	if not cmds then return end

	for i,cmd in ipairs(cmds) do
		local holder = Instance.new("Frame")
		holder.Size = UDim2.new(1,-8,0,34)
		holder.BackgroundColor3 = Color3.fromRGB(25,25,25)
		holder.BorderSizePixel = 0
		holder.Parent = scroll
		makeCorner(holder,6)

		local t = Instance.new("TextLabel")
		t.Size = UDim2.new(1,-40,1,0)
		t.Position = UDim2.new(0,8,0,0)
		t.BackgroundTransparency = 1
		t.Text = cmd
		t.TextColor3 = Color3.new(1,1,1)
		t.Font = Enum.Font.Code
		t.TextSize = 13
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.Parent = holder

		local del = Instance.new("TextButton")
		del.Size = UDim2.new(0,26,0,26)
		del.Position = UDim2.new(1,-30,0.5,-13)
		del.BackgroundColor3 = Color3.fromRGB(60,60,60)
		del.Text = "X"
		del.TextColor3 = Color3.new(1,1,1)
		del.Font = Enum.Font.Code
		del.TextSize = 13
		del.BorderSizePixel = 0
		del.Parent = holder
		makeCorner(del,6)

		del.MouseButton1Click:Connect(function()
			local current = brickData[part]
			if current and current[i] then
				table.remove(current,i)
			end
			load(part)
		end)
	end
end

local function sendCommands(part,playerName)
	if cooldowns[part] then return end
	cooldowns[part] = true

	local cmds = brickData[part]

	playerName = playerName:gsub("_",".")

	if cmds then
		for _,c in ipairs(cmds) do
			pcall(function()
				TextChatService.TextChannels.RBXGeneral:SendAsync(";"..c.." "..playerName)
			end)
		end
	end

	task.delay(10,function()
		cooldowns[part] = nil
	end)
end

local function attach(part)
	if touchConnections[part] then return end

	touchConnections[part] = part.Touched:Connect(function(hit)
		local plr = Players:GetPlayerFromCharacter(hit.Parent)

		if plr then
			sendCommands(part,plr.Name)
		end
	end)
end

selectBtn.MouseButton1Click:Connect(function()
	selecting = true

	mouse.Button1Down:Connect(function()
		if not selecting then return end

		if mouse.Target and (mouse.Target.Name == "Brick" or mouse.Target.Name == "Cube") then
			selectedPart = mouse.Target
			setOutline(selectedPart)
			load(selectedPart)
		end
	end)
end)

finishBtn.MouseButton1Click:Connect(function()
	selecting = false
	setOutline(nil)

	if selectedPart then
		attach(selectedPart)
	end
end)

cancelBtn.MouseButton1Click:Connect(function()
	selecting = false
	selectedPart = nil
	setOutline(nil)
	clearScroll()
end)

addBtn.MouseButton1Click:Connect(function()
	if not selectedPart then return end

	if selectedPart.Name ~= "Brick" and selectedPart.Name ~= "Cube" then
		return
	end

	if textBox.Text == "" then return end

	brickData[selectedPart] = brickData[selectedPart] or {}
	table.insert(brickData[selectedPart],textBox.Text)

	load(selectedPart)
	attach(selectedPart)

	textBox.Text = ""
end)
	end
})

Extras:AddButton({
	Name = "Unanchor tool control",
	Info = "Control unanchored blocks with a tool",
	Callback = function()
		local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local Tool = Instance.new("Tool")
Tool.Name = "Unanchor Control Tool"
Tool.RequiresHandle = true
Tool.Parent = player.Backpack

local Handle = Instance.new("Part")
Handle.Name = "Handle"
Handle.Size = Vector3.new(0.9,0.9,0.9)
Handle.Color = Color3.fromRGB(255,255,0)
Handle.Material = Enum.Material.Plastic
Handle.TopSurface = Enum.SurfaceType.Studs
Handle.BottomSurface = Enum.SurfaceType.Inlet
Handle.Parent = Tool

local equipped = false
local editMode = false

local selectedKeyframe = nil
local handles = nil

local keyframes = {}

local playing = false
local animationThread = nil

local speedMultiplier = 1
local separatedBricks = false
local freeBlockMovement = false
local followsPlayer = true

local animTrack = nil

local gui = Instance.new("ScreenGui")
gui.Name = "UnanchorGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local function playCharAnim(on)
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if animTrack then
		animTrack:Stop()
		animTrack:Destroy()
		animTrack = nil
	end

	if on then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://17755760862"
		animTrack = hum:LoadAnimation(anim)
		animTrack:Play()
	end
end

local function makeDraggable(frame)
	local dragging = false
	local dragStart
	local startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if sliderActive then return end

			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not sliderActive then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local function createGui(name,pos)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.Size = UDim2.new(0,180,0,250)
	frame.Position = pos
	frame.BackgroundColor3 = Color3.fromRGB(170,255,170)
	frame.BackgroundTransparency = 0.35
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,12)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(120,220,120)
	stroke.Thickness = 2
	stroke.Parent = frame

	makeDraggable(frame)
	return frame
end

local function createButton(text,pos,parent)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,140,0,35)
	b.Position = pos
	b.BackgroundColor3 = Color3.fromRGB(150,255,150)
	b.BackgroundTransparency = 0.25
	b.Text = text
	b.TextScaled = true
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.SourceSansBold
	b.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = b

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(120,220,120)
	stroke.Thickness = 2
	stroke.Parent = b

	return b
end

local function hashObj(obj)
	local s = tostring(obj:GetDebugId())
	local h = 0
	for i = 1, #s do
		h = (h * 31 + string.byte(s, i)) % 100000
	end
	return h
end

local g1 = createGui("Gui1",UDim2.new(0.5,-90,0.5,-125))

local sliderActive = false

local editButton = createButton("Edit",UDim2.new(0.5,-70,0,10),g1)

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0,140,0,18)
sliderFrame.Position = UDim2.new(0.5,-70,0,55)
sliderFrame.BackgroundColor3 = Color3.fromRGB(120,220,120)
sliderFrame.BackgroundTransparency = 0.3
sliderFrame.BorderSizePixel = 0
sliderFrame.Parent = g1

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0,8)
sliderCorner.Parent = sliderFrame

local sliderKnob = Instance.new("Frame")
sliderKnob.Size = UDim2.new(0,18,0,18)
sliderKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
sliderKnob.BorderSizePixel = 0
sliderKnob.Parent = sliderFrame

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1,0)
knobCorner.Parent = sliderKnob

local toggleButton = createButton("Separated Bricks: OFF",UDim2.new(0.5,-70,0,80),g1)
local freeBlockButton = createButton("Free Block Movement: OFF",UDim2.new(0.5,-70,0,115),g1)

local addButton = createButton("Add keyframe",UDim2.new(0.5,-70,0,10),g1)
addButton.Visible = false

local deleteButton = createButton("Delete keyframe",UDim2.new(0.5,-70,0,50),g1)
deleteButton.Visible = false

local exitButton = createButton("Exit Edit Mode",UDim2.new(0.5,-70,0,90),g1)

local followsButton = createButton("Follows Player: ON",UDim2.new(0.5,-70,0,200),g1)

local playButton = createButton("Play Unanchor Animation",UDim2.new(0.5,-70,0,160),g1)

followsButton.MouseButton1Click:Connect(function()
	followsPlayer = not followsPlayer
	followsButton.Text = "Follows Player: " .. (followsPlayer and "ON" or "OFF")
end)

local function setSliderFromX(x)
	local alpha = math.clamp((x - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
	sliderKnob.Position = UDim2.new(alpha, -9, 0, 0)
	speedMultiplier = 0.5 + alpha * 9.5
end

sliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderActive = true
		UIS.ModalEnabled = true
		setSliderFromX(input.Position.X)
	end
end)

sliderFrame.InputEnded:Connect(function()
	sliderActive = false
	UIS.ModalEnabled = false
end)

UIS.InputChanged:Connect(function(input)
	if sliderActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		setSliderFromX(input.Position.X)
	end
end)

toggleButton.MouseButton1Click:Connect(function()
	separatedBricks = not separatedBricks
	toggleButton.Text = "Separated Bricks: " .. (separatedBricks and "ON" or "OFF")
end)

freeBlockButton.MouseButton1Click:Connect(function()
	freeBlockMovement = not freeBlockMovement
	freeBlockButton.Text = "Free Block Movement: " .. (freeBlockMovement and "ON" or "OFF")
end)

local function clearSelection()
	for _,v in pairs(keyframes) do
		local box = v:FindFirstChild("SelectionBox")
		if box then box:Destroy() end
	end
	if handles then handles:Destroy() handles = nil end
end

local function refreshKeyframes()
	for _,v in pairs(keyframes) do
		v.LocalTransparencyModifier = (equipped and editMode) and 0.5 or 1
	end
end

local function selectKeyframe(part)
	if not equipped or not editMode then return end

	selectedKeyframe = part
	clearSelection()

	local outline = Instance.new("SelectionBox")
	outline.Adornee = part
	outline.LineThickness = 0.05
	outline.Color3 = Color3.fromRGB(0,255,0)
	outline.Parent = part

	handles = Instance.new("Handles")
	handles.Style = Enum.HandlesStyle.Movement
	handles.Color3 = Color3.fromRGB(0,255,0)
	handles.Adornee = part
	handles.Parent = game:GetService("CoreGui")

	handles.MouseDrag:Connect(function(face,distance)
		UIS.ModalEnabled = true
		local offset = part:GetAttribute("Offset") or Vector3.zero
		local step = distance * 0.1
		local target = offset

		if face == Enum.NormalId.Right then target += Vector3.new(step,0,0)
		elseif face == Enum.NormalId.Left then target -= Vector3.new(step,0,0)
		elseif face == Enum.NormalId.Top then target += Vector3.new(0,step,0)
		elseif face == Enum.NormalId.Bottom then target -= Vector3.new(0,step,0)
		elseif face == Enum.NormalId.Front then target -= Vector3.new(0,0,step)
		elseif face == Enum.NormalId.Back then target += Vector3.new(0,0,step)
		end

		local start = offset
		local t0 = tick()

		while tick()-t0 < 0.07 do
			local a = (tick()-t0)/0.07
			part:SetAttribute("Offset", start:Lerp(target,a))
			RunService.Heartbeat:Wait()
		end

		UIS.ModalEnabled = false
	end)
end

editButton.MouseButton1Click:Connect(function()
	editMode = true
	editButton.Visible = false
	addButton.Visible = true
	deleteButton.Visible = true
	exitButton.Visible = true
	toggleButton.Visible = false
	sliderFrame.Visible = false
	freeBlockButton.Visible = false
	refreshKeyframes()
end)

exitButton.MouseButton1Click:Connect(function()
	editMode = false
	editButton.Visible = true
	addButton.Visible = false
	deleteButton.Visible = false
	exitButton.Visible = false
	toggleButton.Visible = true
	sliderFrame.Visible = true
	freeBlockButton.Visible = true
	clearSelection()
	refreshKeyframes()
end)

addButton.MouseButton1Click:Connect(function()
	local c = player.Character
	if not c then return end
	local r = c:FindFirstChild("HumanoidRootPart")
	if not r then return end

	local p = Instance.new("Part")
	p.Name = "Keyframe"
	p.Size = Vector3.new(4,4,4)
	p.Color = Color3.fromRGB(255,0,0)
	p.Anchored = true
	p.CanCollide = false
	p.Parent = workspace
	p:SetAttribute("Offset",Vector3.new(0,0,-8))
	table.insert(keyframes,p)
	selectKeyframe(p)
	refreshKeyframes()
end)

deleteButton.MouseButton1Click:Connect(function()
	if selectedKeyframe then
		for i,v in pairs(keyframes) do
			if v == selectedKeyframe then table.remove(keyframes,i) end
		end
		selectedKeyframe:Destroy()
		selectedKeyframe = nil
		clearSelection()
	end
end)

playButton.MouseButton1Click:Connect(function()
	playing = not playing
	playButton.Text = playing and "Stop Animation" or "Play Unanchor Animation"

	playCharAnim(playing)

	if animationThread then task.cancel(animationThread) end
	if not playing then return end

	animationThread = task.spawn(function()
		local frameIndex = 1

		while playing do
			if #keyframes == 0 then return end

			local moving = {}

			for _,obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("Part") and obj.Name == "Brick" and not obj.Anchored and not obj:IsDescendantOf(player.Character) then

					local targetKF

					if freeBlockMovement then
						targetKF = math.random(1,#keyframes)
					elseif separatedBricks then
						local h = hashObj(obj)
						targetKF = (h % #keyframes) + 1
					else
						targetKF = frameIndex
					end

					obj.CanCollide = false

					table.insert(moving,{
						part = obj,
						start = obj.Position,
						kf = targetKF
					})
				end
			end

			local duration = 1.2 / speedMultiplier
			local startTime = tick()

			while tick()-startTime < duration and playing do
				local alpha = math.clamp((tick()-startTime)/duration,0,1)
				alpha = alpha*alpha*(3-2*alpha)

				for _,d in pairs(moving) do
					local obj = d.part
					local kf = keyframes[d.kf]
					if obj and obj.Parent and kf then
						if followsPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
							local hrp = player.Character.HumanoidRootPart
							local offset = kf:GetAttribute("Offset") or Vector3.zero
							kf.Position = hrp.Position + offset
						end

						local targetPos = d.start:Lerp(kf.Position,alpha)
						obj.AssemblyLinearVelocity = (targetPos-obj.Position)*8*speedMultiplier
					end
				end

				RunService.Heartbeat:Wait()
			end

			frameIndex += 1
			if frameIndex > #keyframes then
				frameIndex = 1
			end

			task.wait(0.05)
		end
	end)
end)

mouse.Button1Down:Connect(function()
	if not equipped or not editMode then return end
	local t = mouse.Target
	if t and t.Name=="Keyframe" then selectKeyframe(t) end
end)

UIS.TouchTap:Connect(function()
	if not equipped or not editMode then return end
	local t = mouse.Target
	if t and t.Name=="Keyframe" then selectKeyframe(t) end
end)

RunService.RenderStepped:Connect(function()
	local c = player.Character
	if not c then return end
	local r = c:FindFirstChild("HumanoidRootPart")
	if not r then return end
	for _,v in pairs(keyframes) do
		if v and v.Parent then
			if followsPlayer then
				v.Position = r.Position + (v:GetAttribute("Offset") or Vector3.zero)
			end
		end
	end
end)

Tool.Equipped:Connect(function()
	equipped = true
	g1.Visible = true
	refreshKeyframes()
end)

Tool.Unequipped:Connect(function()
	equipped = false
	editMode = false
	g1.Visible = false
	editButton.Visible = true
	addButton.Visible = false
	deleteButton.Visible = false
	exitButton.Visible = false
	clearSelection()
	refreshKeyframes()
end)
	end
})

Extras:AddButton({
	Name = "Legacy service 2",
	Info = "A complement for Legacy Service[this will get deleted soon, all his content will be stay in Legacy Service",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/system7372772-art/FUMAZDEVHUB/refs/heads/main/LEGACY%202"))()
	end
})

CM67:AddButton({
	Name = "Crash Machine with bkit",
	Info = "Crash machine using bkit",
	Callback = function()
		local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

_G.Bkit_Stop = false
_G.Bkit_SelectedBrick = nil
_G.Bkit_Confirmed = false

local lastPosition = nil

local function notify(title, desc)
	local n = Instance.new("ScreenGui")
	n.ResetOnSpawn = false
	n.Parent = safeWait(player, "PlayerGui", 15)

	local f = Instance.new("Frame")
	f.Size = UDim2.new(0,280,0,90)
	f.Position = UDim2.new(0.5,-140,0.18,0)
	f.BackgroundColor3 = Color3.fromRGB(20,20,20)
	f.BorderSizePixel = 0
	f.Parent = n

	local fc = Instance.new("UICorner")
	fc.CornerRadius = UDim.new(0,6)
	fc.Parent = f

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.new(0,0,0)
	stroke.Transparency = 0.4
	stroke.Parent = f

	local topBar = Instance.new("Frame")
	topBar.Size = UDim2.new(1,0,0,28)
	topBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
	topBar.BorderSizePixel = 0
	topBar.Parent = f

	local tc = Instance.new("UICorner")
	tc.CornerRadius = UDim.new(0,6)
	tc.Parent = topBar

	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1,-20,1,0)
	t.Position = UDim2.new(0,10,0,0)
	t.BackgroundTransparency = 1
	t.Text = title
	t.TextColor3 = Color3.new(1,1,1)
	t.Font = Enum.Font.Code
	t.TextSize = 14
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.Parent = topBar

	local d = Instance.new("TextLabel")
	d.Size = UDim2.new(1,-20,1,-28)
	d.Position = UDim2.new(0,10,0,28)
	d.BackgroundTransparency = 1
	d.Text = desc
	d.TextColor3 = Color3.fromRGB(180,180,180)
	d.Font = Enum.Font.Code
	d.TextSize = 13
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.TextWrapped = true
	d.Parent = f

	task.delay(2.5,function()
		n:Destroy()
	end)
end

local gui = Instance.new("ScreenGui")
gui.Parent = safeWait(player, "PlayerGui", 15)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,260,0,170)
frame.Position = UDim2.new(0.5,-130,0.7,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,10)
frameCorner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0,0,0)
stroke.Transparency = 0.4
stroke.Parent = frame

local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,30)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0,6)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "Bkit Method"
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.Code
title.TextSize = 15
title.Parent = header

local dragging = false
local dragInput
local dragStart
local startPos

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local body = Instance.new("Frame")
body.Size = UDim2.new(1,0,1,-30)
body.Position = UDim2.new(0,0,0,30)
body.BackgroundTransparency = 1
body.Parent = frame

local function button(text,y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-24,0,34)
	b.Position = UDim2.new(0,12,0,y)
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Code
	b.TextSize = 14
	b.Parent = body

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,6)
	c.Parent = b

	local s = Instance.new("UIStroke")
	s.Thickness = 1
	s.Color = Color3.new(0,0,0)
	s.Transparency = 0.4
	s.Parent = b

	return b
end

local selectBtn = button("Select",8)
local confirmBtn = button("Confirm",48)
local cancelBtn = button("Cancel",88)

local outline = Instance.new("SelectionBox")
outline.Color3 = Color3.fromRGB(0,255,0)
outline.LineThickness = 0.06
outline.Parent = workspace

local selecting = false

selectBtn.MouseButton1Click:Connect(function()
	selecting = true
end)

cancelBtn.MouseButton1Click:Connect(function()
	selecting = false
	_G.Bkit_SelectedBrick = nil
	_G.Bkit_Confirmed = false
	lastPosition = nil
	outline.Adornee = nil
end)

confirmBtn.MouseButton1Click:Connect(function()
	if _G.Bkit_SelectedBrick then
		_G.Bkit_Confirmed = true
		selecting = false
	end
end)

local function notifyError()
	notify("Error!","Only Unanchored Blocks can be used")
end

mouse.Button1Down:Connect(function()
	if not selecting then return end

	local target = mouse.Target

	if target and target:IsA("BasePart") and target.Name == "Brick" then
		if target.Anchored then
			notifyError()
			return
		end

		_G.Bkit_SelectedBrick = target
		lastPosition = target.Position
		outline.Adornee = target
	end
end)

local function getEvent()
	local character = player.Character or player.CharacterAdded:Wait()
	local build = character:WaitForChild("Build")
	local scriptFolder = build:WaitForChild("Script")
	return scriptFolder:WaitForChild("Event")
end

local buildEvent = getEvent()

player.CharacterAdded:Connect(function()
	buildEvent = getEvent()
end)

local function getClosestBrick(pos)
	local folder = workspace:FindFirstChild("Bricks")
	if not folder then return nil end

	local closest
	local dist = math.huge

	for _,playerFolder in ipairs(folder:GetChildren()) do
		for _,brick in ipairs(playerFolder:GetChildren()) do
			if brick:IsA("BasePart")
			and brick.Name == "Brick"
			and not brick.Anchored then

				local d = (brick.Position - pos).Magnitude

				if d < dist then
					dist = d
					closest = brick
				end
			end
		end
	end

	return closest
end

RunService.Heartbeat:Connect(function()
	if _G.Bkit_Stop then return end
	if not _G.Bkit_Confirmed then return end

	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")

	if not (hrp and buildEvent) then return end

	local target = _G.Bkit_SelectedBrick

	if target and target.Parent then
		target.CFrame = hrp.CFrame * CFrame.new(0,5,0)
	end

	if not (target and target.Parent) then
		if lastPosition then
			target = getClosestBrick(lastPosition)
			_G.Bkit_SelectedBrick = target
			outline.Adornee = target
		end
	end

	if target and target.Parent then
		lastPosition = target.Position

		buildEvent:FireServer(
			target,
			Enum.NormalId.Bottom,
			hrp.Position,
			"normal"
		)
	end
end)
	end
})

local WidthBox = Canvas:AddTextbox({
    Default = "50",
    Placeholder = "Width...",
    Info = "Canvas width"
})

local HeightBox = Canvas:AddTextbox({
    Default = "50",
    Placeholder = "Height...",
    Info = "Canvas height"
})

local buildMode = "SideToSide"
local rotationAxis = "Z"

Canvas:AddButton({
    Name = "Side to Side",
    Callback = function()
        buildMode = "SideToSide"
    end
})

Canvas:AddButton({
    Name = "Bottom to Top",
    Callback = function()
        buildMode = "BottomToTop"
    end
})

Canvas:AddButton({
    Name = "Rotate X 90°",
    Callback = function()
        rotationAxis = "X"
    end
})

Canvas:AddButton({
    Name = "Rotate Y 90°",
    Callback = function()
        rotationAxis = "Y"
    end
})

Canvas:AddButton({
    Name = "Rotate Z 90°",
    Callback = function()
        rotationAxis = "Z"
    end
})

local function StartCanvas()
    if _G.CanvaRunning then
        return
    end

    if _G.CanvaConnection then
        _G.CanvaConnection:Disconnect()
        _G.CanvaConnection = nil
    end

    local WIDTH = math.clamp(
        math.floor(tonumber(WidthBox:Get()) or 50),
        1,
        500
    )

    local HEIGHT = math.clamp(
        math.floor(tonumber(HeightBox:Get()) or 50),
        1,
        500
    )

    _G.CanvaRunning = true

    task.spawn(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")

        local tool = character:FindFirstChild("Build")
            or player.Backpack:FindFirstChild("Build")

        if not tool then
            _G.CanvaRunning = false
            return
        end

        tool.Parent = character

        task.wait(0.4)

        local event = tool:WaitForChild("Script"):WaitForChild("Event")
        local bricksFolder = workspace:WaitForChild("Bricks"):WaitForChild(player.Name)

        local GRID = 1
        local origin = hrp.Position

        local center = Vector3.new(
            origin.X,
            origin.Y + ((HEIGHT - 1) * GRID) / 2,
            origin.Z
        )

        local placed = {}

        local oldWalkSpeed = humanoid.WalkSpeed
        local oldJumpPower = humanoid.JumpPower
        local oldAutoRotate = humanoid.AutoRotate
        local oldPlatformStand = humanoid.PlatformStand

        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
        humanoid.AutoRotate = false
        humanoid.PlatformStand = true

        local stopped = false
        local blocksSinceScan = 0

        local function stop()
            if stopped then
                return
            end

            stopped = true
            _G.CanvaRunning = false

            humanoid.WalkSpeed = oldWalkSpeed
            humanoid.JumpPower = oldJumpPower
            humanoid.AutoRotate = oldAutoRotate
            humanoid.PlatformStand = oldPlatformStand

            if hrp.Parent then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end

            if _G.CanvaConnection then
                _G.CanvaConnection:Disconnect()
                _G.CanvaConnection = nil
            end
        end

        _G.CanvaConnection = RunService.Heartbeat:Connect(function()
            if not _G.CanvaRunning then
                stop()
                return
            end

            if hrp.Parent then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end)

        local function running()
            if not _G.CanvaRunning then
                stop()
                return false
            end

            return true
        end

        local function key(x,y)
            return x .. ":" .. y
        end

        local function getRotation()
            if rotationAxis == "X" then
                return CFrame.Angles(math.rad(90),0,0)
            elseif rotationAxis == "Y" then
                return CFrame.Angles(0,math.rad(90),0)
            end

            return CFrame.Angles(0,0,math.rad(90))
        end

        local rotation = getRotation()

        local function positionFor(x,y)
            local localX =
                (x - ((WIDTH - 1) / 2)) * GRID

            local localY =
                (y - ((HEIGHT - 1) / 2)) * GRID

            local offset = rotation * Vector3.new(
                localX,
                localY,
                0
            )

            return center + offset
        end

        local function scanBricks()
            table.clear(placed)

            for _,obj in ipairs(bricksFolder:GetChildren()) do
                if obj.Name == "Brick"
                and obj:IsA("BasePart") then

                    local relative = obj.Position - center

                    local localPosition =
                        rotation:Inverse() * relative

                    local px = math.round(
                        localPosition.X / GRID
                        + ((WIDTH - 1) / 2)
                    )

                    local py = math.round(
                        localPosition.Y / GRID
                        + ((HEIGHT - 1) / 2)
                    )

                    if px >= 0
                    and px < WIDTH
                    and py >= 0
                    and py < HEIGHT then

                        local expected = positionFor(px,py)

                        if (obj.Position - expected).Magnitude < 0.35 then
                            placed[key(px,py)] = true
                        end
                    end
                end
            end

            blocksSinceScan = 0
        end

        local function place(x,y)
            if not running() then
                return false
            end

            local k = key(x,y)

            if placed[k] then
                return true
            end

            local position = positionFor(x,y)

            hrp.CFrame = CFrame.new(
                position + Vector3.new(0,2,-3)
            )

            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero

            task.wait(0.08)

            if not running() then
                return false
            end

            event:FireServer(
                workspace.Terrain,
                Enum.NormalId.Top,
                position,
                "detail"
            )

            placed[k] = true
            blocksSinceScan += 1

            if blocksSinceScan >= 25 then
                task.wait(0.15)

                if not running() then
                    return false
                end

                scanBricks()
            end

            return true
        end

        scanBricks()

        local built = 0

        if buildMode == "SideToSide" then

            for y = 0,HEIGHT - 1 do
                if not running() then
                    break
                end

                local direction =
                    (y % 2 == 0) and 1 or -1

                if direction == 1 then

                    for x = 0,WIDTH - 1 do
                        if not running() then
                            break
                        end

                        if place(x,y) then
                            built += 1
                        end
                    end

                else

                    for x = WIDTH - 1,0,-1 do
                        if not running() then
                            break
                        end

                        if place(x,y) then
                            built += 1
                        end
                    end
                end

                task.wait(0.15)
            end

        else

            for x = 0,WIDTH - 1 do
                if not running() then
                    break
                end

                local direction =
                    (x % 2 == 0) and 1 or -1

                if direction == 1 then

                    for y = 0,HEIGHT - 1 do
                        if not running() then
                            break
                        end

                        if place(x,y) then
                            built += 1
                        end
                    end

                else

                    for y = HEIGHT - 1,0,-1 do
                        if not running() then
                            break
                        end

                        if place(x,y) then
                            built += 1
                        end
                    end
                end

                task.wait(0.15)
            end
        end

        if running() then
            scanBricks()

            for cycle = 1,3 do
                if not running() then
                    break
                end

                local missing = {}

                for y = 0,HEIGHT - 1 do
                    for x = 0,WIDTH - 1 do
                        if not placed[key(x,y)] then
                            missing[#missing + 1] = {
                                x = x,
                                y = y
                            }
                        end
                    end
                end

                if #missing == 0 then
                    break
                end

                for _,block in ipairs(missing) do
                    if not running() then
                        break
                    end

                    place(
                        block.x,
                        block.y
                    )
                end

                task.wait(0.25)

                if running() then
                    scanBricks()
                end
            end
        end

        stop()
    end)
end

Canvas:AddButton({
    Name = "Start Canvas",
    Info = "Start building the canvas",
    Callback = function()
        StartCanvas()
    end
})

Canvas:AddButton({
    Name = "Stop Canvas",
    Info = "Stop building the canvas",
    Callback = function()
        _G.CanvaRunning = false

        if _G.CanvaConnection then
            _G.CanvaConnection:Disconnect()
            _G.CanvaConnection = nil
        end
    end
})

return Library
