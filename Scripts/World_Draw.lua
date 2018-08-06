function World:drawScene()
	love.graphics.translate( -View.camera.Xcam, -View.camera.Ycam )
		
	ViewClass.draw(Map.img, -240, -200)

	self:drawCharactersInScene()
	
	love.graphics.translate( View.camera.Xcam, View.camera.Ycam )
end

function World:drawCharactersInScene()
	for j=1,Map.Ymax do
		for i=1,Map.Xmax do
			if Map.char_grid[j][i] then
				local character = Map.char_grid[j][i]
				local frame = character:GetFrame()
				ViewClass.draw(character.CharSpt[frame], 2*character.Px, 2*character.Py)
			end
		end
	end
end

function World:drawInteraction()
	ViewClass.draw(View.DialogBox,100,850)
	
	local current = GameController.world.dialog.content[GameController.world.dialog.count]
	local dialogChar
	
	if not current.characterId then
		dialogChar = GameController.player
	else
		dialogChar = GetCharacterById(current.characterId)
	end
	
	dialogChar:DrawCharacterPortrait(30, 856)
	ViewClass.printf(current.value,480,1020, 1020)
end
