TextData		= {}
View			= {}

loadDialogs()

love.graphics.setFont(Constants.FONT)

DataManager.load_user_data()
Item.LoadItems()
GameController.begin_game()
