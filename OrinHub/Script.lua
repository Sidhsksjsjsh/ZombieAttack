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

local library = loadstring(game:HttpGet("https://pastebin.com/raw/Uub92rmN"))()


local Window = library:AddWindow("Orin - Cheat",
    {
        main_color = Color3.fromRGB(0, 128, 0),
        min_size = Vector2.new(373, 433),
        toggle_key = Enum.KeyCode.RightShift,
    })
    
local T1 = Window:AddTab("Farm")
local T4 = Window:AddTab("Crates")
local T2 = Window:AddTab("Tool")
local T3 = Window:AddTab("Anti-Afk")
local T5 = Window:AddTab("Misc")
local T6 = Window:AddTab("Player")
local T7 = Window:AddTab("Powerup")
local workspace = game:GetService("Workspace")
local playerpos = 0
local zombiepos = 0
local bosspos = 0
local Player = game.Players.LocalPlayer
local console = {}
local virtualxray = {}
local RunService = game:GetService("RunService")

--// Made by Blissful#4992
--// Locals:
local camera = workspace.CurrentCamera

--// Settings:
local on = true -- Use this if your making gui

local Box_Color = Color3.fromRGB(0, 255, 50)
local Box_Thickness = 1.4
local Box_Transparency = 1 -- 1 Visible, 0 Not Visible

local Tracers = true
local Tracer_Color = Color3.fromRGB(0, 255, 50)
local Tracer_Thickness = 1.4
local Tracer_Transparency = 1 -- 1 Visible, 0 Not Visible

local Autothickness = false -- Makes screen less encumbered

local Team_Check = false
local red = Color3.fromRGB(227, 52, 52)
local green = Color3.fromRGB(88, 217, 24)

local function NewLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(1, 1)
    line.Color = Box_Color
    line.Thickness = Box_Thickness
    line.Transparency = Box_Transparency
    return line
end

--// Main Function:

--workspace.ChildAdded:Connect(forZombie)

function bossCheck()
for _,v in pairs(workspace.BossFolder:GetChildren()) do
	return v.Name
end
end

function isBoss()
if workspace.BossFolder:FindFirstChild(bossCheck()) then
	return true
else
	return false
end
end

function getMap()
for _,v in pairs(workspace["map"]:GetChildren()) do
	return v.Name
end
end

function uppercase(context)
	context:upper()
end

function lowercase(context)
	context:lower()
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
if not body:FindFirstChild("Genta") then
 local esp = Instance.new("Highlight")
 esp.Name = "Genta"
 esp.FillTransparency = 0
 esp.FillColor = Color3.new(1, 0.666667, 0)
 esp.OutlineColor = Color3.new(1, 0.333333, 1)
 esp.OutlineTransparency = 0
 esp.Parent = body
end
end

virtualxray.killesp = function(body)
if body:FindFirstChild("Genta") then
	body:FindFirstChild("Genta"):Destroy()
end
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
local args = {
    [1] = {
        ["Normal"] = Vector3.new(0,0,0),
        ["Direction"] = getNearest()[partaim].Position,
        ["Name"] = getEquippedWeapon(game.Players.LocalPlayer),
        ["Hit"] = getNearest()[partaim],
        ["Origin"] = getNearest()[partaim].Position,
        ["Pos"] = getNearest()[partaim].Position
    }
}

game:GetService("ReplicatedStorage").Gun:FireServer(unpack(args))
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

local zombieConsole = T1:AddConsole({
    ["y"] = 50,
    ["source"] = "",
})

console.log = function(cont)
    zombieConsole:Set(cont)
end

console.view = function(consoleParent)
	return consoleParent:Get()
end

local PartKill = T1:AddDropdown("Select body type", function(prtaim)
_G._ZombieKillPart = prtaim
end)

PartKill:Add("HumanoidRootPart")
PartKill:Add("Head")
PartKill:Add("Torso")
PartKill:Add("Left Leg")
PartKill:Add("Right Arm")
PartKill:Add("Left Arm")
PartKill:Add("Right Leg")

console.log('You are not a zombie!\n<!===================>\nCurrent Map: ' .. tostring(getMap()))

local cratesList = T4:AddDropdown("Select body type", function(list)
_G._CratesList = list
end)

cratesList:Add("Basic #1")
cratesList:Add("Basic #2")
cratesList:Add("Basic #3")
cratesList:Add("Uncommon")
cratesList:Add("Rare")
cratesList:Add("Legendary")

T2:AddButton("Get all Knives", function()
for _,Thing in pairs(game.ReplicatedStorage.Knives:GetChildren()) do
if Thing:IsA("Tool") then
Thing.Parent = game.Players.LocalPlayer.Backpack
end
end
end)

T2:AddButton("Get all Guns", function()
for _,Thing in pairs(game.ReplicatedStorage.Guns:GetChildren()) do
if Thing:IsA("Tool") then
Thing.Parent = game.Players.LocalPlayer.Backpack
end
end
end)

T1:AddSwitch("Auto kill with teleport", function(bool)
_G.farm2 = bool

while wait() do
if _G.farm2 == false then break end
--local target = globalTarget
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, getNearest().Head.Position)
Player.Character.HumanoidRootPart.CFrame = (getNearest().HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = getNearest()[_G._ZombieKillPart].Position, ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name, ["Hit"] = getNearest()[_G._ZombieKillPart], ["Origin"] = getNearest()[_G._ZombieKillPart].Position, ["Pos"] = getNearest()[_G._ZombieKillPart].Position,})
end
end)
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
T1:AddButton("Bullet tracker [Damage only]", function()
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                local method = getnamecallmethod()
                if tostring(self) == "Gun" and tostring(method) == "FireServer" then
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
end)
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
T1:AddSwitch("kill platform", function(bool)
local plr = game:service('Players').LocalPlayer
local char = plr.Character
local root = char.HumanoidRootPart
_G.iszombie = bool
 
platform = Instance.new('Part', workspace)
platform.Size = Vector3.new(100,0,100)
platform.Anchored = true
platform.Position = Vector3.new(555,555,555)
root.CFrame = platform.CFrame * CFrame.new(0,4,0)
   
if not _G.iszombie then
   for _, a in pairs(workspace.enemies:children()) do
       for _, b in pairs(a:children()) do
           if b:IsA'Part' then
               b.Anchored = true
               b.CFrame = root.CFrame * CFrame.new(2,0,2)
           end
       end
   end
elseif _G.iszombie then
   for _, a in pairs(game:service'Players':GetPlayers()) do
       if a.Character then
           for _, b in pairs(a.Character:children()) do
               if b:IsA'Part' and a.Name ~= plr.Name then
                   b.Anchored = true
                   b.CFrame =  root.CFrame * CFrame.new(2,0,2)
               end
           end
       end
   end
end
end)




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

function BodyColor()
for _,v in pairs(workspace.BossFolder:GetChildren()) do
	virtualxray.Enemy(v["Head"])
        virtualxray.Enemy(v["Torso"])
	virtualxray.Enemy(v["Right Arm"])
	virtualxray.Enemy(v["Left Arm"])
	virtualxray.Enemy(v["Right Leg"])
	virtualxray.Enemy(v["Left Leg"])
end
for _,v in pairs(workspace.enemies:GetChildren()) do
	virtualxray.Enemy(v["Head"])
        virtualxray.Enemy(v["Torso"])
	virtualxray.Enemy(v["Right Arm"])
	virtualxray.Enemy(v["Left Arm"])
	virtualxray.Enemy(v["Right Leg"])
	virtualxray.Enemy(v["Left Leg"])
end
--#
end

--game:GetService("ReplicatedStorage")["forhackers"]:InvokeServer("hit",getEquippedWeapon(game.Players.LocalPlayer),getNearest()[partaim])

T4:AddSwitch("Auto Open Crate", function(bool)
_G._openCrates = bool
	while wait() do
		if _G._openCrates == false then break end
                   game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("unbox_box",_G._CratesList)
	end
end)

T4:AddButton("Open 1x", function()
game:GetService("ReplicatedStorage")["RemoteEventContainer"]["CommunicationF"]:InvokeServer("unbox_box",_G._CratesList)
end)

T5:AddButton("Infinite Jump", function()
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)
end)

T5:AddButton("Gravity", function()
game.Workspace.Gravity = 3
end)

T1:AddSwitch("wallbang V1 [Patched]", function(State)
getgenv().WALLBANG = State
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
  local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and getgenv().WALLBANG then
       table.insert(Args[2], workspace.map)
    end
    return OldNameCall(self, ...)
end) 
end)

T1:AddSwitch("wallbang V2 [Patched]", function(State)
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
end)		

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
]]
T6:AddTextBox("speed", function(e)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=e 
end)

T6:AddTextBox("jump", function(e)
game.Players.LocalPlayer.Character.Humanoid.JumpPower=e 
end)

T3:AddButton("Anti-Afk", function()
		local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end)

T3:AddButton("Anti-Lag", function()
	for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
end	
end)		

T1:AddSwitch("Auto Kill zombie [Gun]", function(bool)
_G._UserKill = bool
	while wait() do
	if _G._UserKill == false then break end
		KillZombies("gun",_G._ZombieKillPart)
	end
end)

T5:AddSwitch("Claim All missions", function(State)
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
end)

T5:AddSwitch("Discard All missions", function(State)
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
end)

T7:AddSwitch("Auto Collect power up", function(State)
_G._BringShit = State
	while wait() do
	     if _G._BringShit == false then break end
	   for _,v in pairs(game:GetService("Workspace").Powerups.Powerup:GetChildren()) do
                if v.Name:FindFirstChild("grenadePart") or v.Name:FindFirstChild("godmodePart") or v.Name:FindFirstChild("molotovPart") or v.Name:FindFirstChild("speedboostPart") or v.Name:FindFirstChild("stungrenadePart") then
			game:GetService("Workspace").Powerups.Powerup[v.Name].CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
		end
	    end
	end
end)

RunService.RenderStepped:Connect(function()
if workspace:FindFirstChild(Player.Name) then
   console.log('You are not a zombie!\n<!===================>\nCurrent Map: ' .. tostring(getMap()))
else
   console.log('You are a zombie!\n<!===================>\nCurrent Map: ' .. tostring(getMap()))
end
end)

RunService.RenderStepped:Connect(function()
BodyColor()
end)
