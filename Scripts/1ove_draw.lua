function love.draw(dt)

	setDrawSize()
	
	if GameController.state == Constants.EnumGameState.MENU then
		GameController.menu:draw() 
	elseif GameController.state == Constants.EnumGameState.IN_GAME then
		GameController.world:draw_ingame() 
	end
	
	ViewClass.print('Memory actually used: '..math.ceil(collectgarbage('count')).." kB", 10,10)
	collectgarbage('collect')
end
