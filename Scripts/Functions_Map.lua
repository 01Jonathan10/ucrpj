function resetMap(Origin)
	
	Map.CharacterPos = {}
	Map.Events = {}
	
	Map.Xmax = 0
	Map.Ymax = 0
	for i=1,1000 do
		Map[i] = {}
		Map.CharacterPos[i] = {}
		for j=1,1000 do
			Map[i][j]="None"
			Map.CharacterPos[i][j] = nil
		end
	end
	
	if Origin == nil then
		Player:SetCharacterPosition(5,5)
	else
		Player:SetCharacterPosition(Map.Meta.Exits[Origin][3], Map.Meta.Exits[Origin][2])
	end
	
	Map.Meta = {}
	
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
			DialogsChk[tostring(ObjId)][lineId] = {}
			DialogsChk[tostring(ObjId)][lineId].value = string.sub(line, 6)
			DialogsChk[tostring(ObjId)][lineId].isPlayer = true
			DialogsChk[tostring(ObjId)][lineId+1] = nil
			lineId = lineId + 1
		end
	end
	
	Map.DialogsChk = DialogsChk
end

function PlaceEventsChars(MapNo)

	local DidClear = false
		
	if not SceneNPCs[MapNo] then
		ClearNPCs(MapNo)
		DidClear = true
	end
			
	local MapMetaTable = love.filesystem.load('MapData/Metadata/MapMeta ('..MapNo..').lua')()
	local MapMeta = {Exits = {}}
	
	local MapEvents = {}
	if love.filesystem.exists('MapData/Events/Events '..MapNo..'.lua') then
		MapEvents = love.filesystem.load('MapData/Events/Events '..MapNo..'.lua')()
	end
	
	for _, line in pairs(MapMetaTable) do
		
		if line[1]:sub(1,1)=='E' then
			MapMeta.Exits[line[1]] = {line[2], line[3], line[4]}
		elseif line[1]:sub(1,1)=='V' then
			local index = tonumber(line[1]:sub(2))
			Map.Events[line[2].."-"..line[3]] = MapEvents[index]
		elseif line[1]:sub(1,1)=='C' and DidClear then
			NPC.create(line[2], line[3], line[4], MapNo)
		end
	end
	
	Map.Meta = MapMeta
	Map.Number = MapNo
	
	if not DidClear then
		for _, character in pairs(SceneNPCs[MapNo]) do
			Map.CharacterPos[character.Pygrid + 1][character.Pxgrid] = character
		end
	end
end

function loadMap(MapNo, Origin)
	
	resetMap(Origin)
	
	readMapLines(MapNo)
	readMapDialog(MapNo)
	Camera:setCameraPosition(Player)
	PlaceEventsChars(MapNo)
	
	if not MapImgs[Map.Number] then _, MapImgs[Map.Number] = pcall(love.graphics.newImage, 'Graphics/Maps/Level ('..MapNo..').png') end
	if not Utils.IsImage(MapImgs[Map.Number]) then MapImgs[Map.Number] = nil end
	
end
