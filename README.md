local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Dxddy PRIVATE", "BloodTheme")
local Tab = Window:NewTab("AIM")
local Section = Tab:NewSection("CREDTIS TO Dxddy#6513")
Section:NewButton("Silent aim ", "Press C to enable", function()
    getgenv().ToggleKey =  (  "c"  )  -- [ Toggle On And Off | Stop asking re-tarded questions ]

getgenv().Prediction =  (  .18  )   -- [ Lower Prediction: Lower Ping | Higher Prediction: Higher Ping  ]

getgenv().FOV =  (  350  )   -- [ Increases Or Decreases FOV Radius ]

getgenv().FOV_Visible = true -- [ True or False, same for below ]

getgenv().TargetAim_Visible = true -- [ Shows The Dot Or Disables It ]

getgenv().FIXCrossHair = true -- [ Attempts to Fix the crosshair-placement when you toggle silent-aim, you will want to leave this on true ]

getgenv().DontShootMyFriends = false -- [ True or False ]

getgenv().DontShootThesePeople = {  -- [ List Of Who Not To Shoot like this. "Quotations with their name and then a comma afterwards for each line"; ]

	"Player1";
	"Player2";

};

task.wait(1) --- ysyncload

loadstring(game:HttpGet("https://raw.githubusercontent.com/Nosssa/NossLock/main/CuffGrim"))();
end)
local Tab = Window:NewTab("MISC")
local Section = Tab:NewSection("Add me if u want a customs gui")
Section:NewButton("Desync", "Press X to use wont be able to get hit", function()
    local P1000ToggleKey = "x" -- Change that to whatever keybind: "t"


--[[

	Standing still will trick the hitbox, you won't be able to get hit.


	DO NOT EDIT BEYOND THIS POINT IF YOU DON'T UNDERSTAND WHAT IS GOING ON.
	
	ORIGINAL SOURCE PUT INTO SKID FRIENDLY FORMAT TAKE WHAT YOU LIKE AND MAKE MANY MORE OBLIVITIES CLONES WITH THIS OR EVEN YOUR VERY OWN DIY OBLIVITY!
	
	AND REMEMBER TO SAY, SO LOOOOONG OBLIVITYYYYYY!!!


--]]


--// Services
checkcaller = checkcaller
newcclosure = newcclosure
hookmetamethod = hookmetamethod

local PastedSources = false
local BruhXD = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Bullshit = LocalPlayer:GetMouse()


--// Toggles
Bullshit.KeyDown:Connect(function(SayNoToOblivity)
	if SayNoToOblivity == string.lower(P1000ToggleKey) then
		pcall(function()
			if PastedSources == false then
				PastedSources = true
				print("Enabled P1000")
			elseif PastedSources == true then
				PastedSources = false
				print("Disabled P1000")
			end
		end)
	end
end)

Bullshit.KeyDown:Connect(function(SayNoToOblivity)
	if SayNoToOblivity == ("=") then
		game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) 
	end
end)


--// Desync_Source
function RandomNumberRange(a)
	return math.random(-a * 100, a * 100) / 100
end

function RandomVectorRange(a, b, c)
	return Vector3.new(RandomNumberRange(a), RandomNumberRange(b), RandomNumberRange(c))
end


local DesyncTypes = {}
BruhXD.Heartbeat:Connect(function()
	if PastedSources == true then
		DesyncTypes[1] = LocalPlayer.Character.HumanoidRootPart.CFrame
		DesyncTypes[2] = LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity

		local SpoofThis = LocalPlayer.Character.HumanoidRootPart.CFrame

		SpoofThis = SpoofThis * CFrame.new(Vector3.new(0, 0, 0))
		SpoofThis = SpoofThis * CFrame.Angles(math.rad(RandomNumberRange(180)), math.rad(RandomNumberRange(180)), math.rad(RandomNumberRange(180)))

		LocalPlayer.Character.HumanoidRootPart.CFrame = SpoofThis

		LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(1, 1, 1) * 16384

		BruhXD.RenderStepped:Wait()

		LocalPlayer.Character.HumanoidRootPart.CFrame = DesyncTypes[1]
		LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = DesyncTypes[2]
	end
end)


--// Hook_CFrame
local XDDDDDD = nil
XDDDDDD = hookmetamethod(game, "__index", newcclosure(function(self, key)
	if PastedSources == true then
		if not checkcaller() then
			if key == "CFrame" and PastedSources == true and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
				if self == LocalPlayer.Character.HumanoidRootPart then
					return DesyncTypes[1] or CFrame.new()
				elseif self == LocalPlayer.Character.Head then
					return DesyncTypes[1] and DesyncTypes[1] + Vector3.new(0, LocalPlayer.Character.HumanoidRootPart.Size / 2 + 0.5, 0) or CFrame.new()
				end
			end
		end
	end
	return XDDDDDD(self, key)
end))
end)
