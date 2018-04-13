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
	
	OverWorldControls()
	
	UpdatePlayer(dt)
	
	UpdateNPCs(dt)
	
	OverWorldEvents()
	
	PauseMenu(dt)
		
	DialogUpdate()
	
	Camera:UpdateCamera(dt)
	
end
