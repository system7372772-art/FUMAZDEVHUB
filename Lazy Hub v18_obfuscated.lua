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
gui:SetAttribute("LegacySkin", true)
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
	Background = Color3.fromRGB(28,28,31),
	Secondary = Color3.fromRGB(34,34,37),
	Element = Color3.fromRGB(50,50,54),
	Border = Color3.fromRGB(70,66,64),
	Text = Color3.fromRGB(242,236,226),
	SubText = Color3.fromRGB(172,164,155),
	Accent = Color3.fromRGB(176,112,84),
	ToggleOff = Color3.fromRGB(58,58,62),
	AccentHover = Color3.fromRGB(204,136,100),
	GroupBackground = Color3.fromRGB(24,24,27)
}

Library.Settings = {
	Blur = true,
	BlurSize = 8,
	Transparency = 0.04,
	CornerRadius = 14,
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
	s.Color = Color3.fromRGB(255,255,255)
	s.Thickness = (thickness or 1) + 1
	s.Transparency = 0
	s.Parent = obj

	local metal = Instance.new("UIGradient")
	metal.Rotation = 90
	metal.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(84,80,78)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(26,26,29)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(4,4,6))
	})
	metal.Parent = s

	return s
end

local function surfaceGradient(obj)
	local g = Instance.new("UIGradient")
	g.Rotation = 90
	g.Color = ColorSequence.new(Color3.fromRGB(255,255,255), Color3.fromRGB(138,138,146))
	g.Parent = obj
	return g
end

local function innerBevel(obj)
	local rim = Instance.new("Frame")
	rim.Name = "Bevel"
	rim.BackgroundTransparency = 1
	rim.BorderSizePixel = 0
	rim.Active = false
	rim.Size = UDim2.new(1,-6,1,-6)
	rim.Position = UDim2.new(0,3,0,3)
	rim.ZIndex = obj.ZIndex
	rim.Parent = obj

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,7)
	c.Parent = rim

	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(255,255,255)
	s.Thickness = 1
	s.Transparency = 0.45
	s.Parent = rim

	local g = Instance.new("UIGradient")
	g.Rotation = 90
	g.Color = ColorSequence.new(Color3.fromRGB(92,88,86), Color3.fromRGB(10,10,12))
	g.Parent = s
	return rim
end

local function sinkApply(obj, sunk, speed)
	speed = speed or 0.08
	local depth = obj:GetAttribute("SinkDepth") or 3

	local padding = obj:FindFirstChild("SinkPad")
	if not padding then
		padding = Instance.new("UIPadding")
		padding.Name = "SinkPad"
		padding.Parent = obj
	end
	Anim(padding,{PaddingTop = UDim.new(0, sunk and depth or 0)},speed)

	local grad = obj:FindFirstChildOfClass("UIGradient")
	if grad then
		Anim(grad,{Rotation = sunk and 270 or 90},speed)
	end

	local outline = obj:FindFirstChildOfClass("UIStroke")
	local outlineGrad = outline and outline:FindFirstChildOfClass("UIGradient")
	if outlineGrad then
		Anim(outlineGrad,{Rotation = sunk and 270 or 90},speed)
	end

	local bevel = obj:FindFirstChild("Bevel")
	local bevelStroke = bevel and bevel:FindFirstChildOfClass("UIStroke")
	local bevelGrad = bevelStroke and bevelStroke:FindFirstChildOfClass("UIGradient")
	if bevelGrad then
		Anim(bevelGrad,{Rotation = sunk and 270 or 90},speed)
	end
end

local function sinkPress(obj, pressed, speed)
	sinkApply(obj, pressed or obj:GetAttribute("Sunk") == true, speed)
end

local function setSunk(obj, sunk, speed, depth)
	if depth then
		obj:SetAttribute("SinkDepth", depth)
	end
	obj:SetAttribute("Sunk", sunk)
	sinkApply(obj, sunk, speed)
end

local function buttonAnimation(button, normalColor, hoverColor)
	local pressedAt = 0
	button:SetAttribute("SinkDepth", 4)

	local function releaseSink()
		local stamp = pressedAt
		task.delay(math.max(0, 0.14 - (tick() - pressedAt)), function()
			if pressedAt == stamp then
				sinkPress(button,false,0.14)
			end
		end)
	end

	button.MouseEnter:Connect(function()
		Anim(button,{
			Size = UDim2.new(1,0,0,35)
		},0.12)
	end)

	button.MouseLeave:Connect(function()
		releaseSink()
		Anim(button,{
			Size = UDim2.new(1,0,0,34)
		},0.14)
	end)

	button.MouseButton1Down:Connect(function()
		pressedAt = tick()
		sinkPress(button,true,0.05)
		Anim(button,{
			Size = UDim2.new(1,-4,0,32)
		},0.07)
	end)

	button.MouseButton1Up:Connect(function()
		releaseSink()
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
	stroke(main,Library.Theme.Border,2)
	surfaceGradient(main)

	Window.Main = main

	local top = Instance.new("Frame")
	top.Name = "TopBar"
	top.Size = UDim2.new(1,0,0,42)
	top.BackgroundColor3 = Library.Theme.Secondary
	top.BorderSizePixel = 0
	top.Parent = main

	corner(top)
	surfaceGradient(top)

	local topFix = Instance.new("Frame")
	topFix.Size = UDim2.new(1,0,0,12)
	topFix.Position = UDim2.new(0,0,1,-12)
	topFix.BackgroundColor3 = Library.Theme.Secondary
	topFix.BorderSizePixel = 0
	topFix.Parent = top

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,1,0)
	title.Position = UDim2.new(0,0,0,0)
	title.BackgroundTransparency = 1
	title.Text = options.Title or options.Name or "Library"
	title.TextColor3 = Library.Theme.Text
	title.TextSize = 17
	title.Font = Enum.Font.Garamond
	title.TextXAlignment = Enum.TextXAlignment.Center
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

	corner(tooltip,10)
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
	toggleButton.Font = Enum.Font.Garamond
	toggleButton.AutoButtonColor = false
	toggleButton.BorderSizePixel = 0
	toggleButton.Parent = gui

	corner(toggleButton,12)
	stroke(toggleButton,Library.Theme.Border,1)
	surfaceGradient(toggleButton)
	innerBevel(toggleButton)

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
		tabButton.TextSize = 14
		tabButton.Font = Enum.Font.Garamond
		tabButton.AutoButtonColor = false
		tabButton.BorderSizePixel = 0
		tabButton.Parent = tabs

		corner(tabButton,10)
		stroke(tabButton,Library.Theme.Border,0)
		surfaceGradient(tabButton)

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
			sinkPress(tabButton,true,0.06)
			Anim(tabButton,{
				Size = UDim2.new(1,-6,0,32)
			},0.07)
		end)

		tabButton.MouseButton1Up:Connect(function()
			sinkPress(tabButton,false,0.12)
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
			nameLabel.TextSize = 16
			nameLabel.Font = Enum.Font.Garamond
			nameLabel.TextXAlignment = Enum.TextXAlignment.Left
			nameLabel.Parent = section

			local info = Instance.new("TextLabel")
			info.Size = UDim2.new(1,0,0,18)
			info.Position = UDim2.new(0,0,0,20)
			info.BackgroundTransparency = 1
			info.Text = config.Info or ""
			info.TextColor3 = Library.Theme.SubText
			info.TextSize = 12
			info.Font = Enum.Font.Garamond
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
			label.TextSize = 14
			label.Font = Enum.Font.Garamond
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
			button.TextSize = 14
			button.Font = Enum.Font.Garamond
			button.AutoButtonColor = false
			button.BorderSizePixel = 0
			button.Parent = column

			corner(button,10)
			stroke(button,Library.Theme.Border,1)
			surfaceGradient(button)
			innerBevel(button)

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

			corner(holder,10)
			stroke(holder,Library.Theme.Border,1)
			surfaceGradient(holder)
			innerBevel(holder)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1,-55,1,0)
			label.Position = UDim2.new(0,10,0,0)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Toggle"
			label.TextColor3 = Library.Theme.Text
			label.TextSize = 14
			label.Font = Enum.Font.Garamond
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
			surfaceGradient(toggle)

			local knob = Instance.new("Frame")
			knob.Size = UDim2.new(0,16,0,16)
			knob.Position = UDim2.new(0,2,0.5,-8)
			knob.BackgroundColor3 = Library.Theme.SubText
			knob.BorderSizePixel = 0
			knob.Parent = toggle

			corner(knob,8)
			surfaceGradient(knob)

			local state = config.Default == true

			local function update(value,callback)
				state = value
				setSunk(toggle,state,0.12,1)
				if callback then
					sinkPress(holder,true,0.05)
					task.delay(0.1,function()
						sinkPress(holder,false,0.14)
					end)
				end

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

			corner(holder,10)
			stroke(holder,Library.Theme.Border,1)
			surfaceGradient(holder)
			innerBevel(holder)

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(1,-12,1,-10)
			box.Position = UDim2.new(0,6,0,5)
			box.BackgroundColor3 = Library.Theme.Secondary
			box.BorderSizePixel = 0
			box.Text = config.Default or ""
			box.PlaceholderText = config.Placeholder or "Text..."
			box.PlaceholderColor3 = Library.Theme.SubText
			box.TextColor3 = Library.Theme.Text
			box.TextSize = 14
			box.Font = Enum.Font.Garamond
			box.ClearTextOnFocus = false
			box.Parent = holder

			corner(box,8)
			stroke(box,Library.Theme.Border,1)
			surfaceGradient(box)
			innerBevel(box)

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

			corner(holder,10)
			stroke(holder,Library.Theme.Border,1)
			surfaceGradient(holder)
			innerBevel(holder)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1,-55,0,20)
			label.Position = UDim2.new(0,8,0,3)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Slider"
			label.TextColor3 = Library.Theme.Text
			label.TextSize = 13
			label.Font = Enum.Font.Garamond
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = holder

			local valueLabel = Instance.new("TextLabel")
			valueLabel.Size = UDim2.new(0,45,0,20)
			valueLabel.Position = UDim2.new(1,-51,0,3)
			valueLabel.BackgroundTransparency = 1
			valueLabel.TextColor3 = Library.Theme.SubText
			valueLabel.TextSize = 13
			valueLabel.Font = Enum.Font.Garamond
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right
			valueLabel.Parent = holder

			local bar = Instance.new("Frame")
			bar.Size = UDim2.new(1,-16,0,5)
			bar.Position = UDim2.new(0,8,0,32)
			bar.BackgroundColor3 = Library.Theme.ToggleOff
			bar.BorderSizePixel = 0
			bar.Parent = holder

			corner(bar,3)
			surfaceGradient(bar)

			local fill = Instance.new("Frame")
			fill.Size = UDim2.new(0,0,1,0)
			fill.BackgroundColor3 = Library.Theme.Accent
			fill.BorderSizePixel = 0
			fill.Parent = bar

			corner(fill,3)
			surfaceGradient(fill)

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

			corner(group,12)
			stroke(group,Library.Theme.Border,1)
			surfaceGradient(group)

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
				groupTitle.TextSize = 15
				groupTitle.Font = Enum.Font.Garamond
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
					groupInfo.TextSize = 11
					groupInfo.Font = Enum.Font.Garamond
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
				button.TextSize = 14
				button.Font = Enum.Font.Garamond
				button.AutoButtonColor = false
				button.BorderSizePixel = 0
				button.Parent = group

				corner(button,10)
				stroke(button,Library.Theme.Border,1)
				surfaceGradient(button)
				innerBevel(button)

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
				label.TextSize = 13
				label.Font = Enum.Font.Garamond
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
				section.TextSize = 13
				section.Font = Enum.Font.Garamond
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

				corner(holder,10)
				stroke(holder,Library.Theme.Border,1)
				surfaceGradient(holder)
				innerBevel(holder)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1,-55,1,0)
				label.Position = UDim2.new(0,10,0,0)
				label.BackgroundTransparency = 1
				label.Text = toggleConfig.Name or "Toggle"
				label.TextColor3 = Library.Theme.Text
				label.TextSize = 14
				label.Font = Enum.Font.Garamond
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
				surfaceGradient(toggle)

				local knob = Instance.new("Frame")
				knob.Size = UDim2.new(0,16,0,16)
				knob.Position = UDim2.new(0,2,0.5,-8)
				knob.BackgroundColor3 = Library.Theme.SubText
				knob.BorderSizePixel = 0
				knob.Parent = toggle

				corner(knob,8)
				surfaceGradient(knob)

				local state = toggleConfig.Default == true

				local function update(value,callback)
					state = value
					setSunk(toggle,state,0.12,1)
					if callback then
						sinkPress(holder,true,0.05)
						task.delay(0.1,function()
							sinkPress(holder,false,0.14)
						end)
					end

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

				corner(holder,10)
				stroke(holder,Library.Theme.Border,1)
				surfaceGradient(holder)
				innerBevel(holder)

				local box = Instance.new("TextBox")
				box.Size = UDim2.new(1,-12,1,-10)
				box.Position = UDim2.new(0,6,0,5)
				box.BackgroundColor3 = Library.Theme.Secondary
				box.BorderSizePixel = 0
				box.Text = textboxConfig.Default or ""
				box.PlaceholderText = textboxConfig.Placeholder or "Text..."
				box.PlaceholderColor3 = Library.Theme.SubText
				box.TextColor3 = Library.Theme.Text
				box.TextSize = 14
				box.Font = Enum.Font.Garamond
				box.ClearTextOnFocus = false
				box.Parent = holder

				corner(box,8)
				stroke(box,Library.Theme.Border,1)
				surfaceGradient(box)
				innerBevel(box)

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

				corner(holder,10)
				stroke(holder,Library.Theme.Border,1)
				surfaceGradient(holder)
				innerBevel(holder)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1,-55,0,20)
				label.Position = UDim2.new(0,8,0,3)
				label.BackgroundTransparency = 1
				label.Text = sliderConfig.Name or "Slider"
				label.TextColor3 = Library.Theme.Text
				label.TextSize = 13
				label.Font = Enum.Font.Garamond
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = holder

				local valueLabel = Instance.new("TextLabel")
				valueLabel.Size = UDim2.new(0,45,0,20)
				valueLabel.Position = UDim2.new(1,-51,0,3)
				valueLabel.BackgroundTransparency = 1
				valueLabel.TextColor3 = Library.Theme.SubText
				valueLabel.TextSize = 13
				valueLabel.Font = Enum.Font.Garamond
				valueLabel.TextXAlignment = Enum.TextXAlignment.Right
				valueLabel.Parent = holder

				local bar = Instance.new("Frame")
				bar.Size = UDim2.new(1,-16,0,5)
				bar.Position = UDim2.new(0,8,0,32)
				bar.BackgroundColor3 = Library.Theme.ToggleOff
				bar.BorderSizePixel = 0
				bar.Parent = holder

				corner(bar,3)
				surfaceGradient(bar)

				local fill = Instance.new("Frame")
				fill.Size = UDim2.new(0,0,1,0)
				fill.BackgroundColor3 = Library.Theme.Accent
				fill.BorderSizePixel = 0
				fill.Parent = bar

				corner(fill,3)
				surfaceGradient(fill)

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
				setSunk(other.Button,false,0.14)

				Anim(other.Button,{
					BackgroundTransparency = 1,
					TextColor3 = Library.Theme.SubText,
					Size = UDim2.new(1,0,0,34)
				},0.14)
			end

			page.Visible = true
			setSunk(tabButton,true,0.12)

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

	Library._window = Window
	return Window
end

Library._style = {
	stroke = stroke,
	surfaceGradient = surfaceGradient,
	innerBevel = innerBevel,
	sinkPress = sinkPress,
	setSunk = setSunk
}

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
gui:SetAttribute("LegacySkin", true)
gui.Name = "PerfGui"
gui:SetAttribute("LegacySkin", nil)
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
adminGui:SetAttribute("LegacySkin", true)
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

local function buildNameCard(head, name, title, subtitle, accent, height)
	local TweenService = game:GetService("TweenService")

	local gui = Instance.new("BillboardGui")
	gui.Name = name
	gui.Adornee = head
	gui.Size = UDim2.fromOffset(224, 64)
	gui.StudsOffset = Vector3.new(0, height or 3.2, 0)
	gui.AlwaysOnTop = false
	gui.MaxDistance = 650
	gui.ResetOnSpawn = false

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.Size = UDim2.fromScale(1, 1)
	card.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
	card.BackgroundTransparency = 0.03
	card.BorderSizePixel = 0
	card.Parent = gui

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 14)
	cardCorner.Parent = card

	local surface = Instance.new("UIGradient")
	surface.Rotation = 90
	surface.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 158))
	surface.Parent = card

	local rim = Instance.new("UIStroke")
	rim.Color = Color3.fromRGB(255, 255, 255)
	rim.Thickness = 2
	rim.Transparency = 0.1
	rim.Parent = card

	local rimGradient = Instance.new("UIGradient")
	rimGradient.Rotation = 45
	rimGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, accent),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(46, 36, 34)),
		ColorSequenceKeypoint.new(1, Color3.new(accent.R * 0.7, accent.G * 0.7, accent.B * 0.7))
	})
	rimGradient.Parent = rim

	TweenService:Create(
		rim,
		TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		{Transparency = 0.6}
	):Play()

	local emblem = Instance.new("Frame")
	emblem.Position = UDim2.fromOffset(10, 13)
	emblem.Size = UDim2.fromOffset(38, 38)
	emblem.BackgroundColor3 = accent
	emblem.BorderSizePixel = 0
	emblem.Parent = card

	local emblemCorner = Instance.new("UICorner")
	emblemCorner.CornerRadius = UDim.new(1, 0)
	emblemCorner.Parent = emblem

	local emblemGradient = Instance.new("UIGradient")
	emblemGradient.Rotation = 90
	emblemGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(140, 110, 100))
	emblemGradient.Parent = emblem

	local emblemStroke = Instance.new("UIStroke")
	emblemStroke.Color = Color3.fromRGB(12, 12, 14)
	emblemStroke.Thickness = 2
	emblemStroke.Parent = emblem

	local letter = Instance.new("TextLabel")
	letter.BackgroundTransparency = 1
	letter.Size = UDim2.fromScale(1, 1)
	letter.Font = Enum.Font.Garamond
	letter.TextSize = 28
	letter.TextColor3 = Color3.fromRGB(255, 247, 237)
	letter.TextStrokeTransparency = 0.6
	letter.TextStrokeColor3 = Color3.fromRGB(40, 20, 12)
	letter.Text = "L"
	letter.Parent = emblem

	local titleLabel = Instance.new("TextLabel")
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.fromOffset(58, 9)
	titleLabel.Size = UDim2.new(1, -66, 0, 22)
	titleLabel.Font = Enum.Font.Garamond
	titleLabel.TextScaled = true
	titleLabel.TextColor3 = Color3.fromRGB(242, 236, 226)
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextStrokeTransparency = 0.7
	titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	titleLabel.Text = title
	titleLabel.Parent = card

	local titleLimit = Instance.new("UITextSizeConstraint")
	titleLimit.MaxTextSize = 19
	titleLimit.MinTextSize = 10
	titleLimit.Parent = titleLabel

	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Position = UDim2.fromOffset(58, 32)
	subtitleLabel.Size = UDim2.new(1, -66, 0, 14)
	subtitleLabel.Font = Enum.Font.Garamond
	subtitleLabel.TextSize = 14
	subtitleLabel.TextColor3 = Color3.fromRGB(172, 164, 155)
	subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	subtitleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	subtitleLabel.TextStrokeTransparency = 0.7
	subtitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	subtitleLabel.Text = subtitle
	subtitleLabel.Parent = card

	local line = Instance.new("Frame")
	line.Position = UDim2.fromOffset(58, 51)
	line.Size = UDim2.fromOffset(46, 3)
	line.BackgroundColor3 = accent
	line.BorderSizePixel = 0
	line.Parent = card

	local lineCorner = Instance.new("UICorner")
	lineCorner.CornerRadius = UDim.new(1, 0)
	lineCorner.Parent = line

	gui.Parent = head

	if Library._onNewGui then
		pcall(Library._onNewGui, gui)
	end

	return gui
end

Library._card = buildNameCard

Library._fixedRole = function(player)
	if player.UserId == OWNER_USER_ID then
		return "Legacy Service Owner", Color3.fromRGB(232,190,92)
	end

	if table.find(TESTER_USER_IDS,player.UserId) then
		return "Legacy Service Tester", Color3.fromRGB(90,200,210)
	end

	if player.UserId == COLLABORATOR_USER_ID then
		return "Colaborator??", Color3.fromRGB(170,110,230)
	end

	return nil
end

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
local Settings = Window:AddTab("⚙️Settings")

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

local Building67 = NS:AddGroup({
    Name = "Building🏗",
    Info = "Building🏗",
    Side = "Left"
})

local Gears67 = NS:AddGroup({
	Name = "Gears🚧",
	Info = "Gears🚧",
	Side = "Left"
})

local Utils67 = NS:AddGroup({
	Name = "Utils⛏️",
	Info = "Utilidades⛏️",
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

local Themes67 = Settings:AddGroup({
	Name = "Themes📚",
	Info = "Themes📚",
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
gui:SetAttribute("LegacySkin", true)
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
gui:SetAttribute("LegacySkin", true)
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
	gui:SetAttribute("LegacySkin", true)
	gui.Name = "MiniPalette230"
	gui:SetAttribute("LegacySkin", nil)
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
screenGui:SetAttribute("LegacySkin", true)
screenGui.Name = "MaterialGui"
screenGui:SetAttribute("LegacySkin", nil)
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
gui:SetAttribute("LegacySkin", true)
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
gui:SetAttribute("LegacySkin", true)
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
sui:SetAttribute("LegacySkin", true)
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
gui:SetAttribute("LegacySkin", true)
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
gui:SetAttribute("LegacySkin", true)
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

local sliderActive = false

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
	frame.Size = UDim2.new(0,210,0,256)
	frame.Position = pos
	frame.BackgroundColor3 = Color3.fromRGB(28,28,31)
	frame.BackgroundTransparency = 0.05
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,12)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(30,30,33)
	stroke.Thickness = 2
	stroke.Parent = frame

	makeDraggable(frame)
	return frame
end

local function createButton(text,pos,parent)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,180,0,34)
	b.Position = pos
	b.BackgroundColor3 = Color3.fromRGB(50,50,54)
	b.BackgroundTransparency = 0.1
	b.Text = text
	b.TextScaled = true
	b.TextColor3 = Color3.fromRGB(242,236,226)
	b.Font = Enum.Font.Garamond
	b.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = b

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(30,30,33)
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

local editButton = createButton("Edit",UDim2.new(0.5,-90,0,12),g1)

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0,180,0,18)
sliderFrame.Position = UDim2.new(0.5,-90,0,56)
sliderFrame.BackgroundColor3 = Color3.fromRGB(58,58,62)
sliderFrame.BackgroundTransparency = 0
sliderFrame.BorderSizePixel = 0
sliderFrame.Parent = g1

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0,8)
sliderCorner.Parent = sliderFrame

local sliderKnob = Instance.new("Frame")
sliderKnob.Size = UDim2.new(0,18,0,18)
sliderKnob.Position = UDim2.new(0.0526,-9,0,0)
sliderKnob.BackgroundColor3 = Color3.fromRGB(242,236,226)
sliderKnob.BorderSizePixel = 0
sliderKnob.Parent = sliderFrame

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1,0)
knobCorner.Parent = sliderKnob

local toggleButton = createButton("Separated Bricks: OFF",UDim2.new(0.5,-90,0,88),g1)
local freeBlockButton = createButton("Free Block Movement: OFF",UDim2.new(0.5,-90,0,126),g1)

local addButton = createButton("Add keyframe",UDim2.new(0.5,-90,0,12),g1)
addButton.Visible = false

local deleteButton = createButton("Delete keyframe",UDim2.new(0.5,-90,0,52),g1)
deleteButton.Visible = false

local exitButton = createButton("Exit Edit Mode",UDim2.new(0.5,-90,0,92),g1)
exitButton.Visible = false

local followsButton = createButton("Follows Player: ON",UDim2.new(0.5,-90,0,202),g1)

local playButton = createButton("Play Unanchor Animation",UDim2.new(0.5,-90,0,164),g1)

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
	n:SetAttribute("LegacySkin", true)
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
gui:SetAttribute("LegacySkin", true)
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

local ChunksToggle = Canvas:AddToggle({
    Name = "Chunks",
    Info = "Build the canvas in square chunks that adapt to the width and height",
    Default = false
})

local FastToggle = Canvas:AddToggle({
    Name = "Fast Mode",
    Info = "Always looks for the fastest route: stands in the middle of reach sized tiles and places every brick of the tile from one spot, shrinking the tiles on its own if bricks are missing. Works with or without Chunks",
    Default = false
})

local CP = {
    bricks = {},
    painted = {},
    count = 0,
    pixels = nil,
    jw = 0,
    jh = 0,
    jsonText = nil,
    W = 0,
    H = 0,
    axis = "Z",
    mirror = false,
    conn = nil,
    painting = false
}
_G.CanvasPaint = CP

local PixelJson = Canvas:AddTextbox({
    Placeholder = "JSON here",
    Info = "Paste the JSON code from the pixel art website here"
})

Canvas:AddButton({
    Name = "Clear Json",
    Info = "Clears the JSON textbox",
    Callback = function()
        PixelJson:Set("")
    end
})

local PaintStatus = Canvas:AddLabel("Paint: no saved canvas")

CP.raw = {}
CP.tries = {}
CP.list = {}
CP.index = 0

function CP.tag()
    return "Canvas " .. CP.index .. "/" .. #CP.list .. " - "
end

function CP.snapshot()
    if CP.index == 0 then
        return
    end

    CP.list[CP.index] = {
        bricks = CP.bricks,
        raw = CP.raw,
        painted = CP.painted,
        count = CP.count,
        session = CP.session,
        folder = CP.folder,
        imported = CP.imported,
        W = CP.W,
        H = CP.H,
        axis = CP.axis,
        center = CP.center,
        rotation = CP.rotation,
        jsonText = CP.jsonText,
        pixels = CP.pixels,
        jw = CP.jw,
        jh = CP.jh,
        frames = CP.frames,
        frame = CP.frame,
        fps = CP.fps
    }
end

function CP.load(i)
    local c = CP.list[i]

    CP.index = i
    CP.bricks = c.bricks
    CP.raw = c.raw
    CP.painted = c.painted
    CP.count = c.count
    CP.session = c.session
    CP.folder = c.folder
    CP.imported = c.imported
    CP.W, CP.H, CP.axis = c.W, c.H, c.axis
    CP.center, CP.rotation = c.center, c.rotation
    CP.jsonText = c.jsonText
    CP.pixels, CP.jw, CP.jh = c.pixels, c.jw, c.jh
    CP.frames, CP.frame, CP.fps = c.frames, c.frame, c.fps
end

function CP.save(px, py, obj)
    CP.raw[obj] = true
end

function CP.rescan()
    if not (CP.center and CP.rotation) then
        return
    end

    local lp = game:GetService("Players").LocalPlayer
    local root = workspace:FindFirstChild("Bricks")
    local folder = CP.folder or (root and root:FindFirstChild(lp.Name))

    if not folder then
        PaintStatus:Set("workspace.Bricks." .. lp.Name .. " not found")
        return
    end

    local inv = CP.rotation:Inverse()
    local pts = {}
    local total = 0

    for _, obj in ipairs(folder:GetDescendants()) do
        if obj:IsA("BasePart") then
            total += 1
            local rel = inv * (obj.Position - CP.center)

            if math.abs(rel.X) <= CP.W / 2 + 2 and math.abs(rel.Y) <= CP.H / 2 + 2 then
                local sz = obj.Size
                local unit = sz.X > 0.9 and sz.X < 1.1 and sz.Y > 0.9 and sz.Y < 1.1 and sz.Z > 0.9 and sz.Z < 1.1
                pts[#pts + 1] = {obj = obj, x = rel.X, y = rel.Y, z = rel.Z, unit = unit}
            end
        end
    end

    local units = {}

    for _, p in ipairs(pts) do
        if p.unit then
            units[#units + 1] = p
        end
    end

    if #units > 0 then
        pts = units
    end

    local zs = {}

    for _, p in ipairs(pts) do
        if CP.raw[p.obj] then
            zs[#zs + 1] = p.z
        end
    end

    if #zs == 0 then
        for _, p in ipairs(pts) do
            zs[#zs + 1] = p.z
        end
    end

    if #zs == 0 then
        CP.bricks = {}
        CP.count = 0
        PaintStatus:Set(CP.tag() .. "Saved bricks: 0 (folder: " .. total .. ")")
        return
    end

    table.sort(zs)
    local zRef = zs[math.ceil(#zs / 2)]

    local plane = {}

    for _, p in ipairs(pts) do
        if math.abs(p.z - zRef) <= 0.6 then
            plane[#plane + 1] = p
        end
    end

    local ax, ay = math.huge, math.huge
    local anyRaw = false

    for _, p in ipairs(plane) do
        if CP.raw[p.obj] then
            anyRaw = true
            ax = math.min(ax, p.x)
            ay = math.min(ay, p.y)
        end
    end

    if not anyRaw then
        for _, p in ipairs(plane) do
            ax = math.min(ax, p.x)
            ay = math.min(ay, p.y)
        end
    end

    if CP.imported then
        ax = -(CP.W - 1) / 2
        ay = -(CP.H - 1) / 2
    end

    local bricks, count = {}, 0

    for _, p in ipairs(plane) do
        local gx = math.round(p.x - ax)
        local gy = math.round(p.y - ay)

        if gx >= 0 and gx < CP.W and gy >= 0 and gy < CP.H
        and math.abs(p.x - ax - gx) < 0.3 and math.abs(p.y - ay - gy) < 0.3 then
            local k = gx .. ":" .. gy

            if not bricks[k] then
                count += 1
            end

            bricks[k] = p.obj
        end
    end

    CP.bricks = bricks
    CP.count = count

    PaintStatus:Set(CP.tag() .. "Saved bricks: " .. count .. " (folder: " .. total .. ")")
end

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

local ImportState = {
    selecting = false,
    first = nil,
    second = nil,
    boxFirst = nil,
    boxSecond = nil,
    conn = nil,
    button = nil
}

local function ImportClearBoxes()
    if ImportState.boxFirst then
        ImportState.boxFirst:Destroy()
        ImportState.boxFirst = nil
    end

    if ImportState.boxSecond then
        ImportState.boxSecond:Destroy()
        ImportState.boxSecond = nil
    end

    ImportState.first = nil
    ImportState.second = nil
end

local function ImportStop()
    ImportState.selecting = false

    if ImportState.conn then
        ImportState.conn:Disconnect()
        ImportState.conn = nil
    end

    if ImportState.button then
        ImportState.button.Text = "Select Corners"
    end
end

local function ImportBox(brick, color)
    local box = Instance.new("SelectionBox")
    box.Adornee = brick
    box.Color3 = color
    box.LineThickness = 0.08
    box.SurfaceTransparency = 1
    box.Parent = game:GetService("CoreGui")
    return box
end

local function ImportPick(brick)
    if ImportState.first and not ImportState.second then
        if brick == ImportState.first then
            return
        end

        ImportState.second = brick
        ImportState.boxSecond = ImportBox(brick, Color3.fromRGB(60, 255, 90))
        PaintStatus:Set("Import: corner 2 set (green). Press Confirm Import")
        return
    end

    ImportClearBoxes()

    ImportState.first = brick
    ImportState.boxFirst = ImportBox(brick, Color3.fromRGB(255, 60, 60))
    PaintStatus:Set("Import: corner 1 set (red). Pick the opposite corner")
end

local function ImportBrickAt(position)
    local root = workspace:FindFirstChild("Bricks")
    local camera = workspace.CurrentCamera

    if not (root and camera) then
        return nil
    end

    local ray = camera:ScreenPointToRay(position.X, position.Y)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Include
    params.FilterDescendantsInstances = {root}

    local hit = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)

    if hit and hit.Instance and hit.Instance:IsA("BasePart") then
        return hit.Instance
    end

    return nil
end

local function ImportStart()
    if _G.CanvaRunning or CP.painting or CP.conn then
        PaintStatus:Set("Stop the canvas first")
        return
    end

    ImportStop()
    ImportClearBoxes()

    ImportState.selecting = true

    if ImportState.button then
        ImportState.button.Text = "Selecting..."
    end

    local importUIS = game:GetService("UserInputService")
    local importMouse = game:GetService("Players").LocalPlayer:GetMouse()

    PaintStatus:Set("Import: tap the first corner brick (unequip your tools)")

    ImportState.conn = importUIS.InputBegan:Connect(function(input, processed)
        if processed or not ImportState.selecting then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local position = input.Position

        task.defer(function()
            local brick = ImportBrickAt(position)

            if not brick then
                local target = importMouse.Target
                local root = workspace:FindFirstChild("Bricks")

                if target and root and target:IsA("BasePart") and target:IsDescendantOf(root) then
                    brick = target
                end
            end

            if brick then
                ImportPick(brick)
            end
        end)
    end)
end

local function ImportConfirm()
    if _G.CanvaRunning or CP.painting or CP.conn then
        PaintStatus:Set("Stop the canvas first")
        return
    end

    local first = ImportState.first
    local second = ImportState.second

    if not (first and second and first.Parent and second.Parent) then
        PaintStatus:Set("Import: select both corners first")
        return
    end

    local root = workspace:FindFirstChild("Bricks")
    local camera = workspace.CurrentCamera

    if not (root and camera) then
        PaintStatus:Set("Import: workspace.Bricks not found")
        return
    end

    local origin = first.Position
    local delta = second.Position - origin
    local flat = {}

    for _, axis in ipairs({"X", "Y", "Z"}) do
        if math.abs(delta[axis]) < 0.75 then
            flat[#flat + 1] = axis
        end
    end

    if #flat == 0 then
        PaintStatus:Set("Import: the corners are not on the same flat plane")
        return
    end

    if #flat > 1 then
        PaintStatus:Set("Import: pick two opposite corners, not a line")
        return
    end

    local normalAxis = flat[1]
    local axisVector = Vector3.new(
        normalAxis == "X" and 1 or 0,
        normalAxis == "Y" and 1 or 0,
        normalAxis == "Z" and 1 or 0
    )

    local cameraPosition = camera.CFrame.Position
    local side = (cameraPosition - origin):Dot(axisVector) >= 0 and 1 or -1
    local normal = axisVector * side

    local up

    if normalAxis == "Y" then
        local look = camera.CFrame.LookVector

        if math.abs(look.X) > math.abs(look.Z) then
            up = Vector3.new(look.X > 0 and 1 or -1, 0, 0)
        else
            up = Vector3.new(0, 0, look.Z > 0 and 1 or -1)
        end
    else
        up = Vector3.new(0, 1, 0)
    end

    local right = up:Cross(normal)
    local rotation = CFrame.fromMatrix(Vector3.zero, right, up, normal)

    local u = delta:Dot(right)
    local v = delta:Dot(up)

    local importW = math.floor(math.abs(u) + 0.5) + 1
    local importH = math.floor(math.abs(v) + 0.5) + 1

    if importW > 500 or importH > 500 then
        PaintStatus:Set("Import: canvas too big (max 500x500)")
        return
    end

    local minU = math.min(0, u)
    local minV = math.min(0, v)
    local bottomLeft = origin + right * minU + up * minV

    local center = bottomLeft + rotation * Vector3.new(
        (importW - 1) / 2,
        (importH - 1) / 2,
        0
    )

    local inverse = rotation:Inverse()
    local bricks, raw, count = {}, {}, 0

    for _, obj in ipairs(root:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Brick" then
            local rel = inverse * (obj.Position - center)

            if math.abs(rel.X) <= (importW - 1) / 2 + 0.45
            and math.abs(rel.Y) <= (importH - 1) / 2 + 0.45
            and math.abs(rel.Z) <= 0.45 then
                local fx = rel.X + (importW - 1) / 2
                local fy = rel.Y + (importH - 1) / 2
                local gx = math.round(fx)
                local gy = math.round(fy)

                if gx >= 0 and gx < importW and gy >= 0 and gy < importH
                and math.abs(fx - gx) < 0.3 and math.abs(fy - gy) < 0.3 then
                    local k = gx .. ":" .. gy

                    if not bricks[k] then
                        count += 1
                    end

                    bricks[k] = obj
                    raw[obj] = true
                end
            end
        end
    end

    if count == 0 then
        PaintStatus:Set("Import: no bricks found between the corners")
        return
    end

    CP.snapshot()
    CP.index = #CP.list + 1
    CP.list[CP.index] = {}
    CP.jsonText = nil
    CP.bricks = bricks
    CP.raw = raw
    CP.painted = {}
    CP.count = count
    CP.W, CP.H, CP.axis = importW, importH, "X"
    CP.center, CP.rotation = center, rotation
    CP.folder = root
    CP.imported = true
    CP.session = nil

    ImportStop()
    ImportClearBoxes()

    PaintStatus:Set(
        CP.tag() .. "Imported canvas " .. importW .. "x" .. importH
        .. " (" .. count .. " bricks)"
    )
end

ImportState.button = Canvas:AddButton({
    Name = "Select Corners",
    Info = "Tap two opposite corner bricks of a canvas that already exists. Corner 1 gets a red outline and corner 2 a green one",
    Callback = function()
        if ImportState.selecting then
            ImportStop()
            ImportClearBoxes()
            PaintStatus:Set("Import: selection cancelled")
        else
            ImportStart()
        end
    end
})

Canvas:AddButton({
    Name = "Confirm Import",
    Info = "Imports every brick between the two selected corners as a canvas you can paint",
    Callback = ImportConfirm
})

local function StartCanvas(resume)
    if _G.CanvaRunning then
        return
    end

    if resume and not CP.session then
        PaintStatus:Set("Nothing to continue")
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

    if resume then
        WIDTH, HEIGHT = CP.session.W, CP.session.H
    end

    local useChunks = ChunksToggle:Get() == true
    local useFast = FastToggle:Get() == true

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

        if resume then
            center = CP.session.center
        end

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

            local c = CP.conn
            task.delay(1, function()
                if c then c:Disconnect() end
                if CP.conn == c then CP.conn = nil end
                CP.rescan()
            end)

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

            if humanoid.Health <= 0 or not hrp.Parent then
                _G.CanvaRunning = false
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
        local mode = buildMode

        if resume then
            rotation = CP.session.rotation
            mode = CP.session.mode
        end

        if CP.conn then
            CP.conn:Disconnect()
            CP.conn = nil
        end
        if not resume then
            CP.snapshot()
            CP.index = #CP.list + 1
            CP.list[CP.index] = {}
            CP.jsonText = nil
            CP.bricks = {}
            CP.raw = {}
            CP.painted = {}
            CP.count = 0
            CP.W, CP.H, CP.axis = WIDTH, HEIGHT, rotationAxis
            CP.folder = nil
            CP.imported = nil
            CP.center, CP.rotation = center, rotation
            CP.session = {
                W = WIDTH,
                H = HEIGHT,
                center = center,
                rotation = rotation,
                mode = mode
            }
            PaintStatus:Set(CP.tag() .. "Saved bricks: 0")
        end

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
                            CP.save(px,py,obj)
                        end
                    end
                end
            end

            if next(CP.raw) then
                CP.rescan()

                for k in pairs(CP.bricks) do
                    placed[k] = true
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

        CP.conn = bricksFolder.ChildAdded:Connect(function(obj)
            if not obj:IsA("BasePart") then
                return
            end

            CP.raw[obj] = true

            if not CP.pending then
                CP.pending = true

                task.delay(0.4, function()
                    CP.pending = false
                    CP.rescan()
                end)
            end
        end)

        scanBricks()

        local built = 0

        local function pickChunkSize()
            local largest = math.max(WIDTH,HEIGHT)

            if largest <= 16 then
                return largest
            end

            local limit = math.min(WIDTH,HEIGHT)
            local maxSize = math.min(16,limit)
            local minSize = math.min(4,limit)

            local best = maxSize
            local bestBad = math.huge

            for size = maxSize,minSize,-1 do
                local remW = WIDTH % size
                local remH = HEIGHT % size
                local bad = 0

                if remW > 0 and remW < size / 2 then
                    bad += 1
                end

                if remH > 0 and remH < size / 2 then
                    bad += 1
                end

                if bad < bestBad then
                    best = size
                    bestBad = bad
                end
            end

            return best
        end

        local function gridOrder(x0,y0,x1,y1,size)
            local list = {}
            local countX = math.ceil((x1 - x0 + 1) / size)
            local countY = math.ceil((y1 - y0 + 1) / size)

            local function rect(i,j)
                return {
                    x0 + i * size,
                    y0 + j * size,
                    math.min(x1,x0 + (i + 1) * size - 1),
                    math.min(y1,y0 + (j + 1) * size - 1)
                }
            end

            if mode == "SideToSide" then
                for j = 0,countY - 1 do
                    local first,last,step = 0,countX - 1,1

                    if j % 2 == 1 then
                        first,last,step = countX - 1,0,-1
                    end

                    for i = first,last,step do
                        list[#list + 1] = rect(i,j)
                    end
                end
            else
                for i = 0,countX - 1 do
                    local first,last,step = 0,countY - 1,1

                    if i % 2 == 1 then
                        first,last,step = countY - 1,0,-1
                    end

                    for j = first,last,step do
                        list[#list + 1] = rect(i,j)
                    end
                end
            end

            return list
        end

        local function buildChunk(x0,y0,x1,y1)
            if mode == "SideToSide" then
                for y = y0,y1 do
                    if not running() then
                        return
                    end

                    if (y - y0) % 2 == 0 then
                        for x = x0,x1 do
                            if not running() then
                                return
                            end

                            if place(x,y) then
                                built += 1
                            end
                        end
                    else
                        for x = x1,x0,-1 do
                            if not running() then
                                return
                            end

                            if place(x,y) then
                                built += 1
                            end
                        end
                    end

                    task.wait(0.15)
                end
            else
                for x = x0,x1 do
                    if not running() then
                        return
                    end

                    if (x - x0) % 2 == 0 then
                        for y = y0,y1 do
                            if not running() then
                                return
                            end

                            if place(x,y) then
                                built += 1
                            end
                        end
                    else
                        for y = y1,y0,-1 do
                            if not running() then
                                return
                            end

                            if place(x,y) then
                                built += 1
                            end
                        end
                    end

                    task.wait(0.15)
                end
            end
        end

        local function placeFast(x,y)
            if not running() then
                return false
            end

            local k = key(x,y)

            if placed[k] then
                return true
            end

            event:FireServer(
                workspace.Terrain,
                Enum.NormalId.Top,
                positionFor(x,y),
                "detail"
            )

            placed[k] = true
            blocksSinceScan += 1

            return true
        end

        local function runStop(rect)
            local x0,y0,x1,y1 = rect[1],rect[2],rect[3],rect[4]
            local pending = {}

            for y = y0,y1 do
                for x = x0,x1 do
                    if not placed[key(x,y)] then
                        pending[#pending + 1] = {x,y}
                    end
                end
            end

            if #pending == 0 then
                return true
            end

            if not running() then
                return false
            end

            local midX = math.floor((x0 + x1) / 2)
            local midY = math.floor((y0 + y1) / 2)

            hrp.CFrame = CFrame.new(
                positionFor(midX,midY) + Vector3.new(0,2,-3)
            )

            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero

            task.wait(0.1)

            for index,cell in ipairs(pending) do
                if not running() then
                    return false
                end

                if placeFast(cell[1],cell[2]) then
                    built += 1
                end

                if index % 6 == 0 then
                    task.wait()
                end
            end

            if blocksSinceScan >= 200 then
                task.wait(0.05)

                if not running() then
                    return false
                end

                scanBricks()
            end

            return true
        end

        local function fastStops(tile)
            local stops = {}

            if useChunks then
                for _,chunk in ipairs(gridOrder(0,0,WIDTH - 1,HEIGHT - 1,pickChunkSize())) do
                    for _,rect in ipairs(gridOrder(chunk[1],chunk[2],chunk[3],chunk[4],tile)) do
                        stops[#stops + 1] = rect
                    end
                end
            else
                stops = gridOrder(0,0,WIDTH - 1,HEIGHT - 1,tile)
            end

            return stops
        end

        local function countMissing()
            local missing = 0

            for y = 0,HEIGHT - 1 do
                for x = 0,WIDTH - 1 do
                    if not placed[key(x,y)] then
                        missing += 1
                    end
                end
            end

            return missing
        end

        if useFast then

            local tiles = {10,6,3}
            local startIndex = 1

            for index,value in ipairs(tiles) do
                if value == CP.fastTile then
                    startIndex = index
                end
            end

            for index = startIndex,#tiles do
                if not running() then
                    break
                end

                local tile = tiles[index]

                PaintStatus:Set(CP.tag() .. "Fast mode: tiles of " .. tile)

                for _,rect in ipairs(fastStops(tile)) do
                    if not runStop(rect) then
                        break
                    end
                end

                if not running() then
                    break
                end

                task.wait(0.35)
                scanBricks()

                local missing = countMissing()
                local allowed = math.max(3,math.floor(WIDTH * HEIGHT * 0.02))

                if missing <= allowed or index == #tiles then
                    CP.fastTile = tile
                    break
                end
            end

        elseif useChunks then

            local size = pickChunkSize()
            local order = gridOrder(0,0,WIDTH - 1,HEIGHT - 1,size)

            for index,chunk in ipairs(order) do
                if not running() then
                    break
                end

                PaintStatus:Set(
                    CP.tag() .. "Chunk " .. index .. "/" .. #order
                    .. " (" .. size .. "x" .. size .. ")"
                )

                buildChunk(chunk[1],chunk[2],chunk[3],chunk[4])
                task.wait(0.1)
            end

        elseif mode == "SideToSide" then

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

Canvas:AddButton({
    Name = "Continue Canvas",
    Info = "Continues the last canvas from where it stopped after dying or pressing Stop",
    Callback = function()
        StartCanvas(true)
    end
})

local function CPSwitch(step)
    if _G.CanvaRunning or CP.painting or CP.conn then
        PaintStatus:Set("Stop the canvas first")
        return
    end

    local n = #CP.list

    if n < 2 then
        PaintStatus:Set(CP.tag() .. "No other canvas saved")
        return
    end

    CP.snapshot()

    local i = CP.index + step

    if i > n then
        i = 1
    elseif i < 1 then
        i = n
    end

    CP.load(i)
    CP.rescan()
end

Canvas:AddButton({
    Name = "Next Canvas",
    Info = "Switches to the next saved canvas",
    Callback = function()
        CPSwitch(1)
    end
})

Canvas:AddButton({
    Name = "Previous Canvas",
    Info = "Switches to the previous saved canvas",
    Callback = function()
        CPSwitch(-1)
    end
})

local function CPColorAt(px, py)
    if CP.white then
        return Color3.fromRGB(255, 255, 255)
    end

    local u, v

    if CP.axis == "Z" then
        u = (CP.H - 1 - py + 0.5) / CP.H
        v = (CP.W - 1 - px + 0.5) / CP.W
    else
        u = (px + 0.5) / CP.W
        v = (CP.H - 1 - py + 0.5) / CP.H
    end

    if CP.mirror then
        u = 1 - u
    end

    local col = math.clamp(math.floor(u * CP.jw) + 1, 1, CP.jw)
    local row = math.clamp(math.floor(v * CP.jh) + 1, 1, CP.jh)

    local hex = CP.pixels[row] and CP.pixels[row][col]

    if type(hex) ~= "string" then
        return nil
    end

    local r, g, b = hex:match("^#?(%x%x)(%x%x)(%x%x)$")

    if not r then
        return nil
    end

    return Color3.fromRGB(tonumber(r,16), tonumber(g,16), tonumber(b,16))
end

local function CPLoadJson(text)
    local ok, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(text)
    end)

    if not ok or type(data) ~= "table"
    or not tonumber(data.width) or not tonumber(data.height) then
        return false
    end

    local frames = data.pixels and {data.pixels}

    if type(data.frames) == "table" and #data.frames > 0 then
        frames = data.frames
    end

    if type(frames) ~= "table" or type(frames[1]) ~= "table" then
        return false
    end

    CP.frames = frames
    CP.frame = 1
    CP.fps = math.clamp(tonumber(data.fps) or 8, 1, 30)
    CP.pixels = frames[1]
    CP.jw = tonumber(data.width)
    CP.jh = tonumber(data.height)

    return true
end

local function CPSetFrame(i)
    CP.frame = i
    CP.pixels = CP.frames[i]
end

local function CPFrameTag()
    if CP.frames and #CP.frames > 1 then
        return "Frame " .. CP.frame .. "/" .. #CP.frames .. " "
    end

    return ""
end

local function CPPrepare(skipJson)
    if CP.painting then
        return false
    end

    CP.rescan()

    if CP.count == 0 then
        PaintStatus:Set("Build the canvas first (Start Canvas)")
        return false
    end

    if skipJson then
        return true
    end

    local text = PixelJson:Get():gsub("^%s+", ""):gsub("%s+$", "")

    if text:sub(1, 1) ~= "{" and text ~= "" and isfile and isfile(text) then
        text = readfile(text)
    end

    if text ~= CP.jsonText then
        if not CPLoadJson(text) then
            PaintStatus:Set("Invalid JSON")
            return false
        end

        CP.jsonText = text
        CP.painted = {}

        if CP.jw ~= CP.W or CP.jh ~= CP.H then
            PaintStatus:Set("Warning: JSON " .. CP.jw .. "x" .. CP.jh .. " vs canvas " .. CP.W .. "x" .. CP.H .. " (will be fitted)")
            task.wait(1.2)
        end
    end

    if not CP.pixels then
        PaintStatus:Set("Invalid JSON")
        return false
    end

    return true
end

local function CPSame(a, b)
    return math.abs(a.R - b.R) * 255 < 2
    and math.abs(a.G - b.G) * 255 < 2
    and math.abs(a.B - b.B) * 255 < 2
end

local function CPSortList(list)
    table.sort(list, function(a, b)
        if a.py ~= b.py then
            return a.py < b.py
        end
        return a.px < b.px
    end)
end

local function CPBuildListBucket()
    local list = {}

    for k, brick in pairs(CP.bricks) do
        if brick.Parent then
            local px, py = k:match("^(%-?%d+):(%-?%d+)$")
            local color = CPColorAt(tonumber(px), tonumber(py))

            if color and CP.painted[k] ~= color then
                list[#list + 1] = {k = k, brick = brick, color = color, px = tonumber(px), py = tonumber(py)}
            end
        end
    end

    CPSortList(list)

    return list
end

local function CPBuildList(ignoreTries)
    local list = {}

    for k, brick in pairs(CP.bricks) do
        if brick.Parent then
            local px, py = k:match("^(%-?%d+):(%-?%d+)$")
            local color = CPColorAt(tonumber(px), tonumber(py))

            if color and not CPSame(brick.Color, color)
            and (ignoreTries or (CP.tries[k] or 0) < 4) then
                list[#list + 1] = {k = k, brick = brick, color = color, px = tonumber(px), py = tonumber(py)}
            end
        end
    end

    CPSortList(list)

    return list
end

local function CPPaintFast(root, remote)
    local list = CPBuildListBucket()
    local total = #list
    local done = 0
    local inflight = 0

    for _, item in ipairs(list) do
        if not CP.painting or not root.Parent then
            break
        end

        while inflight >= 20 do
            task.wait()
        end

        inflight += 1

        task.spawn(function()
            local ok = pcall(function()
                remote:InvokeServer("PaintPart", {
                    Part = item.brick,
                    Color = item.color,
                    Position = root.Position,
                    CFrame = root.CFrame
                })
            end)

            if ok then
                CP.painted[item.k] = item.color
            end

            done += 1
            inflight -= 1
        end)

        if done % 10 == 0 then
            PaintStatus:Set(CPFrameTag() .. "Painting " .. done .. "/" .. total)
        end
    end

    while inflight > 0 do
        task.wait()
    end

    return done, total
end

local function CPPaintTP(root, event, list, label)
    local total = #list
    local done = 0

    root.Anchored = true

    for _, item in ipairs(list) do
        if not CP.painting or not root.Parent or not item.brick.Parent then
            break
        end

        local cf = item.brick.CFrame
        local face = cf:PointToWorldSpace(Vector3.new(0, 0, item.brick.Size.Z / 2))
        local normal = cf:VectorToWorldSpace(Vector3.new(0, 0, 1))

        root.CFrame = CFrame.new(face + normal * 3 + Vector3.new(0, 2, 0))
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero

        task.wait(0.08)

        if not CP.painting then
            break
        end

        event:FireServer(item.brick, Enum.NormalId.Back, face, "color", item.color, "smooth", "")

        CP.tries[item.k] = (CP.tries[item.k] or 0) + 1
        done += 1

        if done % 5 == 0 then
            PaintStatus:Set(CPFrameTag() .. label .. " " .. done .. "/" .. total)
        end
    end

    if root.Parent then
        root.Anchored = false
    end
end

local function CPRun(white, play)
    CP.white = false

    if not CPPrepare(white) then
        return
    end

    CP.painting = true

    task.spawn(function()
        local lp = game:GetService("Players").LocalPlayer
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local useTool = CP.method == "tool"
        local toolName = useTool and "Paint" or "PaintBucket"
        local tool = (char and char:FindFirstChild(toolName))
            or lp.Backpack:FindFirstChild(toolName)

        if not (root and tool) then
            CP.painting = false
            PaintStatus:Set((useTool and "Paint tool" or "PaintBucket") .. " not found")
            return
        end

        if tool.Parent ~= char then
            local hum = char:FindFirstChildOfClass("Humanoid")

            if hum then
                hum:EquipTool(tool)
            else
                tool.Parent = char
            end

            task.wait(0.4)
        end

        local remote

        if useTool then
            local sc = tool:WaitForChild("Script", 5)
            remote = sc and sc:WaitForChild("Event", 5)
        else
            local rem = tool:WaitForChild("Remotes", 5)
            remote = rem and rem:WaitForChild("ServerControls", 5)
        end

        if not remote then
            CP.painting = false
            PaintStatus:Set("Remote not found")
            return
        end

        CP.white = white == true

        local loop = play and CP.frames and #CP.frames > 1
        local done, total, missing = 0, 0, 0

        repeat
            if useTool then
                CP.tries = {}

                local list = CPBuildList()

                PaintStatus:Set(CPFrameTag() .. "Painting 0/" .. #list)

                if #list > 0 then
                    CPPaintTP(root, remote, list, "Painting")
                end

                local pass = 0

                while CP.painting and root.Parent and pass < 8 do
                    task.wait(0.8)

                    list = CPBuildList()

                    if #list == 0 then
                        break
                    end

                    pass += 1
                    CPPaintTP(root, remote, list, "Fix " .. pass)
                end

                missing = #CPBuildList(true)
            else
                done, total = CPPaintFast(root, remote)
            end

            if loop and CP.painting and root.Parent then
                CPSetFrame(CP.frame % #CP.frames + 1)
                task.wait(1 / CP.fps)
            end
        until not loop or not CP.painting or not root.Parent

        local finished = CP.painting

        CP.painting = false
        CP.white = false

        if white then
            CP.painted = {}
        end

        if useTool then
            PaintStatus:Set(CPFrameTag() .. (finished and "Painting done" or "Painting stopped") .. " - missing " .. missing)
        else
            PaintStatus:Set(CPFrameTag() .. (finished and "Painting done " or "Painting stopped ") .. done .. "/" .. total)
        end
    end)
end

Canvas:AddButton({
    Name = "Paint Method",
    Info = "Switches between the PaintBucket remote and the Paint tool with teleport to each brick",
    Callback = function()
        CP.method = CP.method == "tool" and "bucket" or "tool"
        PaintStatus:Set(CP.method == "tool" and "Paint method: Paint tool with teleport" or "Paint method: PaintBucket")
    end
})

Canvas:AddButton({
    Name = "Paint Canvas",
    Info = "Paints the saved canvas bricks using the pasted JSON with the selected paint method",
    Callback = function()
        CPRun()
    end
})

local function CPStep(step)
    if CP.painting then
        PaintStatus:Set("Stop painting first")
        return
    end

    if not CPPrepare() then
        return
    end

    local n = #CP.frames

    if n < 2 then
        PaintStatus:Set("The JSON has only one frame")
        return
    end

    CPSetFrame((CP.frame - 1 + step) % n + 1)
    CPRun(false)
end

Canvas:AddButton({
    Name = "Next Frame",
    Info = "Paints the next frame of the animation using the selected paint method",
    Callback = function()
        CPStep(1)
    end
})

Canvas:AddButton({
    Name = "Previous Frame",
    Info = "Paints the previous frame of the animation using the selected paint method",
    Callback = function()
        CPStep(-1)
    end
})

Canvas:AddButton({
    Name = "Play Animation",
    Info = "Paints every frame in a loop using the fps from the JSON until you press Stop Paint",
    Callback = function()
        CPRun(false, true)
    end
})

Canvas:AddButton({
    Name = "Clear Canvas",
    Info = "Paints the whole saved canvas white using the selected paint method",
    Callback = function()
        CPRun(true)
    end
})

Canvas:AddButton({
    Name = "Stop Paint",
    Info = "Stops painting and keeps the saved bricks and what is already painted",
    Callback = function()
        CP.painting = false
    end
})

Canvas:AddButton({
    Name = "Mirror Image",
    Info = "Flips the image horizontally if it comes out reversed",
    Callback = function()
        CP.mirror = not CP.mirror
        CP.painted = {}
        PaintStatus:Set("Mirror: " .. tostring(CP.mirror))
    end
})

local _AB = {}

Building67:AddTextbox({
	Name = "Save Name",
	Placeholder = "Enter build name to save...",
	Text = "",
	Callback = function(text)
		_AB.currentSaveName = text
	end
})

Building67:AddButton({
	Name = "SAVE BUILD",
	Info = "Saves current bricks with the name entered above",
	Callback = function()
		if _AB.doSave then _AB.doSave(_AB.currentSaveName or "") end
	end
})

Building67:AddButton({
	Name = "EXPORT SELECTED",
	Info = "Copies selected build JSON to clipboard",
	Callback = function()
		if _AB.doExport then _AB.doExport() end
	end
})

Building67:AddButton({
	Name = "IMPORT JSON",
	Info = "Opens window to paste and import JSON",
	Callback = function()
		if _AB.doImport then _AB.doImport() end
	end
})

Building67:AddToggle({
	Name = "Server Mode Save",
	Info = "ON: Scans all server models. OFF: Only your local bricks.",
	Default = false,
	Callback = function(value)
		_AB.saveMode = value and "server" or "local"
	end
})

Building67:AddButton({
	Name = "REFRESH BUILDS LIST",
	Info = "Reloads saved builds creating dynamic buttons",
	Callback = function()
		if _AB.refreshBuilds then _AB.refreshBuilds() end
	end
})

Building67:AddButton({
	Name = "LOAD SELECTED BUILD",
	Info = "Starts building the last clicked build from list",
	Callback = function()
		if _AB.loadSelected then _AB.loadSelected() end
	end
})

Building67:AddButton({
	Name = "STOP AUTOBUILD",
	Info = "Stops current loading process immediately",
	Callback = function()
		_AB.stopped = true
	end
})

Building67:AddToggle({
	Name = "Teleport While Building",
	Default = true,
	Callback = function(value)
		_AB.tp = value
	end
})

Building67:AddToggle({
	Name = "Apply Colors",
	Default = true,
	Callback = function(value)
		_AB.colorbool = value
	end
})

Building67:AddSlider({
	Name = "Build Speed",
	Min = 0.01,
	Max = 5,
	Step = 0.01,
	Default = 0.1,
	Callback = function(value)
		_AB.buildSpeed = value
	end
})

Building67:AddSlider({
	Name = "Resize Wait",
	Min = 0.01,
	Max = 5,
	Step = 0.01,
	Default = 0.4,
	Callback = function(value)
		_AB.resizewait = value
	end
})

Building67:AddSlider({
	Name = "History Max",
	Min = 10,
	Max = 1000,
	Step = 10,
	Default = 400,
	Callback = function(value)
		_AB.historymax = math.floor(value)
	end
})

Building67:AddButton({
	Name = "SET OFFSET HERE",
	Info = "Uses current position as origin for future loads",
	Callback = function()
		if _AB.setOffset then _AB.setOffset() end
	end
})

Building67:AddButton({
	Name = "RESET OFFSET",
	Info = "Resets origin to (0,0,0)",
	Callback = function()
		_AB.offset = Vector3.new(0,0,0)
	end
})

Building67:AddButton({
	Name = "OPTIMIZE ALL SAVES",
	Info = "Reduces size of all JSON files",
	Callback = function()
		if _AB.optimizeAll then _AB.optimizeAll() end
	end
})

Building67:AddButton({
	Name = "DELETE SELECTED SAVE",
	Info = "Deletes file of the last clicked build",
	Callback = function()
		if _AB.deleteSelected then _AB.deleteSelected() end
	end
})

Gears67:AddButton({
	Name = "Color: White",
	Info = "Select white color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(1, 1, 1)
	end
})

Gears67:AddButton({
	Name = "Color: Red",
	Info = "Select red color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(1, 0, 0)
	end
})

Gears67:AddButton({
	Name = "Color: Blue",
	Info = "Select blue color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(0, 0, 1)
	end
})

Gears67:AddButton({
	Name = "Color: Green",
	Info = "Select green color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(0, 1, 0)
	end
})

Gears67:AddButton({
	Name = "Color: Black",
	Info = "Select black color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(0, 0, 0)
	end
})

Gears67:AddButton({
	Name = "Color: Yellow",
	Info = "Select yellow color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(1, 1, 0)
	end
})

Gears67:AddButton({
	Name = "Color: Cyan",
	Info = "Select cyan color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(0, 1, 1)
	end
})

Gears67:AddButton({
	Name = "Color: Purple",
	Info = "Select purple color",
	Callback = function()
		_G.PaintBucketColor = Color3.new(0.5, 0, 0.5)
	end
})

Gears67:AddButton({
	Name = "Paint All Blocks",
	Info = "Paint all blocks using PaintBucket",
	Callback = function()
		local Players = game:GetService("Players")
		local plr = Players.LocalPlayer
		local character = plr.Character
		
		if not character then return end
		
		local pb = character:FindFirstChild("PaintBucket") or plr.Backpack:FindFirstChild("PaintBucket")
		if not pb then return end
		
		if pb.Parent ~= character then
			pb.Parent = character
			task.wait(0.2)
		end
		
		local paintevent = pb:FindFirstChild("Remotes") and pb.Remotes:FindFirstChild("ServerControls")
		if not paintevent then return end
		
		local targetColor = _G.PaintBucketColor or Color3.new(1, 1, 1)
		
		pcall(function()
			paintevent:InvokeServer("PaintPart", {
				Part = game.ReplicatedStorage:FindFirstChild("Brick"),
				Color = targetColor
			})
		end)
		
		local searchRoots = {workspace, game:GetService("ReplicatedStorage")}
		for _, root in ipairs(searchRoots) do
			for _, v in ipairs(root:GetDescendants()) do
				local ok, col = pcall(function() return v.Color end)
				if ok and typeof(col) == "Color3" then
					pcall(function()
						paintevent:InvokeServer("PaintPart", {
							Part = v,
							Color = targetColor
						})
					end)
				end
			end
		end
	end
})

Gears67:AddToggle({
	Name = "Random Paint Loop",
	Default = false,
	Callback = function(value)
		_G.RandomPaintLoopEnabled = value
		if value then
			_G.StopRandomPaintColor = false
			task.spawn(function()
				while _G.RandomPaintLoopEnabled and not _G.StopRandomPaintColor do
					local Players = game:GetService("Players")
					local plr = Players.LocalPlayer
					local character = plr.Character
					
					if not character then task.wait(1) continue end
					
					local pb = character:FindFirstChild("PaintBucket") or plr.Backpack:FindFirstChild("PaintBucket")
					if not pb then task.wait(1) continue end
					
					if pb.Parent ~= character then
						pb.Parent = character
						task.wait(0.2)
					end
					
					local paintevent = pb:FindFirstChild("Remotes") and pb.Remotes:FindFirstChild("ServerControls")
					if not paintevent then task.wait(1) continue end
					
					local targetColor = Color3.new(math.random(), math.random(), math.random())
					
					pcall(function()
						paintevent:InvokeServer("PaintPart", {
							Part = game.ReplicatedStorage:FindFirstChild("Brick"),
							Color = targetColor
						})
					end)
					
					local searchRoots = {workspace, game:GetService("ReplicatedStorage")}
					for _, root in ipairs(searchRoots) do
						for _, v in ipairs(root:GetDescendants()) do
							if _G.StopRandomPaintColor then break end
							local ok, col = pcall(function() return v.Color end)
							if ok and typeof(col) == "Color3" then
								pcall(function()
									paintevent:InvokeServer("PaintPart", {
										Part = v,
										Color = targetColor
									})
								end)
							end
						end
						if _G.StopRandomPaintColor then break end
					end
					
					task.wait(0.5)
				end
			end)
		else
			_G.StopRandomPaintColor = true
		end
	end
})

Gears67:AddButton({
	Name = "Get PaintBucket Gear",
	Info = "Request PaintBucket gear via chat",
	Callback = function()
		pcall(function()
			game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(";Gear me 18474459")
		end)
	end
})

Utils67:AddButton({
	Name = "Copy Job ID",
	Info = "Copies server Job ID to clipboard",
	Callback = function()
		if setclipboard then
			setclipboard(game.JobId)
		end
	end
})

Utils67:AddButton({
	Name = "Copy Place ID",
	Info = "Copies game Place ID to clipboard",
	Callback = function()
		if setclipboard then
			setclipboard(tostring(game.PlaceId))
		end
	end
})

Utils67:AddButton({
	Name = "Rejoin Server",
	Info = "Rejoin current server",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
		TeleportService:Teleport(game.PlaceId)
	end
})

Utils67:AddButton({
	Name = "Del Clones",
	Info = "Send delete clones command",
	Callback = function()
		pcall(function()
			game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(";delclones all")
		end)
	end
})

Utils67:AddButton({
	Name = "Get Server Stats",
	Info = "Show current player count",
	Callback = function()
		local Players = game:GetService("Players")
		local count = #Players:GetPlayers()
	end
})

Utils67:AddButton({
	Name = "Find Players",
	Info = "Scan and list all players",
	Callback = function()
		local Players = game:GetService("Players")
		local playerList = {}
		for _, player in ipairs(Players:GetPlayers()) do
			table.insert(playerList, player.Name)
		end
	end
})

Utils67:AddButton({
	Name = "Teleport to Player",
	Info = "Teleport to random player",
	Callback = function()
		local Players = game:GetService("Players")
		local allPlayers = Players:GetPlayers()
		if #allPlayers > 1 then
			local randomPlayer = allPlayers[math.random(2, #allPlayers)]
			if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local plr = Players.LocalPlayer
				if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
				end
			end
		end
	end
})

Utils67:AddButton({
	Name = "Get My Position",
	Info = "Get current player position",
	Callback = function()
		local Players = game:GetService("Players")
		local plr = Players.LocalPlayer
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local pos = plr.Character.HumanoidRootPart.Position
			if setclipboard then
				setclipboard(tostring(pos))
			end
		end
	end
})

Utils67:AddButton({
	Name = "List All Players",
	Info = "Get all player names",
	Callback = function()
		local Players = game:GetService("Players")
		local names = {}
		for _, player in ipairs(Players:GetPlayers()) do
			table.insert(names, player.Name)
		end
		if setclipboard then
			setclipboard(table.concat(names, ", "))
		end
	end
})

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

_AB.mult = 4
_AB.built = false
_AB.stopped = false
_AB.skipblock = false
_AB.on = true
_AB.ors = true
_AB.colorbool = true
_AB.childcube = nil
_AB.oldprt = nil
_AB.tp = true
_AB.blocks = {}
_AB.cubehistory = {}
_AB.historynum = 0
_AB.historymax = 400
_AB.cubechild = nil
_AB.novel = false
_AB.resizewait = 0.4
_AB.wbs = false
_AB.buildSpeed = 0.05
_AB.offset = Vector3.new(0,0,0)
_AB.selectedBuild = nil
_AB.saveMode = "local"
_AB.savebuildnames = {}
_AB.currentSaveName = ""
_AB.dynamicButtons = {}

_AB.blockCache = {}
_AB.lastPlacedBlock = nil
_AB.lastBlockTime = 0
_AB.maxParallel = 3
_AB.batchSize = 5

_AB.normalids = {}
_AB.normalids[Enum.NormalId.Right] = {Vector3.new(1,0,0),"X"}
_AB.normalids[Enum.NormalId.Top] = {Vector3.new(0,1,0),"Y"}
_AB.normalids[Enum.NormalId.Back] = {Vector3.new(0,0,1),"Z"}
_AB.normalids[Enum.NormalId.Left] = {Vector3.new(-1,0,0),"X"}
_AB.normalids[Enum.NormalId.Bottom] = {Vector3.new(0,-1,0),"Y"}
_AB.normalids[Enum.NormalId.Front] = {Vector3.new(0,0,-1),"Z"}

_AB.colors = {}
_AB.colors["tan"] = Color3.fromRGB(188,155,93)
_AB.colors["pink"] = Color3.fromRGB(255,0,255)
_AB.colors["dark pink"] = Color3.fromRGB(160,0,160)
_AB.defaultcolor = Color3.fromRGB(192,192,192)

_AB.highlight = Instance.new("Highlight")
_AB.highlight.Parent = game.CoreGui
_AB.highlight.FillTransparency = 1
_AB.highlight.OutlineTransparency = 0

_AB.materials = {}
_AB.materials[Enum.Material.SmoothPlastic] = "smooth"
_AB.materials[Enum.Material.Plastic] = "plastic"
_AB.materials[Enum.Material.CeramicTiles] = "tiles"
_AB.materials[Enum.Material.Brick] = "bricks"
_AB.materials[Enum.Material.WoodPlanks] = "planks"
_AB.materials[Enum.Material.Ice] = "ice"
_AB.materials[Enum.Material.Grass] = "grass"
_AB.materials[Enum.Material.Sand] = "sand"
_AB.materials[Enum.Material.Snow] = "snow"
_AB.materials[Enum.Material.Glass] = "glass"
_AB.materials[Enum.Material.Wood] = "wood"
_AB.materials[Enum.Material.Slate] = "stone"
_AB.materials[Enum.Material.Pebble] = "pebble"
_AB.materials[Enum.Material.Marble] = "marble"
_AB.materials[Enum.Material.Granite] = "granite"
_AB.materials[Enum.Material.DiamondPlate] = "steel"
_AB.materials[Enum.Material.Metal] = "metal"
_AB.materials[Enum.Material.Asphalt] = "asphalt"
_AB.materials[Enum.Material.Concrete] = "concrete"
_AB.materials[Enum.Material.Pavement] = "pavement"
_AB.materials[Enum.Material.Neon] = "neon"

_AB.swappedmaterials = {}
for i,v in pairs(_AB.materials) do
	_AB.swappedmaterials[v] = i
end

if workspace.Bricks and workspace.Bricks:FindFirstChild(LocalPlayer.Name) then
	_AB.cubechild = workspace.Bricks[LocalPlayer.Name].ChildAdded:Connect(function(child)
		_AB.childcube = child
		_AB.historynum = _AB.historynum + 1
		if _AB.historynum > _AB.historymax then
			_AB.historynum = 1
		end
		_AB.cubehistory[_AB.historynum] = child
		_AB.built = true
	end)
end

function _AB.roundnum(num,m)
	return math.round((num - 2) / m) * m + 2
end

function _AB.round(pos,m)
	return Vector3.new(_AB.roundnum(pos.X,m or _AB.mult),_AB.roundnum(pos.Y,m or _AB.mult),_AB.roundnum(pos.Z,m or _AB.mult))
end

function _AB.snap(pos,m)
	if m == nil then m = _AB.mult end
	return pos
end

function _AB.validate(name)
	local bannedsymbols = {}
	bannedsymbols['"'] = "''"
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

function _AB.listfilesfixed(directory)
	local s,lf = pcall(function()
		return listfiles(directory)
	end)
	if s then
		for i,v in pairs(lf) do
			if typeof(v) == "string" and string.sub(v,1,2) == "./" then
				lf[i] = string.sub(v,3)
			end
		end
	end
	return lf or {}
end

function _AB.getfn(js,first)
	local fn = _AB.listfilesfixed("TCOLSaves/")
	if fn and typeof(fn) == "table" then
		if not js then
			for i,v in pairs(fn) do
				if typeof(v) == "string" then
					fn[i] = v:gsub(".json","")
				end
			end
		end
		if not first then
			for i,v in pairs(fn) do
				if typeof(v) == "string" then
					fn[i] = v:gsub("TCOLSaves/","")
				end
			end
		end
	else
		fn = {}
	end
	return fn
end

function _AB.createpartrepl(pos,bsize,col,mat,transp,anch,collide,sprays)
	if typeof(pos) == "Vector3" then
		pos = CFrame.new(pos)
	end
	local p = Instance.new("Part")
	_AB.oldprt = p
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
	p.Size = bsize or Vector3.new(_AB.mult,_AB.mult,_AB.mult)
	p.CFrame = pos
	p.Parent = workspace
	return p
end

function _AB.isAdjacentBlock(newPos, lastBlock)
	if not lastBlock then return false end
	local dist = (newPos - lastBlock.Position).Magnitude
	local mult = _AB.mult
	if dist <= mult * 2.5 then
		if (lastBlock.Size - lastBlock.Size).Magnitude < 0.5 then
			return true
		end
	end
	return false
end

function _AB.updateBlockCache(newBlock)
	if newBlock and newBlock.Parent then
		_AB.lastPlacedBlock = newBlock
		_AB.lastBlockTime = tick()
		local key = math.floor(newBlock.Position.X) .. "," .. math.floor(newBlock.Position.Y) .. "," .. math.floor(newBlock.Position.Z)
		_AB.blockCache[key] = {
			block = newBlock,
			time = _AB.lastBlockTime,
			size = newBlock.Size,
			material = newBlock.Material,
			color = newBlock.Color
		}
	end
end

function _AB.getStackableBlock()
	if not _AB.lastPlacedBlock or not _AB.lastPlacedBlock.Parent then
		return nil
	end
	return _AB.lastPlacedBlock
end

function _AB.isSimilarBlock(block1, block2, tolerance)
	tolerance = tolerance or 0.1
	if not block1 or not block2 then return false end
	if not block1.Parent or not block2.Parent then return false end
	
	local sizeDiff = (block1.Size - block2.Size).Magnitude
	if sizeDiff > tolerance then return false end
	
	if block1.Material ~= block2.Material then return false end
	
	local colorDiff = math.abs(block1.Color.R - block2.Color.R) + math.abs(block1.Color.G - block2.Color.G) + math.abs(block1.Color.B - block2.Color.B)
	if colorDiff > 0.05 then return false end
	
	return true
end

function _AB.buildblock(pos,texture,color,bsize,bsizev3,premadebuild,origmaterial,sprays,anchored,collide)
	task.wait(0.001)
	if anchored == nil then anchored = true end
	if collide == nil then collide = true end
	
	local stackBlock = _AB.getStackableBlock()
	local isIdentical = stackBlock and _AB.isSimilarBlock(stackBlock, stackBlock, 0.1)
	local isStackable = _AB.isAdjacentBlock(pos, stackBlock)
	
	pcall(function()
		if LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Build") then
			LocalPlayer.Backpack.Build.Parent = LocalPlayer.Character
		end
	end)
	
	_AB.childcube = nil
	
	if bsize == nil then
		bsize = "normal"
		pcall(function()
			if LocalPlayer.PlayerGui:FindFirstChild("Build") then
				local buildGui = LocalPlayer.PlayerGui.Build
				if buildGui and buildGui:FindFirstChild("Button") then
					bsize = buildGui.Button.Text
				end
			end
		end)
		if bsizev3 ~= nil and (bsizev3.X ~= _AB.mult or bsizev3.Y ~= _AB.mult or bsizev3.Z ~= _AB.mult) then
			bsize = "detailed"
		end
	end
	
	local oldpos = pos
	pos = _AB.snap(pos)
	local args = {
		[1] = workspace.Terrain,
		[2] = Enum.NormalId.Top,
		[3] = pos,
		[4] = bsize or "normal"
	}
	
	_AB.built = false
	local attempts = 0
	local maxAttempts = isIdentical and 12 or (isStackable and 50 or 100)
	local waitTime = isIdentical and 0.008 or (isStackable and 0.03 or 0.05)
	
	repeat
		attempts = attempts + 1
		
		if _AB.tp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 6, 0))
		end
		
		if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("Build") and LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Build") then
			LocalPlayer.Backpack.Build.Parent = LocalPlayer.Character
		end
		
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Build") then
			pcall(function()
				local event = LocalPlayer.Character.Build:FindFirstChild("origevent") 
					and LocalPlayer.Character.Build.origevent:Invoke(unpack(args)) 
					or LocalPlayer.Character.Build.Script.Event:FireServer(unpack(args))
			end)
		end
		
		task.wait(waitTime)
		
	until (_AB.built and _AB.childcube) or _AB.stopped or _AB.skipblock or attempts > maxAttempts
	
	if _AB.childcube then
		_AB.updateBlockCache(_AB.childcube)
	end
	
	_AB.built = false
	
	if _AB.colorbool and _AB.childcube and typeof(color) == "Color3" then
		local paintPos = (_AB.childcube and _AB.childcube.Position + _AB.childcube.Size/2) or pos
		
		local paintExists = LocalPlayer.Backpack:FindFirstChild("Paint") or LocalPlayer.Character:FindFirstChild("Paint")
		if paintExists and _AB.childcube.Color ~= color then
			local paintArgs = {
				[1] = _AB.childcube,
				[2] = Enum.NormalId.Top,
				[3] = paintPos,
				[4] = "color",
				[5] = color,
				[6] = "tiles",
				[7] = ""
			}
			
			task.wait(0.01)
			
			pcall(function()
				if LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Paint") then
					LocalPlayer.Backpack.Paint.Parent = LocalPlayer.Character
				end
			end)
			
			_AB.built = false
			attempts = 0
			local maxPaintAttempts = isIdentical and 8 or 25
			
			repeat
				attempts = attempts + 1
				
				if _AB.tp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(paintPos + Vector3.new(0, 6, 0))
				end
				
				if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("Paint") and LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Paint") then
					LocalPlayer.Backpack.Paint.Parent = LocalPlayer.Character
				end
				
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Paint") then
					pcall(function()
						local event = LocalPlayer.Character.Paint:FindFirstChild("origevent")
							and LocalPlayer.Character.Paint.origevent:Invoke(unpack(paintArgs))
							or LocalPlayer.Character.Paint.Script.Event:FireServer(unpack(paintArgs))
					end)
				end
				
				task.wait(isIdentical and 0.04 or 0.08)
				
			until not _AB.childcube or not _AB.childcube.Parent or _AB.childcube.Color == color or _AB.stopped or _AB.skipblock or attempts > maxPaintAttempts
		end
	end
	
	if _AB.childcube and texture then
		local paintPos = (_AB.childcube and _AB.childcube.Position + _AB.childcube.Size/2) or pos
		
		local paintExists = LocalPlayer.Backpack:FindFirstChild("Paint") or LocalPlayer.Character:FindFirstChild("Paint")
		if paintExists then
			local textureArgs = {
				[1] = _AB.childcube,
				[2] = Enum.NormalId.Top,
				[3] = paintPos,
				[4] = "material",
				[5] = nil,
				[6] = texture,
				[7] = ""
			}
			
			task.wait(0.01)
			
			pcall(function()
				if LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Paint") then
					LocalPlayer.Backpack.Paint.Parent = LocalPlayer.Character
				end
			end)
			
			_AB.built = false
			attempts = 0
			local maxMatAttempts = isIdentical and 8 or 15
			
			repeat
				attempts = attempts + 1
				
				if _AB.tp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(paintPos + Vector3.new(0, 6, 0))
				end
				
				if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("Paint") and LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Paint") then
					LocalPlayer.Backpack.Paint.Parent = LocalPlayer.Character
				end
				
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Paint") then
					pcall(function()
						local event = LocalPlayer.Character.Paint:FindFirstChild("origevent")
							and LocalPlayer.Character.Paint.origevent:Invoke(unpack(textureArgs))
							or LocalPlayer.Character.Paint.Script.Event:FireServer(unpack(textureArgs))
					end)
				end
				
				task.wait(isIdentical and 0.04 or 0.08)
				
			until not _AB.childcube or not _AB.childcube.Parent or _AB.stopped or _AB.skipblock or attempts > maxMatAttempts
		end
	end
	
	if _AB.childcube and bsizev3 and (bsizev3.X ~= _AB.mult or bsizev3.Y ~= _AB.mult or bsizev3.Z ~= _AB.mult) and (LocalPlayer.Character:FindFirstChild("Shape") or LocalPlayer.Backpack:FindFirstChild("Shape")) then
		if not LocalPlayer.Character:FindFirstChild("Shape") and LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Shape") then
			LocalPlayer.Backpack.Shape.Parent = LocalPlayer.Character
		end
		
		local args = {[1] = _AB.childcube, [2] = Enum.NormalId.Right, [3] = "", [4] = ""}
		
		if _AB.childcube and _AB.childcube.Size.X ~= bsizev3.X then
			local c = 0
			repeat
				c = c + 1
				pos = (_AB.childcube and _AB.childcube.Position + _AB.childcube.Size/2) or pos
				args[4] = nil
				if _AB.childcube then
					args[3] = pos
					if _AB.childcube.Size.X > bsizev3.X then
						args[4] = "decrease"
					elseif _AB.childcube.Size.X < bsizev3.X then
						args[4] = "increase"
					end
				end
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Shape") then
					local event = (LocalPlayer.Character.Shape:FindFirstChild("origevent") and LocalPlayer.Character.Shape.origevent:Invoke(unpack(args))) or LocalPlayer.Character.Shape.Script.Event:FireServer(unpack(args))
				end
				task.wait(_AB.resizewait)
			until args[4] == nil or (args[4] == "decrease" and _AB.childcube and _AB.childcube.Size.X <= 1) or (_AB.childcube and _AB.childcube.Size.X == bsizev3.X) or _AB.stopped == true or _AB.skipblock == true or not _AB.childcube or c > (bsizev3.X*3)/_AB.resizewait
		end
		
		if _AB.childcube and _AB.childcube.Size.Y ~= bsizev3.Y then
			local c = 0
			repeat
				c = c + 1
				pos = (_AB.childcube and _AB.childcube.Position + _AB.childcube.Size/2) or pos
				args[4] = nil
				if _AB.childcube then
					args[2] = Enum.NormalId.Top
					args[3] = pos
					if _AB.childcube.Size.Y > bsizev3.Y then
						args[4] = "decrease"
					elseif _AB.childcube.Size.Y < bsizev3.Y then
						args[4] = "increase"
					end
				end
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Shape") then
					local event = (LocalPlayer.Character.Shape:FindFirstChild("origevent") and LocalPlayer.Character.Shape.origevent:Invoke(unpack(args))) or LocalPlayer.Character.Shape.Script.Event:FireServer(unpack(args))
				end
				task.wait(_AB.resizewait)
			until args[4] == nil or (args[4] == "decrease" and _AB.childcube and _AB.childcube.Size.Y <= 1) or (_AB.childcube and _AB.childcube.Size.Y == bsizev3.Y) or _AB.stopped == true or _AB.skipblock == true or not _AB.childcube or c > (bsizev3.Y*3)/_AB.resizewait
		end
		
		if _AB.childcube and _AB.childcube.Size.Z ~= bsizev3.Z then
			local c = 0
			repeat
				c = c + 1
				pos = (_AB.childcube and _AB.childcube.Position + _AB.childcube.Size/2) or pos
				args[4] = nil
				if _AB.childcube then
					args[2] = Enum.NormalId.Back
					args[3] = pos
					if _AB.childcube.Size.Z > bsizev3.Z then
						args[4] = "decrease"
					elseif _AB.childcube.Size.Z < bsizev3.Z then
						args[4] = "increase"
					end
				end
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Shape") then
					local event = (LocalPlayer.Character.Shape:FindFirstChild("origevent") and LocalPlayer.Character.Shape.origevent:Invoke(unpack(args))) or LocalPlayer.Character.Shape.Script.Event:FireServer(unpack(args))
				end
				task.wait(_AB.resizewait)
			until args[4] == nil or (args[4] == "decrease" and _AB.childcube and _AB.childcube.Size.Z <= 1) or (_AB.childcube and _AB.childcube.Size.Z == bsizev3.Z) or _AB.stopped == true or _AB.skipblock == true or not _AB.childcube or c > (bsizev3.Z*3)/_AB.resizewait
		end
	end
	
	_AB.highlight.Adornee = nil
	_AB.skipblock = false
	if _AB.oldprt then _AB.oldprt:Destroy() end
	_AB.novel = false
	_AB.childcube = nil
end

function _AB.saveblock(bl)
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
		if bl.Size.X ~= _AB.mult or bl.Size.Y ~= _AB.mult or bl.Size.Z ~= _AB.mult then
			blockdata.p[1] = (blockdata.p[1] - (bl.Size.X/2))+.5
			blockdata.p[2] = (blockdata.p[2] - (bl.Size.Y/2))+.5
			blockdata.p[3] = (blockdata.p[3] - (bl.Size.Z/2))+.5
			blockdata.s = {bl.Size.X,bl.Size.Y,bl.Size.Z}
		end
		blockdata.m = _AB.materials[bl.Material]
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

pcall(function()
	local files = _AB.listfilesfixed("")
	if (not table.find(files,"TCOLSaves/") and not table.find(files,"TCOLSaves")) then
		makefolder("TCOLSaves")
	end
end)

_AB.refreshBuilds = function()
	for _, btn in ipairs(_AB.dynamicButtons) do
		btn:Destroy()
	end
	_AB.dynamicButtons = {}
	
	local builds = _AB.getfn()
	table.sort(builds,function(a,b)
		return a:lower() < b:lower()
	end)
	
	for _, name in ipairs(builds) do
		local b = Building67:AddButton({
			Name = name,
			Info = "Click to select this build",
			Callback = function()
				_AB.selectedBuild = name
			end
		})
		table.insert(_AB.dynamicButtons, b)
	end
end

_AB.doSave = function(text)
	if text == "" then return end
	
	local builddata = {}
	
	if _AB.saveMode == "local" then
		local folder = workspace:FindFirstChild("Bricks")
		if not folder or not folder:FindFirstChild(LocalPlayer.Name) then
			return
		end
		
		for i,v in ipairs(folder[LocalPlayer.Name]:GetChildren()) do
			if v:IsA("BasePart") then
				table.insert(builddata, _AB.saveblock(v))
			end
		end
	else
		local folder = workspace:FindFirstChild("Bricks")
		if folder then
			for i,v in pairs(folder:GetChildren()) do
				if v:IsA("Model") then
					for i2,v2 in pairs(v:GetChildren()) do
						if v2:IsA("BasePart") then
							table.insert(builddata, _AB.saveblock(v2))
						end
					end
				end
			end
		end
	end
	
	if #builddata == 0 then return end
	
	local name = _AB.validate(text)
	if not _AB.savebuildnames[name] then _AB.savebuildnames[name] = 0 end
	_AB.savebuildnames[name] = _AB.savebuildnames[name] + 1
	local savename = name
	if _AB.savebuildnames[name] > 1 then savename = name..tostring(_AB.savebuildnames[name]) end
	
	writefile("TCOLSaves/" .. savename .. ".json", HttpService:JSONEncode(builddata))
	_AB.refreshBuilds()
end

_AB.doExport = function()
	if not _AB.selectedBuild or _AB.selectedBuild == "" then return end
	
	local fullPath = "TCOLSaves/" .. _AB.selectedBuild .. ".json"
	
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
end

_AB.doImport = function()
	local playerGui = LocalPlayer:WaitForChild("PlayerGui")
	local importGui = Instance.new("ScreenGui")
	importGui:SetAttribute("LegacySkin", true)
	importGui.Name = "ImportBuildGUI_"..tick()
	importGui.Parent = playerGui
	importGui.ResetOnSpawn = false
	
	local importFrame = Instance.new("Frame")
	importFrame.Size = UDim2.new(0, 500, 0, 600)
	importFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
	importFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	importFrame.BorderSizePixel = 0
	importFrame.Parent = importGui
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = importFrame
	
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(0,0,0)
	stroke.Transparency = 0.4
	stroke.Parent = importFrame
	
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
	titleLabel.BackgroundColor3 = Color3.fromRGB(18,18,18)
	titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
	titleLabel.BorderSizePixel = 0
	titleLabel.Parent = importFrame
	
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
	nameBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
	nameBox.TextColor3 = Color3.fromRGB(255,255,255)
	nameBox.Font = Enum.Font.Gotham
	nameBox.BorderSizePixel = 0
	nameBox.Parent = importFrame
	
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
	jsonBox.PlaceholderText = "Paste .Json code here"
	jsonBox.Text = ""
	jsonBox.TextSize = 11
	jsonBox.TextWrapped = true
	jsonBox.TextXAlignment = Enum.TextXAlignment.Left
	jsonBox.TextYAlignment = Enum.TextYAlignment.Top
	jsonBox.ClearTextOnFocus = false
	jsonBox.MultiLine = true
	jsonBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
	jsonBox.TextColor3 = Color3.fromRGB(255,255,255)
	jsonBox.Font = Enum.Font.Gotham
	jsonBox.BorderSizePixel = 0
	jsonBox.Parent = importFrame
	
	local confirmBtn = Instance.new("TextButton")
	confirmBtn.Size = UDim2.new(0.48,-12,0,40)
	confirmBtn.Position = UDim2.new(0,10,0,440)
	confirmBtn.Text = "CONFIRM"
	confirmBtn.TextSize = 12
	confirmBtn.Font = Enum.Font.GothamBold
	confirmBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	confirmBtn.TextColor3 = Color3.fromRGB(255,255,255)
	confirmBtn.BorderSizePixel = 0
	confirmBtn.Parent = importFrame
	
	confirmBtn.MouseButton1Click:Connect(function()
		if nameBox.Text == "" then return end
		if jsonBox.Text == "" then return end
		
		local isJsonValid = false
		pcall(function()
			local decodedData = HttpService:JSONDecode(jsonBox.Text)
			if decodedData and typeof(decodedData) == "table" then
				isJsonValid = true
			end
		end)
		
		if not isJsonValid then return end
		
		local name = _AB.validate(nameBox.Text)
		if not _AB.savebuildnames[name] then _AB.savebuildnames[name] = 0 end
		_AB.savebuildnames[name] = _AB.savebuildnames[name] + 1
		local savename = name
		if _AB.savebuildnames[name] > 1 then savename = name..tostring(_AB.savebuildnames[name]) end
		
		pcall(function()
			writefile("TCOLSaves/" .. savename .. ".json", jsonBox.Text)
			_AB.refreshBuilds()
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
	cancelBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	cancelBtn.TextColor3 = Color3.fromRGB(255,255,255)
	cancelBtn.BorderSizePixel = 0
	cancelBtn.Parent = importFrame
	
	cancelBtn.MouseButton1Click:Connect(function()
		importGui:Destroy()
	end)
end

_AB.loadSelected = function()
	if not _AB.selectedBuild or _AB.selectedBuild == "" then return end
	
	_AB.stopped = false
	
	task.spawn(function()
		local path = "TCOLSaves/" .. _AB.selectedBuild .. ".json"
		if not isfile(path) then return end
		
		local data = HttpService:JSONDecode(readfile(path))
		if not data then return end
		
		local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local bp = LocalPlayer:WaitForChild("Backpack")
		
		if bp:FindFirstChild("Build") then
			bp:FindFirstChild("Build").Parent = char
		end
		
		for i, b in ipairs(data) do
			if _AB.stopped then break end
			
			local posses = (b.p or b.pos)
			local pos = Vector3.new(posses[1], posses[2], posses[3]) + _AB.offset
			local color = Color3.fromRGB(table.unpack(b.c or b.color))
			local bsize = nil
			if b.s or b.size then
				bsize = Vector3.new(table.unpack(b.s or b.size))
			end
			
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
			end
			
			_AB.buildblock(pos, b.m or b.mat, color, nil, bsize, nil, b.o or b.origmat, b.sp or b.sprayed, b.a or b.anchored, b.cc or b.collide)
			task.wait(_AB.buildSpeed)
		end
	end)
end

_AB.setOffset = function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		_AB.offset = _AB.round(workspace.Spawn.Position + char.HumanoidRootPart.Position)
	end
end

_AB.optimizeAll = function()
	for i,v in pairs(_AB.getfn()) do
		local path = "TCOLSaves/" .. v .. ".json"
		if isfile(path) then
			local data = HttpService:JSONDecode(readfile(path))
			for i,b in pairs(data) do
				if b.pos then b.p = b.pos; b.pos = nil end
				if b.size then b.s = b.size; b.size = nil end
				if b.color then b.c = b.color; b.color = nil end
				if b.material then b.m = b.material; b.material = nil end
				if b.anchored then b.a = b.anchored; b.anchored = nil end
				if b.collide then b.cc = b.collide; b.collide = nil end
			end
			writefile(path, HttpService:JSONEncode(data))
		end
	end
end

_AB.deleteSelected = function()
	if not _AB.selectedBuild or _AB.selectedBuild == "" then return end
	
	local path = "TCOLSaves/" .. _AB.selectedBuild .. ".json"
	if isfile(path) then
		delfile(path)
		_AB.selectedBuild = nil
		_AB.refreshBuilds()
	end
end

_AB.refreshBuilds()

pcall(function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local StarterGui = game:GetService("StarterGui")
	local lp = Players.LocalPlayer

	local connections = {}

	local function stopLoop(key)
		if connections[key] then
			connections[key]:Disconnect()
			connections[key] = nil
		end
	end

	local function startLoop(key, interval, fn)
		stopLoop(key)
		local elapsed = 0
		connections[key] = RunService.Heartbeat:Connect(function(dt)
			elapsed = elapsed + dt
			if elapsed < interval then
				return
			end
			elapsed = 0
			pcall(fn)
		end)
	end

	local function makePrompt(text, cooldown, action)
		local busy = false
		local bind = Instance.new("BindableFunction")
		function bind.OnInvoke(choice)
			if choice == "Yes" then
				pcall(action)
				busy = false
			end
		end
		return function()
			if busy then
				return
			end
			busy = true
			pcall(function()
				StarterGui:SetCore("SendNotification", {
					Title = "Notification",
					Text = text,
					Callback = bind,
					Button1 = "Yes",
					Button2 = "No",
					Duration = cooldown,
				})
			end)
			task.delay(cooldown, function()
				busy = false
			end)
		end
	end

	local function getHumanoid()
		local char = lp.Character
		return char and char:FindFirstChildOfClass("Humanoid")
	end

	local askReset = makePrompt("Reset your character?", 5, function()
		local hum = getHumanoid()
		if hum then
			hum.Health = 0
		end
	end)

	local askUnstun = makePrompt("UnTackle your character?", 20, function()
		local hum = getHumanoid()
		if hum then
			hum.PlatformStand = false
			hum.Sit = false
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end)

	local function breakVelocity()
		task.spawn(function()
			local zero = Vector3.new(0, 0, 0)
			local finish = tick() + 1
			while tick() < finish do
				local char = lp.Character
				if char then
					for _, part in ipairs(char:GetChildren()) do
						if part:IsA("BasePart") then
							part.AssemblyLinearVelocity = zero
							part.AssemblyAngularVelocity = zero
						end
					end
				end
				RunService.Heartbeat:Wait()
			end
		end)
	end

	Anti67:AddToggle({
		Name = "Anti Gravity",
		Info = "Keeps the gravity at its normal value",
		Default = false,
		Callback = function(value)
			if value then
				startLoop("AntiGravity", 0.1, function()
					if lp:GetAttribute("Flying") == true then
						return
					end
					if workspace.Gravity ~= 196.2 then
						workspace.Gravity = 196.2
					end
				end)
			else
				stopLoop("AntiGravity")
			end
		end,
	})

	Anti67:AddToggle({
		Name = "Anti Drag",
		Info = "Prevents other players from dragging you",
		Default = false,
		Callback = function(value)
			if value then
				startLoop("AntiDrag", 0.1, function()
					local char = lp.Character
					if not char then
						return
					end
					local dragger = char:FindFirstChild("Dragger")
					local hum = char:FindFirstChildOfClass("Humanoid")
					if dragger and hum then
						dragger.ResponseStyle = Enum.DragDetectorResponseStyle.Custom
						if hum.PlatformStand then
							hum.PlatformStand = false
							hum.Sit = false
							hum:ChangeState(Enum.HumanoidStateType.GettingUp)
						end
					end
				end)
			else
				stopLoop("AntiDrag")
			end
		end,
	})

	Anti67:AddToggle({
		Name = "Anti Invisible",
		Info = "Asks to reset you when your body gets invisible",
		Default = false,
		Callback = function(value)
			if value then
				startLoop("AntiInvisible", 0.5, function()
					local char = lp.Character
					if not char then
						return
					end
					local torso = char:FindFirstChild("Torso")
					if torso and char:FindFirstChild("Humanoid") and torso.Transparency == 1 then
						askReset()
					end
				end)
			else
				stopLoop("AntiInvisible")
			end
		end,
	})

	Anti67:AddToggle({
		Name = "Anti Stun",
		Info = "Asks to untackle you when you get stunned",
		Default = false,
		Callback = function(value)
			if value then
				startLoop("AntiStun", 0.5, function()
					local hum = getHumanoid()
					if hum and hum.PlatformStand == true then
						askUnstun()
					end
				end)
			else
				stopLoop("AntiStun")
			end
		end,
	})

	Anti67:AddToggle({
		Name = "Anti Farlands",
		Info = "Brings you back to the map if you get flung too far away",
		Default = false,
		Callback = function(value)
			if value then
				startLoop("AntiFarlands", 0.1, function()
					local char = lp.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					if not hrp then
						return
					end
					local pos = hrp.Position
					if math.abs(pos.X) > 10000 or math.abs(pos.Y) > 10000 or math.abs(pos.Z) > 10000 then
						char:PivotTo(CFrame.new(0, 51, 0))
						hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						breakVelocity()
					end
				end)
			else
				stopLoop("AntiFarlands")
			end
		end,
	})

	Anti67:AddToggle({
		Name = "Anti Cursed",
		Info = "Disables the cursed lighting effects",
		Default = false,
		Callback = function(value)
			if value then
				local lighting = game:GetService("Lighting")
				startLoop("AntiCursed", 0.5, function()
					local rgb = lighting:FindFirstChild("RGB")
					if rgb then
						rgb.Enabled = false
					end
					local cc = lighting:FindFirstChild("ColorCorrection")
					if cc then
						cc.Enabled = false
					end
				end)
			else
				stopLoop("AntiCursed")
			end
		end,
	})

	local walkSpeedValue = 16
	local jumpPowerValue = 50
	local walkSpeedTouched = false
	local jumpPowerTouched = false

	local function applyCharacterStats()
		local hum = getHumanoid()
		if not hum then
			return
		end
		if walkSpeedTouched then
			hum.WalkSpeed = walkSpeedValue
		end
		if jumpPowerTouched then
			pcall(function()
				hum.JumpPower = jumpPowerValue
			end)
			pcall(function()
				hum.JumpHeight = jumpPowerValue * 0.56
			end)
		end
	end

	lp.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid", 10)
		task.wait(0.5)
		applyCharacterStats()
	end)

	LP67:AddSlider({
		Name = "Walk Speed",
		Info = "Set your character walk speed",
		Min = 16,
		Max = 100,
		Default = 16,
		Callback = function(value)
			walkSpeedValue = value
			walkSpeedTouched = true
			applyCharacterStats()
		end,
	})

	LP67:AddSlider({
		Name = "Jump Power",
		Info = "Set your character jump power",
		Min = 50,
		Max = 100,
		Default = 50,
		Callback = function(value)
			jumpPowerValue = value
			jumpPowerTouched = true
			applyCharacterStats()
		end,
	})

	LP67:AddToggle({
		Name = "Noclip",
		Info = "Walk through blocks and walls",
		Default = false,
		Callback = function(value)
			if value then
				connections.Noclip = RunService.Stepped:Connect(function()
					local char = lp.Character
					if not char then
						return
					end
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end)
			else
				stopLoop("Noclip")
				local char = lp.Character
				if char then
					for _, name in ipairs({ "Head", "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart" }) do
						local part = char:FindFirstChild(name)
						if part and part:IsA("BasePart") then
							part.CanCollide = true
						end
					end
				end
			end
		end,
	})
end)
pcall(function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local lp = Players.LocalPlayer

	local Auras67 = NS:AddGroup({
		Name = "Auras🌀",
		Info = "Auras🌀",
		Side = "Left",
	})

	local range = 150
	local speed = 100
	local rainbowTerrain = false
	local auraConnections = {}
	local toggles = {}
	local recent = {}

	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Include
	overlapParams.MaxParts = 20000

	local function getFolder()
		return workspace:FindFirstChild("Bricks") or workspace:FindFirstChild("Cubes")
	end

	local function scanBlocks(center, includeTerrain)
		local folder = getFolder()
		local found = {}
		if folder then
			overlapParams.FilterDescendantsInstances = { folder }
			local size = Vector3.new(range * 2, range * 2, range * 2)
			local ok, parts = pcall(workspace.GetPartBoundsInBox, workspace, CFrame.new(center), size, overlapParams)
			if ok and type(parts) == "table" then
				for _, part in ipairs(parts) do
					found[#found + 1] = part
				end
			end
		end
		if includeTerrain then
			for _, part in ipairs(workspace:GetChildren()) do
				if part:IsA("BasePart") and part.Anchored and (part.Position - center).Magnitude <= range * 1.75 then
					found[#found + 1] = part
				end
			end
		end
		local distances = {}
		for _, part in ipairs(found) do
			distances[part] = (part.Position - center).Magnitude
		end
		table.sort(found, function(a, b)
			return distances[a] < distances[b]
		end)
		return found
	end

	local function equipTool(name)
		local char = lp.Character
		local backpack = lp:FindFirstChild("Backpack")
		if not char then
			return nil
		end
		local tool = char:FindFirstChild(name) or (backpack and backpack:FindFirstChild(name))
		if tool and tool.Parent ~= char then
			tool.Parent = char
		end
		return tool
	end

	local function getPaintEvent()
		local tool = equipTool("Paint")
		local toolScript = tool and tool:FindFirstChild("Script")
		return toolScript and toolScript:FindFirstChild("Event")
	end

	local function getBucketRemote()
		local tool = equipTool("PaintBucket")
		local remotes = tool and tool:FindFirstChild("Remotes")
		return remotes and remotes:FindFirstChild("ServerControls")
	end

	local function onCooldown(block, seconds)
		local last = recent[block]
		if last and tick() - last < seconds then
			return true
		end
		recent[block] = tick()
		return false
	end

	local auraDefinitions = {
		Rainbow = {
			includeTerrain = function()
				return rainbowTerrain
			end,
			fire = function(block)
				local color = Color3.fromHSV((tick() * 0.2 + block.Position.X * 0.01) % 1, 1, 1)
				local bucket = getBucketRemote()
				if bucket then
					task.spawn(function()
						pcall(bucket.InvokeServer, bucket, "PaintPart", { Part = block, Color = color })
					end)
					return
				end
				local event = getPaintEvent()
				if event then
					event:FireServer(block, Enum.NormalId.Top, block.Position, "color", color, "", "")
				end
			end,
		},
		Toxic = {
			includeTerrain = function()
				return false
			end,
			fire = function(block)
				if onCooldown(block, 4) then
					return
				end
				local event = getPaintEvent()
				if event then
					event:FireServer(block, Enum.NormalId.Top, block.Position, "material", Color3.new(0, 0, 0), "toxic", "")
				end
			end,
		},
		Anchor = {
			includeTerrain = function()
				return false
			end,
			fire = function(block)
				if block.Anchored or onCooldown(block, 2) then
					return
				end
				local event = getPaintEvent()
				if event then
					event:FireServer(block, Enum.NormalId.Top, block.Position, "material", nil, "anchor", "")
				end
			end,
		},
		Unanchor = {
			includeTerrain = function()
				return false
			end,
			fire = function(block)
				if not block.Anchored or onCooldown(block, 2) then
					return
				end
				local event = getPaintEvent()
				if event then
					event:FireServer(block, Enum.NormalId.Top, block.Position, "material", nil, "anchor", "")
				end
			end,
		},
	}

	local function stopAura(name)
		if auraConnections[name] then
			auraConnections[name]:Disconnect()
			auraConnections[name] = nil
		end
	end

	local function startAura(name)
		stopAura(name)
		local definition = auraDefinitions[name]
		local queue = {}
		local index = 1
		local allowance = 0
		auraConnections[name] = RunService.Heartbeat:Connect(function(dt)
			local char = lp.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then
				return
			end
			allowance = math.min(allowance + dt * speed, math.max(speed, 20))
			while allowance >= 1 do
				if index > #queue then
					queue = scanBlocks(hrp.Position, definition.includeTerrain())
					index = 1
					if next(recent) ~= nil and #queue == 0 then
						recent = {}
					end
					if #queue == 0 then
						allowance = 0
						return
					end
				end
				local block = queue[index]
				index = index + 1
				allowance = allowance - 1
				if block and block.Parent then
					pcall(definition.fire, block)
				end
			end
		end)
	end

	local function addAura(name, info)
		toggles[name] = Auras67:AddToggle({
			Name = name .. " Aura",
			Info = info,
			Default = false,
			Callback = function(value)
				if value then
					startAura(name)
				else
					stopAura(name)
				end
			end,
		})
	end

	addAura("Rainbow", "Paints every block in range with rainbow colors, one after another")

	Auras67:AddToggle({
		Name = "Rainbow Terrain",
		Info = "Rainbow Aura also paints the terrain and ground parts",
		Default = false,
		Callback = function(value)
			rainbowTerrain = value
		end,
	})

	addAura("Toxic", "Toxifies every block in range")
	addAura("Anchor", "Anchors every unanchored block in range")
	addAura("Unanchor", "Unanchors every anchored block in range")

	Auras67:AddSlider({
		Name = "Aura Range",
		Info = "Cube radius around you affected by the auras",
		Min = 5,
		Max = 250,
		Default = 150,
		Callback = function(value)
			range = math.floor(value)
		end,
	})

	Auras67:AddSlider({
		Name = "Aura Speed",
		Info = "Blocks processed per second by each aura",
		Min = 5,
		Max = 200,
		Default = 100,
		Callback = function(value)
			speed = math.floor(value)
		end,
	})

	Auras67:AddButton({
		Name = "Stop All Auras",
		Info = "Turns off every aura of this group",
		Callback = function()
			for _, toggle in pairs(toggles) do
				toggle:Set(false)
			end
			for name in pairs(auraConnections) do
				stopAura(name)
			end
		end,
	})
end)

pcall(function()
	local RunService = game:GetService("RunService")
	local Lighting = game:GetService("Lighting")

	local World67 = NS:AddGroup({
		Name = "World🌅",
		Info = "World🌅",
		Side = "Right",
	})

	local cycleSpeed = 0.5
	local currentTime = Lighting.ClockTime
	local settingTime = false
	local cycleConnection = nil
	local overrideConnection = nil

	local function stopCycle()
		if cycleConnection then
			cycleConnection:Disconnect()
			cycleConnection = nil
		end
		if overrideConnection then
			overrideConnection:Disconnect()
			overrideConnection = nil
		end
	end

	World67:AddToggle({
		Name = "Day/Night Cycle",
		Info = "Smoothly cycles day and night overriding the game",
		Default = false,
		Callback = function(value)
			stopCycle()
			if not value then
				return
			end
			currentTime = Lighting.ClockTime
			overrideConnection = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
				if not settingTime then
					settingTime = true
					Lighting.ClockTime = currentTime
					settingTime = false
				end
			end)
			cycleConnection = RunService.Heartbeat:Connect(function(dt)
				currentTime = (currentTime + dt * cycleSpeed) % 24
				settingTime = true
				Lighting.ClockTime = currentTime
				settingTime = false
			end)
		end,
	})

	World67:AddSlider({
		Name = "Cycle Speed",
		Info = "In game hours per real second",
		Min = 0.1,
		Max = 5,
		Default = 0.5,
		Callback = function(value)
			cycleSpeed = value
		end,
	})
end)


pcall(function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local CoreGui = game:GetService("CoreGui")
	local TextChatService = game:GetService("TextChatService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local lp = Players.LocalPlayer
	local mouse = lp:GetMouse()

	local FONT = Enum.Font.Garamond
	local TEXT_COLOR = Color3.fromRGB(242, 236, 226)
	local ALL_FACES = {
		Enum.NormalId.Top,
		Enum.NormalId.Bottom,
		Enum.NormalId.Front,
		Enum.NormalId.Back,
		Enum.NormalId.Left,
		Enum.NormalId.Right,
	}

	local function getFolder()
		return workspace:FindFirstChild("Cubes") or workspace:FindFirstChild("Bricks")
	end

	local function isOG()
		return workspace:FindFirstChild("Cubes") ~= nil
	end

	local function getHrp()
		local char = lp.Character
		return char and char:FindFirstChild("HumanoidRootPart")
	end

	local function getPos()
		local hrp = getHrp()
		return hrp and hrp.Position or Vector3.new(0, 0, 0)
	end

	local function say(text)
		pcall(function()
			TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(
				string.format("<font color='#%s'>%s</font>", Color3.fromRGB(0, 170, 255):ToHex(), text)
			)
		end)
	end

	local function chat(msg)
		pcall(function()
			TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
		end)
	end

	local function sanitizeName(txt)
		if string.sub(txt, 1, 3):lower() == "btc" then
			txt = "bt"
		end
		if string.sub(txt, 1, 3):lower() == "fat" then
			txt = "fa"
		end
		if not isOG() then
			txt = string.gsub(txt, "_", ".")
		end
		return string.sub(txt, 1, 7)
	end

	local function resolvePlayer(part)
		local current = part
		while current and current ~= workspace and current ~= game do
			local found = Players:GetPlayerFromCharacter(current)
			if found then
				return found
			end
			current = current.Parent
		end
		return nil
	end

	local function isSelectable(part, hit)
		local folder = getFolder()
		local hrp = getHrp()
		if part and hit and folder and hrp then
			return (hit - hrp.Position).Magnitude < 30 and part:IsDescendantOf(folder)
		end
		return false
	end

	local function equipTool(name)
		local char = lp.Character
		local backpack = lp:FindFirstChild("Backpack")
		if not char then
			return nil
		end
		local tool = char:FindFirstChild(name) or (backpack and backpack:FindFirstChild(name))
		if tool and tool.Parent ~= char then
			tool.Parent = char
			task.wait()
		end
		return tool
	end

	local function paintFire(...)
		local args = table.pack(...)
		local tool = equipTool("Paint")
		if not tool then
			return false
		end
		local orig = tool:FindFirstChild("origevent")
		if orig then
			return pcall(function()
				orig:Invoke(table.unpack(args, 1, args.n))
			end)
		end
		local toolScript = tool:FindFirstChild("Script")
		local event = toolScript and toolScript:FindFirstChild("Event")
		if event then
			return pcall(function()
				event:FireServer(table.unpack(args, 1, args.n))
			end)
		end
		return false
	end

	local function deleteBlock(block)
		local hrp = getHrp()
		if not hrp then
			return false
		end
		local tool = equipTool("Delete")
		if not tool then
			return false
		end
		if isOG() then
			local events = lp.Backpack:FindFirstChild("Events")
			if events then
				return pcall(function()
					events:FireServer(hrp.Position, Enum.NormalId.Top, block)
				end)
			end
			return false
		end
		local toolScript = tool:FindFirstChild("Script")
		local event = toolScript and toolScript:FindFirstChild("Event")
		if event then
			return pcall(function()
				event:FireServer(block, hrp.Position)
			end)
		end
		return false
	end

	local function giveTool(tool)
		tool.Parent = lp:WaitForChild("Backpack")
	end

	local function addPiece(tool, handle, shape, size, offset, color, material, transparency)
		local piece
		if shape == "Wedge" then
			piece = Instance.new("WedgePart")
		else
			piece = Instance.new("Part")
			if shape == "Ball" then
				piece.Shape = Enum.PartType.Ball
			elseif shape == "Cylinder" then
				piece.Shape = Enum.PartType.Cylinder
			end
		end
		piece.Size = size
		piece.Color = color
		piece.Material = material or Enum.Material.SmoothPlastic
		piece.Transparency = transparency or 0
		piece.CanCollide = false
		piece.CanQuery = false
		piece.CanTouch = false
		piece.Massless = true
		piece.CastShadow = false
		piece.CFrame = handle.CFrame * offset
		local weld = Instance.new("Weld")
		weld.Part0 = handle
		weld.Part1 = piece
		weld.C0 = offset
		weld.Parent = piece
		piece.Parent = tool
		return piece
	end

	local DARK = Color3.fromRGB(34, 37, 46)
	local NEON = Enum.Material.Neon
	local METAL = Enum.Material.Metal
	local PLASTIC = Enum.Material.SmoothPlastic
	local GLASS = Enum.Material.Glass
	local ALONG_Z = CFrame.Angles(0, math.rad(90), 0)

	local designs = {}

	designs["Clone Tool"] = function(tool, handle, color)
		addPiece(tool, handle, "Ball", Vector3.new(0.5, 0.5, 0.5), CFrame.new(0, 0, 1.15), color, NEON)
		addPiece(tool, handle, "Block", Vector3.new(1, 0.16, 0.16), CFrame.new(0, 0, -0.95), DARK, METAL)
		addPiece(tool, handle, "Block", Vector3.new(0.75, 0.75, 0.75), CFrame.new(0, 0, -1.5), color, NEON)
		addPiece(
			tool,
			handle,
			"Block",
			Vector3.new(0.75, 0.75, 0.75),
			CFrame.new(0.42, 0.42, -1.92),
			color,
			GLASS,
			0.45
		)
	end

	designs["Move Tool"] = function(tool, handle, color)
		addPiece(tool, handle, "Ball", Vector3.new(0.6, 0.6, 0.6), CFrame.new(0, 0, -1.4), color, NEON)
		addPiece(tool, handle, "Block", Vector3.new(1.3, 0.13, 0.13), CFrame.new(0, 0, -1.4), Color3.fromRGB(255, 80, 80), NEON)
		addPiece(tool, handle, "Block", Vector3.new(0.13, 1.3, 0.13), CFrame.new(0, 0, -1.4), Color3.fromRGB(80, 255, 120), NEON)
		addPiece(tool, handle, "Block", Vector3.new(0.13, 0.13, 1.3), CFrame.new(0, 0, -1.4), Color3.fromRGB(80, 160, 255), NEON)
		for _, tip in ipairs({
			Vector3.new(0.65, 0, 0),
			Vector3.new(-0.65, 0, 0),
			Vector3.new(0, 0.65, 0),
			Vector3.new(0, -0.65, 0),
			Vector3.new(0, 0, -0.65),
		}) do
			addPiece(tool, handle, "Ball", Vector3.new(0.2, 0.2, 0.2), CFrame.new(tip + Vector3.new(0, 0, -1.4)), Color3.new(1, 1, 1), NEON)
		end
	end

	designs["Editor Tool"] = function(tool, handle, color)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.22, 1.05, 1.05), CFrame.new(0, 0, -1.45), color, NEON)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.3, 0.5, 0.5), CFrame.new(0, 0, -1.45), DARK, METAL)
		for index = 0, 5 do
			local angle = math.rad(index * 60)
			addPiece(
				tool,
				handle,
				"Block",
				Vector3.new(0.22, 0.24, 0.24),
				CFrame.new(0, math.sin(angle) * 0.58, -1.45 + math.cos(angle) * 0.58),
				color,
				NEON
			)
		end
		addPiece(tool, handle, "Block", Vector3.new(0.45, 0.45, 0.2), CFrame.new(0, 0, 0.9), color, NEON)
	end

	designs["Replication Tool"] = function(tool, handle, color)
		addPiece(tool, handle, "Ball", Vector3.new(0.7, 0.7, 0.7), CFrame.new(0, 0, -1.3), color, NEON)
		addPiece(tool, handle, "Ball", Vector3.new(0.7, 0.7, 0.7), CFrame.new(0, 0, -2), color, GLASS, 0.5)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.08, 1.15, 1.15), CFrame.new(0, 0, -1.65) * ALONG_Z, Color3.new(1, 1, 1), NEON, 0.2)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.08, 0.8, 0.8), CFrame.new(0, 0, -0.9) * ALONG_Z, color, NEON, 0.1)
	end

	designs["Moderation Tool"] = function(tool, handle, color)
		addPiece(tool, handle, "Cylinder", Vector3.new(1.3, 0.62, 0.62), CFrame.new(0, 0, -1.4), color, PLASTIC)
		addPiece(tool, handle, "Block", Vector3.new(0.14, 0.78, 0.78), CFrame.new(0.68, 0, -1.4), DARK, METAL)
		addPiece(tool, handle, "Block", Vector3.new(0.14, 0.78, 0.78), CFrame.new(-0.68, 0, -1.4), DARK, METAL)
		addPiece(tool, handle, "Block", Vector3.new(0.3, 0.3, 0.3), CFrame.new(0, 0, -1.4), Color3.new(1, 1, 1), NEON)
		addPiece(tool, handle, "Ball", Vector3.new(0.45, 0.45, 0.45), CFrame.new(0, 0, 1.15), color, NEON)
	end

	designs["Giver Tool"] = function(tool, handle, color)
		addPiece(tool, handle, "Block", Vector3.new(0.85, 0.85, 0.85), CFrame.new(0, 0, -1.5), color, PLASTIC)
		addPiece(tool, handle, "Block", Vector3.new(0.14, 0.92, 0.92), CFrame.new(0, 0, -1.5), Color3.fromRGB(255, 240, 120), NEON)
		addPiece(tool, handle, "Block", Vector3.new(0.92, 0.14, 0.92), CFrame.new(0, 0, -1.5), Color3.fromRGB(255, 240, 120), NEON)
		addPiece(tool, handle, "Ball", Vector3.new(0.34, 0.34, 0.34), CFrame.new(0.2, 0.5, -1.5), Color3.fromRGB(255, 240, 120), NEON)
		addPiece(tool, handle, "Ball", Vector3.new(0.34, 0.34, 0.34), CFrame.new(-0.2, 0.5, -1.5), Color3.fromRGB(255, 240, 120), NEON)
	end

	designs["Trap Editor Tool"] = function(tool, handle, color)
		addPiece(
			tool,
			handle,
			"Block",
			Vector3.new(0.65, 0.65, 0.65),
			CFrame.new(0, 0, -1.5) * CFrame.Angles(math.rad(45), math.rad(45), 0),
			color,
			NEON
		)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.08, 1.25, 1.25), CFrame.new(0, 0, -1.5) * ALONG_Z, Color3.new(1, 1, 1), NEON, 0.25)
		for _, direction in ipairs({
			Vector3.new(0.55, 0, 0),
			Vector3.new(-0.55, 0, 0),
			Vector3.new(0, 0.55, 0),
			Vector3.new(0, -0.55, 0),
		}) do
			addPiece(tool, handle, "Wedge", Vector3.new(0.16, 0.34, 0.16), CFrame.new(direction + Vector3.new(0, 0, -1.5)), Color3.new(1, 1, 1), NEON)
		end
	end

	designs["RoTool"] = function(tool, handle, color)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.12, 1.15, 1.15), CFrame.new(0, 0, -1.5) * ALONG_Z, color, NEON)
		addPiece(tool, handle, "Cylinder", Vector3.new(0.16, 0.82, 0.82), CFrame.new(0, 0, -1.5) * ALONG_Z, DARK, METAL)
		addPiece(tool, handle, "Ball", Vector3.new(0.3, 0.3, 0.3), CFrame.new(0, 0, -1.5), color, NEON)
		addPiece(tool, handle, "Ball", Vector3.new(0.2, 0.2, 0.2), CFrame.new(0, 0.58, -1.5), Color3.new(1, 1, 1), NEON)
		addPiece(tool, handle, "Wedge", Vector3.new(0.14, 0.3, 0.22), CFrame.new(0.58, 0, -1.5) * CFrame.Angles(0, 0, math.rad(90)), Color3.new(1, 1, 1), NEON)
		addPiece(tool, handle, "Wedge", Vector3.new(0.14, 0.3, 0.22), CFrame.new(-0.58, 0, -1.5) * CFrame.Angles(0, 0, math.rad(-90)), Color3.new(1, 1, 1), NEON)
	end

	local function newTool(name, tip, color)
		local tool = Instance.new("Tool")
		tool.Name = name
		tool.ToolTip = tip
		tool.RequiresHandle = true
		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(0.34, 0.34, 2.3)
		handle.Color = DARK
		handle.Material = METAL
		handle.CanCollide = false
		handle.Parent = tool
		addPiece(tool, handle, "Block", Vector3.new(0.4, 0.4, 0.28), CFrame.new(0, 0, 0.55), color, NEON)
		addPiece(tool, handle, "Block", Vector3.new(0.4, 0.4, 0.28), CFrame.new(0, 0, 0.05), color, NEON)
		local design = designs[name]
		if design then
			pcall(design, tool, handle, color)
		end
		return tool
	end

	local function bindCleanup(tool, connections, cleanup)
		table.insert(
			connections,
			tool.AncestryChanged:Connect(function()
				if tool.Parent and tool.Parent.Parent then
					return
				end
				for _, connection in ipairs(connections) do
					pcall(function()
						connection:Disconnect()
					end)
				end
				if cleanup then
					pcall(cleanup)
				end
			end)
		)
	end

	local TweenService = game:GetService("TweenService")

	local function tweenTo(obj, props, duration)
		TweenService:Create(obj, TweenInfo.new(duration or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
	end

	local function addStroke(parent, thickness)
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Thickness = thickness
		stroke.Parent = parent
		local metal = Instance.new("UIGradient")
		metal.Rotation = 90
		metal.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 80, 78)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(26, 26, 29)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 4, 6)),
		})
		metal.Parent = stroke
		return stroke
	end

	local function addCorner(parent, radius)
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, radius)
		corner.Parent = parent
		return corner
	end

	local function limitText(parent, size)
		local constraint = Instance.new("UITextSizeConstraint")
		constraint.MaxTextSize = size
		constraint.Parent = parent
		return constraint
	end

	local function addSurface(obj, rotation)
		local gradient = Instance.new("UIGradient")
		gradient.Rotation = rotation or 90
		gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(138, 138, 146))
		gradient.Parent = obj
		return gradient
	end

	local function addBevel(obj)
		local rim = Instance.new("Frame")
		rim.Name = "Bevel"
		rim.BackgroundTransparency = 1
		rim.BorderSizePixel = 0
		rim.Active = false
		rim.Size = UDim2.new(1, -6, 1, -6)
		rim.Position = UDim2.new(0, 3, 0, 3)
		rim.ZIndex = obj.ZIndex
		rim.Parent = obj
		addCorner(rim, 7)
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Thickness = 1
		stroke.Transparency = 0.45
		stroke.Parent = rim
		local gradient = Instance.new("UIGradient")
		gradient.Rotation = 90
		gradient.Color = ColorSequence.new(Color3.fromRGB(92, 88, 86), Color3.fromRGB(10, 10, 12))
		gradient.Parent = stroke
		return rim
	end

	local function sinkApply(obj, sunk, duration)
		duration = duration or 0.08
		local depth = obj:GetAttribute("SinkDepth") or 3
		local padding = obj:FindFirstChild("SinkPad")
		if not padding then
			padding = Instance.new("UIPadding")
			padding.Name = "SinkPad"
			padding.Parent = obj
		end
		tweenTo(padding, { PaddingTop = UDim.new(0, sunk and depth or 0) }, duration)
		local surface = obj:FindFirstChildOfClass("UIGradient")
		if surface then
			tweenTo(surface, { Rotation = sunk and 270 or 90 }, duration)
		end
		local outline = obj:FindFirstChildOfClass("UIStroke")
		local outlineGradient = outline and outline:FindFirstChildOfClass("UIGradient")
		if outlineGradient then
			tweenTo(outlineGradient, { Rotation = sunk and 270 or 90 }, duration)
		end
		local bevel = obj:FindFirstChild("Bevel")
		local bevelStroke = bevel and bevel:FindFirstChildOfClass("UIStroke")
		local bevelGradient = bevelStroke and bevelStroke:FindFirstChildOfClass("UIGradient")
		if bevelGradient then
			tweenTo(bevelGradient, { Rotation = sunk and 270 or 90 }, duration)
		end
	end

	local function sinkPress(obj, pressed, duration)
		sinkApply(obj, pressed or obj:GetAttribute("Sunk") == true, duration)
	end

	local function setSunk(obj, sunk, duration)
		obj:SetAttribute("Sunk", sunk)
		sinkApply(obj, sunk, duration)
	end

	local BUTTON_COLOR = Color3.fromRGB(50, 50, 54)

	local function makeButton(parent, text, callback)
		local button = Instance.new("TextButton")
		button.BackgroundColor3 = BUTTON_COLOR
		button.BackgroundTransparency = 0
		button.BorderSizePixel = 0
		button.Font = FONT
		button.Text = text
		button.TextColor3 = TEXT_COLOR
		button.TextScaled = true
		button.AutoButtonColor = false
		button.Parent = parent
		addStroke(button, 2)
		addCorner(button, 10)
		addSurface(button)
		addBevel(button)
		limitText(button, 17)
		button:SetAttribute("SinkDepth", 4)

		local pressedAt = 0
		local function release()
			local stamp = pressedAt
			task.delay(math.max(0, 0.14 - (tick() - pressedAt)), function()
				if pressedAt == stamp then
					sinkPress(button, false, 0.14)
				end
			end)
		end
		button.MouseButton1Down:Connect(function()
			pressedAt = tick()
			sinkPress(button, true, 0.05)
		end)
		button.MouseButton1Up:Connect(release)
		button.MouseLeave:Connect(release)

		if callback then
			button.MouseButton1Click:Connect(callback)
		end
		return button
	end

	local function setButtonState(button, on)
		setSunk(button, on, 0.12)
	end

	local function createPanel(name, title, width)
		local gui = Instance.new("ScreenGui")
		gui.Name = name
		gui.ResetOnSpawn = false
		gui.IgnoreGuiInset = true
		gui.Enabled = false
		gui:SetAttribute("ThemeRoot", true)
		gui.Parent = CoreGui

		local main = Instance.new("Frame")
		main.Parent = gui
		main.BackgroundColor3 = Color3.fromRGB(28, 28, 31)
		main.BackgroundTransparency = 0.04
		main.BorderSizePixel = 0
		main.AnchorPoint = Vector2.new(1, 0)
		main.Position = UDim2.new(1, -12, 0.2, 0)
		main.Size = UDim2.new(0, width, 0, 0)
		main.AutomaticSize = Enum.AutomaticSize.Y
		main.Active = true
		main.Draggable = true
		addStroke(main, 3)
		addCorner(main, 14)
		addSurface(main)

		local padding = Instance.new("UIPadding")
		padding.PaddingTop = UDim.new(0, 8)
		padding.PaddingBottom = UDim.new(0, 8)
		padding.PaddingLeft = UDim.new(0, 10)
		padding.PaddingRight = UDim.new(0, 10)
		padding.Parent = main

		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 6)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = main

		local header = Instance.new("TextLabel")
		header.Parent = main
		header.LayoutOrder = 0
		header.BackgroundColor3 = Color3.fromRGB(50, 50, 54)
		header.BackgroundTransparency = 0
		header.BorderSizePixel = 0
		header.Size = UDim2.new(1, 0, 0, 30)
		header.Font = FONT
		header.Text = string.upper(title)
		header.TextColor3 = TEXT_COLOR
		header.TextScaled = true
		addStroke(header, 2)
		addCorner(header, 10)
		addSurface(header)
		addBevel(header)
		limitText(header, 22)

		local panel = { gui = gui, frame = main, order = 1 }

		local function nextOrder()
			panel.order = panel.order + 1
			return panel.order
		end

		function panel:label(text)
			local label = Instance.new("TextLabel")
			label.LayoutOrder = nextOrder()
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 0, 20)
			label.Font = FONT
			label.Text = text
			label.TextColor3 = TEXT_COLOR
			label.TextScaled = true
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = main
			limitText(label, 16)
			return label
		end

		function panel:button(text, callback)
			local button = makeButton(main, text, callback)
			button.LayoutOrder = nextOrder()
			button.Size = UDim2.new(1, 0, 0, 28)
			return button
		end

		function panel:row(specs)
			local holder = Instance.new("Frame")
			holder.LayoutOrder = nextOrder()
			holder.BackgroundTransparency = 1
			holder.Size = UDim2.new(1, 0, 0, 28)
			holder.Parent = main
			local buttons = {}
			local count = #specs
			for index, spec in ipairs(specs) do
				local button = makeButton(holder, spec[1], spec[2])
				button.Size = UDim2.new(1 / count, -4, 1, 0)
				button.Position = UDim2.new((index - 1) / count, 2, 0, 0)
				buttons[index] = button
			end
			return buttons
		end

		function panel:input(placeholder, default)
			local box = Instance.new("TextBox")
			box.LayoutOrder = nextOrder()
			box.Size = UDim2.new(1, 0, 0, 28)
			box.BackgroundColor3 = Color3.fromRGB(34, 34, 38)
			box.BackgroundTransparency = 0
			box.BorderSizePixel = 0
			box.Font = FONT
			box.Text = default or ""
			box.PlaceholderText = placeholder
			box.PlaceholderColor3 = Color3.fromRGB(120, 112, 104)
			box.TextColor3 = TEXT_COLOR
			box.TextScaled = true
			box.ClearTextOnFocus = false
			box.Parent = main
			addStroke(box, 2)
			addCorner(box, 10)
			addSurface(box, 270)
			limitText(box, 17)
			return box
		end

		local status = Instance.new("TextLabel")
		status.LayoutOrder = 10000
		status.BackgroundTransparency = 1
		status.Size = UDim2.new(1, 0, 0, 34)
		status.Font = FONT
		status.Text = "Equip to start"
		status.TextColor3 = Color3.fromRGB(172, 164, 155)
		status.TextScaled = true
		status.TextWrapped = true
		status.Parent = main
		limitText(status, 15)
		panel.status = status

		return panel
	end

	local function makeSelectionBox(color, thickness)
		local box = Instance.new("SelectionBox")
		box.Color3 = color
		box.SurfaceColor3 = color
		box.SurfaceTransparency = 0.8
		box.LineThickness = thickness
		box.Parent = CoreGui
		return box
	end

	local function normalizeColorText(text)
		local parts = string.split(text, ",")
		if #parts < 3 then
			return nil
		end
		local r, g, b = tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3])
		if not r or not g or not b then
			return nil
		end
		return Color3.fromRGB(r, g, b)
	end

	local createClone
	local createMove
	local createEditor
	local createReplication
	local createModeration
	local createGiver
	local createTrap
	local createRoTool

	pcall(function()
		local panel = createPanel("CloneToolGui", "Clone Tool", 220)
		local status = panel.status
		local countLabel = panel:label("Selected: 0 block(s)")
		local offsetLabel = panel:label("Offset: 0, 0, 0")
		local radiusBox = panel:input("Nearby radius (default 30)", "30")

		local MAX_BOXES = 150
		local selected = {}
		local boxes = {}
		local boxCount = 0
		local offset = Vector3.new(0, 0, 0)
		local center = Vector3.new(0, 0, 0)
		local snapOn = true
		local building = false
		local handles = nil
		local handlePart = nil
		local dragStart = nil
		local lastHandleTime = 0
		local snapButton
		local function setSnap(value)
			snapOn = value
			snapButton.Text = snapOn and "Snap: ON  (G)" or "Snap: OFF (G)"
			setButtonState(snapButton, snapOn)
		end

		snapButton = panel:button("Snap: ON  (G)", function()
			setSnap(not snapOn)
		end)
		setButtonState(snapButton, true)

		local function updateCount()
			local total = 0
			for _ in pairs(selected) do
				total = total + 1
			end
			countLabel.Text = "Selected: " .. total .. " block(s)"
			return total
		end

		local function updateOffsetLabel()
			offsetLabel.Text = string.format("Offset: %.0f, %.0f, %.0f", offset.X, offset.Y, offset.Z)
		end

		local function computeCenter()
			local sum = Vector3.new(0, 0, 0)
			local total = 0
			for part in pairs(selected) do
				if part.Parent then
					sum = sum + part.Position
					total = total + 1
				end
			end
			return total > 0 and (sum / total) or Vector3.new(0, 0, 0)
		end

		local function setHighlight(part, on)
			if on then
				if boxes[part] or boxCount >= MAX_BOXES then
					return
				end
				local box = makeSelectionBox(Color3.fromRGB(255, 170, 0), 0.055)
				box.Adornee = part
				boxes[part] = box
				boxCount = boxCount + 1
			elseif boxes[part] then
				boxes[part]:Destroy()
				boxes[part] = nil
				boxCount = boxCount - 1
			end
		end

		local function clearHandles()
			if handles then
				handles:Destroy()
				handles = nil
			end
			if handlePart then
				handlePart:Destroy()
				handlePart = nil
			end
			dragStart = nil
		end

		local function clearSelection()
			for part in pairs(selected) do
				setHighlight(part, false)
			end
			selected = {}
			offset = Vector3.new(0, 0, 0)
			center = Vector3.new(0, 0, 0)
			clearHandles()
			updateCount()
			updateOffsetLabel()
		end

		local function buildHandles()
			clearHandles()
			center = computeCenter()
			if updateCount() == 0 then
				return
			end
			handlePart = Instance.new("Part")
			handlePart.Anchored = true
			handlePart.CanCollide = false
			handlePart.CanQuery = false
			handlePart.CastShadow = false
			handlePart.Transparency = 1
			handlePart.Size = Vector3.new(1, 1, 1)
			handlePart.CFrame = CFrame.new(center + offset)
			handlePart.Parent = workspace

			handles = Instance.new("Handles")
			handles.Adornee = handlePart
			handles.Style = Enum.HandlesStyle.Movement
			handles.Color3 = Color3.fromRGB(255, 200, 0)
			handles.Parent = CoreGui

			handles.MouseButton1Down:Connect(function()
				dragStart = offset
				lastHandleTime = tick()
			end)
			handles.MouseDrag:Connect(function(face, distance)
				if not dragStart or not handlePart then
					return
				end
				lastHandleTime = tick()
				local step = snapOn and (math.round(distance / _AB.mult) * _AB.mult) or distance
				offset = dragStart + Vector3.fromNormalId(face) * step
				handlePart.CFrame = CFrame.new(center + offset)
				updateOffsetLabel()
			end)
		end

		local function toggleBlock(part)
			if selected[part] then
				selected[part] = nil
				setHighlight(part, false)
			else
				selected[part] = true
				setHighlight(part, true)
			end
			local total = updateCount()
			if total > 0 then
				buildHandles()
				status.Text = total .. " selected. Move the handles, then Confirm"
			else
				clearHandles()
				status.Text = "Tap blocks to select them"
			end
		end

		local function selectNearby()
			local folder = getFolder()
			local hrp = getHrp()
			if not folder or not hrp then
				status.Text = "No blocks folder found"
				return
			end
			local radius = math.clamp(tonumber(radiusBox.Text) or 30, 5, 300)
			local origin = hrp.Position
			for _, object in ipairs(folder:GetDescendants()) do
				if object:IsA("BasePart") and (object.Position - origin).Magnitude <= radius then
					if not selected[object] then
						selected[object] = true
						setHighlight(object, true)
					end
				end
			end
			local total = updateCount()
			if total > 0 then
				buildHandles()
				status.Text = total .. " selected nearby. Move the handles, then Confirm"
			else
				status.Text = "No blocks in that radius"
			end
		end

		local function doConfirm()
			if building then
				status.Text = "Already cloning"
				return
			end
			local data = {}
			for part in pairs(selected) do
				if part.Parent then
					local saved = _AB.saveblock(part)
					if saved and saved.p then
						table.insert(data, saved)
					end
				end
			end
			if #data == 0 then
				status.Text = "Nothing selected. Tap blocks first"
				return
			end
			table.sort(data, function(a, b)
				if a.p[2] ~= b.p[2] then
					return a.p[2] < b.p[2]
				end
				if a.p[1] ~= b.p[1] then
					return a.p[1] < b.p[1]
				end
				return a.p[3] < b.p[3]
			end)
			local applied = offset
			building = true
			_AB.stopped = false
			task.spawn(function()
				for index, block in ipairs(data) do
					if _AB.stopped then
						break
					end
					local pos = Vector3.new(block.p[1], block.p[2], block.p[3]) + applied
					local color = block.c and Color3.fromRGB(table.unpack(block.c)) or _AB.defaultcolor
					local size = block.s and Vector3.new(table.unpack(block.s)) or nil
					local hrp = getHrp()
					if _AB.tp and hrp then
						hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
					end
					pcall(_AB.buildblock, pos, block.m, color, nil, size, nil, block.o, block.sp, block.a, block.cc)
					task.wait(_AB.buildSpeed)
					status.Text = string.format("Cloning %d / %d", index, #data)
				end
				building = false
				status.Text = _AB.stopped and "Clone stopped" or ("Done. " .. #data .. " block(s) cloned")
				_AB.stopped = false
			end)
		end

		local function doCancel()
			clearSelection()
			status.Text = "Cancelled. Tap blocks to select"
		end

		panel:button("Select Nearby", selectNearby)
		panel:button("Confirm Clone", doConfirm)
		panel:row({
			{ "Cancel (R)", doCancel },
			{
				"Clear Sel.",
				function()
					clearSelection()
					status.Text = "Selection cleared"
				end,
			},
		})
		panel:button("Stop Building", function()
			_AB.stopped = true
			status.Text = "Stopping the clone"
		end)
		panel:label("Tap a block to select or deselect")

		createClone = function()
			local connections = {}
			local tool = newTool(
				"Clone Tool",
				"Tap blocks to select them, move the handles, then confirm to clone",
				Color3.fromRGB(255, 170, 0),
				Vector3.new(0.7, 0.7, 2.5),
				Enum.Material.Neon
			)
			local equipped = false

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					panel.gui.Enabled = true
					updateCount()
					updateOffsetLabel()
					status.Text = "Tap blocks to select them"
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					equipped = false
					panel.gui.Enabled = false
				end)
			)

			table.insert(
				connections,
				mouse.Button1Down:Connect(function()
					if not equipped then
						return
					end
					local target = mouse.Target
					local folder = getFolder()
					if not target or not folder or not target:IsDescendantOf(folder) then
						return
					end
					task.delay(0.05, function()
						if not equipped or tick() - lastHandleTime < 0.25 then
							return
						end
						if target.Parent then
							toggleBlock(target)
						end
					end)
				end)
			)

			table.insert(
				connections,
				UserInputService.InputBegan:Connect(function(input, processed)
					if processed or not equipped then
						return
					end
					if input.KeyCode == Enum.KeyCode.G then
						setSnap(not snapOn)
					elseif input.KeyCode == Enum.KeyCode.R then
						doCancel()
					end
				end)
			)

			bindCleanup(tool, connections, function()
				panel.gui.Enabled = false
			end)

			return tool
		end
	end)

	pcall(function()
		local panel = createPanel("MoveToolGui", "Move Tool", 210)
		local status = panel.status
		local selection = nil
		local originalCFrame = nil
		local wasAnchored = false
		local handles = nil
		local dragStart = nil
		local snapOn = true
		local snapButton

		local function toggleAnchor(part)
			paintFire(part, Enum.NormalId.Top, getPos(), "material", nil, "anchor", "")
		end

		local function cleanHandles()
			if handles then
				handles:Destroy()
				handles = nil
			end
			dragStart = nil
		end

		local function setSnap(value)
			snapOn = value
			snapButton.Text = snapOn and "Snap: ON  (G)" or "Snap: OFF (G)"
			setButtonState(snapButton, snapOn)
		end

		snapButton = panel:button("Snap: ON  (G)", function()
			setSnap(not snapOn)
		end)
		setButtonState(snapButton, true)

		local function doConfirm()
			if not selection or not selection.Parent then
				cleanHandles()
				selection = nil
				status.Text = "Click a block to select"
				return
			end
			local part = selection
			local anchoredBefore = wasAnchored
			local data = _AB.saveblock(part)
			cleanHandles()
			selection = nil
			if not data or not data.p then
				status.Text = "Could not read the block"
				return
			end
			status.Text = "Moving server side"
			task.spawn(function()
				if not part.Anchored then
					toggleAnchor(part)
					task.wait(0.2)
				end
				deleteBlock(part)
				task.wait(0.35)
				local captured = nil
				local originalUpdate = _AB.updateBlockCache
				_AB.updateBlockCache = function(block, ...)
					captured = block
					return originalUpdate(block, ...)
				end
				local color = data.c and Color3.fromRGB(table.unpack(data.c)) or _AB.defaultcolor
				local size = data.s and Vector3.new(table.unpack(data.s)) or nil
				local pos = Vector3.new(data.p[1], data.p[2], data.p[3])
				pcall(_AB.buildblock, pos, data.m, color, nil, size, true, data.o, data.sp, anchoredBefore, data.cc ~= false)
				_AB.updateBlockCache = originalUpdate
				_AB.stopped = false

				if not captured or not captured.Parent then
					local folder = getFolder()
					local mine = folder and folder:FindFirstChild(lp.Name)
					local expected = pos
					if size then
						expected = Vector3.new(pos.X + size.X / 2 - 0.5, pos.Y + size.Y / 2 - 0.5, pos.Z + size.Z / 2 - 0.5)
					end
					local closest = 3
					for _, child in ipairs(mine and mine:GetChildren() or {}) do
						if child:IsA("BasePart") then
							local distance = (child.Position - expected).Magnitude
							if distance < closest then
								closest = distance
								captured = child
							end
						end
					end
				end

				if captured and captured.Parent then
					for _ = 1, 4 do
						task.wait(0.3)
						if not captured.Parent or captured.Anchored == anchoredBefore then
							break
						end
						paintFire(captured, Enum.NormalId.Top, captured.Position, "material", nil, "anchor", "")
					end
					if data.cc ~= nil and captured.Parent and captured.CanCollide ~= data.cc then
						paintFire(captured, Enum.NormalId.Top, captured.Position, "material", nil, "collide", "")
					end
				end
				status.Text = "Placed. Click a block to select"
			end)
		end

		local function doCancel()
			if selection and selection.Parent then
				if originalCFrame then
					selection.CFrame = originalCFrame
				end
				if wasAnchored and not selection.Anchored then
					toggleAnchor(selection)
				end
			end
			cleanHandles()
			selection = nil
			status.Text = "Cancelled. Click a block to select"
		end

		panel:row({ { "Confirm", doConfirm }, { "Cancel (R)", doCancel } })
		panel:label("G = snap   R = cancel")

		createMove = function()
			local connections = {}
			local tool = newTool(
				"Move Tool",
				"Click a block then drag the arrows to move it",
				Color3.fromRGB(0, 180, 255),
				Vector3.new(0.6, 0.6, 2.5),
				Enum.Material.SmoothPlastic
			)
			local equipped = false
			local box = makeSelectionBox(Color3.fromRGB(0, 200, 255), 0.05)

			local function selectBlock(part)
				doConfirm()
				selection = part
				originalCFrame = part.CFrame
				wasAnchored = part.Anchored
				box.Adornee = part
				status.Text = "Unanchoring"
				if part.Anchored then
					toggleAnchor(part)
					task.wait(0.2)
				end
				pcall(function()
					lp.SimulationRadius = math.huge
				end)
				task.wait(0.1)
				cleanHandles()
				handles = Instance.new("Handles")
				handles.Adornee = part
				handles.Style = Enum.HandlesStyle.Movement
				handles.Color3 = Color3.fromRGB(255, 210, 0)
				handles.Parent = CoreGui
				handles.MouseButton1Down:Connect(function()
					dragStart = part.CFrame
				end)
				handles.MouseDrag:Connect(function(face, distance)
					if not dragStart then
						return
					end
					local step = snapOn and (math.round(distance / _AB.mult) * _AB.mult) or distance
					part.CFrame = dragStart * CFrame.new(Vector3.fromNormalId(face) * step)
					pcall(function()
						lp.SimulationRadius = math.huge
					end)
				end)
				status.Text = "Drag arrows to move. Confirm or Cancel"
			end

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					panel.gui.Enabled = true
					status.Text = "Click a block to select"
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					if not equipped then
						return
					end
					equipped = false
					doCancel()
					panel.gui.Enabled = false
					box.Adornee = nil
				end)
			)

			table.insert(
				connections,
				mouse.Button1Down:Connect(function()
					if not equipped then
						return
					end
					local target = mouse.Target
					if target and target ~= selection and isSelectable(target, mouse.Hit.Position) then
						task.spawn(selectBlock, target)
					end
				end)
			)

			table.insert(
				connections,
				UserInputService.InputBegan:Connect(function(input, processed)
					if processed or not equipped then
						return
					end
					if input.KeyCode == Enum.KeyCode.G then
						setSnap(not snapOn)
					elseif input.KeyCode == Enum.KeyCode.R then
						doCancel()
					end
				end)
			)

			bindCleanup(tool, connections, function()
				cleanHandles()
				box:Destroy()
				panel.gui.Enabled = false
			end)

			return tool
		end
	end)

	pcall(function()
		local panel = createPanel("EditorToolGui", "Block Editor", 215)
		local status = panel.status
		local colorBox = panel:input("R,G,B (e.g. 255,0,0)")
		local materialBox = panel:input("Material (e.g. Neon)")
		local selection = nil

		local function ready()
			return selection and selection.Parent
		end

		panel:row({
			{
				"Color",
				function()
					if not ready() then
						return
					end
					local color = normalizeColorText(colorBox.Text)
					if color and paintFire(selection, Enum.NormalId.Top, getPos(), "color", color, "", "") then
						status.Text = "Color applied"
					end
				end,
			},
			{
				"Material",
				function()
					if not ready() then
						return
					end
					if paintFire(selection, Enum.NormalId.Top, getPos(), "material", nil, materialBox.Text:lower(), "") then
						status.Text = "Material applied"
					end
				end,
			},
			{
				"All Sides",
				function()
					if not ready() then
						return
					end
					local color = normalizeColorText(colorBox.Text)
					if not color then
						return
					end
					for _, face in ipairs(ALL_FACES) do
						paintFire(selection, face, getPos(), "color", color, "", "")
					end
					status.Text = "All sides painted"
				end,
			},
		})

		panel:row({
			{
				"Anchor",
				function()
					if not ready() then
						return
					end
					if paintFire(selection, Enum.NormalId.Top, getPos(), "material", nil, "anchor", "") then
						status.Text = "Toggled anchor"
					end
				end,
			},
			{
				"Toxify",
				function()
					if not ready() then
						return
					end
					if paintFire(selection, Enum.NormalId.Top, getPos(), "material", Color3.new(0, 0, 0), "toxic", "") then
						status.Text = "Toxified"
					end
				end,
			},
			{
				"Delete",
				function()
					if not ready() then
						return
					end
					deleteBlock(selection)
					selection = nil
					status.Text = "Deleted"
				end,
			},
		})

		local signBox = panel:input("Sign text")

		panel:row({
			{
				"Sign",
				function()
					if not ready() or signBox.Text == "" then
						return
					end
					if
						paintFire(
							selection,
							Enum.NormalId.Front,
							getPos(),
							"both \u{1F91D}",
							selection.Color,
							"",
							signBox.Text
						)
					then
						status.Text = "Sign applied"
					end
				end,
			},
			{
				"Clone",
				function()
					if not ready() then
						return
					end
					local hrp = getHrp()
					if not hrp then
						return
					end
					local data = _AB.saveblock(selection)
					if not data or not data.p then
						return
					end
					local target = _AB.round(hrp.Position + hrp.CFrame.LookVector * 6)
					local size = data.s and Vector3.new(table.unpack(data.s)) or nil
					local pos = target
					if size then
						pos = Vector3.new(target.X - size.X / 2 + 0.5, target.Y - size.Y / 2 + 0.5, target.Z - size.Z / 2 + 0.5)
					end
					local color = data.c and Color3.fromRGB(table.unpack(data.c)) or _AB.defaultcolor
					task.spawn(function()
						pcall(_AB.buildblock, pos, data.m, color, nil, size, nil, data.o, data.sp, data.a, data.cc)
					end)
					status.Text = "Cloned in front of you"
				end,
			},
		})

		local infoLabel = panel:label("")
		infoLabel.Size = UDim2.new(1, 0, 0, 34)
		infoLabel.TextWrapped = true
		infoLabel.TextXAlignment = Enum.TextXAlignment.Center

		createEditor = function()
			local connections = {}
			local tool = newTool(
				"Editor Tool",
				"Click blocks to edit properties",
				Color3.fromRGB(0, 85, 255),
				Vector3.new(0.6, 0.6, 2.5),
				Enum.Material.SmoothPlastic
			)
			local equipped = false
			local box = makeSelectionBox(Color3.fromRGB(0, 85, 255), 0.07)

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					panel.gui.Enabled = true
					status.Text = "Click a block to select"
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					if not equipped then
						return
					end
					equipped = false
					panel.gui.Enabled = false
					box.Adornee = nil
					selection = nil
				end)
			)

			table.insert(
				connections,
				mouse.Button1Down:Connect(function()
					if not equipped then
						return
					end
					if not isSelectable(mouse.Target, mouse.Hit.Position) then
						return
					end
					selection = mouse.Target
					box.Adornee = selection
					local color = selection.Color
					colorBox.Text = math.floor(color.R * 255)
						.. ","
						.. math.floor(color.G * 255)
						.. ","
						.. math.floor(color.B * 255)
					materialBox.Text = selection.Material.Name
					status.Text = "Selected block"
					infoLabel.Text = string.format(
						"Pos %.0f,%.0f,%.0f | Size %.0f,%.0f,%.0f | %s",
						selection.Position.X,
						selection.Position.Y,
						selection.Position.Z,
						selection.Size.X,
						selection.Size.Y,
						selection.Size.Z,
						selection.Anchored and "Anchored" or "Unanchored"
					)
				end)
			)

			bindCleanup(tool, connections, function()
				box:Destroy()
				panel.gui.Enabled = false
			end)

			return tool
		end
	end)

	pcall(function()
		local panel = createPanel("ReplicationToolGui", "Replication Tool", 215)
		local status = panel.status
		panel:label("Click a block to copy it")
		panel:label("into ReplicatedStorage.Brick")

		createReplication = function()
			local connections = {}
			local tool = newTool(
				"Replication Tool",
				"Click a block to replicate it to ReplicatedStorage.Brick",
				Color3.fromRGB(255, 230, 0),
				Vector3.new(0.8, 0.8, 2.5),
				Enum.Material.SmoothPlastic,
				Enum.PartType.Cylinder
			)
			local equipped = false
			local processing = false
			local box = makeSelectionBox(Color3.fromRGB(255, 230, 0), 0.07)

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					panel.gui.Enabled = true
					status.Text = "Click a block to replicate"
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					equipped = false
					panel.gui.Enabled = false
					box.Adornee = nil
				end)
			)

			table.insert(
				connections,
				tool.Activated:Connect(function()
					if not equipped or processing then
						return
					end
					if not (mouse.Target and isSelectable(mouse.Target, mouse.Hit.Position) and mouse.TargetSurface) then
						return
					end
					local brick = ReplicatedStorage:FindFirstChild("Brick")
					if not brick or (brick.HasTag and brick:HasTag("FAKE")) then
						status.Text = "ReplicatedStorage.Brick is missing"
						return
					end
					processing = true
					box.Color3 = Color3.fromRGB(0, 200, 0)
					box.SurfaceColor3 = Color3.fromRGB(0, 200, 0)
					status.Text = "Replicating"
					local source = mouse.Target

					local ok = pcall(function()
						local material = _AB.materials[source.Material] or "plastic"
						if material == "neon" then
							material = "toxic"
						end
						paintFire(brick, Enum.NormalId.Top, getPos(), "both \u{1F91D}", source.Color, material, "")
						task.wait(0.25)
						if source.Anchored ~= brick.Anchored then
							paintFire(brick, Enum.NormalId.Top, getPos(), "material", Color3.new(), "anchor", "")
							task.wait(0.25)
						end
						if source.CanCollide ~= brick.CanCollide then
							paintFire(brick, Enum.NormalId.Top, getPos(), "material", Color3.new(), "collide", "")
							task.wait(0.25)
						end
						local pending = { Back = true, Front = true, Left = true, Right = true, Top = true, Bottom = true }
						for _, child in ipairs(source:GetChildren()) do
							if child:IsA("SurfaceGui") then
								local label = child:FindFirstChild("Label") or child:FindFirstChildWhichIsA("TextLabel")
								if child.Face and label then
									pending[child.Face.Name] = nil
									paintFire(
										brick,
										child.Face,
										getPos(),
										"both \u{1F91D}",
										label.TextColor3 or Color3.new(),
										"spray",
										label.Text or ""
									)
									task.wait(0.5)
								end
							end
						end
						for faceName in pairs(pending) do
							paintFire(brick, Enum.NormalId[faceName], getPos(), "material", Color3.new(), "spray", "")
							task.wait(0.35)
						end
					end)

					processing = false
					box.Color3 = Color3.fromRGB(255, 230, 0)
					box.SurfaceColor3 = Color3.fromRGB(255, 230, 0)
					status.Text = ok and "Block replicated" or "Replication failed"
				end)
			)

			local elapsed = 0
			table.insert(
				connections,
				RunService.Heartbeat:Connect(function(dt)
					if processing then
						return
					end
					elapsed = elapsed + dt
					if elapsed < 0.05 then
						return
					end
					elapsed = 0
					if equipped and mouse.Target and isSelectable(mouse.Target, mouse.Hit.Position) then
						box.Adornee = mouse.Target
					else
						box.Adornee = nil
					end
				end)
			)

			bindCleanup(tool, connections, function()
				box:Destroy()
				panel.gui.Enabled = false
			end)

			return tool
		end
	end)

	pcall(function()
		local panel = createPanel("ModerationToolGui", "Moderation Tool", 215)
		local status = panel.status
		local commandBox = panel:input("Command (default: reset)", "reset")
		panel:label("Click any player to fire it")

		createModeration = function()
			local connections = {}
			local tool = newTool(
				"Moderation Tool",
				"Click players to send a chat command targeting them",
				Color3.fromRGB(220, 50, 60),
				Vector3.new(0.8, 0.8, 2.5),
				Enum.Material.SmoothPlastic,
				Enum.PartType.Cylinder
			)
			local equipped = false
			local highlightObject = Instance.new("Highlight")
			highlightObject.FillColor = Color3.fromRGB(220, 50, 60)
			highlightObject.OutlineColor = Color3.fromRGB(255, 255, 255)
			highlightObject.FillTransparency = 0.6
			highlightObject.Parent = CoreGui

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					panel.gui.Enabled = true
					status.Text = "Click a player"
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					equipped = false
					panel.gui.Enabled = false
					highlightObject.Adornee = nil
				end)
			)

			table.insert(
				connections,
				tool.Activated:Connect(function()
					if not equipped or not (mouse.Target and mouse.Target.Parent) then
						return
					end
					local target = resolvePlayer(mouse.Target)
					if not target then
						return
					end
					local command = (commandBox.Text or ""):match("^%s*(.-)%s*$") or ""
					if command == "" then
						command = "reset"
					end
					chat(";" .. command .. " " .. sanitizeName(target.Name))
					status.Text = "Sent " .. command .. " to " .. target.Name
				end)
			)

			local elapsed = 0
			table.insert(
				connections,
				RunService.Heartbeat:Connect(function(dt)
					if not equipped then
						return
					end
					elapsed = elapsed + dt
					if elapsed < 0.05 then
						return
					end
					elapsed = 0
					local target = mouse.Target and resolvePlayer(mouse.Target)
					highlightObject.Adornee = target and target.Character or nil
				end)
			)

			bindCleanup(tool, connections, function()
				highlightObject:Destroy()
				panel.gui.Enabled = false
			end)

			return tool
		end
	end)

	local function createZoneTool(config)
		local zone = {
			blocks = {},
			mode = config.modes[1],
			selectMode = config.modes[1],
			selecting = false,
		}
		for _, modeName in ipairs(config.modes) do
			zone.blocks[modeName] = {}
		end

		local panel = createPanel(config.gui, config.title, 225)
		local status = panel.status
		local modeLabel = panel:label("Mode: " .. zone.mode)
		local countLabel = panel:label("")
		local input = config.inputPlaceholder and panel:input(config.inputPlaceholder) or nil

		local function updateUI()
			local total = 0
			for _ in pairs(zone.blocks[zone.mode]) do
				total = total + 1
			end
			modeLabel.Text = "Mode: " .. zone.mode
			countLabel.Text = zone.mode .. " blocks: " .. total
		end

		local function dropBlock(modeName, block)
			local data = zone.blocks[modeName][block]
			if not data then
				return
			end
			if data.OnTouched then
				pcall(function()
					data.OnTouched:Disconnect()
				end)
			end
			if data.SelectionBox then
				pcall(function()
					data.SelectionBox:Destroy()
				end)
			end
			zone.blocks[modeName][block] = nil
			if config.onDrop then
				config.onDrop(block)
			end
		end

		local function setMode(modeName)
			if zone.selecting then
				return
			end
			zone.mode = modeName
			updateUI()
			status.Text = "Mode: " .. modeName
		end

		for index = 1, #config.modes, 2 do
			local first = config.modes[index]
			local second = config.modes[index + 1]
			local specs = {
				{
					first,
					function()
						setMode(first)
					end,
				},
			}
			if second then
				specs[2] = {
					second,
					function()
						setMode(second)
					end,
				}
			end
			panel:row(specs)
		end

		panel:button("Select Blocks", function()
			if zone.selecting then
				return
			end
			zone.selecting = true
			zone.selectMode = zone.mode
			for _, data in pairs(zone.blocks[zone.selectMode]) do
				if data.SelectionBox then
					data.SelectionBox.LineThickness = 0.1
				end
			end
			status.Text = "Click " .. zone.selectMode .. " blocks. Finish when done"
		end)

		local function finish()
			if not zone.selecting then
				status.Text = "Not in selection mode"
				return
			end
			local modeName = zone.selectMode
			local context = nil
			if config.validate then
				local ok, result = config.validate(modeName, input and input.Text or "")
				if not ok then
					status.Text = result
					return
				end
				context = result
			end
			zone.selecting = false
			local activeColor = config.colors[modeName] or Color3.fromRGB(255, 255, 255)
			local total = 0
			for block, data in pairs(zone.blocks[modeName]) do
				if data.SelectionBox then
					data.SelectionBox.LineThickness = -1
				end
				if not data.Active then
					data.Active = true
					if data.SelectionBox then
						data.SelectionBox.Color3 = activeColor
						data.SelectionBox.SurfaceColor3 = activeColor
					end
					local connect = true
					if config.activate then
						connect = config.activate(modeName, block, data, context)
					end
					if connect ~= false then
						data.OnTouched = block.Touched:Connect(function(hit)
							if not zone.blocks[modeName] or not zone.blocks[modeName][block] then
								return
							end
							local touched = resolvePlayer(hit)
							if not touched or not touched.Character then
								return
							end
							if not touched.Character:FindFirstChildOfClass("Humanoid") then
								return
							end
							task.spawn(config.onTouch, modeName, block, touched)
						end)
					end
				end
				total = total + 1
			end
			status.Text = modeName .. " active: " .. total .. " block(s)"
			updateUI()
		end

		local function cancel()
			if not zone.selecting then
				return
			end
			zone.selecting = false
			for block, data in pairs(zone.blocks[zone.selectMode]) do
				if not data.Active then
					dropBlock(zone.selectMode, block)
				elseif data.SelectionBox then
					data.SelectionBox.LineThickness = -1
				end
			end
			status.Text = "Selection cancelled"
			updateUI()
		end

		panel:row({ { "Finish", finish }, { "Cancel", cancel } })

		panel:button("Remove Mode Blocks", function()
			for block in pairs(zone.blocks[zone.mode]) do
				dropBlock(zone.mode, block)
			end
			if zone.selecting and zone.selectMode == zone.mode then
				zone.selecting = false
			end
			status.Text = zone.mode .. " blocks cleared"
			updateUI()
		end)

		panel:button("Remove All Blocks", function()
			for _, modeName in ipairs(config.modes) do
				for block in pairs(zone.blocks[modeName]) do
					dropBlock(modeName, block)
				end
			end
			zone.selecting = false
			if config.onClearAll then
				config.onClearAll()
			end
			status.Text = "All blocks cleared"
			updateUI()
		end)

		zone.create = function()
			local connections = {}
			local tool = newTool(
				config.toolName,
				config.tip,
				config.handleColor,
				Vector3.new(0.8, 0.8, 2.5),
				config.handleMaterial or Enum.Material.SmoothPlastic
			)
			local equipped = false

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					panel.gui.Enabled = true
					for _, modeBlocks in pairs(zone.blocks) do
						for _, data in pairs(modeBlocks) do
							if data.Active and data.SelectionBox then
								data.SelectionBox.LineThickness = 0.05
							end
						end
					end
					updateUI()
					status.Text = "Choose a mode and select blocks"
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					if not equipped then
						return
					end
					equipped = false
					panel.gui.Enabled = false
					if zone.selecting then
						cancel()
					end
					for _, modeBlocks in pairs(zone.blocks) do
						for _, data in pairs(modeBlocks) do
							if data.SelectionBox then
								data.SelectionBox.LineThickness = -1
							end
						end
					end
				end)
			)

			table.insert(
				connections,
				mouse.Button1Down:Connect(function()
					if not equipped or not zone.selecting then
						return
					end
					local target = mouse.Target
					local folder = getFolder()
					if not target or not folder or not target:IsDescendantOf(folder) then
						return
					end
					local modeName = zone.selectMode
					if zone.blocks[modeName][target] then
						dropBlock(modeName, target)
						status.Text = "Block removed from " .. modeName
					else
						local box = Instance.new("SelectionBox")
						box.Color3 = Color3.fromRGB(0, 170, 255)
						box.LineThickness = 0.1
						box.SurfaceColor3 = Color3.fromRGB(13, 105, 172)
						box.SurfaceTransparency = 0.7
						box.Adornee = target
						box.Parent = CoreGui
						zone.blocks[modeName][target] = { SelectionBox = box, Block = target, Active = false }
						status.Text = "Added to " .. modeName .. ". Press Finish"
					end
					updateUI()
				end)
			)

			bindCleanup(tool, connections, function()
				panel.gui.Enabled = false
			end)

			return tool
		end

		return zone
	end

	pcall(function()
		local tagged = {}
		local commands = {
			R6 = ";r6 %s",
			Carpet = ";carpet %s",
			Fly = ";fly %s",
			Bkit = ";bkit %s",
			Paint = ";paint %s",
		}

		local function isTagged(uid, block)
			return tagged[uid] and tagged[uid][block] and tagged[uid][block] > tick()
		end

		local function setTag(uid, block, duration)
			if not tagged[uid] then
				tagged[uid] = {}
			end
			tagged[uid][block] = tick() + duration
		end

		local function equipEnlighten()
			local arken = lp.Backpack:FindFirstChild("The Arkenstone")
			if arken then
				pcall(function()
					arken.Parent = lp.Character
				end)
			end
		end

		local zone = createZoneTool({
			gui = "GiverToolGui",
			title = "Giver Tool",
			toolName = "Giver Tool",
			tip = "Select blocks to give R6, Carpet, Fly, Bkit or Paint on touch",
			handleColor = Color3.fromRGB(0, 200, 100),
			modes = { "R6", "Carpet", "Fly", "Bkit", "Paint" },
			colors = {
				R6 = Color3.fromRGB(255, 200, 0),
				Carpet = Color3.fromRGB(139, 90, 43),
				Fly = Color3.fromRGB(0, 180, 255),
				Bkit = Color3.fromRGB(0, 210, 100),
				Paint = Color3.fromRGB(230, 80, 200),
			},
			onTouch = function(modeName, block, player)
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if modeName == "R6" and humanoid.RigType == Enum.HumanoidRigType.R6 then
					return
				end
				if modeName == "Carpet" and player.Character:FindFirstChild("RainbowMagicCarpet") then
					return
				end
				if isTagged(player.UserId, block) then
					return
				end
				setTag(player.UserId, block, 3)
				local command = string.format(commands[modeName], sanitizeName(player.Name))
				equipEnlighten()
				task.wait(0.15)
				chat(command)
			end,
			onClearAll = function()
				tagged = {}
			end,
		})

		createGiver = zone.create
	end)

	pcall(function()
		local tags = {}
		local disco = {}
		local guessWords = {}
		local zone
		local chatConnection = nil

		local function setTag(block, duration)
			tags[block] = tick() + duration
		end

		local function isTagged(block)
			return tags[block] and tags[block] > tick()
		end

		local function ensureChatHook()
			if chatConnection then
				return
			end
			local channels = TextChatService:FindFirstChild("TextChannels")
			local channel = channels and channels:FindFirstChild("RBXGeneral")
			if not channel then
				return
			end
			chatConnection = channel.MessageReceived:Connect(function(message)
				local text = string.lower(message and message.Text or "")
				if text == "" then
					return
				end
				for block, data in pairs(zone.blocks.Guess) do
					if data.Active and block.Parent and not isTagged(block) then
						local matched = false
						for _, word in ipairs(guessWords[block] or {}) do
							if word ~= "" and string.find(text, word, 1, true) then
								matched = true
								break
							end
						end
						if matched then
							setTag(block, 6)
							local original = block.Color
							paintFire(block, Enum.NormalId.Top, getPos(), "material", Color3.new(1, 0, 0), "glass", "")
							task.wait(0.1)
							paintFire(block, Enum.NormalId.Top, getPos(), "material", Color3.new(1, 0, 0), "collide", "")
							task.delay(5, function()
								paintFire(block, Enum.NormalId.Top, getPos(), "material", original, "plastic", "")
								task.wait(0.1)
								paintFire(block, Enum.NormalId.Top, getPos(), "material", original, "collide", "")
							end)
						end
					end
				end
			end)
		end

		local actions = {
			Spleef = function(block)
				if not block.Parent or isTagged(block) or block.CanCollide ~= true then
					return
				end
				setTag(block, 6)
				local original = block.Color
				paintFire(block, Enum.NormalId.Top, getPos(), "both \u{1F91D}", Color3.new(1, 0, 0), "collide", "")
				task.delay(5, function()
					paintFire(block, Enum.NormalId.Top, getPos(), "both \u{1F91D}", original, "collide", "")
				end)
			end,
			Delete = function(block)
				if not block.Parent or isTagged(block) or block.CanCollide ~= true then
					return
				end
				setTag(block, 2)
				deleteBlock(block)
			end,
			Toxify = function(block)
				if not block.Parent or isTagged(block) or block.CanCollide ~= true then
					return
				end
				setTag(block, 3)
				paintFire(block, Enum.NormalId.Top, getPos(), "material", Color3.new(1, 0, 0), "toxic", "")
			end,
			Disco = function(block)
				if not block.Parent or isTagged(block) then
					return
				end
				setTag(block, 0.2)
				disco[block] = (disco[block] or 0) + 1
				local hue = ((disco[block] * 25) % 255) / 255
				paintFire(block, Enum.NormalId.Top, getPos(), "both \u{1F91D}", Color3.fromHSV(hue, 1, 1), "neon", "")
			end,
		}

		zone = createZoneTool({
			gui = "TrapEditorGui",
			title = "Trap Editor",
			toolName = "Trap Editor Tool",
			tip = "Select blocks, then players touching them trigger the chosen action",
			handleColor = Color3.fromRGB(255, 100, 200),
			handleMaterial = Enum.Material.Neon,
			modes = { "Spleef", "Delete", "Toxify", "Disco", "Guess" },
			inputPlaceholder = "Guess words (split with |, e.g. apple|red)",
			colors = {
				Spleef = Color3.fromRGB(255, 90, 90),
				Delete = Color3.fromRGB(180, 0, 0),
				Toxify = Color3.fromRGB(80, 255, 60),
				Disco = Color3.fromRGB(255, 0, 255),
				Guess = Color3.fromRGB(255, 200, 0),
			},
			validate = function(modeName, text)
				if modeName ~= "Guess" then
					return true, nil
				end
				local words = {}
				for _, part in ipairs(string.split(text or "", "|")) do
					local trimmed = string.lower(part:match("^%s*(.-)%s*$"))
					if trimmed ~= "" then
						table.insert(words, trimmed)
					end
				end
				if #words == 0 then
					return false, "No Guess words set. Type them above"
				end
				ensureChatHook()
				return true, words
			end,
			activate = function(modeName, block, _, context)
				if modeName == "Guess" then
					guessWords[block] = context
					return false
				end
				return true
			end,
			onTouch = function(modeName, block, player)
				if player == lp then
					return
				end
				local action = actions[modeName]
				if action then
					action(block)
				end
			end,
			onDrop = function(block)
				disco[block] = nil
				guessWords[block] = nil
			end,
			onClearAll = function()
				tags = {}
				disco = {}
				guessWords = {}
			end,
		})

		createTrap = zone.create
	end)

	pcall(function()
		local DAGGER = "DaggerOfShatteredDimensions"
		local GEAR_ID = "71037101"
		local snapSteps = { 90, 45, 15, 5, 0 }
		local snapIndex = 3

		local panel = createPanel("RoToolGui", "RoTool", 230)
		local status = panel.status
		panel:label("Tap a brick, spin the rings, Confirm")
		local rotationLabel = panel:label("Rotation: 0, 0, 0")

		local selection = nil
		local originalCFrame = nil
		local preview = nil
		local gizmo = nil
		local arcs = nil
		local busy = false
		local active = 0
		local lastHandleTime = 0
		local box = makeSelectionBox(Color3.fromRGB(255, 140, 60), 0.06)
		local previewBox = makeSelectionBox(Color3.fromRGB(90, 255, 140), 0.05)

		local function snapLabel()
			local value = snapSteps[snapIndex]
			return value > 0 and ("Snap: " .. value .. " deg") or "Snap: free"
		end

		local function updateReadout()
			if preview and originalCFrame then
				local rx, ry, rz = originalCFrame:ToObjectSpace(preview.CFrame):ToOrientation()
				rotationLabel.Text = string.format(
					"Rotation: %d, %d, %d",
					math.round(math.deg(rx)),
					math.round(math.deg(ry)),
					math.round(math.deg(rz))
				)
			else
				rotationLabel.Text = "Rotation: 0, 0, 0"
			end
		end

		local function clearPreview()
			if arcs then
				arcs:Destroy()
				arcs = nil
			end
			if gizmo then
				gizmo:Destroy()
				gizmo = nil
			end
			if preview then
				preview:Destroy()
				preview = nil
			end
			previewBox.Adornee = nil
			updateReadout()
		end

		local function buildPreview(part)
			clearPreview()
			originalCFrame = part.CFrame

			preview = Instance.new("Part")
			preview.Name = "RoToolPreview"
			preview.Anchored = true
			preview.CanCollide = false
			preview.CanQuery = false
			preview.CanTouch = false
			preview.CastShadow = false
			preview.Size = part.Size
			preview.Color = part.Color
			preview.Material = part.Material
			preview.Transparency = 0.45
			preview.CFrame = originalCFrame
			preview.Parent = workspace
			previewBox.Adornee = preview

			local side = math.max(part.Size.X, part.Size.Y, part.Size.Z)
			local gizmoSize = math.clamp(side * 2.4, 4, 12)
			gizmo = Instance.new("Part")
			gizmo.Name = "RoToolGizmo"
			gizmo.Anchored = true
			gizmo.CanCollide = false
			gizmo.CanQuery = false
			gizmo.CanTouch = false
			gizmo.CastShadow = false
			gizmo.Transparency = 1
			gizmo.Size = Vector3.new(gizmoSize, gizmoSize, gizmoSize)
			gizmo.CFrame = originalCFrame
			gizmo.Parent = workspace

			arcs = Instance.new("ArcHandles")
			arcs.Adornee = gizmo
			arcs.Color3 = Color3.fromRGB(255, 140, 60)
			arcs.Parent = CoreGui

			local startCFrame = gizmo.CFrame

			arcs.MouseButton1Down:Connect(function()
				startCFrame = gizmo.CFrame
				lastHandleTime = tick()
			end)

			arcs.MouseDrag:Connect(function(axis, relativeAngle)
				if not gizmo or not preview then
					return
				end
				lastHandleTime = tick()
				local angle = relativeAngle
				local snap = snapSteps[snapIndex]
				if snap > 0 then
					local step = math.rad(snap)
					angle = math.round(angle / step) * step
				end
				local turned = startCFrame * CFrame.fromAxisAngle(Vector3.FromAxis(axis), angle)
				gizmo.CFrame = turned
				preview.CFrame = turned
				updateReadout()
			end)

			updateReadout()
		end

		local function findDagger()
			local char = lp.Character
			local backpack = lp:FindFirstChild("Backpack")
			return (char and char:FindFirstChild(DAGGER)) or (backpack and backpack:FindFirstChild(DAGGER))
		end

		local function waitFor(check, seconds)
			local limit = tick() + seconds
			while tick() < limit do
				local result = check()
				if result then
					return result
				end
				task.wait(0.15)
			end
			return check()
		end

		local function holdTool(tool)
			local char = lp.Character
			local humanoid = char and char:FindFirstChildOfClass("Humanoid")
			if not (char and humanoid and tool) then
				return false
			end
			if tool.Parent ~= char then
				pcall(function()
					humanoid:EquipTool(tool)
				end)
				if tool.Parent ~= char then
					tool.Parent = char
				end
			end
			return tool.Parent == char
		end

		local function holdEnlighten()
			local char = lp.Character
			local backpack = lp:FindFirstChild("Backpack")
			if char and char:FindFirstChild("The Arkenstone") then
				return true
			end
			local arken = backpack and backpack:FindFirstChild("The Arkenstone")
			if arken then
				return holdTool(arken)
			end
			return false
		end

		local function anchorOnce(part, wanted)
			for _ = 1, 2 do
				if not part.Parent then
					return false
				end
				if part.Anchored == wanted then
					return true
				end
				paintFire(part, Enum.NormalId.Top, getPos(), "material", nil, "anchor", "")
				local limit = tick() + 1.2
				while tick() < limit do
					task.wait(0.1)
					if part.Parent and part.Anchored == wanted then
						return true
					end
				end
			end
			return part.Parent ~= nil and part.Anchored == wanted
		end

		local function enforce(part, target)
			if not part.Parent or part.Anchored then
				return
			end
			pcall(function()
				part.CFrame = target
				part.AssemblyLinearVelocity = Vector3.zero
				part.AssemblyAngularVelocity = Vector3.zero
			end)
		end

		local function rotationMatches(part, target)
			local _, angle = (part.CFrame.Rotation:Inverse() * target.Rotation):ToAxisAngle()
			return math.abs(angle) < 0.05
		end

		local function rotateBrick(part, target)
	status.Text = "1/7 Checking the gear"
	local dagger = findDagger()
	if not dagger then
		if not holdEnlighten() then
			status.Text = "You need The Arkenstone to send commands"
			return
		end
		task.wait(0.4)
		status.Text = "1/7 Getting the gear"
		chat(";gear me " .. GEAR_ID)
		dagger = waitFor(findDagger, 10)
		if not dagger then
			status.Text = "The gear did not arrive"
			return
		end
	end
	if not part.Parent then
		status.Text = "The brick no longer exists"
		return
	end
	status.Text = "2/7 Anchor (unanchoring the brick)"
	if not anchorOnce(part, false) then
		status.Text = "Could not unanchor the brick"
		return
	end
	
	status.Text = "3/7 Using the gear"
	if not holdTool(dagger) then
		status.Text = "Could not equip the dagger"
		pcall(anchorOnce, part, true)
		return
	end
	local remote = dagger:WaitForChild("Remote", 4)
	if not remote then
		status.Text = "The dagger has no Remote"
		pcall(anchorOnce, part, true)
		return
	end
	task.wait(1)
	remote:FireServer(Enum.KeyCode.Q)
	enforce(part, target)
	
	status.Text = "4/7 Waiting 9 seconds"
	for remaining = 9, 1, -1 do
		status.Text = "4/7 Waiting " .. remaining .. "s"
		for _ = 1, 5 do
			enforce(part, target)
			task.wait(0.2)
		end
	end
	
	status.Text = "5/7 Collide, collide"
	paintFire(part, Enum.NormalId.Top, getPos(), "material", Color3.new(), "collide", "")
	task.wait(0.2)
	paintFire(part, Enum.NormalId.Top, getPos(), "material", Color3.new(), "collide", "")
	enforce(part, target)
	
	status.Text = "6/7 Final Wait & Force"
	for remaining = 3, 1, -1 do
		status.Text = "6/7 Waiting " .. remaining .. "s"
		for _ = 1, 5 do
			enforce(part, target)
			task.wait(0.2)
		end
	end
	enforce(part, target)
	task.wait(0.5)
	enforce(part, target)
	
	status.Text = "7/7 Anchor"
	local anchored = anchorOnce(part, true)
	enforce(part, target)
	if not anchored then
		status.Text = "Finished, but the brick is not anchored"
	elseif rotationMatches(part, target) then
		status.Text = "Done. The brick has the preview rotation"
	else
		status.Text = "Done"
	end
end

		local function hideIfIdle()
			if active == 0 and not busy then
				panel.gui.Enabled = false
				box.Adornee = nil
				clearPreview()
			end
		end

		local snapButton
		snapButton = panel:button(snapLabel(), function()
			snapIndex = snapIndex % #snapSteps + 1
			snapButton.Text = snapLabel()
		end)

		panel:row({
			{
				"Reset",
				function()
					if busy or not (preview and gizmo and originalCFrame) then
						return
					end
					gizmo.CFrame = originalCFrame
					preview.CFrame = originalCFrame
					updateReadout()
					status.Text = "Rotation reset"
				end,
			},
			{
				"Cancel",
				function()
					if busy then
						status.Text = "Wait for the rotation to end"
						return
					end
					selection = nil
					box.Adornee = nil
					clearPreview()
					status.Text = "Selection cleared"
				end,
			},
		})

		panel:button("Confirm", function()
			if busy then
				return
			end
			if not (selection and selection.Parent and preview) then
				status.Text = "Tap a brick first"
				return
			end
			busy = true
			local part = selection
			local target = preview.CFrame
			if arcs then
				arcs.Adornee = nil
			end
			task.spawn(function()
				local ok = pcall(rotateBrick, part, target)
				if not ok then
					status.Text = "Something failed. Anchoring the brick again"
					pcall(anchorOnce, part, true)
				end
				busy = false
				selection = nil
				box.Adornee = nil
				clearPreview()
				task.delay(4, hideIfIdle)
			end)
		end)

		createRoTool = function()
			local connections = {}
			local tool = newTool(
				"RoTool",
				"Tap a brick, spin the preview with the rings and rotate the block, too easy, u need enlighten",
				Color3.fromRGB(255, 140, 60)
			)
			local equipped = false

			table.insert(
				connections,
				tool.Equipped:Connect(function()
					equipped = true
					active = active + 1
					panel.gui.Enabled = true
					if selection and selection.Parent and not busy then
						box.Adornee = selection
						buildPreview(selection)
					end
					if not busy then
						status.Text = "Tap a brick, spin the rings, Confirm"
					end
				end)
			)

			table.insert(
				connections,
				tool.Unequipped:Connect(function()
					if not equipped then
						return
					end
					equipped = false
					active = math.max(0, active - 1)
					hideIfIdle()
				end)
			)

			table.insert(
				connections,
				mouse.Button1Down:Connect(function()
					if not equipped or busy then
						return
					end
					local target = mouse.Target
					local hit = mouse.Hit.Position
					task.delay(0.05, function()
						if busy or tick() - lastHandleTime < 0.3 then
							return
						end
						if target and target.Parent and isSelectable(target, hit) then
							selection = target
							box.Adornee = target
							buildPreview(target)
							status.Text = "Brick selected. Spin the rings, then Confirm"
						end
					end)
				end)
			)

			bindCleanup(tool, connections, function()
				if equipped then
					active = math.max(0, active - 1)
				end
				hideIfIdle()
			end)

			return tool
		end
	end)

	local function addToolButton(name, info, creator)
		Extras:AddButton({
			Name = name,
			Info = info,
			Callback = function()
				giveTool(creator())
			end,
		})
	end

	addToolButton("Clone tool (Ctool)", "Tap blocks to select them, move the handles and clone them", function()
		return createClone()
	end)

	addToolButton("Move tool", "Click a block and drag the arrows to move it server side", function()
		return createMove()
	end)

	addToolButton("Editor tool", "Click a block to edit its color, material, anchor, sign and more", function()
		return createEditor()
	end)

	addToolButton("Replication tool", "Click a block to copy its look into ReplicatedStorage.Brick", function()
		return createReplication()
	end)

	addToolButton("Moderation tool", "Click a player to send a chat command targeting them", function()
		return createModeration()
	end)

	addToolButton("Giver tool", "Select blocks that give R6, Carpet, Fly, Bkit or Paint on touch", function()
		return createGiver()
	end)

	addToolButton("Trap editor tool", "Spleef, Delete, Toxify, Disco and Guess traps on blocks", function()
		return createTrap()
	end)

	addToolButton("RoTool", "Rotate ur blocks using this tool and enlighten!", function()
		return createRoTool()
	end)
end)


pcall(function()
	local Players = game:GetService("Players")
	local HttpService = game:GetService("HttpService")
	local lp = Players.LocalPlayer

	local RELAY_URL = "https://legacy-relay.system-7372772.workers.dev"
	local RELAY_KEY = "THELEGACY18W7272771_7"
	local BEAT_SECONDS = 20
	local BB_NAME = "LegacyUserBB"

	local showUsers = true
	local shareMe = true
	local active = {}
	local poke = false
	local started = false

	local requestFunction = (syn and syn.request) or (http and http.request) or http_request or request

	local Users67 = NS:AddGroup({
		Name = "Users🌐",
		Info = "Users🌐",
		Side = "Right",
	})

	local function accentFor(role)
		if role == "OWNER" then
			return Color3.fromRGB(232, 190, 92)
		end
		return Color3.fromRGB(200, 128, 92)
	end

	local function titleFor(role)
		if role == "USER" then
			return "Legacy Service User"
		end
		return "Legacy Service " .. string.upper(string.sub(role, 1, 1)) .. string.lower(string.sub(role, 2))
	end

	local function removeCard(player)
		local char = player.Character
		local head = char and char:FindFirstChild("Head")
		local card = head and head:FindFirstChild(BB_NAME)
		if card then
			card:Destroy()
		end
	end

	local function makeCard(player, key, title, accent)
		local char = player.Character
		local head = char and char:FindFirstChild("Head")
		if not head then
			return
		end
		local existing = head:FindFirstChild(BB_NAME)
		if existing then
			if existing:GetAttribute("Role") == key then
				return
			end
			existing:Destroy()
		end
		local subtitle = "@" .. player.Name .. "  |  " .. player.AccountAge .. "d"
		local gui = Library._card(head, BB_NAME, title, subtitle, accent, 3.2)
		gui:SetAttribute("Role", key)
	end

	local function syncPlayer(player)
		local isSelf = player == lp
		local char = player.Character
		local head = char and char:FindFirstChild("Head")
		local allowed = isSelf and shareMe or (not isSelf and showUsers)
		local fixedTitle, fixedAccent = Library._fixedRole(player)
		local role = active[player.UserId]
		if allowed and head and (fixedTitle or role) then
			if fixedTitle then
				makeCard(player, fixedTitle, fixedTitle, fixedAccent)
			else
				makeCard(player, role, titleFor(role), accentFor(role))
			end
		else
			removeCard(player)
		end
	end

	local function syncAll()
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(syncPlayer, player)
		end
	end

	local function beat()
		if not requestFunction or RELAY_URL == "" then
			return
		end
		if not showUsers and not shareMe then
			return
		end
		local url = string.gsub(RELAY_URL, "/+$", "") .. "/hb"
		local payload = HttpService:JSONEncode({
			userId = lp.UserId,
			jobId = game.JobId,
			key = RELAY_KEY,
			share = shareMe,
		})
		local response = requestFunction({
			Url = url,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = payload,
		})
		if not response or response.StatusCode ~= 200 then
			return
		end
		local ok, data = pcall(function()
			return HttpService:JSONDecode(response.Body)
		end)
		if not ok or type(data) ~= "table" or type(data.users) ~= "table" then
			return
		end
		local fresh = {}
		for _, entry in ipairs(data.users) do
			local id = tonumber(entry.id)
			if id then
				fresh[id] = tostring(entry.role or "USER"):upper()
			end
		end
		active = fresh
		syncAll()
	end

	local function hookPlayer(player)
		player.CharacterAdded:Connect(function()
			task.wait(1.5)
			pcall(syncPlayer, player)
		end)
		if player.Character then
			task.defer(function()
				pcall(syncPlayer, player)
			end)
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		hookPlayer(player)
	end

	Players.PlayerAdded:Connect(function(player)
		hookPlayer(player)
		task.wait(1)
		poke = true
	end)

	Players.PlayerRemoving:Connect(function(player)
		active[player.UserId] = nil
	end)

	lp.CharacterAdded:Connect(function()
		task.wait(1)
		poke = true
	end)

	local function startLoop()
		if started then
			return
		end
		started = true
		task.spawn(function()
			while true do
				pcall(beat)
				local waited = 0
				while waited < BEAT_SECONDS and not poke do
					task.wait(0.5)
					waited = waited + 0.5
				end
				poke = false
			end
		end)
	end

	local function refreshAll()
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(syncPlayer, player)
		end
	end

	Users67:AddToggle({
		Name = "Show Legacy Users",
		Info = "Shows a card over players using Legacy Service in this server",
		Default = true,
		Callback = function(value)
			showUsers = value
			refreshAll()
			poke = true
		end,
	})

	Users67:AddToggle({
		Name = "Show Me To Others",
		Info = "Lets other Legacy Service users see the card over your head",
		Default = true,
		Callback = function(value)
			shareMe = value
			refreshAll()
			poke = true
		end,
	})

	startLoop()
	task.defer(refreshAll)
end)

pcall(function()
	local Players = game:GetService("Players")
	local CoreGui = game:GetService("CoreGui")
	local lp = Players.LocalPlayer
	local S = Library._style

	local SKIN_FONT = Enum.Font.Garamond
	local CREAM = Color3.fromRGB(242, 236, 226)
	local SKIN_BG = Color3.fromRGB(28, 28, 31)
	local SKIN_PANEL = Color3.fromRGB(38, 38, 42)
	local SKIN_ELEMENT = Color3.fromRGB(50, 50, 54)
	local SKIN_INPUT = Color3.fromRGB(34, 34, 38)

	local function isNeutral(color)
		local high = math.max(color.R, color.G, color.B)
		local low = math.min(color.R, color.G, color.B)
		return high < 0.36 or (high - low) < 0.2
	end

	local function tint(color, base)
		if isNeutral(color) then
			return base
		end
		return Color3.new(color.R * 0.6, color.G * 0.6, color.B * 0.6)
	end

	local function measure(obj)
		local width = math.max(obj.AbsoluteSize.X, obj.Size.X.Offset)
		local height = math.max(obj.AbsoluteSize.Y, obj.Size.Y.Offset)
		return width, height
	end

	local function hasLayout(obj)
		return obj:FindFirstChildOfClass("UIListLayout") ~= nil
			or obj:FindFirstChildOfClass("UIGridLayout") ~= nil
			or obj:FindFirstChildOfClass("UITableLayout") ~= nil
			or obj:FindFirstChildOfClass("UIPageLayout") ~= nil
	end

	local function clearStrokes(obj)
		for _, child in ipairs(obj:GetChildren()) do
			if child:IsA("UIStroke") then
				child:Destroy()
			end
		end
	end

	local function clearGradients(obj)
		for _, child in ipairs(obj:GetChildren()) do
			if child:IsA("UIGradient") then
				child:Destroy()
			end
		end
	end

	local function ensureCorner(obj, radius)
		local corner = obj:FindFirstChildOfClass("UICorner")
		if not corner then
			corner = Instance.new("UICorner")
			corner.Parent = obj
		end
		if corner.CornerRadius.Scale == 0 and corner.CornerRadius.Offset < radius then
			corner.CornerRadius = UDim.new(0, radius)
		end
	end

	local function skinText(obj)
		if obj.Font ~= SKIN_FONT then
			obj.Font = SKIN_FONT
			if not obj.TextScaled and obj.TextSize <= 18 then
				obj.TextSize = obj.TextSize + 2
			end
		end
		local color = obj.TextColor3
		if math.min(color.R, color.G, color.B) > 0.7 and isNeutral(color) then
			obj.TextColor3 = CREAM
		end
	end

	local function raise(obj, base, radius, strokeWidth)
		if obj.BackgroundTransparency > 0.1 then
			obj.BackgroundTransparency = 0.05
		end
		obj.BackgroundColor3 = tint(obj.BackgroundColor3, base)
		clearStrokes(obj)
		clearGradients(obj)
		S.stroke(obj, nil, strokeWidth)
		ensureCorner(obj, radius)
		S.surfaceGradient(obj)
	end

	local function skinButton(obj)
		skinText(obj)
		local width, height = measure(obj)
		if obj.BackgroundTransparency >= 0.95 or width < 20 or height < 16 then
			return
		end
		if obj.Text == "" and width < 40 then
			return
		end
		raise(obj, SKIN_ELEMENT, 10, 1)
		if not obj:FindFirstChild("Bevel") and width >= 40 and height >= 24 and not hasLayout(obj) then
			S.innerBevel(obj)
		end
		obj:SetAttribute("SinkDepth", 3)

		local pressedAt = 0
		local function release()
			local stamp = pressedAt
			task.delay(math.max(0, 0.14 - (tick() - pressedAt)), function()
				if pressedAt == stamp and obj.Parent then
					S.sinkPress(obj, false, 0.14)
				end
			end)
		end
		obj.MouseButton1Down:Connect(function()
			pressedAt = tick()
			S.sinkPress(obj, true, 0.05)
		end)
		obj.MouseButton1Up:Connect(release)
		obj.MouseLeave:Connect(release)
	end

	local function skinBox(obj)
		skinText(obj)
		local width, height = measure(obj)
		if width < 28 or height < 18 then
			return
		end
		obj.PlaceholderColor3 = Color3.fromRGB(120, 112, 104)
		raise(obj, SKIN_INPUT, 10, 1)
		local gradient = obj:FindFirstChildOfClass("UIGradient")
		if gradient then
			gradient.Rotation = 270
		end
		if not obj:FindFirstChild("Bevel") and width >= 40 and height >= 24 then
			S.innerBevel(obj)
		end
	end

	local function skinFrame(obj)
		local width, height = measure(obj)
		if obj.BackgroundTransparency >= 0.95 then
			return
		end
		if width >= 40 and height >= 24 then
			local topLevel = obj.Parent ~= nil and obj.Parent:IsA("ScreenGui")
			raise(obj, topLevel and SKIN_BG or SKIN_PANEL, topLevel and 14 or 10, topLevel and 2 or 1)
			if obj:IsA("ScrollingFrame") then
				obj.ScrollBarImageColor3 = Color3.fromRGB(120, 110, 104)
			elseif not hasLayout(obj) and width >= 60 and height >= 30 and not obj:FindFirstChild("Bevel") then
				S.innerBevel(obj)
			end
		elseif height >= 8 and width >= 8 then
			if not obj:FindFirstChildOfClass("UIGradient") then
				S.surfaceGradient(obj)
			end
		end
	end

	local function skinObject(obj)
		if obj:GetAttribute("Skinned") or obj.Name == "Bevel" then
			return
		end
		if not obj:IsA("GuiObject") then
			return
		end
		if obj:IsA("TextButton") or obj:IsA("TextBox") or obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
			local width, height = measure(obj)
			if (width == 0 or height == 0) and not obj:GetAttribute("SkinWaiting") then
				obj:SetAttribute("SkinWaiting", true)
				local connection
				connection = obj:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					if obj.AbsoluteSize.X > 0 and obj.AbsoluteSize.Y > 0 then
						connection:Disconnect()
						obj:SetAttribute("SkinWaiting", nil)
						task.defer(function()
							pcall(skinObject, obj)
						end)
					end
				end)
				return
			end
		end
		obj:SetAttribute("Skinned", true)
		if obj:IsA("TextButton") then
			skinButton(obj)
		elseif obj:IsA("TextBox") then
			skinBox(obj)
		elseif obj:IsA("TextLabel") then
			skinText(obj)
		elseif obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
			skinFrame(obj)
		end
	end

	local function skinGui(gui)
		if not gui:IsA("ScreenGui") or gui:GetAttribute("GuiSkinned") or not gui:GetAttribute("LegacySkin") then
			return
		end
		gui:SetAttribute("GuiSkinned", true)
		gui.DescendantAdded:Connect(function(descendant)
			task.defer(function()
				pcall(skinObject, descendant)
			end)
		end)
		task.defer(function()
			for _, descendant in ipairs(gui:GetDescendants()) do
				pcall(skinObject, descendant)
			end
		end)
	end

	local function watch(container)
		for _, child in ipairs(container:GetChildren()) do
			pcall(skinGui, child)
		end
		container.ChildAdded:Connect(function(child)
			task.defer(function()
				pcall(skinGui, child)
			end)
		end)
	end

	watch(CoreGui)
	local playerGui = lp:FindFirstChildOfClass("PlayerGui") or lp:WaitForChild("PlayerGui", 10)
	if playerGui then
		watch(playerGui)
	end
end)

pcall(function()
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local GuiService = game:GetService("GuiService")
	local CoreGui = game:GetService("CoreGui")
	local lp = Players.LocalPlayer

	local function rgb(r, g, b)
		return Color3.fromRGB(r, g, b)
	end

	local themes = {
		Medieval = {
			font = Enum.Font.Garamond,
			fontDelta = 0,
			transparency = 0.04,
			cornerScale = 1,
			glass = false,
			colors = {
				Background = rgb(28, 28, 31),
				GroupBackground = rgb(24, 24, 27),
				Secondary = rgb(34, 34, 37),
				Panel = rgb(38, 38, 42),
				Input = rgb(34, 34, 38),
				Element = rgb(50, 50, 54),
				ToggleOff = rgb(58, 58, 62),
				Border = rgb(70, 66, 64),
				Text = rgb(242, 236, 226),
				SubText = rgb(172, 164, 155),
				Accent = rgb(176, 112, 84),
				AccentHover = rgb(204, 136, 100),
				CardBg = rgb(22, 22, 26),
				CardRim = rgb(46, 36, 34),
				EmblemRing = rgb(12, 12, 14),
				Copper = rgb(200, 128, 92),
				Letter = rgb(255, 247, 237),
				MetalHi = rgb(84, 80, 78),
				MetalMid = rgb(26, 26, 29),
				MetalLo = rgb(4, 4, 6),
				BevelHi = rgb(92, 88, 86),
				BevelLo = rgb(10, 10, 12),
				SurfaceLo = rgb(138, 138, 146),
				SurfaceLo2 = rgb(168, 168, 174),
				SurfaceLo3 = rgb(150, 150, 158),
				EmblemLo = rgb(140, 110, 100),
				Placeholder = rgb(120, 112, 104),
				ScrollBar = rgb(120, 110, 104),
			},
		},
		Aqua = {
			font = Enum.Font.Nunito,
			fontDelta = -2,
			transparency = 0.2,
			cornerScale = 1.4,
			glass = true,
			colors = {
				Background = rgb(8, 38, 56),
				GroupBackground = rgb(6, 30, 46),
				Secondary = rgb(10, 48, 68),
				Panel = rgb(12, 54, 76),
				Input = rgb(6, 32, 48),
				Element = rgb(16, 78, 104),
				ToggleOff = rgb(20, 62, 84),
				Border = rgb(90, 200, 220),
				Text = rgb(226, 248, 255),
				SubText = rgb(140, 196, 214),
				Accent = rgb(0, 190, 210),
				AccentHover = rgb(60, 225, 235),
				CardBg = rgb(6, 34, 50),
				CardRim = rgb(10, 70, 92),
				EmblemRing = rgb(4, 24, 36),
				Copper = rgb(40, 190, 220),
				Letter = rgb(240, 255, 255),
				MetalHi = rgb(120, 225, 238),
				MetalMid = rgb(24, 110, 140),
				MetalLo = rgb(6, 40, 58),
				BevelHi = rgb(140, 235, 245),
				BevelLo = rgb(6, 44, 62),
				SurfaceLo = rgb(160, 205, 220),
				SurfaceLo2 = rgb(185, 220, 235),
				SurfaceLo3 = rgb(175, 212, 228),
				EmblemLo = rgb(60, 150, 170),
				Placeholder = rgb(96, 150, 170),
				ScrollBar = rgb(90, 190, 210),
			},
		},
		Retro = {
			font = Enum.Font.Michroma,
			fontDelta = -4,
			transparency = 0.06,
			cornerScale = 0.5,
			glass = false,
			textStroke = { color = rgb(0, 230, 255), transparency = 0.6 },
			colors = {
				Background = rgb(22, 10, 38),
				GroupBackground = rgb(17, 8, 30),
				Secondary = rgb(34, 14, 54),
				Panel = rgb(40, 18, 62),
				Input = rgb(14, 8, 26),
				Element = rgb(58, 26, 86),
				ToggleOff = rgb(46, 26, 68),
				Border = rgb(255, 70, 190),
				Text = rgb(255, 238, 248),
				SubText = rgb(178, 150, 214),
				Accent = rgb(255, 46, 166),
				AccentHover = rgb(255, 150, 70),
				CardBg = rgb(15, 8, 27),
				CardRim = rgb(60, 20, 70),
				EmblemRing = rgb(10, 4, 20),
				Copper = rgb(0, 224, 255),
				Letter = rgb(255, 252, 250),
				MetalHi = rgb(255, 60, 190),
				MetalMid = rgb(100, 52, 180),
				MetalLo = rgb(0, 210, 255),
				BevelHi = rgb(255, 120, 220),
				BevelLo = rgb(0, 150, 200),
				SurfaceLo = rgb(150, 130, 182),
				SurfaceLo2 = rgb(172, 150, 204),
				SurfaceLo3 = rgb(160, 140, 192),
				EmblemLo = rgb(152, 60, 142),
				Placeholder = rgb(140, 104, 170),
				ScrollBar = rgb(255, 72, 192),
			},
		},
		Wii = {
			font = Enum.Font.Nunito,
			fontDelta = -1,
			transparency = 0.02,
			cornerScale = 1.7,
			glass = false,
			textStroke = { color = rgb(255, 255, 255), transparency = 1 },
			colors = {
				Background = rgb(238, 242, 247),
				GroupBackground = rgb(247, 249, 252),
				Secondary = rgb(226, 233, 241),
				Panel = rgb(250, 251, 254),
				Input = rgb(230, 237, 244),
				Element = rgb(251, 252, 254),
				ToggleOff = rgb(196, 206, 218),
				Border = rgb(150, 172, 194),
				Text = rgb(70, 84, 104),
				SubText = rgb(128, 143, 162),
				Accent = rgb(0, 166, 226),
				AccentHover = rgb(70, 198, 240),
				CardBg = rgb(244, 248, 252),
				CardRim = rgb(190, 214, 232),
				EmblemRing = rgb(206, 224, 238),
				Copper = rgb(0, 168, 228),
				Letter = rgb(254, 254, 255),
				MetalHi = rgb(253, 254, 255),
				MetalMid = rgb(196, 212, 228),
				MetalLo = rgb(122, 152, 180),
				BevelHi = rgb(252, 253, 255),
				BevelLo = rgb(172, 196, 216),
				SurfaceLo = rgb(222, 230, 240),
				SurfaceLo2 = rgb(230, 237, 246),
				SurfaceLo3 = rgb(226, 234, 243),
				EmblemLo = rgb(120, 190, 232),
				Placeholder = rgb(150, 163, 178),
				ScrollBar = rgb(120, 190, 226),
			},
		},
		Relax = {
			font = Enum.Font.Nunito,
			fontDelta = -1,
			transparency = 0.08,
			cornerScale = 1.3,
			glass = false,
			colors = {
				Background = rgb(22, 26, 38),
				GroupBackground = rgb(18, 22, 32),
				Secondary = rgb(28, 33, 48),
				Panel = rgb(32, 38, 56),
				Input = rgb(16, 20, 30),
				Element = rgb(40, 47, 68),
				ToggleOff = rgb(36, 42, 60),
				Border = rgb(72, 84, 120),
				Text = rgb(214, 222, 240),
				SubText = rgb(134, 146, 178),
				Accent = rgb(122, 140, 220),
				AccentHover = rgb(156, 172, 240),
				CardBg = rgb(15, 19, 29),
				CardRim = rgb(40, 48, 78),
				EmblemRing = rgb(10, 12, 20),
				Copper = rgb(126, 150, 226),
				Letter = rgb(236, 240, 252),
				MetalHi = rgb(96, 110, 170),
				MetalMid = rgb(30, 36, 56),
				MetalLo = rgb(10, 12, 22),
				BevelHi = rgb(92, 104, 150),
				BevelLo = rgb(12, 14, 24),
				SurfaceLo = rgb(136, 142, 170),
				SurfaceLo2 = rgb(158, 164, 190),
				SurfaceLo3 = rgb(146, 152, 180),
				EmblemLo = rgb(80, 96, 150),
				Placeholder = rgb(96, 108, 142),
				ScrollBar = rgb(100, 114, 170),
			},
		},
		Cafeteria = {
			font = Enum.Font.PatrickHand,
			fontDelta = 1,
			transparency = 0.05,
			cornerScale = 1.1,
			glass = false,
			colors = {
				Background = rgb(44, 30, 24),
				GroupBackground = rgb(36, 24, 19),
				Secondary = rgb(56, 38, 30),
				Panel = rgb(64, 44, 34),
				Input = rgb(30, 20, 16),
				Element = rgb(88, 62, 48),
				ToggleOff = rgb(76, 54, 44),
				Border = rgb(146, 104, 74),
				Text = rgb(250, 238, 220),
				SubText = rgb(200, 170, 140),
				Accent = rgb(214, 142, 72),
				AccentHover = rgb(238, 172, 98),
				CardBg = rgb(29, 19, 15),
				CardRim = rgb(80, 54, 40),
				EmblemRing = rgb(18, 12, 9),
				Copper = rgb(222, 152, 84),
				Letter = rgb(255, 246, 230),
				MetalHi = rgb(178, 126, 88),
				MetalMid = rgb(62, 42, 32),
				MetalLo = rgb(24, 16, 12),
				BevelHi = rgb(170, 122, 88),
				BevelLo = rgb(22, 15, 11),
				SurfaceLo = rgb(150, 128, 112),
				SurfaceLo2 = rgb(172, 150, 132),
				SurfaceLo3 = rgb(160, 138, 122),
				EmblemLo = rgb(150, 100, 70),
				Placeholder = rgb(150, 118, 92),
				ScrollBar = rgb(176, 128, 92),
			},
		},
		Realistic = {
			font = Enum.Font.Roboto,
			fontDelta = -1,
			transparency = 0.2,
			cornerScale = 1.1,
			glass = true,
			colors = {
				Background = rgb(30, 34, 40),
				GroupBackground = rgb(24, 28, 33),
				Secondary = rgb(38, 43, 50),
				Panel = rgb(44, 50, 58),
				Input = rgb(20, 24, 29),
				Element = rgb(58, 65, 75),
				ToggleOff = rgb(50, 56, 65),
				Border = rgb(120, 132, 148),
				Text = rgb(236, 240, 244),
				SubText = rgb(154, 164, 178),
				Accent = rgb(86, 148, 226),
				AccentHover = rgb(120, 172, 240),
				CardBg = rgb(19, 23, 28),
				CardRim = rgb(52, 60, 72),
				EmblemRing = rgb(12, 14, 18),
				Copper = rgb(96, 156, 232),
				Letter = rgb(244, 247, 250),
				MetalHi = rgb(150, 160, 176),
				MetalMid = rgb(46, 52, 60),
				MetalLo = rgb(14, 16, 20),
				BevelHi = rgb(140, 152, 168),
				BevelLo = rgb(16, 18, 22),
				SurfaceLo = rgb(140, 148, 160),
				SurfaceLo2 = rgb(160, 168, 180),
				SurfaceLo3 = rgb(150, 158, 170),
				EmblemLo = rgb(90, 110, 140),
				Placeholder = rgb(110, 122, 138),
				ScrollBar = rgb(120, 134, 156),
			},
		},
	}

	local libraryKeys = {
		"Background",
		"Secondary",
		"Element",
		"Border",
		"Text",
		"SubText",
		"Accent",
		"ToggleOff",
		"AccentHover",
		"GroupBackground",
	}

	local panelNames = { "Background", "GroupBackground", "Secondary", "Panel" }

	local currentName = "Medieval"
	local rng = Random.new()

	local function colorKey(color)
		return math.floor(color.R * 255 + 0.5) * 65536
			+ math.floor(color.G * 255 + 0.5) * 256
			+ math.floor(color.B * 255 + 0.5)
	end

	local function buildMap(from, to)
		local map = {}
		for name, color in pairs(from.colors) do
			local target = to.colors[name]
			local key = colorKey(color)
			if target and key ~= 16777215 and not map[key] then
				map[key] = target
			end
		end
		return map
	end

	local function panelKeySet(theme)
		local set = {}
		for _, name in ipairs(panelNames) do
			set[colorKey(theme.colors[name])] = true
		end
		return set
	end

	local function recolor(inst, prop, map)
		local ok, value = pcall(function()
			return inst[prop]
		end)
		if not ok or typeof(value) ~= "Color3" then
			return
		end
		local target = map[colorKey(value)]
		if target then
			inst[prop] = target
		end
	end

	local function applyInstance(inst, map, from, to, panelKeys)
		if inst:IsA("GuiObject") then
			local oldKey = colorKey(inst.BackgroundColor3)
			recolor(inst, "BackgroundColor3", map)

			if inst:IsA("Frame") or inst:IsA("ScrollingFrame") then
				local original = inst:GetAttribute("OrigTransp")
				if to.glass then
					local tooSmall = inst.AutomaticSize == Enum.AutomaticSize.None
						and inst.Size.Y.Scale == 0
						and inst.Size.Y.Offset > 0
						and inst.Size.Y.Offset < 30
					if panelKeys[oldKey] and not tooSmall and inst.BackgroundTransparency <= 0.12 and not original then
						inst:SetAttribute("OrigTransp", inst.BackgroundTransparency)
						inst.BackgroundTransparency = to.transparency
					end
				elseif original then
					inst.BackgroundTransparency = original
					inst:SetAttribute("OrigTransp", nil)
				end
			end

			if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
				recolor(inst, "TextColor3", map)
				if inst:IsA("TextBox") then
					recolor(inst, "PlaceholderColor3", map)
				end
				if inst.Font == from.font then
					inst.Font = to.font
					local delta = to.fontDelta - from.fontDelta
					if delta ~= 0 and not inst.TextScaled then
						inst.TextSize = math.max(8, inst.TextSize + delta)
					end
				end
				if to.textStroke then
					if inst:GetAttribute("OrigStrokeT") == nil then
						inst:SetAttribute("OrigStrokeT", inst.TextStrokeTransparency)
						inst:SetAttribute("OrigStrokeC", inst.TextStrokeColor3)
					end
					inst.TextStrokeColor3 = to.textStroke.color
					inst.TextStrokeTransparency = to.textStroke.transparency
				elseif inst:GetAttribute("OrigStrokeT") ~= nil then
					inst.TextStrokeTransparency = inst:GetAttribute("OrigStrokeT")
					inst.TextStrokeColor3 = inst:GetAttribute("OrigStrokeC")
					inst:SetAttribute("OrigStrokeT", nil)
					inst:SetAttribute("OrigStrokeC", nil)
				end
			end
			if inst:IsA("ScrollingFrame") then
				recolor(inst, "ScrollBarImageColor3", map)
			end
			if inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
				recolor(inst, "ImageColor3", map)
			end
		elseif inst:IsA("UIStroke") then
			recolor(inst, "Color", map)
		elseif inst:IsA("UIGradient") then
			local keypoints = inst.Color.Keypoints
			local changed = false
			local rebuilt = {}
			for index, point in ipairs(keypoints) do
				local target = map[colorKey(point.Value)]
				if target then
					changed = true
					rebuilt[index] = ColorSequenceKeypoint.new(point.Time, target)
				else
					rebuilt[index] = point
				end
			end
			if changed then
				inst.Color = ColorSequence.new(rebuilt)
			end
		elseif inst:IsA("UICorner") then
			local original = inst:GetAttribute("OrigCorner")
			if inst.CornerRadius.Scale == 0 then
				if original == nil and inst.CornerRadius.Offset >= 4 and inst.CornerRadius.Offset <= 20 then
					original = inst.CornerRadius.Offset
					inst:SetAttribute("OrigCorner", original)
				end
				if original then
					local scaled = math.floor(original * to.cornerScale + 0.5)
					if scaled < 2 then
						scaled = 2
					end
					inst.CornerRadius = UDim.new(0, scaled)
				end
			end
		end
	end

	local fx = nil
	local fxAlive = false
	local bubbleCount = 0
	local fxConnections = {}

	local function applyTree(root, map, from, to, panelKeys)
		pcall(applyInstance, root, map, from, to, panelKeys)
		local counter = 0
		for _, descendant in ipairs(root:GetDescendants()) do
			if not (fx and descendant:IsDescendantOf(fx)) then
				pcall(applyInstance, descendant, map, from, to, panelKeys)
			end
			counter = counter + 1
			if counter % 500 == 0 then
				task.wait()
			end
		end
	end

	local function applyNew(inst)
		if currentName == "Medieval" or not inst.Parent then
			return
		end
		if fx and inst:IsDescendantOf(fx) then
			return
		end
		local from = themes.Medieval
		local to = themes[currentName]
		pcall(applyInstance, inst, buildMap(from, to), from, to, panelKeySet(from))
	end

	local function applyNewTree(root)
		if currentName == "Medieval" or not root.Parent then
			return
		end
		local from = themes.Medieval
		local to = themes[currentName]
		applyTree(root, buildMap(from, to), from, to, panelKeySet(from))
	end

	local function hookRoot(root)
		if root:GetAttribute("ThemeHooked") then
			return
		end
		root:SetAttribute("ThemeHooked", true)
		root.DescendantAdded:Connect(function(descendant)
			if currentName == "Medieval" then
				return
			end
			task.defer(applyNew, descendant)
			task.delay(0.4, applyNew, descendant)
		end)
	end

	local function isThemeRoot(gui)
		return gui:IsA("ScreenGui") and (gui:GetAttribute("LegacySkin") or gui:GetAttribute("ThemeRoot"))
	end

	local function getRoots()
		local roots = {}
		local window = Library._window
		if window and window.Gui then
			table.insert(roots, window.Gui)
		end
		local playerGui = lp:FindFirstChildOfClass("PlayerGui")
		for _, container in ipairs({ CoreGui, playerGui }) do
			if container then
				for _, child in ipairs(container:GetChildren()) do
					if isThemeRoot(child) then
						table.insert(roots, child)
					end
				end
			end
		end
		return roots
	end

	local function getCards()
		local cards = {}
		for _, player in ipairs(Players:GetPlayers()) do
			local char = player.Character
			local head = char and char:FindFirstChild("Head")
			local card = head and head:FindFirstChild("LegacyUserBB")
			if card then
				table.insert(cards, card)
			end
		end
		return cards
	end

	local function newCircle(parent, size, color, transparency)
		local frame = Instance.new("Frame")
		frame.BackgroundColor3 = color
		frame.BackgroundTransparency = transparency
		frame.BorderSizePixel = 0
		frame.Size = UDim2.fromOffset(size, size)
		frame.Parent = parent
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = frame
		return frame
	end

	local function makeFxContainer(name, radius)
		local window = Library._window
		local main = window and window.Main
		if not main then
			return nil
		end
		local container = Instance.new("Frame")
		container.Name = name
		container.BackgroundTransparency = 1
		container.BorderSizePixel = 0
		container.Size = UDim2.fromScale(1, 1)
		container.ClipsDescendants = true
		container.ZIndex = 60
		container.Active = false
		container.Parent = main
		local containerCorner = Instance.new("UICorner")
		containerCorner.CornerRadius = UDim.new(0, radius)
		containerCorner.Parent = container
		return container, main
	end

	local function solid(parent, color, transparency, size, position)
		local frame = Instance.new("Frame")
		frame.BackgroundColor3 = color
		frame.BackgroundTransparency = transparency
		frame.BorderSizePixel = 0
		frame.Size = size
		frame.Position = position or UDim2.new(0, 0, 0, 0)
		frame.Parent = parent
		return frame
	end

	local function fadeGradient(parent, rotation, points)
		local gradient = Instance.new("UIGradient")
		gradient.Rotation = rotation
		local keypoints = {}
		for index, point in ipairs(points) do
			keypoints[index] = NumberSequenceKeypoint.new(point[1], point[2])
		end
		gradient.Transparency = NumberSequence.new(keypoints)
		gradient.Parent = parent
		return gradient
	end

	local function osdLabel(parent, text, anchor, position, align, color)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.AnchorPoint = anchor
		label.Position = position
		label.Size = UDim2.fromOffset(150, 18)
		label.Font = Enum.Font.Michroma
		label.TextSize = 11
		label.TextColor3 = color
		label.TextStrokeColor3 = Color3.fromRGB(0, 230, 255)
		label.TextStrokeTransparency = 0.35
		label.TextXAlignment = align
		label.Text = text
		label.Parent = parent
		return label
	end

	local function toWindowSpace(main, position)
		local window = Library._window
		local gui = window and window.Gui
		local inset = Vector2.new(0, 0)
		if gui and not gui.IgnoreGuiInset then
			inset = GuiService:GetGuiInset()
		end
		return Vector2.new(position.X, position.Y) - main.AbsolutePosition - inset
	end

	local function spawnRipple(parent, relative, color)
		local ring = newCircle(parent, 8, color, 1)
		ring.AnchorPoint = Vector2.new(0.5, 0.5)
		ring.Position = UDim2.fromOffset(relative.X, relative.Y)
		local outline = Instance.new("UIStroke")
		outline.Color = color
		outline.Thickness = 2
		outline.Transparency = 0.2
		outline.Parent = ring
		TweenService:Create(
			ring,
			TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.fromOffset(100, 100) }
		):Play()
		TweenService:Create(
			outline,
			TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Transparency = 1 }
		):Play()
		task.delay(0.85, function()
			ring:Destroy()
		end)
	end

	local function connectRipples(main, container, color)
		table.insert(
			fxConnections,
			UserInputService.InputBegan:Connect(function(input)
				if
					input.UserInputType ~= Enum.UserInputType.MouseButton1
					and input.UserInputType ~= Enum.UserInputType.Touch
				then
					return
				end
				local relative = toWindowSpace(main, input.Position)
				if
					relative.X >= 0
					and relative.Y >= 0
					and relative.X <= main.AbsoluteSize.X
					and relative.Y <= main.AbsoluteSize.Y
				then
					spawnRipple(container, relative, color)
				end
			end)
		)
	end

	local function makeWave(parent, width, color, transparency, period, seconds, direction, lift)
		local strip = Instance.new("Frame")
		strip.BackgroundTransparency = 1
		strip.BorderSizePixel = 0
		strip.Size = UDim2.new(0, width + period * 4, 0, period * 1.6)
		local startX = direction > 0 and -period * 2 or 0
		local endX = direction > 0 and 0 or -period * 2
		strip.Position = UDim2.new(0, startX, 1, -lift)
		strip.Parent = parent
		local count = math.ceil((width + period * 4) / period) + 1
		for index = 0, count do
			local circle = newCircle(strip, period * 1.6, color, transparency)
			circle.Position = UDim2.fromOffset(index * period, 0)
		end
		TweenService:Create(
			strip,
			TweenInfo.new(seconds, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
			{ Position = UDim2.new(0, endX, 1, -lift) }
		):Play()
	end

	local function makeRay(parent, xScale, widthPx, sway)
		local ray = Instance.new("Frame")
		ray.BackgroundColor3 = Color3.fromRGB(235, 252, 255)
		ray.BackgroundTransparency = 0
		ray.BorderSizePixel = 0
		ray.Rotation = 16
		ray.Size = UDim2.new(0, widthPx, 1.7, 0)
		ray.Position = UDim2.new(xScale, 0, -0.25, 0)
		ray.Parent = parent
		local fade = Instance.new("UIGradient")
		fade.Rotation = 90
		fade.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.9),
			NumberSequenceKeypoint.new(0.6, 0.96),
			NumberSequenceKeypoint.new(1, 1),
		})
		fade.Parent = ray
		TweenService:Create(
			ray,
			TweenInfo.new(rng:NextNumber(5, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.new(xScale, sway, -0.25, 0) }
		):Play()
	end

	local function spawnBubble(root)
		if not root or not root.Parent then
			return
		end
		local size = rng:NextInteger(6, 18)
		local x = rng:NextNumber(0.03, 0.97)
		local rise = rng:NextNumber(4.5, 8.5)

		local wrapper = Instance.new("Frame")
		wrapper.BackgroundTransparency = 1
		wrapper.Size = UDim2.fromOffset(size, size)
		wrapper.Position = UDim2.new(x, 0, 1, size)
		wrapper.Parent = root

		local swayHolder = Instance.new("Frame")
		swayHolder.BackgroundTransparency = 1
		swayHolder.Size = UDim2.fromScale(1, 1)
		swayHolder.Parent = wrapper

		local bubble = newCircle(swayHolder, size, Color3.fromRGB(210, 245, 255), 0.78)
		bubble.Size = UDim2.fromScale(1, 1)

		local rim = Instance.new("UIStroke")
		rim.Color = Color3.fromRGB(235, 252, 255)
		rim.Thickness = 1
		rim.Transparency = 0.45
		rim.Parent = bubble

		local shine = newCircle(bubble, 4, Color3.fromRGB(255, 255, 255), 0.3)
		shine.Size = UDim2.fromScale(0.28, 0.28)
		shine.Position = UDim2.fromScale(0.2, 0.17)

		bubbleCount = bubbleCount + 1

		TweenService:Create(
			swayHolder,
			TweenInfo.new(rng:NextNumber(1, 1.8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.fromOffset(rng:NextInteger(-12, 12), 0) }
		):Play()

		TweenService:Create(
			bubble,
			TweenInfo.new(rise * 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, rise * 0.65),
			{ BackgroundTransparency = 1 }
		):Play()
		TweenService:Create(
			rim,
			TweenInfo.new(rise * 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, rise * 0.65),
			{ Transparency = 1 }
		):Play()

		local rising = TweenService:Create(
			wrapper,
			TweenInfo.new(rise, Enum.EasingStyle.Linear),
			{ Position = UDim2.new(x, 0, -0.1, -size) }
		)
		rising.Completed:Connect(function()
			bubbleCount = math.max(0, bubbleCount - 1)
			wrapper:Destroy()
		end)
		rising:Play()
	end

	local fxNames = {
		AquaFX = true,
		RetroFX = true,
		WiiFX = true,
		RelaxFX = true,
		CafeFX = true,
		RealisticFX = true,
	}

	local function purgeFx()
		local window = Library._window
		local main = window and window.Main
		if not main then
			return
		end
		for _, child in ipairs(main:GetChildren()) do
			if fxNames[child.Name] then
				child:Destroy()
			end
		end
	end

	local function stopFx()
		fxAlive = false
		for _, connection in ipairs(fxConnections) do
			connection:Disconnect()
		end
		fxConnections = {}
		if fx then
			fx:Destroy()
			fx = nil
		end
		purgeFx()
		bubbleCount = 0
	end

	local function startAquaFx()
		local window = Library._window
		local main = window and window.Main
		if not main then
			return
		end

		fx = Instance.new("Frame")
		local aquaRoot = fx
		fx.Name = "AquaFX"
		fx.BackgroundTransparency = 1
		fx.BorderSizePixel = 0
		fx.Size = UDim2.fromScale(1, 1)
		fx.ClipsDescendants = true
		fx.ZIndex = 60
		fx.Active = false
		fx.Parent = main

		local fxCorner = Instance.new("UICorner")
		fxCorner.CornerRadius = UDim.new(0, 20)
		fxCorner.Parent = fx

		local water = Instance.new("Frame")
		water.BackgroundColor3 = Color3.fromRGB(30, 170, 210)
		water.BackgroundTransparency = 0
		water.BorderSizePixel = 0
		water.Size = UDim2.fromScale(1, 1)
		water.Parent = fx
		local waterGradient = Instance.new("UIGradient")
		waterGradient.Rotation = 90
		waterGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.55, 0.96),
			NumberSequenceKeypoint.new(1, 0.78),
		})
		waterGradient.Parent = water
		TweenService:Create(
			waterGradient,
			TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Offset = Vector2.new(0, 0.12) }
		):Play()

		local width = math.max(main.AbsoluteSize.X, 520)
		makeRay(fx, 0.12, 54, 26)
		makeRay(fx, 0.44, 82, -30)
		makeRay(fx, 0.74, 60, 22)
		makeWave(fx, width, Color3.fromRGB(70, 180, 220), 0.8, 36, 4.6, -1, 22)
		makeWave(fx, width, Color3.fromRGB(150, 230, 245), 0.84, 36, 3, 1, 14)

		local fishCount = 0
		local function spawnFish()
			if not aquaRoot.Parent then
				return
			end
			local size = rng:NextInteger(14, 26)
			local direction = rng:NextInteger(1, 2) == 1 and 1 or -1
			local y = rng:NextNumber(0.18, 0.7)
			local travel = rng:NextNumber(10, 16)
			local tint = rng:NextInteger(1, 2) == 1 and Color3.fromRGB(110, 230, 235) or Color3.fromRGB(255, 190, 120)

			local holder = Instance.new("Frame")
			holder.BackgroundTransparency = 1
			holder.Size = UDim2.fromOffset(size * 2.4, size)
			holder.Position = UDim2.new(direction > 0 and -0.15 or 1.1, 0, y, 0)
			holder.Parent = aquaRoot

			local bob = Instance.new("Frame")
			bob.BackgroundTransparency = 1
			bob.Size = UDim2.fromScale(1, 1)
			bob.Parent = holder

			local bodyX = direction > 0 and size * 0.6 or 0
			local body = newCircle(bob, size, tint, 0.7)
			body.Size = UDim2.fromOffset(size * 1.8, size)
			body.Position = UDim2.fromOffset(bodyX, 0)

			local tail = solid(bob, tint, 0.7, UDim2.fromOffset(size * 0.55, size * 0.55))
			tail.Rotation = 45
			tail.Position = direction > 0 and UDim2.fromOffset(size * 0.05, size * 0.225) or UDim2.fromOffset(size * 1.85, size * 0.225)

			local eye = newCircle(bob, 3, Color3.fromRGB(10, 40, 60), 0.2)
			eye.Position = UDim2.fromOffset(direction > 0 and bodyX + size * 1.35 or bodyX + size * 0.4, size * 0.28)

			fishCount = fishCount + 1
			TweenService:Create(
				bob,
				TweenInfo.new(rng:NextNumber(1.2, 2), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{ Position = UDim2.fromOffset(0, rng:NextInteger(-7, 7)) }
			):Play()
			local swim = TweenService:Create(
				holder,
				TweenInfo.new(travel, Enum.EasingStyle.Linear),
				{ Position = UDim2.new(direction > 0 and 1.1 or -0.15, 0, y, 0) }
			)
			swim.Completed:Connect(function()
				fishCount = math.max(0, fishCount - 1)
				holder:Destroy()
			end)
			swim:Play()
		end

		task.spawn(function()
			while fxAlive and aquaRoot.Parent do
				if fishCount < 3 then
					pcall(spawnFish)
				end
				task.wait(rng:NextNumber(3, 6))
			end
		end)

		connectRipples(main, fx, Color3.fromRGB(200, 245, 255))

		fxAlive = true
		task.spawn(function()
			while fxAlive and aquaRoot.Parent do
				if bubbleCount < 14 then
					pcall(spawnBubble, aquaRoot)
				end
				task.wait(rng:NextNumber(0.35, 0.8))
			end
		end)
	end

	local function startRetroFx()
		local container, main = makeFxContainer("RetroFX", 8)
		if not container then
			return
		end
		fx = container

		local width = math.max(main.AbsoluteSize.X, 500)
		local height = math.max(main.AbsoluteSize.Y, 340)
		local horizon = math.floor(height * 0.6)
		local floorHeight = height - horizon

		local wash = solid(container, Color3.fromRGB(255, 255, 255), 0, UDim2.fromScale(1, 1))
		local washGradient = Instance.new("UIGradient")
		washGradient.Rotation = 90
		washGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 40, 200)),
			ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 60, 170)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 60)),
		})
		washGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.95),
			NumberSequenceKeypoint.new(1, 0.86),
		})
		washGradient.Parent = wash

		local sky = Instance.new("Frame")
		sky.BackgroundTransparency = 1
		sky.ClipsDescendants = true
		sky.Size = UDim2.new(1, 0, 0, horizon)
		sky.Parent = container

		local sunSize = math.floor(height * 0.36)
		local sun = Instance.new("Frame")
		sun.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sun.BackgroundTransparency = 0
		sun.BorderSizePixel = 0
		sun.Size = UDim2.fromOffset(sunSize, sunSize)
		sun.Position = UDim2.new(0.5, -sunSize / 2, 0, horizon - math.floor(sunSize * 0.66))
		sun.Parent = sky
		local sunCorner = Instance.new("UICorner")
		sunCorner.CornerRadius = UDim.new(1, 0)
		sunCorner.Parent = sun
		local sunGradient = Instance.new("UIGradient")
		sunGradient.Rotation = 90
		sunGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 90)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 130, 70)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 160)),
		})
		sunGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.8),
			NumberSequenceKeypoint.new(0.55, 0.8),
			NumberSequenceKeypoint.new(0.5501, 1),
			NumberSequenceKeypoint.new(0.58, 1),
			NumberSequenceKeypoint.new(0.5801, 0.8),
			NumberSequenceKeypoint.new(0.66, 0.8),
			NumberSequenceKeypoint.new(0.6601, 1),
			NumberSequenceKeypoint.new(0.71, 1),
			NumberSequenceKeypoint.new(0.7101, 0.8),
			NumberSequenceKeypoint.new(0.79, 0.8),
			NumberSequenceKeypoint.new(0.7901, 1),
			NumberSequenceKeypoint.new(0.86, 1),
			NumberSequenceKeypoint.new(0.8601, 0.8),
			NumberSequenceKeypoint.new(1, 0.8),
		})
		sunGradient.Parent = sun

		local grid = Instance.new("Frame")
		grid.BackgroundTransparency = 1
		grid.ClipsDescendants = true
		grid.Size = UDim2.new(1, 0, 0, floorHeight)
		grid.Position = UDim2.new(0, 0, 0, horizon)
		grid.Parent = container

		solid(grid, Color3.fromRGB(0, 230, 255), 0.5, UDim2.new(1, 0, 0, 2))

		local lineLength = floorHeight * 1.7
		for index = -9, 9 do
			local angle = math.rad(index * 6.5)
			local line = solid(grid, Color3.fromRGB(255, 70, 200), 0.72, UDim2.fromOffset(1, lineLength))
			line.AnchorPoint = Vector2.new(0.5, 0.5)
			line.Position = UDim2.new(0.5, -math.sin(angle) * lineLength / 2, 0, math.cos(angle) * lineLength / 2)
			line.Rotation = index * 6.5
		end

		local rows = {}
		for index = 1, 9 do
			rows[index] = solid(grid, Color3.fromRGB(0, 220, 255), 0.7, UDim2.new(1, 0, 0, 1))
		end

		local scan = Instance.new("Frame")
		scan.BackgroundTransparency = 1
		scan.Size = UDim2.fromScale(1, 1)
		scan.Parent = container
		for y = 0, height, 5 do
			solid(scan, Color3.fromRGB(0, 0, 0), 0.9, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 0, y))
		end

		local shapeColors = {
			Color3.fromRGB(255, 232, 90),
			Color3.fromRGB(0, 224, 200),
			Color3.fromRGB(255, 80, 170),
		}
		for index = 1, 7 do
			local size = rng:NextInteger(16, 34)
			local shape = Instance.new("Frame")
			shape.BackgroundTransparency = 1
			shape.BorderSizePixel = 0
			shape.Size = UDim2.fromOffset(size, size)
			local baseX = rng:NextNumber(0.04, 0.94)
			local baseY = rng:NextNumber(0.06, 0.55)
			shape.Position = UDim2.new(baseX, 0, baseY, 0)
			shape.Rotation = rng:NextInteger(0, 90)
			shape.Parent = container
			if index % 2 == 0 then
				local round = Instance.new("UICorner")
				round.CornerRadius = UDim.new(1, 0)
				round.Parent = shape
			end
			local outline = Instance.new("UIStroke")
			outline.Color = shapeColors[(index - 1) % 3 + 1]
			outline.Thickness = 2
			outline.Transparency = 0.4
			outline.Parent = shape
			TweenService:Create(
				shape,
				TweenInfo.new(rng:NextNumber(5, 9), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{
					Position = UDim2.new(baseX, rng:NextInteger(-18, 18), baseY, rng:NextInteger(-16, 16)),
					Rotation = shape.Rotation + rng:NextInteger(-50, 50),
				}
			):Play()
		end

		local black = Color3.fromRGB(0, 0, 0)
		local top = solid(container, black, 0, UDim2.new(1, 0, 0, 46))
		fadeGradient(top, 90, { { 0, 0.5 }, { 1, 1 } })
		local bottom = solid(container, black, 0, UDim2.new(1, 0, 0, 46), UDim2.new(0, 0, 1, -46))
		fadeGradient(bottom, 90, { { 0, 1 }, { 1, 0.5 } })
		local left = solid(container, black, 0, UDim2.new(0, 46, 1, 0))
		fadeGradient(left, 0, { { 0, 0.5 }, { 1, 1 } })
		local right = solid(container, black, 0, UDim2.new(0, 46, 1, 0), UDim2.new(1, -46, 0, 0))
		fadeGradient(right, 0, { { 0, 1 }, { 1, 0.5 } })

		local band = solid(container, Color3.fromRGB(255, 255, 255), 0, UDim2.new(1, 0, 0, 58), UDim2.new(0, 0, 0, -64))
		fadeGradient(band, 90, { { 0, 1 }, { 0.42, 0.9 }, { 0.5, 0.8 }, { 0.58, 0.9 }, { 1, 1 } })
		TweenService:Create(
			band,
			TweenInfo.new(5.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false),
			{ Position = UDim2.new(0, 0, 1, 8) }
		):Play()

		local playLabel = osdLabel(container, "PLAY >", Vector2.new(0, 0), UDim2.new(0, 12, 0, 8), Enum.TextXAlignment.Left, Color3.fromRGB(255, 255, 255))
		local recLabel = osdLabel(container, "REC *", Vector2.new(1, 0), UDim2.new(1, -12, 0, 8), Enum.TextXAlignment.Right, Color3.fromRGB(255, 70, 90))
		local counter = osdLabel(container, "SP 00:00:00", Vector2.new(1, 1), UDim2.new(1, -12, 1, -8), Enum.TextXAlignment.Right, Color3.fromRGB(255, 255, 255))

		fxAlive = true

		task.spawn(function()
			local started = tick()
			local blink = true
			while fxAlive and container.Parent do
				local elapsed = math.floor(tick() - started)
				counter.Text = string.format("SP %02d:%02d:%02d", math.floor(elapsed / 3600), math.floor(elapsed / 60) % 60, elapsed % 60)
				blink = not blink
				recLabel.TextTransparency = blink and 0 or 1
				recLabel.TextStrokeTransparency = blink and 0.35 or 1
				playLabel.TextTransparency = (elapsed % 7 == 0) and 0.6 or 0
				task.wait(0.6)
			end
		end)

		task.spawn(function()
			local phase = 0
			while fxAlive and container.Parent do
				phase = (phase + 0.03) % 1
				for index, row in ipairs(rows) do
					local t = ((index - 1 + phase) % #rows) / #rows
					row.Position = UDim2.new(0, 0, 0, math.floor(floorHeight * t ^ 2.2))
				end
				task.wait(0.05)
			end
		end)

		task.spawn(function()
			while fxAlive and container.Parent do
				task.wait(rng:NextNumber(1.6, 4.2))
				if not (fxAlive and container.Parent) then
					break
				end
				for _ = 1, rng:NextInteger(2, 4) do
					local tint = rng:NextInteger(1, 2) == 1 and Color3.fromRGB(255, 60, 200) or Color3.fromRGB(60, 230, 255)
					local strip = solid(
						container,
						tint,
						0.7,
						UDim2.new(1, 0, 0, rng:NextInteger(4, 20)),
						UDim2.new(rng:NextNumber(-0.04, 0.04), 0, rng:NextNumber(0, 0.95), 0)
					)
					TweenService:Create(
						strip,
						TweenInfo.new(0.14, Enum.EasingStyle.Linear),
						{ Position = UDim2.new(rng:NextNumber(-0.08, 0.08), 0, strip.Position.Y.Scale, 0), BackgroundTransparency = 1 }
					):Play()
					task.delay(0.16, function()
						strip:Destroy()
					end)
				end
			end
		end)
	end

	local function startWiiFx()
		local container, main = makeFxContainer("WiiFX", 24)
		if not container then
			return
		end
		fx = container

		local width = math.max(main.AbsoluteSize.X, 500)
		local height = math.max(main.AbsoluteSize.Y, 340)

		fxAlive = true

		local gloss = solid(container, Color3.fromRGB(255, 255, 255), 0, UDim2.fromScale(1, 1))
		fadeGradient(gloss, 90, { { 0, 0.55 }, { 0.46, 0.8 }, { 0.4601, 1 }, { 1, 1 } })

		local hillBack = newCircle(container, 10, Color3.fromRGB(110, 205, 245), 0.84)
		hillBack.Size = UDim2.fromOffset(width * 1.7, width * 1.7)
		hillBack.Position = UDim2.new(0, -width * 0.35, 1, -height * 0.16)
		local hillFront = newCircle(container, 10, Color3.fromRGB(255, 255, 255), 0.62)
		hillFront.Size = UDim2.fromOffset(width * 1.9, width * 1.9)
		hillFront.Position = UDim2.new(0, -width * 0.55, 1, -height * 0.07)

		TweenService:Create(
			hillBack,
			TweenInfo.new(7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.new(0, -width * 0.2, 1, -height * 0.18) }
		):Play()
		TweenService:Create(
			hillFront,
			TweenInfo.new(9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.new(0, -width * 0.4, 1, -height * 0.09) }
		):Play()

		local function spawnOrb()
			if not fx then
				return
			end
			local size = rng:NextInteger(18, 56)
			local x = rng:NextNumber(0.03, 0.97)
			local life = rng:NextNumber(9, 15)
			local orb = newCircle(container, size, Color3.fromRGB(170, 225, 250), 0.84)
			orb.Position = UDim2.new(x, 0, 1, size)
			local orbRim = Instance.new("UIStroke")
			orbRim.Color = Color3.fromRGB(120, 200, 240)
			orbRim.Thickness = 1
			orbRim.Transparency = 0.55
			orbRim.Parent = orb
			TweenService:Create(
				orbRim,
				TweenInfo.new(life * 0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, life * 0.6),
				{ Transparency = 1 }
			):Play()
			bubbleCount = bubbleCount + 1
			TweenService:Create(
				orb,
				TweenInfo.new(life * 0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, life * 0.6),
				{ BackgroundTransparency = 1 }
			):Play()
			local rising = TweenService:Create(
				orb,
				TweenInfo.new(life, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
				{ Position = UDim2.new(x, rng:NextInteger(-24, 24), 0.05, 0) }
			)
			rising.Completed:Connect(function()
				bubbleCount = math.max(0, bubbleCount - 1)
				orb:Destroy()
			end)
			rising:Play()
		end

		local glowFrame = Instance.new("Frame")
		glowFrame.BackgroundTransparency = 1
		glowFrame.Size = UDim2.new(1, -10, 1, -10)
		glowFrame.Position = UDim2.fromOffset(5, 5)
		glowFrame.Parent = container
		local glowCorner = Instance.new("UICorner")
		glowCorner.CornerRadius = UDim.new(0, 20)
		glowCorner.Parent = glowFrame
		local glowStroke = Instance.new("UIStroke")
		glowStroke.Color = Color3.fromRGB(110, 205, 245)
		glowStroke.Thickness = 2
		glowStroke.Transparency = 0.5
		glowStroke.Parent = glowFrame
		TweenService:Create(
			glowStroke,
			TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Transparency = 0.88 }
		):Play()

		local sweep = solid(container, Color3.fromRGB(255, 255, 255), 0, UDim2.new(0, 110, 1.8, 0), UDim2.new(-0.3, 0, -0.4, 0))
		sweep.Rotation = 18
		fadeGradient(sweep, 0, { { 0, 1 }, { 0.5, 0.7 }, { 1, 1 } })
		task.spawn(function()
			while fxAlive and container.Parent do
				task.wait(rng:NextNumber(4, 7))
				if not (fxAlive and container.Parent) then
					break
				end
				TweenService:Create(
					sweep,
					TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{ Position = UDim2.new(1.2, 0, -0.4, 0) }
				):Play()
				task.wait(1.7)
				sweep.Position = UDim2.new(-0.3, 0, -0.4, 0)
			end
		end)

		local function sparkle()
			local holder = Instance.new("Frame")
			holder.BackgroundTransparency = 1
			holder.AnchorPoint = Vector2.new(0.5, 0.5)
			holder.Size = UDim2.fromOffset(16, 16)
			holder.Parent = container
			local arms = {}
			for index = 1, 2 do
				local arm = solid(holder, Color3.fromRGB(90, 196, 242), 1, index == 1 and UDim2.new(1, 0, 0, 2) or UDim2.new(0, 2, 1, 0))
				arm.AnchorPoint = Vector2.new(0.5, 0.5)
				arm.Position = UDim2.fromScale(0.5, 0.5)
				local armCorner = Instance.new("UICorner")
				armCorner.CornerRadius = UDim.new(1, 0)
				armCorner.Parent = arm
				arms[index] = arm
			end
			task.spawn(function()
				task.wait(rng:NextNumber(0, 3))
				while fxAlive and container.Parent do
					holder.Position = UDim2.new(rng:NextNumber(0.05, 0.95), 0, rng:NextNumber(0.06, 0.7), 0)
					holder.Rotation = 0
					for _, arm in ipairs(arms) do
						TweenService:Create(arm, TweenInfo.new(0.5), { BackgroundTransparency = 0.1 }):Play()
					end
					TweenService:Create(holder, TweenInfo.new(1.3, Enum.EasingStyle.Sine), { Rotation = 90 }):Play()
					task.wait(0.8)
					for _, arm in ipairs(arms) do
						TweenService:Create(arm, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
					end
					task.wait(rng:NextNumber(1.2, 3.8))
				end
			end)
		end
		for _ = 1, 6 do
			sparkle()
		end

		connectRipples(main, container, Color3.fromRGB(0, 166, 226))

		if UserInputService.MouseEnabled then
			local pointer = Instance.new("Frame")
			pointer.BackgroundTransparency = 1
			pointer.AnchorPoint = Vector2.new(0.5, 0.5)
			pointer.Size = UDim2.fromOffset(34, 34)
			pointer.Visible = false
			pointer.Parent = container
			local pointerCorner = Instance.new("UICorner")
			pointerCorner.CornerRadius = UDim.new(1, 0)
			pointerCorner.Parent = pointer
			local pointerRing = Instance.new("UIStroke")
			pointerRing.Color = Color3.fromRGB(0, 166, 226)
			pointerRing.Thickness = 2
			pointerRing.Transparency = 0.3
			pointerRing.Parent = pointer
			local dot = newCircle(pointer, 6, Color3.fromRGB(0, 166, 226), 0.2)
			dot.AnchorPoint = Vector2.new(0.5, 0.5)
			dot.Position = UDim2.fromScale(0.5, 0.5)
			local smooth = nil
			table.insert(
				fxConnections,
				RunService.Heartbeat:Connect(function()
					local relative = toWindowSpace(main, UserInputService:GetMouseLocation())
					local inside = relative.X >= 0
						and relative.Y >= 0
						and relative.X <= main.AbsoluteSize.X
						and relative.Y <= main.AbsoluteSize.Y
					pointer.Visible = inside
					if inside then
						smooth = smooth and smooth:Lerp(relative, 0.35) or relative
						pointer.Position = UDim2.fromOffset(smooth.X, smooth.Y)
					end
				end)
			)
		end

		bubbleCount = 0
		fxAlive = true
		task.spawn(function()
			while fxAlive and container.Parent do
				if bubbleCount < 9 then
					pcall(spawnOrb)
				end
				task.wait(rng:NextNumber(0.9, 1.8))
			end
		end)
	end

	local function startRelaxFx()
		local container, main = makeFxContainer("RelaxFX", 18)
		if not container then
			return
		end
		fx = container
		fxAlive = true

		local tint = solid(container, Color3.fromRGB(70, 90, 190), 0, UDim2.fromScale(1, 1))
		fadeGradient(tint, 90, { { 0, 0.94 }, { 1, 0.9 } })

		local auroraColors = {
			{ Color3.fromRGB(60, 220, 190), Color3.fromRGB(150, 110, 240) },
			{ Color3.fromRGB(110, 140, 255), Color3.fromRGB(60, 220, 190) },
			{ Color3.fromRGB(170, 110, 240), Color3.fromRGB(80, 190, 250) },
		}
		for index = 1, 3 do
			local band = solid(
				container,
				Color3.fromRGB(255, 255, 255),
				0,
				UDim2.new(1.7, 0, 0, 56 + index * 10),
				UDim2.new(-0.35, 0, 0.06 + index * 0.24, 0)
			)
			band.Rotation = -10
			local gradient = Instance.new("UIGradient")
			gradient.Rotation = 0
			gradient.Color = ColorSequence.new(auroraColors[index][1], auroraColors[index][2])
			gradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.3, 0.93),
				NumberSequenceKeypoint.new(0.7, 0.93),
				NumberSequenceKeypoint.new(1, 1),
			})
			gradient.Parent = band
			TweenService:Create(
				band,
				TweenInfo.new(11 + index * 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{ Position = UDim2.new(-0.12, 0, 0.1 + index * 0.24, 0) }
			):Play()
			TweenService:Create(
				gradient,
				TweenInfo.new(7 + index, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{ Offset = Vector2.new(0.2, 0) }
			):Play()
		end

		for _ = 1, 18 do
			local star = newCircle(container, rng:NextInteger(2, 3), Color3.fromRGB(225, 232, 255), 0.85)
			star.Position = UDim2.new(rng:NextNumber(0.02, 0.98), 0, rng:NextNumber(0.02, 0.9), 0)
			TweenService:Create(
				star,
				TweenInfo.new(rng:NextNumber(1.6, 4.2), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{ BackgroundTransparency = 0.25 }
			):Play()
		end

		local halo = newCircle(container, 96, Color3.fromRGB(210, 220, 255), 0.95)
		halo.Position = UDim2.new(1, -86, 0, -14)
		TweenService:Create(
			halo,
			TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ BackgroundTransparency = 0.9 }
		):Play()
		local moon = newCircle(container, 40, Color3.fromRGB(236, 240, 255), 0.82)
		moon.Position = UDim2.new(1, -58, 0, 14)
		local moonRim = Instance.new("UIStroke")
		moonRim.Color = Color3.fromRGB(200, 210, 255)
		moonRim.Thickness = 1
		moonRim.Transparency = 0.85
		moonRim.Parent = moon

		task.spawn(function()
			while fxAlive and container.Parent do
				task.wait(rng:NextNumber(9, 15))
				if not (fxAlive and container.Parent) then
					break
				end
				local startX = rng:NextNumber(0.1, 0.5)
				local startY = rng:NextNumber(0.04, 0.3)
				local streak = solid(container, Color3.fromRGB(255, 255, 255), 0, UDim2.fromOffset(70, 2), UDim2.new(startX, 0, startY, 0))
				streak.Rotation = 25
				fadeGradient(streak, 0, { { 0, 1 }, { 1, 0.1 } })
				TweenService:Create(
					streak,
					TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ Position = UDim2.new(startX + 0.28, 0, startY + 0.2, 0), BackgroundTransparency = 1 }
				):Play()
				task.delay(1, function()
					streak:Destroy()
				end)
			end
		end)

		connectRipples(main, container, Color3.fromRGB(170, 185, 255))
	end

	local function startCafeFx()
		local container, main = makeFxContainer("CafeFX", 14)
		if not container then
			return
		end
		fx = container
		fxAlive = true

		local width = math.max(main.AbsoluteSize.X, 500)
		local height = math.max(main.AbsoluteSize.Y, 340)

		local wash = solid(container, Color3.fromRGB(255, 170, 80), 0, UDim2.fromScale(1, 1))
		fadeGradient(wash, 90, { { 0, 0.97 }, { 1, 0.9 } })

		local lampSize = math.floor(width * 1.3)
		local lamp = newCircle(container, lampSize, Color3.fromRGB(255, 196, 120), 0.93)
		lamp.Position = UDim2.new(0.5, -lampSize / 2, 0, -math.floor(lampSize * 0.64))
		TweenService:Create(
			lamp,
			TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ BackgroundTransparency = 0.89 }
		):Play()

		local steamCount = 0
		local function spawnSteam()
			if not fx then
				return
			end
			local wisp = newCircle(container, 10, Color3.fromRGB(255, 246, 232), 0.8)
			wisp.Size = UDim2.fromOffset(9, 24)
			local baseX = rng:NextInteger(math.floor(width * 0.08), math.floor(width * 0.92))
			wisp.Position = UDim2.fromOffset(baseX, height - 24)
			steamCount = steamCount + 1
			local lift = rng:NextNumber(2.6, 4)
			TweenService:Create(
				wisp,
				TweenInfo.new(lift, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
				{
					Position = UDim2.fromOffset(baseX + rng:NextInteger(-14, 14), height - 130),
					Size = UDim2.fromOffset(16, 40),
					BackgroundTransparency = 1,
				}
			):Play()
			task.delay(lift, function()
				steamCount = math.max(0, steamCount - 1)
				wisp:Destroy()
			end)
		end

		task.spawn(function()
			while fxAlive and container.Parent do
				if steamCount < 7 then
					pcall(spawnSteam)
				end
				task.wait(rng:NextNumber(0.5, 0.9))
			end
		end)
		connectRipples(main, container, Color3.fromRGB(255, 214, 160))
	end

	local function startRealisticFx()
		local container, main = makeFxContainer("RealisticFX", 16)
		if not container then
			return
		end
		fx = container
		fxAlive = true

		local width = math.max(main.AbsoluteSize.X, 500)
		local height = math.max(main.AbsoluteSize.Y, 340)
		local white = Color3.fromRGB(255, 255, 255)

		local fog = solid(container, white, 0, UDim2.fromScale(1, 1))
		fadeGradient(fog, 45, { { 0, 0.9 }, { 0.5, 0.96 }, { 1, 0.92 } })

		local bokehColors = {
			Color3.fromRGB(255, 214, 150),
			Color3.fromRGB(150, 200, 255),
			Color3.fromRGB(255, 180, 190),
		}
		for index = 1, 8 do
			local color = bokehColors[(index - 1) % 3 + 1]
			local size = rng:NextInteger(22, 56)
			local bokeh = newCircle(container, size, color, 0.92)
			local bx = rng:NextNumber(0.04, 0.94)
			local by = rng:NextNumber(0.05, 0.9)
			bokeh.Position = UDim2.new(bx, 0, by, 0)
			local bokehRim = Instance.new("UIStroke")
			bokehRim.Color = color
			bokehRim.Thickness = 1
			bokehRim.Transparency = 0.86
			bokehRim.Parent = bokeh
			TweenService:Create(
				bokeh,
				TweenInfo.new(rng:NextNumber(6, 10), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{ Position = UDim2.new(bx, rng:NextInteger(-16, 16), by, rng:NextInteger(-12, 12)) }
			):Play()
		end

		local beam = solid(container, Color3.fromRGB(255, 240, 210), 0, UDim2.new(0, 180, 1.9, 0), UDim2.new(0.04, 0, -0.45, 0))
		beam.Rotation = -24
		fadeGradient(beam, 90, { { 0, 0.9 }, { 0.7, 0.96 }, { 1, 1 } })
		TweenService:Create(
			beam,
			TweenInfo.new(16, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.new(0.1, 0, -0.45, 0) }
		):Play()

		for _ = 1, 12 do
			local size = rng:NextInteger(2, 3)
			local mote = newCircle(container, size, Color3.fromRGB(255, 246, 226), 0.5)
			local mx = rng:NextNumber(0.04, 0.4)
			local my = rng:NextNumber(0.05, 0.85)
			mote.Position = UDim2.new(mx, 0, my, 0)
			TweenService:Create(
				mote,
				TweenInfo.new(rng:NextNumber(5, 9), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{
					Position = UDim2.new(mx, rng:NextInteger(-22, 22), my, rng:NextInteger(-30, 30)),
					BackgroundTransparency = 0.85,
				}
			):Play()
		end

		local glare = solid(container, white, 0, UDim2.new(0, 120, 1.9, 0), UDim2.new(0.08, 0, -0.4, 0))
		glare.Rotation = 20
		fadeGradient(glare, 0, { { 0, 1 }, { 0.45, 0.93 }, { 0.55, 0.93 }, { 1, 1 } })
		TweenService:Create(
			glare,
			TweenInfo.new(14, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
			{ Position = UDim2.new(0.55, 0, -0.4, 0) }
		):Play()

		local black = Color3.fromRGB(0, 0, 0)
		local top = solid(container, black, 0, UDim2.new(1, 0, 0, 60))
		fadeGradient(top, 90, { { 0, 0.62 }, { 1, 1 } })
		local bottom = solid(container, black, 0, UDim2.new(1, 0, 0, 70), UDim2.new(0, 0, 1, -70))
		fadeGradient(bottom, 90, { { 0, 1 }, { 1, 0.55 } })
		local left = solid(container, black, 0, UDim2.new(0, 60, 1, 0))
		fadeGradient(left, 0, { { 0, 0.66 }, { 1, 1 } })
		local right = solid(container, black, 0, UDim2.new(0, 60, 1, 0), UDim2.new(1, -60, 0, 0))
		fadeGradient(right, 0, { { 0, 1 }, { 1, 0.66 } })

		local dropCount = 0
		local function spawnDroplet()
			if not container.Parent then
				return
			end
			local size = rng:NextInteger(5, 13)
			local x = rng:NextNumber(0.03, 0.97)
			local y = rng:NextNumber(0.04, 0.8)
			local slides = rng:NextInteger(1, 100) <= 45

			local trail = nil
			if slides then
				trail = solid(container, Color3.fromRGB(205, 226, 244), 0, UDim2.fromOffset(2, 0), UDim2.new(x, math.floor(size / 2) - 1, y, size))
				fadeGradient(trail, 90, { { 0, 1 }, { 1, 0.8 } })
			end

			local drop = newCircle(container, size, Color3.fromRGB(205, 226, 244), 1)
			drop.Position = UDim2.new(x, 0, y, 0)
			local dropGradient = Instance.new("UIGradient")
			dropGradient.Rotation = 90
			dropGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.88),
				NumberSequenceKeypoint.new(0.55, 0.78),
				NumberSequenceKeypoint.new(1, 0.5),
			})
			dropGradient.Parent = drop
			local dropRim = Instance.new("UIStroke")
			dropRim.Color = white
			dropRim.Thickness = 1
			dropRim.Transparency = 1
			dropRim.Parent = drop
			local shine = newCircle(drop, 3, white, 0.1)
			shine.Size = UDim2.fromScale(0.3, 0.3)
			shine.Position = UDim2.fromScale(0.2, 0.16)

			dropCount = dropCount + 1
			TweenService:Create(drop, TweenInfo.new(0.5), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(dropRim, TweenInfo.new(0.5), { Transparency = 0.55 }):Play()

			local life
			if slides then
				task.wait(rng:NextNumber(1, 3.5))
				if not container.Parent then
					return
				end
				local dist = math.min(rng:NextInteger(40, 120), math.floor(height * (1 - y)) - size)
				dist = math.max(dist, 20)
				local travel = rng:NextNumber(0.9, 1.6)
				TweenService:Create(
					drop,
					TweenInfo.new(travel, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					{ Position = UDim2.new(x, 0, y, dist) }
				):Play()
				TweenService:Create(
					trail,
					TweenInfo.new(travel, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					{ Size = UDim2.fromOffset(2, dist) }
				):Play()
				life = travel
			else
				life = rng:NextNumber(6, 12)
			end

			task.wait(life)
			if not container.Parent then
				return
			end
			TweenService:Create(drop, TweenInfo.new(0.6), { BackgroundTransparency = 1 }):Play()
			TweenService:Create(dropRim, TweenInfo.new(0.6), { Transparency = 1 }):Play()
			TweenService:Create(shine, TweenInfo.new(0.6), { BackgroundTransparency = 1 }):Play()
			if trail then
				TweenService:Create(trail, TweenInfo.new(0.6), { BackgroundTransparency = 1 }):Play()
			end
			task.wait(0.65)
			dropCount = math.max(0, dropCount - 1)
			drop:Destroy()
			if trail then
				trail:Destroy()
			end
		end

		task.spawn(function()
			while fxAlive and container.Parent do
				if dropCount < 18 then
					task.spawn(function()
						pcall(spawnDroplet)
					end)
				end
				task.wait(rng:NextNumber(0.5, 1.2))
			end
		end)

		connectRipples(main, container, Color3.fromRGB(200, 222, 242))
	end

	local fxBuilders = {
		Aqua = startAquaFx,
		Retro = startRetroFx,
		Wii = startWiiFx,
		Relax = startRelaxFx,
		Cafeteria = startCafeFx,
		Realistic = startRealisticFx,
	}

	local function applyThemeNow(name)
		local target = themes[name]
		if not target or name == currentName then
			return
		end
		local from = themes[currentName]
		local map = buildMap(from, target)
		local panelKeys = panelKeySet(from)

		for _, key in ipairs(libraryKeys) do
			Library.Theme[key] = target.colors[key]
		end
		Library.Settings.Transparency = target.transparency

		for _, root in ipairs(getRoots()) do
			hookRoot(root)
			applyTree(root, map, from, target, panelKeys)
		end
		for _, card in ipairs(getCards()) do
			applyTree(card, map, from, target, panelKeys)
		end

		currentName = name
		stopFx()
		local builder = fxBuilders[name]
		if builder then
			builder()
		end
	end

	local switching = false
	local pendingName = nil

	local function setTheme(name)
		if switching then
			pendingName = name
			return
		end
		switching = true
		pcall(applyThemeNow, name)
		switching = false
		if pendingName then
			local nextName = pendingName
			pendingName = nil
			setTheme(nextName)
		end
	end

	Library._onNewGui = function(gui)
		if currentName == "Medieval" then
			return
		end
		task.defer(applyNewTree, gui)
		task.delay(0.4, applyNewTree, gui)
	end

	for _, root in ipairs(getRoots()) do
		hookRoot(root)
	end

	local function watchContainer(container)
		container.ChildAdded:Connect(function(child)
			task.defer(function()
				if isThemeRoot(child) then
					hookRoot(child)
					if currentName ~= "Medieval" then
						task.wait(0.1)
						applyNewTree(child)
						task.delay(0.5, applyNewTree, child)
					end
				end
			end)
		end)
	end

	watchContainer(CoreGui)
	local playerGui = lp:FindFirstChildOfClass("PlayerGui")
	if playerGui then
		watchContainer(playerGui)
	end

	Themes67:AddButton({
		Name = "Medieval[Default]",
		Info = "Dark charcoal panels with dark metal borders and copper accents",
		Callback = function()
			setTheme("Medieval")
		end,
	})

	Themes67:AddButton({
		Name = "Aqua",
		Info = "Underwater look with bubbles, waves, light rays and glassy blue panels",
		Callback = function()
			setTheme("Aqua")
		end,
	})

	Themes67:AddButton({
		Name = "Retro",
		Info = "Neon purple and magenta with VHS scanlines, tracking bar, glitches and tape overlay",
		Callback = function()
			setTheme("Retro")
		end,
	})

	Themes67:AddButton({
		Name = "Wii",
		Info = "Clean white and sky blue glossy panels with soft rounded corners and floating light orbs",
		Callback = function()
			setTheme("Wii")
		end,
	})

	Themes67:AddButton({
		Name = "Dark Relax",
		Info = "Calm deep blue night mode with a slow aurora, twinkling stars, a soft moon and shooting stars",
		Callback = function()
			setTheme("Relax")
		end,
	})

	Themes67:AddButton({
		Name = "Cafeteria",
		Info = "Warm espresso and cream colors with a soft lamp glow and rising steam",
		Callback = function()
			setTheme("Cafeteria")
		end,
	})

	Themes67:AddButton({
		Name = "Realistic",
		Info = "Frosted graphite glass with rain droplets, bokeh lights, a light beam with dust and soft shadows",
		Callback = function()
			setTheme("Realistic")
		end,
	})
end)

return Library
