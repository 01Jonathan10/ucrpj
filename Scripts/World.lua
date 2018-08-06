World = {}
World.__index = World

require ('World_Draw')
require ('World_Update')
require ('World_Keypress')

function World:begin_game()
	MyLib.FadeToColor(0.3,{"Menu", "LuaCall>GameController.world=World.create()", "LuaCall>GameController.world:begin_loading()"},{},"fill",{0,0,0,255},true)
end

function World:create()
	local world = {loading = true}
	
	setmetatable(world,World)
	
	GameController.state = Constants.EnumGameState.IN_GAME
	GameController.menu = {}
	
	return world
end

function World:begin_loading()
	View.camera = Camera.setup()
	
	MyLib.lock_controls = true
	
	if GameController.player.MetaData.id then
		Area.create(GameController.player.MetaData.area, GameController.player.MetaData.id, {GameController.player.MetaData.pos_x, GameController.player.MetaData.pos_y})
	else 
		Area.create(1, 1, {5, 5})
	end
	
	GameController.world.dialog = nil
	GameController.world.state = Constants.EnumWorldState.MENU
	GameController.world.menu = GMenu.build()
	MyLib.KeyRefresh()
end

function World:draw_ingame()
	
	if self.loading then
		
	else
		self:drawScene()
		
		if GameController.world.state == Constants.EnumWorldState.DIALOG then
			self:drawInteraction()
		end
		
		if GameController.world.state == Constants.EnumWorldState.MENU then
			GameController.world.menu:draw()
		end
	end
end

function World:update_ingame(dt)

	Map = MapClass.get_active()

	if self.loading then
	
	else
		self:overworld_controls()
		
		self:update_player(dt)
		
		self:update_npcs(dt)
		
		self:overworld_events()
		
		if GameController.world.state == Constants.EnumWorldState.MENU then
			GameController.world.menu:update(dt)
		end
					
		View.camera:UpdateCamera(dt)
	end
end

function World:keypress_ingame()

	self:dialog_keypressed(dt)

end
