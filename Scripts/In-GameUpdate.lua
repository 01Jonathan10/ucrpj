function DialogUpdate()
	if Player.CurrentDialog then
		GMenu.locked = true
		if KeyList[2] then
			Player.CurrentDialog.count = Player.CurrentDialog.count + 1
			
			if Player.CurrentDialog.content[Player.CurrentDialog.count] == nil then
				for _, eachChar in pairs(Player.CurrentDialog.characters) do eachChar.Locked = false end
				Player.CurrentDialog = nil
				GMenu.locked = false
				EventClass.triggerEvent()
			end
			
			MyLib.KeyRefresh()
		end
	end
end

function OverWorldControls()
	PauseControls()
	if not Player.CurrentDialog and not GMenu.Active then	-- Comandos fora de diálogos
		MovementControls()
		
		if KeyList[2] and Player.OverMove == 'none' then
			Player:Interact()
		end
	end
end

function PauseControls()
	if KeyList[3] then
		if GMenu.Active then
			if GMenu.Submenu then
				GMenu.Submenu = nil
			else
				GMenu:CloseMenu()
			end
		else
			GMenu:StartMenu()
		end
	end
end

function MovementControls()
	if Player.OverMove == 'none' and not MyLib.lockControls then
		if MyLib.isKeyDown('rshift','lshift') then
			Player.Speed = 10
		else
			Player.Speed = 5
		end	
	end
	if MyLib.isKeyDown('down','s') and Player.OverMove == 'none' then
		Player.Facing = 1
		if CanMove(Player:RelativeCharacterCoordinates(0,1)) then
			Player:MoveSquare('down')
		end
	elseif MyLib.isKeyDown('right','d') and Player.OverMove == 'none' then
		Player.Facing = 2
		if CanMove(Player:RelativeCharacterCoordinates(1,0)) then
			Player:MoveSquare('right')
		end
	elseif MyLib.isKeyDown('up','w') and Player.OverMove == 'none' then
		Player.Facing = 3
		if CanMove(Player:RelativeCharacterCoordinates(0,-1)) then
			Player:MoveSquare('up')
		end
	elseif MyLib.isKeyDown('left','a') and Player.OverMove == 'none' then
		Player.Facing = 4
		if CanMove(Player:RelativeCharacterCoordinates(-1,0)) then
			Player:MoveSquare('left')
		end
	end
end

function OverWorldEvents()
	if Player:RelativeCharacterPosition():sub(1,1) == "E" then
		local MapNo = Map.Exits[Player:RelativeCharacterPosition()][1]
		loadMap(MapNo, Player:RelativeCharacterPosition())
	end
end

function UpdateNPCs(dt)
	for _, eachNPC in pairs(SceneNPCs[Map.Number]) do
		eachNPC:BehaviorCall(dt)
		eachNPC:followPath()
		eachNPC:moveCharacter(dt)
	end
end

function UpdatePlayer(dt)
	Player:followPath()
	Player:moveCharacter(dt)
end
