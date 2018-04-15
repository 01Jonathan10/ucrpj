require ('In-GameDraw')
require ('In-GameUpdate')

function drawInGame()
	
	if OverW then
		drawScene()
		
		if Player.CurrentDialog then
			drawInteraction()
		end
		
		if GMenu.Active then
			GMenu:Draw()
		end
	end
	
end

function inGameUpdate(dt)
	
	OverWorldControls()
	
	UpdatePlayer(dt)
	
	UpdateNPCs(dt)
	
	OverWorldEvents()
	
	if GMenu.Active then
		GMenu:Update(dt)
	end
		
	DialogUpdate()
	
	Camera:UpdateCamera(dt)
	
end
