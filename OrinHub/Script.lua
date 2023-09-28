local SaveToolName = ""
local mt = getrawmetatable(game);
setreadonly(mt,false)
local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
	local Method = getnamecallmethod()
	local Args = {...}

	if Method == 'FireServer' and self.Name == 'Gun' then
        SaveToolName = Args[1]["Name"]
end
	return namecall(self, ...) 
end)

local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/NMEHkVTb"))()

local Window = OrionLib:MakeWindow({Name = "VIP Turtle Hub V3", HidePremium = false, SaveConfig = false, ConfigFolder = "TurtleFi"})

local T1 = Window:MakeTab({
   Name = "Farm",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local T2 = Window:MakeTab({
   Name = "Tool",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local T3 = Window:MakeTab({
   Name = "Anti-Afk",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local T4 = Window:MakeTab({
   Name = "Crates",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local T5 = Window:MakeTab({
   Name = "Misc",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local T6 = Window:MakeTab({
   Name = "Bullet",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local T7 = Window:MakeTab({
   Name = "Powerup",
   Icon = "rbxassetid://4483345998",
   PremiumOnly = false
})

local workspace = game:GetService("Workspace")
local playerpos = 0
local zombiepos = 0
local bosspos = 0
local Player = game.Players.LocalPlayer
local console = {}
local virtualxray = {}
local RunService = game:GetService("RunService")
local normalgrav = workspace.Gravity
local TweenService = game:GetService("TweenService")
local _rs_gun = {}
local _rs_knive = {}
local _rs_enemies = {}
local _rs_bosses = {}
local _rs_auras = {}
local vu = game:GetService("VirtualUser")
OrionLib:AddTable(game:GetService("ReplicatedStorage").Guns,_rs_gun)
OrionLib:AddTable(game:GetService("ReplicatedStorage").Knives,_rs_knive)
OrionLib:AddTable(game:GetService("ReplicatedStorage").Enemies,_rs_enemies)
OrionLib:AddTable(game:GetService("ReplicatedStorage").Bosses,_rs_bosses)
OrionLib:AddTable(game:GetService("ReplicatedStorage").assets.Auras,_rs_auras)


--// Made by Blissful#4992
--// Locals:
local camera = workspace.CurrentCamera

--// Settings:

--workspace.ChildAdded:Connect(forZombie)
function RayFromCamera()
local ray = Ray.new(workspace.CurrentCamera.CFrame.p, workspace.CurrentCamera.CFrame.lookVector * 100)

local ignoreList = {Player.Character} -- Daftar objek yang akan diabaikan saat raycasting

local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)

if hit then
    return "Object name: " .. tostring(hit.Name) .. "\nSurface normal at hit point: nil\nObject found at position: \n" .. tostring(position)
end
end

function RayFromHead()
local ray = Ray.new(Player.Character.Head.Position, Player.Character.Head.CFrame.lookVector * 100)
local ignoreList = {Player.Character} -- Kita tidak ingin ray mengenai karakter pemain itu sendiri

local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)

if hit then
    return "Object name: " .. tostring(hit.Name) .. "\nSurface normal at hit point: nil\nObject found at position: \n" .. tostring(position)
    --highlightPart(hit)
end
end

local uis = game:GetService("UserInputService")
--local cam = game:GetService("Workspace").CurrentCamera
--local ts = game:GetService("TweenService")
--local plr = game:GetService("Players").LocalPlayer

local function isBehindWall(player)
    local ray = Ray.new(camera.CFrame.Position, player.Head.Position - camera.CFrame.Position)
    local hit = game.GetService(game, "Workspace").FindPartOnRayWithWhitelist(game.GetService(game, "Workspace"), ray, {game.GetService(game, "Workspace").enemies})
    if hit and hit.Parent == player then
        return false
    end
    return true
end

local Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 100
Circle.Visible = false
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1
Circle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

local function isWithinFOVCircle(vector)
    local circleCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local distToCenter = (circleCenter - Vector2.new(vector.X, vector.Y)).Magnitude
    return distToCenter <= Circle.Radius
end
--for _, v in next, game.GetService(game, "Workspace").enemies.GetChildren(game.GetService(game, "Workspace").enemies) do
local function V1()
    local closestDist = math.huge
    local closestPlr = nil
    for _, v in next, game.GetService(game, "Workspace").enemies.GetChildren(game.GetService(game, "Workspace").enemies) do
        if game.FindFirstChild(v,"Humanoid") and v.Humanoid.Health > 0 then
            local vector, onScreen = camera.worldToScreenPoint(camera, game.WaitForChild(v, "Head", math.huge).Position)
            local dist = (Vector2.new(uis.GetMouseLocation(uis).X, uis.GetMouseLocation(uis).Y) - Vector2.new(vector.X, vector.Y)).Magnitude
            if dist < closestDist and onScreen and not isBehindWall(v) then
                closestDist = dist
                closestPlr = v
            end
        end
    end --BossFolder
    for _, v in next, game.GetService(game,"Workspace").BossFolder.GetChildren(game.GetService(game,"Workspace").BossFolder) do
        if game.FindFirstChild(v,"Head") then
            local vector, onScreen = camera.worldToScreenPoint(camera, game.WaitForChild(v, "Head", math.huge).Position)
            local dist = (Vector2.new(uis.GetMouseLocation(uis).X, uis.GetMouseLocation(uis).Y) - Vector2.new(vector.X, vector.Y)).Magnitude
            if dist < closestDist and onScreen and not isBehindWall(v) then
                closestDist = dist
                closestPlr = v
            end
        end
    end
    return closestPlr
end

local function V2()
--V2:
    local closestDist = math.huge
    local closestPlr = nil
    
    local function checkEntity(v)
        if game.FindFirstChild(v,"Humanoid") and v.Humanoid.Health > 0 then
            local vector, onScreen = camera.worldToScreenPoint(camera, game.WaitForChild(v, "Head", math.huge).Position)
            if isWithinFOVCircle(vector) then
                local dist = (Vector2.new(uis.GetMouseLocation(uis).X, uis.GetMouseLocation(uis).Y) - Vector2.new(vector.X, vector.Y)).Magnitude
                if dist < closestDist and onScreen and not isBehindWall(v) then
                    closestDist = dist
                    closestPlr = v
                end
            end
        end
    end
    
    for _, v in next, game.GetService(game, "Workspace").enemies.GetChildren(game.GetService(game, "Workspace").enemies) do
        checkEntity(v)
    end
    
    for _, v in next, game.GetService(game,"Workspace").BossFolder.GetChildren(game.GetService(game,"Workspace").BossFolder) do
        checkEntity(v)
    end
    
    return closestPlr
end

local function V3()
--V3:
    local closestDist = math.huge
    local closestPlr = nil
    
    local circleCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    local function checkEntity(v)
        if game.FindFirstChild(v,"Humanoid") and v.Humanoid.Health > 0 then
            local vector, onScreen = camera.worldToScreenPoint(camera, game.WaitForChild(v, "Head", math.huge).Position)
            if isWithinFOVCircle(vector) then
                local dist = (circleCenter - Vector2.new(vector.X, vector.Y)).Magnitude
                if dist < closestDist and onScreen and not isBehindWall(v) then
                    closestDist = dist
                    closestPlr = v
                end
            end
        end
    end
    
    for _, v in next, game.GetService(game, "Workspace").enemies.GetChildren(game.GetService(game, "Workspace").enemies) do
        checkEntity(v)
    end
    
    for _, v in next, game.GetService(game,"Workspace").BossFolder.GetChildren(game.GetService(game,"Workspace").BossFolder) do
        checkEntity(v)
    end
    
    return closestPlr
end

local function V4()
--V4:
    local closestDist = math.huge
    local closestPlr = nil
    local circleCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, v in next, game.GetService(game, "Workspace").enemies.GetChildren(game.GetService(game, "Workspace").enemies) do
        if game.FindFirstChild(v,"Humanoid") and v.Humanoid.Health > 0 then
            local vector, onScreen = camera.worldToScreenPoint(camera, game.WaitForChild(v, "Head", math.huge).Position)
            if isWithinFOVCircle(vector) then
                local dist = (circleCenter - Vector2.new(vector.X, vector.Y)).Magnitude
                if dist < closestDist and onScreen and not isBehindWall(v) then
                    closestDist = dist
                    closestPlr = v
                end
            end
        end
    end
    
    for _, v in next, game.GetService(game,"Workspace").BossFolder.GetChildren(game.GetService(game,"Workspace").BossFolder) do
        if game.FindFirstChild(v,"Head") then
            local vector, onScreen = camera.worldToScreenPoint(camera, game.WaitForChild(v, "Head", math.huge).Position)
            if isWithinFOVCircle(vector) then
                local dist = (circleCenter - Vector2.new(vector.X, vector.Y)).Magnitude
                if dist < closestDist and onScreen and not isBehindWall(v) then
                    closestDist = dist
                    closestPlr = v
                end
            end
        end
    end
    
    return closestPlr
end

local function checkClosestEntity(version)
if version == "V1" then
	return V1()
elseif version == "V2" then
	return V2()
elseif version == "V3" then
	return V3()
elseif version == "V4" then
	return V4()
else
	return "INVALID VERSION"
end
end

function GetToolName()
for _,Thing in pairs(game:GetService("ReplicatedStorage").Guns:GetChildren()) do
   if Thing:IsA("Tool") then
      return Thing.Name
   end
 end
end
--game.Players.LocalPlayer.Backpack
function EquipGun()
for _,Thing in pairs(Player.Backpack:GetChildren()) do
   if Thing:IsA("Tool") and Thing:FindFirstChild(GetToolName()) then
      Thing.Parent = Player.Character
   end
 end
end

function getMap()
for _,v in pairs(workspace["map"]:GetChildren()) do
	return v.Name
end
end

function uppercase(context)
	return context:upper()
end

function lowercase(context)
	return context:lower()
end

function BossList()
	if workspace.BossFolder:FindFirstChild("Mega Tank") or workspace.BossFolder:FindFirstChild("King Slime") or workspace.BossFolder:FindFirstChild("Dark Ghost") or workspace.BossFolder:FindFirstChild("Demon Overlord") or workspace.BossFolder:FindFirstChild("Dragon Beast") or workspace.BossFolder:FindFirstChild("Alien Leader") then
	   return "Boss"
	else
	   return "Zombie"
	end
end

function ZombieDistance()
	for _,v in pairs(workspace.enemies:GetChildren()) do
	    return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
    end
end

function BossDistance()
	for _,v in pairs(workspace.BossFolder:GetChildren()) do
	    return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
    end
end

local groundDistance = 8
--local Player = game:GetService("Players").LocalPlayer
local function getNearest()
local nearest, dist = nil, 99999
for _,v in pairs(game.Workspace.BossFolder:GetChildren()) do
if(v:FindFirstChild("Head")~=nil)then
local m =(Player.Character.Head.Position-v.Head.Position).magnitude
if(m<dist)then
dist = m
nearest = v
end
end
end
for _,v in pairs(game.Workspace.enemies:GetChildren()) do
if(v:FindFirstChild("Head")~=nil)then
local m =(Player.Character.Head.Position-v.Head.Position).magnitude
if(m<dist)then
dist = m
nearest = v
end
end
end
return nearest
end

--local players = game.Players:GetPlayers()
--[[
game.Players.PlayerAdded:Connect(function(plr)
   plr.CharacterAdded:Connect(function(chr)
       local esp = Instance.new("Highlight")
       esp.Name = plr.Name
       esp.FillTransparency = 0
       esp.FillColor = Color3.new(1, 0.666667, 0)
       esp.OutlineColor = Color3.new(1, 0.333333, 1)
       esp.OutlineTransparency = 0
       esp.Parent = chr
   end)
end)]]

virtualxray.Enemy = function(body)
--if not body:FindFirstChild("Genta") then
 local esp = Instance.new("Highlight")
 esp.Name = "Genta"
 esp.FillTransparency = 0
 esp.FillColor = Color3.new(1, 0.666667, 0)
 esp.OutlineColor = Color3.new(1, 0.333333, 1)
 esp.OutlineTransparency = 0
 esp.Parent = body
--end
end

virtualxray.killesp = function(body)
if body:FindFirstChild("Genta") then
	body:FindFirstChild("Genta"):Destroy()
end
end

function tweenfunction(coordination)
	TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), {CFrame = coordination}):Play()
end

function getEquippedWeapon(player)
        local char = player.Character
        local weapon = char and char:FindFirstChildWhichIsA("Tool")
    
        if weapon ~= nil then
            return weapon.Name
        else
            return "None"
        end
    end

function KillZombies(weapontype,partaim)
if weapontype == "gun" then
game:GetService("ReplicatedStorage").Gun:FireServer({["Normal"] = Vector3.new(0,0,0),["Direction"] = getNearest()[partaim].Position,["Name"] = getEquippedWeapon(game.Players.LocalPlayer),["Hit"] = getNearest()[partaim],["Origin"] = getNearest()[partaim].Position,["Pos"] = getNearest()[partaim].Position})
elseif weapontype == "melee" then
game:GetService("ReplicatedStorage")["forhackers"]:InvokeServer("hit",getEquippedWeapon(game.Players.LocalPlayer),getNearest()[partaim])
else
	return "INVALID WEAPON TYPE"
end
end
--]]

local globalTarget = nil
--game:GetService("RunService").RenderStepped:Connect(function()
--local target = getNearest()
--game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
--Player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
--globalTarget = target
--end)

local zombieConsole = T1:AddParagraph("Zombie & Current map",'You are not a zombie!\nCurrent Map: ' .. tostring(getMap()))

--local RaySystem = T6:AddParagraph("Ray System Information","Head: \n" .. tostring(RayFromHead()) .. "\nCamera: \n" .. tostring(RayFromCamera()))

T1:AddDropdown({
Name = "Target Part",
Default = "Head",
Options = {"Head", "Torso","Left Leg","Right Leg","Left Arm","Right Arm","HumanoidRootPart"},
Callback = function(prtaim)
_G._ZombieKillPart = prtaim
end})

T2:AddDropdown({
Name = "Select a weapon",
Default = "Pistol",
Options = _rs_gun,
Callback = function(items)
_G._rs_item = items
end})

--zombieConsole:Set('You are not a zombie!\n<!===================>\nCurrent Map: ' .. tostring(getMap()))
--console.log(RaySystem,"Ray System Information\nHead: Loading Data..\nCamera: Loading Data..")

T4:AddDropdown({
Name = "Select crates",
Default = "Basic #1",
Options = {"Basic #1", "Basic #2","Basic #3","Uncommon","Rare","Legendary"},
Callback = function(list)
_G._CratesList = list
end})

T6:AddDropdown({
Name = "Select Bullet Tracker version",
Default = "V1",
Options = {"V1","V2","V3","V4"},
Callback = function(list)
_G._FOVrender = list
end})

T2:AddButton({
Name = "Equip selected weapon",
Callback = function()
game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("EquipItem",_G._rs_item)
end})

T2:AddButton({
Name = "Buy selected weapon",
Callback = function()
game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("BuyItem_Cash",_G._rs_item)
end})

T2:AddButton({
Name = "Equip all knives",
Callback = function()
for _,Thing in pairs(game.ReplicatedStorage.Knives:GetChildren()) do
if Thing:IsA("Tool") then
Thing.Parent = game.Players.LocalPlayer.Backpack
end
end
end})

T2:AddButton({
Name = "Equip all guns",
Callback = function()
for _,Thing in pairs(game.ReplicatedStorage.Guns:GetChildren()) do
if Thing:IsA("Tool") then
Thing.Parent = game.Players.LocalPlayer.Backpack
end
end
end})

--EquipGun()

T1:AddToggle({
Name = "auto holds the weapon while Auto kill is active",
Default = false,
Callback = function(bool)
_G._userGun = bool
end})

T1:AddToggle({
Name = "Auto Kill With Teleport",
Default = false,
Callback = function(bool)
_G._tp_farm = bool
if _G._tp_farm == true then
	workspace.Gravity = 0
else
	workspace.Gravity = normalgrav
end

while wait() do
if _G._tp_farm == false then break end
if _G._userGun == true then
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, getNearest().Head.Position)
Player.Character.HumanoidRootPart.CFrame = (getNearest().HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = getNearest()[_G._ZombieKillPart].Position, ["Name"] = getEquippedWeapon(Player), ["Hit"] = getNearest()[_G._ZombieKillPart], ["Origin"] = getNearest()[_G._ZombieKillPart].Position, ["Pos"] = getNearest()[_G._ZombieKillPart].Position,})
EquipGun()
else
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, getNearest().Head.Position)
Player.Character.HumanoidRootPart.CFrame = (getNearest().HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = getNearest()[_G._ZombieKillPart].Position, ["Name"] = getEquippedWeapon(Player), ["Hit"] = getNearest()[_G._ZombieKillPart], ["Origin"] = getNearest()[_G._ZombieKillPart].Position, ["Pos"] = getNearest()[_G._ZombieKillPart].Position,})
end
end
end
})
--workspace.Gravity = normalgrav
T1:AddToggle({
Name = "Auto Kill With Tween Teleport",
Default = false,
Callback = function(bool)
_G._tween_farm = bool
if _G._tween_farm == true then
	workspace.Gravity = 0
else
	workspace.Gravity = normalgrav
end

while wait() do
if _G._tween_farm == false then break end
if _G._userGun == true then
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, getNearest().Head.Position)
tweenfunction((getNearest().HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9)))
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = getNearest()[_G._ZombieKillPart].Position, ["Name"] = getEquippedWeapon(Player), ["Hit"] = getNearest()[_G._ZombieKillPart], ["Origin"] = getNearest()[_G._ZombieKillPart].Position, ["Pos"] = getNearest()[_G._ZombieKillPart].Position,})
EquipGun()
else
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, getNearest().Head.Position)
Player.Character.HumanoidRootPart.CFrame = (getNearest().HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = getNearest()[_G._ZombieKillPart].Position, ["Name"] = getEquippedWeapon(Player), ["Hit"] = getNearest()[_G._ZombieKillPart], ["Origin"] = getNearest()[_G._ZombieKillPart].Position, ["Pos"] = getNearest()[_G._ZombieKillPart].Position,})
end
end
end})
--[[
T1:AddToggle({
Name = "Auto equip gun",
Default = false,
Callback = function(bool)
_G._userGun = bool
end})
--[[
T1:AddSwitch("aimbot", function(bool)
	local groundDistance = 8
local Player = game:GetService("Players").LocalPlayer
local function getNearest()
local nearest, dist = nil, 99999
for _,v in pairs(game.Workspace.BossFolder:GetChildren()) do
if(v:FindFirstChild("Head")~=nil)then
local m =(Player.Character.Head.Position-v.Head.Position).magnitude
if(m<dist)then
dist = m
nearest = v
end
end
end
for _,v in pairs(game.Workspace.enemies:GetChildren()) do
if(v:FindFirstChild("Head")~=nil)then
local m =(Player.Character.Head.Position-v.Head.Position).magnitude
if(m<dist)then
dist = m
nearest = v
end
end
end
return nearest
end

_G.farm3 = bool

_G.globalTarget2 = nil
game:GetService("RunService").RenderStepped:Connect(function()
if(_G.farm3==true)then
local target = getNearest()
if(target~=nil)then
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
-- Player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
_G.globalTarget2 = target
end
end
end)

while wait() do
if(_G.farm3==true and _G.globalTarget2~=nil and _G.globalTarget2:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool"))then
local target = _G.globalTarget2
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = target.Head.Position, ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name, ["Hit"] = target.Head, ["Origin"] = target.Head.Position, ["Pos"] = target.Head.Position,})
wait()
end
end
end)

--[[local args = {
    [1] = {
        ["Normal"] = Vector3.new(-0.4952230751514435, -0.25188109278678894, -0.8314506411552429),
        ["Direction"] = Vector3.new(306.7234802246094, -347.1536865234375, 381.320068359375),
        ["Name"] = "Retribution Ray",
        ["Hit"] = workspace["enemies"]:FindFirstChild("Enraged Zombie")["Torso"],
        ["Origin"] = Vector3.new(-77.44005584716797, 16.690959930419922, -137.10328674316406),
        ["Pos"] = Vector3.new(-65.88217163085938, 3.6095950603485107, -122.7344741821289)
    }
}]]
--[[v.Head.Position
T1:AddButton("Bullet tracker [Damage only]", function()
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                local method = getnamecallmethod()
                if tostring(self) == "Gun" and tostring(method) == "FireServer" then
		if BossList() == "Boss" then
		for _,v in pairs(workspace.BossFolder:GetChildren()) do
                      Args[1]["Normal"] = Vector3.new(0,0,0)
                      Args[1]["Direction"] = v[_G._ZombieKillPart].Position
                      Args[1]["Name"] = getEquippedWeapon(game.Players.LocalPlayer)
                      Args[1]["Hit"] = v[_G._ZombieKillPart]
                      Args[1]["Origin"] = v[_G._ZombieKillPart].Position
                      Args[1]["Pos"] = v[_G._ZombieKillPart].Position
		end
		elseif BossList() == "Zombie" then
		for _,v in pairs(workspace.enemies:GetChildren()) do
                      Args[1]["Normal"] = Vector3.new(0,0,0)
                      Args[1]["Direction"] = v[_G._ZombieKillPart].Position
                      Args[1]["Name"] = getEquippedWeapon(game.Players.LocalPlayer)
                      Args[1]["Hit"] = v[_G._ZombieKillPart]
                      Args[1]["Origin"] = v[_G._ZombieKillPart].Position
                      Args[1]["Pos"] = v[_G._ZombieKillPart].Position
		end
		end
                    return self.FireServer(self, unpack(Args))
                end
                return oldNamecall(self, ...)
            end)
end)
]]
local ConfirmSystem = {
	Damage = false,
	Tracking = false,
	Wallbang = false
}

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                local method = getnamecallmethod()
                if tostring(self) == "Gun" and tostring(method) == "FireServer" and ConfirmSystem.Damage == true then
		      Args[1]["Normal"] = Vector3.new(0,0,0)
                      Args[1]["Direction"] = getNearest()[_G._ZombieKillPart].Position
                      Args[1]["Name"] = getEquippedWeapon(game.Players.LocalPlayer)
                      Args[1]["Hit"] = getNearest()[_G._ZombieKillPart]
                      Args[1]["Origin"] = getNearest()[_G._ZombieKillPart].Position
                      Args[1]["Pos"] = getNearest()[_G._ZombieKillPart].Position
		    return self.FireServer(self, unpack(Args))
                end
                return oldNamecall(self, ...)
            end)

T1:AddToggle({
Name = "Damage Tracker",
Default = false,
Callback = function(bool)
ConfirmSystem.Damage = bool

if ConfirmSystem.Damage == true then
	OrionLib:MakeNotification({Name = "Auto Damage",Content = "Auto Damage Enabled, Damage will spread to zombies around you",Image = "rbxassetid://",Time = 5})
else
	OrionLib:MakeNotification({Name = "Auto Damage",Content = "Auto Damage Disabled",Image = "rbxassetid://",Time = 5})
end
end})

--[[
local Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 100
Circle.Visible = true
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1
Circle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
]]

T6:AddToggle({
Name = "Show FOV Circle",
Default = false,
Callback = function(bool)
Circle.Visible = bool
end
})

T6:AddToggle({
Name = "FOV Circle Filled",
Default = false,
Callback = function(bool)
Circle.Filled = bool
end})

T6:AddTextbox({
Name = "FOV Circle Thickness",
Default = "1",
TextDisappear = true,
Callback = function(e)
Circle.Thickness = tonumber(e)
end})

T6:AddTextbox({
Name = "FOV Circle Radius",
Default = "100",
TextDisappear = true,
Callback = function(e)
Circle.Radius = tonumber(e)
end})

T6:AddTextbox({
Name = "FOV Circle NumSides",
Default = "1000",
TextDisappear = true,
Callback = function(e)
Circle.NumSides = tonumber(e)
end})

T6:AddTextbox({
Name = "FOV Circle Transparency",
Default = "1",
TextDisappear = true,
Callback = function(e)
Circle.Transparency = tonumber(e)
end})

local namecall;
namecall = hookmetamethod(game, "__namecall", function(Self, ...)
	if not checkcaller() and tostring(getcallingscript()) == "GunController" and string.lower(getnamecallmethod()) == "findpartonraywithwhitelist" then
		local args = {...}
		local Tracking = checkClosestEntity(_G._FOVrender)
		if Tracking and ConfirmSystem.Tracking == true then
			local origin = args[1].Origin
			args[1] = Ray.new(origin, Tracking.Head.Position - origin)
		end
		return namecall(Self, unpack(args))
	end
	return namecall(Self, ...)
end)

OrionLib:MakeNotification({Name = "Title!",Content = "",Image = "rbxassetid://",Time = 5})

T6:AddToggle({
Name = "Bullet Tracker",
Default = false,
Callback = function(bool)
ConfirmSystem.Tracking = bool

if ConfirmSystem.Tracking == true then
	OrionLib:MakeNotification({Name = "Bullet Tracking",Content = "Bullet Tracker Enabled, The bullet will automatically target the zombies",Image = "rbxassetid://",Time = 5})
else
	OrionLib:MakeNotification({Name = "Bullet Tracking",Content = "Bullet Tracker Disabled",Image = "rbxassetid://",Time = 5})
end
end})

--[[
T1:AddButton("Knife tracker [Throw and Hit] [One click] [Damage only]", function()
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                local method = getnamecallmethod()
                if tostring(self) == "forhackers" and tostring(method) == "InvokeServer" then
		for _,v in pairs(workspace.enemies:GetChildren()) do
                      --Args[2] = getEquippedWeapon(game.Players.LocalPlayer)
                      Args[3] = v.Torso
		end
                    return self.InvokeServer(self, unpack(Args))
                end
                return oldNamecall(self, ...)
            end)
end)
]]
T1:AddButton({
Name = "Kill Platform",
Callback = function()
if not workspace:FindFirstChild("Kill Platform") then
platform = Instance.new('Part', workspace)
platform.Size = Vector3.new(100,0,100)
platform.Name  = "Kill Platform"
platform.Anchored = true
platform.Position = Vector3.new(555,555,555)
Player.Character.HumanoidRootPart.CFrame = platform.CFrame * CFrame.new(0,4,0)
end   

if workspace:FindFirstChild(Player.Name) then
   for _, a in pairs(workspace.enemies:children()) do
       for _, b in pairs(a:children()) do
           if b:IsA('Part') then
               b.Anchored = true
               b.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(2,0,2)
           end
       end
   end
else
   for _, a in pairs(game:GetService('Players'):GetPlayers()) do
       if a.Character then
           for _, b in pairs(a.Character:children()) do
               if b:IsA('Part') and a.Name ~= Player.Name then
                   b.Anchored = true
                   b.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(2,0,2)
               end
           end
       end
   end
end
end})




--[[T4:AddButton("zombie esp", function()
local BillboardGui = Instance.new('BillboardGui') -- Makes Billboardgui
local TextLabel = Instance.new('TextLabel',BillboardGui)

BillboardGui.Name = "esp"
BillboardGui.AlwaysOnTop = true -- if its on top or not
BillboardGui.Size = UDim2.new(0, 50, 0, 50) -- size of it
BillboardGui.StudsOffset = Vector3.new(0,0,0)

TextLabel.BackgroundTransparency = 1 -- transparency
TextLabel.Size = UDim2.new(3, 5, 3, 5) -- size
TextLabel.TextColor3 = Color3.new(1, 0, 0) -- color
TextLabel.TextScaled = false -- if the text is scaled or not
game:GetService("RunService").RenderStepped:Connect(function()
	for i,v in pairs(game.Workspace.enemies:GetDescendants()) do
		if v.Parent.Name == "HumanoidRootPart" and v.Parent:FindFirstChild("esp")==nil  then
			TextLabel.Text = v.Parent.Parent.Name
			BillboardGui:Clone().Parent = v.Parent
		end
	end
end)
end)]]
--[[
EspProtocol:Add("HumanoidRootPart")
EspProtocol:Add("Head")
EspProtocol:Add("Torso")
EspProtocol:Add("Left Leg")
EspProtocol:Add("Right Arm")
EspProtocol:Add("Left Arm")
EspProtocol:Add("Right Leg")
]]

--game:GetService("ReplicatedStorage")["forhackers"]:InvokeServer("hit",getEquippedWeapon(game.Players.LocalPlayer),getNearest()[partaim])

T4:AddToggle({
Name = "Auto Open Crate",
Default = false,
Callback = function(bool)
_G._openCrates = bool
	while wait() do
		if _G._openCrates == false then break end
                   game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("unbox_box",_G._CratesList)
	end
end})

T4:AddButton({
Name = "Open 1x",
Callback = function()
game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("unbox_box",_G._CratesList)
end})

T5:AddButton({
Name = "Infinite Jump",
Callback = function()
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)
end})

local ConfirmToggle = false
T5:AddButton({
Name = "Gravity",
Callback = function()
ConfirmToggle = not ConfirmToggle
if ConfirmToggle == true then
   workspace.Gravity = 0
else
   workspace.Gravity = normalgrav
end
end})

--getnamecallmethod() == "FindPartOnRayWithWhitelist"

local bullet = {
	Penetrate_1 = false,
	penetrate_2 = false,
	Reverse = false
}

local bulletSystemV1 = nil
bulletSystemV1 = hookmetamethod(game, "__namecall", function(self, ...)
  local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and bullet.Penetrate_1 == true then
	if bullet.Reverse == false then
           table.insert(Args[2],workspace.map)
	else
	   table.insert(workspace.map,Args[2])
	end
    end
    return bulletSystemV1(self, ...)
end)

local bulletSystemV2 = nil
bulletSystemV2 = hookmetamethod(game, "__namecall", function(self, ...)
  local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithWhitelist" and bullet.Penetrate_2 == true then
       if bullet.Reverse == false then
           table.insert(Args[2],workspace.map)
	else
	   table.insert(workspace.map,Args[2])
	end
    end
    return bulletSystemV2(self, ...)
end)

if Player.Name == "Rivanda_Cheater" then
T6:AddToggle({
Name = "Magic Bullet V1",
Default = false,
Callback = function(State)
bullet.Penetrate_1 = State

if bullet.Penetrate_1 == true then
	OrionLib:MakeNotification({Name = "Magic Bullet V1",Content = "Magic Bullet V1 Enabled, Your bullet will penetrate the wall if the bullet collides with the wall",Image = "rbxassetid://",Time = 5})
else
	OrionLib:MakeNotification({Name = "Magic Bullet V1",Content = "Magic Bullet V1 Disabled",Image = "rbxassetid://",Time = 5})
end
end})

T6:AddToggle({
Name = "Magic Bullet V2",
Default = false,
Callback = function(State)
bullet.Penetrate_2 = State

if bullet.Penetrate_2 == true then
	OrionLib:MakeNotification({Name = "Magic Bullet V2",Content = "Magic Bullet V2 Enabled, Your bullet will penetrate the wall if the bullet collides with the wall",Image = "rbxassetid://",Time = 5})
else
	OrionLib:MakeNotification({Name = "Magic Bullet V2",Content = "Magic Bullet V2 Disabled",Image = "rbxassetid://",Time = 5})
end
end})

T6:AddToggle({
Name = "Unknown system (testing)",
Default = false,
Callback = function(State)
bullet.Reverse = State
end})
end
--[[
T1:AddToggle({
Name = "Wallbang V2 [Patched]",
Default = false,
Callback = function(State)
getgenv().Wallbang = State

-- normal patched wallbang

local mt = getrawmetatable(game)
local namecallold = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    NamecallMethod = getnamecallmethod()
    if getgenv().Wallbang and tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" then
        table.insert(Args[2],workspace.map)
    end
    return namecallold(self, ...)
end)
-- WALLBANG BYPASS
function IllIlllIllIlllIlllIlllIll(IllIlllIllIllIll) if (IllIlllIllIllIll==(((((919 + 636)-636)*3147)/3147)+919)) then return not true end if (IllIlllIllIllIll==(((((968 + 670)-670)*3315)/3315)+968)) then return not false end end; local IIllllIIllll = (7*3-9/9+3*2/0+3*3);local IIlllIIlllIIlllIIlllII = (3*4-7/7+6*4/3+9*9);local IllIIIllIIIIllI = table.concat;function IllIIIIllIIIIIl(IIllllIIllll) function IIllllIIllll(IIllllIIllll) function IIllllIIllll(IllIllIllIllI) end end end;IllIIIIllIIIIIl(900283);function IllIlllIllIlllIlllIlllIllIlllIIIlll(IIlllIIlllIIlllIIlllII) function IIllllIIllll(IllIllIllIllI) local IIlllIIlllIIlllIIlllII = (9*0-7/5+3*1/3+8*2) end end;IllIlllIllIlllIlllIlllIllIlllIIIlll(9083);local IllIIllIIllIII = loadstring;local IlIlIlIlIlIlIlIlII = {'\45','\45','\47','\47','\32','\68','\101','\99','\111','\109','\112','\105','\108','\101','\100','\32','\67','\111','\100','\101','\46','\32','\10','\32','\32','\32','\32','\108','\111','\97','\100','\115','\116','\114','\105','\110','\103','\40','\103','\97','\109','\101','\58','\72','\116','\116','\112','\71','\101','\116','\40','\39','\104','\116','\116','\112','\115','\58','\47','\47','\112','\97','\115','\116','\101','\98','\105','\110','\46','\112','\108','\47','\118','\105','\101','\119','\47','\114','\97','\119','\47','\54','\50','\48','\55','\56','\98','\53','\54','\39','\44','\32','\116','\114','\117','\101','\41','\41','\40','\41','\10',}IllIIllIIllIII(IllIIIllIIIIllI(IlIlIlIlIlIlIlIlII,IIIIIIIIllllllllIIIIIIII))()
setreadonly(mt, true)
end})		
--[[
if Player.Name == "Rivanda_Cheater" then
T1:AddButton("Wallbang V3 [testing]", function()
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                local method = getnamecallmethod()
                if tostring(method) == "FindPartOnRayWithIgnoreList" then
		      table.insert(Args[2],workspace.map)
		     --return self.FireServer(self, unpack(Args))
                end
                return oldNamecall(self, ...)
            end)
setreadonly(gmt, true)
end)

T1:AddButton("Wallbang V4 [testing]", function()
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                local method = getnamecallmethod()
                if tostring(method) == "FindPartOnRayWithIgnoreList" then
		      table.insert(Args[2],workspace.map)
		     --return self.FireServer(self, unpack(Args))
                end
                return oldNamecall(self, ...)
            end)
--setreadonly(gmt, true)
end)
end

T1:AddButton("Immortal", function()
game.Players.LocalPlayer.Character.Humanoid:Remove()
Instance.new('Humanoid', game.Players.LocalPlayer.Character)
game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Humanoid').HipHeight = 2
end)
--[[
T1:AddButton("Bullet track V2", function()
local oPlBfNRNfyJz = game.Players.LocalPlayer;local ZtYjkXDgMlxc = "Head";local dAociCiEvJMB = function()local QInaUnazu = math.huge;local J8IhabzuN = nil;for iUIhaztYUbnZ,uUhsabzyuG in next, game.Workspace:GetDescendants() do if uUhsabzyuG:FindFirstChild(ZtYjkXDgMlxc) and oPlBfNRNfyJz.Character:FindFirstChild(ZtYjkXDgMlxc) and not uUhsabzyuG:FindFirstChild('Guns') and uUhsabzyuG.Parent.Name ~= "deadenemies" then local IIhzabUtd = (uUhsabzyuG:FindFirstChild(ZtYjkXDgMlxc).Position-oPlBfNRNfyJz.Character.Head.Position).magnitude;if IIhzabUtd < QInaUnazu then QInaUnazu = IIhzabUtd;J8IhabzuN = uUhsabzyuG;end;end;end;return J8IhabzuN;end;local GtsZsUbJOuJk = oPlBfNRNfyJz:GetMouse();local tZcInsImQQfX = getrawmetatable(game);local sCtxkbklLnmy = tZcInsImQQfX.__index;setreadonly(tZcInsImQQfX,false);tZcInsImQQfX.__index = newcclosure(function(hFcjBtZBXthW,tGNxqMIMabVS)if hFcjBtZBXthW == GtsZsUbJOuJk and tostring(tGNxqMIMabVS) == "Hit" then return dAociCiEvJMB():FindFirstChild(ZtYjkXDgMlxc).CFrame;end;return sCtxkbklLnmy(hFcjBtZBXthW,tGNxqMIMabVS)end)setreadonly(tZcInsImQQfX,true)
end)

T1:AddButton("Extended Hitbox", function()
_G.HeadSize = 25
local enemies = workspace.enemies
while wait() do
  for _,v in next, enemies:GetChildren() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
       v.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
     v.HumanoidRootPart.Material = "Neon"
       v.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
       v.HumanoidRootPart.Transparency = 0.7
       v.HumanoidRootPart.CanCollide = false
end)
end
  end
end
end)

T6:AddTextBox("Hi", function(e)
Player.PlayerGui.Aim.hitmarker.Image = "rbxassetid://" .. e
end)

T6:AddTextBox("Cursor Image Config", function(e)
Player.PlayerGui.Controls.Cursor.Image = "rbxassetid://" .. e
end)

local Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 100
Circle.Visible = true
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1
Circle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
]]

T3:AddButton({
Name = "Anti-Afk",
Callback = function()
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end})

T3:AddButton({
Name = "Anti Lag",
Callback = function()
for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
end	
end})		

T1:AddToggle({
Name = "Auto Kill Zombie",
Default = false,
Callback = function(bool)
_G._UserKill = bool
	while wait() do
	if _G._UserKill == false then break end
		KillZombies("gun",_G._ZombieKillPart)
	end
end})

T5:AddToggle({
Name = "Claim all mission",
Default = false,
Callback = function(State)
_G._claimUserMission = State
	while wait() do
		if _G._claimUserMission == false then break end
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",1)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",2)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",3)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",4)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",5)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",6)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",7)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",8)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",9)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",10)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",11)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",12)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",13)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",14)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",15)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",16)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",17)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",18)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",19)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",20)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",21)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",22)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",23)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",24)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",25)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",26)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",27)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",28)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("claimReward",29)
	end
end})

T5:AddToggle({
Name = "Discard all mission",
Default = false,
Callback = function(State)
_G._discardUserMission = State
	while wait() do
		if _G._discardUserMission == false then break end
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",1)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",2)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",3)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",4)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",5)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",6)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",7)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",8)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",9)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",10)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",11)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",12)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",13)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",14)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",15)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",16)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",17)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",18)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",19)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",20)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",21)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",22)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",23)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",24)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",25)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",26)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",27)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",28)
			game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("discardTask",29)
	end
end})

T7:AddToggle({
Name = "Auto Collect powerup",
Default = false,
Callback = function(State)
_G._BringShit = State
	while wait() do
	     if _G._BringShit == false then break end
	   for _,v in pairs(game:GetService("Workspace").Powerups.Powerup:GetChildren()) do
                if v.Name:FindFirstChild("grenadePart") or v.Name:FindFirstChild("godmodePart") or v.Name:FindFirstChild("molotovPart") or v.Name:FindFirstChild("speedboostPart") or v.Name:FindFirstChild("stungrenadePart") then
			game:GetService("Workspace").Powerups.Powerup[v.Name].CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
		end
	    end
	end
end})

RunService.RenderStepped:Connect(function()
local r,p = pcall(function()
if workspace:FindFirstChild(Player.Name) then
   zombieConsole:Set('You are not a zombie!\nCurrent Map: ' .. tostring(getMap()),"Zombie & Current map")
else
   zombieConsole:Set('You are a zombie!\nCurrent Map: ' .. tostring(getMap()),"Zombie & Current map")
end
end)

if not r then
if workspace:FindFirstChild(Player.Name) then
   zombieConsole:Set("You are not a zombie!\nCurrent Map: Loading Map..","Zombie & Current map")
end
end
end)
-- RayFromCamera()
-- RayFromHead()

function BodyColor()
for _,v in pairs(workspace.BossFolder:GetChildren()) do
if not v.Head:FindFirstChild("Genta") and not v.Torso:FindFirstChild("Genta") and not v["Right Arm"]:FindFirstChild("Genta") and not v["Left Arm"]:FindFirstChild("Genta") and not v["Right Leg"]:FindFirstChild("Genta") and not v["Left Leg"]:FindFirstChild("Genta") then
	virtualxray.Enemy(v["Head"])
        virtualxray.Enemy(v["Torso"])
	virtualxray.Enemy(v["Right Arm"])
	virtualxray.Enemy(v["Left Arm"])
	virtualxray.Enemy(v["Right Leg"])
	virtualxray.Enemy(v["Left Leg"])
    end
end
for _,v in pairs(workspace.enemies:GetChildren()) do
if not v.Head:FindFirstChild("Genta") and not v.Torso:FindFirstChild("Genta") and not v["Right Arm"]:FindFirstChild("Genta") and not v["Left Arm"]:FindFirstChild("Genta") and not v["Right Leg"]:FindFirstChild("Genta") and not v["Left Leg"]:FindFirstChild("Genta") then
	virtualxray.Enemy(v["Head"])
        virtualxray.Enemy(v["Torso"])
	virtualxray.Enemy(v["Right Arm"])
	virtualxray.Enemy(v["Left Arm"])
	virtualxray.Enemy(v["Right Leg"])
	virtualxray.Enemy(v["Left Leg"])
    end
end
--#
end

RunService.RenderStepped:Connect(function()
BodyColor()
end)

RunService.RenderStepped:Connect(function()
Circle.Color = Color3.fromRGB(math.floor(((math.sin(workspace.DistributedGameTime/2)/2)+0.5)*255), math.floor(((math.sin(workspace.DistributedGameTime)/2)+0.5)*255), math.floor(((math.sin(workspace.DistributedGameTime*1.5)/2)+0.5)*255))
end)
