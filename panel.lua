if RBXL_RUNNING_SCRIPT or _G.RBXL_RUNNING_SCRIPT then return end


if getgenv then
	getgenv().DISABLE_RAYFIELD_REQUESTS = true
end

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "webshares gateway",
	Icon = 105769028533132,
	LoadingTitle = "webshares gateway",
	LoadingSubtitle = "by webshares and bilsr",
	Theme = "Default",
	DisableRayfieldPrompts = true,
	DisableBuildWarnings = true,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "wedontskid",
		FileName = "proxy67676767"
	}
})

local function GetPlayers(str)
	str = tostring(str):lower()
	if str == "me" then
		return {Player}
	end
	if str == "random" then
		return Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
	end
	if str == "all" or str == "everyone" then return Players:GetPlayers() end
	if str:find("others") then
		local plrs = {}
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= Player then
				table.insert(plrs, player)
			end
		end
		return plrs
	end
	local players = {}
	for i, v in pairs(Players:GetPlayers()) do
		if string.find(v.Name:lower(), str) or string.find(v.DisplayName:lower(), str) then
			table.insert(players, v)
		end
	end
	return players
end

local function FindInTable(tab,val)
	for i,v in pairs(tab) do
		if v == val then
			return true
		end
	end
	return false
end

local function Notify(title, content)
	Rayfield:Notify({
		["Title"] = title,
		["Content"] = content,
		["Duration"] = 5,
		["Image"] = "bell"
	})
end

local function ChangeTheme(theme)
	return function()
		Window.ModifyTheme(theme)
	end
end

local function CopyToClipboard(content)
	local CopyClipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
	if CopyClipboard then CopyClipboard(content) return true end
	return false
end

local function MoveCharacter(vector3)
	if Player.Character then
		Player.Character:MoveTo(vector3)
	end
end

local function unequipTool(name)
	if not Player.Character then return end
	for i,v in pairs(Player.Character:GetChildren()) do
		if v:IsA("Tool") and v.Name == name then
			v.Parent = Player.Backpack;
		end
	end
end

local function equipTool(name)
	if not Player.Character then return end
	for i,v in pairs(Player.Backpack:GetChildren()) do
		if v:IsA("Tool") and v.Name == name then
			v.Parent = Player.Character;
		end
	end
end

local UserTab = Window:CreateTab("Hub", "info")
UserTab:CreateSection("Details")
UserTab:CreateLabel("Version: 0.0.6 Private", "history")
UserTab:CreateLabel("Role: Developer", "circle-user-round")

UserTab:CreateDivider()

UserTab:CreateSection("Theme")

UserTab:CreateButton({
	Name = "Default Theme",
	Callback = ChangeTheme("Default")
})

UserTab:CreateButton({
	Name = "Amber Glow Theme",
	Callback = ChangeTheme("AmberGlow")
})

UserTab:CreateButton({
	Name = "Amethyst (Purple) Theme",
	Callback = ChangeTheme("Amethyst")
})

UserTab:CreateButton({
	Name = "Bloom Theme",
	Callback = ChangeTheme("Bloom")
})

UserTab:CreateButton({
	Name = "Dark Blue Theme",
	Callback = ChangeTheme("DarkBlue")
})

UserTab:CreateButton({
	Name = "Green Theme",
	Callback = ChangeTheme("Green")
})

UserTab:CreateButton({
	Name = "Light Theme",
	Callback = ChangeTheme("Light")
})

UserTab:CreateButton({
	Name = "Ocean Theme",
	Callback = ChangeTheme("Ocean")
})

UserTab:CreateButton({
	Name = "Serenity Theme",
	Callback = ChangeTheme("Serenity")
})

local MainTab = Window:CreateTab("Main", "scroll-text")
MainTab:CreateSection("Hubs")

MainTab:CreateButton({
    Name = "Sirius",
    Callback = function()
        loadstring(game:HttpGet('https://sirius.menu/script'))()
    end
})

MainTab:CreateButton({
    Name = "Orca",
    Callback = function()
        loadstring(
  game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/snapshot.lua")
)()
    end
})

MainTab:CreateButton({
    Name = "Wisl",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Bilsurrr/bilsr-hub-rayfield/0c5f3f8ac68b668473e1e64b9e269b62626bb34a/skiubiditoi%20wertlsdfsdgsd"))()
    end
})

MainTab:CreateButton({
    Name = "MoonUI",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IlikeyocutgHAH/MoonUI-v13-102-SCRIPTS/main/MoonUI%20v13!"))()
    end
})

MainTab:CreateButton({
    Name = "SystemBroken",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/bilsr/webshares/refs/heads/main/systembroken.lua"))()
    end
})

MainTab:CreateSection("Games")

MainTab:CreateSection("Misc")
MainTab:CreateButton({
    Name = "Decal Logger",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Image-Logger-29606"))()
    end
})





local SettingsTab = Window:CreateTab("Settings", "settings")

SettingsTab:CreateSection("Settings")

SettingsTab:CreateButton({
    Name = "Self Destruct",
    Callback = function()
        Rayfield:Destroy()
    end
})


SettingsTab:CreateSection("Info")

SettingsTab:CreateLabel("Executor: " .. (identifyexecutor and identifyexecutor() or getexecutorname and getexecutorname() or "******"), "app-window")
SettingsTab:CreateLabel("HWID: " .. RbxAnalyticsService:GetClientId(), "binary")
local HttpService = game:GetService("HttpService")

local http = request or http_request or syn and syn.request or fluxus and fluxus.request

if not http then
    SettingsTab:CreateLabel("HTTP not supported by executor", "x")
    return
end

local success, response = pcall(function()
    return http({
        Url = "https://ipwho.is/",
        Method = "GET"
    })
end)

if not success or not response or not response.Body then
    SettingsTab:CreateLabel("HTTP Request Failed", "x")
    return
end

local data = HttpService:JSONDecode(response.Body)

if not data.success then
    SettingsTab:CreateLabel("IP Lookup Failed", "x")
    return
end

SettingsTab:CreateLabel("IP: " .. tostring(data.ip), "globe")
SettingsTab:CreateLabel("City: " .. tostring(data.city), "map-pin")
SettingsTab:CreateLabel("Region: " .. tostring(data.region), "map")
SettingsTab:CreateLabel("Country: " .. tostring(data.country), "flag")
SettingsTab:CreateLabel(
    "VPN / Proxy: " .. (data.proxy and "Yes" or "No"),
    "shield"
)

task.spawn(function()
	while task.wait(5) do
		Rayfield:SaveConfiguration()
	end
end)

Rayfield:LoadConfiguration()
