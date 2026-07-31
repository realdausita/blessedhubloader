repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/WindUI"))()

local Skyboxes = {
    ['--'] = {},
    Galaxy = {
        SkyboxBk = 'rbxassetid://159454299',
        SkyboxDn = 'rbxassetid://159454296',
        SkyboxFt = 'rbxassetid://159454293',
        SkyboxLf = 'rbxassetid://159454286',
        SkyboxRt = 'rbxassetid://159454300',
        SkyboxUp = 'rbxassetid://159454288'
    },
    Purple = {
        SkyboxBk = 'rbxassetid://570557514',
        SkyboxDn = 'rbxassetid://570557775',
        SkyboxFt = 'rbxassetid://570557559',
        SkyboxLf = 'rbxassetid://570557620',
        SkyboxRt = 'rbxassetid://570557672',
        SkyboxUp = 'rbxassetid://570557727'
    },
    ['Purple Night'] = {
        SkyboxBk = 'rbxassetid://296908715',
        SkyboxDn = 'rbxassetid://296908724',
        SkyboxFt = 'rbxassetid://296908740',
        SkyboxLf = 'rbxassetid://296908755',
        SkyboxRt = 'rbxassetid://296908764',
        SkyboxUp = 'rbxassetid://296908769'
    },
    ['Night Sky'] = {
        SkyboxBk = 'rbxassetid://12064107',
        SkyboxDn = 'rbxassetid://12064152',
        SkyboxFt = 'rbxassetid://12064121',
        SkyboxLf = 'rbxassetid://12063984',
        SkyboxRt = 'rbxassetid://12064115',
        SkyboxUp = 'rbxassetid://12064131'
    },
    ['Pink Daylight'] = {
        SkyboxBk = 'rbxassetid://271042516',
        SkyboxDn = 'rbxassetid://271077243',
        SkyboxFt = 'rbxassetid://271042556',
        SkyboxLf = 'rbxassetid://271042310',
        SkyboxRt = 'rbxassetid://271042467',
        SkyboxUp = 'rbxassetid://271077958'
    },
    ['Morning Glow'] = {
        SkyboxBk = 'rbxassetid://1417494030',
        SkyboxDn = 'rbxassetid://1417494146',
        SkyboxFt = 'rbxassetid://1417494253',
        SkyboxLf = 'rbxassetid://1417494402',
        SkyboxRt = 'rbxassetid://1417494499',
        SkyboxUp = 'rbxassetid://1417494643'
    },
    ['Setting Sun'] = {
        SkyboxBk = 'rbxassetid://626460377',
        SkyboxDn = 'rbxassetid://626460216',
        SkyboxFt = 'rbxassetid://626460513',
        SkyboxLf = 'rbxassetid://626473032',
        SkyboxRt = 'rbxassetid://626458639',
        SkyboxUp = 'rbxassetid://626460625'
    },
    ['Fade Blue'] = {
        SkyboxBk = 'rbxassetid://153695414',
        SkyboxDn = 'rbxassetid://153695352',
        SkyboxFt = 'rbxassetid://153695452',
        SkyboxLf = 'rbxassetid://153695320',
        SkyboxRt = 'rbxassetid://153695383',
        SkyboxUp = 'rbxassetid://153695471'
    },
    ['Elegant Morning'] = {
        SkyboxBk = 'rbxassetid://153767241',
        SkyboxDn = 'rbxassetid://153767216',
        SkyboxFt = 'rbxassetid://153767266',
        SkyboxLf = 'rbxassetid://153767200',
        SkyboxRt = 'rbxassetid://153767231',
        SkyboxUp = 'rbxassetid://153767288'
    },
    Neptune = {
        SkyboxBk = 'rbxassetid://218955819',
        SkyboxDn = 'rbxassetid://218953419',
        SkyboxFt = 'rbxassetid://218954524',
        SkyboxLf = 'rbxassetid://218958493',
        SkyboxRt = 'rbxassetid://218957134',
        SkyboxUp = 'rbxassetid://218950090'
    },
    Redshift = {
        SkyboxBk = 'rbxassetid://401664839',
        SkyboxDn = 'rbxassetid://401664862',
        SkyboxFt = 'rbxassetid://401664960',
        SkyboxLf = 'rbxassetid://401664881',
        SkyboxRt = 'rbxassetid://401664901',
        SkyboxUp = 'rbxassetid://401664936'
    },
    ['Aesthetic Night'] = {
        SkyboxBk = 'rbxassetid://1045964490',
        SkyboxDn = 'rbxassetid://1045964368',
        SkyboxFt = 'rbxassetid://1045964655',
        SkyboxLf = 'rbxassetid://1045964655',
        SkyboxRt = 'rbxassetid://1045964655',
        SkyboxUp = 'rbxassetid://1045962969'
    }
}

local Lighting = game:GetService("Lighting")
local originalSky = Lighting:FindFirstChildOfClass("Sky")
if originalSky then
    originalSky = originalSky:Clone()
end

local isEnabled = false
local selectedSkybox = "--"

local function applySkybox(skyName)
    if not isEnabled then return end
    
    local skyData = Skyboxes[skyName]
    
    if not skyData or not skyData.SkyboxBk then
        local currentSky = Lighting:FindFirstChildOfClass("Sky")
        if currentSky then
            currentSky:Destroy()
        end
        if originalSky then
            originalSky:Clone().Parent = Lighting
        end
        return
    end

	local currentSky = Lighting:FindFirstChildOfClass("Sky")
    if not currentSky then
        currentSky = Instance.new("Sky")
        currentSky.Name = "CustomSkybox"
        currentSky.Parent = Lighting
    end

	currentSky.SkyboxBk = skyData.SkyboxBk
    currentSky.SkyboxDn = skyData.SkyboxDn
    currentSky.SkyboxFt = skyData.SkyboxFt
    currentSky.SkyboxLf = skyData.SkyboxLf
    currentSky.SkyboxRt = skyData.SkyboxRt
    currentSky.SkyboxUp = skyData.SkyboxUp
end

WindUI:AddTheme({
	Name = 'Dark',
	Accent = '#18181b',
	Dialog = '#18181b',
	Outline = '#FFFFFF',
	Text = '#FFFFFF',
	Placeholder = '#999999',
	Background = '#0e0e10',
	Button = '#52525b',
	Icon = '#a1a1aa',
})
WindUI:AddTheme({
	Name = 'Light',
	Accent = '#f4f4f5',
	Dialog = '#f4f4f5',
	Outline = '#000000',
	Text = '#000000',
	Placeholder = '#666666',
	Background = '#ffffff',
	Button = '#e4e4e7',
	Icon = '#52525b',
})
WindUI:AddTheme({
	Name = 'Gray',
	Accent = '#374151',
	Dialog = '#374151',
	Outline = '#d1d5db',
	Text = '#f9fafb',
	Placeholder = '#9ca3af',
	Background = '#1f2937',
	Button = '#4b5563',
	Icon = '#d1d5db',
})
WindUI:AddTheme({
	Name = 'Blue',
	Accent = '#1e40af',
	Dialog = '#1e3a8a',
	Outline = '#93c5fd',
	Text = '#f0f9ff',
	Placeholder = '#60a5fa',
	Background = '#1e293b',
	Button = '#3b82f6',
	Icon = '#93c5fd',
})
WindUI:AddTheme({
	Name = 'Green',
	Accent = '#059669',
	Dialog = '#047857',
	Outline = '#6ee7b7',
	Text = '#ecfdf5',
	Placeholder = '#34d399',
	Background = '#064e3b',
	Button = '#10b981',
	Icon = '#6ee7b7',
})
WindUI:AddTheme({
	Name = 'Red',
	Accent = '#991b1b',
	Dialog = '#991b1b',
	Outline = '#fecaca',
	Text = '#fef2f2',
	Placeholder = '#f87171',
	Background = '#450a0a',
	Button = '#dc2626',
	Icon = '#fecaca',
})
WindUI:AddTheme({
	Name = 'Rise',
	Accent = '#ff3131',
	Dialog = '#2a0505',
	Outline = '#5c0000',
	Text = '#ffffff',
	Placeholder = '#8c4a4a',
	Background = '#120000',
	Button = '#d00000',
	Icon = '#ff3131',
})

WindUI:SetNotificationLower(true)

local themes = {
	'Dark',
	'Light',
	'Gray',
	'Blue',
	'Green',
	'Red',
	'Rise',
}
local currentThemeIndex = 7

if not getgenv().TransparencyEnabled then
	getgenv().TransparencyEnabled = false
end

Window = WindUI:CreateWindow({
	Title = 'Rise',
	Icon = 'crown',
	Author = 'Evade',
	Folder = 'risehub',
	Size = UDim2.fromOffset(500, 240),
	Transparent = getgenv().TransparencyEnabled,
	Theme = 'Rise',
	Background = 'rbxassetid://77397718569947',
	Resizable = true,
	NewElements = true,
	CornerRadius = UDim.new(0, 0),
	SideBarWidth = 210,
	BackgroundImageTransparency = 0.8,
	HideSearchBar = false,
	ScrollBarEnabled = true,
	User = {
		Enabled = true,
		Anonymous = false,
		Callback = function()
			currentThemeIndex = currentThemeIndex + 1

			if currentThemeIndex > #themes then
				currentThemeIndex = 1
			end

			local newTheme = themes[currentThemeIndex]

			WindUI:SetTheme(newTheme)
			WindUI:Notify({
				Title = 'Theme Changed',
				Content = 'Switched to ' .. newTheme .. ' theme!',
				Duration = 2,
				Icon = 'palette',
			})
		end,
	},
})

Window:Tag({
	Title = 'NEO',
	Icon = 'crown',
	Color = Color3.fromHex('#FF0006'),
	Radius = 4,
})

pcall(function()
	Window:CreateTopbarButton('TransparencyToggle', 'eye', function()
		if getgenv().TransparencyEnabled then
			getgenv().TransparencyEnabled = false

			pcall(function()
				Window:ToggleTransparency(false)
			end)
			WindUI:Notify({
				Title = 'Transparency',
				Content = 'Transparency disabled',
				Duration = 3,
				Icon = 'eye',
			})
		else
			getgenv().TransparencyEnabled = true

			pcall(function()
				Window:ToggleTransparency(true)
			end)
			WindUI:Notify({
				Title = 'Transparency',
				Content = 'Transparency enabled',
				Duration = 3,
				Icon = 'eye-off',
			})
		end
	end, 990)
end)

Window:EditOpenButton({
	Title = 'Rise',
	CornerRadius = UDim.new(0, 6),
	StrokeThickness = 2,
	Color = ColorSequence.new(Color3.fromRGB(100, 0, 0), Color3.fromRGB(200, 0, 0)),
	Draggable = true,
	Enabled = true,
	OnlyMobile = false,
})

local function copyToClipboard(text)
	if setclipboard then
		setclipboard(text)
	elseif toclipboard then
		toclipboard(text)
	end
end

local InformationTab = Window:Tab({
	Title = "Information",
	Icon = "info",
	ShowTabTitle = true,
	Border = true
})

InformationTab:Paragraph({
	Title = "Credits",
	Desc = "This script fully made by hzshawde and dausita",
})

InformationTab:Button({
	Title = "Copy Discord Link",
	Desc = "Click to copy official Discord link to clipboard",
	Icon = "copy",
	Callback = function()
		copyToClipboard("https://discord.gg/risext")
		WindUI:Notify({
			Title = "Discord",
			Content = "Discord link copied to clipboard!",
			Duration = 3,
			Icon = "check"
		})
	end
})

local HomeTab = Window:Tab({
	Title = "Home",
	Icon = "house",
	ShowTabTitle = true,
	Border = true
})

local PlayerTab = Window:Tab({
	Title = "Players",
	Icon = "user-round",
	ShowTabTitle = true,
	Border = true
})

local MovementTab = Window:Tab({
	Title = "Movement",
	Icon = "person-standing",
	ShowTabTitle = true,
	Border = true
})

local VisualTab = Window:Tab({
	Title = "Visual",
	Icon = "eye",
	ShowTabTitle = true,
	Border = true
})

local FarmTab = Window:Tab({
	Title = "Farm",
	Icon = "circle-dollar-sign",
	ShowTabTitle = true,
	Border = true
})

Window:SelectTab(InformationTab)

HomeTab:Paragraph({
	Title = "Welcome to Rise Script",
	Desc = "Rise Script is back! A lot of people (probably just 5) asked for Rise Script to return, so we’ve released this special NEO version for you! (To be updated)",
})

HomeTab:Paragraph({
	Title = "WARNING",
	Desc = "Script isn't really recommended for PC users; for a better experience, try the paid script called WaveLine.",
})

HomeTab:Divider({})

HomeTab:Paragraph({
	Title = "Update Log",
	Desc = "Rise script is back vro",
})

local changePlayerMode = ReplicatedStorage:WaitForChild("Events", 5) and (ReplicatedStorage.Events:FindFirstChild("SetPlayerMode") or ReplicatedStorage.Events:FindFirstChild("changePlayerMode") or ReplicatedStorage.Events:FindFirstChild("CharacterTask"))

local CharacterTag
local CharacterService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Asset"):WaitForChild("CharacterService"))
local ServerStateRegistryService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Data"):WaitForChild("ServerStateRegistryService"))
local Movement = require(ReplicatedStorage.Objects.Game.Character.Client.Movement)
local ClientItemService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Items"):WaitForChild("ClientItemService"))

local SelfRevive = {
	Enabled = false,
	IsReviving = false,
	HasRevived = false,
	Method = "Spawnpoint",
	Connections = {},
	LastSavedPosition = nil
}

function SelfRevive:Respawn()
	local char = LocalPlayer.Character
	if not char or self.IsReviving then return end

	local charData = CharacterService:GetCharacterFromPlayer(LocalPlayer)
	local isDowned = charData and charData.DataRegistry and charData.DataRegistry:Get("Downed")
	if not isDowned then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	self.IsReviving = true

	if self.Method == "Spawnpoint" then
		if not self.HasRevived then
			self.HasRevived = true
			pcall(function()
				if changePlayerMode then
					changePlayerMode:FireServer(true)
				end
			end)
			task.delay(10, function()
				self.HasRevived = false
			end)
			task.delay(1, function()
				self.IsReviving = false
			end)
		else
			self.IsReviving = false
		end
	elseif self.Method == "Fake Revive" then
		local savedPos = nil
		if hrp then
			savedPos = hrp.CFrame.Position
		end
		task.spawn(function()
			pcall(function()
				if changePlayerMode then
					changePlayerMode:FireServer(true)
				end
			end)
			local newCharacter
			repeat
				newCharacter = LocalPlayer.Character
				task.wait()
			until newCharacter and newCharacter:FindFirstChild("HumanoidRootPart") and newCharacter ~= char
			if newCharacter then
				local newHRP = newCharacter:FindFirstChild("HumanoidRootPart")
				if savedPos and newHRP then
					task.wait(0.1)
					newHRP.CFrame = CFrame.new(savedPos + Vector3.new(0, 0, 0))
				end
			end
			self.IsReviving = false
		end)
	end
end

function SelfRevive:Start()
	if self.Connections.Heartbeat then return end
	self.Enabled = true

	self.Connections.Heartbeat = RunService.Heartbeat:Connect(function()
		if not self.Enabled then return end
		local char = LocalPlayer.Character
		if not char then return end

		local charData = CharacterService:GetCharacterFromPlayer(LocalPlayer)
		if charData and charData.DataRegistry and charData.DataRegistry:Get("Downed") then
			self:Respawn()
		end
	end)

	self.Connections.Character = LocalPlayer.CharacterAdded:Connect(function(newChar)
		self.HasRevived = false
		self.IsReviving = false
		self.LastSavedPosition = nil
	end)
end

function SelfRevive:Stop()
	self.Enabled = false
	self.HasRevived = false
	self.IsReviving = false
	self.LastSavedPosition = nil

	for name, conn in pairs(self.Connections) do
		if conn then
			conn:Disconnect()
			self.Connections[name] = nil
		end
	end
end


PlayerTab:Space()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer

local CharacterService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Asset"):WaitForChild("CharacterService"))
local Movement = require(ReplicatedStorage.Objects.Game.Character.Client.Movement)
local ClientItemService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Items"):WaitForChild("ClientItemService"))

local currentSettings = {
	Speed = 1500,
	JumpHeight = 3,
	JumpCap = 1,
	JumpSpeedMultiplier = 1.45,
	AirStrafeAcceleration = 182,
	AirAcceleration = 1,
	SprintCap = 2,
	SprintAcceleration = 1,
	Friction = 5,
	RunAccel = 1,
	RunDeaccel = 700,
	WalkSpeedMultiplier = 1,
	GroundedDistCheck = 2.9
}

local function GetCharacterTag(character)
	if not character then return nil end
	local charData = CharacterService:GetCharacterFromPlayer(LocalPlayer)
	if charData and charData.Tag then
		return charData.Tag
	end
	return character.Name
end

local fireSignalFunc = firesignal or function(signal, ...)
	if signal and typeof(signal) == "RBXScriptSignal" then
		for _, connection in ipairs(getconnections(signal)) do
			connection:Fire(...)
		end
	end
end

local defaultMovementValues = {
	SprintAcceleration = 1,
	SprintCap = 2,
	RunAccel = 1,
	Friction = 5,
	RunDeaccel = 700,
	AirStrafeAcceleration = 182,
	AirAcceleration = 1,
	Speed = 1500,
	JumpHeight = 3,
	JumpCap = 1,
	WalkSpeedMultiplier = 1,
	JumpSpeedMultiplier = 1.45,
	BhopEnabled = false,
	GroundedDistCheck = 2.9
}

local infiniteSlide = false
local slideFriction = -8
local emoteSpeedEnabled = false
local emoteSpeedType = "Blatant"
local emoteSpeedValue = 1000
local emoteAccelerationValue = -2
local AutowallHop = false
local autoJumpEnabled = false
local autoJumpType = "Simulation"
local bhopHoldEnabled = false
local accelerationMethod = "Acceleration"
local accelerationValue = -0.2
local autoAccelerationEnabled = false
local maxAcceleration = 3
local minAcceleration = -1
local maxAutoAccelSpeed = 70

local function getCurrentSpeed(character)
	if not character then return 0 end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return 0 end
	for _, child in ipairs(hrp:GetChildren()) do
		if child:IsA("LinearVelocity") and child.Name:find("LinearVelocity") then
			local pv = child.PlaneVelocity
			return (pv.X * pv.X + pv.Y * pv.Y) ^ 0.5
		end
	end
	local velocity = hrp.AssemblyLinearVelocity
	return (velocity.X * velocity.X + velocity.Z * velocity.Z) ^ 0.5
end

function MovementValueSet(MovementType, value)
	local tag = GetCharacterTag(LocalPlayer.Character)
	if not tag then return end

	pcall(function()
		fireSignalFunc(ReplicatedStorage.Events.CharacterTask.OnClientEvent, 
			tag,
			"ModifyMovement",
			{
				MovementType,
				value
			}
		)
	end)
end

local function applySettingsToNewCharacter(retries)
	retries = retries or 0
	if retries > 15 then return end

	local tag = GetCharacterTag(LocalPlayer.Character)
	if tag then
		task.wait(0.2)
		for key, val in pairs(currentSettings) do
			if val ~= nil then
				MovementValueSet(key, val)
			end
		end
	else
		task.delay(0.2, function()
			applySettingsToNewCharacter(retries + 1)
		end)
	end
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
	newChar:WaitForChild("Humanoid")
	applySettingsToNewCharacter(0)
end)

if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
	applySettingsToNewCharacter(0)
end

local originalRegistry = Movement.RegistryTermUpdated
Movement.RegistryTermUpdated = function(self, term)
	if term == "Emote" then
		local id = self.DataRegistry:Get("Emote")
		if id and id ~= 0 then
			local item = ClientItemService:GetItemFromID(id)
			local mult = item and (require(item).EmoteInfo or {}).SpeedMult or 1
			if emoteSpeedEnabled and emoteSpeedType == "Blatant" then
				self.MoveStats:SpeedChange("Emote", mult * (emoteSpeedValue / 1000))
			else
				self.MoveStats:SpeedChange("Emote", mult)
			end
		else
			self.MoveStats:SpeedChange("Emote", nil)
		end
		return
	end
	originalRegistry(self, term)
end

local originalMovementUpdate = Movement.Update
local lastFriction = nil

Movement.Update = function(self, ...)
	originalMovementUpdate(self, ...)
	local humanoid = self.Character and self.Character:FindFirstChild("Humanoid")
	if not humanoid then return end

	local LocalPlayerData = CharacterService:GetCharacterFromPlayer(LocalPlayer)
	local movementData = LocalPlayerData and LocalPlayerData.Movement
	local state = movementData and movementData.State
	if not state then
		state = self.State
	end

	local grounded = self.DataRegistry:Get("Grounded")
	local desiredFriction = nil
	local isInfSlide = (state == "Slide" or state == "EmotingSlide" or state == "CarrySlide")
	local isEmoteSlideAccel = (state == "EmotingSlide")

	if isInfSlide and infiniteSlide then
		desiredFriction = slideFriction
	end

	if isEmoteSlideAccel and emoteSpeedEnabled and emoteSpeedType == "Legit" then
		desiredFriction = emoteAccelerationValue
	end

	if desiredFriction == nil and accelerationMethod == "Acceleration" then
		local isBhopActive = autoJumpEnabled or (bhopHoldEnabled and humanoid.Jump == true)
		if isBhopActive and not grounded then
			local currentSpeed = getCurrentSpeed(self.Character)
			if autoAccelerationEnabled then
				if currentSpeed > maxAutoAccelSpeed then
					desiredFriction = maxAcceleration
				elseif currentSpeed < maxAutoAccelSpeed then
					desiredFriction = minAcceleration
				else
					desiredFriction = accelerationValue
				end
			else
				desiredFriction = accelerationValue
			end
		end
	end

	if desiredFriction ~= lastFriction then
		if desiredFriction ~= nil then
			MovementValueSet("Friction", desiredFriction)
		else
			MovementValueSet("Friction", currentSettings.Friction or defaultMovementValues.Friction)
		end
		lastFriction = desiredFriction
	end

	if (state == "WallrunRight" or state == "WallrunLeft") and AutowallHop then
		self:AttemptJump()
	end

	if autoJumpEnabled and grounded then
		if autoJumpType == "Realistic" then
			self:AttemptJump()
		else
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end

	if bhopHoldEnabled and grounded and humanoid.Jump == true then
		self:AttemptJump()
	end
end

function ToggleEmoteSpeed(state)
	emoteSpeedEnabled = state
	local currentEmoteId = Movement.DataRegistry:Get("Emote")
	if currentEmoteId and currentEmoteId ~= 0 then
		Movement.RegistryTermUpdated(Movement, "Emote")
	end
end

function ToggleInfiniteSlide(state)
	infiniteSlide = state
end

PlayerTab:Section({Title="Modification"})

BaseSpeedInput = PlayerTab:Input({
	Title="Speed", 
	Placeholder="1500", 
	NumbersOnly=true, 
	Value="1500",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.Speed = val
		MovementValueSet("Speed", val)
	end
})

PlayerTab:Space()

JumpHeightInput = PlayerTab:Input({
	Title="Jump height", 
	Placeholder="3", 
	NumbersOnly=true, 
	Value="3",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.JumpHeight = val
		MovementValueSet("JumpHeight", val)
	end
})

JumpCapInput = PlayerTab:Input({
	Title="Jump Cap", 
	Placeholder="1", 
	NumbersOnly=true, 
	Value="1",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.JumpCap = val
		MovementValueSet("JumpCap", val)
	end
})

JumpSpeedMultiplierInput = PlayerTab:Input({
	Title="Jump Speed Multiplier", 
	Placeholder="1.45", 
	NumbersOnly=true, 
	Value="1.45",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.JumpSpeedMultiplier = val
		MovementValueSet("JumpSpeedMultiplier", val)
	end
})

PlayerTab:Space()

AirStrafeAccelerationInput = PlayerTab:Input({
	Title="Air Strafe Acceleration", 
	Placeholder="182", 
	NumbersOnly=true, 
	Value="182",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.AirStrafeAcceleration = val
		MovementValueSet("AirStrafeAcceleration", val)
	end
})

AirAccelerationInput = PlayerTab:Input({
	Title="Air Acceleration", 
	Placeholder="1", 
	NumbersOnly=true, 
	Value="1",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.AirAcceleration = val
		MovementValueSet("AirAcceleration", val)
	end
})

PlayerTab:Space()

SprintCapInput = PlayerTab:Input({
	Title="Sprint Cap", 
	Placeholder="2", 
	NumbersOnly=true, 
	Value="2",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.SprintCap = val
		MovementValueSet("SprintCap", val)
	end
})

SprintAccelerationInput = PlayerTab:Input({
	Title="Sprint Acceleration", 
	Placeholder="1", 
	NumbersOnly=true, 
	Value="1",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.SprintAcceleration = val
		MovementValueSet("SprintAcceleration", val)
	end
})

PlayerTab:Space()

FrictionInput = PlayerTab:Input({
	Title="Friction", 
	Placeholder="5", 
	NumbersOnly=true, 
	Value="5",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.Friction = val
		MovementValueSet("Friction", val)
	end
})

RunAccelInput = PlayerTab:Input({
	Title="Run Acceleration", 
	Placeholder="1", 
	NumbersOnly=true, 
	Value="1",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.RunAccel = val
		MovementValueSet("RunAccel", val)
	end
})

RunDeaccelInput = PlayerTab:Input({
	Title="Run Deacceleration", 
	Placeholder="700", 
	NumbersOnly=true, 
	Value="700",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.RunDeaccel = val
		MovementValueSet("RunDeaccel", val)
	end
})

WalkSpeedMultiplierInput = PlayerTab:Input({
	Title="Walk Speed Multiplier", 
	Placeholder="1", 
	NumbersOnly=true, 
	Value="1",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.WalkSpeedMultiplier = val
		MovementValueSet("WalkSpeedMultiplier", val)
	end
})

GroundedDistCheckInput = PlayerTab:Input({
	Title="Grounded Dist Check", 
	Placeholder="2.9", 
	NumbersOnly=true, 
	Value="2.9",
	Callback = function(value)
		local val = tonumber(value)
		currentSettings.GroundedDistCheck = val
		MovementValueSet("GroundedDistCheck", val)
	end
})

MovementTab:Section({ Title = "Infinite Slide" })

InfiniteSlideToggle = MovementTab:Toggle({
	Title = "Infinite Slide",
	Value = false,
	Callback = function(state)
		ToggleInfiniteSlide(state)
	end
})

MovementTab:Space()

MovementTab:Section({ Title = "Emote Speed" })

EmoteSpeedToggle = MovementTab:Toggle({
	Title = "Enable Emote Speed",
	Value = false,
	Callback = function(v)
		ToggleEmoteSpeed(v)
		fireSignalFunc(ReplicatedStorage.Events.SharedUISetType.OnClientEvent, 
			"Notification",
			"Announcement",
			{
				Type = "commandString",
				Global = true,
				Brackets = {},
				Sender = dausita,
				String = "Your Emote Speed Is Updated Re-Emote To Use It"
			}
		)
	end
})

EmoteSpeedType = MovementTab:Dropdown({
	Title = "Emote Speed Type",
	Values = { "Blatant", "Legit" },
	Value = "Blatant",
	Callback = function(value)
		emoteSpeedType = value
		if emoteSpeedEnabled then
			fireSignalFunc(ReplicatedStorage.Events.SharedUISetType.OnClientEvent, 
				"Notification",
				"Announcement",
				{
					Type = "commandString",
					Global = true,
					Brackets = {},
					Sender = 6065839964,
					String = "Your Speed has been modified successfully! Restart your emote to take effective"
				}
			)
		end
	end
})

EmoteSpeedInput = MovementTab:Input({
	Title = "Emote Speed Value",
	Placeholder = "1000",
	NumbersOnly = true,
	Value = "1000",
	Callback = function(v)
		emoteSpeedValue = tonumber(v) or 1000
		if emoteSpeedEnabled then
			fireSignalFunc(ReplicatedStorage.Events.SharedUISetType.OnClientEvent, 
				"Notification",
				"Announcement",
				{
					Type = "commandString",
					Global = true,
					Brackets = {},
					Sender = 6065839964,
					String = "Your Speed has been modified successfully! Restart your emote to take effective"
				}
			)
		end
	end
})

EmoteAccelerationInput = MovementTab:Input({
	Title = "Emote Acceleration (Negative Only)",
	Desc = "Negative Only",
	Placeholder = "-2",
	NumbersOnly = true,
	Value = "-2",
	Callback = function(v)
		emoteAccelerationValue = tonumber(v) or -2
	end
})

MovementTab:Space()

ResetEmoteSpeedButton = MovementTab:Button({
	Title = "Reset Emote Speed",
	Desc = "Having Trouble? Reset the speed or rejoin",
	Callback = function()
		emoteSpeedValue = 1000
		emoteAccelerationValue = -2
		emoteSpeedType = "Blatant"
		if EmoteSpeedInput then EmoteSpeedInput:Set("1000") end
		if EmoteAccelerationInput then EmoteAccelerationInput:Set("-2") end
		if EmoteSpeedType then EmoteSpeedType:Select("Blatant") end
	end
})

local TimerGUI = nil
local TimerEnabled = false
local SpecialRoundEnabled = false
local CurrentSpecialRoundName = ""
local OriginalTimerVisible = false
local CheckingGameTimer = false
local _attributeConnection = nil
local _attributeConnection2 = nil
local _attributeConnection3 = nil

local function createTimerGUI()
	local RoundTimerTemplate = ReplicatedStorage.Assets.UI.Game.HUD.Overlay.RoundOverlay.RoundTimer.RoundTimer
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "TimerGUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = PlayerGui

	local Timer = Instance.new("Frame")
	Timer.Name = "Timer"
	Timer.BackgroundTransparency = 1
	Timer.Size = UDim2.new(1, 0, 1, 0)
	Timer.Parent = ScreenGui

	local Top = Instance.new("Frame")
	Top.Name = "Top"
	Top.AnchorPoint = Vector2.new(0.5, 0)
	Top.BackgroundTransparency = 1
	Top.Position = UDim2.new(0.5, 0, 0, 0)
	Top.Size = UDim2.new(1, 0, 1, 0)
	Top.Parent = Timer

	local AspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	AspectRatioConstraint.Parent = Top

	local SizeConstraint = Instance.new("UISizeConstraint")
	SizeConstraint.MaxSize = Vector2.new(900, 900)
	SizeConstraint.Parent = Top

	local MainTimer = RoundTimerTemplate:Clone()
	MainTimer.Name = "MainTimer"
	MainTimer.AnchorPoint = Vector2.new(0.5, 0)
	MainTimer.Position = UDim2.new(0.5, 0, 0.04, 0)
	MainTimer.Size = UDim2.new(0.25, 0, 0.1, 0)
	MainTimer.Parent = Top
	MainTimer.Visible = false

	local TimeDisplay = MainTimer:FindFirstChild("Timer")
	if not TimeDisplay then
		TimeDisplay = Instance.new("TextLabel")
		TimeDisplay.Name = "Timer"
		TimeDisplay.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TimeDisplay.Text = "0:00"
		TimeDisplay.TextColor3 = Color3.fromRGB(165, 194, 255)
		TimeDisplay.TextScaled = true
		TimeDisplay.TextSize = 14
		TimeDisplay.TextStrokeTransparency = 0.95
		TimeDisplay.TextWrapped = true
		TimeDisplay.AnchorPoint = Vector2.new(0.5, 0.5)
		TimeDisplay.BackgroundTransparency = 1
		TimeDisplay.Position = UDim2.new(0.5, 0, 0.65, 0)
		TimeDisplay.Size = UDim2.new(0.5, 0, 0.5, 0)
		TimeDisplay.ZIndex = 3
		TimeDisplay.Parent = MainTimer
		local TimeStroke = Instance.new("UIStroke")
		TimeStroke.Thickness = 3
		TimeStroke.Transparency = 0.7
		TimeStroke.Parent = TimeDisplay
		local TimeGradient = Instance.new("UIGradient")
		TimeGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194))
		})
		TimeGradient.Rotation = 90
		TimeGradient.Parent = TimeDisplay
	end

	local StatusLabel = MainTimer:FindFirstChild("About")
	if not StatusLabel then
		StatusLabel = Instance.new("TextLabel")
		StatusLabel.Name = "About"
		StatusLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		StatusLabel.Text = "ROUND ACTIVE"
		StatusLabel.TextColor3 = Color3.fromRGB(165, 194, 255)
		StatusLabel.TextScaled = true
		StatusLabel.TextSize = 14
		StatusLabel.TextStrokeTransparency = 0.95
		StatusLabel.TextWrapped = true
		StatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		StatusLabel.BackgroundTransparency = 1
		StatusLabel.Position = UDim2.new(0.5, 0, 0.25, 0)
		StatusLabel.Size = UDim2.new(0.8, 0, 0.25, 0)
		StatusLabel.ZIndex = 3
		StatusLabel.Parent = MainTimer
		local StatusStroke = Instance.new("UIStroke")
		StatusStroke.Thickness = 2
		StatusStroke.Transparency = 0.7
		StatusStroke.Parent = StatusLabel
		local StatusGradient = Instance.new("UIGradient")
		StatusGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194))
		})
		StatusGradient.Rotation = 90
		StatusGradient.Parent = StatusLabel
	end

	local MainTimerStroke = MainTimer:FindFirstChildOfClass("UIStroke")
	if not MainTimerStroke then
		MainTimerStroke = Instance.new("UIStroke")
		MainTimerStroke.Transparency = 0.8
		MainTimerStroke.Parent = MainTimer
	end

	local MainTimerImage = MainTimer:FindFirstChildOfClass("ImageLabel")
	if not MainTimerImage then
		MainTimerImage = Instance.new("ImageLabel")
		MainTimerImage.Name = "Background"
		MainTimerImage.Image = "rbxassetid://196969716"
		MainTimerImage.ImageColor3 = Color3.fromRGB(21, 21, 21)
		MainTimerImage.ImageTransparency = 0.7
		MainTimerImage.AnchorPoint = Vector2.new(0.5, 0.5)
		MainTimerImage.BackgroundTransparency = 1
		MainTimerImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainTimerImage.Size = UDim2.new(1, 0, 1, 0)
		MainTimerImage.ZIndex = 0
		MainTimerImage.Parent = MainTimer
		local MainTimerImageCorner = Instance.new("UICorner")
		MainTimerImageCorner.CornerRadius = UDim.new(0, 4)
		MainTimerImageCorner.Parent = MainTimerImage
	end

	local SpecialRound = Instance.new("Frame")
	SpecialRound.Name = "SpecialRound"
	SpecialRound.AnchorPoint = Vector2.new(0.5, 0)
	SpecialRound.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SpecialRound.BackgroundTransparency = 0.6
	SpecialRound.BorderSizePixel = 0
	SpecialRound.Position = UDim2.new(0.5, 0, 0.15, 0)
	SpecialRound.Size = UDim2.new(0.23, 0, 0.05, 0)
	SpecialRound.Parent = Top
	SpecialRound.Visible = false

	local SpecialRoundLabel = Instance.new("TextLabel")
	SpecialRoundLabel.Name = "Label"
	SpecialRoundLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	SpecialRoundLabel.Text = "No Data"
	SpecialRoundLabel.TextColor3 = Color3.fromRGB(255, 208, 115)
	SpecialRoundLabel.TextScaled = true
	SpecialRoundLabel.TextSize = 14
	SpecialRoundLabel.TextStrokeTransparency = 0.95
	SpecialRoundLabel.TextWrapped = true
	SpecialRoundLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	SpecialRoundLabel.BackgroundTransparency = 1
	SpecialRoundLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	SpecialRoundLabel.Size = UDim2.new(0.9, 0, 0.6, 0)
	SpecialRoundLabel.ZIndex = 3
	SpecialRoundLabel.Parent = SpecialRound

	local SpecialRoundStroke = Instance.new("UIStroke")
	SpecialRoundStroke.Thickness = 2
	SpecialRoundStroke.Transparency = 0.7
	SpecialRoundStroke.Parent = SpecialRoundLabel

	local SpecialRoundEmptyFrame = Instance.new("Frame")
	SpecialRoundEmptyFrame.AnchorPoint = Vector2.new(0, 0.5)
	SpecialRoundEmptyFrame.BackgroundTransparency = 1
	SpecialRoundEmptyFrame.Position = UDim2.new(0.775, 0, 0.6, 0)
	SpecialRoundEmptyFrame.Size = UDim2.new(0.225, 0, 0.45, 0)
	SpecialRoundEmptyFrame.Parent = SpecialRound

	local SpecialRoundListLayout = Instance.new("UIListLayout")
	SpecialRoundListLayout.FillDirection = Enum.FillDirection.Horizontal
	SpecialRoundListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	SpecialRoundListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SpecialRoundListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	SpecialRoundListLayout.Parent = SpecialRoundEmptyFrame

	local SpecialRoundCorner = Instance.new("UICorner")
	SpecialRoundCorner.CornerRadius = UDim.new(0, 4)
	SpecialRoundCorner.Parent = SpecialRound

	local SpecialRoundBackground = Instance.new("ImageLabel")
	SpecialRoundBackground.Name = "Background"
	SpecialRoundBackground.Image = "rbxassetid://196969716"
	SpecialRoundBackground.ImageColor3 = Color3.fromRGB(21, 21, 21)
	SpecialRoundBackground.ImageTransparency = 0.7
	SpecialRoundBackground.AnchorPoint = Vector2.new(0.5, 0.5)
	SpecialRoundBackground.BackgroundTransparency = 1
	SpecialRoundBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
	SpecialRoundBackground.Size = UDim2.new(1, 0, 1, 0)
	SpecialRoundBackground.ZIndex = 0
	SpecialRoundBackground.Parent = SpecialRound

	local SpecialRoundBackgroundCorner = Instance.new("UICorner")
	SpecialRoundBackgroundCorner.CornerRadius = UDim.new(0, 4)
	SpecialRoundBackgroundCorner.Parent = SpecialRoundBackground

	local SpecialRoundUIStroke = Instance.new("UIStroke")
	SpecialRoundUIStroke.Transparency = 0.8
	SpecialRoundUIStroke.Parent = SpecialRound

	return {
		ScreenGui = ScreenGui,
		TimeDisplay = TimeDisplay,
		SpecialRoundLabel = SpecialRoundLabel,
		StatusLabel = StatusLabel,
		MainTimer = MainTimer,
		SpecialRound = SpecialRound,
		MainTimerStroke = MainTimerStroke,
		MainTimerImage = MainTimerImage
	}
end

local function stopGameTimerCheck()
	CheckingGameTimer = false
	if TimerGUI then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
	end
end

local function checkGameTimerVisibility()
	if not TimerEnabled or not TimerGUI then
		if TimerGUI then TimerGUI.MainTimer.Visible = false end
		return
	end

	local hud = PlayerGui:FindFirstChild("Shared")
	if not hud then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	hud = hud:FindFirstChild("HUD")
	if not hud then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	hud = hud:FindFirstChild("Overlay")
	if not hud then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	hud = hud:FindFirstChild("Default")
	if not hud then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	hud = hud:FindFirstChild("RoundOverlay")
	if not hud then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	hud = hud:FindFirstChild("Round")
	if not hud then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	local roundTimer = hud:FindFirstChild("RoundTimer")
	if not roundTimer then
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
		return
	end

	if roundTimer.Visible then
		TimerGUI.MainTimer.Visible = false
	else
		TimerGUI.MainTimer.Visible = OriginalTimerVisible
	end
end

local RunService = game:GetService("RunService")
local gameTimerConnection = nil

local function startGameTimerCheck()
	if gameTimerConnection then return end

	gameTimerConnection = RunService.Heartbeat:Connect(function()
		checkGameTimerVisibility()
	end)
end

local function stopGameTimerCheck()
	if gameTimerConnection then
		gameTimerConnection:Disconnect()
		gameTimerConnection = nil
	end
end

local function stopAttributeMonitor()
	if _attributeConnection then
		_attributeConnection:Disconnect()
		_attributeConnection = nil
	end
	if _attributeConnection2 then
		_attributeConnection2:Disconnect()
		_attributeConnection2 = nil
	end
	if _attributeConnection3 then
		_attributeConnection3:Disconnect()
		_attributeConnection3 = nil
	end
end

local function destroyTimerGUI()
	if TimerGUI then
		stopGameTimerCheck()
		stopAttributeMonitor()
		TimerGUI.ScreenGui:Destroy()
		TimerGUI = nil
	end
	TimerEnabled = false
	SpecialRoundEnabled = false
end

local function ensureTimerGUI()
	if not TimerGUI then
		TimerGUI = createTimerGUI()
	end
end

local function getRoundTitle(roundName)
	if not roundName or roundName == "" then
		return ""
	end

	local specialRoundsFolder = ReplicatedStorage:FindFirstChild("Info")
	if not specialRoundsFolder then return roundName end

	specialRoundsFolder = specialRoundsFolder:FindFirstChild("SpecialRounds")
	if not specialRoundsFolder then return roundName end

	local roundModule = specialRoundsFolder:FindFirstChild(roundName)
	if not roundModule then return roundName end

	local success, moduleData = pcall(function()
		return require(roundModule)
	end)

	if success and moduleData and moduleData.Title then
		return moduleData.Title
	end

	return roundName
end

local function setTime(seconds)
	if not TimerGUI then return end
	if type(seconds) == "number" then
		local minutes = math.floor(seconds / 60)
		local remainingSeconds = math.floor(seconds % 60)
		TimerGUI.TimeDisplay.Text = string.format("%d:%02d", minutes, remainingSeconds)

		if seconds <= 5 then
			TimerGUI.TimeDisplay.TextColor3 = Color3.fromRGB(215, 100, 100)
			TimerGUI.StatusLabel.TextColor3 = Color3.fromRGB(215, 100, 100)
			if TimerGUI.MainTimerStroke then
				TimerGUI.MainTimerStroke.Color = Color3.fromRGB(255, 138, 138)
			end
			if TimerGUI.MainTimerImage then
				TimerGUI.MainTimerImage.ImageColor3 = Color3.fromRGB(255, 138, 138)
			end
		else
			TimerGUI.TimeDisplay.TextColor3 = Color3.fromRGB(165, 194, 255)
			TimerGUI.StatusLabel.TextColor3 = Color3.fromRGB(165, 194, 255)
			if TimerGUI.MainTimerStroke then
				TimerGUI.MainTimerStroke.Color = Color3.fromRGB(165, 194, 255)
			end
			if TimerGUI.MainTimerImage then
				TimerGUI.MainTimerImage.ImageColor3 = Color3.fromRGB(21, 21, 21)
			end
		end
	else
		TimerGUI.TimeDisplay.Text = tostring(seconds)
	end
end

local function setSpecialRound(roundName)
	if not TimerGUI then return end
	if roundName and roundName ~= "" then
		CurrentSpecialRoundName = roundName
		local roundTitle = getRoundTitle(roundName)
		TimerGUI.SpecialRoundLabel.Text = roundTitle
		TimerGUI.SpecialRound.Visible = SpecialRoundEnabled
	else
		CurrentSpecialRoundName = ""
		TimerGUI.SpecialRound.Visible = false
	end
end

local function setStatus(text)
	if not TimerGUI then return end
	TimerGUI.StatusLabel.Text = text:upper()
end

local function setTimerVisible(visible)
	TimerEnabled = visible
	OriginalTimerVisible = visible

	if CheckingGameTimer then
		checkGameTimerVisibility()
	else
		if TimerGUI then
			TimerGUI.MainTimer.Visible = visible
		end
	end
end

local function setSpecialRoundVisible(visible)
	SpecialRoundEnabled = visible

	if TimerGUI and visible and CurrentSpecialRoundName ~= "" then
		TimerGUI.SpecialRound.Visible = true
	elseif TimerGUI then
		TimerGUI.SpecialRound.Visible = false
	end
end

local function updateFromAttributes()
	local timerValue = ServerStateRegistryService.Registry.Time
	local specialRoundValue = ServerStateRegistryService.Registry.SpecialRound
	local roundStatus = ServerStateRegistryService.Registry.RoundStatus

	if timerValue and timerValue ~= -1 then
		setTime(timerValue)
	end

	if roundStatus == 2 then
		setStatus("Round Active")
	elseif roundStatus == 1 then
		setStatus("Intermission")
	else
		setStatus("Waiting")
	end

	if specialRoundValue and specialRoundValue ~= false then
		setSpecialRound(tostring(specialRoundValue))
	else
		setSpecialRound("")
	end
end

local function startAttributeMonitor()
	stopAttributeMonitor()

	local lastTimer = ServerStateRegistryService.Registry.Time
	local lastRoundStatus = ServerStateRegistryService.Registry.RoundStatus
	local lastSpecialRound = ServerStateRegistryService.Registry.SpecialRound

	_attributeConnection = RunService.Heartbeat:Connect(function()
		local currentTimer = ServerStateRegistryService.Registry.Time
		local currentRoundStatus = ServerStateRegistryService.Registry.RoundStatus
		local currentSpecialRound = ServerStateRegistryService.Registry.SpecialRound

		if currentTimer ~= lastTimer or currentRoundStatus ~= lastRoundStatus or currentSpecialRound ~= lastSpecialRound then
			lastTimer = currentTimer
			lastRoundStatus = currentRoundStatus
			lastSpecialRound = currentSpecialRound
			updateFromAttributes()
		end
	end)

	updateFromAttributes()
end

local function handleTimerToggles()
	local timerOn = TimerEnabled
	local specialOn = SpecialRoundEnabled

	if not timerOn and not specialOn then
		destroyTimerGUI()
	else
		ensureTimerGUI()
		if timerOn then
			setTimerVisible(true)
			startAttributeMonitor()
			startGameTimerCheck()
		end
		if specialOn then
			setSpecialRoundVisible(true)
		end
	end
end

local currentEmotes = {}
local selectEmotes = {}
local emoteReplacements = {}
local hookActive = false
local lastEmoteName = nil
local Registry = require(ReplicatedStorage.Items.Registry)

local function setEmote(emoteID)
	if not emoteID then return end
	local player = game.Players.LocalPlayer
	local character = player.Character
	if not character then return end
	local tagValue = character:GetAttribute("Tag")
	if not tagValue then return end
	local tagBuf = buffer.create(2)
	buffer.writeu16(tagBuf, 0, tagValue)
	firesignal(ReplicatedStorage.Events.UpdateCharacterDataRegistry.OnClientEvent, {
		buffer.fromstring("\24\1"),
		emoteID,
		tagBuf
	})
end

for i = 1, 12 do
	currentEmotes[i] = ""
	selectEmotes[i] = ""
end

local function getAllEmotes()
	local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
	if not itemsFolder then return {} end

	local allEmotes = {}
	local function findEmotesFolders(parent)
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA("Folder") then
				if child.Name == "Emotes" then
					for _, emote in ipairs(child:GetChildren()) do
						if emote:IsA("ModuleScript") and emote:GetAttribute("ID") then
							table.insert(allEmotes, {Name = emote.Name, ID = emote:GetAttribute("ID")})
						end
					end
				else
					findEmotesFolders(child)
				end
			end
		end
	end
	findEmotesFolders(itemsFolder)
	return allEmotes
end

local function findEmoteInfo(emoteInput)
	if emoteInput == "" then return nil end

	local id = tonumber(emoteInput)
	if id then
		local config = Registry.GetConfig(id)
		if config then
			local allEmotes = getAllEmotes()
			for _, e in ipairs(allEmotes) do
				if e.ID == id then
					return {Name = e.Name, ID = id}
				end
			end
			return {Name = tostring(id), ID = id}
		else
			return nil
		end
	end
	local allEmotes = getAllEmotes()
	for _, emote in ipairs(allEmotes) do
		if emote.Name:lower() == emoteInput:lower() then
			return {Name = emote.Name, ID = emote.ID}
		end
	end
	return nil
end

local function buildEmoteMapping()
	emoteReplacements = {}
	for i = 1, 12 do
		local currentInput = currentEmotes[i] or ""
		local selectInput = selectEmotes[i] or ""
		if currentInput ~= "" and selectInput ~= "" then
			local currentInfo = findEmoteInfo(currentInput)
			local selectInfo = findEmoteInfo(selectInput)
			if currentInfo and selectInfo then
				emoteReplacements[currentInfo.Name] = {
					select = selectInfo.Name,
					selectID = selectInfo.ID,
					slot = i
				}
			end
		end
	end
end

local EmoteClass = require(ReplicatedStorage.Objects.Items.Emote)
local origActivate = EmoteClass.Activate
local origDeactivate = EmoteClass.Deactivate

local function startEmoteWatcher()
	if hookActive then return end
	hookActive = true

	EmoteClass.Activate = function(self, p2, p3)
		origActivate(self, p2, p3)
		local anim = self.Animations and self.Animations.Animation
		if anim and anim.IsPlaying and anim.Speed > 0 then
			local module = self.EmoteModule
			local currentEmote = module and module.Name or "Unknown"
			if currentEmote ~= lastEmoteName then
				if emoteReplacements[currentEmote] then
					local replacement = emoteReplacements[currentEmote]
					local selectID = replacement.selectID
					if selectID then
						lastEmoteName = currentEmote
						setEmote(selectID)
					end
				end
				lastEmoteName = currentEmote
			end
		end
	end

	EmoteClass.Deactivate = function(self, ...)
		origDeactivate(self, ...)
		lastEmoteName = nil
	end
end

local function stopEmoteWatcher()
	hookActive = false
	EmoteClass.Activate = origActivate
	EmoteClass.Deactivate = origDeactivate
	lastEmoteName = nil
end

local ToolSkinSawps = {}
local activeToolsSwaps = {}
local currentToolInput = ""
local currentSkinInput = ""
local selectedSkinInput = ""

local function normalizeString(str)
	return str:gsub("%s+", ""):lower()
end

local function isValidTool(toolName)
	local tools = ReplicatedStorage:FindFirstChild("Tools")
	if not tools then return false end
	local tool = tools:FindFirstChild(toolName)
	if not tool then return false end
	local variants = tool:FindFirstChild("Variants")
	if not variants then return false end
	return true, tool, variants
end

local function isValidSkin(toolName, skinName)
	local toolValid, tool, variants = isValidTool(toolName)
	if not toolValid then return false end
	local skin = variants:FindFirstChild(skinName)
	if not skin then return false end
	return true, tool, variants, skin
end

local function revertSkinSwap(toolName, currentSkinName, selectedSkinName)
	local key = toolName .. "_" .. currentSkinName
	if not activeToolsSwaps[key] then return false end

	local currentValid, currentTool, currentVariants, currentSkin = isValidSkin(toolName, currentSkinName)
	local selectedValid, selectedTool, selectedVariants, selectedSkin = isValidSkin(toolName, selectedSkinName)

	if currentValid and selectedValid then
		pcall(function()
			local tempRoot = Instance.new("Folder")
			tempRoot.Name = "__temp_skin_revert_" .. tostring(tick()):gsub("%.", "_")
			tempRoot.Parent = currentVariants

			local tempCurrent = Instance.new("Folder")
			tempCurrent.Name = "tempCurrent"
			tempCurrent.Parent = tempRoot

			local tempSelected = Instance.new("Folder")
			tempSelected.Name = "tempSelected"
			tempSelected.Parent = tempRoot

			for _, child in ipairs(currentSkin:GetChildren()) do
				child.Parent = tempCurrent
			end

			for _, child in ipairs(selectedSkin:GetChildren()) do
				child.Parent = tempSelected
			end

			for _, child in ipairs(tempCurrent:GetChildren()) do
				child.Parent = selectedSkin
			end

			for _, child in ipairs(tempSelected:GetChildren()) do
				child.Parent = currentSkin
			end

			tempRoot:Destroy()
		end)
	end

	activeToolsSwaps[key] = nil
	return true
end

local function revertAllToolSkinSawps()
	local swapsToRevert = {}
	for key, swapData in pairs(activeToolsSwaps) do
		table.insert(swapsToRevert, swapData)
	end

	for _, swapData in ipairs(swapsToRevert) do
		revertSkinSwap(swapData.toolName, swapData.currentSkin, swapData.selectedSkin)
	end

	ToolSkinSawps = {}
	activeToolsSwaps = {}
end

local function swapSkins(toolName, currentSkinName, selectedSkinName)
	local currentNorm = normalizeString(currentSkinName)
	local selectedNorm = normalizeString(selectedSkinName)

	if toolName == "" or currentNorm == "" or selectedNorm == "" then
		WindUI:Notify({
			Title = "Skin Changer",
			Content = '<font color="#ffaa00"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">triangle-exclamation</font> All fields must be filled</font>',
			Duration = 3
		})
		return false
	end

	if currentNorm == selectedNorm then
		WindUI:Notify({
			Title = "Skin Changer",
			Content = '<font color="#ffaa00"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">triangle-exclamation</font> Skin names cannot be the same</font>',
			Duration = 3
		})
		return false
	end

	local currentValid, currentTool, currentVariants, currentSkin = isValidSkin(toolName, currentSkinName)
	local selectedValid, selectedTool, selectedVariants, selectedSkin = isValidSkin(toolName, selectedSkinName)

	if not currentValid then
		WindUI:Notify({
			Title = "Skin Changer",
			Content = '<font color="#ff3030"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-x</font> Current skin not found: ' .. currentSkinName .. '</font>',
			Duration = 3
		})
		return false
	end

	if not selectedValid then
		WindUI:Notify({
			Title = "Skin Changer",
			Content = '<font color="#ff3030"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-x</font> Selected skin not found: ' .. selectedSkinName .. '</font>',
			Duration = 3
		})
		return false
	end

	local key = toolName .. "_" .. currentSkinName

	if activeToolsSwaps[key] then
		revertSkinSwap(toolName, currentSkinName, activeToolsSwaps[key].selectedSkin)
	end

	pcall(function()
		local tempRoot = Instance.new("Folder")
		tempRoot.Name = "__temp_skin_swap_" .. tostring(tick()):gsub("%.", "_")
		tempRoot.Parent = currentVariants

		local tempCurrent = Instance.new("Folder")
		tempCurrent.Name = "tempCurrent"
		tempCurrent.Parent = tempRoot

		local tempSelected = Instance.new("Folder")
		tempSelected.Name = "tempSelected"
		tempSelected.Parent = tempRoot

		for _, child in ipairs(currentSkin:GetChildren()) do
			child.Parent = tempCurrent
		end

		for _, child in ipairs(selectedSkin:GetChildren()) do
			child.Parent = tempSelected
		end

		for _, child in ipairs(tempCurrent:GetChildren()) do
			child.Parent = selectedSkin
		end

		for _, child in ipairs(tempSelected:GetChildren()) do
			child.Parent = currentSkin
		end

		tempRoot:Destroy()

		local swapData = {
			toolName = toolName,
			currentSkin = currentSkinName,
			selectedSkin = selectedSkinName
		}

		activeToolsSwaps[key] = swapData

		local found = false
		for i, swap in ipairs(ToolSkinSawps) do
			if swap.toolName == toolName and swap.currentSkin == currentSkinName then
				ToolSkinSawps[i] = swapData
				found = true
				break
			end
		end

		if not found then
			table.insert(ToolSkinSawps, swapData)
		end

		WindUI:Notify({
			Title = "Skin Changer",
			Content = '<font color="#00ff88"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-check</font> Successfully swapped ' .. currentSkinName .. ' with ' .. selectedSkinName .. ' for ' .. toolName .. '</font>',
			Duration = 3
		})
	end)

	return true
end

local ESP = {
	NameEnabled = false,
	UseDisplayName = false,
	NameSize = 14,
	NameColor = Color3.fromRGB(255, 255, 255)
}

local function getPlayerStatus(player)
	if not player or not player.Character then return "DEAD" end
	local character = player.Character

	local isDowned = false
	pcall(function()
		local charData = CharacterService:GetCharacterFromPlayer(player)
		if charData and charData.DataRegistry and charData.DataRegistry:Get("Downed") then
			isDowned = true
		end
	end)

	if not isDowned then
		pcall(function()
			if character:GetAttribute("Downed") or character:FindFirstChild("Downed") then
				isDowned = true
			end
		end)
	end

	if isDowned then
		return "DOWNED"
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		return "ALIVE"
	end

	return "DEAD"
end

local function updatePlayerESP(player)
	if player == LocalPlayer or not player.Character then return end
	local character = player.Character
	local head = character:FindFirstChild("Head") or character.PrimaryPart

	local oldHighlight = character:FindFirstChild("RiseHighlight")
	if oldHighlight then
		oldHighlight:Destroy()
	end

	if head then
		local billboard = head:FindFirstChild("RiseNameTag")
		if ESP.NameEnabled then
			if not billboard then
				billboard = Instance.new("BillboardGui")
				billboard.Name = "RiseNameTag"
				billboard.Size = UDim2.new(0, 200, 0, 50)
				billboard.StudsOffset = Vector3.new(0, 2.5, 0)
				billboard.AlwaysOnTop = true
				billboard.Parent = head

				local textLabel = Instance.new("TextLabel")
				textLabel.Name = "TagLabel"
				textLabel.BackgroundTransparency = 1
				textLabel.Size = UDim2.new(1, 0, 1, 0)
				textLabel.Font = Enum.Font.SourceSansBold
				textLabel.TextStrokeTransparency = 0
				textLabel.Parent = billboard
			end

			local textLabel = billboard:FindFirstChild("TagLabel")
			if textLabel then
				local baseName = ESP.UseDisplayName and player.DisplayName or player.Name
				local status = getPlayerStatus(player)
				if status == "DOWNED" then
					textLabel.Text = baseName .. " | DOWN"
				else
					textLabel.Text = baseName
				end
				textLabel.TextSize = ESP.NameSize
				textLabel.TextColor3 = ESP.NameColor
			end
			billboard.Enabled = true
		else
			if billboard then
				billboard:Destroy()
			end
		end
	end
end

RunService.RenderStepped:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		updatePlayerESP(player)
	end
end)

VisualTab:Toggle({
	Title = "Player Name",
	Desc = "Show names above players",
	Value = false,
	Callback = function(state)
		ESP.NameEnabled = state
	end
})

VisualTab:Toggle({
	Title = "Use Display Name",
	Desc = "Show display name instead of username",
	Value = false,
	Callback = function(state)
		ESP.UseDisplayName = state
	end
})

VisualTab:Slider({
	Title = "Name Text Size",
	Desc = "Adjust font size of player names",
	Value = {Min = 8, Max = 32, Default = 14},
	Step = 1,
	IsTextbox = true,
	Callback = function(value)
		ESP.NameSize = value
	end
})

VisualTab:Colorpicker({
	Title = "Name Color",
	Desc = "Change color of player name text",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function(color)
		ESP.NameColor = color
	end
})

do
	VisualTab:Section({ Title = "Nextbot ESP", TextSize = 20 })
	local NextbotNamesEnabled = false
	local NextbotDistanceEnabled = false
	local nextbotEspConnection = nil
	local nextbotBillboards = {}

	local function isNextbotModel(model)
		if model:GetAttribute("Team") == "Nextbot" then return true end
		if model:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(model) then
			if model:GetAttribute("Team") == "Nextbot" then return true end
		end
		return false
	end

	local function updateNextbotESP()
		for _, bb in pairs(nextbotBillboards) do
			if bb and bb.Parent then bb:Destroy() end
		end
		nextbotBillboards = {}
		if not NextbotNamesEnabled and not NextbotDistanceEnabled then return end
		for _, model in ipairs(workspace:GetDescendants()) do
			pcall(function()
				if model:IsA("Model") and isNextbotModel(model) then
					local hrp = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
					if hrp then
						local bb = Instance.new("BillboardGui")
						bb.Name = "NextbotESP"
						bb.Adornee = hrp
						bb.Size = UDim2.new(0, 200, 0, 50)
						bb.StudsOffset = Vector3.new(0, 3, 0)
						bb.AlwaysOnTop = true
						bb.Parent = game.CoreGui
						local label = Instance.new("TextLabel")
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.TextColor3 = Color3.fromRGB(255, 0, 0)
						label.TextStrokeTransparency = 0.5
						label.Font = Enum.Font.GothamBold
						label.TextSize = 14
						label.Parent = bb
						table.insert(nextbotBillboards, bb)
						RunService.RenderStepped:Connect(function()
							if not bb.Parent then return end
							local parts = {}
							if NextbotNamesEnabled then table.insert(parts, model.Name) end
							if NextbotDistanceEnabled then
								local char = LocalPlayer.Character
								if char and char:FindFirstChild("HumanoidRootPart") then
									local dist = math.floor((char.HumanoidRootPart.Position - hrp.Position).Magnitude)
									table.insert(parts, "[" .. dist .. "m]")
								end
							end
							label.Text = table.concat(parts, " ")
						end)
					end
				end
			end)
		end
	end

	VisualTab:Toggle({ Title = "Nextbot Names", Value = false, Callback = function(state) NextbotNamesEnabled = state updateNextbotESP() end })
	VisualTab:Toggle({ Title = "Nextbot Distance", Value = false, Callback = function(state) NextbotDistanceEnabled = state updateNextbotESP() end })
end

do
	VisualTab:Section({ Title = "Vehicle ESP", TextSize = 20 })
	local VehicleNamesEnabled = false
	local VehicleDistanceEnabled = false
	local VehicleHighlightEnabled = false
	local vehicleBillboards = {}
	local vehicleHighlights = {}

	local function findVehicles()
		local results = {}
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Model") and (obj:FindFirstChildOfClass("VehicleSeat") or obj:GetAttribute("Vehicle")) then
				table.insert(results, obj)
			end
		end
		return results
	end

	local function updateVehicleESP()
		for _, bb in pairs(vehicleBillboards) do if bb and bb.Parent then bb:Destroy() end end
		for _, hl in pairs(vehicleHighlights) do if hl and hl.Parent then hl:Destroy() end end
		vehicleBillboards = {}
		vehicleHighlights = {}
		if not VehicleNamesEnabled and not VehicleDistanceEnabled and not VehicleHighlightEnabled then return end
		for _, veh in ipairs(findVehicles()) do
			pcall(function()
				local adornee = veh.PrimaryPart or veh:FindFirstChildWhichIsA("BasePart")
				if not adornee then return end
				if VehicleHighlightEnabled then
					local hl = Instance.new("Highlight")
					hl.Adornee = veh
					hl.FillColor = Color3.fromRGB(0, 191, 255)
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
					hl.Parent = veh
					table.insert(vehicleHighlights, hl)
				end
				if VehicleNamesEnabled or VehicleDistanceEnabled then
					local bb = Instance.new("BillboardGui")
					bb.Name = "VehicleESP"
					bb.Adornee = adornee
					bb.Size = UDim2.new(0, 200, 0, 50)
					bb.StudsOffset = Vector3.new(0, 3, 0)
					bb.AlwaysOnTop = true
					bb.Parent = game.CoreGui
					local label = Instance.new("TextLabel")
					label.Size = UDim2.new(1, 0, 1, 0)
					label.BackgroundTransparency = 1
					label.TextColor3 = Color3.fromRGB(0, 191, 255)
					label.TextStrokeTransparency = 0.5
					label.Font = Enum.Font.GothamBold
					label.TextSize = 14
					label.Parent = bb
					table.insert(vehicleBillboards, bb)
					RunService.RenderStepped:Connect(function()
						if not bb.Parent then return end
						local parts = {}
						if VehicleNamesEnabled then table.insert(parts, veh.Name) end
						if VehicleDistanceEnabled then
							local char = LocalPlayer.Character
							if char and char:FindFirstChild("HumanoidRootPart") then
								local dist = math.floor((char.HumanoidRootPart.Position - adornee.Position).Magnitude)
								table.insert(parts, "[" .. dist .. "m]")
							end
						end
						label.Text = table.concat(parts, " ")
					end)
				end
			end)
		end
	end

	VisualTab:Toggle({ Title = "Vehicle Names", Value = false, Callback = function(state) VehicleNamesEnabled = state updateVehicleESP() end })
	VisualTab:Toggle({ Title = "Vehicle Distance", Value = false, Callback = function(state) VehicleDistanceEnabled = state updateVehicleESP() end })
	VisualTab:Toggle({ Title = "Vehicle Highlight", Value = false, Callback = function(state) VehicleHighlightEnabled = state updateVehicleESP() end })
end

VisualTab:Section({Title = "Timer Display"})

VisualTab:Toggle({
	Title = "Timer Display",
	Value = false,
	Callback = function(state)
		TimerEnabled = state
		handleTimerToggles()
	end
})

VisualTab:Toggle({
	Title = "Special Round Display",
	Value = false,
	Callback = function(state)
		SpecialRoundEnabled = state
		handleTimerToggles()
	end
})

VisualTab:Section({Title = "Emote Changer"})

for i = 1, 12 do
	VisualTab:Input({
		Title = "Current Emote " .. i,
		Placeholder = "Enter emote name or ID",
		Callback = function(v) 
			currentEmotes[i] = v:gsub("%s+", "")
		end
	})
end

VisualTab:Space()

for i = 1, 12 do
	VisualTab:Input({
		Title = "Select Emote " .. i,
		Placeholder = "Enter emote name or ID",
		Callback = function(v) 
			selectEmotes[i] = v:gsub("%s+", "")
		end
	})
end

VisualTab:Button({
	Title = "Apply Emote Mappings",
	Icon = "refresh-cw",
	Callback = function()
		local hasAnyEmote = false
		local incompleteSlots = {}
		local emptySlots = true

		for i = 1, 12 do
			local current = currentEmotes[i] or ""
			local select = selectEmotes[i] or ""
			if current ~= "" or select ~= "" then
				emptySlots = false
				if current ~= "" and select == "" then
					table.insert(incompleteSlots, string.format("Slot %d: Current set, Select missing", i))
				elseif current == "" and select ~= "" then
					table.insert(incompleteSlots, string.format("Slot %d: Select set, Current missing", i))
				else
					hasAnyEmote = true
				end
			end
		end

		if emptySlots then
			WindUI:Notify({
				Title = "Emote Changer",
				Content = '<font color="#ffaa00"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">triangle-exclamation</font> No emote fields are filled. Please enter at least one Current and Select pair.</font>',
				Duration = 5
			})
			return
		end

		if #incompleteSlots > 0 then
			local msg = '<font color="#ff3030"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-x</font> Failed to Apply Emote:</font>'
			for _, err in ipairs(incompleteSlots) do
				msg = msg .. '\n<font color="#ffaa00">' .. err .. '</font>'
			end
			WindUI:Notify({
				Title = "Emote Changer Error",
				Content = msg,
				Duration = 8
			})
			return
		end

		local allEmotes = getAllEmotes()
		buildEmoteMapping()

		local validMappings = 0
		local messages = {}

		for i = 1, 12 do
			local currentInput = currentEmotes[i] or ""
			local selectInput = selectEmotes[i] or ""
			if currentInput ~= "" and selectInput ~= "" then
				local currentInfo = findEmoteInfo(currentInput)
				local selectInfo = findEmoteInfo(selectInput)
				if currentInfo and selectInfo then
					validMappings = validMappings + 1
					table.insert(messages, string.format(
						'<font color="#00ff88"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-check</font> Slot %d:</font> <b>%s</b> <font color="#88ccff">→</font> <b>%s</b>',
						i, currentInfo.Name, selectInfo.Name
						))
				else
					local errors = {}
					if not currentInfo then
						table.insert(errors, string.format('<font color="#ff6666">Current "%s" not found</font>', currentInput))
					end
					if not selectInfo then
						table.insert(errors, string.format('<font color="#ff6666">Select "%s" not found</font>', selectInput))
					end
					table.insert(messages, string.format(
						'<font color="#ff3030"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-x</font> Slot %d:</font> %s',
						i, table.concat(errors, ", ")
						))
				end
			end
		end

		if validMappings == 0 then
			table.insert(messages, 1, '<font color="#ffaa00"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">triangle-exclamation</font> No valid emote mappings found.</font>')
			WindUI:Notify({
				Title = "Emote Changer Error",
				Content = table.concat(messages, "\n"),
				Duration = 8
			})
			return
		end

		stopEmoteWatcher()
		task.wait(0.1)
		startEmoteWatcher()

		table.insert(messages, 1, string.format(
			'<font color="#00ff88"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">circle-check</font> %d emote mapping%s applied.</font>',
			validMappings, validMappings > 1 and "s" or ""
			))
		WindUI:Notify({
			Title = "Emote Changer",
			Content = table.concat(messages, "\n"),
			Duration = 8
		})
	end
})

VisualTab:Button({
	Title = "Reset Emote Mappings",
	Icon = "trash-2",
	Color = Color3.fromHex("#FF3030"),
	Callback = function()
		stopEmoteWatcher()
		emoteReplacements = {}

		for i = 1, 12 do
			currentEmotes[i] = ""
			selectEmotes[i] = ""
		end

		WindUI:Notify({
			Title = "Emote Changer",
			Content = '<font color="#ff3030"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">trash-can</font> All emote mappings have been reset.</font>',
			Duration = 3
		})
	end
})

VisualTab:Section({Title = "Tools Skin Changer"})

VisualTab:Input({
	Title = "Tool Name",
	Placeholder = "Enter tool name",
	Callback = function(value)
		currentToolInput = value
	end
})

VisualTab:Input({
	Title = "Current Skin",
	Placeholder = "Enter current skin name",
	Callback = function(value)
		currentSkinInput = value
	end
})

VisualTab:Input({
	Title = "New Skin",
	Placeholder = "Enter new skin name",
	Callback = function(value)
		selectedSkinInput = value
	end
})

VisualTab:Button({
	Title = "Replace Skin Swap",
	Icon = "refresh-cw",
	Callback = function()
		swapSkins(currentToolInput, currentSkinInput, selectedSkinInput)
	end
})

VisualTab:Button({
	Title = "Reset All Skins",
	Icon = "trash-2",
	Color = Color3.fromHex("#FF3030"),
	Desc = "Revert all skin swaps",
	Callback = function()
		revertAllToolSkinSawps()
		WindUI:Notify({
			Title = "Skin Changer",
			Content = '<font color="#ff3030"><font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="Regular">trash-can</font> All skins have been reset to original</font>',
			Duration = 3
		})
	end
})

local farmPlatform = nil
local levelFarmEnabled = false
local eventFarmEnabled = false

local function getOrCreatePlatform()
	if not farmPlatform or not farmPlatform.Parent then
		farmPlatform = Instance.new("Part")
		farmPlatform.Name = "RiseClientFarmPlatform"
		farmPlatform.Size = Vector3.new(100, 4, 100)
		farmPlatform.Position = Vector3.new(0, 3500, 0)
		farmPlatform.Anchored = true
		farmPlatform.CanCollide = true
		farmPlatform.Transparency = 0.5
		farmPlatform.Material = Enum.Material.SmoothPlastic
		farmPlatform.Color = Color3.fromRGB(255, 49, 49)
		farmPlatform.Parent = workspace
	end
	return farmPlatform
end

local function teleportToPlatform()
	local plat = getOrCreatePlatform()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = plat.CFrame + Vector3.new(0, 5, 0)
	end
end

local function startLevelFarm()
	if not levelFarmEnabled then return end

	teleportToPlatform()

	task.delay(5, function()
		if levelFarmEnabled then
			startLevelFarm()
		end
	end)
end

local function getTicketVisualObjects()
	local list = {}
	local effectsFolder = workspace:FindFirstChild("Effects")
	local ticketsFolder = effectsFolder and effectsFolder:FindFirstChild("Tickets")

	if ticketsFolder then
		for _, child in ipairs(ticketsFolder:GetChildren()) do
			if child.Name == "Visual" then
				table.insert(list, child)
			else
				local visualChild = child:FindFirstChild("Visual")
				if visualChild then
					table.insert(list, visualChild)
				elseif child:IsA("Model") or child:IsA("BasePart") then
					table.insert(list, child)
				end
			end
		end
	end
	return list
end

local function getObjectCFrame(obj)
	if obj:IsA("Model") then
		return obj:GetPivot()
	elseif obj:IsA("BasePart") then
		return obj.CFrame
	end
	return nil
end

local function processTicket(ticket, onComplete)
	if not eventFarmEnabled or not ticket or not ticket.Parent or not ticket:IsDescendantOf(workspace) then
		onComplete()
		return
	end

	local targetCF = getObjectCFrame(ticket)
	if targetCF and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = targetCF
	end

	local connection
	local function cleanup()
		if connection then
			connection:Disconnect()
			connection = nil
		end
		onComplete()
	end

	connection = ticket.AncestryChanged:Connect(function(_, parent)
		if not parent then
			cleanup()
		end
	end)

	task.delay(2, function()
		if connection then
			cleanup()
		end
	end)
end

local function startEventFarm()
	if not eventFarmEnabled then return end

	local ticketObjects = getTicketVisualObjects()

	if #ticketObjects == 0 then
		teleportToPlatform()
		task.delay(5, startEventFarm)
	else
		local index = 1

		local function nextTicket()
			if not eventFarmEnabled or index > #ticketObjects then
				task.delay(0.1, startEventFarm)
				return
			end

			local ticket = ticketObjects[index]
			index = index + 1

			processTicket(ticket, function()
				nextTicket()
			end)
		end

		nextTicket()
	end
end

FarmTab:Toggle({
	Title = "Level Farm",
	Desc = "Teleports to client platform every 5 seconds",
	Value = false,
	Callback = function(state)
		levelFarmEnabled = state
		if state then
			startLevelFarm()
		end
	end
})

FarmTab:Toggle({
	Title = "Event Farm",
	Desc = "Auto teleports to ticket visual objects",
	Value = false,
	Callback = function(state)
		eventFarmEnabled = state
		if state then
			startEventFarm()
		end
	end
})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

PlayerTab:Section({Title="Modify Bounce", TextSize=20})
local bounceConnection = nil
local BounceSpeed = 0
PlayerTab:Toggle({
	Title="Modify Multiplier",
	Value=false,
	Callback = function(state)
		if bounceConnection then
			bounceConnection:Disconnect()
			bounceConnection = nil
		end
		if state then
			bounceConnection = RunService.RenderStepped:Connect(function()
				local char = LocalPlayer.Character
				if not char then return end
				local humanoid = char:FindFirstChild("Humanoid")
				if not humanoid then return end
				if humanoid.Health <= 0 then return end
				humanoid.WalkSpeed = BounceSpeed
			end)
		else
			local char = LocalPlayer.Character
			if char then
				local humanoid = char:FindFirstChild("Humanoid")
				if humanoid then humanoid.WalkSpeed = 0 end
			end
		end
	end
})
PlayerTab:Input({
	Title="Multiplier value", Placeholder="80", NumbersOnly=true,
	Callback = function(value) BounceSpeed = tonumber(value) or 0 end
})

PlayerTab:Section({ Title = "Super Bounce", TextSize = 20 })
local BounceHeight = 190
local superBounceEnabled = false
local superBounceConnection = nil
PlayerTab:Input({
	Title = "Bounce Height", Placeholder = "190", NumbersOnly = true,
	Callback = function(value) BounceHeight = tonumber(value) or 50 end
})
PlayerTab:Toggle({
	Title = "Super Bounce",
	Value = false,
	Callback = function(state)
		superBounceEnabled = state
		if state then
			if superBounceConnection then superBounceConnection:Disconnect() end
			superBounceConnection = RunService.Heartbeat:Connect(function()
				local char = LocalPlayer.Character
				if not char then return end
				local humanoid = char:FindFirstChild("Humanoid")
				local rootPart = char:FindFirstChild("HumanoidRootPart")
				if humanoid and rootPart and humanoid.FloorMaterial ~= Enum.Material.Air then
					humanoid.JumpPower = BounceHeight
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					rootPart.Velocity = Vector3.new(rootPart.Velocity.X, BounceHeight, rootPart.Velocity.Z)
				end
			end)
		else
			if superBounceConnection then superBounceConnection:Disconnect() superBounceConnection = nil end
		end
	end
})

PlayerTab:Section({ Title = "Modify Edge Trimp", TextSize = 20 })
local BounceMultiplier = 5
local FallSpeedThreshold = 69
local EdgeTrimpEnabled = false
local LastFloorMaterial = Enum.Material.Air
local LastPosition = Vector3.new()
local WasFalling = false
local EdgeDetected = false
local Character = nil
local Humanoid = nil
local RootPart = nil
local edgeTrimpConnection = nil
local charAddedConnection = nil

local function handleCharacterAdded(NewCharacter)
	Character = NewCharacter
	Humanoid = Character:WaitForChild("Humanoid")
	RootPart = Character:WaitForChild("HumanoidRootPart")
	LastPosition = RootPart.Position
	WasFalling = false
	EdgeDetected = false
end

PlayerTab:Toggle({
	Title = "Modify Edge Trimp",
	Value = false,
	Callback = function(State)
		EdgeTrimpEnabled = State
		if State then
			if LocalPlayer.Character then handleCharacterAdded(LocalPlayer.Character) end
			charAddedConnection = LocalPlayer.CharacterAdded:Connect(handleCharacterAdded)
			edgeTrimpConnection = RunService.Heartbeat:Connect(function()
				if not (Character and Humanoid and RootPart) then return end
				local CurrentPosition = RootPart.Position
				local Velocity = (CurrentPosition - LastPosition) / RunService.Heartbeat:Wait()
				LastPosition = CurrentPosition
				local CurrentFloorMaterial = Humanoid.FloorMaterial
				local IsFalling = Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping
				if CurrentFloorMaterial ~= LastFloorMaterial and CurrentFloorMaterial == Enum.Material.Air and not IsFalling then
					EdgeDetected = true
				else
					EdgeDetected = false
				end
				if EdgeDetected and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
					local FallVelocity = Velocity.Y
					if FallVelocity < -FallSpeedThreshold then
						local BounceVelocity = math.abs(FallVelocity) * BounceMultiplier
						RootPart.Velocity = Vector3.new(RootPart.Velocity.X, BounceVelocity, RootPart.Velocity.Z)
					end
				end
				LastFloorMaterial = CurrentFloorMaterial
				WasFalling = IsFalling
			end)
		else
			if edgeTrimpConnection then edgeTrimpConnection:Disconnect() edgeTrimpConnection = nil end
			if charAddedConnection then charAddedConnection:Disconnect() charAddedConnection = nil end
		end
	end
})
PlayerTab:Input({
	Title = "Bounce Height Multiplier", Placeholder = "5", NumbersOnly = true,
	Callback = function(Value) local Num = tonumber(Value) if Num and Num > 0 then BounceMultiplier = Num end end
})

PlayerTab:Section({ Title = "Fly", TextSize = 20 })
local FLY_SPEED = 150
local Movement = nil
pcall(function() Movement = require(ReplicatedStorage:WaitForChild("Objects"):WaitForChild("Game"):WaitForChild("Character"):WaitForChild("Client"):WaitForChild("Movement")) end)
local playerModule = nil
local controlModule = nil
pcall(function() 
	playerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
	controlModule = require(playerModule:WaitForChild("ControlModule"))
end)

local originalUpdate = Movement and Movement.Update or function() end
local freezeY = nil
local flying = false

local function getFlyDirection()
	local camCF = Workspace.CurrentCamera.CFrame
	local moveVector = controlModule and controlModule:GetMoveVector() or Vector3.new(0,0,0)
	if moveVector.Magnitude < 0.01 then return Vector3.new(0, 0, 0) end
	local forward = camCF.LookVector
	local right = camCF.RightVector
	return (forward * -moveVector.Z + right * moveVector.X).Unit * FLY_SPEED
end

local function flyUpdate(self, dt)
	originalUpdate(self, dt)
	local hrp = self.Character and self.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local flyDir = getFlyDirection()
	if flyDir.Magnitude > 0.1 then
		freezeY = nil
	elseif not freezeY then
		freezeY = hrp.Position.Y
	end
	local newVel = flyDir
	if self.DataRegistry then self.DataRegistry:Set("Velocity", newVel * 90) end
	hrp.AssemblyLinearVelocity = newVel
	if freezeY and flyDir.Magnitude <= 0.1 then
		local pos = hrp.Position
		hrp.CFrame = CFrame.new(pos.X, freezeY, pos.Z) * (hrp.CFrame - hrp.CFrame.Position)
	end
end

local FlyToggleObj
local function StartFly()
	if flying then return end
	flying = true
	freezeY = nil
	if Movement then Movement.Update = flyUpdate end
end
local function StopFly()
	if not flying then return end
	flying = false
	freezeY = nil
	if Movement then Movement.Update = originalUpdate end
end

local FlyScreenGui = Instance.new("ScreenGui")
FlyScreenGui.Name = "RiseFlyButton"
FlyScreenGui.ResetOnSpawn = false
FlyScreenGui.Enabled = false
FlyScreenGui.Parent = game.CoreGui

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 120, 0, 45)
flyBtn.Position = UDim2.new(0.5, -60, 0.8, 0)
flyBtn.Text = "FLY: OFF"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 18
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
flyBtn.BorderSizePixel = 0
flyBtn.Active = true
flyBtn.Parent = FlyScreenGui

local function makeDraggable(guiObject)
	local UserInputService = game:GetService("UserInputService")
	local dragging, dragInput, dragStart, startPos
	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = guiObject.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	guiObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end
makeDraggable(flyBtn)

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 8)
uicorner.Parent = flyBtn

local uistroke = Instance.new("UIStroke")
uistroke.Color = Color3.fromRGB(255, 49, 49)
uistroke.Thickness = 2
uistroke.Parent = flyBtn

local uigradient = Instance.new("UIGradient")
uigradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 20, 20))
}
uigradient.Rotation = 45
uigradient.Parent = flyBtn

local activeFly = false
flyBtn.MouseButton1Click:Connect(function()
	activeFly = not activeFly
	if activeFly then
		flyBtn.Text = "FLY: ON"
		uistroke.Color = Color3.fromRGB(0, 255, 100)
		StartFly()
		if FlyToggleObj then FlyToggleObj:Set(true) end
	else
		flyBtn.Text = "FLY: OFF"
		uistroke.Color = Color3.fromRGB(255, 49, 49)
		StopFly()
		if FlyToggleObj then FlyToggleObj:Set(false) end
	end
end)

FlyToggleObj = PlayerTab:Toggle({
	Title = "Fly",
	Value = false,
	Callback = function(state)
		if state then StartFly() else StopFly() end
		if state ~= activeFly then
			activeFly = state
			flyBtn.Text = activeFly and "FLY: ON" or "FLY: OFF"
			uistroke.Color = activeFly and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 49, 49)
		end
	end
})

PlayerTab:Toggle({
	Title = "Show Fly Button",
	Value = false,
	Callback = function(state) FlyScreenGui.Enabled = state end
})

PlayerTab:Input({
	Title = "Fly Speed", Placeholder = "150", NumbersOnly = true,
	Callback = function(value) local speed = tonumber(value) if speed and speed > 0 then FLY_SPEED = speed end end
})

PlayerTab:Section({ Title = "Custom Gravity", TextSize = 20 })
local CustomGravityValue = 196.2
local CustomGravityEnabled = false

local GravityScreenGui = Instance.new("ScreenGui")
GravityScreenGui.Name = "RiseGravityButton"
GravityScreenGui.ResetOnSpawn = false
GravityScreenGui.Enabled = false
GravityScreenGui.Parent = game.CoreGui

local gravityBtn = Instance.new("TextButton")
gravityBtn.Size = UDim2.new(0, 130, 0, 45)
gravityBtn.Position = UDim2.new(0.5, 70, 0.8, 0)
gravityBtn.Text = "GRAVITY: OFF"
gravityBtn.Font = Enum.Font.GothamBold
gravityBtn.TextSize = 16
gravityBtn.TextColor3 = Color3.new(1, 1, 1)
gravityBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
gravityBtn.BorderSizePixel = 0
gravityBtn.Active = true
gravityBtn.Parent = GravityScreenGui
makeDraggable(gravityBtn)

local gravCorner = Instance.new("UICorner")
gravCorner.CornerRadius = UDim.new(0, 8)
gravCorner.Parent = gravityBtn

local gravStroke = Instance.new("UIStroke")
gravStroke.Color = Color3.fromRGB(255, 49, 49)
gravStroke.Thickness = 2
gravStroke.Parent = gravityBtn

local gravGradient = Instance.new("UIGradient")
gravGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 20, 20))
}
gravGradient.Rotation = 45
gravGradient.Parent = gravityBtn

local function applyGravity(enabled)
	CustomGravityEnabled = enabled
	if enabled then
		workspace.Gravity = CustomGravityValue
	else
		workspace.Gravity = 196.2
	end
end

gravityBtn.MouseButton1Click:Connect(function()
	CustomGravityEnabled = not CustomGravityEnabled
	applyGravity(CustomGravityEnabled)
	gravityBtn.Text = CustomGravityEnabled and "GRAVITY: ON" or "GRAVITY: OFF"
	gravStroke.Color = CustomGravityEnabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 49, 49)
	if GravityToggleObj then GravityToggleObj:Set(CustomGravityEnabled) end
end)

GravityToggleObj = PlayerTab:Toggle({
	Title = "Custom Gravity",
	Value = false,
	Callback = function(state)
		applyGravity(state)
		gravityBtn.Text = state and "GRAVITY: ON" or "GRAVITY: OFF"
		gravStroke.Color = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 49, 49)
	end
})

PlayerTab:Toggle({
	Title = "Show Gravity Button",
	Value = false,
	Callback = function(state) GravityScreenGui.Enabled = state end
})

PlayerTab:Slider({
	Title = "Gravity Value",
	Value = { Min = 0, Max = 500, Default = 196, Step = 1 },
	Callback = function(value)
		CustomGravityValue = value
		if CustomGravityEnabled then workspace.Gravity = value end
	end
})

PlayerTab:Section({ Title = "Noclip CFrame", TextSize = 20 })
local noclipConnection = nil
local noclipEnabled = false
PlayerTab:Toggle({
	Title = "Noclip CFrame",
	Value = false,
	Callback = function(state)
		noclipEnabled = state
		if state then
			if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
			noclipConnection = RunService.RenderStepped:Connect(function()
				local char = LocalPlayer.Character
				if not char then return end
				local hrp = char:FindFirstChild("HumanoidRootPart")
				local humanoid = char:FindFirstChild("Humanoid")
				if not hrp or not humanoid then return end
				if humanoid.Health <= 0 then return end
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
				local moveDir = humanoid.MoveDirection
				if moveDir.Magnitude > 0 then hrp.CFrame = hrp.CFrame + (moveDir * 0.1) end
			end)
		else
			if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
			local char = LocalPlayer.Character
			if char then
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = true end
				end
			end
		end
	end
})
LocalPlayer.CharacterAdded:Connect(function(char)
	if noclipEnabled then
		task.wait(0.5)
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end)

PlayerTab:Section({ Title = "Walk On Water", TextSize = 20 })
local waterRenderConnection = nil
PlayerTab:Toggle({
	Title = "Walk On Water",
	Value = false,
	Callback = function(state)
		local partsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Parts")
		if not partsFolder then return end
		local waterFolder = partsFolder:FindFirstChild("Water")
		if not waterFolder then return end
		local fakeWaterFolder = partsFolder:FindFirstChild("FakeWater")
		if not fakeWaterFolder then
			fakeWaterFolder = Instance.new("Folder")
			fakeWaterFolder.Name = "FakeWater"
			fakeWaterFolder.Parent = partsFolder
		end
		if state then
			if waterRenderConnection then waterRenderConnection:Disconnect() end
			waterRenderConnection = RunService.RenderStepped:Connect(function()
				for _, part in ipairs(waterFolder:GetChildren()) do
					if part:IsA("BasePart") and part.Parent ~= fakeWaterFolder then
						part.CanCollide = true
						part.Parent = fakeWaterFolder
					end
				end
			end)
		else
			if waterRenderConnection then waterRenderConnection:Disconnect() waterRenderConnection = nil end
			for _, part in ipairs(fakeWaterFolder:GetChildren()) do
				if part:IsA("BasePart") then part.CanCollide = false part.Parent = waterFolder end
			end
		end
	end
})

PlayerTab:Section({ Title = "TP Walk", TextSize = 20 })
local tpwalkEnabled = false
local TpwalkValue = 1
local tpwalkConnection = nil

local function startTpwalk()
	if tpwalkConnection then return end
	tpwalkConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character
		if not char then return end
		local humanoid = char:FindFirstChild("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if humanoid and hrp and humanoid.MoveDirection.Magnitude > 0 then
			hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * TpwalkValue)
		end
	end)
end

local function stopTpwalk()
	if tpwalkConnection then
		tpwalkConnection:Disconnect()
		tpwalkConnection = nil
	end
end

PlayerTab:Toggle({
	Title = "TP WALK",
	Value = false,
	Callback = function(state)
		tpwalkEnabled = state
		if state then startTpwalk() else stopTpwalk() end
	end
})
PlayerTab:Slider({
	Title = "TPWALK VALUE",
	Value = { Min = 1, Max = 200, Default = 1, Step = 1 },
	Callback = function(value) TpwalkValue = value end
})

local AutoTab = Window:Tab({ Title = 'Auto', Icon = 'zap' })
local MiscTab = Window:Tab({ Title = 'Misc', Icon = 'layout-grid' })

MiscTab:Section({ Title = "Anti AFK", TextSize = 20 })
local VirtualUser = game:GetService("VirtualUser")
local antiAfkConnection = nil
MiscTab:Toggle({
	Title = "Anti AFK",
	Value = false,
	Callback = function(s)
		if s then
			if antiAfkConnection then antiAfkConnection:Disconnect() end
			antiAfkConnection = LocalPlayer.Idled:Connect(function()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		else
			if antiAfkConnection then antiAfkConnection:Disconnect() antiAfkConnection = nil end
		end
	end
})

MiscTab:Button({
	Title = "FE Boombox",
	Desc = "Executes the FE Boombox script.",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowBey01/Rise-Script/refs/heads/main/cool%20stuff/fe%20boombox"))()
	end
})

MiscTab:Toggle({
    Title = "Enable Skybox Changer",
    Desc = "",
    Value = false,
    Callback = function(state)
        isEnabled = state
        if isEnabled then
            applySkybox(selectedSkybox)
        else
            local currentSky = Lighting:FindFirstChildOfClass("Sky")
            if currentSky then
                currentSky:Destroy()
            end
            if originalSky then
                originalSky:Clone().Parent = Lighting
            end
        end
    end
})

local skyboxOptions = {
    "--",
    "Galaxy",
    "Purple",
    "Purple Night",
    "Night Sky",
    "Pink Daylight",
    "Morning Glow",
    "Setting Sun",
    "Fade Blue",
    "Elegant Morning",
    "Neptune",
    "Redshift",
    "Aesthetic Night"
}

MiscTab:Dropdown({
    Title = "Select Skybox",
    Desc = "Select A Skybox ",
    Values = skyboxOptions,
    Value = "--",
    Callback = function(option)
        selectedSkybox = type(option) == "table" and option[1] or option
    end
})

MiscTab:Button({
    Title = "Apply Selected Skybox",
    Desc = "",
    Callback = function()
        if isEnabled then
            applySkybox(selectedSkybox)
            WindUI:Notify({
                Title = "Skybox Changed",
                Content = selectedSkybox .. " successfully applied! dau was here",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Warning",
                Content = "	Open Enable Skybox Changer Toggle First Before Changing A Skybox",
                Duration = 3
            })
        end
    end
})

local UtilityTab = Window:Tab({ Title = 'Utility', Icon = 'wrench' })

UtilityTab:Section({ Title = "Map Adjustments", TextSize = 20 })
UtilityTab:Toggle({
	Title = "Invis Walls Collide",
	Value = true,
	Callback = function(state)
		local invisPartsFolder = workspace:FindFirstChild("Map")
		if invisPartsFolder then invisPartsFolder = invisPartsFolder:FindFirstChild("InvisParts") end
		if not invisPartsFolder then
			local gameFolder = workspace:FindFirstChild("Game")
			if gameFolder then
				local mapFolder = gameFolder:FindFirstChild("Map")
				if mapFolder then invisPartsFolder = mapFolder:FindFirstChild("InvisParts") end
			end
		end
		if invisPartsFolder then
			for _, obj in ipairs(invisPartsFolder:GetDescendants()) do
				if obj:IsA("BasePart") then obj.CanCollide = state end
			end
		end
	end
})

do
	VisualTab:Section({ Title = "Camera & Lighting Mods", TextSize = 20 })

	local cameraStretchConnection = nil
	local stretchHorizontal = 0.80
	local stretchVertical = 0.80

	VisualTab:Toggle({
		Title = "Camera Stretch",
		Value = false,
		Callback = function(state)
			if state then
				if cameraStretchConnection then cameraStretchConnection:Disconnect() end
				cameraStretchConnection = game:GetService("RunService").RenderStepped:Connect(function()
					local Camera = workspace.CurrentCamera
					Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, stretchHorizontal, 0, 0, 0, stretchVertical, 0, 0, 0, 1)
				end)
			else
				if cameraStretchConnection then
					cameraStretchConnection:Disconnect()
					cameraStretchConnection = nil
				end
			end
		end
	})

	VisualTab:Input({
		Title = "Camera Stretch Horizontal",
		Placeholder = "0.80",
		NumbersOnly = true,
		Callback = function(value)
			local num = tonumber(value)
			if num then
				stretchHorizontal = num
				if cameraStretchConnection then
					cameraStretchConnection:Disconnect()
					cameraStretchConnection = game:GetService("RunService").RenderStepped:Connect(function()
						local Camera = workspace.CurrentCamera
						Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, stretchHorizontal, 0, 0, 0, stretchVertical, 0, 0, 0, 1)
					end)
				end
			end
		end
	})

	VisualTab:Input({
		Title = "Camera Stretch Vertical",
		Placeholder = "0.80",
		NumbersOnly = true,
		Callback = function(value)
			local num = tonumber(value)
			if num then
				stretchVertical = num
				if cameraStretchConnection then
					cameraStretchConnection:Disconnect()
					cameraStretchConnection = game:GetService("RunService").RenderStepped:Connect(function()
						local Camera = workspace.CurrentCamera
						Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, stretchHorizontal, 0, 0, 0, stretchVertical, 0, 0, 0, 1)
					end)
				end
			end
		end
	})
end

do
	local Lighting = game:GetService("Lighting")
	local FullBright = false
	local fullBrightConnection = nil
	local fullBrightCharConnection = nil
	local originalBrightness = Lighting.Brightness
	local originalAmbient = Lighting.Ambient
	local originalOutdoorAmbient = Lighting.OutdoorAmbient
	local originalColorShiftBottom = Lighting.ColorShift_Bottom
	local originalColorShiftTop = Lighting.ColorShift_Top 

	local function applyFullBright()
		if Lighting.Brightness ~= 1 then Lighting.Brightness = 1 end
		if Lighting.Ambient ~= Color3.new(1, 1, 1) then Lighting.Ambient = Color3.new(1, 1, 1) end
		if Lighting.OutdoorAmbient ~= Color3.new(1, 1, 1) then Lighting.OutdoorAmbient = Color3.new(1, 1, 1) end
		if Lighting.ColorShift_Bottom ~= Color3.new(1, 1, 1) then Lighting.ColorShift_Bottom = Color3.new(1, 1, 1) end
		if Lighting.ColorShift_Top ~= Color3.new(1, 1, 1) then Lighting.ColorShift_Top = Color3.new(1, 1, 1) end
	end

	VisualTab:Toggle({
		Title = "Full Bright",
		Value = false,
		Callback = function(state)
			FullBright = state
			if state then 
				originalBrightness = Lighting.Brightness
				originalAmbient = Lighting.Ambient
				originalOutdoorAmbient = Lighting.OutdoorAmbient
				originalColorShiftBottom = Lighting.ColorShift_Bottom
				originalColorShiftTop = Lighting.ColorShift_Top 

				applyFullBright() 

				if fullBrightConnection then fullBrightConnection:Disconnect() end 
				fullBrightConnection = RunService.Heartbeat:Connect(function()
					if FullBright then applyFullBright() end
				end) 
				fullBrightCharConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function()
					task.wait(1)
					if FullBright then applyFullBright() end
				end) 
			else
				if fullBrightConnection then fullBrightConnection:Disconnect() fullBrightConnection = nil end 
				if fullBrightCharConnection then fullBrightCharConnection:Disconnect() fullBrightCharConnection = nil end 
				if originalBrightness then
					Lighting.Brightness = originalBrightness
					Lighting.Ambient = originalAmbient
					Lighting.OutdoorAmbient = originalOutdoorAmbient
					Lighting.ColorShift_Bottom = originalColorShiftBottom
					Lighting.ColorShift_Top = originalColorShiftTop
				end
			end
		end
	})
end

do
	local Lighting = game:GetService("Lighting")
	local originalFogEnd = Lighting.FogEnd
	local originalFogColor = Lighting.FogColor
	local fogConnection
	VisualTab:Toggle({
		Title = "Remove Fog",
		Value = false,
		Callback = function(state)
			if state then
				if fogConnection then fogConnection:Disconnect() end
				fogConnection = RunService.RenderStepped:Connect(function()
					Lighting.FogEnd = 9e9
					Lighting.FogColor = Color3.fromRGB(255, 255, 255)
				end)
			else
				if fogConnection then fogConnection:Disconnect() fogConnection = nil end
				Lighting.FogEnd = originalFogEnd
				Lighting.FogColor = originalFogColor
			end
		end
	})
end

do
	local fadeConnection = nil
	VisualTab:Toggle({
		Title = "Disable Fade effect",
		Value = false,
		Callback = function(state)
			if fadeConnection then fadeConnection:Disconnect() fadeConnection = nil end

			local coverScreen = PlayerGui:FindFirstChild("Shared")
			if coverScreen then coverScreen = coverScreen:FindFirstChild("Popups")
				if coverScreen then coverScreen = coverScreen:FindFirstChild("CoverScreen") end
			end

			if not coverScreen then return end

			if state then
				coverScreen.Visible = false
				fadeConnection = coverScreen:GetPropertyChangedSignal("Visible"):Connect(function()
					if coverScreen.Visible then coverScreen.Visible = false end
				end)
			else
				coverScreen.Visible = true
			end
		end
	})
end

do
	UtilityTab:Section({ Title = "Lag Switch", TextSize = 20 })
	local lagSwitchEnabled = false
	local lagMethod = "CPU Cycle"
	local lagDuration = 0.5
	local isLagActive = false

	local LagScreenGui = Instance.new("ScreenGui")
	LagScreenGui.Name = "LagSwitchGui"
	LagScreenGui.ResetOnSpawn = false
	LagScreenGui.Parent = game.CoreGui

	local lagBtn = Instance.new("TextButton")
	lagBtn.Size = UDim2.new(0, 120, 0, 40)
	lagBtn.Position = UDim2.new(0.5, -60, 0.2, 0)
	lagBtn.Text = "LAG"
	lagBtn.Font = Enum.Font.GothamBold
	lagBtn.TextSize = 16
	lagBtn.TextColor3 = Color3.new(1, 1, 1)
	lagBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	lagBtn.BorderSizePixel = 0
	lagBtn.Active = true
	lagBtn.Visible = false
	lagBtn.Parent = LagScreenGui
	Instance.new("UICorner", lagBtn).CornerRadius = UDim.new(0, 8)
	local lagStroke = Instance.new("UIStroke", lagBtn)
	lagStroke.Color = Color3.fromRGB(255, 49, 49)
	lagStroke.Thickness = 2

	if makeDraggable then makeDraggable(lagBtn) end

	local function lag()
		if lagMethod == "CPU Cycle" then
			local start = os.clock()
			while os.clock() - start < lagDuration do end
		end
	end

	lagBtn.MouseButton1Click:Connect(function()
		if lagSwitchEnabled then
			task.spawn(lag)
		end
	end)

	UtilityTab:Toggle({
		Title = "Lag Switch",
		Value = false,
		Callback = function(state)
			lagSwitchEnabled = state
			lagBtn.Visible = state
		end
	})
	UtilityTab:Dropdown({
		Title = "Lag Method",
		Values = {"CPU Cycle", "OS.ClockFFlag"},
		Value = "CPU Cycle",
		Callback = function(value) lagMethod = value end
	})
	UtilityTab:Input({
		Title = "Lag Duration (seconds)",
		Placeholder = "0.5",
		NumbersOnly = true,
		Callback = function(text) local n = tonumber(text) if n then lagDuration = n end end
	})
end

do
	MovementTab:Section({ Title = "Jump Pad Bounce Modifier", TextSize = 20 })
	local JumpPadModule = nil
	pcall(function() JumpPadModule = require(ReplicatedStorage.Items.BaseItems.Loadout.Deployables.JumpPad.Modules.Client) end)

	local JumpPadValue = 360
	local originalUse = JumpPadModule and JumpPadModule.Use or nil

	if JumpPadModule then
		MovementTab:Toggle({
			Title = "Jump Pad Bounce Modifier",
			Value = false,
			Callback = function(state)
				if state then
					function JumpPadModule.Use(p1, p2)
						if p2 == nil or (p2 ~= Players.LocalPlayer.Character or p2:GetAttribute("JumpPadInEffect") == true) then
							return originalUse(p1, p2)
						end
						p1.Model.AnimationController:LoadAnimation(p1.Model.Animations.Use):Play(0.1)
						p1.Model.BoundingBox.Launch:Play()
						Players.LocalPlayer.Character.HumanoidRootPart:ApplyImpulse(Vector3.new(0, JumpPadValue, 0))
						p2:SetAttribute("JumpPadInEffect", true)
						task.spawn(function()
							task.wait(1.5)
							p2:SetAttribute("JumpPadInEffect", nil)
						end)
					end
				else
					JumpPadModule.Use = originalUse
				end
			end
		})
		MovementTab:Input({
			Title = "Jump Value",
			Placeholder = "0",
			NumbersOnly = true,
			Callback = function(text) local num = tonumber(text) if num then JumpPadValue = num end end
		})
	end
end

do
	UtilityTab:Section({ Title = "Performance & Graphics Boosters", TextSize = 20 })

	local NoRender = false
	local NoRenderColor = Color3.fromRGB(0, 0, 0)
	UtilityTab:Toggle({
		Title = "No Render",
		Value = false,
		Callback = function(state)
			NoRender = state
			game:GetService("RunService"):Set3dRenderingEnabled(not state) 
			if state then
				local gui = Instance.new("ScreenGui")
				gui.Name = "NoRenderBackground"
				gui.DisplayOrder = -99999
				gui.IgnoreGuiInset = true
				gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				gui.ResetOnSpawn = false 
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, 0, 1, 0)
				frame.BackgroundColor3 = NoRenderColor
				frame.BorderSizePixel = 0
				frame.Parent = gui 
				gui.Parent = PlayerGui
			else
				local gui = PlayerGui:FindFirstChild("NoRenderBackground")
				if gui then gui:Destroy() end
			end
		end
	})

	UtilityTab:Button({
		Title = "Remove Textures",
		Callback = function()
			for _, part in ipairs(workspace:GetDescendants()) do
				if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("UnionOperation") or part:IsA("WedgePart") or part:IsA("CornerWedgePart") then
					part.Material = Enum.Material.SmoothPlastic
					if part:IsA("MeshPart") and part.TextureID ~= "" then part.TextureID = "" end
					for _, texture in ipairs(part:GetChildren()) do
						if texture:IsA("Texture") or texture:IsA("Decal") then
							texture.Texture = "rbxassetid://0"
						end
					end
				end
			end
			WindUI:Notify({ Title = "Textures Removed", Content = "All textures and materials have been removed", Duration = 3 })
		end
	})

	UtilityTab:Button({
		Title = "Clear MaterialService",
		Callback = function()
			local materialService = game:GetService("MaterialService")
			for _, child in ipairs(materialService:GetChildren()) do
				child:Destroy()
			end
			WindUI:Notify({ Title = "Performance", Content = "MaterialService items cleared!", Duration = 2 })
		end
	})

	UtilityTab:Button({
		Title = "Low Quality",
		Callback = function()
			local ToDisable = { Textures = true, VisualEffects = true, Parts = true, Particles = true, Sky = true }
			for _, v in next, game:GetDescendants() do
				if ToDisable.Parts then
					if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("BasePart") then
						v.Material = Enum.Material.SmoothPlastic
					end
				end 
				if ToDisable.Particles then
					if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or v:IsA("Fire") then
						v.Enabled = false
					end
				end 
				if ToDisable.VisualEffects then
					if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
						v.Enabled = false
					end
				end 
				if ToDisable.Textures then
					if v:IsA("Decal") or v:IsA("Texture") then
						v.Texture = ""
					end
				end 
			end
			WindUI:Notify({ Title = "Performance", Content = "Low Quality mode applied!", Duration = 2 })
		end
	})
end

do
	AutoTab:Section({ Title = "Self Revive", TextSize = 20 })
	AutoTab:Toggle({
		Title = "Auto Self Revive",
		Value = false,
		Callback = function(state)
			if state then SelfRevive:Start() else SelfRevive:Stop() end
		end
	})
	AutoTab:Dropdown({
		Title = "Self Revive Method",
		Values = {"Spawnpoint", "Fake Revive"},
		Value = "Spawnpoint",
		Callback = function(value) SelfRevive.Method = value end
	})
	AutoTab:Button({ Title = "Manual Revive", Icon = "heart", Callback = function() SelfRevive:Respawn() end })
	AutoTab:Button({ Title = "Force Respawn", Icon = "heart", Callback = function() changePlayerMode:FireServer(true) end })
end

do
	AutoTab:Section({ Title = "Auto Whistle", TextSize = 20 })
	local AutoWhistle = false
	local autoWhistleConnection = nil
	local lastWhistle = 0

	local function startAutoWhistle()
		if autoWhistleConnection then return end
		lastWhistle = tick()
		autoWhistleConnection = RunService.Heartbeat:Connect(function()
			if not AutoWhistle then return end
			local now = tick()
			if now - lastWhistle >= 1 then
				lastWhistle = now
				pcall(function()
					ReplicatedStorage:WaitForChild("Services"):WaitForChild("Client"):WaitForChild("KeybindService"):WaitForChild("SendKeybindEvent"):Fire({["Down"] = true, ["Key"] = "Whistle"})
				end)
			end
		end)
	end

	local function stopAutoWhistle()
		AutoWhistle = false
		if autoWhistleConnection then autoWhistleConnection:Disconnect() autoWhistleConnection = nil end
	end

	AutoTab:Toggle({
		Title = "Auto Whistle",
		Value = false,
		Callback = function(state)
			AutoWhistle = state
			if state then startAutoWhistle() else stopAutoWhistle() end
		end
	})
end

do
	AutoTab:Section({ Title = "Auto Vote", TextSize = 20 })
	local AutoVote = { Enabled = false, Map = 1, Mode = 1, Connections = { Map = nil, Mode = nil } }

	local function fireVoteServer(mapNumber)
		pcall(function()
			local voteEvent = ReplicatedStorage:FindFirstChild("Events")
			if voteEvent then voteEvent = voteEvent:FindFirstChild("Vote")
				if voteEvent and voteEvent:IsA("RemoteEvent") then voteEvent:FireServer(mapNumber) end
			end
		end)
	end

	local function fireVoteMode(modeNumber)
		pcall(function()
			local voteEvent = ReplicatedStorage:FindFirstChild("Events")
			if voteEvent then voteEvent = voteEvent:FindFirstChild("Vote")
				if voteEvent and voteEvent:IsA("RemoteEvent") then voteEvent:FireServer(modeNumber, true) end
			end
		end)
	end

	local mapDropdownValues = {}
	for i = 1, 4 do table.insert(mapDropdownValues, "Map " .. i) end

	AutoTab:Dropdown({ Title = "Auto Vote Map", Values = mapDropdownValues, Value = "Map 1", Callback = function(value) AutoVote.Map = tonumber(value:match("%d+")) end })
	AutoTab:Toggle({ Title = "Auto Vote Map", Value = false, Callback = function(state)
		if state then
			if AutoVote.Connections.Map then AutoVote.Connections.Map:Disconnect() end
			AutoVote.Connections.Map = RunService.Heartbeat:Connect(function() fireVoteServer(AutoVote.Map) end)
		else
			if AutoVote.Connections.Map then AutoVote.Connections.Map:Disconnect() AutoVote.Connections.Map = nil end
		end
	end })

	local modeDropdownValues = {}
	for i = 1, 4 do table.insert(modeDropdownValues, "Mode " .. i) end

	AutoTab:Dropdown({ Title = "Auto Vote Mode", Values = modeDropdownValues, Value = "Mode 1", Callback = function(value) AutoVote.Mode = tonumber(value:match("%d+")) end })
	AutoTab:Toggle({ Title = "Auto Vote Game Mode", Value = false, Callback = function(state)
		if state then
			if AutoVote.Connections.Mode then AutoVote.Connections.Mode:Disconnect() end
			AutoVote.Connections.Mode = RunService.Heartbeat:Connect(function() fireVoteMode(AutoVote.Mode) end)
		else
			if AutoVote.Connections.Mode then AutoVote.Connections.Mode:Disconnect() AutoVote.Connections.Mode = nil end
		end
	end })
end

do
	AutoTab:Section({ Title = "Auto Carry", TextSize = 20 })
	local AutoCarry = false
	local AutoCarryConnection = nil
	local lastCarryAttempt = 0
	local carryCooldown = 0.5

	local function startAutoCarry()
		AutoCarryConnection = RunService.Heartbeat:Connect(function()
			if not AutoCarry then return end
			local char = LocalPlayer.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end
			local now = tick()
			if now - lastCarryAttempt < carryCooldown then return end
			for _, other in ipairs(Players:GetPlayers()) do
				if other == LocalPlayer then continue end
				local otherChar = other.Character
				if not otherChar then continue end
				local otherHRP = otherChar:FindFirstChild("HumanoidRootPart")
				if not otherHRP then continue end
				local dist = (hrp.Position - otherHRP.Position).Magnitude
				if dist <= 20 then
					local targetTag = otherChar:GetAttribute("Tag")
					if targetTag then
						pcall(function() ReplicatedStorage.Events.Interact:FireServer("Carry", targetTag) end)
						lastCarryAttempt = now
						break
					end
				end
			end
		end)
	end

	local function stopAutoCarry()
		if AutoCarryConnection then AutoCarryConnection:Disconnect() AutoCarryConnection = nil end
	end

	local CarryScreenGui = Instance.new("ScreenGui")
	CarryScreenGui.Name = "CarryBtnGui"
	CarryScreenGui.ResetOnSpawn = false
	CarryScreenGui.Parent = game.CoreGui
	local carryBtn = Instance.new("TextButton")
	carryBtn.Size = UDim2.new(0, 120, 0, 40)
	carryBtn.Position = UDim2.new(0.5, -60, 0.35, 0)
	carryBtn.Text = "CARRY: OFF"
	carryBtn.Font = Enum.Font.GothamBold
	carryBtn.TextSize = 16
	carryBtn.TextColor3 = Color3.new(1, 1, 1)
	carryBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	carryBtn.BorderSizePixel = 0
	carryBtn.Active = true
	carryBtn.Visible = false
	carryBtn.Parent = CarryScreenGui
	Instance.new("UICorner", carryBtn).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", carryBtn).Color = Color3.fromRGB(255, 49, 49)

	if makeDraggable then makeDraggable(carryBtn) end

	carryBtn.MouseButton1Click:Connect(function()
		AutoCarry = not AutoCarry
		carryBtn.Text = AutoCarry and "CARRY: ON" or "CARRY: OFF"
		carryBtn.BackgroundColor3 = AutoCarry and Color3.fromRGB(255, 49, 49) or Color3.fromRGB(20, 20, 25)
		if AutoCarry then startAutoCarry() else stopAutoCarry() end
	end)

	AutoTab:Toggle({ Title = "Auto Carry", Value = false, Callback = function(state)
		AutoCarry = state
		carryBtn.Text = state and "CARRY: ON" or "CARRY: OFF"
		carryBtn.BackgroundColor3 = state and Color3.fromRGB(255, 49, 49) or Color3.fromRGB(20, 20, 25)
		if state then startAutoCarry() else stopAutoCarry() end
	end })
	AutoTab:Toggle({ Title = "Show Carry Button", Value = false, Callback = function(state) carryBtn.Visible = state end })
end

do
	AutoTab:Section({ Title = "Auto Crouch", TextSize = 20 })
	local AutoCrouch = false
	local AutoCrouchMode = "Air"
	local CrouchDelay = 0
	local crouchConnection = nil
	local arg_v784 = 0
	local arg_v785 = false

	local function fireKeybind(down)
		pcall(function()
			ReplicatedStorage:WaitForChild("Services"):WaitForChild("Client"):WaitForChild("KeybindService"):WaitForChild("SendKeybindEvent"):Fire({["Down"] = down, ["Key"] = "Crouching"})
		end)
	end

	local function StartAutoCrouch()
		if crouchConnection then return end
		crouchConnection = RunService.RenderStepped:Connect(function()
			if not AutoCrouch then fireKeybind(false) return end
			local character = Players.LocalPlayer.Character
			if not character or not character:FindFirstChild("Humanoid") then return end
			local humanoid = character.Humanoid
			local isAir = (humanoid.FloorMaterial == Enum.Material.Air) and (humanoid:GetState() ~= Enum.HumanoidStateType.Seated)
			if AutoCrouchMode == "Spam" then
				local currentTime = tick()
				if currentTime - arg_v784 >= CrouchDelay then
					arg_v785 = not arg_v785
					fireKeybind(arg_v785)
					arg_v784 = currentTime
				end
			elseif AutoCrouchMode == "Normal" then fireKeybind(true)
			elseif AutoCrouchMode == "Air" and isAir then fireKeybind(true)
			elseif AutoCrouchMode == "Ground" and not isAir then fireKeybind(true)
			else fireKeybind(false) end
		end)
	end

	local function StopAutoCrouch()
		if crouchConnection then crouchConnection:Disconnect() crouchConnection = nil end
		arg_v784 = 0; arg_v785 = false; fireKeybind(false)
	end

	local CrouchScreenGui = Instance.new("ScreenGui")
	CrouchScreenGui.Name = "CrouchBtnGui"
	CrouchScreenGui.ResetOnSpawn = false
	CrouchScreenGui.Parent = game.CoreGui
	local crouchBtn = Instance.new("TextButton")
	crouchBtn.Size = UDim2.new(0, 120, 0, 40)
	crouchBtn.Position = UDim2.new(0.5, -60, 0.45, 0)
	crouchBtn.Text = "CROUCH: OFF"
	crouchBtn.Font = Enum.Font.GothamBold
	crouchBtn.TextSize = 16
	crouchBtn.TextColor3 = Color3.new(1, 1, 1)
	crouchBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	crouchBtn.BorderSizePixel = 0
	crouchBtn.Active = true
	crouchBtn.Visible = false
	crouchBtn.Parent = CrouchScreenGui
	Instance.new("UICorner", crouchBtn).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", crouchBtn).Color = Color3.fromRGB(255, 49, 49)

	if makeDraggable then makeDraggable(crouchBtn) end

	crouchBtn.MouseButton1Click:Connect(function()
		AutoCrouch = not AutoCrouch
		crouchBtn.Text = AutoCrouch and "CROUCH: ON" or "CROUCH: OFF"
		crouchBtn.BackgroundColor3 = AutoCrouch and Color3.fromRGB(255, 49, 49) or Color3.fromRGB(20, 20, 25)
		if AutoCrouch then StartAutoCrouch() else StopAutoCrouch() end
	end)

	AutoTab:Toggle({ Title = "Auto Crouch", Value = false, Callback = function(state)
		AutoCrouch = state
		crouchBtn.Text = state and "CROUCH: ON" or "CROUCH: OFF"
		if state then StartAutoCrouch() else StopAutoCrouch() end
	end })
	AutoTab:Input({ Title = "Spam Delay (seconds)", Placeholder = "0", NumbersOnly = true, Callback = function(delay) CrouchDelay = tonumber(delay) or 0 end })
	AutoTab:Toggle({ Title = "Show Auto Crouch Button", Value = false, Callback = function(state) crouchBtn.Visible = state end })
	AutoTab:Dropdown({ Title = "Auto Crouch Mode", Values = {"Air", "Spam", "Ground", "Normal"}, Value = "Air", Callback = function(value)
		AutoCrouchMode = value; arg_v784 = 0; arg_v785 = false
		if value ~= "Spam" then fireKeybind(false) end
	end })
end

do
	AutoTab:Section({ Title = "Auto Walk", TextSize = 20 })
	local MOVE_DIRECTION = Vector3.new(0, 0, 1)
	local oldGetMoveVector = nil
	local controlModule = nil
	local autoWalkEnabled = false

	local WalkScreenGui = Instance.new("ScreenGui")
	WalkScreenGui.Name = "WalkBtnGui"
	WalkScreenGui.ResetOnSpawn = false
	WalkScreenGui.Parent = game.CoreGui
	local walkBtn = Instance.new("TextButton")
	walkBtn.Size = UDim2.new(0, 120, 0, 40)
	walkBtn.Position = UDim2.new(0.5, -60, 0.5, 0)
	walkBtn.Text = "WALK: OFF"
	walkBtn.Font = Enum.Font.GothamBold
	walkBtn.TextSize = 16
	walkBtn.TextColor3 = Color3.new(1, 1, 1)
	walkBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	walkBtn.BorderSizePixel = 0
	walkBtn.Active = true
	walkBtn.Visible = false
	walkBtn.Parent = WalkScreenGui
	Instance.new("UICorner", walkBtn).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", walkBtn).Color = Color3.fromRGB(255, 49, 49)

	if makeDraggable then makeDraggable(walkBtn) end

	local function toggleAutoWalk()
		autoWalkEnabled = not autoWalkEnabled
		walkBtn.Text = autoWalkEnabled and "WALK: ON" or "WALK: OFF"
		walkBtn.BackgroundColor3 = autoWalkEnabled and Color3.fromRGB(255, 49, 49) or Color3.fromRGB(20, 20, 25)
		if autoWalkEnabled then
			local success, mod = pcall(function()
				return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
			end)
			if success and mod then
				controlModule = mod
				oldGetMoveVector = controlModule.GetMoveVector
				controlModule.GetMoveVector = function(...)
					local input = oldGetMoveVector(...)
					return input.Magnitude > 0.1 and input or MOVE_DIRECTION
				end
			end
		else
			if controlModule and oldGetMoveVector then
				controlModule.GetMoveVector = oldGetMoveVector
				oldGetMoveVector = nil; controlModule = nil
			end
		end
	end

	walkBtn.MouseButton1Click:Connect(toggleAutoWalk)

	AutoTab:Toggle({ Title = "Auto Walk", Value = false, Callback = function(state)
		if state ~= autoWalkEnabled then toggleAutoWalk() end
	end })
	AutoTab:Toggle({ Title = "Show Auto Walk Button", Value = false, Callback = function(state) walkBtn.Visible = state end })
	AutoTab:Input({ Title = "Move Direction", Placeholder = "X Y Z", Callback = function(value)
		local x, y, z = value:match("([%d.-]+)%s+([%d.-]+)%s+([%d.-]+)")
		if x and y and z then MOVE_DIRECTION = Vector3.new(tonumber(x), tonumber(y), tonumber(z)) end
	end })
end

do
	AutoTab:Section({ Title = "Auto Acceleration", TextSize = 20 })
	local autoAccelerationEnabled = false
	local maxAcceleration = 3
	local minAcceleration = -1
	local maxAutoAccelSpeed = 70

	AutoTab:Toggle({ Title = "Auto Acceleration (Legit)", Value = false, Callback = function(state) autoAccelerationEnabled = state end })
	AutoTab:Input({ Title = "Max Acceleration", Placeholder = "3", NumbersOnly = true, Callback = function(value) local n = tonumber(value) if n then maxAcceleration = n end end })
	AutoTab:Input({ Title = "Min Acceleration", Placeholder = "-1", NumbersOnly = true, Callback = function(value) local n = tonumber(value) if n then minAcceleration = n end end })
	AutoTab:Input({ Title = "Max Speed", Placeholder = "70", NumbersOnly = true, Callback = function(value) local n = tonumber(value) if n and n > 0 then maxAutoAccelSpeed = n end end })
end

do
	AutoTab:Section({ Title = "Bhop", TextSize = 20 })
	local bhopEnabled = false
	local bhopHoldEnabled = false
	local bhopMode = "Acceleration"
	local accelerationValue = -0.2
	local autoJumpType = "Simulation"
	local AutowallHop = false
	local bhopConnection = nil

	local function startBhop()
		if bhopConnection then return end
		bhopConnection = RunService.RenderStepped:Connect(function()
			local char = LocalPlayer.Character
			if not char then return end
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if not humanoid then return end
			if bhopEnabled or bhopHoldEnabled then
				if humanoid.FloorMaterial ~= Enum.Material.Air then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	end

	local function stopBhop()
		if bhopConnection then bhopConnection:Disconnect() bhopConnection = nil end
	end

	local BhopScreenGui = Instance.new("ScreenGui")
	BhopScreenGui.Name = "BhopBtnGui"
	BhopScreenGui.ResetOnSpawn = false
	BhopScreenGui.Parent = game.CoreGui
	local bhopBtn = Instance.new("TextButton")
	bhopBtn.Size = UDim2.new(0, 120, 0, 40)
	bhopBtn.Position = UDim2.new(0.5, -60, 0.55, 0)
	bhopBtn.Text = "BHOP: OFF"
	bhopBtn.Font = Enum.Font.GothamBold
	bhopBtn.TextSize = 16
	bhopBtn.TextColor3 = Color3.new(1, 1, 1)
	bhopBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	bhopBtn.BorderSizePixel = 0
	bhopBtn.Active = true
	bhopBtn.Visible = false
	bhopBtn.Parent = BhopScreenGui
	Instance.new("UICorner", bhopBtn).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", bhopBtn).Color = Color3.fromRGB(255, 49, 49)

	if makeDraggable then makeDraggable(bhopBtn) end

	bhopBtn.MouseButton1Click:Connect(function()
		bhopEnabled = not bhopEnabled
		bhopBtn.Text = bhopEnabled and "BHOP: ON" or "BHOP: OFF"
		bhopBtn.BackgroundColor3 = bhopEnabled and Color3.fromRGB(255, 49, 49) or Color3.fromRGB(20, 20, 25)
		if bhopEnabled then startBhop() else stopBhop() end
	end)

	AutoTab:Toggle({ Title = "Bhop", Value = false, Callback = function(state)
		bhopEnabled = state
		bhopBtn.Text = state and "BHOP: ON" or "BHOP: OFF"
		bhopBtn.BackgroundColor3 = state and Color3.fromRGB(255, 49, 49) or Color3.fromRGB(20, 20, 25)
		if state then startBhop() else stopBhop() end
	end })
	AutoTab:Toggle({ Title = "Bhop Hold Jump", Value = false, Callback = function(state)
		bhopHoldEnabled = state
		if state then startBhop() elseif not bhopEnabled then stopBhop() end
	end })

	local SettingsTab = Window:Tab({
		Title = "Settings",
		Icon = "settings",
		ShowTabTitle = true,
		Border = true
	})

	SettingsTab:Dropdown({
		Title = "Select Theme",
		Desc = "Change menu color theme",
		Values = themes,
		Value = "Rise",
		Callback = function(themeName)
			WindUI:SetTheme(themeName)
		end
	})

	AutoTab:Dropdown({ Title = "Bhop Mode", Values = {"No Acceleration", "Acceleration"}, Value = "Acceleration", Callback = function(value) bhopMode = value end })
	AutoTab:Input({ Title = "Bhop Acceleration (Negative Only)", Placeholder = "-0.2", NumbersOnly = true, Callback = function(value) local n = tonumber(value) if n then accelerationValue = n end end })
	AutoTab:Dropdown({ Title = "Auto Jump Mode", Values = {"Simulation", "Realistic"}, Value = "Simulation", Callback = function(value) autoJumpType = value end })
	AutoTab:Toggle({ Title = "Auto Wall Hop", Value = false, Callback = function(state) AutowallHop = state end })
	AutoTab:Toggle({ Title = "Show Bhop Button", Value = false, Callback = function(state) bhopBtn.Visible = state end })
end
