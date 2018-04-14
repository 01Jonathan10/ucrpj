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
		ClearedEvents = {}
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
		self:StartDialogChar(Map.CharacterPos[coord.y][coord.x])
	else
		self:StartChecking(self:InFrontOf())
	end
end

function PlayerClass:StartChecking(id)
	MyLib.KeyRefresh()
	self:StartDialog(Map.DialogsChk[id])
end

function PlayerClass:StartDialogChar(Character)
	Character.Facing = Utils.Opposite(self.Facing)
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
		xp = 0, 
		level = 1, 
		Name = '', 
		hair = 1, 
		face = 1, 
		clothesTop = 1, 
		clothesBot = 1,
		MetaData = {ItemsGot = {}}
	}
end
