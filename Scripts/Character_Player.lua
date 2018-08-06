Player = Utils.inheritsFrom( Character )
Player.__index = Player

function Player.create(args)
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
	}
	
	Utils.mergeTables(player,args)
			
	setmetatable(player,Player)
	
	player:loadSprites()
		
	return player
end

function Player:Interact()
	local coord = self:InFrontOfCoordinates()
	local event = EventClass.getEvent(coord) or {}
	
	if event.method == "Check" then
		event:beginEvent()
		if event.single then EventClass.lockEvent(coord) end
	elseif hasCharacter(coord) then
		local character = Map.char_grid[coord.y][coord.x]
		character.Facing = Utils.Opposite(self.Facing)
		if Map.char_dialogs[character.Id] then
			local content = nil
			if GameController.player.SeenDialogs[character.Id] then
				content = Map.char_dialogs[character.Id].common
			else
				content = Map.char_dialogs[character.Id].firstDialog
				GameController.player.SeenDialogs[character.Id] = true
			end
			self:StartDialog(content, {character})
		else
			self:StartDialogChar(character)
		end
		
	else
		self:StartChecking(self:InFrontOf())
	end
end

function Player:StartChecking(id)
	MyLib.KeyRefresh()
	self:StartDialog(Map.check_dialogs[id])
end

function Player:StartDialogChar(character)
	DialogID = math.random(1, table.getn(TextData.SmallTalk[character.Mood]))
	self:StartDialog(TextData.SmallTalk[character.Mood][DialogID], {character})
end

function Player:StartDialog(content, charList)
	local charList = charList or {}
	for _, eachChar in pairs(charList) do eachChar.Locked = true end
	
	GameController.world.dialog = {count = 1, content = content, characters = charList}
	GameController.world.state = Constants.EnumWorldState.DIALOG
	MyLib.KeyRefresh()
end

function Player:GainItem(ItemID, Ammount)
	local Ammount = Ammount or 1
	
	if self.Inventory.contents[ItemID] then
		Ammount = Ammount + self.Inventory.contents[ItemID]
	end
	
	self.Inventory.contents[ItemID] = Ammount
end

function Player:blank_character()
	return {
		gold = 0, 
		level = 1,
		name = '',
		gender = Constants.EnumGender.FEMALE,
		MetaData = {ItemsGot = {}},
		ClearedEvents = {},
		SeenDialogs = {},	
		Day = 1,
		Time = {6,0},
		creating = true,
	}
end

function Player:DoneMoving()
	local coord = {x=self.Pxgrid, y=self.Pygrid+1}
	local event = EventClass.getEvent(coord)
	if event then
		if event.method == "Walk" then 
			event:beginEvent() 
			if event.single then EventClass.lockEvent(coord) end
		end
	end
	
	Character.DoneMoving(self)
	self.TimerLimit = nil
end

function Player:Wait(timedelta)
	self.WaitTime = timedelta
end
