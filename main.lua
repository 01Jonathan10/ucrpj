love.filesystem.setRequirePath( 'MyLib/?.lua' )
require ('MyLib')

love.filesystem.setRequirePath( 'Scripts/?.lua' )
require ('settings')
require ('utils')

require ('Class_Camera')
require ('Class_Character')
require ('Class_Event')
require ('Class_Item')
require ('Class_LoadQueue')
require ('Class_Menu')
require ('Class_NPC')
require ('Class_Player')

require ('In-Game')
require ('Functions')
require ('Load')
require ('Setup')

function love.keypressed (key)
	if key == "backspace" and Menu then
		if Menu.TypingName then
			NewCharacter.Name = string.sub(NewCharacter.Name, 1, string.len(NewCharacter.Name) - 1)
		end
	end
end

function love.textinput (text)
    if Menu then
		if Menu.Submenu == 2 and Menu.TypingName then
			NewCharacter.Name = NewCharacter.Name .. text
		end
    end
end

function love.mousepressed ( X, Y, K )
	if K == 1 then
		LClicked = true
	elseif K == 2 then
		RClicked = true
	end
end

function love.update(dt)
		
	QueueManagement.LoadQueue()
		
	if Menu then Menu:menuUpdate(dt) end
		
	if OverW then
		inGameUpdate(dt)
	end
	
end

function love.draw(dt)

	setDrawSize()
	
	if Menu then Menu:drawMenu() end
	
	drawInGame()
		
	love.graphics.print('Memory actually used (in kB): ' .. math.ceil(collectgarbage('count')), 10,10)
	collectgarbage('collect')
end

function love.quit()
	if Player.SaveSlot and not Map.EventQueue then
		SaveCharacter(Player)
	end
	SaveUserData()
end

MyLib.MyLibSetup()
