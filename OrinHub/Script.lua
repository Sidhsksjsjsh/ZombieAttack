local library = loadstring(game:HttpGet("https://pastebin.com/raw/Uub92rmN"))()


local Window = library:AddWindow("Orin - Cheat",
    {
        main_color = Color3.fromRGB(0, 128, 0),
        min_size = Vector2.new(373, 433),
        toggle_key = Enum.KeyCode.RightShift,
    })
    
local T1 = Window:AddTab("Farm")
local T2 = Window:AddTab("Tool")
local T3 = Window:AddTab("Player list")

local PlayerList = T3:AddConsole({
    ["y"] = 50,
    ["source"] = "",
})

local zombieConsole = T1:AddConsole({
    ["y"] = 50,
    ["source"] = "",
})

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
game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = target.Head.Position, ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name, ["Hit"] = target.Head, ["Origin"] = target.Head.Position, ["Pos"] = target.Head.Position,})
wait()
end
end
end)

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

T1:AddButton("Bullet tracker (Follow zombies)", function()
	local oPlBfNRNfyJz = game.Players.LocalPlayer;local ZtYjkXDgMlxc = "Head";local dAociCiEvJMB = function()local QInaUnazu = math.huge;local J8IhabzuN = nil;for iUIhaztYUbnZ,uUhsabzyuG in next, game.Workspace:GetDescendants() do if uUhsabzyuG:FindFirstChild(ZtYjkXDgMlxc) and oPlBfNRNfyJz.Character:FindFirstChild(ZtYjkXDgMlxc) and not uUhsabzyuG:FindFirstChild('Guns') and uUhsabzyuG.Parent.Name ~= "deadenemies" then local IIhzabUtd = (uUhsabzyuG:FindFirstChild(ZtYjkXDgMlxc).Position-oPlBfNRNfyJz.Character.Head.Position).magnitude;if IIhzabUtd < QInaUnazu then QInaUnazu = IIhzabUtd;J8IhabzuN = uUhsabzyuG;end;end;end;return J8IhabzuN;end;local GtsZsUbJOuJk = oPlBfNRNfyJz:GetMouse();local tZcInsImQQfX = getrawmetatable(game);local sCtxkbklLnmy = tZcInsImQQfX.__index;setreadonly(tZcInsImQQfX,false);tZcInsImQQfX.__index = newcclosure(function(hFcjBtZBXthW,tGNxqMIMabVS)if hFcjBtZBXthW == GtsZsUbJOuJk and tostring(tGNxqMIMabVS) == "Hit" then return dAociCiEvJMB():FindFirstChild(ZtYjkXDgMlxc).CFrame;end;return sCtxkbklLnmy(hFcjBtZBXthW,tGNxqMIMabVS)end)setreadonly(tZcInsImQQfX,true)
end)

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

while wait(0.5) do
for _,IndexGame in pairs(game.Players:GetPlayers()) do
PlayerList:Set(IndexGame.Name .. "\n")
end
end
