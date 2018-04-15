function resetMap()
	
	Map.CharacterPos = {}
	Map.Events = {}
	
	Map.Xmax = 0
	Map.Ymax = 0
	for i=1,1000 do
		Map[i] = {}
		Map.CharacterPos[i] = {}
	end
	
	Map.Exits = {}
end

function readMapLines(MapNo)
	local i = 1
	local j = 1
	
	for line in love.filesystem.lines('MapData/Maps/Map ('..MapNo..').txt') do
		Map[i] = {}
		for value in line:gmatch("%w+") do 
			Map[i][j] = value
			j = j + 1
		end
		i = i + 1
		
		if Map.Xmax < j then
			Map.Xmax = j
		end
		
		j = 1
	end
	Map.Ymax = i - 1
	
end

function readMapDialog(MapNo)
	local DialogsChk = {}
	DialogsChk["-1"] = {}
	
	local ObjId = -1
	local lineId = 1
	
	for line in love.filesystem.lines('TextData/CheckObjects/Check_'..MapNo..'.txt') do
		if line == "--" then
			ObjId = ObjId + 1
			lineId = 1
			DialogsChk[tostring(ObjId)] = {}
		else
			DialogsChk[tostring(ObjId)][lineId] = {value = line:split(">",false,1)[2]}
			DialogsChk[tostring(ObjId)][lineId+1] = nil
			lineId = lineId + 1
		end
	end
	
	Map.DialogsChk = DialogsChk
	
	local DialogsChar = {}
	
	for charId, content in pairs(love.filesystem.load('TextData/CharacterDialog/Dialog_'..MapNo..'.lua')()) do
		DialogsChar[charId] = {firstDialog = content.firstDialog, common = content.common}
	end
	
	Map.DialogsChar = DialogsChar
end

function PlaceEventsChars(MapNo)

	Map.Exits = {}
		
	if not SceneNPCs[MapNo] then ClearNPCs(MapNo) end
				
	local MapEvents = {}
	if love.filesystem.exists('MapData/Events/Events '..MapNo..'.lua') then
		MapEvents = love.filesystem.load('MapData/Events/Events '..MapNo..'.lua')()
	end
	
	for _, line in pairs(love.filesystem.load('MapData/Metadata/MapMeta ('..MapNo..').lua')()) do
		
		if line[1]:sub(1,1)=='E' then
			Map.Exits[line[1]] = {line[2], line[3], line[4]}
		elseif line[1]:sub(1,1)=='V' then
			local index = tonumber(line[1]:sub(2))
			if not Player.ClearedEvents[MapEvents[index].id] then
				Map.Events[line[2].."-"..line[3]] = EventClass.create(MapEvents[index])
			end
		elseif line[1] == 'Character' then
			local condition = line[3] or function() return true end
			if condition() then
				if not SceneNPCs[MapNo][line[2].Id] then
					NPC.create(line[2], MapNo)
				end
			end
		elseif line[1]:sub(1,1)=='C' and SceneNPCs[MapNo].cleared then
			NPC.createRandom(line[2], line[3], line[4], MapNo)
		end
	end
	
	Map.Number = MapNo
	
	SceneNPCs[MapNo].cleared = nil
	
	ClearCharPos()
	for _, character in pairs(SceneNPCs[MapNo]) do
		if character.OverMove == "none" then
			Map.CharacterPos[character.Pygrid + 1][character.Pxgrid] = character
		else
			local coord = character:InFrontOfCoordinates()
			Map.CharacterPos[coord.y][coord.x] = character
		end
	end
end

function ClearCharPos()
	Map.CharacterPos = {}
	for i=1,Map.Ymax do
		Map.CharacterPos[i] = {}
	end
end

function loadMap(MapNo, Origin)
	
	local MapExit = GetOrigin(Origin)
	
	resetMap()
	
	readMapLines(MapNo)
	readMapDialog(MapNo)
	Camera:setCameraPosition(Player)
	PlaceEventsChars(MapNo)
	
	if not MapImgs[Map.Number] then MapImgs[Map.Number] = love.graphics.newImage('Graphics/Maps/Level ('..MapNo..').png') end

	Player:SetCharacterPosition(MapExit[1], MapExit[2])
end

function GetOrigin(Origin)
	if Origin == nil then
		return {5,5}
	else
		return {Map.Exits[Origin][3], Map.Exits[Origin][2]}
	end
end
