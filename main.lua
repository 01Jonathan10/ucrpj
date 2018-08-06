math.randomseed(os.time())

love.filesystem.setRequirePath( 'MyLib/?.lua' )
require ('MyLib')

love.filesystem.setRequirePath( 'Scripts/?.lua' )
require ('1ove_draw')
require ('1ove_keypressed')
require ('1ove_update')

require ('Utils')
require ('Constants')

require ('Area')
require ('Camera')
require ('Character')
require ('Character_Player')
require ('DataManager')
require ('GameController')
require ('GMenu')
require ('MainMenu')
require ('QueueManager')
require ('View')
require ('World')


require ('Class_Event')
require ('Class_Item')
require ('Class_Map')
require ('Class_NPC')

require ('Functions')
require ('Setup')

function love.load(arg)		
		
	View.DialogBox = love.graphics.newImage('Graphics/Dev Files/Dialogbox.png')
	
end

function love.quit()
	if GameController.player then
		if not GameController.player.creating then
			DataManager.save(GameController.player)
		end
	end
	DataManager.save_user_data()
end

MyLib.MyLibSetup()
