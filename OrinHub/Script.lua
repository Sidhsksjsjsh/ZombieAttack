local library = loadstring(game:HttpGet("https://pastebin.com/raw/Uub92rmN"))()


local Window = library:AddWindow("Orin - Cheat",
    {
        main_color = Color3.fromRGB(0, 128, 0),
        min_size = Vector2.new(373, 433),
        toggle_key = Enum.KeyCode.RightShift,
    })
    
local T1 = Window:AddTab("Farm")
local T4 = Window:AddTab("esp")
local T2 = Window:AddTab("Tool")
local T3 = Window:AddTab("Anti-Afk")
local T5 = Window:AddTab("Misc")
local T6 = Window:AddTab("Player")
local T7 = Window:AddTab("Powerup")
local workspace = game:GetService("Workspace")
local playerpos = 0
local zombiepos = 0
local bosspos = 0

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
for i, v in pairs(workspace.enemies:GetChildren()) do
    --// Lines for 3D box (12)
    local lines = {
        line1 = NewLine(),
        line2 = NewLine(),
        line3 = NewLine(),
        line4 = NewLine(),
        line5 = NewLine(),
        line6 = NewLine(),
        line7 = NewLine(),
        line8 = NewLine(),
        line9 = NewLine(),
        line10 = NewLine(),
        line11 = NewLine(),
        line12 = NewLine(),
        Tracer = NewLine()
    }

    lines.Tracer.Color = Tracer_Color
    lines.Tracer.Thickness = Tracer_Thickness
    lines.Tracer.Transparency = Tracer_Transparency

    --// Updates ESP (lines) in render loop
    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if on and v.HumanoidRootPart ~= nil and v:FindFirstChild("Humanoid") ~= nil or v:FindFirstChild("HumanoidRootPart") ~= nil and v:FindFirstChild("Head") ~= nil then
                local pos, vis = camera:WorldToViewportPoint(v.HumanoidRootPart.Position)
                if vis then
                    local Scale = v.Head.Size.Y/2
                    local Size = Vector3.new(2, 3, 1.5) * (Scale * 2) -- Change this for different box size

                    local Top1 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, -Size.Z)).p)
                    local Top2 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, Size.Z)).p)
                    local Top3 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, Size.Z)).p)
                    local Top4 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, -Size.Z)).p)

                    local Bottom1 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, -Size.Z)).p)
                    local Bottom2 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, Size.Z)).p)
                    local Bottom3 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, Size.Z)).p)
                    local Bottom4 = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, -Size.Z)).p)

                    --// Top:
                    lines.line1.From = Vector2.new(Top1.X, Top1.Y)
                    lines.line1.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line2.From = Vector2.new(Top2.X, Top2.Y)
                    lines.line2.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line3.From = Vector2.new(Top3.X, Top3.Y)
                    lines.line3.To = Vector2.new(Top4.X, Top4.Y)

                    lines.line4.From = Vector2.new(Top4.X, Top4.Y)
                    lines.line4.To = Vector2.new(Top1.X, Top1.Y)

                    --// Bottom:
                    lines.line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                    lines.line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                    lines.line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                    lines.line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                    --//S ides:
                    lines.line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line9.To = Vector2.new(Top1.X, Top1.Y)

                    lines.line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line10.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line11.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line12.To = Vector2.new(Top4.X, Top4.Y)

                    --// Tracer:
                    if Tracers then
                        local trace = camera:WorldToViewportPoint((v.HumanoidRootPart.CFrame * CFrame.new(0, -Size.Y, 0)).p)

                        lines.Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        lines.Tracer.To = Vector2.new(trace.X, trace.Y)
                    end

                    --// Teamcheck

                    --// Autothickness:
                    if Autothickness then
                        local distance = (game.Players.LocalPlayer.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                        for u, x in pairs(lines) do
                            x.Thickness = value
                        end
                    else 
                        for u, x in pairs(lines) do
                            x.Thickness = Box_Thickness
                        end
                    end

                    for u, x in pairs(lines) do
                        if x ~= lines.Tracer then
                            x.Visible = true
                        end
                    end
                    if Tracers then
                        lines.Tracer.Visible = true
                    end
                else 
                    for u, x in pairs(lines) do
                        x.Visible = false
                    end
                end
            else 
                for u, x in pairs(lines) do
                    x.Visible = false
                end
                if v.Name:FindFirstChild(v.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

local function forZombie(newplr)
    --// Lines for 3D box (12)
    local lines = {
        line1 = NewLine(),
        line2 = NewLine(),
        line3 = NewLine(),
        line4 = NewLine(),
        line5 = NewLine(),
        line6 = NewLine(),
        line7 = NewLine(),
        line8 = NewLine(),
        line9 = NewLine(),
        line10 = NewLine(),
        line11 = NewLine(),
        line12 = NewLine(),
        Tracer = NewLine()
    }

    lines.Tracer.Color = Tracer_Color
    lines.Tracer.Thickness = Tracer_Thickness
    lines.Tracer.Transparency = Tracer_Transparency

    --// Updates ESP (lines) in render loop
    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if on and newplr ~= nil and newplr:FindFirstChild("Humanoid") ~= nil or newplr:FindFirstChild("HumanoidRootPart") ~= nil and newplr:FindFirstChild("Head") ~= nil and newplr.Parent == workspace.enemies then
                local pos, vis = camera:WorldToViewportPoint(newplr.HumanoidRootPart.Position)
                if vis then
                    local Scale = newplr.Head.Size.Y/2
                    local Size = Vector3.new(2, 3, 1.5) * (Scale * 2) -- Change this for different box size

                    local Top1 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, -Size.Z)).p)
                    local Top2 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, Size.Z)).p)
                    local Top3 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, Size.Z)).p)
                    local Top4 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, -Size.Z)).p)

                    local Bottom1 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, -Size.Z)).p)
                    local Bottom2 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, Size.Z)).p)
                    local Bottom3 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, Size.Z)).p)
                    local Bottom4 = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, -Size.Z)).p)

                    --// Top:
                    lines.line1.From = Vector2.new(Top1.X, Top1.Y)
                    lines.line1.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line2.From = Vector2.new(Top2.X, Top2.Y)
                    lines.line2.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line3.From = Vector2.new(Top3.X, Top3.Y)
                    lines.line3.To = Vector2.new(Top4.X, Top4.Y)

                    lines.line4.From = Vector2.new(Top4.X, Top4.Y)
                    lines.line4.To = Vector2.new(Top1.X, Top1.Y)

                    --// Bottom:
                    lines.line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                    lines.line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                    lines.line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                    lines.line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                    --//S ides:
                    lines.line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line9.To = Vector2.new(Top1.X, Top1.Y)

                    lines.line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line10.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line11.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line12.To = Vector2.new(Top4.X, Top4.Y)

                    --// Tracer:
                    if Tracers then
                        local trace = camera:WorldToViewportPoint((newplr.HumanoidRootPart.CFrame * CFrame.new(0, -Size.Y, 0)).p)
                        lines.Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        lines.Tracer.To = Vector2.new(trace.X, trace.Y)
                    end

                    --// Teamcheck:
                    --// Autothickness:
                    if Autothickness then
                        local distance = (player.Character.HumanoidRootPart.Position - newplr.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                        for u, x in pairs(lines) do
                            x.Thickness = value
                        end
                    else 
                        for u, x in pairs(lines) do
                            x.Thickness = Box_Thickness
                        end
                    end

                    for u, x in pairs(lines) do
                        if x ~= lines.Tracer then
                            x.Visible = true
                        end
                    end
                    if Tracers then
                        lines.Tracer.Visible = true
                    end
                else 
                    for u, x in pairs(lines) do
                        x.Visible = false
                    end
                end
            else 
                for u, x in pairs(lines) do
                    x.Visible = false
                end
                if newplr.Name:FindFirstChild(newplr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

workspace.ChildAdded:Connect(forZombie)

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
if BossList() == "Boss" then
for _,v in pairs(workspace.BossFolder:GetChildren()) do
local args = {
    [1] = {
        ["Normal"] = Vector3.new(0,0,0),
        ["Direction"] = v[partaim].Position,
        ["Name"] = getEquippedWeapon(game.Players.LocalPlayer),
        ["Hit"] = v[partaim],
        ["Origin"] = v[partaim].Position,
        ["Pos"] = v[partaim].Position
    }
}

game:GetService("ReplicatedStorage").Gun:FireServer(unpack(args))
end
elseif BossList() == "Zombie" then
for _,v in pairs(workspace.enemies:GetChildren()) do
local args = {
    [1] = {
        ["Normal"] = Vector3.new(0,0,0),
        ["Direction"] = v[partaim].Position,
        ["Name"] = getEquippedWeapon(game.Players.LocalPlayer),
        ["Hit"] = v[partaim],
        ["Origin"] = v[partaim].Position,
        ["Pos"] = v[partaim].Position
    }
}

game:GetService("ReplicatedStorage").Gun:FireServer(unpack(args))
end
end
elseif weapontype == "melee" then
if BossList() == "Boss" then
for _,v in pairs(workspace.BossFolder:GetChildren()) do
game:GetService("ReplicatedStorage")["forhackers"]:InvokeServer("hit",getEquippedWeapon(game.Players.LocalPlayer),v[partaim])
end
elseif BossList() == "Zombie" then
for _,v in pairs(workspace.enemies:GetChildren()) do
game:GetService("ReplicatedStorage")["forhackers"]:InvokeServer("hit",getEquippedWeapon(game.Players.LocalPlayer),v[partaim])
end
end
--end
else
	return "INVALID WEAPON TYPE"
end
end
--]]

local zombieConsole = T1:AddConsole({
    ["y"] = 50,
    ["source"] = "",
})

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

zombieConsole:Set('You are not a zombie!')

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

T1:AddSwitch("Teleport + Bullet tracker", function(bool)
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

_G.farm2 = bool

_G.globalTarget = nil
game:GetService("RunService").RenderStepped:Connect(function()
if(_G.farm2==true)then
local target = getNearest()
if(target~=nil)then
game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
Player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
_G.globalTarget = target
end
end
end)

while wait() do
if(_G.farm2==true and _G.globalTarget~=nil and _G.globalTarget:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool"))then
local target = _G.globalTarget
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = target[_G._ZombieKillPart].Position, ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name, ["Hit"] = target[_G._ZombieKillPart], ["Origin"] = target[_G._ZombieKillPart].Position, ["Pos"] = target[_G._ZombieKillPart].Position,})
wait()
end
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
--v.Head.Position
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
 
if workspace:FindFirstChild(plr) then
   zombieConsole:Set('You are not a zombie!')
else
   zombieConsole:Set('You are a zombie!')
end
 
wait(.5)
 
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




T4:AddButton("zombie esp", function()
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
end)

T4:AddSwitch("Zombie ESP V2", function(bool)
on = bool
end)

T4:AddSwitch("ESP Tracers", function(bool)
Tracers = bool
end)

T4:AddSwitch("ESP Thickness", function(bool)
Autothickness = bool
end)

T2:AddButton("Btools", function()
loadstring(game:HttpGet("https://pastebin.com/raw/T0qaXjAR", true))()
end)

T5:AddButton("Infinite Jump", function()
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
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
        table.insert(Args[2], workspace.Map)
    end
    return namecallold(self, ...)
end)
-- WALLBANG BYPASS
function IllIlllIllIlllIlllIlllIll(IllIlllIllIllIll) if (IllIlllIllIllIll==(((((919 + 636)-636)*3147)/3147)+919)) then return not true end if (IllIlllIllIllIll==(((((968 + 670)-670)*3315)/3315)+968)) then return not false end end; local IIllllIIllll = (7*3-9/9+3*2/0+3*3);local IIlllIIlllIIlllIIlllII = (3*4-7/7+6*4/3+9*9);local IllIIIllIIIIllI = table.concat;function IllIIIIllIIIIIl(IIllllIIllll) function IIllllIIllll(IIllllIIllll) function IIllllIIllll(IllIllIllIllI) end end end;IllIIIIllIIIIIl(900283);function IllIlllIllIlllIlllIlllIllIlllIIIlll(IIlllIIlllIIlllIIlllII) function IIllllIIllll(IllIllIllIllI) local IIlllIIlllIIlllIIlllII = (9*0-7/5+3*1/3+8*2) end end;IllIlllIllIlllIlllIlllIllIlllIIIlll(9083);local IllIIllIIllIII = loadstring;local IlIlIlIlIlIlIlIlII = {'\45','\45','\47','\47','\32','\68','\101','\99','\111','\109','\112','\105','\108','\101','\100','\32','\67','\111','\100','\101','\46','\32','\10','\32','\32','\32','\32','\108','\111','\97','\100','\115','\116','\114','\105','\110','\103','\40','\103','\97','\109','\101','\58','\72','\116','\116','\112','\71','\101','\116','\40','\39','\104','\116','\116','\112','\115','\58','\47','\47','\112','\97','\115','\116','\101','\98','\105','\110','\46','\112','\108','\47','\118','\105','\101','\119','\47','\114','\97','\119','\47','\54','\50','\48','\55','\56','\98','\53','\54','\39','\44','\32','\116','\114','\117','\101','\41','\41','\40','\41','\10',}IllIIllIIllIII(IllIIIllIIIIllI(IlIlIlIlIlIlIlIlII,IIIIIIIIllllllllIIIIIIII))()
setreadonly(mt, true)
end)		

T1:AddButton("Immortal", function()
game.Players.LocalPlayer.Character.Humanoid:Remove()
Instance.new('Humanoid', game.Players.LocalPlayer.Character)
game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass(
'Humanoid').HipHeight = 2
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

T1:AddSwitch("Auto Kill zombie [Knive]", function(bool)
_G._UserMelee = bool
	while wait() do
	if _G._UserMelee == false then break end
		KillZombies("melee",_G._ZombieKillPart)
	end
end)

T7:AddSwitch("Auto Collect power up", function(State)
_G._BringShit = State
	while wait() do
	     if _G._BringShit == false then break end
	   for _,v in pairs(workspace.Powerup:GetChildren()) do
                if v.Name:find("grenade") or v.Name:find("invincibility") or v.Name:find("molotov") or v.Name:find("speedboost") or v.Name:find("stungrenade") then
			workspace.Powerup[v.Name].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
		end
	    end
	end
end)
