local Library = {}

local NeverloseVersion = "v1.1A."

local TweenService = game:GetService("TweenService")
local input = game:GetService("UserInputService")

for i,v in next, game.CoreGui:GetChildren() do
    if v:IsA("ScreenGui") and v.Name == "Neverlose" then
        v:Destroy() 
    end
end

local Theme = {
    Background = Color3.fromRGB(11, 11, 15),
    SideBar = Color3.fromRGB(14, 15, 20),
    Section = Color3.fromRGB(18, 19, 25),
    Accent = Color3.fromRGB(38, 151, 255),
    Border = Color3.fromRGB(35, 38, 48),
    Text = Color3.fromRGB(160, 175, 190),
    TextHigh = Color3.fromRGB(255, 255, 255)
}

local themouse = game.Players.LocalPlayer:GetMouse()

local function Notify(tt, tx)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = tt,
        Text = tx,
        Duration = 5
    })
end

local function Dragify(frame, parent)

    parent = parent or frame

    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local function round(num, bracket)
    bracket = bracket or 1
    local a = math.floor(num/bracket + (math.sign(num) * 0.5)) * bracket
    if a < 0 then
        a = a + bracket
    end
    return a
end

local function buttoneffect(options)
    pcall(function()
        options.entered.MouseEnter:Connect(function()
            TweenService:Create(options.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                TextColor3 = Theme.TextHigh
            }):Play()
        end)
        options.entered.MouseLeave:Connect(function()
            TweenService:Create(options.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                TextColor3 = Theme.Text
            }):Play()
        end)
    end)
end

local function clickEffect(options)
    options.button.MouseButton1Click:Connect(function()
        local new = options.button.TextSize - tonumber(options.amount)
        local revert = new + tonumber(options.amount)
        TweenService:Create(options.button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextSize = new}):Play()
        wait(0.1)
        TweenService:Create(options.button, TweenInfo.new(0.1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextSize = revert}):Play()
    end)
end

function Library:Toggle(value)
    if game:GetService("CoreGui"):FindFirstChild("Neverlose") == nil then return end
    local NeverloseGui = game:GetService("CoreGui"):FindFirstChild("Neverlose")
    local enabled = (type(value) == "boolean" and value) or NeverloseGui.Enabled
    NeverloseGui.Enabled = not enabled
end

function Library:Window(options)
    options.text = options.text or "NEVERLOSE"

    local SG = Instance.new("ScreenGui")
    local Body = Instance.new("Frame")
    Dragify(Body, Body)
    local bodyCorner = Instance.new("UICorner")

    local SideBar = Instance.new("Frame")
    local sidebarCorner = Instance.new("UICorner")
    local sbLine = Instance.new("Frame")

    local TopBar = Instance.new("Frame")
    local tbLine = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    --local saveBtn = Instance.new("TextButton")
    --local saveLabel = Instance.new("ImageLabel")

    local allPages = Instance.new("Frame")
    local tabContainer = Instance.new("Frame")

    SG.Parent = game.CoreGui
    SG.Name = "Neverlose"

    Body.Name = "Body"
    Body.Parent = SG
    Body.AnchorPoint = Vector2.new(0.5, 0.5)
    Body.BackgroundColor3 = Theme.Background
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0.5, 0, 0.5, 0)
    Body.Size = UDim2.new(0, 650, 0, 500)

    bodyCorner.CornerRadius = UDim.new(0, 8)
    bodyCorner.Name = "bodyCorner"
    bodyCorner.Parent = Body

    local bodyStroke = Instance.new("UIStroke")
    bodyStroke.Color = Theme.Border
    bodyStroke.Thickness = 1.5
    bodyStroke.Parent = Body

    SideBar.Name = "SideBar"
    SideBar.Parent = Body
    SideBar.BackgroundColor3 = Theme.SideBar
    SideBar.BorderSizePixel = 0
    SideBar.Size = UDim2.new(0, 180, 1, 0)

    sidebarCorner.CornerRadius = UDim.new(0, 8)
    sidebarCorner.Name = "sidebarCorner"
    sidebarCorner.Parent = SideBar
    
    local sbClip = Instance.new("Frame")
    sbClip.Name = "sbClip"
    sbClip.Parent = SideBar
    sbClip.BackgroundColor3 = Theme.SideBar
    sbClip.BorderSizePixel = 0
    sbClip.Position = UDim2.new(1, -10, 0, 0)
    sbClip.Size = UDim2.new(0, 10, 1, 0)

    sbLine.Name = "sbLine"
    sbLine.Parent = SideBar
    sbLine.BackgroundColor3 = Theme.Border
    sbLine.BorderSizePixel = 0
    sbLine.Position = UDim2.new(1, 0, 0, 0)
    sbLine.Size = UDim2.new(0, 1, 1, 0)

    TopBar.Name = "TopBar"
    TopBar.Parent = Body
    TopBar.BackgroundColor3 = Theme.Background
    TopBar.BackgroundTransparency = 1.000
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0, 180, 0, 0)
    TopBar.Size = UDim2.new(1, -180, 0, 50)

    tbLine.Name = "tbLine"
    tbLine.Parent = TopBar
    tbLine.BackgroundColor3 = Theme.Border
    tbLine.BorderSizePixel = 0
    tbLine.Position = UDim2.new(0, 0, 1, -1)
    tbLine.Size = UDim2.new(1, 0, 0, 1)

    Title.Name = "Title"
    Title.Parent = SideBar
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 0, 0, 15)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = options.text
    Title.TextColor3 = Theme.Accent
    Title.TextSize = 22.000
    Title.TextXAlignment = Enum.TextXAlignment.Center

    --[[saveBtn.Name = "saveBtn"
    saveBtn.Parent = TopBar
    saveBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    saveBtn.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
    saveBtn.Position = UDim2.new(0.146918148, 0, 0.479591846, 0)
    saveBtn.Size = UDim2.new(0, 88, 0, 20)
    saveBtn.AutoButtonColor = false
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.Text = "   Save"
    saveBtn.TextColor3 = Color3.fromRGB(132, 146, 153)
    saveBtn.TextSize = 14.000

    saveLabel.Name = "saveLabel"
    saveLabel.Parent = saveBtn
    saveLabel.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
    saveLabel.BackgroundTransparency = 1.000
    saveLabel.BorderSizePixel = 0
    saveLabel.Position = UDim2.new(0.0862553269, 0, 0.0500000007, 0)
    saveLabel.Size = UDim2.new(0, 18, 0, 18)
    saveLabel.Image = "rbxassetid://7999984136"
    saveLabel.ImageColor3 = Color3.fromRGB(132, 146, 153)
    ]]

    allPages.Name = "allPages"
    allPages.Parent = Body
    allPages.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
    allPages.BackgroundTransparency = 1.000
    allPages.BorderSizePixel = 0
    allPages.Position = UDim2.new(0, 180, 0, 50)
    allPages.Size = UDim2.new(1, -180, 1, -50)

    tabContainer.Name = "tabContainer"
    tabContainer.Parent = SideBar
    tabContainer.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
    tabContainer.BackgroundTransparency = 1.000
    tabContainer.BorderSizePixel = 0
    tabContainer.Position = UDim2.new(0, 0, 0, 80)
    tabContainer.Size = UDim2.new(1, 0, 1, -80)

    local tabsections = {}

    function tabsections:TabSection(options)
        options.text = options.text or "Tab Section"

        local tabLayout = Instance.new("UIListLayout")
        local tabSection = Instance.new("Frame")
        local tabSectionLabel = Instance.new("TextLabel")
        local tabSectionLayout = Instance.new("UIListLayout")

        tabLayout.Name = "tabLayout"
        tabLayout.Parent = tabContainer

        tabSection.Name = "tabSection"
        tabSection.Parent = tabContainer
        tabSection.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
        tabSection.BackgroundTransparency = 1.000
        tabSection.BorderSizePixel = 0
        tabSection.Size = UDim2.new(1, 0, 0, 22)

        local function ResizeTS(num)
            tabSection.Size += UDim2.new(0, 0, 0, num)
        end

        tabSectionLabel.Name = "tabSectionLabel"
        tabSectionLabel.Parent = tabSection
        tabSectionLabel.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
        tabSectionLabel.BackgroundTransparency = 1.000
        tabSectionLabel.BorderSizePixel = 0
        tabSectionLabel.Size = UDim2.new(1, 0, 0, 22)
        tabSectionLabel.Font = Enum.Font.GothamBold
        tabSectionLabel.Text = options.text:upper()
        tabSectionLabel.TextColor3 = Theme.Text
        tabSectionLabel.TextSize = 13.000
        tabSectionLabel.TextXAlignment = Enum.TextXAlignment.Center

        tabSectionLayout.Name = "tabSectionLayout"
        tabSectionLayout.Parent = tabSection
        tabSectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabSectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabSectionLayout.Padding = UDim.new(0, 4)

        local tabs = {}

        function tabs:Tab(options)
            options.text = options.text or "New Tab"
            options.icon = options.icon or "rbxassetid://7999345313"

            local tabButton = Instance.new("TextButton")
            local tabButtonCorner = Instance.new("UICorner")
            local tabIcon = Instance.new("ImageLabel")

            local newPage = Instance.new("ScrollingFrame")
            local pageLayout = Instance.new("UIGridLayout")

            tabButton.Name = "tabButton"
            tabButton.Parent = tabSection
            tabButton.BackgroundColor3 = Theme.Accent
            tabButton.BorderSizePixel = 0
            tabButton.Size = UDim2.new(0, 160, 0, 32)
            tabButton.AutoButtonColor = false
            tabButton.Font = Enum.Font.GothamSemibold
            tabButton.Text = "          " .. options.text
            tabButton.TextColor3 = Theme.Text
            tabButton.TextSize = 13.000
            tabButton.BackgroundTransparency = 1
            tabButton.TextXAlignment = Enum.TextXAlignment.Left
            
            local tabIndicator = Instance.new("Frame")
            tabIndicator.Name = "tabIndicator"
            tabIndicator.Parent = tabButton
            tabIndicator.BackgroundColor3 = Theme.Accent
            tabIndicator.BorderSizePixel = 0
            tabIndicator.Position = UDim2.new(0, 5, 0.5, -8)
            tabIndicator.Size = UDim2.new(0, 2, 0, 16)
            tabIndicator.BackgroundTransparency = 1

            tabButton.MouseButton1Click:Connect(function()
                for i,v in next, allPages:GetChildren() do
                    v.Visible = false
                end

                newPage.Visible = true

                for i,v in next, tabSection.Parent:GetDescendants() do
                    if v.Name == "tabButton" then
                        TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1,
                            TextColor3 = Theme.Text
                        }):Play()
                        TweenService:Create(v.tabIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play()
                    end
                end

                TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.9,
                    TextColor3 = Theme.TextHigh
                }):Play()
                TweenService:Create(tabIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0
                }):Play()
            end)

            tabButtonCorner.CornerRadius = UDim.new(0, 6)
            tabButtonCorner.Name = "tabButtonCorner"
            tabButtonCorner.Parent = tabButton

            tabIcon.Name = "tabIcon"
            tabIcon.Parent = tabButton
            tabIcon.BackgroundTransparency = 1.000
            tabIcon.BorderSizePixel = 0
            tabIcon.Position = UDim2.new(0, 10, 0.5, -9)
            tabIcon.Size = UDim2.new(0, 18, 0, 18)
            tabIcon.Image = options.icon
            tabIcon.ImageColor3 = Theme.Accent

            newPage.Name = "newPage"
            newPage.Parent = allPages
            newPage.Visible = false
            newPage.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
            newPage.BackgroundTransparency = 1.000
            newPage.BorderSizePixel = 0
            newPage.ClipsDescendants = false
            newPage.Position = UDim2.new(0, 10, 0, 10)
            newPage.Size = UDim2.new(1, -20, 1, -20)
            newPage.ScrollBarThickness = 4
            newPage.CanvasSize = UDim2.new(0,0,0,0)

            pageLayout.Name = "pageLayout"
            pageLayout.Parent = newPage
            pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
            pageLayout.CellPadding = UDim2.new(0, 12, 0, 12)
            pageLayout.CellSize = UDim2.new(0, 215, 0, -10)
            pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                newPage.CanvasSize = UDim2.new(0,0,0,pageLayout.AbsoluteContentSize.Y) 
            end)

            ResizeTS(50)

            local sections = {}

            function sections:Section(options)
                options.text = options.text or "Section"

                local sectionFrame = Instance.new("Frame")
                local sectionLabel = Instance.new("TextLabel")
                local sectionFrameCorner = Instance.new("UICorner")
                local sectionLayout = Instance.new("UIListLayout")
                local sLine = Instance.new("TextLabel")
                local sectionSizeConstraint = Instance.new("UISizeConstraint")

                sectionFrame.Name = "sectionFrame"
                sectionFrame.Parent = newPage
                sectionFrame.BackgroundColor3 = Theme.Section
                sectionFrame.BorderSizePixel = 0
                sectionFrame.ClipsDescendants = false
                sectionFrame.Size = UDim2.new(0, 210, 0, 134)

                sectionFrameCorner.CornerRadius = UDim.new(0, 8)
                sectionFrameCorner.Name = "sectionFrameCorner"
                sectionFrameCorner.Parent = sectionFrame
                
                local sectionStroke = Instance.new("UIStroke")
                sectionStroke.Color = Theme.Border
                sectionStroke.Thickness = 1
                sectionStroke.Parent = sectionFrame

                sectionLabel.Name = "sectionLabel"
                sectionLabel.Parent = sectionFrame
                sectionLabel.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
                sectionLabel.BackgroundTransparency = 1.000
                sectionLabel.BorderSizePixel = 0
                sectionLabel.Position = UDim2.new(0.0121902823, 0, 0, 0)
                sectionLabel.Size = UDim2.new(0, 213, 0, 25)
                sectionLabel.Font = Enum.Font.GothamSemibold
                sectionLabel.Text = "   " .. options.text
                sectionLabel.TextColor3 = Color3.fromRGB(234, 239, 245)
                sectionLabel.TextSize = 14.000
                sectionLabel.TextXAlignment = Enum.TextXAlignment.Left

                sectionFrameCorner.CornerRadius = UDim.new(0, 4)
                sectionFrameCorner.Name = "sectionFrameCorner"
                sectionFrameCorner.Parent = sectionFrame

                sectionLayout.Name = "sectionLayout"
                sectionLayout.Parent = sectionFrame
                sectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                sectionLayout.Padding = UDim.new(0, 2)

                sLine.Name = "sLine"
                sLine.Parent = sectionFrame
                sLine.BackgroundColor3 = Theme.Border
                sLine.BorderSizePixel = 0
                sLine.Position = UDim2.new(0, 0, 0, 25)
                sLine.Size = UDim2.new(1, 0, 0, 1)
                sLine.Font = Enum.Font.SourceSans
                sLine.Text = ""
                sLine.TextColor3 = Color3.fromRGB(0, 0, 0)
                sLine.TextSize = 0

                sectionSizeConstraint.Name = "sectionSizeConstraint"
                sectionSizeConstraint.Parent = sectionFrame
                sectionSizeConstraint.MinSize = Vector2.new(215, 35)

                local function Resize(num)
                    sectionSizeConstraint.MinSize += Vector2.new(0, num)
                end

                local elements = {}

                function elements:Button(options)
                    if not options.text or not options.callback then Notify("Button", "Missing arguments!") return end

                    local TextButton = Instance.new("TextButton")

                    TextButton.Parent = sectionFrame
                    TextButton.BackgroundColor3 = Color3.fromRGB(13, 57, 84)
                    TextButton.BorderSizePixel = 0
                    TextButton.Position = UDim2.new(0.0348837227, 0, 0.355555564, 0)
                    TextButton.Size = UDim2.new(0, 200, 0, 22)
                    TextButton.AutoButtonColor = false
                    TextButton.Text = options.text
                    TextButton.Font = Enum.Font.Gotham
                    TextButton.TextColor3 = Color3.fromRGB(157, 171, 182)
                    TextButton.TextSize = 14.000
                    TextButton.BackgroundTransparency = 1
                    buttoneffect({frame = TextButton, entered = TextButton})
                    clickEffect({button = TextButton, amount = 5})
                    TextButton.MouseButton1Click:Connect(function()
                        options.callback()
                    end)

                    Resize(25)
                end

                function elements:Toggle(options)
                    if not options.text or not options.callback then Notify("Toggle", "Missing arguments!") return end

                    local toggleLabel = Instance.new("TextLabel")
                    local toggleFrame = Instance.new("TextButton")
                    local togFrameCorner = Instance.new("UICorner")
                    local toggleButton = Instance.new("TextButton")
                    local togBtnCorner = Instance.new("UICorner")

                    local State = options.state or false

                    if options.state then
                        toggleButton.Position = UDim2.new(0.74, 0, 0.5, 0)
                        toggleLabel.TextColor3 = Color3.fromRGB(234, 239, 246)
                        toggleButton.BackgroundColor3 = Color3.fromRGB(2, 162, 243)
                        toggleFrame.BackgroundColor3 = Color3.fromRGB(2, 23, 49)
                    end

                    toggleLabel.Name = "toggleLabel"
                    toggleLabel.Parent = sectionFrame
                    toggleLabel.BackgroundColor3 = Color3.fromRGB(157, 171, 182)
                    toggleLabel.BackgroundTransparency = 1.000
                    toggleLabel.Position = UDim2.new(0.0348837227, 0, 0.965517223, 0)
                    toggleLabel.Size = UDim2.new(0, 200, 0, 22)
                    toggleLabel.Font = Enum.Font.Gotham
                    toggleLabel.Text = " " .. options.text
                    toggleLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    toggleLabel.TextSize = 14.000
                    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    buttoneffect({frame = toggleLabel, entered = toggleLabel})

                    local function PerformToggle()
                        State = not State
                        options.callback(State)
                        TweenService:Create(toggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Position = State and UDim2.new(0.7, 0, 0.5, 0) or UDim2.new(0.3, 0, 0.5, 0),
                            BackgroundColor3 = State and Color3.new(1,1,1) or Color3.fromRGB(150, 150, 150)
                        }):Play()
                        TweenService:Create(toggleLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            TextColor3 = State and Theme.TextHigh or Theme.Text
                        }):Play()
                        TweenService:Create(toggleFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            BackgroundColor3 = State and Theme.Accent or Color3.fromRGB(30, 30, 35)
                        }):Play()
                    end

                    toggleFrame.Name = "toggleFrame"
                    toggleFrame.Parent = toggleLabel
                    toggleFrame.BackgroundColor3 = Color3.fromRGB(4, 4, 11)
                    toggleFrame.BorderSizePixel = 0
                    toggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    toggleFrame.Position = UDim2.new(0.9, 0, 0.5, 0)
                    toggleFrame.Size = UDim2.new(0, 38, 0, 18)
                    toggleFrame.AutoButtonColor = false
                    toggleFrame.Font = Enum.Font.SourceSans
                    toggleFrame.Text = ""
                    toggleFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggleFrame.TextSize = 14.000
                    toggleFrame.MouseButton1Click:Connect(function()
                        PerformToggle()
                    end)

                    togFrameCorner.CornerRadius = UDim.new(0, 50)
                    togFrameCorner.Name = "togFrameCorner"
                    togFrameCorner.Parent = toggleFrame

                    toggleButton.Name = "toggleButton"
                    toggleButton.Parent = toggleFrame
                    toggleButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                    toggleButton.BorderSizePixel = 0
                    toggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
                    toggleButton.Position = UDim2.new(0.25, 0, 0.5, 0)
                    toggleButton.Size = UDim2.new(0, 16, 0, 16)
                    toggleButton.AutoButtonColor = false
                    toggleButton.Font = Enum.Font.SourceSans
                    toggleButton.Text = ""
                    toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggleButton.TextSize = 14.000
                    toggleButton.MouseButton1Click:Connect(function()
                        PerformToggle()
                    end)

                    togBtnCorner.CornerRadius = UDim.new(0, 50)
                    togBtnCorner.Name = "togFrameCorner"
                    togBtnCorner.Parent = toggleButton

                    Resize(25)
                end

                function elements:Slider(options)
                    if not options.text or not options.min or not options.max or not options.callback then Notify("Slider", "Missing arguments!") return end

                    local Slider = Instance.new("Frame")
                    local sliderLabel = Instance.new("TextLabel")
                    local sliderFrame = Instance.new("TextButton")
                    local sliderBall = Instance.new("TextButton")
                    local sliderBallCorner = Instance.new("UICorner")
                    local sliderTextBox = Instance.new("TextBox")
                    buttoneffect({frame = sliderLabel, entered = Slider})

                    local Value
                    local Held = false

                    local UIS = game:GetService("UserInputService")
                    local RS = game:GetService("RunService")
                    local Mouse = game.Players.LocalPlayer:GetMouse()

                    local percentage = 0
                    local step = 0.01

                    local function snap(number, factor)
                        if factor == 0 then
                            return number
                        else
                            return math.floor(number/factor+0.5)*factor
                        end
                    end

                    UIS.InputEnded:Connect(function(Mouse)
                        Held = false
                    end)

                    Slider.Name = "Slider"
                    Slider.Parent = sectionFrame
                    Slider.BackgroundColor3 = Color3.fromRGB(157, 171, 182)
                    Slider.BackgroundTransparency = 1.000
                    Slider.Position = UDim2.new(0.0395348854, 0, 0.947335422, 0)
                    Slider.Size = UDim2.new(0, 200, 0, 22)

                    sliderLabel.Name = "sliderLabel"
                    sliderLabel.Parent = Slider
                    sliderLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    sliderLabel.BackgroundColor3 = Color3.fromRGB(157, 171, 182)
                    sliderLabel.BackgroundTransparency = 1.000
                    sliderLabel.Position = UDim2.new(0.2, 0, 0.5, 0)
                    sliderLabel.Size = UDim2.new(0, 77, 0, 22)
                    sliderLabel.Font = Enum.Font.Gotham
                    sliderLabel.Text = " " .. options.text
                    sliderLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    sliderLabel.TextSize = 14.000
                    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    sliderLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
                        if sliderLabel.TextBounds.X > 75 then
                            sliderLabel.TextScaled = true
                        else
                            sliderLabel.TextScaled = false
                        end
                    end)

                    sliderFrame.Name = "sliderFrame"
                    sliderFrame.Parent = sliderLabel
                    sliderFrame.BackgroundColor3 = Theme.SideBar
                    sliderFrame.BorderSizePixel = 0
                    sliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    sliderFrame.Position = UDim2.new(1.6, 0, 0.5, 0)
                    sliderFrame.Size = UDim2.new(0, 72, 0, 4)
                    sliderFrame.Text = ""
                    sliderFrame.AutoButtonColor = false
                    
                    local sfCorner = Instance.new("UICorner")
                    sfCorner.CornerRadius = UDim.new(0, 8)
                    sfCorner.Parent = sliderFrame

                    sliderBall.Name = "sliderBall"
                    sliderBall.Parent = sliderFrame
                    sliderBall.AnchorPoint = Vector2.new(0.5, 0.5)
                    sliderBall.BackgroundColor3 = Theme.Accent
                    sliderBall.BorderSizePixel = 0
                    sliderBall.Position = UDim2.new(0, 0, 0.5, 0)
                    sliderBall.Size = UDim2.new(0, 14, 0, 14)
                    sliderBall.AutoButtonColor = false
                    sliderBall.Font = Enum.Font.SourceSans
                    sliderBall.Text = ""
                    sliderBall.TextColor3 = Color3.fromRGB(0, 0, 0)
                    sliderBall.TextSize = 14.000
                    
                    local sbStroke = Instance.new("UIStroke")
                    sbStroke.Color = Theme.Border
                    sbStroke.Thickness = 1
                    sbStroke.Parent = sliderBall

                    sliderBall.MouseButton1Down:Connect(function()
                        Held = true
                    end)

                    sliderFrame.MouseButton1Down:Connect(function()
                        Held = true
                    end)

                    RS.RenderStepped:Connect(function()
                        if Held then
                            local BtnPos = sliderBall.Position
                            local MousePos = UIS:GetMouseLocation().X
                            local FrameSize = sliderFrame.AbsoluteSize.X
                            local FramePos = sliderFrame.AbsolutePosition.X
                            local pos = snap((MousePos-FramePos)/FrameSize,step)
                            percentage = math.clamp(pos,0,0.9)

                            Value = ((((tonumber(options.max) - tonumber(options.min)) / 0.9) * percentage)) + tonumber(options.min)
                            Value = round(Value, options.float)
                            Value = math.clamp(Value, options.min, options.max)
                            sliderTextBox.Text = Value
                            options.callback(Value)
                            sliderBall.Position = UDim2.new(percentage,0,BtnPos.Y.Scale, BtnPos.Y.Offset)
                        end
                    end)

                    sliderBallCorner.CornerRadius = UDim.new(0, 50)
                    sliderBallCorner.Name = "sliderBallCorner"
                    sliderBallCorner.Parent = sliderBall

                    sliderTextBox.Name = "sliderTextBox"
                    sliderTextBox.Parent = sliderLabel
                    sliderTextBox.BackgroundColor3 = Color3.fromRGB(1, 7, 17)
                    sliderTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                    sliderTextBox.Position = UDim2.new(2.4, 0, 0.5, 0)
                    sliderTextBox.Size = UDim2.new(0, 31, 0, 15)
                    sliderTextBox.Font = Enum.Font.Gotham
                    sliderTextBox.Text = options.min
                    sliderTextBox.TextColor3 = Color3.fromRGB(234, 239, 245)
                    sliderTextBox.TextSize = 11.000
                    sliderTextBox.TextWrapped = true

                    sliderTextBox.Focused:Connect(function()
                        TweenService:Create(sliderLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(234, 239, 246)}):Play()
                    end)

                    sliderTextBox.FocusLost:Connect(function(Enter)
                        TweenService:Create(sliderLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(157, 171, 182)}):Play()
                        if Enter then
                            if sliderTextBox.Text ~= nil and sliderTextBox.Text ~= "" then
                                if tonumber(sliderTextBox.Text) > options.max then
                                    sliderTextBox.Text = tostring(options.max)
                                    options.callback(options.max)
                                elseif tonumber(sliderTextBox.Text) < options.min then
                                    sliderTextBox.Text = tostring(options.min)
                                    options.callback(options.min)
                                elseif not tonumber(sliderTextBox.Text) < options.min and not tonumber(sliderTextBox.Text) > options.max then
                                    options.callback(sliderTextBox.Text)
                                end
                            end
                        end
                    end)

                    Resize(25)
                end

                function elements:Dropdown(options)
                    if not options.text or not options.default or not options.list or not options.callback then Notify("Dropdown", "Missing arguments!") return end

                    local DropYSize = 0
                    local Dropped = false

                    local Dropdown = Instance.new("Frame")
                    local dropdownLabel = Instance.new("TextLabel")
                    local dropdownText = Instance.new("TextLabel")
                    local dropdownArrow = Instance.new("ImageButton")
                    local dropdownList = Instance.new("ScrollingFrame")

                    local dropListLayout = Instance.new("UIListLayout")
                    buttoneffect({frame = dropdownLabel, entered = Dropdown})

                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = sectionFrame
                    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dropdown.BackgroundTransparency = 1.000
                    Dropdown.BorderSizePixel = 0
                    Dropdown.Position = UDim2.new(0.0697674453, 0, 0.237037033, 0)
                    Dropdown.Size = UDim2.new(0, 200, 0, 22)
                    Dropdown.ZIndex = 2

                    dropdownLabel.Name = "dropdownLabel"
                    dropdownLabel.Parent = Dropdown
                    dropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownLabel.BackgroundTransparency = 1.000
                    dropdownLabel.BorderSizePixel = 0
                    dropdownLabel.Size = UDim2.new(0, 105, 0, 22)
                    dropdownLabel.Font = Enum.Font.Gotham
                    dropdownLabel.Text = " " .. options.text
                    dropdownLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    dropdownLabel.TextSize = 14.000
                    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    dropdownLabel.TextWrapped = true

                    dropdownText.Name = "dropdownText"
                    dropdownText.Parent = dropdownLabel
                    dropdownText.BackgroundColor3 = Theme.SideBar
                    dropdownText.Position = UDim2.new(1.08571434, 0, 0.0909090936, 0)
                    dropdownText.Size = UDim2.new(0, 87, 0, 18)
                    dropdownText.Font = Enum.Font.Gotham
                    dropdownText.Text = " " .. options.default
                    dropdownText.TextColor3 = Theme.TextHigh
                    dropdownText.TextSize = 12.000
                    dropdownText.TextXAlignment = Enum.TextXAlignment.Left
                    dropdownText.TextWrapped = true
                    
                    local dtUIC = Instance.new("UICorner")
                    dtUIC.CornerRadius = UDim.new(0, 4)
                    dtUIC.Parent = dropdownText
                    
                    local dtStroke = Instance.new("UIStroke")
                    dtStroke.Color = Theme.Border
                    dtStroke.Parent = dropdownText

                    dropdownArrow.Name = "dropdownArrow"
                    dropdownArrow.Parent = dropdownText
                    dropdownArrow.BackgroundColor3 = Color3.fromRGB(2, 5, 12)
                    dropdownArrow.BorderSizePixel = 0
                    dropdownArrow.Position = UDim2.new(0.87356323, 0, 0.138888866, 0)
                    dropdownArrow.Size = UDim2.new(0, 11, 0, 13)
                    dropdownArrow.AutoButtonColor = false
                    dropdownArrow.Image = "rbxassetid://8008296380"
                    dropdownArrow.ImageColor3 = Color3.fromRGB(157, 171, 182)

                    dropdownArrow.MouseButton1Click:Connect(function()
                        Dropped = not Dropped
                        if Dropped then
                            Dropdown.ZIndex = 5
                            if dropdownLabel.TextColor3 ~= Color3.fromRGB(234, 239, 245) then
                                TweenService:Create(dropdownLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    TextColor3 = Color3.fromRGB(234, 239, 246)
                                }):Play()
                            end
                            local MaxHeight = (Body.AbsolutePosition.Y + Body.AbsoluteSize.Y) - dropdownList.AbsolutePosition.Y - 5
                            local TargetHeight = math.min(DropYSize, MaxHeight)
                            
                            TweenService:Create(dropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Size = UDim2.new(0, 87, 0, TargetHeight)
                            }):Play()
                            TweenService:Create(dropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                BorderSizePixel = 1
                            }):Play()
                        elseif not Dropped then
                            Dropdown.ZIndex = 2
                            if dropdownLabel.TextColor3 ~= Color3.fromRGB(157, 171, 182) then
                                TweenService:Create(dropdownLabel, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    TextColor3 = Color3.fromRGB(157, 171, 182)
                                }):Play()
                            end
                            TweenService:Create(dropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Size = UDim2.new(0, 87, 0, 0)
                            }):Play()
                            TweenService:Create(dropdownList, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                BorderSizePixel = 0
                            }):Play()
                        end
                    end)

                    dropdownList.Name = "dropdownList"
                    dropdownList.Parent = dropdownText
                    dropdownList.BackgroundColor3 = Theme.SideBar
                    dropdownList.Position = UDim2.new(0, 0, 1, 5)
                    dropdownList.Size = UDim2.new(0, 87, 0, 0)
                    dropdownList.ClipsDescendants = true
                    dropdownList.BorderSizePixel = 0
                    dropdownList.ZIndex = 100
                    dropdownList.Active = true
                    dropdownList.ScrollBarThickness = 4
                    dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
                    dropdownList.ScrollBarImageColor3 = Theme.Accent
                    
                    local dlStroke = Instance.new("UIStroke")
                    dlStroke.Color = Theme.Border
                    dlStroke.Parent = dropdownList
                    
                    local dlCorner = Instance.new("UICorner")
                    dlCorner.CornerRadius = UDim.new(0, 4)
                    dlCorner.Parent = dropdownList

                    dropListLayout.Name = "dropListLayout"
                    dropListLayout.Parent = dropdownList
                    dropListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    dropListLayout.Padding = UDim.new(0, 2)
                    Resize(25)

                    for i,v in next, options.list do
                        local dropdownBtn = Instance.new("TextButton")

                        dropdownBtn.Name = "dropdownBtn"
                        dropdownBtn.Parent = dropdownList
                        dropdownBtn.BackgroundColor3 = Color3.fromRGB(234, 239, 245)
                        dropdownBtn.BackgroundTransparency = 1.000
                        dropdownBtn.BorderSizePixel = 0
                        dropdownBtn.Size = UDim2.new(0, 87, 0, 18)
                        dropdownBtn.AutoButtonColor = false
                        dropdownBtn.Font = Enum.Font.Gotham
                        dropdownBtn.TextColor3 = Color3.fromRGB(234, 239, 245)
                        dropdownBtn.TextSize = 12.000
                        dropdownBtn.Text = "  " .. v
                        dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
                        dropdownBtn.ZIndex = 105
                        dropdownBtn.TextWrapped = false
                        dropdownBtn.ClipsDescendants = true
                        buttoneffect({frame = dropdownBtn, entered = dropdownBtn})
                        clickEffect({button = dropdownBtn, amount = 5})

                        DropYSize = DropYSize + 20

                        dropdownBtn.MouseButton1Click:Connect(function()
                            dropdownText.Text = " " .. v
                            options.callback(v)
                        end)
                    end
                    dropdownList.CanvasSize = UDim2.new(0, 0, 0, DropYSize)
                end

                function elements:Textbox(options)
                    if not options.text or not options.value or not options.callback then Notify("Textbox", "Missing arguments!") return end

                    local Textbox = Instance.new("Frame")
                    local textBoxLabel = Instance.new("TextLabel")
                    local textBox = Instance.new("TextBox")

                    Textbox.Name = "Textbox"
                    Textbox.Parent = sectionFrame
                    Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Textbox.BackgroundTransparency = 1.000
                    Textbox.BorderSizePixel = 0
                    Textbox.Position = UDim2.new(0.0348837227, 0, 0.945454538, 0)
                    Textbox.Size = UDim2.new(0, 200, 0, 22)
                    buttoneffect({frame = textBoxLabel, entered = Textbox})

                    textBoxLabel.Name = "textBoxLabel"
                    textBoxLabel.Parent = Textbox
                    textBoxLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    textBoxLabel.BackgroundColor3 = Color3.fromRGB(157, 171, 182)
                    textBoxLabel.BackgroundTransparency = 1.000
                    textBoxLabel.Position = UDim2.new(0.237000003, 0, 0.5, 0)
                    textBoxLabel.Size = UDim2.new(0, 99, 0, 22)
                    textBoxLabel.Font = Enum.Font.Gotham
                    textBoxLabel.Text = "  " .. options.text
                    textBoxLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    textBoxLabel.TextSize = 14.000
                    textBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

                    textBox.Name = "textBox"
                    textBox.Parent = Textbox
                    textBox.AnchorPoint = Vector2.new(0.5, 0.5)
                    textBox.BackgroundColor3 = Color3.fromRGB(1, 7, 17)
                    textBox.Position = UDim2.new(0.850000024, 0, 0.5, 0)
                    textBox.Size = UDim2.new(0, 53, 0, 15)
                    textBox.Font = Enum.Font.Gotham
                    textBox.Text = options.value
                    textBox.TextColor3 = Color3.fromRGB(234, 239, 245)
                    textBox.TextSize = 11.000
                    textBox.TextWrapped = true

                    Resize(25)

                    textBox.Focused:Connect(function()
                        TweenService:Create(textBoxLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(234, 239, 246)}):Play()
                    end)

                    textBox.FocusLost:Connect(function(Enter)
                        TweenService:Create(textBoxLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(157, 171, 182)}):Play()
                        if Enter then
                            if textBox.Text ~= nil and textBox.Text ~= "" then
                                options.callback(textBox.Text)
                            end
                        end
                    end)
                end

                function elements:Colorpicker(options)
                    if not options.text or not options.color or not options.callback then Notify("Colorpicker", "Missing arguments!") return end


                    local hue, sat, val = Color3.toHSV(options.color)

                    local Colorpicker = Instance.new("Frame")
                    local colorpickerLabel = Instance.new("TextLabel")
                    local colorpickerButton = Instance.new("ImageButton")
                    local colorpickerFrame = Instance.new("Frame")
                    local RGB = Instance.new("ImageButton")
                    local RGBCircle = Instance.new("ImageLabel")
                    local Darkness = Instance.new("ImageButton")
                    local DarknessCircle = Instance.new("Frame")
                    local colorHex = Instance.new("TextLabel")
                    local Copy = Instance.new("TextButton")
                    buttoneffect({frame = colorpickerLabel, entered = Colorpicker})

                    local vis = false 

                    Colorpicker.Name = "Colorpicker"
                    Colorpicker.Parent = sectionFrame
                    Colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Colorpicker.BackgroundTransparency = 1.000
                    Colorpicker.BorderSizePixel = 0
                    Colorpicker.Position = UDim2.new(0.0348837227, 0, 0.945454538, 0)
                    Colorpicker.Size = UDim2.new(0, 200, 0, 22)
                    Colorpicker.ZIndex = 2

                    colorpickerLabel.Name = "colorpickerLabel"
                    colorpickerLabel.Parent = Colorpicker
                    colorpickerLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    colorpickerLabel.BackgroundColor3 = Color3.fromRGB(157, 171, 182)
                    colorpickerLabel.BackgroundTransparency = 1.000
                    colorpickerLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                    colorpickerLabel.Size = UDim2.new(0, 200, 0, 22)
                    colorpickerLabel.Font = Enum.Font.Gotham
                    colorpickerLabel.Text = " " .. options.text
                    colorpickerLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    colorpickerLabel.TextSize = 14.000
                    colorpickerLabel.TextXAlignment = Enum.TextXAlignment.Left

                    colorpickerButton.Name = "colorpickerButton"
                    colorpickerButton.Parent = colorpickerLabel
                    colorpickerButton.AnchorPoint = Vector2.new(0.5, 0.5)
                    colorpickerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    colorpickerButton.BackgroundTransparency = 1.000
                    colorpickerButton.BorderSizePixel = 0
                    colorpickerButton.Position = UDim2.new(0.920, 0, 0.57, 0)
                    colorpickerButton.Size = UDim2.new(0, 15, 0, 15)
                    colorpickerButton.Image = "rbxassetid://8023491332"
                    colorpickerButton.MouseButton1Click:Connect(function()
                        colorpickerFrame.Visible = not colorpickerFrame.Visible
                        vis = not vis
                        TweenService:Create(colorpickerLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                            TextColor3 = vis and Color3.fromRGB(234, 239, 246) or Color3.fromRGB(157, 171, 182)
                        }):Play()
                    end)

                    colorpickerFrame.Name = "colorpickerFrame"
                    colorpickerFrame.Parent = Colorpicker
                    colorpickerFrame.Visible = false
                    colorpickerFrame.BackgroundColor3 = Theme.SideBar
                    colorpickerFrame.Position = UDim2.new(1.15, 0, 0.5, 0)
                    colorpickerFrame.Size = UDim2.new(0, 251, 0, 221)
                    colorpickerFrame.ZIndex = 15
                    
                    local cpCorner = Instance.new("UICorner")
                    cpCorner.CornerRadius = UDim.new(0, 8)
                    cpCorner.Parent = colorpickerFrame
                    
                    local cpStroke = Instance.new("UIStroke")
                    cpStroke.Color = Theme.Border
                    cpStroke.Thickness = 1.5
                    cpStroke.Parent = colorpickerFrame
                    
                    Dragify(colorpickerFrame, colorpickerFrame)

                    RGB.Name = "RGB"
                    RGB.Parent = colorpickerFrame
                    RGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    RGB.BackgroundTransparency = 1.000
                    RGB.BorderSizePixel = 0
                    RGB.Position = UDim2.new(0.0670000017, 0, 0.0680000037, 0)
                    RGB.Size = UDim2.new(0, 179, 0, 161)
                    RGB.AutoButtonColor = false
                    RGB.Image = "rbxassetid://6523286724"
                    RGB.ZIndex = 16

                    RGBCircle.Name = "RGBCircle"
                    RGBCircle.Parent = RGB
                    RGBCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    RGBCircle.BackgroundTransparency = 1.000
                    RGBCircle.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    RGBCircle.BorderSizePixel = 0
                    RGBCircle.Size = UDim2.new(0, 14, 0, 14)
                    RGBCircle.Image = "rbxassetid://3926309567"
                    RGBCircle.ImageRectOffset = Vector2.new(628, 420)
                    RGBCircle.ImageRectSize = Vector2.new(48, 48)
                    RGBCircle.ZIndex = 16

                    Darkness.Name = "Darkness"
                    Darkness.Parent = colorpickerFrame
                    Darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Darkness.BorderSizePixel = 0
                    Darkness.Position = UDim2.new(0.831940293, 0, 0.0680000708, 0)
                    Darkness.Size = UDim2.new(0, 33, 0, 161)
                    Darkness.AutoButtonColor = false
                    Darkness.Image = "rbxassetid://156579757"
                    Darkness.ZIndex = 16

                    DarknessCircle.Name = "DarknessCircle"
                    DarknessCircle.Parent = Darkness
                    DarknessCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DarknessCircle.BorderSizePixel = 0
                    DarknessCircle.Position = UDim2.new(0, 0, 0, 0)
                    DarknessCircle.Size = UDim2.new(0, 33, 0, 5)
                    DarknessCircle.ZIndex = 16

                    colorHex.Name = "colorHex"
                    colorHex.Parent = colorpickerFrame
                    colorHex.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
                    colorHex.Position = UDim2.new(0.0717131495, 0, 0.850678742, 0)
                    colorHex.Size = UDim2.new(0, 94, 0, 24)
                    colorHex.Font = Enum.Font.GothamSemibold
                    colorHex.Text = "#FFFFFF"
                    colorHex.TextColor3 = Color3.fromRGB(234, 239, 245)
                    colorHex.TextSize = 14.000
                    colorHex.ZIndex = 16

                    Copy.Parent = colorpickerFrame
                    Copy.BackgroundColor3 = Color3.fromRGB(9, 8, 13)
                    Copy.Position = UDim2.new(0.72111553, 0, 0.850678742, 0)
                    Copy.Size = UDim2.new(0, 60, 0, 24)
                    Copy.AutoButtonColor = false
                    Copy.Font = Enum.Font.GothamSemibold
                    Copy.Text = "Copy"
                    Copy.TextColor3 = Color3.fromRGB(234, 239, 245)
                    Copy.TextSize = 14.000
                    Copy.ZIndex = 16
                    Resize(25)
                    Copy.MouseButton1Click:Connect(function()
                        if setclipboard then
                            setclipboard(tostring(colorHex.Text))
                            Notify("Cryptweb:", tostring(colorHex.Text))
                            Notify("Cryptweb:", "Done!")
                        else
                            print(tostring(colorHex.Text))
                            Notify("Cryptweb:", tostring(colorHex.Text))
                            Notify("Cryptweb:", "Your exploit does not support the function 'setclipboard', so we've printed it out.")
                        end
                    end)

                    local ceil,clamp,atan2,pi   = math.ceil,math.clamp,math.atan2,math.pi
                    local tostr,sub             = tostring,string.sub
                    local fromHSV               = Color3.fromHSV
                    local v2,udim2              = Vector2.new,UDim2.new

                    local UserInputService  = game:GetService("UserInputService")
                    local getmouse              = game.Players.LocalPlayer:GetMouse()

                    local WheelDown         = false
                    local SlideDown         = false

                    local function toPolar(v)
                        return atan2(v.y, v.x), v.magnitude;
                    end

                    local function radToDeg(x)
                        return ((x + pi) / (2 * pi)) * 360;
                    end
                    local hue, saturation, value = 0, 0, 1;
                    local color = {1,1,1}

                    local function to_hex(color)
                        return string.format("#%02X%02X%02X", color.R * 255, color.G * 255, color.B * 255)
                    end
                    local function update()
                        local r = color[1];
                        local g = color[2];
                        local b = color[3];

                        local c = fromHSV(r, g, b);
                        colorHex.Text = tostring(to_hex(c))
                    end
                    local function mouseLocation()
                        return game.Players.LocalPlayer:GetMouse()
                    end
                    local function UpdateSlide(iX,iY)   
                        local ml = mouseLocation()
                        local y = ml.Y - Darkness.AbsolutePosition.Y
                        local maxY = Darkness.AbsoluteSize.Y
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        y = y/maxY
                        local cy = DarknessCircle.AbsoluteSize.Y/2
                        color = {color[1],color[2],1-y}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        DarknessCircle.BackgroundColor3 = realcolor
                        DarknessCircle.Position = UDim2.new(0,0,y,-cy)
                        options.callback(realcolor)

                        update();
                    end
                    local function UpdateRing(iX,iY)
                        local ml = mouseLocation()
                        local x,y = ml.X - RGB.AbsolutePosition.X,ml.Y - RGB.AbsolutePosition.Y
                        local maxX,maxY = RGB.AbsoluteSize.X,RGB.AbsoluteSize.Y
                        if x<0 then 
                            x=0 
                        end
                        if x>maxX then 
                            x=maxX 
                        end
                        if y<0 then 
                            y=0 
                        end
                        if y>maxY then 
                            y=maxY
                        end
                        x = x/maxX
                        y = y/maxY

                        local cx = RGBCircle.AbsoluteSize.X/2
                        local cy = RGBCircle.AbsoluteSize.Y/2

                        RGBCircle.Position = udim2(x,-cx,y,-cy)

                        color = {1-x,1-y,color[3]}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        Darkness.BackgroundColor3 = realcolor
                        DarknessCircle.BackgroundColor3 = realcolor
                        options.callback(realcolor)
                        update();
                    end


                    RGB.MouseButton1Down:Connect(function()
                        WheelDown = true
                        UpdateRing(getmouse.X,getmouse.Y)
                    end)
                    Darkness.MouseButton1Down:Connect(function()
                        SlideDown = true
                        UpdateSlide(getmouse.X,getmouse.Y)
                    end)


                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            WheelDown = false
                            SlideDown = false
                        end
                    end)

                    RGB.MouseMoved:Connect(function()
                        if WheelDown then
                            UpdateRing(getmouse.X,getmouse.Y)
                        end
                    end)
                    Darkness.MouseMoved:Connect(function()
                        if SlideDown then
                            UpdateSlide(getmouse.X,getmouse.Y)
                        end
                    end)

                    local function setcolor(tbl)
                        local realcolor = Color3.fromHSV(tbl[1],tbl[2],tbl[3])
                        colorHex.Text = tostring(to_hex(realcolor))
                        DarknessCircle.BackgroundColor3 = realcolor
                    end
                    setcolor({hue,sat,val})
                end

                function elements:Keybind(options)
                    if not options.text or not options.default or not options.callback then Notify("Keybind", "Missing arguments") return end

                    Resize(25)

                    local blacklisted = {
                        Return = true,
                        Space = true,
                        Tab = true,
                        W = true,
                        A = true,
                        S = true,
                        D = true,
                        I = true,
                        O = true,
                        Unknown = true
                    }

                    local short = {
                        RightControl = "RCtrl",
                        LeftControl = "LCtrl",
                        LeftShift = "LShift",
                        RightShift = "RShift",
                        MouseButton1 = "M1",
                        MouseButton2 = "M2",
                        LeftAlt = "LAlt",
                        RightAlt = "RAlt"
                    }

                    local oldKey = options.default.Name
                    local Keybind = Instance.new("Frame")
                    local keybindButton = Instance.new("TextButton")
                    local keybindLabel = Instance.new("TextLabel")

                    Keybind.Name = "Keybind"
                    Keybind.Parent = sectionFrame
                    Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Keybind.BackgroundTransparency = 1.000
                    Keybind.BorderSizePixel = 0
                    Keybind.Position = UDim2.new(0.0348837227, 0, 0.945454538, 0)
                    Keybind.Size = UDim2.new(0, 200, 0, 22)
                    Keybind.ZIndex = 2
                    buttoneffect({frame = keybindButton, entered = Keybind})

                    keybindButton.Name = "keybindButton"
                    keybindButton.Parent = Keybind
                    keybindButton.AnchorPoint = Vector2.new(0.5, 0.5)
                    keybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindButton.BackgroundTransparency = 1.000
                    keybindButton.BorderSizePixel = 0
                    keybindButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                    keybindButton.Size = UDim2.new(0, 200, 0, 22)
                    keybindButton.AutoButtonColor = false
                    keybindButton.Font = Enum.Font.Gotham
                    keybindButton.Text = " " .. options.text
                    keybindButton.TextColor3 = Color3.fromRGB(157, 171, 182)
                    keybindButton.TextSize = 14.000
                    keybindButton.TextXAlignment = Enum.TextXAlignment.Left
                    keybindButton.MouseButton1Click:Connect(function()
                        keybindLabel.Text = "... "
                        TweenService:Create(keybindButton, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(234, 239, 246)
                        }):Play()
                        TweenService:Create(keybindLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextColor3 = Color3.fromRGB(234, 239, 246)
                        }):Play()
                        local inputbegan = game:GetService("UserInputService").InputBegan:wait()
                        if not blacklisted[inputbegan.KeyCode.Name] then
                            TweenService:Create(keybindLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            TweenService:Create(keybindButton, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            keybindLabel.Text = short[inputbegan.KeyCode.Name] or inputbegan.KeyCode.Name
                            oldKey = inputbegan.KeyCode.Name
                        else
                            TweenService:Create(keybindButton, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            TweenService:Create(keybindLabel, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TextColor3 = Color3.fromRGB(157, 171, 182)
                            }):Play()
                            keybindLabel.Text = short[oldKey] or oldKey
                        end
                    end)

                    game:GetService("UserInputService").InputBegan:connect(function(key, focused)
                        if not focused then
                            if key.KeyCode.Name == oldKey then
                                options.callback(oldKey)
                            end
                        end
                    end)

                    keybindLabel.Name = "keybindLabel"
                    keybindLabel.Parent = keybindButton
                    keybindLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    keybindLabel.BackgroundColor3 = Color3.fromRGB(157, 171, 182)
                    keybindLabel.BackgroundTransparency = 1.000
                    keybindLabel.Position = UDim2.new(0.910000026, 0, 0.5, 0)
                    keybindLabel.Size = UDim2.new(0, 36, 0, 22)
                    keybindLabel.Font = Enum.Font.Gotham
                    keybindLabel.Text = oldKey .. " "
                    keybindLabel.TextColor3 = Color3.fromRGB(157, 171, 182)
                    keybindLabel.TextSize = 14.000
                    keybindLabel.TextXAlignment = Enum.TextXAlignment.Right
                end

                function elements:TextLabel(options)
                    options = options or {}
                    options.text = options.text or "Label"
                    options.color = options.color or Color3.fromRGB(157, 171, 182)

                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Name = "customLabel"
                    TextLabel.Parent = sectionFrame
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Position = UDim2.new(0.0348837227, 0, 0, 0)
                    TextLabel.Size = UDim2.new(0, 200, 0, 22)
                    TextLabel.Font = Enum.Font.Gotham
                    TextLabel.Text = " " .. options.text
                    TextLabel.TextColor3 = options.color
                    TextLabel.TextSize = 14.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.TextWrapped = true

                    Resize(25)
                    
                    return TextLabel
                end

                return elements
            end

            return sections
        end

        return tabs
    end

    return tabsections
end

return Library
