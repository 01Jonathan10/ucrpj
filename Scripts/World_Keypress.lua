function World:dialog_keypressed()
	self:pause_controls()
	if GameController.world.state == Constants.EnumWorldState.DIALOG then
		if MyLib.key_list.confirm then
			GameController.world.dialog.count = GameController.world.dialog.count + 1
			
			if GameController.world.dialog.content[GameController.world.dialog.count] == nil then
				for _, eachChar in pairs(GameController.world.dialog.characters) do eachChar.Locked = false end
				GameController.world.dialog = nil
				GameController.world.state = Constants.EnumWorldState.ROAMING
				EventClass.triggerEvent()
			end
			
			MyLib.KeyRefresh()
		end
	end
end

function World:pause_controls()
	if MyLib.key_list.escape then
		if GameController.world.state == Constants.EnumWorldState.MENU then
			if GameController.world.menu.submenu ~= Constants.EnumInGameSubmenu.MAIN then
				GameController.world.menu.option = GameController.world.menu.submenu
				GameController.world.menu.submenu = Constants.EnumInGameSubmenu.MAIN
			else
				GameController.world.menu:close_menu()
			end
		else
			GameController.world.menu:open_menu()
		end
	end
	
	if GameController.world.state == Constants.EnumWorldState.MENU then
		GameController.world.menu:keypress()
	end
end
