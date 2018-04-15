PlayerClass = Utils.inheritsFrom( CharacterClass )
PlayerClass.__index = PlayerClass

function PlayerClass.create(Pxgrid, Pygrid, args, SaveSlot)
	local SaveSlot = SaveSlot or nil
	local args = args or {}
	
	local player = { 
		CharSpt = {}, 
		
		Px = 0, 
		Py = 0, 
		Pxgrid = 1, 
		Pygrid = 1, 
		Speed = 0, 
		Facing = 1, 
		OverMove = 'none',
		
		Inventory = {contents = {}, limit = 10},
		
		SaveSlot = SaveSlot,	
	}
	
	Utils.mergeTables(player,args)
		
	setmetatable(player,PlayerClass)
	
	player:loadSprites()
		
	return player
end

function PlayerClass:Interact()
	local coord = self:InFrontOfCoordinates()
	local event = EventClass.getEvent(coord) or {}
	
	if event.method == "Check" then
		event:beginEvent()
		if event.single then EventClass.lockEvent(coord) end
	elseif hasCharacter(coord) then
		local character = Map.CharacterPos[coord.y][coord.x]
		character.Facing = Utils.Opposite(self.Facing)
		if Map.DialogsChar[character.Id] then
			local content = nil
			if Player.SeenDialogs[character.Id] then
				content = Map.DialogsChar[character.Id].common
			else
				content = Map.DialogsChar[character.Id].firstDialog
				Player.SeenDialogs[character.Id] = true
			end
			self:StartDialog(content, {character})
		else
			self:StartDialogChar(character)
		end
		
	else
		self:StartChecking(self:InFrontOf())
	end
end

function PlayerClass:StartChecking(id)
	MyLib.KeyRefresh()
	self:StartDialog(Map.DialogsChk[id])
end

function PlayerClass:StartDialogChar(Character)
	DialogID = math.random(1, table.getn(TextData.SmallTalk[Character.Mood]))
	self:StartDialog(TextData.SmallTalk[Character.Mood][DialogID], {Character})
end

function PlayerClass:StartDialog(content, charList)
	local charList = charList or {}
	for _, eachChar in pairs(charList) do eachChar.Locked = true end
	
	self.CurrentDialog = {count = 1, content = content, characters = charList}
	MyLib.KeyRefresh()
end

function PlayerClass:GainItem(ItemID, Ammount)
	local Ammount = Ammount or 1
	
	if self.Inventory.contents[ItemID] then
		Ammount = Ammount + self.Inventory.contents[ItemID]
	end
	
	self.Inventory.contents[ItemID] = Ammount
end

function PlayerClass:BlankCharacter()
	return {
		gold = 0, 
		level = 1, 
		Name = '', 
		Hair = 1, 
		Face = 1, 
		CTop = 1, 
		CBot = 1,
		MetaData = {ItemsGot = {}},
		ClearedEvents = {},
		SeenDialogs = {},	
		Day = 1,
		Time = {6,0},
	}
end

function PlayerClass:DoneMoving()
	local coord = {x=self.Pxgrid, y=self.Pygrid+1}
	local event = EventClass.getEvent(coord)
	if event then
		if event.method == "Walk" then 
			event:beginEvent() 
			if event.single then EventClass.lockEvent(coord) end
		end
	end
	
	CharacterClass.DoneMoving(self)
	self.TimerLimit = nil
end
