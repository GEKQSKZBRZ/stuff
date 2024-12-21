local util = {}

local ts = game:GetService("TweenService")
local runs = game:GetService("RunService")
local plrs = game:GetService("Players")
local plrGUI = plrs.LocalPlayer.PlayerGui
local custAsset = getsynasset or getcustomasset

function util:createTween(a)
	local p,t,es,ed,g = a.Part, a.Time, a.EasingStyle, a.EasingDirection, a.Goal
	local tw

	if a.Loop then
		tw = ts:Create(p, TweenInfo.new(t, Enum.EasingStyle[es], Enum.EasingDirection[ed], -1, true, 0), g)
	else
		tw = ts:Create(p, TweenInfo.new(t, Enum.EasingStyle[es], Enum.EasingDirection[ed]), g)
	end

	if a.Play then
		tw:Play()
	end
	return tw
end

function util:randSpawn()
	local spawns = {}
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("SpawnLocation") then
			table.insert(spawns, v)
		end
	end
	if spawns[1] then
		return spawns[math.random(1, #spawns)]
	end
end

function util:createAnim(id, name, par)
	local animins = Instance.new("Animation")
	animins.AnimationId = "rbxassetid://"..id
	animins.Name = name
	animins.Parent = par
	return animins
end

function util:makeFol(ta)
	local t
	for i = 1, #ta do
		t = ta[i]
		if i > 1 then 
			t = ta[1]..'/'..ta[i] 
		end
		if not isfile(t) then
			pcall(makefolder, t)
		else
			pcall(delfile, t)
		end
	end
	return t .. "/"
end 

function util:downloadAsset(name, link)
	if isfile(name) then
		pcall(delfile, name)
		repeat task.wait() until not isfile(name)
	end

	pcall(writefile, name, request({Url = link, Method = 'GET'}).Body)
	repeat task.wait() until isfile(name)
	return custAsset(name)
end

function util:CreateCharacter(iconText, iconImg, magicText, onSpawn)
	chrs = {
		["SERIOUS MODE"] = "Saitama",
		["RAMPAGE"] = "Garou",
		["MAXIMUM ENERGY OUTPUT"] = "Genos",
		["CAN YOU EVEN SEE ME?"] = "Sonic",
		["PUMPED UP"] = "Bad",
		["SCORCHING BLADE"] = "Kamikaze",
		["BERSERK"] = "Tatsumaki"
	}
	for _,v in ipairs(plrGUI:GetDescendants()) do
		if v.Name == "Crab" then
			cusIcon = v:Clone()
			cusIcon.Name = "CustomIcon"
			cusIcon.Parent = v.Parent
			cusIcon:WaitForChild("IconButton"):WaitForChild("IconLabel").Text = iconText
			cusIcon:WaitForChild("IconButton"):WaitForChild("IconImage").Image = iconImg
		end
	end

	local mous 
	mous = cusIcon.MouseEnter:Connect(function()
		cusIcon.IconOverlay.BackgroundTransparency = .9
	end)

	local mousl
	mousl = cusIcon.MouseLeave:Connect(function()
		cusIcon.IconOverlay.BackgroundTransparency = 1
	end)

	local mClick
	mClick = cusIcon.IconButton.MouseButton1Down:Connect(function(inp)
		if plrGUI.ScreenGui.MagicHealth.TextLabel.Text == magicText then
			cusIcon.IconOverlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
			cusIcon.IconOverlay.BackgroundTransparency = .7
			onSpawn()
		else 
			cusIcon.IconButton.IconLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		end 
	end)

	local mClickOver
	mClickOver = cusIcon.IconButton.MouseButton1Up:Connect(function(inp)
		cusIcon.IconOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		cusIcon.IconOverlay.BackgroundTransparency = 1
		cusIcon.IconButton.IconLabel.TextColor3 = Color3.fromRGB(255, 216, 19)
	end)
end

return util
