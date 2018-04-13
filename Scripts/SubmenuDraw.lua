function mainMenuDraw()
	love.graphics.draw(Selecao, 560, 234 + 126*Menu.SelectMenu)
end

function FileSelectDraw()
	if Menu.SelectMenu < 4 then
		love.graphics.draw(Selecao, 120, 130 + 260*Menu.SelectMenu)
	else
		love.graphics.draw(Selecao, 1200*(Menu.SelectMenu-4), 1090)
	end

	for i=1,3 do
		if LoadedChars[i] then
			love.graphics.print(LoadedChars[i].Name, 600, 130 + 260*i)
			love.graphics.print("Level "..LoadedChars[i].level, 1000, 130 + 260*i)
			love.graphics.print("XP: "..LoadedChars[i].xp, 600, 170 + 260*i)
			love.graphics.print("Gold: "..LoadedChars[i].gold, 600, 210 + 260*i)
		end
	end
end
	
function CharacterCreateDraw()
	if Menu.Changing then
		love.graphics.setColor(126,126,126)
	end
	
	if Menu.SelectMenuCustom > 0 then
		love.graphics.draw(Selecao, 120, 180 + 160*Menu.SelectMenuCustom)
	else
		love.graphics.draw(Selecao, 700, 400)
	end
	
	love.graphics.setColor(255,255,255)
	
	NewCharacter:DrawCharacterFull(140,200)
	
	love.graphics.print(NewCharacter.Name, 800, 400)
	love.graphics.print("Level "..NewCharacter.level, 1200, 400)
	love.graphics.print("XP: "..NewCharacter.xp, 800, 440)
	love.graphics.print("Gold: "..NewCharacter.gold, 800, 480)
end

function OptionsDraw()
	if not Menu.VControl then
		love.graphics.draw(Selecao, 300, Menu.SelectMenu*150+450)
		love.graphics.setColor(126,126,126)		
	end
	love.graphics.draw(Selecao, 370+630*(Menu.MasterV/100), 380)
	love.graphics.setColor(255,255,255)
end
