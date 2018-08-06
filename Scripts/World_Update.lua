function World:overworld_controls()
	if (not GameController.world.dialog) and not (GameController.world.state == Constants.EnumWorldState.MENU) then
		self:movement_controls()
		
		if MyLib.key_list.confirm and GameController.player.OverMove == 'none' then
			GameController.player:Interact()
		end
	end
end

function World:movement_controls()
	if GameController.player.OverMove == 'none' and not MyLib.lock_controls then
		if MyLib.isKeyDown('rshift','lshift') then
			GameController.player.Speed = 10
		else
			GameController.player.Speed = 5
		end	
	end
	if MyLib.isKeyDown('down','s') and GameController.player.OverMove == 'none' then
		GameController.player.Facing = 1
		if CanMove(GameController.player:RelativeCharacterCoordinates(0,1)) then
			GameController.player:MoveSquare('down')
		end
	elseif MyLib.isKeyDown('right','d') and GameController.player.OverMove == 'none' then
		GameController.player.Facing = 2
		if CanMove(GameController.player:RelativeCharacterCoordinates(1,0)) then
			GameController.player:MoveSquare('right')
		end
	elseif MyLib.isKeyDown('up','w') and GameController.player.OverMove == 'none' then
		GameController.player.Facing = 3
		if CanMove(GameController.player:RelativeCharacterCoordinates(0,-1)) then
			GameController.player:MoveSquare('up')
		end
	elseif MyLib.isKeyDown('left','a') and GameController.player.OverMove == 'none' then
		GameController.player.Facing = 4
		if CanMove(GameController.player:RelativeCharacterCoordinates(-1,0)) then
			GameController.player:MoveSquare('left')
		end
	end
end

function World:overworld_events()
	if GameController.player:RelativeCharacterPosition():sub(1,1) == "E" then
		local map_no = Map.exits[GameController.player:RelativeCharacterPosition()][1]
		GameController.world.area.maps[map_no]:load_map(Map.id, GameController.player:RelativeCharacterPosition())
	end
end

function World:update_npcs(dt)
	for _, eachNPC in pairs(GameController.world.area.NPCs[Map.id]) do
		eachNPC:BehaviorCall(dt)
		eachNPC:followPath()
		eachNPC:moveCharacter(dt)
	end
end

function World:update_player(dt)
	if GameController.player.WaitTime then
		GameController.player.WaitTime = GameController.player.WaitTime - dt
		if GameController.player.WaitTime <= 0 then GameController.player.WaitTime = nil EventClass.triggerEvent() end
	else
		GameController.player:followPath()
		GameController.player:moveCharacter(dt)
	end
end
