require('GSubmenuScripts')

function DialogUpdate()
	if Player.CurrentDialog then						-- Dentro de diálogo
		if KeyList[2] then
			Player.CurrentDialog.count = Player.CurrentDialog.count + 1
			if Player.CurrentDialog.content[Player.CurrentDialog.count] ~= nil then
				while (Player.CurrentDialog.content[Player.CurrentDialog.count].value:sub(1,8) == "LuaCall>") do
					loadstring(Player.CurrentDialog.content[Player.CurrentDialog.count].value:sub(9))()
					Player.CurrentDialog.count = Player.CurrentDialog.count + 1
					if Player.CurrentDialog.content[Player.CurrentDialog.count] == nil then break end
				end
				if Player.CurrentDialog.content[Player.CurrentDialog.count] == nil then
					for _, eachChar in pairs(Player.CurrentDialog.characters) do eachChar.Locked = false end
					Player.CurrentDialog = nil
				end
			else
				for _, eachChar in pairs(Player.CurrentDialog.characters) do eachChar.Locked = false end
				Player.CurrentDialog = nil
			end
			MyLib.KeyRefresh()
		end
	end
end

function PauseMenu(dt)
	if GMenu then
		if GMenu.Submenu then
			GSubmenuUpdate(dt)
		else
			if KeyList[4] and GMenu.SelectMenu>3 then
				GMenu.SelectMenu=GMenu.SelectMenu - 3
			elseif KeyList[5] and GMenu.SelectMenu<4 then
				GMenu.SelectMenu=GMenu.SelectMenu + 3
			elseif KeyList[7] and GMenu.SelectMenu % 3 ~= 0 then
				GMenu.SelectMenu=GMenu.SelectMenu + 1 
			elseif KeyList[6] and GMenu.SelectMenu % 3 ~= 1 then
				GMenu.SelectMenu=GMenu.SelectMenu - 1
			elseif KeyList[2] then
				if GMenu.SelectMenu == 6 then -- Quit
					MyLib.FadeToColor(0.3,{"LuaCall>Menu = SetupMenu()", "OverW"},{nil,false},"fill",{0,0,0,255},true)
					SaveCharacter(Player)
				else
					GMenu.SubmenuSelect = 1
					GMenu.Submenu = GMenu.SelectMenu
					
					if GMenu.Submenu == 5 then
						local FullScreen, _ = love.window.getFullscreen()
						GMenu.FullScreen = FullScreen
						GMenu.MasterV = 100*love.audio.getVolume()
						GMenu.VControl = true
					end
				end
				
				-- 4 TODO
				-- 3 Friends
				-- 2 Equip
				-- 1 Inventory

			end
		end
	end
end

function OverWorldControls()
	PauseControls()
	if not Player.CurrentDialog and not GMenu then	-- Comandos fora de diálogos
		MovementControls()
		
		if KeyList[2] and Player.OverMove == 'none' then
			Player:Interact()
		end
	end
end

function PauseControls()
	if KeyList[3] then
		if GMenu then
			if GMenu.Submenu then
				GMenu.Submenu = nil
			else
				GMenu = nil
			end
		else
			GMenu = SetupGMenu()
		end
	end
end

function MovementControls()
	if Player.OverMove == 'none' then
		if love.keyboard.isDown('rshift','lshift') then
			Player.Speed = 10
		else
			Player.Speed = 5
		end	
	end
	if love.keyboard.isDown('down','s') and Player.OverMove == 'none' then
		Player.Facing = 1
		if CanMove(Player:RelativeCharacterCoordinates(0,1)) then
			Player:MoveSquare('down')
		end
	elseif love.keyboard.isDown('right','d') and Player.OverMove == 'none' then
		Player.Facing = 2
		if CanMove(Player:RelativeCharacterCoordinates(1,0)) then
			Player:MoveSquare('right')
		end
	elseif love.keyboard.isDown('up','w') and Player.OverMove == 'none' then
		Player.Facing = 3
		if CanMove(Player:RelativeCharacterCoordinates(0,-1)) then
			Player:MoveSquare('up')
		end
	elseif love.keyboard.isDown('left','a') and Player.OverMove == 'none' then
		Player.Facing = 4
		if CanMove(Player:RelativeCharacterCoordinates(-1,0)) then
			Player:MoveSquare('left')
		end
	end
end

function OverWorldEvents()
	if Player:RelativeCharacterPosition():sub(1,1) == "E" then
		local MapNo = Map.Meta.Exits[Player:RelativeCharacterPosition()][1]
		loadMap(MapNo, Player:RelativeCharacterPosition())
	end
end

function UpdateNPCs(dt)
	for _, eachNPC in pairs(SceneNPCs[Map.Number]) do
		eachNPC:BehaviorCall(dt)
		eachNPC:moveCharacter(eachNPC.OverMove, dt)
	end
end

function UpdatePlayer(dt)
	Player:moveCharacter(Player.OverMove, dt)
end