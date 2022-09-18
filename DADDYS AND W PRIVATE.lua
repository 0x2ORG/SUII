local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("daddy og W", "Midnight")
local Tab = Window:NewTab("Da hood")
local Section = Tab:NewSection("lock")
Section:NewButton("dot lock", "enable c ", function()
    local settings = {
    main = {
        DotEnabled = true, -- leave this true thusky pooh ;)
        Prediction = 0.11621,
        Part = "LowerTorso",
        Key = "c",
        Notifications = true,
        AirshotFunc = false
    },
    Dot = {
        Show = true,
        Color = Color3.fromRGB(128, 0, 128),
        Size = Vector3.new(0.9, 1.2, 0.9)
    }
}






local CurrentCamera = game:GetService "Workspace".CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Plr = game.Players.LocalPlayer

local Part = Instance.new("Part", game.Workspace)
Part.Anchored = true
Part.CanCollide = false
Part.Parent = game.Workspace
Part.Shape = Enum.PartType.Ball
Part.Size = settings.Dot.Size
Part.Color = settings.Dot.Color

if settings.Dot.Show == true then
    Part.Transparency = 0
else
    Part.Transparency = 1
end

Mouse.KeyDown:Connect(function(KeyPressed)
    if KeyPressed == (settings.main.Key) then
        if settings.main.DotEnabled == true then
            settings.main.DotEnabled = false
            if settings.main.Notifications == true then
                Plr = FindClosestUser()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Private Script",
                    Text = "No longer locked on"
                })
            end
        else
            Plr = FindClosestUser()
            settings.main.DotEnabled = true
            if settings.main.Notifications == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Private Script",
                    Text = "Locked on to:" .. tostring(Plr.Character.Humanoid.DisplayName)
                })
            end
        end
    end
end)

function FindClosestUser()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
            v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

RunService.Stepped:connect(function()
    if settings.main.DotEnabled and Plr.Character and Plr.Character:FindFirstChild("LowerTorso") then
        Part.CFrame = CFrame.new(Plr.Character[settings.main.Part].Position +
                                     (Plr.Character.LowerTorso.Velocity * settings.main.Prediction))
    else
        Part.CFrame = CFrame.new(0, 9999, 0)

    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if settings.main.DotEnabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = Plr.Character[settings.main.Part].Position +
                      (Plr.Character[settings.main.Part].Velocity * settings.main.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)


if settings.main.AirshotFunc == true then
    if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        settings.main.Part = "RightFoot"
    else
        Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
            if new == Enum.HumanoidStateType.Freefall then
                settings.main.Part = "RightFoot"
            else
                settings.main.Part = "LowerTorso"
            end
        end)
    end
end
end)

Section:NewButton("silent aim cs", "enable q", function()
    getgenv().Silent = {
    Key = "Q",
    Prediction = 0.12984,
    Airshot = false,
    Part = "LowerTorso",
    Radius = 120
}
local Image = {
    Enabled = true,
    Url = "https://www.kindpng.com/picc/m/444-4447435_csgo-headshot-hd-png-download.png"
}
local Dot = {
    Enabled = true,
    Size = 15.5,
    Color = Color3.fromRGB(224,227,255),
Transparency = 1,
    Thickness = 2
}
local CC = game:GetService("Workspace").CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()
local Locking = false
local cc = game:GetService("Workspace").CurrentCamera
local gs = game:GetService("GuiService")
local ggi = gs.GetGuiInset
local lp = game:GetService("Players").LocalPlayer
local mouse = lp:GetMouse()

local Tracer = Drawing.new("Image")
Tracer.Data = game:HttpGet(Image.Url)
Tracer.Size = Vector2.new(45, 45)
 local Circle = Drawing.new("Circle")
    Circle.Color = Dot.Color
    Circle.Thickness = Dot.Thickness
    Circle.Radius = Dot.Size/4
    Circle.Visible = Dot.Enabled
    Circle.Filled = true
    Circle.Transparency = Dot.Transparency
function x(tx)
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "zenkai",
            Text = tx,
            Duration = 3.6
        }
    )
end

x("Loaded")

if getgenv().flashyes == true then
    x("Already Loaded")
    return
end
getgenv().flashyes = true


game:GetService("UserInputService").InputBegan:Connect(
    function(keygo, ok)
        if (not ok) then
            if (keygo.KeyCode.Name == getgenv().Silent.Key) then
                Locking = not Locking
                if Locking then
                    Plr = getClosestPlayerToCursor()
                     pcall(function()
                    x(Plr.Character.Humanoid.DisplayName)
                    end)
                elseif not Locking then
                    if Plr then
                        Plr = nil
                        x("Unlocked xd")
                    end
                end
            end
        end
    end
)
function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = getgenv().Silent.Radius

    for i, v in pairs(game.Players:GetPlayers()) do
        if
            v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
                v.Character.Humanoid.Health ~= 0 and
                v.Character:FindFirstChild("LowerTorso")
         then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

local rawmetatable = getrawmetatable(game)
local old = rawmetatable.__namecall
setreadonly(rawmetatable, false)
rawmetatable.__namecall =
    newcclosure(
    function(...)
        local args = {...}
        if Plr ~= nil and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] =
                Plr.Character[getgenv().Silent.Part].Position +
                (Plr.Character[getgenv().Silent.Part].Velocity * Silent.Prediction)
            return old(unpack(args))
        end
        return old(...)
    end
)

game:GetService("RunService").RenderStepped:connect(
    function()
        if getgenv().Silent.Airshot == true then
            
            if   Plr ~= nil and Plr.Character.Humanoid.Jump == true and
                    Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air
             then
                getgenv().Silent.Part = "RightFoot"
            else
                                           getgenv().Silent.Part = "LowerTorso"
             end
    end

        if Image.Enabled == true and Plr ~= nil  then
            local Vector, OnScreen = cc:worldToViewportPoint(Plr.Character[getgenv().Silent.Part].Position)
            Tracer.Visible = true
            Tracer.Position = Vector2.new(Vector.X, Vector.Y)
        else
            Tracer.Visible = false
        end
  
  if Dot.Enabled == true and Plr ~= nil  then
                  local Vector, OnScreen = cc:worldToViewportPoint(Plr.Character[getgenv().Silent.Part].Position)
            Circle.Visible = true
            Circle.Position = Vector2.new(Vector.X, Vector.Y)
        else
            Circle.Visible = false
        end
    end)

end)

local Section = Tab:NewSection("MISC")
Section:NewButton("ANTI LOCK", "enable M", function()
    local Toggled = false
local KeyCode = 'M'


function AA()
    local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 4.14
end

game:GetService('UserInputService').InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
        if Toggled then
            Toggled = false
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 1.85

        elseif not Toggled then
            Toggled = true

            while Toggled do
                AA()
                task.wait()
            end
        end
    end
end)
end)

Section:NewButton("ANIMATION CHANGER", "change animation", function()
    loadstring(game:HttpGet("https://gitlab.com/Tsuniox/lua-stuff/-/raw/master/R15GUI.lua"))()

end)

Section:NewButton("korblox", "makes u have korblox", function()
    local ply = game.Players.LocalPlayer
local chr = ply.Character
chr.RightLowerLeg.MeshId = "902942093"
chr.RightLowerLeg.Transparency = "1"
chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
chr.RightFoot.MeshId = "902942089"
chr.RightFoot.Transparency = "1"
end)

Section:NewButton("headless", "makes u have headless", function()
    game.Players.LocalPlayer.Character.Head.Transparency = 1
game.Players.LocalPlayer.Character.Head.Transparency = 1
for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
if (v:IsA("Decal")) then
v.Transparency = 1
end
end
end)

Section:NewButton("server crasher", "crash servern vis en er gay", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/lerkermer/lua-projects/master/SuperCustomServerCrasher'))() 
end)

Section:NewButton("godmode", "makes u fat and with godmode", function()
    local localPlayer = game:GetService('Players').LocalPlayer;
                local localCharacter = localPlayer.Character;
                localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
                local newCharacter = localPlayer.CharacterAdded:Wait();
                local spoofFolder = Instance.new('Folder');
                spoofFolder.Name = 'FULLY_LOADED_CHAR';
                spoofFolder.Parent = newCharacter;
                newCharacter:WaitForChild('RagdollConstraints'):Destroy();
                local spoofValue = Instance.new('BoolValue', newCharacter);
                spoofValue.Name = 'RagdollConstraints';
                local name = game.Players.LocalPlayer.Name
                local lol =    game.Workspace:WaitForChild(name)
                local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
                lol.Parent = game.Workspace.Players
                game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
                game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
end)


local Tab = Window:NewTab("hood custom")
local Section = Tab:NewSection("lock")
Section:NewButton("Aimlock", "enable x ", function()
    getgenv().Prediction = 0.12167
getgenv().AimPart = "HumanoidRootPart"	
getgenv().Key = "x"	
getgenv().DisableKey = "P"	
	
getgenv().FOV = true	
getgenv().ShowFOV = false	
getgenv().FOVSize = 55	
	
--// Variables (Service)	
	
local Players = game:GetService("Players")	
local RS = game:GetService("RunService")	
local WS = game:GetService("Workspace")	
local GS = game:GetService("GuiService")	
local SG = game:GetService("StarterGui")	
	
--// Variables (regular)	
	
local LP = Players.LocalPlayer	
local Mouse = LP:GetMouse()	
local Camera = WS.CurrentCamera	
local GetGuiInset = GS.GetGuiInset	
	
local AimlockState = true	
local Locked	
local Victim	
	
local SelectedKey = getgenv().Key	
local SelectedDisableKey = getgenv().DisableKey	
	
--// Notification function	
	
function Notify(tx)	
    SG:SetCore("SendNotification", {	
        Title = "daddy gokkes's Camlock",	
        Text = tx,	
Duration = 5	
    })	
end	
	
--// Check if aimlock is loaded	
	
if getgenv().Loaded == true then	
    Notify("Aimlock is already loaded!")	
    return	
end	
	
getgenv().Loaded = true	
	
--// FOV Circle	
	
local fov = Drawing.new("Circle")	
fov.Filled = false	
fov.Transparency = 1	
fov.Thickness = 1	
fov.Color = Color3.fromRGB(255, 255, 0)	
fov.NumSides = 1000	
	
--// Functions	
	
function update()	
    if getgenv().FOV == true then	
        if fov then	
fov.Radius = getgenv().FOVSize * 2	
            fov.Visible = getgenv().ShowFOV	
fov.Position = Vector2.new(Mouse.X, Mouse.Y + GetGuiInset(GS).Y)	
	
            return fov	
        end	
    end	
end	
	
function WTVP(arg)	
    return Camera:WorldToViewportPoint(arg)	
end	
	
function WTSP(arg)	
    return Camera.WorldToScreenPoint(Camera, arg)	
end	
	
function getClosest()	
    local closestPlayer	
    local shortestDistance = math.huge	
	
    for i, v in pairs(game.Players:GetPlayers()) do	
        local notKO = v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true	
        local notGrabbed = v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil	
        	
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild(getgenv().AimPart) and notKO and notGrabbed then	
            local pos = Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)	
local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude	
            	
            if (getgenv().FOV) then	
                if (fov.Radius > magnitude and magnitude < shortestDistance) then	
                    closestPlayer = v	
                    shortestDistance = magnitude	
                end	
            else	
                if (magnitude < shortestDistance) then	
                    closestPlayer = v	
                    shortestDistance = magnitude	
                end	
            end	
        end	
    end	
    return closestPlayer	
end	
	
--// Checks if key is down	
	
Mouse.KeyDown:Connect(function(k)	
    SelectedKey = SelectedKey:lower()	
    SelectedDisableKey = SelectedDisableKey:lower()	
    if k == SelectedKey then	
        if AimlockState == true then	
            Locked = not Locked	
            if Locked then	
                Victim = getClosest()	
	
                Notify("Locked onto: "..tostring(Victim.Character.Humanoid.DisplayName))	
            else	
                if Victim ~= nil then	
                    Victim = nil	
	
                    Notify("Unlocked!")	
                end	
            end	
        else	
            Notify("Aimlock is not enabled!")	
        end	
    end	
    if k == SelectedDisableKey then	
        AimlockState = not AimlockState	
    end	
end)	
	
--// Loop update FOV and loop camera lock onto target	
	
RS.RenderStepped:Connect(function()	
    update()	
    if AimlockState == true then	
        if Victim ~= nil then	
            Camera.CFrame = CFrame.new(Camera.CFrame.p, Victim.Character[getgenv().AimPart].Position + Victim.Character[getgenv().AimPart].Velocity*getgenv().Prediction)	
        end	
    end	
end)	
	while wait() do
        if getgenv().AutoPrediction == true then	
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()	
        local split = string.split(pingvalue,'(')	
local ping = tonumber(split[1])	
if ping < 225 then	
getgenv().Prediction = 1.4	
elseif ping < 215 then	
getgenv().Prediction = 1.2	
	elseif ping < 205 then
getgenv().Prediction = 1.0	
	elseif ping < 190 then
getgenv().Prediction = 0.10	
elseif ping < 180 then	
getgenv().Prediction = 0.12	
	elseif ping < 170 then
getgenv().Prediction = 0.15	
	elseif ping < 160 then
getgenv().Prediction = 0.18	
	elseif ping < 150 then
getgenv().Prediction = 0.110	
elseif ping < 140 then	
getgenv().Prediction = 0.113	
elseif ping < 130 then	
getgenv().Prediction = 0.116	
elseif ping < 120 then	
getgenv().Prediction = 0.120	
elseif ping < 110 then	
getgenv().Prediction = 0.124	
elseif ping < 105 then	
getgenv().Prediction = 0.127	
elseif ping < 90 then	
getgenv().Prediction = 0.130	
elseif ping < 80 then	
getgenv().Prediction = 0.133	
elseif ping < 70 then	
getgenv().Prediction = 0.136	
elseif ping < 60 then	
getgenv().Prediction = 0.140	
elseif ping < 50 then	
getgenv().Prediction = 0.143	
elseif ping < 40 then	
getgenv().Prediction = 0.145	
elseif ping < 30 then	
getgenv().Prediction = 0.155	
elseif ping < 20 then	
getgenv().Prediction = 0.157	
        end	
        end	
	end
end)
Section:NewButton("Dot lock", "q to enable white dot", function()
    local CC = game:GetService"Workspace".CurrentCamera
local Plr
local enabled = falseWD
local accomidationfactor = 0.129
local mouse = game.Players.LocalPlayer:GetMouse()
local placemarker = Instance.new("Part", game.Workspace)

function makemarker(Parent, Adornee, Color, Size, Size2)
    local e = Instance.new("BillboardGui", Parent)
    e.Name = "PP"
    e.Adornee = Adornee
    e.Size = UDim2.new(Size, Size2, Size, Size2)
    e.AlwaysOnTop = true
    local a = Instance.new("Frame", e)
    a.Size = UDim2.new(1, 0, 1, 0)
    a.BackgroundTransparency = 0
    a.BackgroundColor3 = Color
    local g = Instance.new("UICorner", a)
    g.CornerRadius = UDim.new(50, 50)
    return(e)
end


local data = game.Players:GetPlayers()
function noob(player)
    local character
    repeat wait() until player.Character
    local handler = makemarker(guimain, player.Character:WaitForChild("HumanoidRootPart"), Color3.fromRGB(107, 184, 255), 0.3, 3)
    handler.Name = player.Name
    player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild("HumanoidRootPart") end)


    spawn(function()
        while wait() do
            if player.Character then
                TextLabel.Text = player.Name..tostring(player:WaitForChild("leaderstats").Wanted.Value).." | "..tostring(math.floor(player.Character:WaitForChild("Humanoid").Health))
            end
        end
    end)
end

for i = 1, #data do
    if data[i] ~= game.Players.LocalPlayer then
        noob(data[i])
    end
end

game.Players.PlayerAdded:connect(function(Player)
    noob(Player)
end)

spawn(function()
    placemarker.Anchored = true
    placemarker.CanCollide = false
    placemarker.Size = Vector3.new(16, 16, 16)
    placemarker.Transparency = 1
    makemarker(placemarker, placemarker, Color3.fromRGB(255,255,255), 0.40, 0)
end)    

mouse.KeyDown:Connect(function(k)
    if k ~= "q" then return end
    if enabled then
        enabled = false
        guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        enabled = true 
        Plr = getClosestPlayerToCursor()
        guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end    
end)

function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

game:GetService"RunService".Stepped:connect(function()
    if enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
        placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
    else
        placemarker.CFrame = CFrame.new(0, 9999, 0)
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if enabled and getnamecallmethod() == "FireServer" and args[2] == "MousePos" then
        args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
        return old(unpack(args))
    end
    return old(...)
end)
end)

local Section = Tab:NewSection("andre hood cusrtom gui")
Section:NewButton("Wintertime", "press it ", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Nosssa/NossLock/main/WinterTime"))()

end)

Section:NewButton("hood custom65x", "press it", function()
    loadstring(game:HttpGet"https://raw.githubusercontent.com/GuizzyisbackV2LOL/65xLua/main/65xSourceLua")()
end)

local Tab = Window:NewTab("CREDITS")
local Section = Tab:NewSection("credits")
local Section = Tab:NewSection("made by 𝙙𝙖𝙙𝙙𝙮 𝙜𝙤𝙠𝙠𝙚#6513")
local Section = Tab:NewSection("this is a private script")
local Section = Tab:NewSection("u cant only get this from me or W")
local Section = Tab:NewSection("if u get it from another plz contact me")
local Section = Tab:NewSection("ill add more later")
local Section = Tab:NewSection("if u leak it ur a moron retard")
Section:NewKeybind("OPEN AND CLOSE UI", "KeybindInfo", Enum.KeyCode.V, function()
	Library:ToggleUI()
end)