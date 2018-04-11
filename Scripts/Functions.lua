require ('Functions_Map')
require ('Functions_SaveLoad')
require ('Functions_Characters')

function BeginGame()
	MyLib.FadeToColor(0.3,{"OverW", "Menu"},{true, nil},"fill",{0,0,0,255},true)
	
	Camera = CameraClass.setup()
	
	if Player.MetaData.Number then 
		loadMap(Player.MetaData.Number) 
		Player:SetCharacterPosition(Player.MetaData .Px, Player.MetaData .Py) 
	else loadMap(1) end
	
	Camera:setForceCameraPosition(Player)
		
	Player.CurrentDialog = nil
	Battle = false
	GMenu = nil
	MyLib.KeyRefresh()
end

function loadDialogs()
	local mood = 1
	local dialog_id = 1
	local lineId = 1
	TextData.SmallTalk = {}
	while love.filesystem.exists('TextData/RandomNPCDialog/SmallTalk_'..mood..'.txt') do
		TextData.SmallTalk[mood] = {}
		TextData.SmallTalk[mood][1] = {}
		for line in love.filesystem.lines('TextData/RandomNPCDialog/SmallTalk_'..mood..'.txt') do
			if line == "--" then
				dialog_id = dialog_id + 1
				lineId = 1
				TextData.SmallTalk[mood][dialog_id] = {}
			else
				TextData.SmallTalk[mood][dialog_id][lineId] = {}
				TextData.SmallTalk[mood][dialog_id][lineId].isPlayer = (line:sub(1,1) == '1')
				TextData.SmallTalk[mood][dialog_id][lineId].characterId = (line:sub(1,1))
				TextData.SmallTalk[mood][dialog_id][lineId].value = string.sub(line, 6)
				TextData.SmallTalk[mood][dialog_id][lineId+1] = nil
				lineId = lineId + 1
			end
		end
		lineId = 1
		mood = mood + 1
	end
end

function setDrawSize()
	local DrawSize = 0.5
	local XOri, YOri, SXSc, SYSc = 0, 0, 0.5, 0.5
	local FullScreen, _ = love.window.getFullscreen()

	if FullScreen then
		local SX, SY = love.graphics.getDimensions()
		SXSc = SX / 1600
		SYSc = SY / 1200
		DrawSize = math.min(SXSc, SYSc)
		if SXSc == DrawSize then
			YOri = (SY - 600) / 2
		else
			XOri = (SX - 800) / 2
		end
	end
	
	love.graphics.scale(DrawSize, DrawSize)
	love.graphics.translate(XOri, YOri)
end

function SetupGMenu()
	return {SelectMenu = 1}
end
