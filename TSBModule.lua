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

function util:downloadAsset(name, link)
	if isfile(name) then
		pcall(delfile, name)
		repeat task.wait() until not isfile(name)
	end
	
	pcall(writefile, name, request({Url = link, Method = 'GET'}).Body)
	repeat task.wait() until isfile(name)
	return custAsset(name)
end


return util
