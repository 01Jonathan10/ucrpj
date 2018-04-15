math.randomseed( os.time() )

Battle 			= false
OverW 			= false

LoadedChars 	= {}
Map 			= {}
MapImgs			= {}
NewCharacter	= {}
TextData		= {}
Player 			= {}
View			= {}

loadSaveFiles()
loadDialogs()

SELECT_CUSTOM_KEYS = {
	[1] = "Hair",
	[2] = "Face",
	[3] = "CTop",
	[4] = "CBot"
}

love.graphics.setFont(Settings.font)

LoadUserData()
MenuClass.BuildMenu()
Item.LoadItems()
