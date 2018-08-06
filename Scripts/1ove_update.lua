function love.update(dt)
		
	QueueManager.load()
		
	if GameController.state == Constants.EnumGameState.MENU then 
		GameController.menu:update(dt)
	elseif GameController.state == Constants.EnumGameState.IN_GAME then
		GameController.world:update_ingame(dt)
	end
	
end
