require ('In-GameDraw')
require ('In-GameUpdate')

function drawInGame()
	
	if OverW then
		drawScene()
		
		if Player.CurrentDialog then
			drawInteraction()
		end
		
		if GMenu then
			drawPauseMenu()
		end
	end
	
end

function inGameUpdate(dt)

	OverWorldEvents()
	
	OverWorldControls()
	
	UpdatePlayer(dt)
	
	UpdateNPCs(dt)
	
	PauseMenu(dt)
		
	DialogUpdate()
	
	Camera:UpdateCamera(dt)
	
end
