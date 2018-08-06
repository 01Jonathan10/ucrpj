MapClass = {}
MapClass.__index = MapClass
MapClass.LoadQueue = {}

function MapClass.create(id, area)
	local map = {
		id = id,
		area = area,
		img = nil,
		Xmax = 0,
		Ymax = 0,
		events = {},
		exits = {},
		char_grid = {},
	}
	
	MapClass.LoadQueue[table.getn(MapClass.LoadQueue) + 1] = map
	
	setmetatable(map,MapClass)
	return map
end

function MapClass:get_active()
	return GameController.world.area.active_map
end

function MapClass:set_active()
	GameController.world.area.active_map = self
end

function MapClass.LoadFromQueue()
	map = table.remove(MapClass.LoadQueue, 1)
	map.img = love.graphics.newImage('Graphics/Maps/Level ('..map.id..').png')
	
	if (table.getn(MapClass.LoadQueue) == 0) then
		MapClass.end_load_callback()
	end
end

function MapClass:end_load_callback()
	MyLib.FadeToColor(0.3,{},{},"fill",{0,0,0,255},false)
	GameController.world.area:done_loading()
end

function MapClass:load_map(prev_map_id, origin)

	self:set_active()
		
	self:read_lines()
	self:read_dialog()
	self:place_events()
	
	View.camera:setCameraPosition(GameController.player)
	
	local origin = self:get_origin(prev_map_id, origin)
	
	if origin then
		GameController.player:SetCharacterPosition(origin[1], origin[2])
	end
	
end

function MapClass:get_origin(prev_map_id, origin)
	local prev_map = self.area.maps[prev_map_id]
	if prev_map and origin then return {prev_map.exits[origin][3], prev_map.exits[origin][2]} else return nil end
end

function MapClass:read_lines()
	local i = 1
	local j = 1
	
	for line in love.filesystem.lines('MapData/Maps/Map ('..self.id..').txt') do
		self[i] = {}
		self.char_grid[i] = {}
		for value in line:gmatch("%w+") do 
			self[i][j] = value
			j = j + 1
		end
		i = i + 1
		
		if self.Xmax < j - 1 then
			self.Xmax = j - 1
		end
		
		j = 1
	end
	self.Ymax = i - 1
end

function MapClass:read_dialog()
	local dialogs = {["-1"] = {}}
	
	local obj_id = -1
	local line_id = 1
	
	for line in love.filesystem.lines('TextData/CheckObjects/Check_'..self.id..'.txt') do
		if line == "--" then
			obj_id = obj_id + 1
			line_id = 1
			dialogs[tostring(obj_id)] = {}
		else
			dialogs[tostring(obj_id)][line_id] = {value = line:split(">",false,1)[2]}
			dialogs[tostring(obj_id)][line_id+1] = nil
			line_id = line_id + 1
		end
	end
	
	self.check_dialogs = dialogs
	
	local char_dialogs = {}
	
	for charId, content in pairs(love.filesystem.load('TextData/CharacterDialog/Dialog_'..self.id..'.lua')()) do
		char_dialogs[charId] = {firstDialog = content.firstDialog, common = content.common}
	end
	
	self.char_dialogs = char_dialogs
end

function MapClass:place_events()

	self.exits = {}
		
	if not self.area.NPCs[self.id] then self:clear_NPCs() end
				
	local events = {}
	if love.filesystem.exists('MapData/Events/Events '..self.id..'.lua') then
		events = love.filesystem.load('MapData/Events/Events '..self.id..'.lua')()
	end
	
	for _, line in pairs(love.filesystem.load('MapData/Metadata/MapMeta ('..self.id..').lua')()) do
		
		if line[1]:sub(1,1)=='E' then
			self.exits[line[1]] = {line[2], line[3], line[4]}
		elseif line[1]:sub(1,1)=='V' then
			local index = tonumber(line[1]:sub(2))
			if not GameController.player.ClearedEvents[events[index].id] then
				self.events[line[2].."-"..line[3]] = EventClass.create(events[index])
			end
		elseif line[1] == 'Character' then
			local condition = line[3] or function() return true end
			if condition() then
				if not self.area.NPCs[self.id][line[2].Id] then
					NPC.create(line[2])
				end
			end
		elseif line[1]:sub(1,1)=='C' and self.area.NPCs[self.id].cleared then
			NPC.createRandom(line[2], line[3], line[4])
		end
	end
	
	self.area.NPCs[self.id].cleared = nil
	
	self:clear_char_pos()
	for _, character in pairs(self.area.NPCs[self.id]) do
		if character.OverMove == "none" then
			self.char_grid[character.Pygrid + 1][character.Pxgrid] = character
		else
			local coord = character:InFrontOfCoordinates()
			self.char_grid[coord.y][coord.x] = character
		end
	end
end

function MapClass:clear_char_pos()
	self.char_grid = {}
	for i=1,self.Ymax do
		self.char_grid[i] = {}
	end
end

function MapClass:clear_NPCs()
	self.area.NPCs[self.id] = {cleared = true}
end
