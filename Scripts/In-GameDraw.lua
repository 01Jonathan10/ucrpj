function drawScene()

	love.graphics.translate( -Camera.Xcam, -Camera.Ycam )
		
	love.graphics.draw(MapImgs[Map.Number], -240, -200)

	drawCharactersInScene()
	
	love.graphics.translate( Camera.Xcam, Camera.Ycam )
end

function drawCharactersInScene()
	for j=1,Map.Ymax do
		for i=1,Map.Xmax do
			if Map.CharacterPos[j][i] then
				local character = Map.CharacterPos[j][i]
				local frame = character:GetFrame()
				love.graphics.draw(character.CharSpt[frame], 2*character.Px, 2*character.Py)
			end
		end
	end
end

function drawInteraction(Character)
	love.graphics.draw(View.DialogBox,100,850)
	
	local current = Player.CurrentDialog.content[Player.CurrentDialog.count]
	local dialogChar
	
	if not current.characterId then
		dialogChar = Player
	else
		dialogChar = GetCharacterById(current.characterId)
	end
	
	dialogChar:DrawCharacterPortrait(30, 856)
	love.graphics.printf(current.value,480,1020, 1020)
end
