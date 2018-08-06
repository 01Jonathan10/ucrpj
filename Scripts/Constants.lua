Constants = {}

Constants.MAIN_MENU_OPTIONS = {'Start Game', 'Options', 'Credits', 'Leave'}

Constants.EnumGameState = {
	MENU = 1,
	IN_GAME = 2,
	BATTLE = 3,
	CUTSCENE = 4,
}
	
Constants.EnumGender = {
	FEMALE = 'F',
	MALE = 'M'
}
	
Constants.EnumMainSubmenu = {
	MAIN = 0,
	FILE_SELECT = 1,
	OPTIONS = 2,
	CREDITS = 3,
	CHARACTER_CREATION = 4,
	NAME_INPUT = 5,
}

Constants.EnumMenuState = {
	NORMAL = 0,
	ERASING_FILE = 1,
	TYPING_NAME = 2,
}

Constants.EnumWorldState = {
	ROAMING = 1,
	DIALOG = 2,
	EVENT = 3,
	MENU = 4,
}

Constants.EnumInGameSubmenu = {
	MAIN = 0,
	INVENTORY = 1,
	EQUIPMENT = 2,
	FRIENDS = 3,
	TODO = 4,
	OPTIONS = 5,
}

Constants.FONT = love.graphics.newFont(26)
