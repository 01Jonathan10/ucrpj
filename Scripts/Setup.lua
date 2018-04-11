math.randomseed( os.time() )

Battle 			= false
OverW 			= false

LoadedChars 	= {}
Map 			= {}
MapImgs			= {}
NewCharacter	= {}
CharCBot		= {}
CharCTop		= {}
CharFace		= {}
CharHair		= {}
TextData		= {}
Player 			= {}

loadSaveFiles()
loadDialogs()

SELECT_CUSTOM_KEYS = {
	[1] = "hair",
	[2] = "face",
	[3] = "clothesTop",
	[4] = "clothesBot"
}

love.graphics.setFont(Settings.font)

LoadUserData()
Menu = SetupMenu()
Item.LoadItems()
