require('GSubmenuDraw')

function drawScene()

	love.graphics.translate( 2*Camera.Xcam, 2*Camera.Ycam )
		
	if MapImgs[Map.Number] then
		love.graphics.draw(MapImgs[Map.Number], -240, -200)
	else
		for j=1,Map.Ymax do
			for i=1,Map.Xmax do
				if Map[j][i]== '0' then
					love.graphics.draw(FloorTl, 80*(i-1), 80*(j-1))
				elseif Map[j][i]== '1' then
					love.graphics.rectangle("fill", 80*(i-1), 80*(j-1), 80, 80 )
				end
			end
		end
	end

	drawCharactersInScene()
	
	love.graphics.translate( -2*Camera.Xcam, -2*Camera.Ycam )
end

function drawCharactersInScene()
	for j=1,Map.Ymax do
		for i=1,Map.Xmax do
			if Map.CharacterPos[j][i] then
				local character = Map.CharacterPos[j][i]
				local frame = character:GetFrame()
				love.graphics.draw(Player.CharSpt[frame], 2*character.Px, 2*character.Py)
				love.graphics.print(Map.CharacterPos[j][i], 2*character.Px, 2*character.Py)
			end
		end
	end
end

function drawPauseMenu()
	if GMenu.Submenu then
		GSubmenuDraw()
	else
		love.graphics.draw(SideMenu, 800, 0)
		love.graphics.draw(SideMenub, 800, 0)
		Xmenu =((GMenu.SelectMenu-1)%3)*206 + 980
		Ymenu =(((GMenu.SelectMenu-1)/3)-((GMenu.SelectMenu-1)/3)%1)*220 + 450
		love.graphics.draw(SideMenuS,Xmenu,Ymenu)
	end
end

function drawInteraction(Character)
	love.graphics.draw(DialogBox,100,850)
	
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
