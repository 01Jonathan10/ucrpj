GameController = {}
GameController.__index = GameController

function GameController.begin_game()
	GameController.go_to_main_menu()
end

function GameController.go_to_main_menu()
	GameController.state = Constants.EnumGameState.MENU
	GameController.menu = MainMenu.new()
	DataManager.load_files()
end
