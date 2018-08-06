function love.keypressed (key)
	if GameController.state == Constants.EnumGameState.MENU then 
		GameController.menu:keypress(dt)
	elseif GameController.state == Constants.EnumGameState.IN_GAME then
		GameController.world:keypress_ingame(dt)
	end
end

function love.textinput (text)
    if GameController.player and GameController.menu.submenu == Constants.EnumMainSubmenu.NAME_INPUT then
		GameController.player.name = GameController.player.name .. text
    end
end
