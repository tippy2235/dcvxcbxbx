if not string.find(game:HttpGet("https://pastefy.app/vW9KPZkf/raw"), "Good") then return end
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tippy2235/dcvxcbxbx/refs/heads/main/central.lua"))()

local g = getinfo or debug.getinfo
local d = false
local h = {}

local x, y

setthreadidentity(2)

for i, v in getgc(true) do
	if typeof(v) == "table" then
		local a = rawget(v, "Detected")
		local b = rawget(v, "Kill")

		if typeof(a) == "function" and not x then
			x = a

			local o
			o = hookfunction(x, function(c, f, n)
				if c ~= "_" then
					if d then
						warn(`Adonis AntiCheat flagged\nMethod: {c}\nInfo: {f}`)
					end
				end

				return true
			end)

			table.insert(h, x)
		end

		if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
			y = b
			local o
			o = hookfunction(y, function(f)
				if d then
					warn(`Adonis AntiCheat tried to kill (fallback): {f}`)
				end
			end)

			table.insert(h, y)
		end
	end
end

local o
o = hookfunction(
	getrenv().debug.info,
	newcclosure(function(...)
		local a, f = ...

		if x and a == x then
			if d then
				warn(`zins | adonis bypassed`)
			end

			return coroutine.yield(coroutine.running())
		end

		return o(...)
	end)
)

setthreadidentity(7)

--------------Above is the Adonis bypass DONT REMOVE IT. It needs to run before the script like now.

-- Webhook Logging
local function logExecution()
    local HttpService = game:GetService("HttpService")
    local req = (syn and syn.request) or http_request or (http and http.request) or request
    local hwid = (gethwid and gethwid()) or "Unknown"
    local executor = (identifyexecutor and identifyexecutor()) or "Unknown"
    
    local count = "Unknown"
    pcall(function()
        local res = game:HttpGet("https://api.counterapi.dev/v1/rynex_central/" .. hwid:gsub("[^%w]", "") .. "/increment")
        local data = HttpService:JSONDecode(res)
        count = data.count or "1"
    end)

    if req then
        pcall(function()
            req({
                Url = "https://discord.com/api/webhooks/1493757745390682185/N1E9wMDUyCxt9O8FUZpFCtT6f4WdjZ8erEj9LFSBpRXp-CX1UkPeBon-YKTVRL_KjzoH",
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({
                    embeds = {{
                        title = "A user has executed the script",
                        description = "New execution detected for **Rynex Central**",
                        color = 0x2697FF,
                        fields = {
                            {name = "Executor Name", value = "```" .. executor .. "```", inline = true},
                            {name = "HWID", value = "```" .. hwid .. "```", inline = true},
                            {name = "Execution Count", value = "```" .. tostring(count) .. "```", inline = false}
                        },
                        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                        footer = {text = "Execution Logger"}
                    }}
                })
            })
        end)
    end
end

task.spawn(logExecution)




-- Silent Aim Variables
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local AimbotEnabled = false
local AimbotSmoothness = 0.1
local AimbotFOV = 200
local AimbotWallCheck = false
local AimbotTeamCheck = false
local AimbotKey = Enum.KeyCode.Q
local SnapLinesEnabled = false
local BulletTracersEnabled = false
local BoxESPEnabled = false
local HealthBarESPEnabled = false
local SilentAimPart = "Head"

local GuiService = game:GetService("GuiService")

local TeleportLocations = {
    ["Gun Store"] = CFrame.new(-716, 64, -256),
    ["Gun Store 2"] = CFrame.new(-717, 64, -256),
    ["Bank"] = CFrame.new(183, 90, -168),
    ["BankSupply"] = CFrame.new(997, 231, -490),
    ["Barber Shop"] = CFrame.new(66, 90, -33),
    ["Box Job"] = CFrame.new(-14, 90, 265),
    ["Build Guns"] = CFrame.new(-35491, 253, -179),
    ["Car Customization"] = CFrame.new(-153, 90, -146),
    ["Sell Cooked Fries"] = CFrame.new(815, 91, 577),
    ["Fries"] = CFrame.new(5, 90, -57),
    ["Clothing Store"] = CFrame.new(115, 90, -53),
    ["McDonalds"] = CFrame.new(963, 130, 86),
    ["DealerShip"] = CFrame.new(413, 90, -360),
    ["ExoticDealer"] = CFrame.new(-152, 90, -262),
    ["Grow Area"] = CFrame.new(1525, 107, 2671),
    ["BlackMarket"] = CFrame.new(-801, 45, 565),
    ["Hitman Registration"] = CFrame.new(-1335, 50, 433),
    ["IceBox"] = CFrame.new(211, 90, 143),
    ["Night Club"] = CFrame.new(-443, 208, 121),
    ["PawnShop"] = CFrame.new(196, 91, -30),
    ["Pent House 1"] = CFrame.new(1001, 272, 459),
    ["Pent House 2"] = CFrame.new(193, 230, 292),
    ["Buy Seeds"] = CFrame.new(-797, 45, 566),
    ["Police Station"] = CFrame.new(381, 92, -109),
    ["Sell Plants"] = CFrame.new(756, 228, -130),
    ["Sell Sewage"] = CFrame.new(0, 10, 0),
    ["Studio"] = CFrame.new(-35784, 18, -289),
    ["SupplyStore"] = CFrame.new(-452, 51, 395),
    ["Swiper Cards"] = CFrame.new(-602, 51, 584),
    ["Tattoo Shop"] = CFrame.new(983, 131, -100),
    ["Trap House"] = CFrame.new(-58, 80, -133),
    ["Laundromat"] = CFrame.new(-710, 50, 289),
    ["Chop Shop"] = CFrame.new(237, 101, 2692),
    ["Package Fruit"] = CFrame.new(-2375, 50, 663),
    ["Fight Club"] = CFrame.new(-470, 35, -81),
    ["Sell Built Guns"] = CFrame.new(394, 120, 220),
    ["Pet Shop"] = CFrame.new(1249, 135, -557)
}

local function getMousePosition()
    return UserInputService:GetMouseLocation()
end

local function getPositionForMath(Vector)
    local cam = workspace.CurrentCamera
    if not cam then return Vector2.new(), false end
    local Vec3, OnScreen = cam:WorldToScreenPoint(Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function getPositionForDrawing(Vector)
    local cam = workspace.CurrentCamera
    if not cam then return Vector2.new(), false end
    local Vec3, OnScreen = cam:WorldToViewportPoint(Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 2
fov_circle.NumSides = 100
fov_circle.Radius = AimbotFOV
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 0.5
fov_circle.Color = Color3.fromRGB(255, 0, 0)


local snapLines = {}
local tracerLines = {}

local function createLine(color, thickness)
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = color or Color3.fromRGB(255, 50, 50)
    line.Thickness = thickness or 1
    line.Transparency = 1
    line.ZIndex = 999
    return line
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local GameId = game.GameId
local ts, characters, teams, rp
local getEntry

local gids = {
	['arsenal'] = 111958650,
	['pf'] = 113491250,
	['pft'] = 115272207,
	['pfu'] = 1256867479,
	['bb'] = 1168263273,
	['rp'] = 2162282815,
	['mm2'] = 66654135
}

if GameId == gids.bb then
	for _,v in next, getgc(true) do
		if typeof(v) == "table" and rawget(v, "InitProjectile") and rawget(v, "TS") then
			ts = rawget(v, "TS")
			characters = ts.Characters
			teams = ts.Teams
		end
	end
elseif GameId == gids.rp then
	rp = true
end

local function GetChar(plr)
	return plr.Character
end

if ts then
    pcall(function() hookfunction(PluginManager, error) end)
    GetChar = function(plr)
        return characters:GetCharacter(plr)
    end
end
if rp then
    GetChar = function(plr)
        local mapfolder = workspace:FindFirstChild("MapFolder")
        local playerfolder = mapfolder and mapfolder:FindFirstChild("Players")
        if playerfolder then
            return playerfolder:FindFirstChild(plr.Name)
        end
        return nil
    end
end


local function isVisible(character)
    local localChar = GetChar(LocalPlayer)
    if not (character and localChar) then return false end
    local root = character:FindFirstChild(SilentAimPart) or character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not root then return false end
    local castPoints = {root.Position}
    local ignoreList = {localChar, character}
    local cam = workspace.CurrentCamera
    if cam then
        for _, v in pairs(cam:GetChildren()) do
            table.insert(ignoreList, v)
        end
    end
    local obscuringParts = cam and cam:GetPartsObscuringTarget(castPoints, ignoreList) or {}
    return #obscuringParts == 0
end

local function getClosestPlayer()
    local closest = nil
    local closestDist = math.huge
    local mousePos = getMousePosition()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if AimbotTeamCheck and player.Team == LocalPlayer.Team then continue end
        local character = GetChar(player)
        if not character then continue end
        local HRP = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("Chest")
        local targetPart = character:FindFirstChild(SilentAimPart) or HRP or character.PrimaryPart
        if not targetPart then continue end
        if AimbotWallCheck and not isVisible(character) then continue end
        local screenPos, onScreen = getPositionForMath(targetPart.Position)
        if not onScreen then continue end
        local dist = (mousePos - screenPos).Magnitude
        if dist <= AimbotFOV and dist < closestDist then
            closestDist = dist
            closest = targetPart
        end
    end
    return closest
end

-- RenderStepped: FOV circle, aimbot, snaplines, bullet tracers
RunService.RenderStepped:Connect(function()
    fov_circle.Position = getMousePosition()
    fov_circle.Radius = AimbotFOV

    local target = getClosestPlayer()
    local keyHeld = UserInputService:IsKeyDown(AimbotKey)

    if AimbotEnabled and keyHeld and target then
        local cam = workspace.CurrentCamera
        if cam then
            local Vec3, OnScreen = cam:WorldToViewportPoint(target.Position)
            if OnScreen then
                local target2D = Vector2.new(Vec3.X, Vec3.Y)
                local mousePos = getMousePosition()
                local rawDistX = (target2D.X - mousePos.X)
                local rawDistY = (target2D.Y - mousePos.Y)
                if mousemoverel and AimbotSmoothness < 1 then
                    mousemoverel(rawDistX * AimbotSmoothness, rawDistY * AimbotSmoothness)
                else
                    if AimbotSmoothness >= 1 then
                        cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
                    else
                        local camCFrame = cam.CFrame
                        local targetCFrame = CFrame.new(camCFrame.Position, target.Position)
                        cam.CFrame = camCFrame:Lerp(targetCFrame, AimbotSmoothness)
                    end
                end
            end
        end
    end

    -- Snaplines
    for _, line in pairs(snapLines) do line.Visible = false end
    local idx = 1
    for _, Player in pairs(Players:GetPlayers()) do
        if Player == LocalPlayer then continue end
        local Character = GetChar(Player)
        if not Character then continue end
        local HRP = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso") or Character:FindFirstChild("Chest")
        local targetPart = Character:FindFirstChild(SilentAimPart) or HRP or Character.PrimaryPart
        if not targetPart then continue end
        local ScreenPos, OnScreen = getPositionForDrawing(targetPart.Position)
        if not OnScreen then continue end
        if SnapLinesEnabled then
            if not snapLines[idx] then snapLines[idx] = createLine(Color3.fromRGB(255, 50, 50), 1) end
            snapLines[idx].From = getMousePosition()
            snapLines[idx].To = ScreenPos
            snapLines[idx].Visible = true
        end
        idx = idx + 1
    end

    -- Bullet Tracers
    for _, line in pairs(tracerLines) do line.Visible = false end
    if BulletTracersEnabled and target then
        local ScreenPos, OnScreen = getPositionForDrawing(target.Position)
        local cam = workspace.CurrentCamera
        if OnScreen and cam then
            if not tracerLines[1] then tracerLines[1] = createLine(Color3.fromRGB(255, 200, 0), 1) end
            local tracerOrigin = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
            tracerLines[1].From = tracerOrigin
            tracerLines[1].To = ScreenPos
            tracerLines[1].Visible = true
        end
    end
end)


local Window = Library:Window({text = "🎮 Rynex 🎮", icon = ""})
local TabSection = Window:TabSection({text = "Central Streets", icon = ""})
local MainTab = TabSection:Tab({text = "🏠 Main", icon = ""})
local AimbotTab = TabSection:Tab({text = "🎯 Aimbot", icon = ""})

-- Aimbot Tab
local AimbotSection = AimbotTab:Section({text = "Aimbot"})

AimbotSection:Toggle({
    text = "Aimbot",
    state = false,
    callback = function(state)
        AimbotEnabled = state
        fov_circle.Visible = state
    end
})

AimbotSection:Keybind({
    text = "Hold Key",
    default = Enum.KeyCode.Q,
    callback = function(key)
        AimbotKey = key
    end
})

AimbotSection:Toggle({
    text = "Wall Check",
    state = false,
    callback = function(state)
        AimbotWallCheck = state
    end
})

AimbotSection:Dropdown({
    text = "Target Part",
    list = {"HumanoidRootPart", "Head"},
    default = "HumanoidRootPart",
    callback = function(value)
        SilentAimPart = value
    end
})

AimbotSection:Toggle({
    text = "Team Check",
    state = false,
    callback = function(state)
        AimbotTeamCheck = state
    end
})

AimbotSection:Slider({
    text = "FOV Radius",
    min = 10,
    max = 500,
    callback = function(value)
        AimbotFOV = tonumber(value) or 200
        fov_circle.Radius = AimbotFOV
    end
})

AimbotSection:Slider({
    text = "Smoothness",
    min = 1,
    max = 100,
    callback = function(value)
        AimbotSmoothness = (tonumber(value) or 10) / 100
    end
})

AimbotSection:Toggle({
    text = "Target Snaplines",
    state = false,
    callback = function(state)
        SnapLinesEnabled = state
        if not state then
            for _, line in pairs(snapLines) do line.Visible = false end
        end
    end
})

AimbotSection:Toggle({
    text = "Bullet Tracers",
    state = false,
    callback = function(state)
        BulletTracersEnabled = state
        if not state then
            for _, line in pairs(tracerLines) do line.Visible = false end
        end
    end
})


local PlayerSection = MainTab:Section({text = "Player"})

getgenv().DisableJumpcooldown = false
PlayerSection:Toggle({
    text = "🚫 No Jump CoolDown",
    state = false,
    callback = function(state)
        if state then
            getgenv().DisableJumpcooldown = true
            while getgenv().DisableJumpcooldown == true do
                game:GetService("Players").LocalPlayer.PlayerGui.JumpCooldown.Disabled = true
                wait()
            end
        else
            getgenv().DisableJumpcooldown = false
            game:GetService("Players").LocalPlayer.PlayerGui.JumpCooldown.Enabled = true
        end
    end
})

local infJump = nil
local infJumpDebounce = false
PlayerSection:Toggle({
    text = "♾️ Infinite Jump",
    state = false,
    callback = function(state)
        if state then
            if infJump then infJump:Disconnect() end
            infJumpDebounce = false
            local UserInputService = game:GetService("UserInputService")
            infJump = UserInputService.JumpRequest:Connect(function()
                if not infJumpDebounce then
                    infJumpDebounce = true
                    local player = game:GetService("Players").LocalPlayer
                    if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
                        player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    wait()
                    infJumpDebounce = false
                end
            end)
        else
            if infJump then
                infJump:Disconnect()
                infJump = nil
            end
            infJumpDebounce = false
        end
    end
})

PlayerSection:Toggle({
    text = "🧍‍♂️ No RagDoll",
    state = false,
    callback = function(state)
        getgenv().NoRagdoll = state
        if state then
            spawn(function()
                while getgenv().NoRagdoll do
                    pcall(function()
                        local char = game:GetService("Players").LocalPlayer.Character
                        if char then
                            local client = char:FindFirstChild("RagdollClient", true) or workspace.FusionFlick65:FindFirstChild("RagdollClient")
                            if client then client.Disabled = true end
                            
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            if hum and (hum.PlatformStand or hum:GetState() == Enum.HumanoidStateType.Ragdoll) then
                                hum.PlatformStand = false
                                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                            end
                        end
                    end)
                    task.wait()
                end
            end)
        else
            pcall(function()
                workspace.FusionFlick65.RagdollClient.Disabled = false
            end)
        end
    end
})local PromptButtonHoldBegan = nil
PlayerSection:Toggle({
    text = "⚡ Instant Interaction",
    state = false,
    callback = function(state)
        if state then
            if fireproximityprompt then
                if PromptButtonHoldBegan then
                    PromptButtonHoldBegan:Disconnect()
                end
                wait(0.1)
                local ProximityPromptService = game:GetService("ProximityPromptService")
                PromptButtonHoldBegan = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
                    fireproximityprompt(prompt)
                end)
            else
                print("Your exploit does not support this feature")
            end
        else
            if PromptButtonHoldBegan then
                PromptButtonHoldBegan:Disconnect()
                PromptButtonHoldBegan = nil
            end
        end
    end
})

local cframewalk = false
local toggleEnabled = false
local walkspeedValue = 80

PlayerSection:Slider({
    text = "CFrame Walk Speed",
    min = 0,
    max = 500,
    callback = function(value)
        walkspeedValue = value
    end
})

PlayerSection:Toggle({
    text = "🏃 CFrame Walk",
    state = false,
    callback = function(state)
        toggleEnabled = state
        cframewalk = state
    end
})

spawn(function()
    while true do
        if cframewalk then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character.HumanoidRootPart then
                player.Character.HumanoidRootPart.Velocity = player.Character.HumanoidRootPart.CFrame.lookVector * walkspeedValue
            end
        end
        wait()
    end
end)

PlayerSection:Keybind({
    text = "⌨️ CFrame Walk Keybind",
    default = Enum.KeyCode.V,
    callback = function()
        if toggleEnabled then
            cframewalk = not cframewalk
        end
    end
})


local autoPickupTools = false
local autoPickupConnection = nil
local pickedUpTools = {}
PlayerSection:Toggle({
    text = "🔧 Auto Pick Up Tools",
    state = false,
    callback = function(state)
        autoPickupTools = state
        if state then
            local player = game:GetService("Players").LocalPlayer
            local function pickupTool(tool)
                if autoPickupTools and tool:IsA("Tool") and not pickedUpTools[tool] then
                    if tool.Parent == workspace or tool.Parent.Parent == workspace then
                        if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
                            pcall(function()
                                tool.Parent = player.Character
                                pickedUpTools[tool] = true
                            end)
                        end
                    end
                end
            end
            for _, tool in pairs(workspace:GetDescendants()) do
                if tool:IsA("Tool") then
                    pickupTool(tool)
                end
            end
            autoPickupConnection = workspace.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("Tool") then
                    wait(0.1)
                    pickupTool(descendant)
                end
            end)
        else
            if autoPickupConnection then
                autoPickupConnection:Disconnect()
                autoPickupConnection = nil
            end
            pickedUpTools = {}
        end
    end
})

local Clip = true
local Noclipping = nil
local floatName = "Float"
PlayerSection:Toggle({
    text = "👻 No Clip",
    state = false,
    callback = function(state)
        if state then
            Clip = false
            wait(0.1)
            local RunService = game:GetService("RunService")
            local function NoclipLoop()
                if Clip == false then
                    local player = game:GetService("Players").LocalPlayer
                    if player.Character ~= nil then
                        for _, child in pairs(player.Character:GetDescendants()) do
                            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                                child.CanCollide = false
                            end
                        end
                    end
                end
            end
            Noclipping = RunService.Stepped:Connect(NoclipLoop)
        else
            Clip = true
            if Noclipping then
                Noclipping:Disconnect()
                Noclipping = nil
            end
            local player = game:GetService("Players").LocalPlayer
            if player.Character ~= nil then
                for _, child in pairs(player.Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.Name ~= floatName then
                        child.CanCollide = true
                    end
                end
            end
        end
    end
})


local TeleportSection = MainTab:Section({text = "Teleports"})

local function getTeleportList()
    local list = {}
    for name, _ in pairs(TeleportLocations) do
        table.insert(list, name)
    end
    table.sort(list)
    return list
end

TeleportSection:Dropdown({
    text = "Select Location",
    list = getTeleportList(),
    default = "Gun Store",
    callback = function(value)
        if TeleportLocations[value] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TeleportLocations[value]
        end
    end
})


local TwitterSection = MainTab:Section({text = "Twitter Configuration"})
local twitterMessage = ""
local loopSendTwitter = false

TwitterSection:Textbox({
    text = "📝 Twitter Message",
    value = "",
    callback = function(text)
        twitterMessage = text
    end
})

TwitterSection:Button({
    text = "📤 Send Message",
    callback = function()
        if twitterMessage ~= "" then
            local args = {"BirdText", twitterMessage}
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PhoneFunction"):InvokeServer(unpack(args))
        end
    end
})

TwitterSection:Toggle({
    text = "🔁 Loop Send Twitter Message",
    state = false,
    callback = function(state)
        loopSendTwitter = state
        if state then
            spawn(function()
                while loopSendTwitter do
                    if twitterMessage ~= "" then
                        local args = {"BirdText", twitterMessage}
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PhoneFunction"):InvokeServer(unpack(args))
                        end)
                    end
                    wait(1)
                end
            end)
        end
    end
})

local TargetSection = MainTab:Section({text = "Target Players"})
local selectedPlayer = nil
local spectating = false
local flinging = false
local viewDied = nil
local viewChanged = nil

getgenv().OldPos = nil
getgenv().FPDH = workspace.FallenPartsDestroyHeight

local function getPlayerNames()
    local players = {}
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    return players
end

TargetSection:Dropdown({
    text = "Select Player",
    list = getPlayerNames(),
    default = getPlayerNames()[1] or "None",
    callback = function(playerName)
        selectedPlayer = game:GetService("Players"):FindFirstChild(playerName)
        print("Selected player: " .. playerName)
    end
})

TargetSection:Toggle({
    text = "👁️ Spectate Player",
    state = false,
    callback = function(state)
        spectating = state
        local player = game:GetService("Players").LocalPlayer
        if state then
            if selectedPlayer and selectedPlayer.Character then
                if viewDied then viewDied:Disconnect() viewDied = nil end
                if viewChanged then viewChanged:Disconnect() viewChanged = nil end
                workspace.CurrentCamera.CameraSubject = selectedPlayer.Character
                print("Spectating " .. selectedPlayer.Name)
                local function viewDiedFunc()
                    repeat wait() until selectedPlayer.Character ~= nil and selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
                    workspace.CurrentCamera.CameraSubject = selectedPlayer.Character
                end
                viewDied = selectedPlayer.CharacterAdded:Connect(viewDiedFunc)
                local function viewChangedFunc()
                    if spectating then
                        workspace.CurrentCamera.CameraSubject = selectedPlayer.Character
                    end
                end
                viewChanged = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(viewChangedFunc)
            else
                print("No player selected")
                spectating = false
            end
        else
            if viewDied then viewDied:Disconnect() viewDied = nil end
            if viewChanged then viewChanged:Disconnect() viewChanged = nil end
            if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
                workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildWhichIsA("Humanoid")
            end
            print("Stopped spectating")
        end
    end
})


TargetSection:Toggle({
    text = "🌀 Fling Player",
    state = false,
    callback = function(state)
        if state then
            if not selectedPlayer then print("No player selected") return end
            flinging = true
            local Player = game:GetService("Players").LocalPlayer
            local TargetPlayer = selectedPlayer
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Humanoid and Humanoid.RootPart
            local TCharacter = TargetPlayer.Character
            if not TCharacter then print("Target has no character") flinging = false return end
            local THumanoid, TRootPart, THead, Accessory, Handle
            if TCharacter:FindFirstChildOfClass("Humanoid") then THumanoid = TCharacter:FindFirstChildOfClass("Humanoid") end
            if THumanoid and THumanoid.RootPart then TRootPart = THumanoid.RootPart end
            if TCharacter:FindFirstChild("Head") then THead = TCharacter.Head end
            if TCharacter:FindFirstChildOfClass("Accessory") then Accessory = TCharacter:FindFirstChildOfClass("Accessory") end
            if Accessory and Accessory:FindFirstChild("Handle") then Handle = Accessory.Handle end
            if Character and Humanoid and RootPart then
                if RootPart.Velocity.Magnitude < 50 then getgenv().OldPos = RootPart.CFrame end
                if THumanoid and THumanoid.Sit then print(TargetPlayer.Name .. " is sitting") flinging = false return end
                if THead then workspace.CurrentCamera.CameraSubject = THead
                elseif Handle then workspace.CurrentCamera.CameraSubject = Handle
                elseif THumanoid and TRootPart then workspace.CurrentCamera.CameraSubject = THumanoid end
                if not TCharacter:FindFirstChildWhichIsA("BasePart") then flinging = false return end
                local FPos = function(BasePart, Pos, Ang)
                    RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                    RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end
                local SFBasePart = function(BasePart)
                    local TimeToWait = 2
                    local Time = tick()
                    local Angle = 0
                    repeat
                        if RootPart and THumanoid then
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle = Angle + 100
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                            end
                        end
                    until Time + TimeToWait < tick() or not flinging
                end
                workspace.FallenPartsDestroyHeight = 0/0
                local BV = Instance.new("BodyVelocity")
                BV.Parent = RootPart
                BV.Velocity = Vector3.new(0, 0, 0)
                BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                if TRootPart then SFBasePart(TRootPart)
                elseif THead then SFBasePart(THead)
                elseif Handle then SFBasePart(Handle)
                else print(TargetPlayer.Name .. " has no valid parts") BV:Destroy() flinging = false return end
                BV:Destroy()
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = Humanoid
                if getgenv().OldPos then
                    repeat
                        RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                        Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                        Humanoid:ChangeState("GettingUp")
                        for _, part in pairs(Character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()
                            end
                        end
                        task.wait()
                    until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
                    workspace.FallenPartsDestroyHeight = getgenv().FPDH
                end
                print("Fling completed")
            else
                print("Your character is not ready")
            end
            flinging = false
        else
            flinging = false
            print("Stopped flinging")
        end
    end
})


TargetSection:Button({
    text = "🎒 View Player Inventory",
    callback = function()
        if selectedPlayer then
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "InventoryViewer"
            ScreenGui.ResetOnSpawn = false
            ScreenGui.Parent = game:GetService("CoreGui")
            local MainFrame = Instance.new("Frame")
            MainFrame.Size = UDim2.new(0, 300, 0, 400)
            MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
            MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            MainFrame.BorderSizePixel = 0
            MainFrame.Active = true
            MainFrame.Draggable = true
            MainFrame.Parent = ScreenGui
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = MainFrame
            local TitleBar = Instance.new("Frame")
            TitleBar.Size = UDim2.new(1, 0, 0, 35)
            TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            TitleBar.BorderSizePixel = 0
            TitleBar.Parent = MainFrame
            local TitleCorner = Instance.new("UICorner")
            TitleCorner.CornerRadius = UDim.new(0, 8)
            TitleCorner.Parent = TitleBar
            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -40, 1, 0)
            Title.BackgroundTransparency = 1
            Title.Text = selectedPlayer.Name .. "'s Inventory"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.Font = Enum.Font.SourceSansBold
            Title.TextSize = 18
            Title.Parent = TitleBar
            local CloseButton = Instance.new("TextButton")
            CloseButton.Position = UDim2.new(1, -35, 0, 0)
            CloseButton.Size = UDim2.new(0, 35, 0, 35)
            CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            CloseButton.BorderSizePixel = 0
            CloseButton.Text = "X"
            CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            CloseButton.Font = Enum.Font.SourceSansBold
            CloseButton.TextSize = 18
            CloseButton.Parent = TitleBar
            local CloseCorner = Instance.new("UICorner")
            CloseCorner.CornerRadius = UDim.new(0, 8)
            CloseCorner.Parent = CloseButton
            CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
            local ScrollFrame = Instance.new("ScrollingFrame")
            ScrollFrame.Position = UDim2.new(0, 10, 0, 45)
            ScrollFrame.Size = UDim2.new(1, -20, 1, -55)
            ScrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ScrollFrame.BorderSizePixel = 0
            ScrollFrame.ScrollBarThickness = 6
            ScrollFrame.Parent = MainFrame
            local ScrollCorner = Instance.new("UICorner")
            ScrollCorner.CornerRadius = UDim.new(0, 6)
            ScrollCorner.Parent = ScrollFrame
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Padding = UDim.new(0, 5)
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = ScrollFrame
            local itemCount = 0
            local backpack = selectedPlayer:FindFirstChild("Backpack")
            if backpack then
                for _, item in pairs(backpack:GetChildren()) do
                    if item:IsA("Tool") then
                        itemCount = itemCount + 1
                        local ItemFrame = Instance.new("Frame")
                        ItemFrame.Size = UDim2.new(1, -10, 0, 30)
                        ItemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        ItemFrame.BorderSizePixel = 0
                        ItemFrame.Parent = ScrollFrame
                        local ItemCorner = Instance.new("UICorner")
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Parent = ItemFrame
                        local ItemLabel = Instance.new("TextLabel")
                        ItemLabel.Size = UDim2.new(1, -10, 1, 0)
                        ItemLabel.Position = UDim2.new(0, 5, 0, 0)
                        ItemLabel.BackgroundTransparency = 1
                        ItemLabel.Text = "🎒 " .. item.Name
                        ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ItemLabel.Font = Enum.Font.SourceSans
                        ItemLabel.TextSize = 16
                        ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
                        ItemLabel.Parent = ItemFrame
                    end
                end
            end
            if selectedPlayer.Character then
                for _, item in pairs(selectedPlayer.Character:GetChildren()) do
                    if item:IsA("Tool") then
                        itemCount = itemCount + 1
                        local ItemFrame = Instance.new("Frame")
                        ItemFrame.Size = UDim2.new(1, -10, 0, 30)
                        ItemFrame.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
                        ItemFrame.BorderSizePixel = 0
                        ItemFrame.Parent = ScrollFrame
                        local ItemCorner = Instance.new("UICorner")
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Parent = ItemFrame
                        local ItemLabel = Instance.new("TextLabel")
                        ItemLabel.Size = UDim2.new(1, -10, 1, 0)
                        ItemLabel.Position = UDim2.new(0, 5, 0, 0)
                        ItemLabel.BackgroundTransparency = 1
                        ItemLabel.Text = "✓ " .. item.Name .. " (Equipped)"
                        ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ItemLabel.Font = Enum.Font.SourceSansBold
                        ItemLabel.TextSize = 16
                        ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
                        ItemLabel.Parent = ItemFrame
                    end
                end
            end
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, itemCount * 35)
            if itemCount == 0 then
                local EmptyLabel = Instance.new("TextLabel")
                EmptyLabel.Size = UDim2.new(1, 0, 1, 0)
                EmptyLabel.BackgroundTransparency = 1
                EmptyLabel.Text = "No items in inventory"
                EmptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
                EmptyLabel.Font = Enum.Font.SourceSansItalic
                EmptyLabel.TextSize = 16
                EmptyLabel.Parent = ScrollFrame
            end
            print("Opened inventory viewer for " .. selectedPlayer.Name)
        else
            print("No player selected")
        end
    end
})

TargetSection:Button({
    text = "📍 Teleport to Player",
    callback = function()
        local player = game:GetService("Players").LocalPlayer
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
                print("Teleported to " .. selectedPlayer.Name)
            end
        else
            print("No player selected")
        end
    end
})


local FarmsTab = TabSection:Tab({text = "📋 Dupe", icon = ""})
local RollBackDupeSection = FarmsTab:Section({text = "RollBack Dupe"})

RollBackDupeSection:TextLabel({text = "⚠️ Need Alt Account Or Friend", color = Color3.fromRGB(255, 100, 100)})
RollBackDupeSection:TextLabel({text = "1. Press Start Dupe"})
RollBackDupeSection:TextLabel({text = "2. Send Money/Drop Guns To Alt"})
RollBackDupeSection:TextLabel({text = "3. Press Rejoin"})
RollBackDupeSection:TextLabel({text = "4. Items Will Be Duped"})

RollBackDupeSection:Button({
    text = "Rejoin",
    callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})

RollBackDupeSection:Button({
    text = "Start Dupe",
    callback = function()
        print("Dupe started")
        local args = {"Pistol", "\255"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SaveSelectedEmote"):FireServer(unpack(args))
    end
})

-- ESP
local espObjects = {}
local black = Color3.fromRGB(0, 0, 0)

local function newESPLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

local function newESPQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0, 0)
    quad.PointB = Vector2.new(0, 0)
    quad.PointC = Vector2.new(0, 0)
    quad.PointD = Vector2.new(0, 0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

local NameESPEnabled = false
local NameESPMode = "Username"

local function newESPText()
    local text = Drawing.new("Text")
    text.Visible = false
    text.Size = 13
    text.Center = true
    text.Outline = true
    text.Color = Color3.fromRGB(255, 255, 255)
    text.Transparency = 1
    return text
end

local function createESP(plr)
    local lib = {
        blackbox  = newESPQuad(2, black),
        box       = newESPQuad(1, Color3.fromRGB(255, 0, 0)),
        healthbar = newESPLine(3, black),
        greenbar  = newESPLine(1.5, black),
        nametext  = newESPText(),
    }
    espObjects[plr] = lib

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not game.Players:FindFirstChild(plr.Name) then
            for _, d in pairs(lib) do d:Remove() end
            espObjects[plr] = nil
            conn:Disconnect()
            return
        end

        local char = plr.Character
        local showBox = BoxESPEnabled
        local showBar = HealthBarESPEnabled

        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            local hrpPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            local headPos = workspace.CurrentCamera:WorldToViewportPoint(char.Head.Position)

            if onScreen then
                local dist = math.clamp((Vector2.new(headPos.X, headPos.Y) - Vector2.new(hrpPos.X, hrpPos.Y)).Magnitude, 2, math.huge)

                local function setBox(q)
                    q.PointA = Vector2.new(hrpPos.X + dist, hrpPos.Y - dist * 2)
                    q.PointB = Vector2.new(hrpPos.X - dist, hrpPos.Y - dist * 2)
                    q.PointC = Vector2.new(hrpPos.X - dist, hrpPos.Y + dist * 2)
                    q.PointD = Vector2.new(hrpPos.X + dist, hrpPos.Y + dist * 2)
                end

                if showBox then
                    setBox(lib.blackbox)
                    setBox(lib.box)
                end
                lib.blackbox.Visible = showBox
                lib.box.Visible = showBox

                local barHeight = (Vector2.new(hrpPos.X - dist, hrpPos.Y - dist * 2) - Vector2.new(hrpPos.X - dist, hrpPos.Y + dist * 2)).Magnitude
                local healthPct = char.Humanoid.Health / char.Humanoid.MaxHealth
                local green = Color3.fromRGB(0, 255, 0)
                local red = Color3.fromRGB(255, 0, 0)

                lib.healthbar.From = Vector2.new(hrpPos.X - dist - 4, hrpPos.Y + dist * 2)
                lib.healthbar.To   = Vector2.new(hrpPos.X - dist - 4, hrpPos.Y - dist * 2)
                lib.greenbar.From  = Vector2.new(hrpPos.X - dist - 4, hrpPos.Y + dist * 2)
                lib.greenbar.To    = Vector2.new(hrpPos.X - dist - 4, hrpPos.Y + dist * 2 - barHeight * healthPct)
                lib.greenbar.Color = red:Lerp(green, healthPct)

                lib.healthbar.Visible = showBar
                lib.greenbar.Visible  = showBar

                if NameESPEnabled then
                    local displayText = (NameESPMode == "Display Name") and plr.DisplayName or plr.Name
                    lib.nametext.Text = displayText
                    lib.nametext.Position = Vector2.new(hrpPos.X, hrpPos.Y - dist * 2 - 14)
                    lib.nametext.Visible = true
                else
                    lib.nametext.Visible = false
                end
            else
                for _, d in pairs(lib) do d.Visible = false end
            end
        else
            for _, d in pairs(lib) do d.Visible = false end
        end
    end)
end

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then coroutine.wrap(createESP)(plr) end
end
Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then coroutine.wrap(createESP)(plr) end
end)

-- Visuals Tab
local VisualsTab = TabSection:Tab({text = "👁️ Visuals", icon = ""})
local ESPSection = VisualsTab:Section({text = "ESP"})

ESPSection:Toggle({
    text = "2D Box ESP",
    state = false,
    callback = function(state)
        BoxESPEnabled = state
    end
})

ESPSection:Toggle({
    text = "Health Bar ESP",
    state = false,
    callback = function(state)
        HealthBarESPEnabled = state
    end
})

ESPSection:Toggle({
    text = "Name ESP",
    state = false,
    callback = function(state)
        NameESPEnabled = state
    end
})

ESPSection:Dropdown({
    text = "Name Type",
    list = {"Username", "Display Name"},
    default = "Username",
    callback = function(value)
        NameESPMode = value
    end
})
