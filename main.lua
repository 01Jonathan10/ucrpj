love.filesystem.setRequirePath( 'MyLib/?.lua' )
require ('MyLib')

love.filesystem.setRequirePath( 'Scripts/?.lua' )
require ('settings')
require ('utils')

require ('Class_Camera')
require ('Class_Character')
require ('Class_Item')
require ('Class_NPC')
require ('Class_Player')

require ('In-Game')
require ('Functions')
require ('Load')
require ('LoadQueue')
require ('Menu')
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
		
	if Menu then
		menuUpdate(dt)
	end
		
	if OverW then
		inGameUpdate(dt)
	end
	
end

function love.draw(dt)

	setDrawSize()
	
	drawMenu()
	
	drawInGame()
		
	love.graphics.print('Memory actually used (in kB): ' .. collectgarbage('count'), 10,10)
	collectgarbage('collect')
end

function love.quit()
	if Player.SaveSlot then
		SaveCharacter(Player)
	end
	SaveUserData()
end

MyLib.MyLibSetup()
